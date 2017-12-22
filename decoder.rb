class Decoder

  DECODER_MAP = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'y', 'z', '1', '2', '3']
  def self.decode(input)
    length  = DECODER_MAP.length
    encoded = ""
      while input > 0 do
        val      = (input % length)
        input    = (input / length)
        encoded += DECODER_MAP[val]
      end
    encoded
  end
end

# Original function
# function encode(input) {
#         length = map.length;
#         var encoded = "";
#         if (input == 0)
#             return map[0];
#         if (input < 0) {
#             input *= -1;
#             encoded += "-";
#         };
#         while (input > 0) {
#             val = parseInt(input % length);
#             input = parseInt(input / length);
#             encoded += map[val];
#         }
#         return encoded;
#     }
