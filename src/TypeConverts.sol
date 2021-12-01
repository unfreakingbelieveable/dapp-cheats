// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

contract TypeConverts {
    // https://ethereum.stackexchange.com/questions/64998/converting-from-bytes-in-0-5-x?rq=1
    function bytesToAddress(bytes memory _b) public pure returns (address) {
        return address(tb20(_b));
    }

    function tb20(bytes memory _b) public pure returns (bytes20 _result) {
        assembly {
            _result := mload(add(_b, 0x20))
        }
    }

    // https://stackoverflow.com/questions/47129173/how-to-convert-uint-to-string-in-solidity
    function uint2str(uint256 _i)
        public
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    // https://stackoverflow.com/questions/68976364/solidity-converting-number-strings-to-numbers
    function st2num(string memory numString) public pure returns (uint256) {
        uint256 val = 0;
        bytes memory stringBytes = bytes(numString);
        for (uint256 i = 0; i < stringBytes.length; i++) {
            uint256 exp = stringBytes.length - i;
            bytes1 ival = stringBytes[i];
            uint8 uval = uint8(ival);
            uint256 jval = uval - uint256(0x30);

            val += (uint256(jval) * (10**(exp - 1)));
        }
        return val;
    }
}
