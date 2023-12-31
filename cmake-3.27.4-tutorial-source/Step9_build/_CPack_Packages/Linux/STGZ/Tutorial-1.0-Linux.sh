#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step9...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� ���d �]|ř����������&�6OE�e;
���ĉ�ma�����,i��PCcRm!P���w��Jz��p�ԁ����+m�k{��G�	`�q��7�3��Ѯ�8&��D�����7�<wvv��p4I��E�#t.����Rꮮt��p��㩮�������]����r$W~�J1�Lh�8�����	w*�����0���������hs���:�i@yTy<��ﮪb�頻*���rUV!�5�Jع�y�/Z$k��$՞��!9֮�cф��䄪i�hKBn��e�D�.���j ʵ���5�+�+�l�(��	P����ҹs̱�_�ZW'�AR����O��]n��������_YUY=��υ��=hiȱhP-*���D{ ��m��Y{�?]�%�"���%�͡�s�m���.n�H�~؍`���������y��n��+�ݞL�WV�����υ�yy l��h�lv��k�	��0ߛ�-@��>����
ӍÃ���e��+/�H77�`G�3���h���N_��s{*ʙ���֭vH�Q�Ie�ɑ��ҿ�hz���?5��^�w-{�t�o���j��F�R8\��Gؗ�GW�\�T��ؔ�jI��vz����$aݷ��;]��F("��/~W�oD�|�r�S���mDRG�4cB~A(~!����|%e�w�,���{��\�v��/ǢD&�o�ϧt!�;�eU�o"�>U!U�#Um�h�Tl.��H�N�����Llk�M@��N[�U\���ڡ!g(���)�@�`��M��i��`!��-�o�&���X�׶Q	j���I�0�|����8�R:_����˅gn8��ò���OP<��}��P�#�輦8��l�3��B&v�f�k����6n7����}�����t�)�oF���oQ(�����n��J�#�����(��k���	�X~m�h��)⏹s����F�u�x �m�g���U{*���L	���t�W��4�������o����z:7t�_�I�i��*��T��,��[��ҿe���Ź�,�ps�[}ͥ�|������@�;�e���w�^�c	l�&��(�;�u���]/WȄ��=Ug�*lA��ה��|r$���x�y����`��%j(5�\:��;���Bo�O���e_�M$B-��D��k���i�I����	ρݠ�)`Vv;}G���GK�X�5]in��ϧ����Jun?!%�ݱ}(��d��cy��MAz2R��2~�[F�K����-�����-�Ǉ{?������ԟ�dM�;'<��{ɻ��ު/����������Xњ�Z�8�I�/�ԘPɒ��{����V5�.7��!9��ѰD䭁HR���X[{/���59�,#�	��^:��}�!잦� ���#����qq����;$����.���"��QKC�����޿nt�Rt<7�@dep�>/+<�M; ���'pk)> qyw=�3���g�0̙����/ 맦�l�l�����%k|�^i��b�bZy�M����po���-V�p�`=nE��*���o�������
�mIrQ\�0R�^��� J�I�Q�螃��cI�\E5���l�-k���Ϸ���@��A�j��&ؠ��+���A#��W����W��)�\5��OO"�t��*u}},��խ�X�W|@�����XB�Ȫ��f�۷)J(SZ�p�\��V遂% O�P����J��WQ~����|�����8��Û)�{�xo��<�sx������p�3�>L����1f�d��R���y��I��/��R�䳱o���F97J�������\�9����ȅ���l��������O�p�m�铍�2W/���p6�,�LΙ���c:C|�p�������򎌆_�9.��NwuǕ�S�ZY��lu�K�mpY��Vwv;���[��Z]����Y�\��~��c�@�K�u��,�)+'\~�Pv��A֫S4�S�N�#��Ւ�E� �^�ZL�ˢ^�id]��h��oE���K��Oy\~���N���Y/A֫[v�S{������?��ST����:����|�[=���\8\�l��G����_��Lf��꿢��[�;N\E�a�h�u�K��u�8^x�(��2���)���H;̔��94�4:$���40��M���3N�l��Q�#7
�4�K̔�G�c�Q����(��N�X�s���|�	�4�o�:3eO�eBy�w�l6 RQ}1^+'R�����]�kZh$���x�C��Ff�һ�3��[��Hӳ���3e����,��F��d��U�<�D�Yn�%#�U4��g�����?�N������'~����I�R���ٓ�D� ��5a���{���k�`�́�!��6���{�J���|��t'��8��6�f��6�I������X�/������u6�t��]6r����-6r�hS>�l�7l�uڔ�#6rV�������6��`��nS��l�m6r���?�&���Vrl�Ug#�������6�,�	�3d����e�o�0^�V��>:�\���hf���<[�B������Ը�(H�i�UBj\m	'45�P�2��t��Y���j�~��v����˄G[��7�x��]��+�X�6�&|u�����jedҪ�;�@��q��`�=k�|m¢*�
�+X_.=��3W�+��k�5PX>���~�R����c�[���	��\�-D�r��h��حJ8�5	��@�%�׵���Zp�3Yn�ڏB)i�V�r::�v5��EA��M��2Jh%����YI��8���f���V׈����GR�KpB
�����F5�����U#��_��P5%�F[�V���\�x8�K��W�K�]���Ě�x ڢ�b%Y���Zӈ���L�C�%,�H����x,nT��݊����a\���n\[_��1zk�ߨ&�;�5�q_��0#�q�-��_���X(}��1��
��[�-02nQ���w��B����
�-A��97�:~�ʕJ�Ӆ�^Ws��M����,w#�\qU��vV�>��R�]Ud.˝����ߍ���z���q��q��瓫\��%oZ��D����\�N����ܟ�>�m<������s����-C:�����x���@ym��x��6���̼~J8\��C?��w�{`������p!��$������9d�>��x�N�w��N��
x/�SPg�߷A�X6G�� ���5�>��s����9<����b��gs�����h>���Bg�����N�y�0���3ίΦ8���p�����s8ڐ���/��2��6M��b�9����px)��8�K���'r����y���'sx�O��M>��o���8������v���~��������gpx�_��9���p���p�L���r�>���17��ܘscn̍�17����?�OI�;����~�+����~���$ҕ;z'}�W��^B�z����t��������>���1�\�?f�y��������'�-_@�����/"�
�Ox��O �L�/&�D�/!�d��$�����D=�?IϿ�O��o�S���T=����?_Ͽ�O��o���7��z�~����PϿ�_���P����*�}`~���[�������~��'�M�U��,��_+�>�_.��P�/��~��|��8�̿/�o�k������D�_������C7��~�����������������fg�%w�� �����,Ҧ����|}�(L�^��{�R?���,�d�Iנ��W�������NjS@�J���^,>�o����k���F��"�"����6�߽�M�|�N�B�Y_��!��6C\S��oOv�F�֮����=!w�es�<_��׹���ޗ1����wӃq���ϕ}��Ϝ�Zd�{�g%���p���A&�m8�!��S��3��m�Rw��*b���8OzM.�
[h�ʤ0�C"��\C�y��S���:�=��~�u��x_����$x���^ƾ�\����1�ڲ��٫<�Zw�K� ���/>=.|(��,G�h��O��5�hd��B#CW�+�LN�d����zwc*�?�T���H��u=�t���t�H~$�O&iƗ{�2UA2�y��#^K���G޳s�q����qć��A�R�8"����ڞ�\���H����Jt�@
oP>R̸o��$+���Ybs$���Ċq�ߵ�;��)��O��If{%�8NT�SeXD�Sh�s�_�3i삀��n4�����G����A�E�[��5$(#�[����wJw�%N<��2՘�z���1����t��4�U���dd�
��Ew�%�S��q7uO�*�
��%e��# �>(�����=���^a��|����4[-��tڣ7��!�p���K|{�p��Q����1�5���M2�ڦZ@Ty>�G�X0b~��~|�I�wn�E$z�>NWu������ �����'�o���\v��L� �9i��!��E�G�Y]�4���p�4�� ��  B�>��7��q�yC8��������)��������U�A��R?��>�Bt7¯�O�F�.;#c4���Fƞ"e��!����!��o�]�CI�� �nd�7@/��b�% V?��`V��� �D���D�/�̪�R����������#�T?Er�s�[�P����]��;�/��M
b����i��uQt�)R2��hU�Ġ���*<��Z��c.�eG<z�H��ψ<
!S����/�Gj�1�"\p�z惬�ǥ޹}�@7[�O����L��h�	O�mΛ���������9���9�n7�R��>GJajp�q����{����:͓�����!�p'�w0�;f���g��������n�q~��9��%=��L#��A�Q8��j��[m�Lv���,v7[4S�~w�[-��k<�~��D��'���Z5�Ǣ2r��D�E]*#9�lkR㨡[�L��Ũ��pB�r��7K���@@$"G!
٭Fß++	Ҍ�ex/9~$���N�}������@�@���l���Z�A�+`H���A�_��8���ƭA�@�>�瀺��	�7� o;Ѕ@{�����>�Q���&6x�C3P�0C�����t'�ׁ��N�;_��)����0�ag���1_~'�&�9V��xχ~s���J�V�L[S:�ւ���K�U̞���ԃ�̸��q~)��8�{�W� >�iXwH������W�x�j�:����u$'�_M^�����T�%��yP��_rdd�:sr.tr�@�jH�2>�3zx������tC�����+[z�_����2�?�Sx���?�ݿ�3!\�$s>&K���/B����smF����q,�[f9��e��E5�f%/'����z��Ź�
�Tg􉀜�M��˩ͤs�_�%����������d���P�v�C�����oe=�O��r��}��{t.�og�d]��G�ҏ��7�[��]:-��b/�u�ݑ����;���^EknxW�2�#\I���n	}S�˟�^&M�1�ЋR���[|�Q�����8�:��ܘsc�c��~l����oMqvܓg�/�/P��#-����r�U�/��Ae{Z�^U�ߛ�Oٽ���i�΄��M�l/r?�|��tP���b���v���=�ر����f�g��^�y?�����֕��T�Yof˕�yf鳽�,<z��I:Iy?���<�s��o҂>N�l�j���yhѱ��^J�(���vJwP�Ci/�{)�����J)e���(�)uQꥴ�қ)m�t�=��R���>J�)�t�mf�:,x��Wލ���34Zh�������n���:�d���;Pr�6�2�o�
��
xIw�&�v���|c<a�3T΀ g'	�1>1����ߥ��'��<�?���̊�g�-�%k���,��mҽ�iN������8lW/�%,s
�[��
�Vҥ��&"gZָ�B��q���6�}������}���b������t�!��G
qۚ�eT�b�.��9:�l�����B&ؙ�4�ׅ�?uX�^fs�y���9�C�~��R>e�uڞ���ի6�g�s̎�Y��������_|&�)�a=c~��y�wL4�	�y���,���Έ�R���;;Cs���'m��l�i��V��q�>�y:���`+]�^ء/v��%9����<����Bq-7fr�F��k<`�?k���	Y��[��7�?��sE��9��B=_�i~ٻ����.���	>��ƌ��9Nˇ��.)���h�bg�bE�z>d��S�^�/Q9l|�q���X�i�}��@�E��[�����O���0�i�Q�����;�:���%��&|��l�?=Aק�n�I�}h�^����d�+g[��Q�������Z�G�����M�
	���H��Ȭ8�l#gV���%Ybc��>���R�@S�!  �%���A�1,�hmJ�H`۴1�%k§��X<��(kk�����e|�:�[�TԨ߆��M%�lk�Q8N���A5j��#�.L�zgɆ�flk�XY�qE�O�_�Mq(W�oT|~
�WmDʪ�֯��YigSX8F���r����)prdޥ�3�Z T�e���UflI�G���2nn�j�����]��W(��V^�҉�)�`PM$C*1��\��%��M�3�U��c��P(����5����J���RW2W�7�+>l�R�k�_��v+�����O��A��
G�dB�r
#7�0c��/wl��Lix{ f[�f�[$Z�H��ۙ��),�Mt��1Č���3�6;mM������� �9�x<�Jd���d�z�o#4�
EZ�
~q��� ��7���%���3�����'��Gv1��M����M6>�>#0��ly#:gߦ팑�Jq����9V�6�L�0�Hb6�ʈ������Tv�2�]�f,�(��@i�]���go-�j� �sξ��t�@���ʡ�jH��� wF�^�R6b{>���p	�n�@�j<��a0 w�@T�iZ������и���Nm�ŷ?��
�Ɛp��L-	wV�O*M0���ׁ�~��+�[��6;KRY���g5-+��jq��b-�\li�^�9g�Y�3�R�2+F�1���f�[��Y����ȨNM���t�aY���l�e��(��3��.�Q}0�!ۈ�)��}�̘�-?�`@M�p$�0����x�N�Z�V�m�B:���V}���Q��k�^�G4D�<��%F/j��U�١�
��	�5�p�Lf�A�]S�NId��E扙hh-?g:
��K�=���f��K��o���^0s�������b��I���!>{/$����)�}�N�X|��w��?{�+�@�;_��f�كfv�į`��-`���ы��b�߂�w�,>{O�(���(���I.>{�h/���[��]H/S���f���ˏ��A�*ʳ�܌���8��C��Wd3�mP!�]���e�L�/��B��Y���ӟe��H�i!��a(}�7vf�Ϗ������Bx��^@�@�Bx���D�og7�.�_	���f����_⯫4Ӑ^L�2�ưCN�O_�ɑt;r,>{��{���b�RI�;߰+O�3{��B<��@�����肶_hb��$��C콃W'��gd��X2}�����f���+ĿT��z�o�mm�Z}�f��A7��}����~�F^�ӇJ̸8~�}��i��@�0�ax̍�1w*���f_� �  