" call ale#linter#Define('ruby', {
" \   'name': 'sorbet-lsp',
" \   'lsp': 'stdio',
" \   'executable': 'true',
" \   'command': 'bundle exec srb typecheck -v --lsp --disable-watchman',
" \   'language': 'ruby',
" \   'project_root': '/Users/timuruski/workspace/clio/billing-service',
" \})
