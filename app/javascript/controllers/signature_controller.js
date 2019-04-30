import { Controller } from 'stimulus'

import SignaturePad from 'signature_pad'

export default class extends Controller {
  initialize() {
    this.initializePads()
    this.initializeActions()

    this.updateUrl = this.element.getAttribute('data-update-url')
  }

  initializePads() {
    this.producerCanvas = document.querySelector('#producer canvas')
    this.producerSignaturePad = new SignaturePad(this.producerCanvas)
    this.producerSignaturePad.fromDataURL(this.producerCanvas.getAttribute('data-signature'), { ratio: 1 })
    this.producerSignaturePad.off()

    this.memberCanvas = document.querySelector('#member canvas')
    this.memberSignaturePad = new SignaturePad(this.memberCanvas)
    this.memberSignaturePad.fromDataURL(this.memberCanvas.getAttribute('data-signature'), { ratio: 1 })
    this.memberSignaturePad.off()
  }

  initializeActions() {
    $('.save').hide()
    $('.cancel').hide()
  }

  editProducerSignature() {
    this.editSignature('producer')
  }

  saveProducerSignature() {
    this.saveSignature('producer')
  }

  cancelProducerSignature() {
    this.cancelSignature('producer')
  }

  editMemberSignature() {
    this.editSignature('member')
  }

  saveMemberSignature() {
    this.saveSignature('member')
  }

  cancelMemberSignature() {
    this.cancelSignature('member')
  }

  editSignature(signature) {
    const signaturePad =  this[`${signature}SignaturePad`]
    signaturePad.on()
    signaturePad.clear()
    $(`#${signature} .sign`).hide()
    $(`#${signature} .save`).show()
    $(`#${signature} .cancel`).show()
  }

  saveSignature(signature) {
    const signaturePad = this[`${signature}SignaturePad`]
    const data = { subscription: {} }
    data['subscription'][`${signature}_signature_data_uri`] = signaturePad.toDataURL('image/png')
    data['subscription'][`${signature}_accepted_at`] = new Date()

    $.ajax({
      type: 'PUT',
      headers: {
        'X-CSRF-Token': document.head.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      dataType: 'json',
      url: this.updateUrl,
      data : data
    })
    .fail(function(resp) {
      signaturePad.clear()
      console.error(resp)
    });

    signaturePad.off()
    $(`#${signature} .sign`).show()
    $(`#${signature} .save`).hide()
    $(`#${signature} .cancel`).hide()
  }

  cancelSignature(signature) {
    this.initializePads()
    $(`#${signature} .sign`).show()
    $(`#${signature} .save`).hide()
    $(`#${signature} .cancel`).hide()
  }
}
