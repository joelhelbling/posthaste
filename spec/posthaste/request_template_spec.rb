require 'yaml'

RSpec.describe Posthaste::RequestTemplate do
  Given(:yaml_file) { './spec/fixtures/example_request_template.yml' }
  Given(:yaml) do
    YAML.load(<<~YAML)
      name: create article
      method: POST
      endpoint: /posts
      parameter_defaults:
        query_string:
          version: 9.9
        header:
          Content-Type: application/json
        body:
          text: Lorem ipsum
      required_parameters:
        query_string:
          - author
          - topic
        header:
          - Authorization
        body:
          - title
          - text
      body_template: |
        {
          "article_title": "<%= title %>",
          "article_body": "<%= text %>"
        }
    YAML
  end

  When(:subject) { described_class.new yaml }

  describe '#name' do
    Then { subject.name == 'create article' }
  end

  describe '#http_method' do
    context 'with GET' do
      Given { yaml['method'] = 'GET' }
      Then { subject.http_method == 'GET' }
    end

    context 'with HEAD' do
      Given { yaml['method'] = 'HEAD' }
      Then { subject.http_method == 'HEAD' }
    end

    context 'with POST' do
      Then { subject.http_method == 'POST' }
    end

    context 'with PUT' do
      Given { yaml['method'] = 'PUT' }
      Then { subject.http_method == 'PUT' }
    end

    context 'with DELETE' do
      Given { yaml['method'] = 'DELETE' }
      Then { subject.http_method == 'DELETE' }
    end

    context 'with CONNECT' do
      Given { yaml['method'] = 'CONNECT' }
      Then { subject.http_method == 'CONNECT' }
    end

    context 'with OPTIONS' do
      Given { yaml['method'] = 'OPTIONS' }
      Then { subject.http_method == 'OPTIONS' }
    end

    context 'with TRACE' do
      Given { yaml['method'] = 'TRACE' }
      Then { subject.http_method == 'TRACE' }
    end

    context 'with PATCH' do
      Given { yaml['method'] = 'PATCH' }
      Then { subject.http_method == 'PATCH' }
    end

    context 'with an illegal method' do
      Given { yaml['method'] = 'DANCE' }
      Then { subject.http_method == 'GET' }
    end

    context 'with nil' do
      Given { yaml.delete 'method' }
      Then { subject.http_method == 'GET' }
    end
  end

  describe '#endpoint' do
    context 'with endpoint defined' do
      Then { subject.endpoint == '/posts' }
    end

    context 'with default' do
      Given { yaml.delete 'endpoint' }
      Then { subject.endpoint == '/' }
    end
  end

  describe '#query_string_defaults' do
    context 'with parameters' do
      Then { subject.query_string_defaults == { 'version' => 9.9 } }
    end

    context 'without default query string parameters' do
      Given { yaml['parameter_defaults'].delete 'query_string' }
      Then { subject.query_string_defaults == {} }
    end

    context 'without default parameters' do
      Given { yaml.delete 'parameter_defaults' }
      Then { subject.query_string_defaults == {} }
    end
  end

  describe '#header_defaults' do
    context 'with parameters' do
      Then do
        subject.header_defaults == { 'Content-Type' => 'application/json' }
      end
    end

    context 'without default header parameters' do
      Given { yaml['parameter_defaults'].delete 'header' }
      Then { subject.header_defaults == {} }
    end

    context 'without default parameters' do
      Given { yaml.delete 'parameter_defaults' }
      Then { subject.header_defaults == {} }
    end
  end

  describe '#body_defaults' do
    context 'with parameters' do
      Then do
        subject.body_defaults == { 'text' => 'Lorem ipsum' }
      end
    end

    context 'without default header parameters' do
      Given { yaml['parameter_defaults'].delete 'body' }
      Then { subject.body_defaults == {} }
    end

    context 'without default parameters' do
      Given { yaml.delete 'parameter_defaults' }
      Then { subject.body_defaults == {} }
    end
  end

  describe '#query_string_required' do
    context 'with parameters' do
      Then { subject.query_string_required == ['author', 'topic'] }
    end

    context 'without required query string parameters' do
      Given { yaml['required_parameters'].delete 'query_string' }
      Then { subject.query_string_required == [] }
    end

    context 'without required parameters' do
      Given { yaml.delete 'required_parameters' }
      Then { subject.query_string_required == [] }
    end
  end

  describe '#header_required' do
    context 'with required parameters' do
      Then { subject.header_required == ['Authorization'] }
    end

    context 'without header required parameters' do
      Given { yaml['required_parameters'].delete 'header' }
      Then { subject.header_required == [] }
    end

    context 'without required parameters' do
      Given { yaml.delete 'required_parameters' }
      Then { subject.header_required == [] }
    end
  end

  describe '#body_required' do
    context 'with required parameters' do
      Then { subject.body_required == ['title', 'text'] }
    end

    context 'without body required parameters' do
      Given { yaml['required_parameters'].delete 'body' }
      Then { subject.body_required == [] }
    end

    context 'without required parameters' do
      Given { yaml.delete 'required_parameters' }
      Then { subject.body_required == [] }
    end
  end

  describe '#body_template' do
    context 'with defined' do
      Then do
        expect(subject.body_template).to eq(<<~JSON)
          {
            "article_title": "<%= title %>",
            "article_body": "<%= text %>"
          }
        JSON
      end
    end

    context 'with default' do
      Given { yaml.delete 'body_template' }
      Then { subject.body_template == '' }
    end
  end
end
