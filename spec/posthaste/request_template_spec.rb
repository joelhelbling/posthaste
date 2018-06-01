require 'yaml'

RSpec.describe Posthaste::RequestTemplate do
  Given(:yaml_file) { './spec/fixtures/example_request_template.yml' }
  Given(:yaml) { YAML.load(File.read(yaml_file)) }
  Given(:subject) { described_class.new yaml }

  Then { subject.name == 'create article' }
  Then { subject.http_method == 'POST' }
  Then { subject.endpoint == '/posts' }
  Then { subject.header_defaults == { 'Content-Type' => 'application/json' } }
  Then { subject.query_string_required == ['author', 'topic'] }
  Then { subject.header_required == ['Authorization'] }
  Then { subject.body_required == ['title', 'text'] }
  Then do
    expect(subject.body_template).to eq(<<~JSON.chomp)
      {
        "article_title": "<%= title %>",
        "article_body": "<%= text %>"
      }
    JSON
  end
end
