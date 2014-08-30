require "trans/version"
require "trans/translator_trans"

module Trans  
  # ---------------- tocmd_trans command -----------------
  def self.hi_trans_local(a)  
    p VERSION
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
