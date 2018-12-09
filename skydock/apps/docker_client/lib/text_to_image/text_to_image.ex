defmodule DockerClient.TextToImage do
  @moduledoc """
  TextToImage is a module that converts a body of text into a JPEG image, and stores it on disk at a given file path.

  System Dependencies:
  - convert
  - ImageMagick plugin for convert
  """

  def store_txt_as_img(text, file_path) do
    write_text_file(text, file_path)
    System.cmd("sh", ["-c", "convert -size 1024x1024 xc:white -pointsize 12 -fill black -draw @#{file_path}.txt #{file_path}"])
  end

  def write_text_file(text, file_path) do
    {:ok, file} = File.open "#{file_path}.txt", [:write]
    IO.binwrite file, "text 80,80 \" #{String.replace(text, "\"", "\\\"")} \"  "
    File.close file
  end

end


