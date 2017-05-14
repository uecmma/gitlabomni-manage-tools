# frozen_string_literal: true

require 'erb'
require 'ostruct'
require 'socket'

module GitLabOmnibusManage
  module Util
    module_function

    def deep_merge_hash(base, ext, oldbase = true)
      base.merge(ext) do |_k, oldv, newv|
        if oldv.is_a?(Hash) && newv.is_a?(Hash)
          deep_merge_hash(oldv, newv, oldbase)
        elsif oldbase
          oldv
        else
          newv
        end
      end
    end

    class DeepOpenStruct < OpenStruct
      def self.openstruct_hash(hash)
        nhash = {}
        hash.each do |k, v|
          nhash[k] =
            if v.is_a?(Hash)
              DeepOpenStruct.new(v)
            else
              v
            end
        end

        nhash
      end

      def initialize(hash = nil)
        newarg =
          if hash.is_a?(Hash)
            DeepOpenStruct.openstruct_hash(hash)
          else
            hash
          end

        super(newarg)
      end
    end

    class ErbRenderer < DeepOpenStruct
      def render(template)
        ERB.new(template).result(binding)
      end
    end

    def render_erb_template(template, hash)
      ErbRenderer.new(hash).render(template)
    end

    def hostfullname
      Socket.gethostbyname(Socket.gethostname).first
    rescue
      'localhost'
    end
  end
end
