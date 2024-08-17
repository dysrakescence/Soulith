const std = @import("std");

const TokenType = enum { LEFT_PAREN, RIGHT_PAREN, LEFT_BRACKET, RIGHT_BRACKET, COMMA, DOT, COLON, SEMICOLON, BACKTICK, SINGLE_QUOTE, DOUBLE_QUOTE, EQUAL, BACKSLASH, HASH, IDENTIFIER, EOF };

pub fn main() !void {
    var file = try std.fs.cwd().openFile("../../example/main.soul", .{});
    defer file.close();

    var reader = file.reader();

    const stdout = std.io.getStdOut().writer();

    var buf: [256]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        for (line) |char| {
            try stdout.print("{c}", .{char});
        }
        try stdout.print("\n", .{});
    }
}
