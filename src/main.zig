const std = @import("std");
const glfw = @import("mach-glfw");
const gl = @import("gl");

const glfw_log = std.log.scoped(.glfw);
const gl_log = std.log.scoped(.gl);

pub fn main() !void {
    if (!glfw.init(.{})) {
        glfw_log.err("failed to initialize GLFW: {?s}", .{glfw.getErrorString()});
        return error.GLFWInitFailed;
    }
    defer glfw.terminate();

    const width: u32 = 800;
    const height: u32 = 600;

    const window = glfw.Window.create(width, height, "breakup", null, null, .{
        .context_version_major = gl.info.version_major,
        .context_version_minor = gl.info.version_minor,
        .opengl_profile = .opengl_core_profile,
        .opengl_forward_compat = true,
    }) orelse {
        glfw_log.err("failed to create GLFW window: {?s}", .{glfw.getErrorString()});
        return error.GLFWCreateWindowFailed;
    };
    defer window.destroy();

    glfw.makeContextCurrent(window);

    // Enable vsync to avoid unnecssary drawing
    glfw.swapInterval(1);

    while (!window.shouldClose()){
        glfw.pollEvents();
        window.swapBuffers();
    }
}
