require "tocmd/version"
require "tocmd/translator_trans"

module Tocmd  
  # ---------------- tocmd_trans command -----------------
  def self.hi_trans_local(a)  
    translator = TranslatorTrans.new(a)  
    translator.hi  
    # puts version info
    p VERSION
  end
	
  def self.hi_trans_dir_local(a)  
    translator = TranslatorTrans.new(a)  
    translator.hi_dir 
    # puts version info
    p VERSION
  end

end
