require 'minitest/autorun'
require File.expand_path(File.dirname(__FILE__) + "/../lib/meg-jsontoolkit")


class MegJsontoolkitTest < MiniTest::Unit::TestCase
  def test_color_with_pound
    assert_equal '#abcdef', Meg::Jsontoolkit.color_with_pound('#abcdef')
    assert_equal '#abcdef', Meg::Jsontoolkit.color_with_pound('abcdef')
    assert_equal '', Meg::Jsontoolkit.color_with_pound('')
    assert_equal '', Meg::Jsontoolkit.color_with_pound(1)
    assert_equal '', Meg::Jsontoolkit.color_with_pound(nil)
  end

  def test_base64_encode_file
    non_existing = 'fsdkknlaf'
    file         = '/etc/passwd'
    dir          = '/etc/'

    assert_nil Meg::Jsontoolkit.base64_encode_file(non_existing)

    assert_instance_of String, Meg::Jsontoolkit.base64_encode_file(file)
    assert !Meg::Jsontoolkit.base64_encode_file(file).empty?
    assert_match Meg::Jsontoolkit.base64_encode_file(file), /^data:.*base64/
    refute_match Meg::Jsontoolkit.base64_encode_file(file), /\n/
    refute_nil Meg::Jsontoolkit.base64_encode_file(file)

    assert_nil Meg::Jsontoolkit.base64_encode_file(dir)
    assert_nil Meg::Jsontoolkit.base64_encode_file(nil)
  end

  def test_url_with_asset_host
    host = 'https://FOBI2012-api.mobileeventguide.de'
    assert_equal 'https://FOBI2012-api.mobileeventguide.de/assets/documents/5/original/asset.pdf?12312311',
      Meg::Jsontoolkit.url_with_asset_host('assets/documents/5/original/asset.pdf?12312311', host )

    assert_equal 'https://FOBI2012-api.mobileeventguide.de/assets/documents/5/original/asset.pdf?12312311',
      Meg::Jsontoolkit.url_with_asset_host('https://FOBI2012-api.mobileeventguide.de/assets/documents/5/original/asset.pdf?12312311', host )
  end

  def test_relation_json
    result = {:table=>"moderators", :uuids=>[1, 2, 3]}
    input = {:key => 'moderators', :collection => [1,2,3]}

    hash = Meg::Jsontoolkit.relation_json(input[:key], input[:collection])
    assert_kind_of Hash, hash
    assert_equal result, hash

    input = {:key => nil, :collection => [1,2,3]}
    hash = Meg::Jsontoolkit.relation_json(input[:key], input[:collection])
    assert_kind_of Hash, hash
    assert_equal {}, hash

    input = {:key => 'fasd', :collection => nil}
    hash = Meg::Jsontoolkit.relation_json(input[:key], input[:collection])
    assert_kind_of Hash, hash
    assert_equal {}, hash

    input = {:key => 'fasd', :collection => []}
    hash = Meg::Jsontoolkit.relation_json(input[:key], input[:collection])
    assert_kind_of Hash, hash
    assert_equal {}, hash

    input = {:key => '', :collection => [1,2,3]}
    hash = Meg::Jsontoolkit.relation_json(input[:key], input[:collection])
    assert_kind_of Hash, hash
    assert_equal {}, hash
  end                                         

end
