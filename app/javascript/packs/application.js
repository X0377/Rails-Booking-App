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

// 予約フォームの料金計算用JavaScript、まだうまく動かない

document.addEventListener('DOMContentLoaded', function() {
  // 日付入力フィールドを取得
  const checkInInput = document.getElementById('check_in_date');
  const checkOutInput = document.getElementById('check_out_date');
  
  // 日付入力フィールドが存在する場合のみ実行（予約フォームページでのみ動作）
  if (checkInInput && checkOutInput) {
    // 宿泊料金を取得（ERBテンプレート内で実際の値に置き換えられる）
    const roomPrice = room.price
    
    // 宿泊日数と合計金額の表示要素
    const nightsElement = document.getElementById('nights');
    const totalPriceElement = document.getElementById('total-price');
    
    // 料金計算関数
    function calculatePrice() {
      const checkInDate = new Date(checkInInput.value);
      const checkOutDate = new Date(checkOutInput.value);
      
      // 日付が両方入力されているか確認
      if (checkInDate && checkOutDate && checkOutDate > checkInDate) {
        // 宿泊日数を計算（ミリ秒を日に変換）
        const diffTime = checkOutDate - checkInDate;
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        
        // 表示を更新
        nightsElement.textContent = diffDays;
        totalPriceElement.textContent = '¥' + (roomPrice * diffDays).toLocaleString();
      } else {
        // 無効な日付の場合
        nightsElement.textContent = '0';
        totalPriceElement.textContent = '¥0';
      }
    }
    
    // 日付入力時にイベントリスナーを追加
    checkInInput.addEventListener('change', calculatePrice);
    checkOutInput.addEventListener('change', calculatePrice);
    
    // ページ読み込み時にも実行（既に値が入力されている場合）
    calculatePrice();
  }
});