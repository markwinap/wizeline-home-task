class CidrMask
  def cidr_to_mask(x)
    ('1' * x + '0' * (32 - x)).match(/(.{8})(.{8})(.{8})(.{8})/).captures
                              .map { |e| e.to_i(2) }.join('.')
  end

  def build_lookup_table
    @lookup_table = (1..32).inject({}) do |ha, i|
      ctm = cidr_to_mask(i)
      ha.merge(i.to_s => ctm, ctm => i.to_s)
    end
  end

  def convert(value)
    build_lookup_table unless @lookup_table
    @lookup_table[value.to_s] || "Invalid value #{value}!"
  end
end

class CidrMaskConvert
  def initialize
    @cm = CidrMask.new
  end

  def cidr_to_mask(val)
    @cm.convert(val)
  end

  def mask_to_cidr(val)
    @cm.convert(val)
  end
end

class IpValidate
  def ipv4_validation(val)
    (ip.to_s.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/i)&.captures ||
    [256]).map{ |e| e.to_i < 256 }.inject{ |x, y| x && y }
  end
end
