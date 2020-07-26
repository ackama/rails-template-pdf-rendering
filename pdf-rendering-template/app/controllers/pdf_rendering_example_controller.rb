class PdfRenderingExampleController < ApplicationController
  def index
  end

  ##
  # GET /pdf_rendering_example/:id
  # * Renders the HTML version
  #
  # GET /pdf_rendering_example/:id.pdf
  # * Generates the HTML version and converts it to PDF
  #
  #
  def show
    @example_num = params[:id]

    respond_to do |format|
      format.html do
        render :show
      end

      format.pdf do
        html = render_as_html(template_path: "pdf_rendering_example/show.html.erb",
                              assigments: { example_num: @example_num })
        pdf = generate_pdf_from(html: html)
        send_file(pdf.file_path, filename: pdf.download_as_filename, type: pdf.mime_type)
      end
    end
  end

  private

  def render_as_html(template_path:, assigments:)
    renderer = ApplicationController.renderer.new

    renderer.render(file: template_path, assigns: assigments)
  end

  def generate_pdf_from(html:)
    PdfRenderingService.new(from_html: html).render
  end
end
