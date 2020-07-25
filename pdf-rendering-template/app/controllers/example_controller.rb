class ExampleController < ApplicationController
  ##
  # GET /example
  # * Renders the HTML version
  #
  # GET /example.pdf
  # * Renders the HTML version and converts it to PDF
  #
  def show
    respond_to do |format|
      format.html do
        render :show
      end

      format.pdf do
        pdf = build_rendered_pdf(html: render_to_string(:show, formats: [:html]))
        send_file(pdf.file_path, filename: pdf.download_as_filename, type: pdf.mime_type)
      end
    end
  end

  private

  def build_rendered_pdf(html:)
    renderer = PdfRenderingService.new(from_html: html)
    renderer.render
    renderer.pdf
  end
end

