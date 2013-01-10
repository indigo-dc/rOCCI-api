require 'rspec'
require 'occi'

module Occi
  module Api
    module Client

    vcr_options = { :record => :new_episodes }
    describe ClientHttp, :vcr => vcr_options do

      context "using media type text/plain" do

        before(:each) do
          @client = Occi::Api::Client::ClientHttp.new(
           'https://localhost:3300',
           { :type  => "none" },
           { :out   => "/dev/null",
             :level => Occi::Log::DEBUG },
           true,
           "text/plain,text/occi"
          )
        end

        after(:each) do
          @client.logger.close
        end

        it "should establish connection" do
          @client.connected.should be_true
        end

        it "should instantiate a compute resource" do
          @client.get_resource "compute"
          @client.get_resource "http://schemas.ogf.org/occi/infrastructure#compute"
        end

        it "should instantiate a network resource" do
          @client.get_resource "network"
          @client.get_resource "http://schemas.ogf.org/occi/infrastructure#network"
        end

        it "should instantiate a storage resource" do
          @client.get_resource "storage"
          @client.get_resource "http://schemas.ogf.org/occi/infrastructure#storage"
        end

        it "should list all available resource types" do
          @client.get_resource_types
        end

        it "should list all available resource type identifiers" do
          @client.get_resource_type_identifiers
        end

        it "should list all available entity types" do
          @client.get_entity_types
        end

        it "should list all available entity type identifiers" do
          @client.get_entity_type_identifiers
        end

        it "should list all available link types" do
          @client.get_link_types
        end

        it "should list all available link type identifiers" do
          @client.get_link_type_identifiers
        end

        it "should list all available mixin types" do
          @client.get_mixin_types
        end

        it "should list all available mixin type identifiers" do
          @client.get_mixin_type_identifiers
        end

        it "should list compute resources" do
          @client.list "compute"
        end

        it "should list network resources" do
          @client.list "network"
        end

        it "should list storage resources" do
          @client.list "storage"
        end

        it "should list all available mixins" do
          @client.get_mixins
        end

        it "should list os_tpl mixins" do
          @client.get_mixins "os_tpl"
        end

        it "should list resource_tpl mixins" do
          @client.get_mixins "resource_tpl"
        end

        it "should describe compute resources" do
          @client.describe "compute"
        end

        it "should describe network resources" do
          @client.describe "network"
        end

        it "should describe storage resources" do
          @client.describe "storage"
        end

        it "should describe all available mixins" do
          @client.get_mixins.each do |mixin|
            mixin_short = mixin.split("/").last
            @client.find_mixin mixin_short.split("#").last, mixin_short.split("#").first, true
          end
        end

        it "should describe os_tpl mixins" do
          @client.get_mixins("os_tpl").each do |mixin|
            mixin_short = mixin.split("/").last
            @client.find_mixin mixin_short.split("#").last, "os_tpl", true
          end
        end

        it "should describe resource_tpl mixins" do
          @client.get_mixins("resource_tpl").each do |mixin|
            mixin_short = mixin.split("/").last
            @client.find_mixin mixin_short.split("#").last, "resource_tpl", true
          end
        end

        it "should create a new compute resource"

        it "should create a new storage resource"

        it "should create a new network resource"

        it "should deploy an instance based on OVF/OVA file"

        it "should delete a compute resource"

        it "should delete a network resource"

        it "should delete a storage resource"

        it "should trigger an action on a compute resource"

        it "should trigger an action on a storage resource"

        it "should trigger an action on a network resource"

        it "should refresh its model" do
          @client.refresh
        end

      end

      context "using media type application/occi+json" do

        before(:each) do
          #@client = Occi::Api::ClientHttp.new(
          #  'https://localhost:3300',
          #  { :type  => "none" },
          #  { :out   => "/dev/null",
          #    :level => Occi::Log::DEBUG },
          #  true,
          #  "application/occi+json"
          #)
        end

        it "should establish connection"

        it "should list compute resources"

        it "should list network resources"

        it "should list storage resources"

        it "should list all available mixins"

        it "should list os_tpl mixins"

        it "should list resource_tpl mixins"

        it "should describe compute resources"

        it "should describe network resources"

        it "should describe storage resources"

        it "should describe all available mixins"

        it "should describe os_tpl mixins"

        it "should describe resource_tpl mixins"

        it "should create a new compute resource"

        it "should create a new storage resource"

        it "should create a new network resource"

        it "should delete a compute resource"

        it "should delete a network resource"

        it "should delete a storage resource"

        it "should trigger an action on a compute resource"

        it "should trigger an action on a storage resource"

        it "should trigger an action on a network resource"

        it "should refresh its model"

      end
    end

    end
  end
end
