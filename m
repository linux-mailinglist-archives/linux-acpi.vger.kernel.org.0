Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3076CEBDF
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 16:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjC2Olg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjC2OlT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 10:41:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05821713;
        Wed, 29 Mar 2023 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680100711; x=1711636711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZiqXGPm+tbkT9B8jsVxww8YK5COiMmWaR7nNNQ4etzQ=;
  b=M0qDbTYpbONdsqjF5Wr+tCaVl2m6acOryhxKVTYDr5tWleMHC2RsOmL9
   u+RkmgJc6xLlmIEghzl/Tm9V0m7yD/4RU5a+XudLiYpKQDKookaT7HMR/
   SVXViHOIrtURrr5Vf5MD0lH4eOD5DLL+FmUc3KLyTlxubwT4vlmuEc3qW
   ztFc4cDklXuyC7dH1bh/QlemxmaQgQocnhu4QbOqpYiT4DUifrZaqRhwc
   tRIpczcQTETYbCoJk6pXZBb+rPYNkCu6WUvGvqJMjOIqrLs0Bk2/fmr6E
   bYJA3VWZ39YcDZdbg6Qmz9eMka2J1fo+8OxeEexm9+kAaD61FyLpSu0oj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="338392384"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="338392384"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="716905996"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="716905996"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2023 07:38:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phWw8-00A3vX-1x;
        Wed, 29 Mar 2023 17:38:04 +0300
Date:   Wed, 29 Mar 2023 17:38:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
Message-ID: <ZCRNTFzTS/FhqKhr@smile.fi.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-6-sakari.ailus@linux.intel.com>
 <ZCMLaKpPrdl6kDIT@smile.fi.intel.com>
 <ZCM+KiZpLt/qf59F@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCM+KiZpLt/qf59F@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 10:21:14PM +0300, Sakari Ailus wrote:
> On Tue, Mar 28, 2023 at 06:44:40PM +0300, Andy Shevchenko wrote:
> > On Tue, Mar 28, 2023 at 01:12:58PM +0300, Sakari Ailus wrote:

...

> > >  #define NO_CSI2_PORT (UINT_MAX - 1)
> > 
> > Has it been used before this patch?
> 
> I don't think so.
> 
> It has its current form as you preferred it earlier. :-)


My point is that it needs to be introduced where the first user appears.

> > #define NEXT_PROPERTY(index, max)				\
> > 	(WARN_ON((index) > ACPI_DEVICE_SWNODE_##max) ?	\
> > 	 ACPI_DEVICE_SWNODE_##max : (index)++)
> > 
> > ?
> 
> This appears functionally (almost) equivalent --- it wouldn't overflow.
> I'll use this in v8.

In this form it even takes line less

#define NEXT_PROPERTY(i, m)				\
	(WARN_ON((i) > ACPI_DEVICE_SWNODE_##m) ? ACPI_DEVICE_SWNODE_##m : (i)++)

...

> > > +	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-lane-polarities");
> > > +	if (ret > 0) {
> > > +		unsigned int bytes = min_t(unsigned int, ret, sizeof(val));
> > > +
> > > +		fwnode_property_read_u8_array(mipi_port_fwnode,
> > > +					      "mipi-img-lane-polarities",
> > > +					      val, bytes);
> > > +
> > > +		/* Total number of lanes here is clock lane + data lanes */
> > > +		if (bytes * BITS_PER_TYPE(u8) >= 1 + num_lanes) {
> > > +			unsigned int i;
> > > +
> > > +			/* Move polarity bits to the lane polarity u32 array */
> > > +			for (i = 0; i < 1 + num_lanes; i++)
> > > +				port->lane_polarities[i] =
> > > +					(bool)(val[i >> 3] & (1 << (i & 7)));
> > 
> > Casting to bool?!
> 
> This was the result of our earlier discussion on an earlier version of this
> set.
> 
> > Can we read the array and convert it to bitmap, then this voodoo-ish code can
> > be simplified to
> > 
> > 	for_each_set_bit(i, ...)
> > 		..._polarities[i] = 1;
> 
> for_each_set_bit() operates on unsigned longs (usually u32 or u64) but we
> have u8s here. There's an endianness issue there.

No issue if you convert it to unsigned long:s first.

> > (assuming initially they are 0:s)?

I think open coding the bitmap operations here is not a win.

-- 
With Best Regards,
Andy Shevchenko


