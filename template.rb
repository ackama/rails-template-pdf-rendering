def main # rubocop:disable Metrics/MethodLength
  add_template_repository_to_source_path

  directory "pdf-rendering-template/app", "app"
  directory "pdf-rendering-template/bin", "bin"
  directory "pdf-rendering-template/spec", "spec"

  run "yarn add puppeteer"

  route <<~EO_ROUTES_SNIPPET
    resources :pdf_rendering_example, only: %i[index show]

  EO_ROUTES_SNIPPET

  append_to_file "README.md" do
    <<~EO_MESSAGE

      ## PDF Rendering

      This app renders PDFs by shelling out to Google Chrome via the Puppeteer
      Node API. See `app/services/pdf_rendering_service.rb` for details.

    EO_MESSAGE
  end

  puts <<~EO_BANNER
    *************************************************************************
    TODO: Install Google Chrome
    *************************************************************************

    PDF rendering requires you to have Google Chrome installed both locally
    (for development) and on your deployed environments. Here are some options
    for installing chrome on server environments:

    Ubuntu Linux (suitable for AWS EC2 deployments):
    $ apt-get install google-chrome

    Heroku:
    https://github.com/heroku/heroku-buildpack-google-chrome

    *************************************************************************
    TODO: Delete/Edit the example controller
    *************************************************************************

    This template created an example controller which you should edit/delete to
    fit your needs. Visit

      http://localhost:3000/pdf_rendering_example/

    to view the controller output.

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
