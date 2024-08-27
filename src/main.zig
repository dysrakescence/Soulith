const std = @import("std");

const TokenType = enum { LeftParen, RightParen, LeftBracket, RightBracket, LeftBrace, RightBrace, Comma, Dot, Colon, Semicolon, Backtick, SingleQuote, Equal, Plus, Dash, Asterisk, Slash, Backslash, Identifier, String, Int, Float, Comment, EOF };

const Token = struct { kind: TokenType, lexeme: [256]u8, length: u8 };

pub fn main() !void {
    var file = try std.fs.cwd().openFile("../../example/main.soul", .{});
    defer file.close();

    var buf = std.io.bufferedReader(file.reader());
    const reader = buf.reader();

    const stdout = std.io.getStdOut().writer();

    var token = try get_token(reader);
    while (true) {
        try stdout.print("{}:\n{s}\n", .{ token.kind, token.lexeme[0..token.length] });
        if (get_token(reader)) |tok| {
            token = tok;
        } else |_| {
            const tok = Token{ .kind = .EOF, .lexeme = undefined, .length = 0 };
            try stdout.print("\n{}\n", .{tok.kind});
            break;
        }
    }
}

fn get_token(reader: anytype) !Token {
    var buffer: [256]u8 = undefined;
    var char = try reader.readByte();
    while (std.ascii.isWhitespace(char))
        char = try reader.readByte();
    buffer[0] = char;
    var index: u8 = 1;
    switch (char) {
        'a'...'z', 'A'...'Z' => {
            char = reader.readByte() catch 0;
            while (std.ascii.isAlphanumeric(char)) : (index += 1) {
                buffer[index] = char;
                char = try reader.readByte();
            }
            return Token{ .kind = .IDENTIFIER, .lexeme = buffer, .length = index };
        },
        '0'...'9' => {
            char = reader.readByte() catch 0;
            var has_period = false;
            while (std.ascii.isDigit(char) or char == '.' and !has_period) : (index += 1) {
                const found = char == '.';
                if (has_period and found)
                    return error.UnexpectedSecondPeriod;
                has_period = found or has_period;
                buffer[index] = char;
                char = try reader.readByte();
            }
            return Token{ .kind = if (has_period) .FLOAT else .INT, .lexeme = buffer, .length = index };
        },
        '#' => {
            char = reader.readByte() catch '\n';
            while (char != '\n' and char != '\r') : (index += 1) {
                buffer[index] = char;
                char = reader.readByte() catch '\n';
            }
            return Token{ .kind = .COMMENT, .lexeme = buffer, .length = index };
        },
        '"' => {
            char = try reader.readByte();
            while (char != '"') : (index += 1) {
                buffer[index] = char;
                char = try reader.readByte();
            }
            buffer[index] = char;
            return Token{ .kind = .STRING, .lexeme = buffer, .length = index + 1 };
        },
        '=' => return Token{ .kind = .EQUAL, .lexeme = buffer, .length = 1 },
        '\'' => return Token{ .kind = .SINGLE_QUOTE, .lexeme = buffer, .length = 1 },
        else => return Token{ .kind = .EOF, .lexeme = buffer, .length = 1 },
    }
}
