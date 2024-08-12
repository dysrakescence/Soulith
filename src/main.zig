const std = @import("std");

pub fn main() !void {
    var file = try std.fs.cwd().openFile("../../example/main.soul", .{});
    defer file.close();

    var reader = file.reader();

    const stdout = std.io.getStdOut().writer();

    var buf: [256]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        try stdout.print("{s}\n", .{line});
    }
}
