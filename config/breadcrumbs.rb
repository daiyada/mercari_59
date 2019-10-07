crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", users_path
  parent :root
end

crumb :userinfo do
  link "本人情報の登録", info_user_path
  parent :mypage
end

crumb :regicard do
  link "支払い方法", new_card_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", new_card_path
  parent :mypage
end

crumb :cardinfo do
  link "クレジットカード情報入力", edit_card_path
  parent :regicard
end