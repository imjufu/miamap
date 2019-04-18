import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['members', 'member', 'memberId']


  initialize() {
    this.preSetMember()
    this.membersUrl = this.element.getAttribute('data-members-url')
  }

  findMember(e) {
    const value = e.target.value
    const that = this

    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: this.membersUrl,
      data : { 'q': value }
    })
    .done(function(members) {
      let lis = '<ul class="list-group list-group-flush">'
      members.forEach(function(member) {
        lis += '<li class="list-group-item" data-action="click->subscription#setMember" data-member-id="' + member.id + '">' + member.full_name + '</li>'
      })
      lis += '</ul>'
      that.membersTarget.innerHTML = lis
      that.showMembers()
    })
    .fail(function(resp) {
      console.error(resp)
    });
  }

  hideMembers() {
    this.membersTarget.innerHTML = ''
    this.membersTarget.hidden = true
  }

  showMembers() {
    this.membersTarget.hidden = false
  }

  preSetMember(e) {
    this.hideMembers()
    const target = this.memberIdTarget
    if (target.value != '') {
      this.memberTarget.value = target.getAttribute('data-member')
      this.memberTarget.disabled = true
    }
  }

  setMember(e) {
    const target = e.target
    this.memberTarget.value = target.textContent
    this.memberTarget.disabled = true
    this.memberIdTarget.value = target.getAttribute('data-member-id')
    this.hideMembers()
  }

  unsetMember(e) {
    this.memberIdTarget.value = ''
    this.memberTarget.value = ''
    this.memberTarget.disabled = false
  }
}
