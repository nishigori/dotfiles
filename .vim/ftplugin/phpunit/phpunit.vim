setlocal omnifunc=phpcomplete#CompletePHP

let g:php_sql_query     = 1  " 文字列中のSQLをハイライト
let g:php_htmlInStrings = 1  " 文字列中のHTMLをハイライトする
"let php_folding=1      " クラスと関数のfoldingを有効
"setlocal foldlevelstart=1 " open buffer's foldlevel

" Set tags for PHPUnit sources
let s:phpunit_tags = get(g:, 'dependency_local_lists["phpunit_dir"]', '')
if s:phpunit_tags != ''
  execute 'setlocal tags+='.s:phpunit_tags.'/tags'
endif

if !exists('g:my_config_use_plugin') || !g:my_config_use_plugin
  finish
endif

" Plugin: vim-sunday "{{{
let g:sunday_pairs = [
  \   ['extends', 'implements'],
  \   ['assert', 'depends', 'dataProvider', 'expectedException', 'group', 'test'],
  \   ['assertArrayHasKey', 'assertArrayNotHasKey'],
  \   ['assertArrayNotHasKey' , 'assertArrayHasKey'],
  \   ['assertClassHasAttribute', 'assertClassNotHasAttribute'],
  \   ['assertClassNotHasAttribute', 'assertClassHasAttribute'],
  \   ['assertClassHasStaticAttribute', 'assertClassNotHasStaticAttribute'],
  \   ['assertClassNotHasStaticAttribute', 'assertClassHasStaticAttribute'],
  \   ['assertContains', 'assertNotContains'],
  \   ['assertNotContains', 'assertContains'],
  \   ['assertAttributeContains', 'assertAttributeNotContains'],
  \   ['assertAttributeNotContains', 'assertAttributeContains'],
  \   ['assertContainsOnly', 'assertNotContainsOnly'],
  \   ['assertNotContainsOnly', 'assertContainsOnly'],
  \   ['assertAttributeContainsOnly', 'assertAttributeNotContainsOnly'],
  \   ['assertAttributeNotContainsOnly', 'assertAttributeContainsOnly'],
  \   ['assertEmpty', 'assertNotEmpty'],
  \   ['assertNotEmpty', 'assertEmpty'],
  \   ['assertAttributeEmpty', 'assertAttributeNotEmpty'],
  \   ['assertAttributeNotEmpty', 'assertAttributeEmpty'],
  \   ['assertEquals', 'assertNotEquals'],
  \   ['assertNotEquals', 'assertEquals'],
  \   ['assertAttributeEquals', 'assertAttributeNotEquals'],
  \   ['assertAttributeNotEquals', 'assertAttributeEquals'],
  \   ['assertFileEquals', 'assertFileNotEquals'],
  \   ['assertFileNotEquals', 'assertFileEquals'],
  \   ['assertFileExists', 'assertFileNotExists'],
  \   ['assertFileNotExists', 'assertFileExists'],
  \   ['assertInstanceOf', 'assertNotInstanceOf'],
  \   ['assertNotInstanceOf', 'assertInstanceOf'],
  \   ['assertAttributeInstanceOf', 'assertAttributeNotInstanceOf'],
  \   ['assertAttributeNotInstanceOf', 'assertAttributeInstanceOf'],
  \   ['assertInternalType', 'assertNotInternalType'],
  \   ['assertNotInternalType', 'assertInternalType'],
  \   ['assertAttributeInternalType', 'assertAttributeNotInternalType'],
  \   ['assertAttributeNotInternalType', 'assertAttributeInternalType'],
  \   ['assertNull', 'assertNotNull'],
  \   ['assertNotNull', 'assertNull'],
  \   ['assertObjectHasAttribute', 'assertObjectNotHasAttribute'],
  \   ['assertObjectNotHasAttribute', 'assertObjectHasAttribute'],
  \   ['assertRegExp', 'assertNotRegExp'],
  \   ['assertNotRegExp', 'assertRegExp'],
  \   ['assertStringMatchesFormat', 'assertStringNotMatchesFormat'],
  \   ['assertStringNotMatchesFormat', 'assertStringMatchesFormat'],
  \   ['assertStringMatchesFormatFile', 'assertStringNotMatchesFormatFile'],
  \   ['assertStringNotMatchesFormatFile', 'assertStringMatchesFormatFile'],
  \   ['assertSame', 'assertNotSame'],
  \   ['assertNotSame', 'assertSame'],
  \   ['assertAttributeSame', 'assertAttributeNotSame'],
  \   ['assertAttributeNotSame', 'assertAttributeSame'],
  \   ['assertStringEndsWith', 'assertStringEndsNotWith'],
  \   ['assertStringEndsNotWith', 'assertStringEndsWith'],
  \   ['assertStringEqualsFile', 'assertStringNotEqualsFile'],
  \   ['assertStringNotEqualsFile', 'assertStringEqualsFile'],
  \   ['assertStringStartsWith', 'assertStringStartsNotWith'],
  \   ['assertStringStartsNotWith', 'assertStringStartsWith'],
  \   ['assertTag', 'assertNotTag'],
  \   ['assertNotTag', 'assertTag'],
  \   ['assertAttributeType', 'assertAttributeNotType'],
  \   ['assertAttributeNotType', 'assertAttributeType'],
  \   ['assertXmlFileEqualsXmlFile', 'assertXmlFileNotEqualsXmlFile'],
  \   ['assertXmlFileNotEqualsXmlFile', 'assertXmlFileEqualsXmlFile'],
  \   ['assertXmlStringEqualsXmlFile', 'assertXmlStringNotEqualsXmlFile'],
  \   ['assertXmlStringNotEqualsXmlFile', 'assertXmlStringEqualsXmlFile'],
  \   ['assertXmlStringEqualsXmlString', 'assertXmlStringNotEqualsXmlString'],
  \   ['assertXmlStringNotEqualsXmlString', 'assertXmlStringEqualsXmlString'],
  \ ]
  " Not into removed PHPUnit 3.6 functions. (ex. asertType, assertNotType)
"}}}

" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
