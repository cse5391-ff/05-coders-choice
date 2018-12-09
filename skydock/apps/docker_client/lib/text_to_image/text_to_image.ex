defmodule DockerClient.TextToImage do

  def store_txt_as_img(text, file_path) do
    {:ok, file} = File.open "#{file_path}.txt", [:write]
    IO.binwrite file, "text 80,80 \" #{String.replace(text, "\"", "\\\"")} \"  "
    File.close file
    # res = System.cmd("sh", ["-c", "convert -size 1024x1024 xc:white -pointsize 12 -fill black -draw 'text 80,80 \" #{text} ' #{file_path}"])
    res = System.cmd("sh", ["-c", "convert -size 1024x1024 xc:white -pointsize 12 -fill black -draw @#{file_path}.txt #{file_path}"])
    IO.inspect(res)
    :ok
  end

end


