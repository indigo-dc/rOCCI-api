module Occi::Api::Client
  module Base

    module EntityMethods

      # Creates a new resource instance, resource should be specified
      # by its name or identifier.
      #
      # @example
      #   client.get_resource "compute" # => Occi::Core::Resource
      #   client.get_resource "storage" # => Occi::Core::Resource
      #   client.get_resource "http://schemas.ogf.org/occi/infrastructure#network"
      #    # => Occi::Core::Resource
      #
      # @param [String] resource name or resource identifier
      # @return [Occi::Core::Resource] new resource instance
      def get_resource(resource_type)
        Occi::Log.debug("Instantiating #{resource_type.inspect}")

        type_id = get_resource_type_identifier(resource_type)
        raise "Unknown resource type! #{resource_type.inspect}" unless type_id

        new_resource = Occi::Core::Resource.new(type_id)
        new_resource.model = @model

        new_resource
      end

      # Retrieves all available entity types.
      #
      # @example
      #    client.get_entity_types # => [ "entity", "resource", "link" ]
      #
      # @return [Array<String>] list of available entity types in a human-readable format
      def get_entity_types
        collection = @model.get(Occi::Core::Entity.kind.type_identifier)
        collection.kinds.to_a.collect { |kind| kind.term }
      end

      # Retrieves all available entity type identifiers.
      #
      # @example
      #    client.get_kind_type_identifiers
      #    # => [ "http://schemas.ogf.org/occi/core#entity",
      #    #      "http://schemas.ogf.org/occi/core#resource",
      #    #      "http://schemas.ogf.org/occi/core#link" ]
      #
      # @return [Array<String>] list of available entity types in a OCCI ID format
      def get_entity_type_identifiers
        get_kind_type_identifiers_related_to Occi::Core::Entity.kind.type_identifier
      end

      # Retrieves available entity type identifier for the given entity type.
      #
      # @example
      #    client.get_entity_type_identifier("compute")
      #     # => 'http://schemas.ogf.org/occi/infrastructure#compute'
      #
      # @return [String, nil] entity type identifier for the given entity type
      def get_entity_type_identifier(type)
        return type if (type =~ URI::ABS_URI) || (type && type.start_with?('/'))

        collection = @model.get(Occi::Core::Entity.kind.type_identifier)
        e_kinds = collection.kinds.to_a.select { |e| e.term == type }
        tis = e_kinds.collect { |e| e.type_identifier }
        tis.uniq!

        if tis.length > 1
          raise Occi::Api::Client::Errors::AmbiguousNameError,
                "Entity type #{type.inspect} is ambiguous, use a type identifier!"
        end

        tis.first
      end

      # Retrieves all available resource types.
      #
      # @example
      #    client.get_resource_types # => [ "compute", "storage", "network" ]
      #
      # @return [Array<String>] list of available resource types in a human-readable format
      def get_resource_types
        collection = @model.get(Occi::Core::Resource.kind.type_identifier)
        collection.kinds.to_a.collect { |kind| kind.term }
      end

      # Retrieves all available resource type identifiers.
      #
      # @example
      #    client.get_resource_type_identifiers
      #    # => [ "http://schemas.ogf.org/occi/infrastructure#compute",
      #    #      "http://schemas.ogf.org/occi/infrastructure#storage",
      #    #      "http://schemas.ogf.org/occi/infrastructure#network" ]
      #
      # @return [Array<String>] list of available resource types in a Occi ID format
      def get_resource_type_identifiers
        get_kind_type_identifiers_related_to Occi::Core::Resource.kind.type_identifier
      end

      # Retrieves available resource type identifier for the given resource type.
      #
      # @example
      #    client.get_resource_type_identifier("compute")
      #     # => 'http://schemas.ogf.org/occi/infrastructure#compute'
      #
      # @return [String, nil] resource type identifier for the given resource type
      def get_resource_type_identifier(type)
        return type if (type =~ URI::ABS_URI) || (type && type.start_with?('/'))

        collection = @model.get(Occi::Core::Resource.kind.type_identifier)
        r_kinds = collection.kinds.to_a.select { |r| r.term == type }
        tis = r_kinds.collect { |r| r.type_identifier }
        tis.uniq!

        if tis.length > 1
          raise Occi::Api::Client::Errors::AmbiguousNameError,
                "Resource type #{type.inspect} is ambiguous, use a type identifier!"
        end

        tis.first
      end

      # Retrieves all available link types.
      #
      # @example
      #    client.get_link_types # => [ "storagelink", "networkinterface" ]
      #
      # @return [Array<String>] list of available link types in a human-readable format
      def get_link_types
        collection = @model.get(Occi::Core::Link.kind.type_identifier)
        collection.kinds.to_a.collect { |kind| kind.term }
      end

      # Retrieves all available link type identifiers.
      #
      # @example
      #    client.get_link_type_identifiers
      #    # => [ "http://schemas.ogf.org/occi/infrastructure#storagelink",
      #    #      "http://schemas.ogf.org/occi/infrastructure#networkinterface" ]
      #
      # @return [Array<String>] list of available link types in a OCCI ID format
      def get_link_type_identifiers
        get_kind_type_identifiers_related_to Occi::Core::Link.kind.type_identifier
      end

      # Retrieves available link type identifier for the given link type.
      #
      # @example
      #    client.get_link_type_identifier("storagelink")
      #     # => 'http://schemas.ogf.org/occi/infrastructure#storagelink'
      #
      # @return [String, nil] link type identifier for the given link type
      def get_link_type_identifier(type)
        return type if (type =~ URI::ABS_URI) || (type && type.start_with?('/'))

        collection = @model.get(Occi::Core::Link.kind.type_identifier)
        l_kinds = collection.kinds.to_a.select { |r| r.term == type }
        tis = l_kinds.collect { |r| r.type_identifier }
        tis.uniq!

        if tis.length > 1
          raise Occi::Api::Client::Errors::AmbiguousNameError,
                "Link type #{type.inspect} is ambiguous, use a type identifier!"
        end

        tis.first
      end

    end

  end
end