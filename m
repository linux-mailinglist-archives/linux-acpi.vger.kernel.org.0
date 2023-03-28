Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14EE6CCA81
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 21:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjC1TVV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjC1TVV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 15:21:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97562D64;
        Tue, 28 Mar 2023 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680031279; x=1711567279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2xcffYOaU7W7KMqsYrL77J4vsOckC0wjMKgigvZwWMs=;
  b=KYli5r+V4483OuY7I5fo4wMp+HBr4nUssBLbS7Fp33/Nvn1ZysxSslan
   83mZkiyjcPQ+uMtITA0qeV/w579mZUxJF+zmY2Zdcos+Vdn9CsZvUCkiP
   KhcGLXPN9jcNxxOskaNcgcPuYc7TyLKrmt/rA5U65wUlH+6ibQF9J0NAS
   3pwV+H9E3auxwxk5NsTc8ngg+57qbQnk78zn+OCbZl523g7j3FoIpo2K9
   W8tUr9PDekjMgU5wOqkwTIQqko+iOLyydKFWoJAzUzMtZ976/RCaD7JZi
   EPESV0B9VozkOiwBlw1LVia5O/wECsufvkZTzJ+B7wJBcgooSh3IH2/5l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340691461"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340691461"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 12:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="716583448"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="716583448"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 12:21:17 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 9B96911F937;
        Tue, 28 Mar 2023 22:21:14 +0300 (EEST)
Date:   Tue, 28 Mar 2023 22:21:14 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
Message-ID: <ZCM+KiZpLt/qf59F@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-6-sakari.ailus@linux.intel.com>
 <ZCMLaKpPrdl6kDIT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMLaKpPrdl6kDIT@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Mar 28, 2023 at 06:44:40PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 01:12:58PM +0300, Sakari Ailus wrote:
> > Prepare generating software nodes for information parsed from ACPI _CRS for
> > CSI-2 as well as MIPI DisCo for Imaging spec. The software nodes are
> > compliant with existing ACPI or DT definitions and are parsed by relevant
> > drivers without changes.
> 
> ...
> 
> >  #define NO_CSI2_PORT (UINT_MAX - 1)
> 
> Has it been used before this patch?

I don't think so.

It has its current form as you preferred it earlier. :-)

> 
> ...
> 
> > +/* Print graph port name into a buffer, return non-zero if failed. */
> > +#define GRAPH_PORT_NAME(var, num)					    \
> > +	(snprintf((var), sizeof(var), SWNODE_GRAPH_PORT_NAME_FMT, (num)) >= \
> > +	 sizeof(var))
> 
> This macro evaluates sizeof(var) twice. Is it a problem?

I don't think it is.

> 
> ...
> 
> > +#define NEXT_PROPERTY(index, max)				\
> > +	(WARN_ON(++(index) > ACPI_DEVICE_SWNODE_##max + 1) ?	\
> > +	 ACPI_DEVICE_SWNODE_##max : (index) - 1)
> 
> This macro full of interesting effects. On top of that it's written in
> hard-to-read form.
> 
> Why not at least
> 
> #define NEXT_PROPERTY(index, max)				\
> 	(WARN_ON((index) > ACPI_DEVICE_SWNODE_##max) ?	\
> 	 ACPI_DEVICE_SWNODE_##max : (index)++)
> 
> ?

This appears functionally (almost) equivalent --- it wouldn't overflow.
I'll use this in v8.

> 
> ...
> 
> > +	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-lane-polarities");
> > +	if (ret > 0) {
> > +		unsigned int bytes = min_t(unsigned int, ret, sizeof(val));
> > +
> > +		fwnode_property_read_u8_array(mipi_port_fwnode,
> > +					      "mipi-img-lane-polarities",
> > +					      val, bytes);
> > +
> > +		/* Total number of lanes here is clock lane + data lanes */
> > +		if (bytes * BITS_PER_TYPE(u8) >= 1 + num_lanes) {
> > +			unsigned int i;
> > +
> > +			/* Move polarity bits to the lane polarity u32 array */
> > +			for (i = 0; i < 1 + num_lanes; i++)
> > +				port->lane_polarities[i] =
> > +					(bool)(val[i >> 3] & (1 << (i & 7)));
> 
> Casting to bool?!

This was the result of our earlier discussion on an earlier version of this
set.

> 
> Can we read the array and convert it to bitmap, then this voodoo-ish code can
> be simplified to
> 
> 	for_each_set_bit(i, ...)
> 		..._polarities[i] = 1;

for_each_set_bit() operates on unsigned longs (usually u32 or u64) but we
have u8s here. There's an endianness issue there.

> 
> (assuming initially they are 0:s)?

-- 
Kind regards,

Sakari Ailus
