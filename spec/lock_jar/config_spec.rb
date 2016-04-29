require 'spec_helper'

describe LockJar::Config do
  describe '.load_config_file' do
    let(:test_config_file) { File.join('spec', 'fixtures', 'lock_jar_config.yml') }
    let(:config) { described_class.load_config_file }
    let(:expected_repo_config) do
      {
        'https://some.fancy.doman/maven' => {
          'username' => 'user1',
          'password' => 'the_pass'
        }
      }
    end

    context 'using current dir config' do
      before do
        FileUtils.cp(test_config_file, File.join(Dir.pwd, described_class::DEFAULT_FILENAME))
      end

      it 'should have a repository config' do
        expect(config.repositories).to eq(expected_repo_config)
      end
    end

    context 'using home dir config' do
      before do
        FileUtils.rm(File.join(Dir.pwd, described_class::DEFAULT_FILENAME))
        FileUtils.cp(test_config_file, File.join(Dir.home, described_class::DEFAULT_FILENAME))
      end

      it 'should have a repository config' do
        expect(config.repositories).to eq(expected_repo_config)
      end
    end

    context 'using ENV path to config' do
      before do
        ENV[described_class::CONFIG_ENV] = File.join(Dir.pwd, described_class::DEFAULT_FILENAME)
      end

      it 'should have a repository config' do
        expect(config.repositories).to eq(expected_repo_config)
      end
    end
  end
end
