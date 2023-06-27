module main

import time
import term.ui as tui

struct App {
mut:
    tui     &tui.Context = unsafe { nil }
    frames  []string       = unsafe { [$embed_file('bongo1.frame').to_string(), $embed_file('bongo2.frame').to_string()] }
    touched bool
}

fn event(e &tui.Event, mut app App) {
    match e.typ {
        .key_down {
            match e.code {
                .escape {
                    exit(0)
                }
                else {
                    app.touched = true
                }
            }
        }
        else {}
    }
}

fn frame(mut app App) {
    app.tui.clear()
    if app.touched {
        app.tui.draw_text(0, (app.tui.window_height-21)/2, app.frames[0])
        app.tui.flush()
        time.sleep(100 * time.millisecond)
        app.touched = false
    } else {
        app.tui.draw_text(0, (app.tui.window_height-21)/2, app.frames[1])
    }
    app.tui.set_cursor_position(0, 0)

    app.tui.reset()
    app.tui.flush()
}

fn main() {
    mut app := &App{}
    app.tui = tui.init(
        user_data:   app
        event_fn:    event
        frame_fn:    frame
        hide_cursor: true
    )
    app.tui.run()?
}
