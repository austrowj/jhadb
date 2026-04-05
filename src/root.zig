//! By convention, root.zig is the root source file when making a package.
const std = @import("std");
const Io = std.Io;

const Command = union(enum) {
    quit: void,
    echo_unrecognized: []const u8,
};

/// Read, evaluate, print, loop
pub fn repl(reader: *Io.Reader, writer: *Io.Writer) !void {
    while (true) {
        _ = try writer.write("\n> ");
        try writer.flush();
        const line = try reader.takeDelimiter('\n') orelse unreachable;

        switch (eval(line)) {
            .quit => return,
            .echo_unrecognized => |msg| {
                try writer.writeAll("Unrecognized command: '");
                try writer.writeAll(msg);
                try writer.writeAll("'\n");
            },
        }
    }
}

fn eval(buf: []const u8) Command {
    if (std.mem.eql(u8, buf, "quit()")) {
        return Command{ .quit = {} };
    } else {
        return Command{ .echo_unrecognized = buf };
    }
}

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try std.testing.expect(add(3, 7) == 10);
}
