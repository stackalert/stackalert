# frozen_string_literal: true

ActiveRecord::Type.register(:downcase_string, DowncaseStringType)
ActiveRecord::Type.register(:capitalize_string, CapitalizeStringType)
