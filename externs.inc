;~ GTK - Main loop and Events
extern gtk_init_check, gtk_main

;~ GtkWidget
extern gtk_widget_show_all, gtk_widget_show, gtk_widget_hide, gtk_widget_set_sensitive, gtk_widget_destroy
extern gtk_widget_grab_focus, gtk_widget_set_state_flags
extern gtk_widget_get_parent

;~ GtkBuilder
extern gtk_builder_new, gtk_builder_add_from_file, gtk_builder_get_object, gtk_builder_connect_signals

;~ GObject
extern g_object_unref

;~ GLib - String Utility Functions
extern g_strchug, g_strchomp, g_strdup, g_stpcpy, g_strstr_len, g_strsplit, g_strfreev, g_strdup_printf, g_signal_connect_data

;~ GLib - Threads
extern g_thread_new, g_thread_unref

;~ GLib - Memory Allocation
extern g_free, g_malloc, g_malloc0, g_realloc

;~ GLib - Memory Slices
extern g_slice_alloc0, g_slice_free1

;~ GtkDialog
extern gtk_dialog_run, gtk_message_dialog_new

;~ GtkToggleButton
extern gtk_toggle_button_get_active, gtk_toggle_button_set_active

;~ GtkLabel
extern  gtk_label_set_text, gtk_label_set_markup

;~ GtkEntry
extern gtk_entry_get_text_length, gtk_entry_get_text, gtk_entry_set_text

;~ stdlib
extern exit, inet_ntoa, inet_aton, strlen, memcpy, getaddrinfo, gethostbyname, atoi, printf
extern time, localtime, strftime

extern g_uri_escape_string 
 
extern gtk_window_set_title, gtk_image_clear

;~ GTKNotebook
extern gtk_notebook_get_current_page, g_file_test

;~ cURL
extern curl_global_init, curl_easy_init, curl_easy_cleanup, curl_easy_setopt, curl_easy_perform, curl_global_cleanup, curl_easy_getinfo

extern g_key_file_new, g_key_file_free, g_key_file_load_from_file, g_key_file_set_value, g_key_file_get_value
extern g_file_set_contents, g_key_file_to_data, g_key_file_set_int64, g_key_file_get_uint64

extern gtk_editable_set_position 
extern gtk_fixed_move, gtk_widget_reparent
extern gtk_spinner_start, gtk_spinner_stop, gtk_image_set_from_file
extern fopen, fclose, mkdir, unlink, inet_pton

; GTKTextView
extern gtk_text_view_get_buffer, gtk_text_buffer_get_text, gtk_text_buffer_get_bounds, gtk_text_buffer_insert, gtk_text_buffer_get_end_iter
extern gtk_text_buffer_create_tag, gtk_text_buffer_insert_with_tags_by_name, gtk_text_buffer_set_text

extern gtk_file_chooser_dialog_new, gtk_file_chooser_set_do_overwrite_confirmation, gtk_file_chooser_set_extra_widget
extern gtk_check_button_new_with_label, gtk_file_chooser_get_filename, gtk_file_chooser_get_extra_widget, gtk_file_chooser_get_current_name, g_file_new_for_path
extern gtk_dialog_get_widget_for_response, gtk_dialog_response

extern g_file_set_contents, gtk_text_buffer_get_modified, gtk_text_buffer_set_modified
extern gtk_css_provider_new, gdk_display_get_default, gdk_display_get_default_screen, gtk_style_context_add_provider_for_screen, gtk_css_provider_load_from_data
extern  gtk_file_chooser_set_current_name, gdk_pixbuf_new_from_data, gtk_image_set_from_pixbuf, gdk_pixbuf_new_from_xpm_data, gdk_pixbuf_get_rowstride, gdk_pixbuf_new_from_file, gtk_widget_queue_draw
extern __h_errno_location, hstrerror

