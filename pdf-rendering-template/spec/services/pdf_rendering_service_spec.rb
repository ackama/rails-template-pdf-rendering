require "rails_helper"

RSpec.describe PdfRenderingService do
  subject(:pdf_rendering_service) { described_class.new(from_html: html) }

  let(:html) do
    <<~EO_HTML
      <html>
        <head>
          <title>I am title</title>
        </head>
        <body>
          <h1>This is a test document</h1>
        </body>
      </html>
    EO_HTML
  end

  describe "#render" do
    let(:pdf_file_header_bytes) { "%PDF-1.4" } # PDFs begin with this sequence of bytes

    it "adds a base tag immediately after the <head> opening tag in the given HTML" do
      pdf_rendering_service.render
      expect(pdf_rendering_service.html).to match(/<head><base href=/)
    end

    it "Saves a PDF version of the HTML file to disk" do
      pdf_rendering_service.render
      expect(pdf_rendering_service.html).to match(/<head><base href=/)
      pdf_file_path = pdf_rendering_service.pdf.file_path
      first_bytes_in_file = File.read(pdf_file_path, 8)

      expect(File.exist?(pdf_file_path)).to eq(true)
      expect(File.size(pdf_file_path)).to be > 0
      expect(first_bytes_in_file).to eq(pdf_file_header_bytes)
    end
  end
end
