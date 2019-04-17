import { Controller } from 'stimulus'

import Quill from 'quill'
import Snow from 'quill/themes/snow'
import '../styles/editor'

export default class extends Controller {
  initialize() {
    const textarea = $('.textarea')
    const quill = new Quill('.editor', { theme: 'snow' })

    textarea.hide()
    $('.ql-editor').html(textarea.val())

    quill.on('text-change', function(delta, oldDelta, source) {
      textarea.val(($('.ql-editor').html()))
    })
  }
}
