# Toplevel Pubnub module.
module Pubnub
  # Pubnub client Class
  class Client
    # Module that holds some getters and setters
    module GettersSetters
      def sdk_version
        "PubNub-Ruby/#{Pubnub::VERSION}"
      end

      # Parameters:
      # ===========
      # <dl>
      #   <dt>uuid</dt>
      #   <dd>New uuid to be set.</dd>
      # </dl>
      #
      # Returns:
      # ========
      # New uuid.
      #
      # Functionality:
      # ==============
      # Can't change uuid while subscribed. You have to leave every subscribed channel.
      def change_uuid(uuid)
        Pubnub.logger.debug('Pubnub::Client') { 'Changing uuid' }
        if subscribed?
          fail('Cannot change UUID while subscribed.')
        else
          @env[:uuid] = uuid
        end
      end
      alias_method :session_uuid=, :change_uuid
      alias_method :uuid=, :change_uuid
      alias_method :set_uuid=, :change_uuid

      # Returns:
      # ========
      # Current origin.
      def current_origin
        @env[:origins_pool].first
      end
      alias_method :origin, :current_origin

      # Returns:
      # ========
      # Current client timetoken
      def timetoken
        @env[:timetoken]
      end

      # Retruns:
      # ========
      # Current region or default '0'
      def region_code
        @env[:region_code] || 0
      end

      # Parameters:
      # ===========
      # <dl>
      #   <dt>region</dt>
      #   <dd>New region.</dd>
      # </dl>
      # Returns:
      # ========
      # New region.
      def region_code=(region)
        @env[:region_code] = region
      end

      # Parameters:
      # ===========
      # <dl>
      #   <dt>timetoken</dt>
      #   <dd>New timetoken.</dd>
      # </dl>
      # Returns:
      # ========
      # New timetoken.
      def timetoken=(timetoken)
        @env[:timetoken] = timetoken
      end

      # Returns:
      # ========
      # Current uuid.
      def uuid
        @env[:uuid]
      end

      # Returns:
      # ========
      # Array of all current events.
      # :nocov:
      def events
        @env[:events]
      end
      # :nocov:

      def current_heartbeat
        @env[:heartbeat].to_i
      end

      def heartbeat=(value)
        @env[:heartbeat] = value
      end

      def subscribe_filter=(filter_expr)
        @env[:subscribe_filter] = filter_expr
        @subscriber.reset if subscribed?
        filter_expr
      end

      def subscribe_filter
        @env[:subscribe_filter]
      end
    end
  end
end