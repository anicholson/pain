require 'pain/version'
require 'optparse'
require 'ostruct'

module Pain
  MAX  = {
    bug_type:   7,
    likelihood: 5,
    impact:     5
  }

  INPUT_MESSAGE  = {
    bug_type:   'What kind of bug is this?',
    likelihood: 'How likely is this bug to occur?',
    impact:     'How much impact will this bug have?'
  }

  OPTIONS = {
    bug_type: {
      1 => 'Documentation: a documentation issue',
      2 => 'Localization: missing translations',
      3 => 'Visual Polish: Aesthetic issues',
      4 => 'Balancing: allows poor usage strategy',
      5 => 'Minor UX: Impairs UX in secondary scenarios',
      6 => 'Major UX: Impairs UX in key scenarios',
      7 => 'Crash: Causes crash or data loss'
    },
    likelihood: {
      1 => 'Will affect almost no one',
      2 => 'Will only affect a few users',
      3 => 'Will affect average number of users',
      4 => 'Will affect most users',
      5 => 'Will affect all users'
    },

    impact: {
      1 => 'Nuisance: not a big deal bug noticeable.',
      2 => 'A Pain: Users won\'t like this once they notice it.',
      3 => 'Affects Buy-in. Will show up in review. Clearly noticeable.',
      4 => 'A user would return the product. Should not deploy until fixed',
      5 => 'Affects system build'
    }
  }

  def max_pain
    MAX.values.reduce(&:*)
  end

  def user_pain(type, likelihood, impact)
    100 * (type * likelihood * impact) / max_pain
  end

  def normalize(value, variable)
    value = value.to_i
    max   = MAX[variable]

    return nil if max.nil? || value.nil?
    return nil if value < 1
    return max if value > max
    value
  end
end
