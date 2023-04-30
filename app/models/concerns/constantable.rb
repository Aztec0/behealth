# frozen_string_literal: true

module Constantable
  extend ActiveSupport::Concern

  PASSWORD_MINIMUM_LENGTH = 6
  ID_CARD_NUMBER_REGEX = /\A[0-9]{9}\z/.freeze
  ID_CARD_ISSUED_BY_REGEX = /\A[0-9]{4}\z/.freeze
  PASSPORT_SERIES_REGEX = /\A[A-Z]{2}\z/.freeze
  PASSPORT_NUMBER_REGEX = /\A[0-9]{6}\z/.freeze
  PASSPORT_ISSUED_BY_REGEX = /\A[\p{Cyrillic}\s]{1,60}\z/.freeze
  NAME_REGEX = /\A\p{Cyrillic}+\z/.freeze
  TIN_LENGTH = 10
  SETTLEMENT_REGEX = /\A[\p{Cyrillic} ,.–();]+\z/.freeze
  HOUSE_REGEX = %r{\A[0-9/]{1,5}\z}.freeze
  APARTMENTS_REGEX = /\A[1-9]{1,5}\z/.freeze
  WORKPLACE_REGEX = /\A[\p{Cyrillic} ,.–();]+\z/.freeze
  POSITION_REGEX = /\A\p{Cyrillic}+\z/.freeze
end
