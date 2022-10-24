package require Tk

# -------------------------------
# -- Prepare the demonstration --
# -------------------------------

# top buttons and info label
pack [button .b1 -text "Show/hide the font chooser"]\
     [button .b2 -text "Show the file chooser"]\
     [button .b3 -text "Change the colour scheme"]\
     [button .b4 -text "Run 'tk_bisque'" -command {tk_bisque; }]\
     [button .b5 -text "ttk::setTheme alt" -command {ttk::setTheme alt}]\
     [button .b6 -text "ttk::setTheme default" -command {ttk::setTheme default}]\
     [button .b7 -text "Deliberately unusable palette" -command {
		tk_setPalette activeBackground #ff00ff activeForeground #ff00ff \
			background #ff00ff disabledForeground #ff00ff foreground #ff00ff \
			highlightBackground #ff00ff highlightColor #ff00ff \
			insertBackground #ff00ff \
			selectBackground #ff00ff selectForeground #ff00ff \
			troughColor #ff00ff
		.b7 configure -foreground white -background blue -activebackground blue -text "Help! I can't see!" -command { tk_bisque; .b7 configure -text "DBZ FOREVER!!! !!! !!!" }
		}]\
     [button .b8 -text "ttk::setTheme classic" -command {ttk::setTheme classic}]\
     [label .l]
.b1 configure -command {tk fontchooser [lindex "show hide" [tk fontchooser configure -visible]]}
.b2 configure -command {tk_getOpenFile}
.b3 configure -command {catch {tk_setPalette [tk_chooseColor -title "Colour to give to tk_setPalette"]}}
.l configure -text "Testy test" -wraplength 300 -justify left

# the little widget previews
frame .f -borderwidth 2 -relief ridge -padx 16 -pady 16

frame .f.f1 -borderwidth 2 -relief ridge -padx 4 -pady 4
pack [button .f.f1.b -text "Button"]\
     [scale .f.f1.s -label Scale -orient horiz]\
     [label .f.f1.l -text "Scrollbar"]
pack [scrollbar .f.f1.scr -orient horiz] -fill x
pack [checkbutton .f.f1.cb -text "Checkbutton"]\
     [radiobutton .f.f1.rb -text "Radiobutton"]\
     [spinbox .f.f1.sb]\
     [entry .f.f1.en]
.f.f1.en insert 0 "Text entry"

set vv 0.61
frame .f.f2 -borderwidth 2 -relief ridge -padx 4 -pady 4
pack [ttk::button .f.f2.b -text "Button"]\
     [ttk::label .f.f2.scl -text "Scale"]\
     [ttk::scale .f.f2.s -orient horiz -variable vv]\
     [ttk::progressbar .f.f2.pb -variable vv -maximum 1.0]\
     [ttk::label .f.f2.l -text "Scrollbar"]
pack [ttk::scrollbar .f.f2.scr -orient horiz] -fill x
pack [ttk::checkbutton .f.f2.cb -text "Checkbutton"]\
     [ttk::radiobutton .f.f2.rb -text "Radiobutton"]\
     [ttk::spinbox .f.f2.sb]\
     [ttk::entry .f.f2.en]
.f.f2.en insert 0 "Text entry"

grid [label .f.l1 -text "Classic widgets"] [label .f.l2 -text "ttk widgets"]
grid .f.f1 .f.f2
pack .f


toplevel .fullttk
pack [ttk::notebook .fullttk.nb]
foreach i { button checkbutton combobox entry frame intro label
            labelframe menubutton notebook panedwindow progressbar
            radiobutton scale scrollbar separator sizegrip spinbox treeview } {
 frame .fullttk.nb.frame_$i -relief ridge -borderwidth 2 -padx 3 -pady 3
 set widget ""
 catch {set widget [ttk::$i .fullttk.nb.frame_$i.widget_$i]}
 if {$widget eq ""} {
  destroy .fullttk.nb.frame_$i
  continue
 }
 .fullttk.nb add .fullttk.nb.frame_$i -text "$i"
 destroy .fullttk.nb.frame_$i.widget_$i
 set gridlist ""
 foreach j {active disabled focus pressed selected background
            readonly alternate invalid hover !disabled} {
  frame .fullttk.nb.frame_$i.widgetstate_$j -padx 1 -pady 1 -relief sunken -borderwidth 1
  pack [label .fullttk.nb.frame_$i.widgetstate_$j.label -text "($j)"]
  pack [ttk::$i .fullttk.nb.frame_$i.widgetstate_$j.widget_$i]
  if [catch {.fullttk.nb.frame_$i.widgetstate_$j.widget_$i state $j}] {
   destroy .fullttk.nb.frame_$i.widgetstate_$j
  } else {
   lappend gridlist .fullttk.nb.frame_$i.widgetstate_$j
  }
 }
 foreach {a b c} $gridlist {
  eval grid $a $b $c
 }
}