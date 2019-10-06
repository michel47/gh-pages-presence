#

tic=$(date +%s)
qm=$(ipfs add -Q -r .)
echo $tic: $qm >> qm.log
ipfs files rm -r /my/documents/PDFs
ipfs files cp /ipfs/$qm /my/documents/PDFs
echo url: http://127.0.0.1:8080/ipfs/$qm
cat <<EOF > ../_data/docs.yml
--- # PDFs documents
# \$Source: /my/documents/PDFs/ \$
qm: $qm
url: http://ipfs.blockring™.ml/ipfs/$qm
tic: $tic
EOF
