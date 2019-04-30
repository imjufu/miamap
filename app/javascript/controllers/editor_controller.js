import { Controller } from 'stimulus'

import Quill from 'quill'
import Snow from 'quill/themes/snow'
import '../styles/editor'

export default class extends Controller {
  initialize() {
    this.initializeQuill()
  }

  initializeQuill() {
    this.quill = new Quill('.editor', {
      modules: {
        toolbar:  {
          container: [
            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
            ['bold', 'italic', 'underline', 'strike'],
            ['blockquote', 'code-block'],
            [{ 'list': 'ordered'}, { 'list': 'bullet' }],
            [{ 'indent': '-1'}, { 'indent': '+1' }],
            [{ 'color': [] }, { 'background': [] }],
            [{ 'align': [] }],
            ['clean'],
            [{ 'placeholder': ['producer', 'member'] }]
          ],
          handlers: {
            placeholder: this.placeholderHandler
          }
        }
      },
      theme: 'snow'
    })

    const textarea = $('.textarea')

    textarea.hide()
    $('.ql-editor').html(textarea.val())

    this.quill.on('text-change', function(delta, oldDelta, source) {
      textarea.val(($('.ql-editor').html()))
    })
  }

  placeholderHandler(placeholder) {
    const range = this.quill.getSelection()
    if (range) {
      this.quill.insertText(range.index, `{{${placeholder}}}`)
    }
  }
}
