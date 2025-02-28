// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


document.addEventListener('turbolinks:load', function() {
  // プロフィールアイコンのクリックイベント設定
  const profileIcons = document.querySelectorAll('.profile-icon');

  profileIcons.forEach(icon => {
    icon.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();

      // 対応するドロップダウンコンテンツを取得
      const dropdownContent = this.nextElementSibling || 
      this.closest('.dropdown').querySelector('.dropdown-content');

      // 表示の切り替え
      if (dropdownContent) {
        dropdownContent.style.display =
          dropdownContent.style.display === 'block' ? 'none' : 'block';
      }
    });
  });

  // ドキュメント上の他の場所をクリックしたらドロップダウンを閉じる
  document.addEventListener('click', function() {
    const dropdowns = document.querySelectorAll('.dropdown-content');
    dropdowns.forEach(dropdown => {
      dropdown.style.display = 'none';
    });
  });
});