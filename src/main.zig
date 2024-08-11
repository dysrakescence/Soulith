const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [32]u8 = undefined;

    try stdout.print("> ", .{});
    while (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        if (std.mem.eql(u8, user_input, "")) {
            try stdout.print("goodbye!\n", .{});
            break;
        }
        try stdout.print("{s}\n> ", .{user_input});
    }
}
