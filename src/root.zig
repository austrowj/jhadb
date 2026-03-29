//! By convention, root.zig is the root source file when making a package.
const std = @import("std");
const Io = std.Io;

/// Read, evaluate, print, loop
pub fn repl(reader: *Io.Reader, writer: *Io.Writer) !void {
    while (true) {
        _ = try writer.write("\n> ");
        try writer.flush();
        const line = try reader.takeDelimiter('\n') orelse unreachable;
        const result = eval(line);
        try writer.writeAll(result);
    }
}

fn eval(buf: []const u8) []const u8 {
    return buf;
}

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try std.testing.expect(add(3, 7) == 10);
}
