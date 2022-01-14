	/**
     * 주민등록번호 유효성검사
     */
    function fnrrnCheck(rrn) {
        var sum = 0;
         
        if (rrn.length != 13) {
            return false;
        } else if (rrn.substr(6, 1) != 1 && rrn.substr(6, 1) != 2 && rrn.substr(6, 1) != 3 && rrn.substr(6, 1) != 4) {
            return false;
        }
         
        for (var i = 0; i < 12; i++) {
            sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
        }
         
        if (((11 - (sum % 11)) % 10) == Number(rrn.substr(12, 1))) {
            return true;
        }
         
        return false;
    },
 
    /**
     * 외국인등록번호 유효성검사
     * @param rrn
     * @returns
     */
    function fnfgnCheck(rrn) {
        var sum = 0;
         
        if (rrn.length != 13) {
            return false;
        } else if (rrn.substr(6, 1) != 5 && rrn.substr(6, 1) != 6 && rrn.substr(6, 1) != 7 && rrn.substr(6, 1) != 8) {
            return false;
        }
         
        if (Number(rrn.substr(7, 2)) % 2 != 0) {
            return false;
        }
         
        for (var i = 0; i < 12; i++) {
            sum += Number(rrn.substr(i, 1)) * ((i % 8) + 2);
        }
         
        if ((((11 - (sum % 11)) % 10 + 2) % 10) == Number(rrn.substr(12, 1))) {
            return true;
        }
         
        return false;
    },
 
    /**
     * 법인등록번호 유효성검사
     * @param bubinNum
     * @returns {Boolean}
     */
    function fnBsnCheck(bubinNum) {
        var as_Biz_no = String(bubinNum);
        var I_TEMP_SUM = 0;
        var I_CHK_DIGIT = 0;
 
        if (bubinNum.length != 13) {
            return false;
        }
 
        for(var index01 = 1; index01 < 13; index01++) {
            var i = index01 % 2;
            var j = 0;
 
            if (i == 1) {
                j = 1; 
                 
            } else if (i == 0) {
                j = 2;
                 
            }
 
            I_TEMP_SUM = I_TEMP_SUM + parseInt(as_Biz_no.substring(index01 - 1, index01), 10) * j;
        }
 
        I_CHK_DIGIT = I_TEMP_SUM % 10;
         
        if (I_CHK_DIGIT != 0) {
            I_CHK_DIGIT = 10 - I_CHK_DIGIT;
        }
 
        if (as_Biz_no.substring(12, 13) != String(I_CHK_DIGIT)) {
            return false;
 
        } else {
            return true;
 
        }
         
    }