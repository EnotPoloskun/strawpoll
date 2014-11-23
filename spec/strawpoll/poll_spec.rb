require 'spec_helper'

describe Strawpoll::Poll do
  context 'Instance methods' do
    describe '#save' do
      let(:poll) { Strawpoll::Poll.new(options: ["Option1", "Option2"], title: 'Poll') }

      before do
        stub_request(:post, "strawpoll.me/api/v2/polls").to_return(body: { id: 1234 }, status: 200)
      end

      it 'should assign id after save' do
        poll.save.id.should eq(1234)
      end
    end

    describe '#vote' do
    end
  end

  context 'Class methods' do
    describe '#get' do
      context 'Valid params' do
        it 'should return poll' do
          expect { Strawpoll::Poll.get('1234') }.to be_an_instance_of(Strawpoll::Poll)
        end

        it 'should return poll with certain options' do
          Strawpoll::Poll.get('1234').options.should eq ['Option1', 'Option2', 'Option3']
        end
      end

      context 'Invalid params' do
        it do
          expect { Strawpoll::Poll.get }.to raise_error(ArgumentError)
        end
      end

      context 'Api error' do
        it do
          expect { Strawpoll::Poll.get('1234') }.to raise_error(Strawpoll::APIError)
        end
      end
    end

    describe '#create' do
      context 'Valid params' do
        before do
          stub_request(:post, "strawpoll.me/api/v2/polls").to_return(body: { id: 1234 }, status: 200)
        end

        it 'should return poll' do
          expect {
            Strawpoll::Poll.create(options: ['Option1', 'Options2', 'Options3'], title: 'title', multi: false)
          }.to be_an_instance_of(Strawpoll::Poll)
        end
      end

      context 'Invalid params' do
        it do
          expect {
            Strawpoll::Poll.create(options: ['Option1', 'Options2', 'Options3'], multi: false)
          }.to raise_error(ArgumentError)
        end
      end

      context 'Api error' do
        before do
          stub_request(:post, "strawpoll.me/api/v2/polls").to_return(body: { error: true }, status: 400)
        end

        it do
          expect {
            Strawpoll::Pol.create(options: ['Option1', 'Options2', 'Options3'], title: 'title', multi: false)
          }.to raise_error(Strawpoll::APIError)
        end
      end
    end
  end
end
