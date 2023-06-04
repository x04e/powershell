
$dir  = "Z:\cp1252\test"
function Main {

    $utf8file = "$dir\utf8-list.txt"
    $cp1252file = "$dir\cp1252-list.txt"

    Remove-Item -ErrorAction SilentlyContinue $dir -Recurse
    
    New-Item -ItemType Directory -Path "$dir\cp1252"
    New-Item -ItemType Directory -Path "$dir\unicode"
    New-Item -ItemType Directory -Path "$dir\utf8"
    New-Item -ItemType Directory -Path "$dir\char"

    foreach($ch in $characters){
        
        $out = (
            $ch.hex +
            "`tUTF8: "+ [System.Text.Encoding]::UTF8.GetChars($ch.hex)+
            "`tUnicode: "+ [System.Text.Encoding]::Unicode.GetChars($ch.hex)+
            "`tCP1252: "+ [System.Text.Encoding]::Default.GetChars($ch.hex)
        )

        try {
            $out | out-file -append -encoding default  $cp1252file
            $out | Out-File ($utf8file) -Append -Encoding utf8
            Write-Host ("("+$out+") - txtfile")
        } catch {
            Write-Host -ForegroundColor Red $out
        }

        # cp1252
        try {
            "hello" | Out-File ($dir +"\cp1252\"+  $ch.hex +"_start_"+ [System.Text.Encoding]::Default.GetChars($ch.hex) +"_end.txt")
            Write-Host ("("+$out+") - cp1252")
        } catch {
            Write-Host -ForegroundColor Red ("("+$out+") - txtfile")
        }

        # unicode
        try {
            "hello" | Out-File ($dir +"\unicode\"+ $ch.hex +"_start_"+ [System.Text.Encoding]::Unicode.GetChars($ch.hex) +"_end.txt")
            Write-Host ("("+$out+") - unicode")
        } catch {
            Write-Host -ForegroundColor Red ("("+$out+") - unicode")
        }

        # utf8
        try {
            "hello" | Out-File ($dir +"\utf8\"+    $ch.hex +"_start_"+ [System.Text.Encoding]::UTF8.GetChars($ch.hex) +"_end.txt")
            Write-Host ("("+$out+") - utf8")
        } catch {
            Write-Host -ForegroundColor Red ("("+$out+") - utf8")
        }

        # literal char
        try {
            "hello" | Out-File ($dir +"\char\"+    $ch.hex +"_start_"+ $ch.character +"_end.txt")
            Write-Host ("("+$out+") - char")
        } catch {
            Write-Host -ForegroundColor Red ("("+$out+") - char")
        }
    }
}

$characters = @(
@{ 'hex'='0x20'; 'character'=[char]0x20; 'ch'=' '; 'name'='SPACE' },
@{ 'hex'='0x21'; 'character'=[char]0x21; 'ch'='!'; 'name'='EXCLAMATION MARK' },
@{ 'hex'='0x22'; 'character'=[char]0x22; 'ch'='"'; 'name'='QUOTATION MARK' },
@{ 'hex'='0x23'; 'character'=[char]0x23; 'ch'='#'; 'name'='NUMBER SIGN' },
@{ 'hex'='0x24'; 'character'=[char]0x24; 'ch'='$'; 'name'='DOLLAR SIGN' },
@{ 'hex'='0x25'; 'character'=[char]0x25; 'ch'='%'; 'name'='PERCENT SIGN' },
@{ 'hex'='0x26'; 'character'=[char]0x26; 'ch'='&'; 'name'='AMPERSAND' },
@{ 'hex'='0x27'; 'character'=[char]0x27; 'ch'="'"; 'name'='APOSTROPHE' },
@{ 'hex'='0x28'; 'character'=[char]0x28; 'ch'='('; 'name'='LEFT PARENTHESIS' },
@{ 'hex'='0x29'; 'character'=[char]0x29; 'ch'=')'; 'name'='RIGHT PARENTHESIS' },
@{ 'hex'='0x2A'; 'character'=[char]0x2A; 'ch'='*'; 'name'='ASTERISK' },
@{ 'hex'='0x2B'; 'character'=[char]0x2B; 'ch'='+'; 'name'='PLUS SIGN' },
@{ 'hex'='0x2C'; 'character'=[char]0x2C; 'ch'=','; 'name'='COMMA' },
@{ 'hex'='0x2D'; 'character'=[char]0x2D; 'ch'='-'; 'name'='HYPHEN-MINUS' },
@{ 'hex'='0x2E'; 'character'=[char]0x2E; 'ch'='.'; 'name'='FULL STOP' },
@{ 'hex'='0x2F'; 'character'=[char]0x2F; 'ch'='/'; 'name'='SOLIDUS' },
@{ 'hex'='0x30'; 'character'=[char]0x30; 'ch'='0'; 'name'='DIGIT ZERO' },
@{ 'hex'='0x31'; 'character'=[char]0x31; 'ch'='1'; 'name'='DIGIT ONE' },
@{ 'hex'='0x32'; 'character'=[char]0x32; 'ch'='2'; 'name'='DIGIT TWO' },
@{ 'hex'='0x33'; 'character'=[char]0x33; 'ch'='3'; 'name'='DIGIT THREE' },
@{ 'hex'='0x34'; 'character'=[char]0x34; 'ch'='4'; 'name'='DIGIT FOUR' },
@{ 'hex'='0x35'; 'character'=[char]0x35; 'ch'='5'; 'name'='DIGIT FIVE' },
@{ 'hex'='0x36'; 'character'=[char]0x36; 'ch'='6'; 'name'='DIGIT SIX' },
@{ 'hex'='0x37'; 'character'=[char]0x37; 'ch'='7'; 'name'='DIGIT SEVEN' },
@{ 'hex'='0x38'; 'character'=[char]0x38; 'ch'='8'; 'name'='DIGIT EIGHT' },
@{ 'hex'='0x39'; 'character'=[char]0x39; 'ch'='9'; 'name'='DIGIT NINE' },
@{ 'hex'='0x3A'; 'character'=[char]0x3A; 'ch'=':'; 'name'='COLON' },
@{ 'hex'='0x3B'; 'character'=[char]0x3B; 'ch'=';'; 'name'='SEMICOLON' },
@{ 'hex'='0x3C'; 'character'=[char]0x3C; 'ch'='<'; 'name'='LESS-THAN SIGN' },
@{ 'hex'='0x3D'; 'character'=[char]0x3D; 'ch'='='; 'name'='EQUALS SIGN' },
@{ 'hex'='0x3E'; 'character'=[char]0x3E; 'ch'='>'; 'name'='GREATER-THAN SIGN' },
@{ 'hex'='0x3F'; 'character'=[char]0x3F; 'ch'='?'; 'name'='QUESTION MARK' },
@{ 'hex'='0x40'; 'character'=[char]0x40; 'ch'='@'; 'name'='COMMERCIAL AT' },
@{ 'hex'='0x41'; 'character'=[char]0x41; 'ch'='A'; 'name'='LATIN CAPITAL LETTER A' },
@{ 'hex'='0x42'; 'character'=[char]0x42; 'ch'='B'; 'name'='LATIN CAPITAL LETTER B' },
@{ 'hex'='0x43'; 'character'=[char]0x43; 'ch'='C'; 'name'='LATIN CAPITAL LETTER C' },
@{ 'hex'='0x44'; 'character'=[char]0x44; 'ch'='D'; 'name'='LATIN CAPITAL LETTER D' },
@{ 'hex'='0x45'; 'character'=[char]0x45; 'ch'='E'; 'name'='LATIN CAPITAL LETTER E' },
@{ 'hex'='0x46'; 'character'=[char]0x46; 'ch'='F'; 'name'='LATIN CAPITAL LETTER F' },
@{ 'hex'='0x47'; 'character'=[char]0x47; 'ch'='G'; 'name'='LATIN CAPITAL LETTER G' },
@{ 'hex'='0x48'; 'character'=[char]0x48; 'ch'='H'; 'name'='LATIN CAPITAL LETTER H' },
@{ 'hex'='0x49'; 'character'=[char]0x49; 'ch'='I'; 'name'='LATIN CAPITAL LETTER I' },
@{ 'hex'='0x4A'; 'character'=[char]0x4A; 'ch'='J'; 'name'='LATIN CAPITAL LETTER J' },
@{ 'hex'='0x4B'; 'character'=[char]0x4B; 'ch'='K'; 'name'='LATIN CAPITAL LETTER K' },
@{ 'hex'='0x4C'; 'character'=[char]0x4C; 'ch'='L'; 'name'='LATIN CAPITAL LETTER L' },
@{ 'hex'='0x4D'; 'character'=[char]0x4D; 'ch'='M'; 'name'='LATIN CAPITAL LETTER M' },
@{ 'hex'='0x4E'; 'character'=[char]0x4E; 'ch'='N'; 'name'='LATIN CAPITAL LETTER N' },
@{ 'hex'='0x4F'; 'character'=[char]0x4F; 'ch'='O'; 'name'='LATIN CAPITAL LETTER O' },
@{ 'hex'='0x50'; 'character'=[char]0x50; 'ch'='P'; 'name'='LATIN CAPITAL LETTER P' },
@{ 'hex'='0x51'; 'character'=[char]0x51; 'ch'='Q'; 'name'='LATIN CAPITAL LETTER Q' },
@{ 'hex'='0x52'; 'character'=[char]0x52; 'ch'='R'; 'name'='LATIN CAPITAL LETTER R' },
@{ 'hex'='0x53'; 'character'=[char]0x53; 'ch'='S'; 'name'='LATIN CAPITAL LETTER S' },
@{ 'hex'='0x54'; 'character'=[char]0x54; 'ch'='T'; 'name'='LATIN CAPITAL LETTER T' },
@{ 'hex'='0x55'; 'character'=[char]0x55; 'ch'='U'; 'name'='LATIN CAPITAL LETTER U' },
@{ 'hex'='0x56'; 'character'=[char]0x56; 'ch'='V'; 'name'='LATIN CAPITAL LETTER V' },
@{ 'hex'='0x57'; 'character'=[char]0x57; 'ch'='W'; 'name'='LATIN CAPITAL LETTER W' },
@{ 'hex'='0x58'; 'character'=[char]0x58; 'ch'='X'; 'name'='LATIN CAPITAL LETTER X' },
@{ 'hex'='0x59'; 'character'=[char]0x59; 'ch'='Y'; 'name'='LATIN CAPITAL LETTER Y' },
@{ 'hex'='0x5A'; 'character'=[char]0x5A; 'ch'='Z'; 'name'='LATIN CAPITAL LETTER Z' },
@{ 'hex'='0x5B'; 'character'=[char]0x5B; 'ch'='['; 'name'='LEFT SQUARE BRACKET' },
@{ 'hex'='0x5C'; 'character'=[char]0x5C; 'ch'='\'; 'name'='REVERSE SOLIDUS' },
@{ 'hex'='0x5D'; 'character'=[char]0x5D; 'ch'=']'; 'name'='RIGHT SQUARE BRACKET' },
@{ 'hex'='0x5E'; 'character'=[char]0x5E; 'ch'='^'; 'name'='CIRCUMFLEX ACCENT' },
@{ 'hex'='0x5F'; 'character'=[char]0x5F; 'ch'='_'; 'name'='LOW LINE' },
@{ 'hex'='0x60'; 'character'=[char]0x60; 'ch'='`'; 'name'='GRAVE ACCENT' },
@{ 'hex'='0x61'; 'character'=[char]0x61; 'ch'='a'; 'name'='LATIN SMALL LETTER A' },
@{ 'hex'='0x62'; 'character'=[char]0x62; 'ch'='b'; 'name'='LATIN SMALL LETTER B' },
@{ 'hex'='0x63'; 'character'=[char]0x63; 'ch'='c'; 'name'='LATIN SMALL LETTER C' },
@{ 'hex'='0x64'; 'character'=[char]0x64; 'ch'='d'; 'name'='LATIN SMALL LETTER D' },
@{ 'hex'='0x65'; 'character'=[char]0x65; 'ch'='e'; 'name'='LATIN SMALL LETTER E' },
@{ 'hex'='0x66'; 'character'=[char]0x66; 'ch'='f'; 'name'='LATIN SMALL LETTER F' },
@{ 'hex'='0x67'; 'character'=[char]0x67; 'ch'='g'; 'name'='LATIN SMALL LETTER G' },
@{ 'hex'='0x68'; 'character'=[char]0x68; 'ch'='h'; 'name'='LATIN SMALL LETTER H' },
@{ 'hex'='0x69'; 'character'=[char]0x69; 'ch'='i'; 'name'='LATIN SMALL LETTER I' },
@{ 'hex'='0x6A'; 'character'=[char]0x6A; 'ch'='j'; 'name'='LATIN SMALL LETTER J' },
@{ 'hex'='0x6B'; 'character'=[char]0x6B; 'ch'='k'; 'name'='LATIN SMALL LETTER K' },
@{ 'hex'='0x6C'; 'character'=[char]0x6C; 'ch'='l'; 'name'='LATIN SMALL LETTER L' },
@{ 'hex'='0x6D'; 'character'=[char]0x6D; 'ch'='m'; 'name'='LATIN SMALL LETTER M' },
@{ 'hex'='0x6E'; 'character'=[char]0x6E; 'ch'='n'; 'name'='LATIN SMALL LETTER N' },
@{ 'hex'='0x6F'; 'character'=[char]0x6F; 'ch'='o'; 'name'='LATIN SMALL LETTER O' },
@{ 'hex'='0x70'; 'character'=[char]0x70; 'ch'='p'; 'name'='LATIN SMALL LETTER P' },
@{ 'hex'='0x71'; 'character'=[char]0x71; 'ch'='q'; 'name'='LATIN SMALL LETTER Q' },
@{ 'hex'='0x72'; 'character'=[char]0x72; 'ch'='r'; 'name'='LATIN SMALL LETTER R' },
@{ 'hex'='0x73'; 'character'=[char]0x73; 'ch'='s'; 'name'='LATIN SMALL LETTER S' },
@{ 'hex'='0x74'; 'character'=[char]0x74; 'ch'='t'; 'name'='LATIN SMALL LETTER T' },
@{ 'hex'='0x75'; 'character'=[char]0x75; 'ch'='u'; 'name'='LATIN SMALL LETTER U' },
@{ 'hex'='0x76'; 'character'=[char]0x76; 'ch'='v'; 'name'='LATIN SMALL LETTER V' },
@{ 'hex'='0x77'; 'character'=[char]0x77; 'ch'='w'; 'name'='LATIN SMALL LETTER W' },
@{ 'hex'='0x78'; 'character'=[char]0x78; 'ch'='x'; 'name'='LATIN SMALL LETTER X' },
@{ 'hex'='0x79'; 'character'=[char]0x79; 'ch'='y'; 'name'='LATIN SMALL LETTER Y' },
@{ 'hex'='0x7A'; 'character'=[char]0x7A; 'ch'='z'; 'name'='LATIN SMALL LETTER Z' },
@{ 'hex'='0x7B'; 'character'=[char]0x7B; 'ch'='{'; 'name'='LEFT CURLY BRACKET' },
@{ 'hex'='0x7C'; 'character'=[char]0x7C; 'ch'='|'; 'name'='VERTICAL LINE' },
@{ 'hex'='0x7D'; 'character'=[char]0x7D; 'ch'='}'; 'name'='RIGHT CURLY BRACKET' },
@{ 'hex'='0x7E'; 'character'=[char]0x7E; 'ch'='~'; 'name'='TILDE' },
@{ 'hex'='0x80'; 'character'=[char]0x80; 'ch'='€'; 'name'='EURO SIGN' },
@{ 'hex'='0x82'; 'character'=[char]0x82; 'ch'="‚"; 'name'='SINGLE LOW-9 QUOTATION MARK' },
@{ 'hex'='0x83'; 'character'=[char]0x83; 'ch'='ƒ'; 'name'='LATIN SMALL LETTER F WITH HOOK' },
@{ 'hex'='0x84'; 'character'=[char]0x84; 'ch'='„'; 'name'='DOUBLE LOW-9 QUOTATION MARK' },
@{ 'hex'='0x85'; 'character'=[char]0x85; 'ch'='…'; 'name'='HORIZONTAL ELLIPSIS' },
@{ 'hex'='0x86'; 'character'=[char]0x86; 'ch'='†'; 'name'='DAGGER' },
@{ 'hex'='0x87'; 'character'=[char]0x87; 'ch'='‡'; 'name'='DOUBLE DAGGER' },
@{ 'hex'='0x88'; 'character'=[char]0x88; 'ch'='ˆ'; 'name'='MODIFIER LETTER CIRCUMFLEX ACCENT' },
@{ 'hex'='0x89'; 'character'=[char]0x89; 'ch'='‰'; 'name'='PER MILLE SIGN' },
@{ 'hex'='0x8A'; 'character'=[char]0x8A; 'ch'='Š'; 'name'='LATIN CAPITAL LETTER S WITH CARON' },
@{ 'hex'='0x8B'; 'character'=[char]0x8B; 'ch'='‹'; 'name'='SINGLE LEFT-POINTING ANGLE QUOTATION MARK' },
@{ 'hex'='0x8C'; 'character'=[char]0x8C; 'ch'='Œ'; 'name'='LATIN CAPITAL LIGATURE OE' },
@{ 'hex'='0x8E'; 'character'=[char]0x8E; 'ch'='Ž'; 'name'='LATIN CAPITAL LETTER Z WITH CARON' },
@{ 'hex'='0x91'; 'character'=[char]0x91; 'ch'="‘"; 'name'='LEFT SINGLE QUOTATION MARK' },
@{ 'hex'='0x92'; 'character'=[char]0x92; 'ch'="’"; 'name'='RIGHT SINGLE QUOTATION MARK' },
@{ 'hex'='0x93'; 'character'=[char]0x93; 'ch'='“'; 'name'='LEFT DOUBLE QUOTATION MARK' },
@{ 'hex'='0x94'; 'character'=[char]0x94; 'ch'='”'; 'name'='RIGHT DOUBLE QUOTATION MARK' },
@{ 'hex'='0x95'; 'character'=[char]0x95; 'ch'='•'; 'name'='BULLET' },
@{ 'hex'='0x96'; 'character'=[char]0x96; 'ch'='–'; 'name'='EN DASH' },
@{ 'hex'='0x97'; 'character'=[char]0x97; 'ch'='—'; 'name'='EM DASH' },
@{ 'hex'='0x98'; 'character'=[char]0x98; 'ch'='˜'; 'name'='SMALL TILDE' },
@{ 'hex'='0x99'; 'character'=[char]0x99; 'ch'='™'; 'name'='TRADE MARK SIGN' },
@{ 'hex'='0x9A'; 'character'=[char]0x9A; 'ch'='š'; 'name'='LATIN SMALL LETTER S WITH CARON' },
@{ 'hex'='0x9B'; 'character'=[char]0x9B; 'ch'='›'; 'name'='SINGLE RIGHT-POINTING ANGLE QUOTATION MARK' },
@{ 'hex'='0x9C'; 'character'=[char]0x9C; 'ch'='œ'; 'name'='LATIN SMALL LIGATURE OE' },
@{ 'hex'='0x9E'; 'character'=[char]0x9E; 'ch'='ž'; 'name'='LATIN SMALL LETTER Z WITH CARON' },
@{ 'hex'='0x9F'; 'character'=[char]0x9F; 'ch'='Ÿ'; 'name'='LATIN CAPITAL LETTER Y WITH DIAERESIS' },
@{ 'hex'='0xA0'; 'character'=[char]0xA0; 'ch'=' '; 'name'='NO-BREAK SPACE' },
@{ 'hex'='0xA1'; 'character'=[char]0xA1; 'ch'='¡'; 'name'='INVERTED EXCLAMATION MARK' },
@{ 'hex'='0xA2'; 'character'=[char]0xA2; 'ch'='¢'; 'name'='CENT SIGN' },
@{ 'hex'='0xA3'; 'character'=[char]0xA3; 'ch'='£'; 'name'='POUND SIGN' },
@{ 'hex'='0xA4'; 'character'=[char]0xA4; 'ch'='¤'; 'name'='CURRENCY SIGN' },
@{ 'hex'='0xA5'; 'character'=[char]0xA5; 'ch'='¥'; 'name'='YEN SIGN' },
@{ 'hex'='0xA6'; 'character'=[char]0xA6; 'ch'='¦'; 'name'='BROKEN BAR' },
@{ 'hex'='0xA7'; 'character'=[char]0xA7; 'ch'='§'; 'name'='SECTION SIGN' },
@{ 'hex'='0xA8'; 'character'=[char]0xA8; 'ch'='¨'; 'name'='DIAERESIS' },
@{ 'hex'='0xA9'; 'character'=[char]0xA9; 'ch'='©'; 'name'='COPYRIGHT SIGN' },
@{ 'hex'='0xAA'; 'character'=[char]0xAA; 'ch'='ª'; 'name'='FEMININE ORDINAL INDICATOR' },
@{ 'hex'='0xAB'; 'character'=[char]0xAB; 'ch'='«'; 'name'='LEFT-POINTING DOUBLE ANGLE QUOTATION MARK' },
@{ 'hex'='0xAC'; 'character'=[char]0xAC; 'ch'='¬'; 'name'='NOT SIGN' },
@{ 'hex'='0xAD'; 'character'=[char]0xAD; 'ch'='­'; 'name'='SOFT HYPHEN' },
@{ 'hex'='0xAE'; 'character'=[char]0xAE; 'ch'='®'; 'name'='REGISTERED SIGN' },
@{ 'hex'='0xAF'; 'character'=[char]0xAF; 'ch'='¯'; 'name'='MACRON' },
@{ 'hex'='0xB0'; 'character'=[char]0xB0; 'ch'='°'; 'name'='DEGREE SIGN' },
@{ 'hex'='0xB1'; 'character'=[char]0xB1; 'ch'='±'; 'name'='PLUS-MINUS SIGN' },
@{ 'hex'='0xB2'; 'character'=[char]0xB2; 'ch'='²'; 'name'='SUPERSCRIPT TWO' },
@{ 'hex'='0xB3'; 'character'=[char]0xB3; 'ch'='³'; 'name'='SUPERSCRIPT THREE' },
@{ 'hex'='0xB4'; 'character'=[char]0xB4; 'ch'='´'; 'name'='ACUTE ACCENT' },
@{ 'hex'='0xB5'; 'character'=[char]0xB5; 'ch'='µ'; 'name'='MICRO SIGN' },
@{ 'hex'='0xB6'; 'character'=[char]0xB6; 'ch'='¶'; 'name'='PILCROW SIGN' },
@{ 'hex'='0xB7'; 'character'=[char]0xB7; 'ch'='·'; 'name'='MIDDLE DOT' },
@{ 'hex'='0xB8'; 'character'=[char]0xB8; 'ch'='¸'; 'name'='CEDILLA' },
@{ 'hex'='0xB9'; 'character'=[char]0xB9; 'ch'='¹'; 'name'='SUPERSCRIPT ONE' },
@{ 'hex'='0xBA'; 'character'=[char]0xBA; 'ch'='º'; 'name'='MASCULINE ORDINAL INDICATOR' },
@{ 'hex'='0xBB'; 'character'=[char]0xBB; 'ch'='»'; 'name'='RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK' },
@{ 'hex'='0xBC'; 'character'=[char]0xBC; 'ch'='¼'; 'name'='VULGAR FRACTION ONE QUARTER' },
@{ 'hex'='0xBD'; 'character'=[char]0xBD; 'ch'='½'; 'name'='VULGAR FRACTION ONE HALF' },
@{ 'hex'='0xBE'; 'character'=[char]0xBE; 'ch'='¾'; 'name'='VULGAR FRACTION THREE QUARTERS' },
@{ 'hex'='0xBF'; 'character'=[char]0xBF; 'ch'='¿'; 'name'='INVERTED QUESTION MARK' },
@{ 'hex'='0xC0'; 'character'=[char]0xC0; 'ch'='À'; 'name'='LATIN CAPITAL LETTER A WITH GRAVE' },
@{ 'hex'='0xC1'; 'character'=[char]0xC1; 'ch'='Á'; 'name'='LATIN CAPITAL LETTER A WITH ACUTE' },
@{ 'hex'='0xC2'; 'character'=[char]0xC2; 'ch'='Â'; 'name'='LATIN CAPITAL LETTER A WITH CIRCUMFLEX' },
@{ 'hex'='0xC3'; 'character'=[char]0xC3; 'ch'='Ã'; 'name'='LATIN CAPITAL LETTER A WITH TILDE' },
@{ 'hex'='0xC4'; 'character'=[char]0xC4; 'ch'='Ä'; 'name'='LATIN CAPITAL LETTER A WITH DIAERESIS' },
@{ 'hex'='0xC5'; 'character'=[char]0xC5; 'ch'='Å'; 'name'='LATIN CAPITAL LETTER A WITH RING ABOVE' },
@{ 'hex'='0xC6'; 'character'=[char]0xC6; 'ch'='Æ'; 'name'='LATIN CAPITAL LETTER AE' },
@{ 'hex'='0xC7'; 'character'=[char]0xC7; 'ch'='Ç'; 'name'='LATIN CAPITAL LETTER C WITH CEDILLA' },
@{ 'hex'='0xC8'; 'character'=[char]0xC8; 'ch'='È'; 'name'='LATIN CAPITAL LETTER E WITH GRAVE' },
@{ 'hex'='0xC9'; 'character'=[char]0xC9; 'ch'='É'; 'name'='LATIN CAPITAL LETTER E WITH ACUTE' },
@{ 'hex'='0xCA'; 'character'=[char]0xCA; 'ch'='Ê'; 'name'='LATIN CAPITAL LETTER E WITH CIRCUMFLEX' },
@{ 'hex'='0xCB'; 'character'=[char]0xCB; 'ch'='Ë'; 'name'='LATIN CAPITAL LETTER E WITH DIAERESIS' },
@{ 'hex'='0xCC'; 'character'=[char]0xCC; 'ch'='Ì'; 'name'='LATIN CAPITAL LETTER I WITH GRAVE' },
@{ 'hex'='0xCD'; 'character'=[char]0xCD; 'ch'='Í'; 'name'='LATIN CAPITAL LETTER I WITH ACUTE' },
@{ 'hex'='0xCE'; 'character'=[char]0xCE; 'ch'='Î'; 'name'='LATIN CAPITAL LETTER I WITH CIRCUMFLEX' },
@{ 'hex'='0xCF'; 'character'=[char]0xCF; 'ch'='Ï'; 'name'='LATIN CAPITAL LETTER I WITH DIAERESIS' },
@{ 'hex'='0xD0'; 'character'=[char]0xD0; 'ch'='Ð'; 'name'='LATIN CAPITAL LETTER ETH' },
@{ 'hex'='0xD1'; 'character'=[char]0xD1; 'ch'='Ñ'; 'name'='LATIN CAPITAL LETTER N WITH TILDE' },
@{ 'hex'='0xD2'; 'character'=[char]0xD2; 'ch'='Ò'; 'name'='LATIN CAPITAL LETTER O WITH GRAVE' },
@{ 'hex'='0xD3'; 'character'=[char]0xD3; 'ch'='Ó'; 'name'='LATIN CAPITAL LETTER O WITH ACUTE' },
@{ 'hex'='0xD4'; 'character'=[char]0xD4; 'ch'='Ô'; 'name'='LATIN CAPITAL LETTER O WITH CIRCUMFLEX' },
@{ 'hex'='0xD5'; 'character'=[char]0xD5; 'ch'='Õ'; 'name'='LATIN CAPITAL LETTER O WITH TILDE' },
@{ 'hex'='0xD6'; 'character'=[char]0xD6; 'ch'='Ö'; 'name'='LATIN CAPITAL LETTER O WITH DIAERESIS' },
@{ 'hex'='0xD7'; 'character'=[char]0xD7; 'ch'='×'; 'name'='MULTIPLICATION SIGN' },
@{ 'hex'='0xD8'; 'character'=[char]0xD8; 'ch'='Ø'; 'name'='LATIN CAPITAL LETTER O WITH STROKE' },
@{ 'hex'='0xD9'; 'character'=[char]0xD9; 'ch'='Ù'; 'name'='LATIN CAPITAL LETTER U WITH GRAVE' },
@{ 'hex'='0xDA'; 'character'=[char]0xDA; 'ch'='Ú'; 'name'='LATIN CAPITAL LETTER U WITH ACUTE' },
@{ 'hex'='0xDB'; 'character'=[char]0xDB; 'ch'='Û'; 'name'='LATIN CAPITAL LETTER U WITH CIRCUMFLEX' },
@{ 'hex'='0xDC'; 'character'=[char]0xDC; 'ch'='Ü'; 'name'='LATIN CAPITAL LETTER U WITH DIAERESIS' },
@{ 'hex'='0xDD'; 'character'=[char]0xDD; 'ch'='Ý'; 'name'='LATIN CAPITAL LETTER Y WITH ACUTE' },
@{ 'hex'='0xDE'; 'character'=[char]0xDE; 'ch'='Þ'; 'name'='LATIN CAPITAL LETTER THORN' },
@{ 'hex'='0xDF'; 'character'=[char]0xDF; 'ch'='ß'; 'name'='LATIN SMALL LETTER SHARP S' },
@{ 'hex'='0xE0'; 'character'=[char]0xE0; 'ch'='à'; 'name'='LATIN SMALL LETTER A WITH GRAVE' },
@{ 'hex'='0xE1'; 'character'=[char]0xE1; 'ch'='á'; 'name'='LATIN SMALL LETTER A WITH ACUTE' },
@{ 'hex'='0xE2'; 'character'=[char]0xE2; 'ch'='â'; 'name'='LATIN SMALL LETTER A WITH CIRCUMFLEX' },
@{ 'hex'='0xE3'; 'character'=[char]0xE3; 'ch'='ã'; 'name'='LATIN SMALL LETTER A WITH TILDE' },
@{ 'hex'='0xE4'; 'character'=[char]0xE4; 'ch'='ä'; 'name'='LATIN SMALL LETTER A WITH DIAERESIS' },
@{ 'hex'='0xE5'; 'character'=[char]0xE5; 'ch'='å'; 'name'='LATIN SMALL LETTER A WITH RING ABOVE' },
@{ 'hex'='0xE6'; 'character'=[char]0xE6; 'ch'='æ'; 'name'='LATIN SMALL LETTER AE' },
@{ 'hex'='0xE7'; 'character'=[char]0xE7; 'ch'='ç'; 'name'='LATIN SMALL LETTER C WITH CEDILLA' },
@{ 'hex'='0xE8'; 'character'=[char]0xE8; 'ch'='è'; 'name'='LATIN SMALL LETTER E WITH GRAVE' },
@{ 'hex'='0xE9'; 'character'=[char]0xE9; 'ch'='é'; 'name'='LATIN SMALL LETTER E WITH ACUTE' },
@{ 'hex'='0xEA'; 'character'=[char]0xEA; 'ch'='ê'; 'name'='LATIN SMALL LETTER E WITH CIRCUMFLEX' },
@{ 'hex'='0xEB'; 'character'=[char]0xEB; 'ch'='ë'; 'name'='LATIN SMALL LETTER E WITH DIAERESIS' },
@{ 'hex'='0xEC'; 'character'=[char]0xEC; 'ch'='ì'; 'name'='LATIN SMALL LETTER I WITH GRAVE' },
@{ 'hex'='0xED'; 'character'=[char]0xED; 'ch'='í'; 'name'='LATIN SMALL LETTER I WITH ACUTE' },
@{ 'hex'='0xEE'; 'character'=[char]0xEE; 'ch'='î'; 'name'='LATIN SMALL LETTER I WITH CIRCUMFLEX' },
@{ 'hex'='0xEF'; 'character'=[char]0xEF; 'ch'='ï'; 'name'='LATIN SMALL LETTER I WITH DIAERESIS' },
@{ 'hex'='0xF0'; 'character'=[char]0xF0; 'ch'='ð'; 'name'='LATIN SMALL LETTER ETH' },
@{ 'hex'='0xF1'; 'character'=[char]0xF1; 'ch'='ñ'; 'name'='LATIN SMALL LETTER N WITH TILDE' },
@{ 'hex'='0xF2'; 'character'=[char]0xF2; 'ch'='ò'; 'name'='LATIN SMALL LETTER O WITH GRAVE' },
@{ 'hex'='0xF3'; 'character'=[char]0xF3; 'ch'='ó'; 'name'='LATIN SMALL LETTER O WITH ACUTE' },
@{ 'hex'='0xF4'; 'character'=[char]0xF4; 'ch'='ô'; 'name'='LATIN SMALL LETTER O WITH CIRCUMFLEX' },
@{ 'hex'='0xF5'; 'character'=[char]0xF5; 'ch'='õ'; 'name'='LATIN SMALL LETTER O WITH TILDE' },
@{ 'hex'='0xF6'; 'character'=[char]0xF6; 'ch'='ö'; 'name'='LATIN SMALL LETTER O WITH DIAERESIS' },
@{ 'hex'='0xF7'; 'character'=[char]0xF7; 'ch'='÷'; 'name'='DIVISION SIGN' },
@{ 'hex'='0xF8'; 'character'=[char]0xF8; 'ch'='ø'; 'name'='LATIN SMALL LETTER O WITH STROKE' },
@{ 'hex'='0xF9'; 'character'=[char]0xF9; 'ch'='ù'; 'name'='LATIN SMALL LETTER U WITH GRAVE' },
@{ 'hex'='0xFA'; 'character'=[char]0xFA; 'ch'='ú'; 'name'='LATIN SMALL LETTER U WITH ACUTE' },
@{ 'hex'='0xFB'; 'character'=[char]0xFB; 'ch'='û'; 'name'='LATIN SMALL LETTER U WITH CIRCUMFLEX' },
@{ 'hex'='0xFC'; 'character'=[char]0xFC; 'ch'='ü'; 'name'='LATIN SMALL LETTER U WITH DIAERESIS' },
@{ 'hex'='0xFD'; 'character'=[char]0xFD; 'ch'='ý'; 'name'='LATIN SMALL LETTER Y WITH ACUTE' },
@{ 'hex'='0xFE'; 'character'=[char]0xFE; 'ch'='þ'; 'name'='LATIN SMALL LETTER THORN' },
@{ 'hex'='0xFF'; 'character'=[char]0xFF; 'ch'='ÿ'; 'name'='LATIN SMALL LETTER Y WITH DIAERESIS' }
)

Main
