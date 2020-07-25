class PdfRenderingService
  class RenderedPdf
    attr_reader :file_path

    def initialize(file_path:)
      @file_path = file_path
    end

    def download_as_filename
      "#{Time.zone.now.strftime("%Y-%m-%d")}-TODO_YOUR_FILE_NAME.pdf"
    end

    def mime_type
      "application/pdf"
    end
  end
end

