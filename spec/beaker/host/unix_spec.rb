require 'spec_helper'

module Unix
  describe Host do
    let(:options)  { @options ? @options : {} }
    let(:platform) do
      if @platform
        { :platform => Beaker::Platform.new(@platform) }
      else
        { :platform => Beaker::Platform.new('el-vers-arch-extra') }
      end
    end
    let(:host)    { make_host('name', options.merge(platform)) }
    let(:opts)    { { :download_url => 'download_url' } }

    describe '#external_copy_base' do
      it 'returns /root in general' do
        copy_base = host.external_copy_base
        expect(copy_base).to be === '/root'
      end

      it 'returns /root if solaris but not version 10' do
        @platform = 'solaris-11-arch'
        copy_base = host.external_copy_base
        expect(copy_base).to be === '/root'
      end

      it 'returns / if on a solaris 10 platform' do
        @platform = 'solaris-10-arch'
        copy_base = host.external_copy_base
        expect(copy_base).to be === '/'
      end
    end

    describe '#determine_ssh_server' do
      it 'returns :openssh' do
        expect(host.determine_ssh_server).to be === :openssh
      end
    end
  end
end
