##
# Documentation for Rails templates:
#   https://guides.rubyonrails.org/rails_application_templates.html
#
# Rails templates make extensive use of Thor. If you can't find docs for a
# function in the guide above, search the Thor docs.
#
def main # rubocop:disable Metrics/MethodLength
  add_template_repository_to_source_path

  directory "pdf-rendering-template/app", "app"
  directory "pdf-rendering-template/bin", "bin"
  directory "pdf-rendering-template/spec", "spec"

  run "yarn add puppeteer"

  route <<~EO_ROUTES_SNIPPET
    resources :pdf_rendering_example, only: %i[index show]

  EO_ROUTES_SNIPPET

  google_chrome_install_instructions = <<~EO_CHROME_INSTALL
    ### Installing Google Chrome

    PDF rendering requires you to have Google Chrome installed both locally (for
    development) and on your deployed environments. Here are some options for
    installing chrome on server environments:

    - Ubuntu Linux (suitable for AWS EC2 deployments):
      ```bash
      $ wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
      $ sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
      $ sudo apt-get update
      $ sudo apt-get install google-chrome
      ```
    - Heroku
      - https://github.com/heroku/heroku-buildpack-google-chrome
    - macOS
      - https://www.google.com/chrome/
    - Windows
      - https://www.google.com/chrome/
  EO_CHROME_INSTALL

  append_to_file "README.md" do
    <<~EO_MESSAGE
      ## PDF Rendering

      This app renders PDFs by shelling out to Google Chrome via the Puppeteer Node
      API. See `app/services/pdf_rendering_service.rb` for details.

      ### Configuration

      The following environment variables can be set to tune PDF rendering:

      - `PDF_RENDERING_TIMEOUT_SECONDS`
        - adjust how long we should wait for Chrome to render the page. The built-in
          default is 30 seconds.
      - `PDF_RENDERING_PATH_TO_CHROME`
        - You probably only need this if you are doing Rails dev in WSL on Windows

      Environment variables can be set in your Heroku console or on the command line
      e.g.

      ```sh
      # export the env var to have it available to all commands in your shell
      $ export PDF_RENDERING_TIMEOUT_SECONDS=60 # wait one minute
      $ bundle exec rails s

      # or just set the env var for the rails server command
      $ PDF_RENDERING_TIMEOUT_SECONDS=60 bundle exec rails s
      ```

      #{google_chrome_install_instructions}
    EO_MESSAGE
  end

  puts <<~EO_BANNER
    *************************************************************************
    TODO: Install Google Chrome
    *************************************************************************

    #{google_chrome_install_instructions}
    *************************************************************************
    TODO: Delete/Edit the example controller
    *************************************************************************

    This template created an example controller which you should edit/delete to
    fit your needs. Visit

      http://localhost:3000/pdf_rendering_example/

    to view the controller output.

    *************************************************************************
    TODO: Make the required small edits suggested by PDF_TEMPLATE_TODO: items
    *************************************************************************

    Using your editor, find all occurances of PDF_TEMPLATE_TODO and make the
    suggested changes.

    *************************************************************************
  EO_BANNER
end

# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  if __FILE__.match?(%r{\Ahttps?://})
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("rails-template-pdf-rendering"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/ackama/rails-template-pdf-rendering.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{rails-template/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

main
