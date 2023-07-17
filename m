Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81484756747
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGQPN7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjGQPN6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 11:13:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A75F9
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689606837; x=1721142837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EcrO6qPfWokuu8QCBEiBVL6scBxk7BUYbeafnS+aH/s=;
  b=ZAUbqMoR5gdpgZ2lh9vYgduHEiilPwVAnmDHunxOlEDPuFa+3B4qecq5
   bHhu2mDrKXTyJPDSnR1BZVrn30EeXTKc9HyJbH5fvYCV43Okm+0K3WUxs
   cAf34HmQ9vBiTIfX85mj0gn2vlmNENwVZ0TjpFbR4Ps1ULK1xkmXLupAd
   x61/omTIzYioueCrYFaGV8lB6fUKxfsRCt2WYYCrmp1/+JyS3Jeqa9eZW
   E3J1nTRLwGfRFG8eyC61zR62/ONT5L7PwLRRYEmWonH9gr+ZFg5m6NJDS
   0Vwbmoa1CnRRWogXkCYwWplumIePydFg6U3x3OOgg6kH73MzulTApsigP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452329564"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452329564"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="752930170"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752930170"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 08:13:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLPv7-002NHV-0P;
        Mon, 17 Jul 2023 18:13:53 +0300
Date:   Mon, 17 Jul 2023 18:13:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com
Subject: Re: [PATCH v2 4/4] ACPI: NHLT: Add query functions
Message-ID: <ZLVasBs5gA+F0adB@smile.fi.intel.com>
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
 <20230717150047.15196-5-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717150047.15196-5-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 17, 2023 at 05:00:47PM +0200, Cezary Rojewski wrote:
> With iteration helpers added there is a room for more complex query
> tasks which are commonly performed by sound drivers. Implement them in
> common API so that a unified mechanism is available for all of them.
> 
> While the acpi_nhlt_endpoint_dmic_count() stands out a bit, it is a
> critical component for any AudioDSP driver to know how many digital
> microphones it is dealing with. There is no one perfect method, but the
> best one available is provided.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  drivers/acpi/nhlt.c | 174 ++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/nhlt.h |  54 ++++++++++++++
>  2 files changed, 228 insertions(+)
> 
> diff --git a/drivers/acpi/nhlt.c b/drivers/acpi/nhlt.c
> index 90d74d0d803e..9d33266f4663 100644
> --- a/drivers/acpi/nhlt.c
> +++ b/drivers/acpi/nhlt.c
> @@ -6,8 +6,182 @@
>  //          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
>  //
>  
> +#define pr_fmt(fmt) "ACPI: NHLT: " fmt
> +
>  #include <linux/export.h>
>  #include <acpi/nhlt.h>
>  
>  struct acpi_table_nhlt *acpi_gbl_NHLT;
>  EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
> +
> +/**
> + * acpi_nhlt_endpoint_match - Verify if an endpoint matches criteria.
> + * @ep:			the endpoint to check.
> + * @link_type:		the hardware link type, e.g.: PDM or SSP.
> + * @dev_type:		the device type.
> + * @dir:		stream direction.
> + * @bus_id:		the ID of virtual bus hosting the endpoint.
> + *
> + * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
> + * value to ignore the parameter when matching.
> + *
> + * Return: %true if endpoint matches specified criteria or %false otherwise.
> + */
> +bool acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
> +			      int link_type, int dev_type, int dir, int bus_id)
> +{
> +	return ep &&
> +	       (link_type < 0 || ep->link_type == link_type) &&
> +	       (dev_type < 0 || ep->device_type == dev_type) &&
> +	       (bus_id < 0 || ep->virtual_bus_id == bus_id) &&
> +	       (dir < 0 || ep->direction == dir);
> +}
> +EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_match);
> +
> +/**
> + * acpi_nhlt_find_endpoint - Search a NHLT table for an endpoint.
> + * @tb:			the table to search.
> + * @link_type:		the hardware link type, e.g.: PDM or SSP.
> + * @dev_type:		the device type.
> + * @dir:		stream direction.
> + * @bus_id:		the ID of virtual bus hosting the endpoint.
> + *
> + * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
> + * value to ignore the parameter during the search.
> + *
> + * Return: A pointer to endpoint matching the criteria, %NULL if not found or
> + * an ERR_PTR() otherwise.
> + */
> +struct acpi_nhlt_endpoint *
> +acpi_nhlt_find_endpoint(const struct acpi_table_nhlt *tb,
> +			int link_type, int dev_type, int dir, int bus_id)
> +{
> +	struct acpi_nhlt_endpoint *ep;
> +
> +	for_each_nhlt_endpoint(tb, ep)
> +		if (acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
> +			return ep;
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(acpi_nhlt_find_endpoint);
> +
> +/**
> + * acpi_nhlt_endpoint_find_fmtcfg - Search endpoint's formats configuration space
> + *                                  for a specific format.
> + * @ep:			the endpoint to search.
> + * @ch:			number of channels.
> + * @rate:		samples per second.
> + * @vbps:		valid bits per sample.
> + * @bps:		bits per sample.
> + *
> + * Return: A pointer to format matching the criteria, %NULL if not found or
> + * an ERR_PTR() otherwise.
> + */
> +struct acpi_nhlt_format_config *
> +acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
> +			       u16 ch, u32 rate, u16 vbps, u16 bps)
> +{
> +	struct acpi_nhlt_wave_extensible *wav;
> +	struct acpi_nhlt_format_config *fmt;
> +
> +	for_each_nhlt_endpoint_fmtcfg(ep, fmt) {
> +		wav = &fmt->format;
> +
> +		if (wav->valid_bits_per_sample == vbps &&
> +		    wav->samples_per_sec == rate &&
> +		    wav->bits_per_sample == bps &&
> +		    wav->channel_count == ch)
> +			return fmt;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_find_fmtcfg);
> +
> +/**
> + * acpi_nhlt_find_fmtcfg - Search a NHLT table for a specific format.
> + * @tb:			the table to search.
> + * @link_type:		the hardware link type, e.g.: PDM or SSP.
> + * @dev_type:		the device type.
> + * @dir:		stream direction.
> + * @bus_id:		the ID of virtual bus hosting the endpoint.
> + *
> + * @ch:			number of channels.
> + * @rate:		samples per second.
> + * @vbps:		valid bits per sample.
> + * @bps:		bits per sample.
> + *
> + * Either of @link_type, @dev_type, @dir or @bus_id may be set to a negative
> + * value to ignore the parameter during the search.
> + *
> + * Return: A pointer to format matching the criteria, %NULL if not found or
> + * an ERR_PTR() otherwise.
> + */
> +struct acpi_nhlt_format_config *
> +acpi_nhlt_find_fmtcfg(const struct acpi_table_nhlt *tb,
> +		      int link_type, int dev_type, int dir, int bus_id,
> +		      u16 ch, u32 rate, u16 vbps, u16 bps)
> +{
> +	struct acpi_nhlt_format_config *fmt;
> +	struct acpi_nhlt_endpoint *ep;
> +
> +	for_each_nhlt_endpoint(tb, ep) {
> +		if (!acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
> +			continue;
> +
> +		fmt = acpi_nhlt_endpoint_find_fmtcfg(ep, ch, rate, vbps, bps);
> +		if (fmt)
> +			return fmt;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(acpi_nhlt_find_fmtcfg);
> +
> +/**
> + * acpi_nhlt_endpoint_dmic_count - Retrieve number of digital microphones for a PDM endpoint.
> + * @ep:			the endpoint to return microphones count for.
> + *
> + * Return: A number of microphones or an error code if an invalid endpoint is provided.
> + */
> +int acpi_nhlt_endpoint_dmic_count(const struct acpi_nhlt_endpoint *ep)
> +{
> +	struct acpi_nhlt_vendor_mic_devcfg *vendor_cfg;
> +	struct acpi_nhlt_format_config *fmt;
> +	struct acpi_nhlt_mic_devcfg *devcfg;
> +	u16 max_ch = 0;
> +
> +	if (!ep || ep->link_type != ACPI_NHLT_PDM)
> +		return -EINVAL;
> +
> +	/* Find max number of channels based on formats configuration. */
> +	for_each_nhlt_endpoint_fmtcfg(ep, fmt)
> +		max_ch = max(fmt->format.channel_count, max_ch);
> +
> +	/* If @ep not a mic array, fallback to channels count. */
> +	devcfg = acpi_nhlt_endpoint_mic_devcfg(ep);
> +	if (!devcfg || devcfg->config_type != ACPI_NHLT_CONFIG_TYPE_MIC_ARRAY)
> +		return max_ch;
> +
> +	switch (devcfg->array_type) {
> +	case ACPI_NHLT_SMALL_LINEAR_2ELEMENT:
> +	case ACPI_NHLT_BIG_LINEAR_2ELEMENT:
> +		return 2;
> +
> +	case ACPI_NHLT_FIRST_GEOMETRY_LINEAR_4ELEMENT:
> +	case ACPI_NHLT_PLANAR_LSHAPED_4ELEMENT:
> +	case ACPI_NHLT_SECOND_GEOMETRY_LINEAR_4ELEMENT:
> +		return 4;
> +
> +	case ACPI_NHLT_VENDOR_DEFINED:
> +		vendor_cfg = acpi_nhlt_endpoint_vendor_mic_devcfg(ep);
> +		if (!vendor_cfg)
> +			return -EINVAL;
> +		return vendor_cfg->num_mics;
> +
> +	default:
> +		pr_warn("undefined mic array type: %#x\n", devcfg->array_type);
> +		return max_ch;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(acpi_nhlt_endpoint_dmic_count);
> diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
> index 90ffa0dc1659..4caada011267 100644
> --- a/include/acpi/nhlt.h
> +++ b/include/acpi/nhlt.h
> @@ -149,4 +149,58 @@ acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt_endpoint *ep)
>  #define for_each_nhlt_endpoint_fmtcfg(ep, fmt) \
>  	for_each_nhlt_fmtcfg(acpi_nhlt_endpoint_fmtscfg(ep), fmt)
>  
> +#if IS_ENABLED(CONFIG_ACPI_NHLT)
> +
> +bool acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
> +			      int link_type, int dev_type, int dir, int bus_id);
> +struct acpi_nhlt_endpoint *
> +acpi_nhlt_find_endpoint(const struct acpi_table_nhlt *tb,
> +			int link_type, int dev_type, int dir, int bus_id);
> +struct acpi_nhlt_format_config *
> +acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
> +			       u16 ch, u32 rate, u16 vbps, u16 bps);
> +struct acpi_nhlt_format_config *
> +acpi_nhlt_find_fmtcfg(const struct acpi_table_nhlt *tb,
> +		      int link_type, int dev_type, int dir, int bus_id,
> +		      u16 ch, u32 rate, u16 vpbs, u16 bps);
> +int acpi_nhlt_endpoint_dmic_count(const struct acpi_nhlt_endpoint *ep);
> +
> +#else /* !CONFIG_ACPI_NHLT */
> +
> +static bool
> +acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
> +			 int link_type, int dev_type, int dir, int bus_id)
> +{
> +	return false;
> +}
> +
> +static inline struct acpi_nhlt_endpoint *
> +acpi_nhlt_find_endpoint(const struct acpi_table_nhlt *tb,
> +			int link_type, int dev_type, int dir, int bus_id)
> +{
> +	return NULL;
> +}
> +
> +static inline struct acpi_nhlt_format_config *
> +acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
> +			       u16 ch, u32 rate, u16 vbps, u16 bps)
> +{
> +	return NULL;
> +}
> +
> +static inline struct acpi_nhlt_format_config *
> +acpi_nhlt_find_fmtcfg(const struct acpi_table_nhlt *tb,
> +		      int link_type, int dev_type, int dir, int bus_id,
> +		      u16 ch, u32 rate, u16 vpbs, u16 bps);
> +{
> +	return NULL;
> +}
> +
> +static inline int acpi_nhlt_endpoint_dmic_count(const struct acpi_nhlt_endpoint *ep)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_ACPI_NHLT */
> +
>  #endif /* __ACPI_NHLT_H__ */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


