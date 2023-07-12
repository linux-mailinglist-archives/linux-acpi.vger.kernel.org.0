Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45211750D02
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 17:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjGLPtY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjGLPtX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 11:49:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D01BE8
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689176960; x=1720712960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ghKt0kJYmDMvPCsZxtyoOGstfHh4aSlwuKPFtOG+Tjk=;
  b=RGdi4IBzg7WVKC8oT1EjcfTPSZKyM4xO8GDg3SHR8G7GRRtinACebYms
   ATv3soV4SehtBwgWnZKrNBiOQQyv36w0k5h+DZPgeXhuwj7Yn2CQ6lWsg
   3ZE9mpAqbBiiuVNPvxS2zHw14Ry8Kob1Ll4NqZ527RTqoCMiqPWmMTjod
   Pil3z4Du95O3lXv34sWVZNgcbLB9L6l8aFjnFZZNDQ+1QKRHPWkQ8Kalr
   Dhy6TMtOkpgOAbVrELkx0PlpGwLgQ43efJgOkXk5fn5AsPg6xXvhmbLTX
   6WRqoBb8LBzASWxdPIew9yYEqzdhDMp6rfH8dYfvuAh4EYUehTR4nHw4x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="349778035"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="349778035"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="866173247"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="866173247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2023 08:48:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qJc5J-002AVv-1n;
        Wed, 12 Jul 2023 18:48:57 +0300
Date:   Wed, 12 Jul 2023 18:48:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com,
        pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com, lenb@kernel.org
Subject: Re: [PATCH 4/4] ACPI: NHLT: Add query functions
Message-ID: <ZK7LadhJSBjJUNqs@smile.fi.intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
 <20230712091048.2545319-5-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712091048.2545319-5-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 12, 2023 at 11:10:48AM +0200, Cezary Rojewski wrote:
> With iteration helpers added there is a room for more complex query
> tasks which are commonly performed by sound drivers. Implement them in
> common API so that a unified mechanism is available for all of them.
> 
> While the acpi_nhlt_endpoint_dmic_count() stands out a bit, it is a
> critical component for any AudioDSP driver to know how many digital
> microphones it is dealing with. There is no one perfect method, but the
> best one available is provided.

...

> +bool acpi_nhlt_endpoint_match(const struct acpi_nhlt_endpoint *ep,
> +			      int link_type, int dev_type, int dir, int bus_id)
> +{
> +	return ep &&
> +	       (link_type < 0 || ep->link_type == link_type) &&
> +	       (dev_type < 0 || ep->device_type == dev_type) &&
> +	       (dir < 0 || ep->direction == dir) &&
> +	       (bus_id < 0 || ep->virtual_bus_id == bus_id);

I think you can split these for better reading.

	if (!ep)
		return false;

	if (link_type >= 0 && ep->link_type != link_type)
		return false;

	if (dev_type >= 0 && ep->device_type != dev_type)
		return false;

	if (dir >= 0 && ep->direction != dir)
		return false;

	if (bus_id >= 0 && ep->virtual_bus_id != bus_id)
		return false;

	return true;

Yes, much more lines, but readability is better in my opinion.
I also believe that code generation on x86_64 will be the same.

> +}

...

> +struct acpi_nhlt_endpoint *
> +acpi_nhlt_find_endpoint(const struct acpi_table_nhlt *tb,
> +			int link_type, int dev_type, int dir, int bus_id)
> +{
> +	struct acpi_nhlt_endpoint *ep;

> +	if (!tb)
> +		return ERR_PTR(-EINVAL);

Just wondering how often we will have a caller that supplies NULL for tb.

> +	for_each_nhlt_endpoint(tb, ep)
> +		if (acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
> +			return ep;
> +	return NULL;
> +}

...

> +struct acpi_nhlt_format_config *
> +acpi_nhlt_endpoint_find_fmtcfg(const struct acpi_nhlt_endpoint *ep,
> +			       u16 ch, u32 rate, u16 vbps, u16 bps)
> +{
> +	struct acpi_nhlt_wave_extensible *wav;
> +	struct acpi_nhlt_format_config *fmt;

> +	if (!ep)
> +		return ERR_PTR(-EINVAL);

Similar Q as above.

> +	for_each_nhlt_endpoint_fmtcfg(ep, fmt) {
> +		wav = &fmt->format;
> +
> +		if (wav->channel_count == ch &&
> +		    wav->valid_bits_per_sample == vbps &&
> +		    wav->bits_per_sample == bps &&
> +		    wav->samples_per_sec == rate)

Also can be split, but this one readable in the original form.

> +			return fmt;
> +	}
> +
> +	return NULL;
> +}

...

> +struct acpi_nhlt_format_config *
> +acpi_nhlt_find_fmtcfg(const struct acpi_table_nhlt *tb,
> +		      int link_type, int dev_type, int dir, int bus_id,
> +		      u16 ch, u32 rate, u16 vbps, u16 bps)
> +{
> +	struct acpi_nhlt_format_config *fmt;
> +	struct acpi_nhlt_endpoint *ep;

> +	if (!tb)
> +		return ERR_PTR(-EINVAL);

Same as above.
Looking at them, wouldn't simply returning NULL suffice?

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

...

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

Is this function can ever be called without backing device? If not,
I would supply (ACPI?) device pointer and use dev_warn() instead.

But I'm not sure about this. Up to you, folks.

> +		return max_ch;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


