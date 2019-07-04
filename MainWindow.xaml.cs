using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows;

namespace TextReplacer
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        List<string> files = new List<string>();
        private void FilesDrop(object sender, DragEventArgs e)

        {
            var dropped = ((string[])e.Data.GetData(DataFormats.FileDrop));

            var dropped_files = dropped.ToList();

            dropped_files.ForEach(f =>
            {
                files.Add(f);
                if (FileDump.Text != "")
                {
                    FileDump.Text += "\n";
                }
                FileDump.Text += f;
            });
        }

        private void ClearFiles_Click(object sender, RoutedEventArgs e)
        {
            files = new List<string>();
            FileDump.Text = "";
        }
        public static Encoding GetFileEncoding(string srcFile)
        {
            // *** Use Default of Encoding.Default (Ansi CodePage)
            Encoding enc = Encoding.Default;
            // *** Detect byte order mark if any - otherwise assume default
            byte[] buffer = new byte[5];
            FileStream file = new FileStream(srcFile, FileMode.Open);
            file.Read(buffer, 0, 5);
            file.Close();
            if (buffer[0] == 0xef && buffer[1] == 0xbb && buffer[2] == 0xbf)
                enc = Encoding.UTF8;
            else if (buffer[0] == 0xfe && buffer[1] == 0xff)
                enc = Encoding.Unicode;
            else if (buffer[0] == 0 && buffer[1] == 0 && buffer[2] == 0xfe && buffer[3] == 0xff)
                enc = Encoding.UTF32;
            else if (buffer[0] == 0x2b && buffer[1] == 0x2f && buffer[2] == 0x76)
                enc = Encoding.UTF7;
            return enc;
        }

        private void Submit_Click(object sender, RoutedEventArgs e)
        {
            if (FindText.Text == "" || ReplaceWith.Text == "" || FileDump.Text == "")
            {
                return;
            }
            files.ForEach(file =>
            {
                // Processing
                var file_path = Path.GetDirectoryName(file); // ex: C:\TextReplacer\TextReplacer
                var file_name = Path.GetFileNameWithoutExtension(file); // ex: ediLineEPS19.cls
                var file_extension = Path.GetExtension(file); // ex: .cls
                var text_to_replace = FindText.Text;
                var replacing_text = ReplaceWith.Text;

                var new_file = Path.Combine(file_path, $@"{file_name}_{DateTime.Now.Ticks}{file_extension}");

                var file_encoding = GetFileEncoding(file);
                var file_content = new StringBuilder();
                const int BufferSize = 128;
                using (var fileStream = File.OpenRead(file))
                using (var streamReader = new StreamReader(fileStream, file_encoding, true, BufferSize))
                {
                    string line;
                    while ((line = streamReader.ReadLine()) != null)
                    {
                        // Process Line
                        file_content.AppendLine(Regex.Replace(line, $@"\{text_to_replace},\b", replacing_text, RegexOptions.IgnoreCase));
                    }
                }

                using (var streamWriter = new StreamWriter(new FileStream(new_file, FileMode.Create, FileAccess.ReadWrite), file_encoding))
                {
                    streamWriter.Write(file_content.ToString());
                }

            });
        }
    }
}
