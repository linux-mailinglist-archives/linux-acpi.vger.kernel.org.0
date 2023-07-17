Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4044755FC3
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGQJsY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjGQJsR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 05:48:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33AE5C
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689587282; x=1721123282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DL32BJxwmV6Yyz/GCbb5Mit9CnOaIGlOxbhxjd1z13A=;
  b=ih8SiV7cUcEKkitxj5xDz7BAq/9L46S3+dvocqEDrRt4RPM1019IArZr
   X50KQXeYNixzrRjACsAoYLZ/igTnCrHHKTKF2xZDqWOQigd3SuLgzA2Rk
   Mnd/GrzgmlWofr9nGHPhE25RfO9JHfSRx5hjJfJV4NYFz1eNEjP8ooRZ+
   LLdAFVtItJlLTBUsz8d1PQB9GzgZIKTY/qPWNQEHoSA82g1EqUF6E0DZV
   vUItBvW8amvXrcRosEuF5IQ+WDw7oN08zSxHT1ZLzKfp5JwGbOii4U9te
   cZZHDKWBVc+ZHkMi/W1yAWqaBZhE1KLg9IUINZPjF0rB0MblnrgVtFAuT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="355826585"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355826585"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866683687"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2023 02:48:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLKpi-00830M-2P;
        Mon, 17 Jul 2023 12:47:58 +0300
Date:   Mon, 17 Jul 2023 12:47:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com
Subject: Re: [PATCH 4/4] ACPI: NHLT: Add query functions
Message-ID: <ZLUOTiLGE4NFAdnD@smile.fi.intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
 <20230712091048.2545319-5-cezary.rojewski@intel.com>
 <ZK7LadhJSBjJUNqs@smile.fi.intel.com>
 <3544e8dd-874e-4b26-cb37-04aad2a8332a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3544e8dd-874e-4b26-cb37-04aad2a8332a@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 17, 2023 at 10:29:17AM +0200, Cezary Rojewski wrote:
> On 2023-07-12 5:48 PM, Andy Shevchenko wrote:
> > On Wed, Jul 12, 2023 at 11:10:48AM +0200, Cezary Rojewski wrote:

...

> > > +	return ep &&
> > > +	       (link_type < 0 || ep->link_type == link_type) &&
> > > +	       (dev_type < 0 || ep->device_type == dev_type) &&
> > > +	       (dir < 0 || ep->direction == dir) &&
> > > +	       (bus_id < 0 || ep->virtual_bus_id == bus_id);
> > 
> > I think you can split these for better reading.
> > 
> > 	if (!ep)
> > 		return false;
> > 
> > 	if (link_type >= 0 && ep->link_type != link_type)
> > 		return false;
> > 
> > 	if (dev_type >= 0 && ep->device_type != dev_type)
> > 		return false;
> > 
> > 	if (dir >= 0 && ep->direction != dir)
> > 		return false;
> > 
> > 	if (bus_id >= 0 && ep->virtual_bus_id != bus_id)
> > 		return false;
> > 
> > 	return true;
> > 
> > Yes, much more lines, but readability is better in my opinion.
> > I also believe that code generation on x86_64 will be the same.
> 
> While I favor readability over less lines of code, I do not think splitting
> the conditions makes it easier in this case. Perhaps reverse-christmas-tree?
> Pivoted around '<'.
> 
> 	return ep &&
> 	       (link_type < 0 || ep->link_type == link_type) &&
> 	       (dev_type < 0 || ep->device_type == dev_type) &&
> 	       (bus_id < 0 || ep->virtual_bus_id == bus_id) &&
> 	       (dir < 0 || ep->direction == dir);

This one definitely better.

> In general I'd like to distinguish between conditions that one _has to_ read
> and understand and those which reader _may_ pass by. Here, we are checking
> description of an endpoint for equality. Nothing more, nothing less.

...

> > > +struct acpi_nhlt_endpoint *
> > > +acpi_nhlt_find_endpoint(const struct acpi_table_nhlt *tb,
> > > +			int link_type, int dev_type, int dir, int bus_id)
> > > +{
> > > +	struct acpi_nhlt_endpoint *ep;
> > 
> > > +	if (!tb)
> > > +		return ERR_PTR(-EINVAL);
> > 
> > Just wondering how often we will have a caller that supplies NULL for tb.
> 
> Depends on kernel's philosophy on public API. In general, public API should
> defend themselves from harmful and illegal callers. However, in low level
> areas 'illegal' is sometimes mistaken with illogical. In such cases double
> safety can be dropped.

What do you put under "public"? ABI? Or just internally available API?
If the latter, we don't do defensive programming there, we usually just
add NULL(invalid data)-awareness to the free()-like functions.

> Or, perhaps you were discussing return value here and ERR_PTR(-EINVAL) could
> be replaced by something else or even NULL.

I prefer to get rid of those.

> > > +	for_each_nhlt_endpoint(tb, ep)
> > > +		if (acpi_nhlt_endpoint_match(ep, link_type, dev_type, dir, bus_id))
> > > +			return ep;
> > > +	return NULL;
> > > +}

...

> > > +		if (wav->channel_count == ch &&
> > > +		    wav->valid_bits_per_sample == vbps &&
> > > +		    wav->bits_per_sample == bps &&
> > > +		    wav->samples_per_sec == rate)
> > 
> > Also can be split, but this one readable in the original form.
> 
> As order does not really matter here, perhaps reverse-christmas-tree to
> improve readability?
> 
> 		if (wav->valid_bits_per_sample == vpbs &&
> 		    wav->samples_per_sec == rate &&
> 		    wav->bits_per_sample == bps &&
> 		    wav->channel_count == ch)

OK!

> > > +			return fmt;

...

> > > +	default:
> > 
> > > +		pr_warn("undefined mic array type: %#x\n", devcfg->array_type);
> > 
> > Is this function can ever be called without backing device? If not,
> > I would supply (ACPI?) device pointer and use dev_warn() instead.
> > 
> > But I'm not sure about this. Up to you, folks.
> 
> Given what's our there in the market I wouldn't say it's impossible to
> encounter such scenario. Could you elaborate on what you meant by "supply
> device pointer"?

In the caller (assuming it has ACPI device):

	ret = acpi_nhlt_endpoint_dmic_count(adev, ep);
	if (ret < 0)
		...

> > > +		return max_ch;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


