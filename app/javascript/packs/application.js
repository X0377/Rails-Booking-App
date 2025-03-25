import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks" - 異常動作のため無効化
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
// Turbolinks.start() - 異常動作のため無効化
ActiveStorage.start()

// ページ読み込み時にイベントリスナーを設定
document.addEventListener('DOMContentLoaded', function() {
  console.log('ページがロードされました');

  // プロフィールアイコンのクリックイベント
  const profileIcons = document.querySelectorAll('.profile-icon');
  profileIcons.forEach(icon => {
    icon.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();

      const dropdownContent = this.nextElementSibling ||
      this.closest('.dropdown').querySelector('.dropdown-content');

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