require 'open-uri'
require 'json'

class HomeController < ApplicationController
  def index
  end
  
  def jack
    lotto_hash = JSON.parse(open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read)

    lotto_array = []
    lotto_bnus = 0
    result = 0
    my_lotto_array = (1..45).to_a.sample(6).sort
    
    lotto_hash.each do |k,v|
       lotto_array << v if k.include? "drwtNo"
       lotto_bnus = v if k.include? "bnusNo"
    end
    
    lotto_match = my_lotto_array & lotto_array.sort!
    lotto_match << lotto_bnus if my_lotto_array.include? lotto_bnus
    lotto_count = lotto_match.count
    
    puts "이번주 로또 번호는 #{lotto_array} 이며 보너스 번호는 #{lotto_bnus} 입니다."
    puts "귀하의 로또 번호는 #{my_lotto_array} 이며 맞은 수는 #{lotto_match} 입니다."
    
    if lotto_array == lotto_match
        result = "1등 입니다."
    elsif 6 == lotto_count
        result = "2등 입니다."
    elsif 5 == lotto_count
        result = "3등 입니다."
    elsif 4 == lotto_count
        result = "4등 입니다."
    elsif 3 == lotto_count
        result = "5등 입니다."
    else
        result = "꽝 입니다."
    end
    
    @lotto_array = lotto_array
    @lotto_bnus = lotto_bnus
    @my_lotto_array = my_lotto_array
    @lotto_match = lotto_match
    @result = result
    
  end
end
