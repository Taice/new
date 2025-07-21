//! Zig program to make a new file/directory depending on the input

const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdIn().writer();
    var args = std.process.args();
    const bin = args.next().?;
    var did = false;
    while (args.next()) |new| {
        makeNew(new) catch |e| {
            std.log.err("{any}", .{e});
        };
        did = true;
    }
    if (!did) {
        try stdout.print("Usage: {s} <new entry>\n", .{bin});
    }
}

fn makeNew(new: []const u8) !void {
    // if dir path
    if (new[new.len - 1] == '/') {
        try std.fs.cwd().makePath(new);
    } else {
        // if path and file
        if (findLastSlash(new)) |idx| {
            const cwd = std.fs.cwd();
            try cwd.makePath(new[0..idx]);
            _ = try cwd.createFile(new, .{ .truncate = false });
            // no path, just file
        } else {
            _ = try std.fs.cwd().createFile(new, .{ .truncate = false });
        }
    }
}

fn findLastSlash(content: []const u8) ?usize {
    var idx = content.len - 1;
    while (idx > 0) : (idx -= 1) {
        if (content[idx] == '/') {
            return idx;
        }
    }
    return null;
}
