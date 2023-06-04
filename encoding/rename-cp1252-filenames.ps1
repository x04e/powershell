$charReplacements = @{
    # CP1252 Character Conversions
    [char]0x0080 = [char]0x20AC; # € EURO SIGN
    [char]0x0082 = [char]0x201A; # ‚ SINGLE LOW-9 QUOTATION MARK
    [char]0x0083 = [char]0x0192; # ƒ LATIN SMALL LETTER F WITH HOOK
    [char]0x0084 = [char]0x201E; # „ DOUBLE LOW-9 QUOTATION MARK
    [char]0x0085 = [char]0x2026; # … HORIZONTAL ELLIPSIS
    [char]0x0086 = [char]0x2020; # † DAGGER
    [char]0x0087 = [char]0x2021; # ‡ DOUBLE DAGGER
    [char]0x0088 = [char]0x02C6; # ˆ MODIFIER LETTER CIRCUMFLEX ACCENT
    [char]0x0089 = [char]0x2030; # ‰ PER MILLE SIGN
    [char]0x008A = [char]0x0160; # Š LATIN CAPITAL LETTER S WITH CARON
    [char]0x008B = [char]0x2039; # ‹ SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    [char]0x008C = [char]0x0152; # Œ LATIN CAPITAL LIGATURE OE
    [char]0x008E = [char]0x017D; # Ž LATIN CAPITAL LETTER Z WITH CARON
    [char]0x0091 = [char]0x2018; # ‘ LEFT SINGLE QUOTATION MARK
    [char]0x0092 = [char]0x2019; # ’ RIGHT SINGLE QUOTATION MARK
    [char]0x0093 = [char]0x201C; # “ LEFT DOUBLE QUOTATION MARK
    [char]0x0094 = [char]0x201D; # ” RIGHT DOUBLE QUOTATION MARK
    [char]0x0095 = [char]0x2022; # • BULLET
    [char]0x0096 = [char]0x2013; # – EN DASH
    [char]0x0097 = [char]0x2014; # — EM DASH
    [char]0x0098 = [char]0x02DC; # ˜ SMALL TILDE
    [char]0x0099 = [char]0x2122; # ™ TRADE MARK SIGN
    [char]0x009A = [char]0x0161; # š LATIN SMALL LETTER S WITH CARON
    [char]0x009B = [char]0x203A; # › SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    [char]0x009C = [char]0x0153; # œ LATIN SMALL LIGATURE OE
    [char]0x009E = [char]0x017E; # ž LATIN SMALL LETTER Z WITH CARON
    [char]0x009F = [char]0x0178; # Ÿ LATIN CAPITAL LETTER Y WITH DIAERESIS

    # Special Character Conversion
    [char]0x0022 = ''; # " Double Quote
    [char]0x002A = ''; # * Asterisk
    [char]0x002F = ''; # / Forward Slash
    [char]0x003A = ''; # : Colon
    [char]0x003C = ''; # < Less-Than
    [char]0x003E = ''; # > Greater-Than
    [char]0x005C = ''; # \ Backslash
    [char]0x007C = ''; # | Pipe
    [char]0x003F = ''; # ? Question Mark (also CP1252 replacement character)
    [char]0xFFFD = ''; # � Unicode replacement character
}

Get-ChildItem -Recurse 'Z:\cp1252\test\utf8' | &{process{
    $newName = ($_.name.ToCharArray() | &{process{
        if($charReplacements[$_] -ne $null){
            $charReplacements[$_]
        } else {
            $_
        }
    }}) -join ''

    # *NB* Use .equals() instead of -eq or -ceq as these
    # will return $true for ('' -(c)eq [char]0xFFFD)
    if(-not ($_.name.equals($newName))){
        Rename-Item -LiteralPath $_.FullName -NewName $newName
    }
}}
