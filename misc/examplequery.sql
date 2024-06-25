WITH
  parsed AS (
  SELECT
    string_field_0 AS useragent_raw,
    `project.dataset.parse_useragents_tf`(string_field_0) AS useragent_parsed
  FROM
    dataset.useragents20000 )

SELECT
  useragent_raw,
  useragent_parsed,
  useragent_parsed.BrowserName,
  useragent_parsed.PlatformName,
  useragent_parsed.PlatformVendor,
  useragent_parsed.IsMobile,
  useragent_parsed.IsSmartPhone,
  useragent_parsed.IsTablet
FROM
  parsed;