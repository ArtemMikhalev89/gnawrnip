require 'capybara/session'

module Capybara
  class Session
    SAVE_SCREENSHOT_METHODS = %i[
  body html source current_url current_host current_path
  execute_script evaluate_script visit refresh go_back go_forward
  within within_element within_fieldset within_table within_frame switch_to_frame
  current_window windows open_new_window switch_to_window within_window window_opened_by
  save_page save_and_open_page save_screenshot
  save_and_open_screenshot reset_session! response_headers
  status_code current_scope
  assert_current_path assert_no_current_path has_current_path? has_no_current_path?
]


    SAVE_SCREENSHOT_METHODS.each do |method|
      alias_method "after_hook_#{method}".to_sym, method

      define_method method do |*args, &block|
        Gnawrnip.photographer.take_shot if current_url != 'about:blank'
        send("after_hook_#{method}", *args, &block)
      end
    end
  end
end
