Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982726CECAC
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC2PVO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC2PVN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 11:21:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355310C3;
        Wed, 29 Mar 2023 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680103272; x=1711639272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m7hzVxOCFSoHjGVclC8nARdYk1W6wFlRHX/1NSdxJkI=;
  b=jHTEJzoqRFb5KwsLvXmpab38DJfsKKvjRap5+HDe3AjC8Weuint5/Osl
   yTlzvvWsxMNSGhlf39KClaIoa7ITyrdMLACJOc/QDn/WBS2MPew8/Xvu2
   wou/RTmnwhmJvemzTqvUHpMK8uGKwHbXWYJ+//y7iub2IAjybIZTPBBlu
   gnZSE8jmwboqiSAZ3qtnDyENNlcseupACJNsLRFZjjkCmKwRN6YxLl1zM
   jVeF+ymS6rYw9RMb+Nw8gDJcRdRlftDefyBWHpr0a+B1JZGvqsWbX3gx9
   mi6iNytjzIZ3zRdQ3wFnyxG8mXN0lIyH/Ldg++fEphhj3pxXImENgmn2K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321299005"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="321299005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 08:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="714647638"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="714647638"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 08:20:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id A79A51224D2;
        Wed, 29 Mar 2023 18:20:53 +0300 (EEST)
Date:   Wed, 29 Mar 2023 18:20:53 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
Message-ID: <ZCRXVYjvhhuH4dRJ@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-6-sakari.ailus@linux.intel.com>
 <ZCMLaKpPrdl6kDIT@smile.fi.intel.com>
 <ZCM+KiZpLt/qf59F@kekkonen.localdomain>
 <ZCRNTFzTS/FhqKhr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCRNTFzTS/FhqKhr@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, Mar 29, 2023 at 05:38:04PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 10:21:14PM +0300, Sakari Ailus wrote:
> > On Tue, Mar 28, 2023 at 06:44:40PM +0300, Andy Shevchenko wrote:
> > > On Tue, Mar 28, 2023 at 01:12:58PM +0300, Sakari Ailus wrote:
> 
> ...
> 
> > > >  #define NO_CSI2_PORT (UINT_MAX - 1)
> > > 
> > > Has it been used before this patch?
> > 
> > I don't think so.
> > 
> > It has its current form as you preferred it earlier. :-)
> 
> 
> My point is that it needs to be introduced where the first user appears.

Yes, the first use of this macro is in this patch.

> 
> > > #define NEXT_PROPERTY(index, max)				\
> > > 	(WARN_ON((index) > ACPI_DEVICE_SWNODE_##max) ?	\
> > > 	 ACPI_DEVICE_SWNODE_##max : (index)++)
> > > 
> > > ?
> > 
> > This appears functionally (almost) equivalent --- it wouldn't overflow.
> > I'll use this in v8.
> 
> In this form it even takes line less
> 
> #define NEXT_PROPERTY(i, m)				\
> 	(WARN_ON((i) > ACPI_DEVICE_SWNODE_##m) ? ACPI_DEVICE_SWNODE_##m : (i)++)

I prefer the previous form as it is easier to grasp what it does --- the
names of the variables suggest what they are for.

> 
> ...
> 
> > > > +	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-lane-polarities");
> > > > +	if (ret > 0) {
> > > > +		unsigned int bytes = min_t(unsigned int, ret, sizeof(val));
> > > > +
> > > > +		fwnode_property_read_u8_array(mipi_port_fwnode,
> > > > +					      "mipi-img-lane-polarities",
> > > > +					      val, bytes);
> > > > +
> > > > +		/* Total number of lanes here is clock lane + data lanes */
> > > > +		if (bytes * BITS_PER_TYPE(u8) >= 1 + num_lanes) {
> > > > +			unsigned int i;
> > > > +
> > > > +			/* Move polarity bits to the lane polarity u32 array */
> > > > +			for (i = 0; i < 1 + num_lanes; i++)
> > > > +				port->lane_polarities[i] =
> > > > +					(bool)(val[i >> 3] & (1 << (i & 7)));
> > > 
> > > Casting to bool?!
> > 
> > This was the result of our earlier discussion on an earlier version of this
> > set.
> > 
> > > Can we read the array and convert it to bitmap, then this voodoo-ish code can
> > > be simplified to
> > > 
> > > 	for_each_set_bit(i, ...)
> > > 		..._polarities[i] = 1;
> > 
> > for_each_set_bit() operates on unsigned longs (usually u32 or u64) but we
> > have u8s here. There's an endianness issue there.
> 
> No issue if you convert it to unsigned long:s first.
> 
> > > (assuming initially they are 0:s)?
> 
> I think open coding the bitmap operations here is not a win.

Sure, this could be converted to a different form and then the bits could
be accessed using existing API functions. But I don't think it'd be better
that way.

-- 
Kind regards,

Sakari Ailus
