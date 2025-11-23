ble-face -s argument_error            'fg=red,underline'
ble-face -s auto_complete             'fg=gray'
ble-face -s cmdinfo_cd_cdpath         'fg=navy,bg=yellow'
ble-face -s command_directory         'fg=blue,underline'
ble-face -s command_function          'fg=magenta'
ble-face -s disabled                  'fg=silver'
ble-face -s filename_directory        'fg=blue,underline'
ble-face -s filename_directory_sticky 'fg=white,bg=blue,underline'
ble-face -s filename_orphan           'fg=cyan,bg=brown,underline'
ble-face -s filename_setgid           'fg=black,bg=lime,underline'
ble-face -s filename_setuid           'fg=black,bg=yellow,underline'
ble-face -s menu_filter_input         'fg=black,bg=yellow'
ble-face -s overwrite_mode            'fg=black,bg=cyan'
ble-face -s prompt_status_line        'fg=white,bg=gray'
ble-face -s region                    'fg=white,bg=navy'
ble-face -s region_insert             'fg=blue,bg=silver'
ble-face -s region_match              'fg=white,bg=navy'
ble-face -s region_target             'fg=black,bg=cyan'
ble-face -s syntax_brace              'fg=teal,bold'
ble-face -s syntax_comment            'fg=silver'
ble-face -s syntax_document           'fg=olive'
ble-face -s syntax_document_begin     'fg=olive,bold'
ble-face -s syntax_error              'fg=black,bg=red'
ble-face -s syntax_expr               'fg=blue'
ble-face -s syntax_function_name      'fg=magenta,bold'
ble-face -s syntax_glob               'fg=magenta,bold'
ble-face -s syntax_history_expansion  'fg=white,bg=brown'
ble-face -s syntax_param_expansion    'fg=magenta'
ble-face -s syntax_tilde              'fg=blue,bold'
ble-face -s syntax_varname            'fg=olive'
ble-face -s varname_array             'fg=olive,bold'
ble-face -s varname_empty             'fg=teal'
ble-face -s varname_export            'fg=megenta,bold'
ble-face -s varname_expr              'fg=blue,bold'
ble-face -s varname_hash              'fg=green,bold'
ble-face -s varname_new               'fg=green'
ble-face -s varname_number            'fg=olive'
ble-face -s varname_readonly          'fg=magenta'
ble-face -s varname_transform         'fg=teal,bold'
ble-face -s varname_unset             'fg=silver'
ble-face -s vbell_erase               'bg=silver'

ble-bind -f 'C-e' edit-and-execute-command

bleopt keymap_vi_mode_show:=

ble-bind -m vi_cmap --cursor 0
ble-bind -m vi_imap --cursor 5
ble-bind -m vi_nmap --cursor 2
ble-bind -m vi_omap --cursor 4
ble-bind -m vi_smap --cursor 2
ble-bind -m vi_xmap --cursor 2
