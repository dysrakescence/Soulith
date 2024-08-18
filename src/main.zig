const std = @import("std");

const TokenType = enum { LEFT_PAREN, RIGHT_PAREN, LEFT_BRACKET, RIGHT_BRACKET, COMMA, DOT, COLON, SEMICOLON, BACKTICK, SINGLE_QUOTE, EQUAL, BACKSLASH, IDENTIFIER, STRING, INT, FLOAT, COMMENT, EOF };

const Token = struct { kind: TokenType, lexeme: [32]u8 };

pub fn main() !void {
    var file = try std.fs.cwd().openFile("../../example/main.soul", .{});
    defer file.close();

    var reader = std.io.bufferedReader(file.reader()).reader();

    const stdout = std.io.getStdOut().writer();

    var buf: [256]u8 = undefined;
    while (try reader.read(&buf, '\n')) |line| {
        for (line) |char| {
            try stdout.print("{c}", .{char});
        }
        try stdout.print("\n", .{});
    }
}

fn get_token_type(reader: std.fs.File.Reader) !Token {
    var buffer: [32]u8 = undefined;
    var char = try reader.readByte();
    while (std.ascii.isWhitespace(char))
        char = try reader.readByte();
    buffer[0] = char;
    var index = 1;
    if (std.ascii.isAlphabetic(char)) {
        char = try reader.readByte();
        while (std.ascii.isAlphanumeric(char)) : (index += 1) {
            buffer[index] = char;
            char = try reader.readByte();
        }
        return Token{ .kind = TokenType.IDENTIFIER, .lexeme = buffer };
    }
    if (std.ascii.isDigit(char)) {
        char = try reader.readByte();
        var found_period = false;
        while (std.ascii.isDigit(char) and !found_period) : (index += 1) {
            if (found_period)
                return error.UnexpectedSecondPeriod;
            found_period = char == '.';
            buffer[index] = char;
            char = try reader.readByte();
        }
        const token_type = if (found_period)
            TokenType.FLOAT
        else
            TokenType.INT;
        return Token{ .kind = token_type, .lexeme = buffer };
    }
    if (char == '#') {
        char = try reader.readByte();
        while (char != '\n' and char != '\r') : (index += 1) {
            buffer[index] = char;
            char = try reader.readByte();
        }
        return Token{ .kind = TokenType.COMMENT, .lexeme = buffer };
    }
    return Token{ .kind = TokenType.EOF, .lexeme = buffer };
}
