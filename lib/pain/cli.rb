# frozen_string_literal: true

require 'optparse'

module Pain
  class Cli
    using Pain::ColorStrings

    def initialize
      @options = {}
      @model = Pain::Model.new
      @option_parser = Options.create(@options, @model)
    end

    def run!
      @option_parser.parse!

      %i[bug_type likelihood impact].each { |input| fill_question(input) }

      puts
      print_report_for options
    end

    private

    attr_reader :model, :options, :option_parser

    def fill_question(input, first: true)
      return unless options[input].nil?

      ask_question_for input
      display_choices_for(input) if first

      response       = gets.chomp
      options[input] = model.normalize(response, input)

      fill_question(input, first: false) if options[input].nil?
    end

    def get_color(value)
      offset = case value
               when :trivial
                 40
               when :minor
                 69
               when :standard
                 184
               when :major
                 202
               when :critical
                 9
               else
                 252
               end
      Term::ANSIColor::Attribute[offset]
    end

    def case_danger(danger)
      if danger < 0.21
        :trivial
      elsif danger < 0.41
        :minor
      elsif danger < 0.65
        :standard
      elsif danger < 0.81
        :major
      else
        :critical
      end
    end

    def total_danger(danger)
      if danger < 21
        :trivial
      elsif danger < 31
        :minor
      elsif danger < 51
        :standard
      elsif danger < 75
        :major
      else
        :critical
      end
    end

    def color_output(msg, danger = :normal)
      level = case danger
              when :normal
                :default
              when Symbol
                danger
              else
                case_danger(danger)
              end
      puts msg.color(get_color(level))
    end

    def display_choices_for(input)
      choices = model.choices_for(input)
      ceiling = choices.count
      choices.each do |v, msg|
        color_output("#{v}: #{msg}", (v / ceiling.to_f))
      end
      puts
    end

    def ask_question_for(input)
      color_output model.input_message(input)
    end

    # rubocop:disable Metrics/AbcSize
    def print_report_for(scores)
      pain = model.user_pain(scores[:bug_type], scores[:likelihood], scores[:impact])

      levels = scores.each_with_object({}) do |(input, level), hash|
        hash[input] = case_danger(level.to_f / model.max_for(input))
      end

      color_output "Type:       #{scores[:bug_type]} - #{model.level_string(:bug_type, scores[:bug_type])}",
                   levels[:bug_type]
      color_output "Likelihood: #{scores[:likelihood]} - #{model.level_string(:likelihood, scores[:likelihood])}",
                   levels[:likelihood]
      color_output "Impact:     #{scores[:impact]} - #{model.level_string(:impact, scores[:impact])}", levels[:impact]
      puts
      color_output "User Pain: #{pain}", total_danger(pain)
    end
    # rubocop:enable Metrics/AbcSize
  end

  # rubocop:disable Metrics/MethodLength
  class Options
    def self.create(options, model)
      OptionParser.new do |opts|
        opts.on(
          '-l',
          '--likelihood [LIKELIHOOD]',
          OptionParser::DecimalInteger,
          model.input_message(:likelihood)
        ) do |like|
          options[:likelihood] = model.normalize(like, :likelihood)
        end

        opts.on(
          '-i',
          '--impact [IMPACT]',
          OptionParser::DecimalInteger,
          model.input_message(:impact)
        ) do |impact|
          options[:impact] = model.normalize(impact, :impact)
        end

        opts.on(
          '-t',
          '--type [TYPE]',
          OptionParser::DecimalInteger,
          model.input_message(:bug_type)
        ) do |bug_type|
          options[:bug_type] = model.normalize(bug_type, :bug_type)
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
end
