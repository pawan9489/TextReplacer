using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TextReplacer
{
    class ViewModelValidataion : INotifyDataErrorInfo
    {
        public string FindText { get; set; } = "";
        public string ReplaceWith { get; set; } = "";
        public string FilesDropped { get; set; } = "";

        public IEnumerable GetErrors(string propertyName)
        {
            if (string.IsNullOrEmpty(propertyName) || (!HasErrors))
                return null;
            return new List<string>() { "Mandatory Fields!" };
        }
        public bool HasErrors { get; set; } = false;
        public event EventHandler<DataErrorsChangedEventArgs> ErrorsChanged;
        public bool ValidateMandatoryFields()
        {
            HasErrors = FindText == "" && ReplaceWith == "" && FilesDropped == "";
            if (HasErrors)
            {
                ErrorsChanged?.Invoke(this, new DataErrorsChangedEventArgs("FindText"));
                ErrorsChanged?.Invoke(this, new DataErrorsChangedEventArgs("ReplaceWith"));
                ErrorsChanged?.Invoke(this, new DataErrorsChangedEventArgs("FilesDropped"));
            }
            else
            {
                return true;
            }
            return false;
        }
    }
}
