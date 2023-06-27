module main

import time
import term.ui as tui

struct App {
mut:
    tui     &tui.Context = unsafe { nil }
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
        app.tui.draw_text(0, (app.tui.window_height-21)/2, '                               -+=.
                            .*%+:=%*
                           =@=     #%
                        ::*%.      :@=
                  .=*%%#*==.        =+###*=-.
               -*@#=:                    :-+*##*=:
            :*@*-                              .-+#%*=.       .-=+:
          :#%-                                      :=#%*-.-*%#+-+@
         +#-                                            -**=:    -@
        +#             .                                         =@
       +%.           =@@%  .                                     ##
      +%.            .+*-  @*.-#.                               :@=
     ##                    -+*+%#+@-      ::                    %%
    *%                          ::       +@@@                  *@.
    #+        :-=*%#*+=-:                 ==.                  %#
    :*#****#%#+=:  .::-=+*#%#*+-:.                              #%.
                             .:=+*###*+=-:+%.                    *%
                                     .:-+@*                       #%
                                        :@          :=+***:        %#
                                         *#+==++*##*+-::-=*####*=-:=@:')
        app.tui.flush()
        time.sleep(100 * time.millisecond)
        app.touched = false
        return
    } else {
        app.tui.draw_text(0, (app.tui.window_height-21)/2, '                               -+=.
                            .*%+:=%*
                           =@=     #%
                        ::*%.      :@=
                  .=*%%#*==.        =+###*=-.
               -*@#=:                    :-+*##*=:
     ...    :*@*-                              .-+#%*=.       .-=+:
  :*%###%#=#%-                                      :=#%*-.-*%#+-+@
 +@**++**:%%                                            -**=:    -@
:@: +@@@-  **          .                                         =@
+#  .*@@:            =@@%  .                                     ##
#*                   .+*-  @*.-#.                               :@=
##                         -+*+%#+@-      ::     -+**+=.        %%
+#                              ::       +@@@  :%#-#**+%%-     *@.
                                          ==.  @*-%++#. =@=    %#
                                              :@= @@@=   .      #%.
                                              :@= .--            *%
                                               @*                 #%
                                               :=                  %#
                                                                   :@:')
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
