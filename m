Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4950F67B239
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjAYMDn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 07:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjAYMDh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 07:03:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2243568A2;
        Wed, 25 Jan 2023 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674648203; x=1706184203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ufZBtV8rcVPX6XXmjP2FHCWksjUH0Yche381zHYKepU=;
  b=GBQCG9JiOUMBUf260xQckzM6F4ntZ9m0oRdiY+gLUxN+BcmvhO37cJ21
   Gp17qq8+BO7B09e/UwArf9oPe9zpjQcp7LYRH9PjEHV05VhjjjtO5tMqE
   tWcMw4FDAz8Wv8/eAU8VsUWvJfixJb0UNUvALEfusUR7f7AaZAJy6ooIw
   iVji/R6+Fg/BaIMJmOtWw62FjImk6NkK/jMRyMHOYZGImyMwjkNKX+V+a
   HzcMo9BZi6ny6srEP4ymVqFTRC0oD0FSgH57ZA21cVx8h3NDsYibl6YQR
   eKA1BF//54f4pd/gvoiHEFFFMzgj8e8fVZ7wbZawX0KpojH4HsrL8TrYE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="388885124"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="388885124"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="664428036"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="664428036"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2023 04:03:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKeUV-00EpqY-1e;
        Wed, 25 Jan 2023 14:02:59 +0200
Date:   Wed, 25 Jan 2023 14:02:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9Eac0awIyK8KJEc@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
 <Y9DuyZUr3McCPGuh@kekkonen.localdomain>
 <Y9EWjBEwu4s96DPa@smile.fi.intel.com>
 <Y9EYPOmy2vEIzP7i@kekkonen.localdomain>
 <Y9EZ2eoQxnvQJPtd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9EZ2eoQxnvQJPtd@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 25, 2023 at 02:00:25PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 25, 2023 at 01:53:32PM +0200, Sakari Ailus wrote:
> > On Wed, Jan 25, 2023 at 01:46:20PM +0200, Andy Shevchenko wrote:
> > > On Wed, Jan 25, 2023 at 10:56:41AM +0200, Sakari Ailus wrote:
> > > > On Tue, Jan 24, 2023 at 09:26:31PM +0200, Andy Shevchenko wrote:
> > > > > On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:

...

> > > > > 		// assuming we dropped the union and renamed to val...
> > > > > 		ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> > > > > 						    "mipi-img-lane-polarities",
> > > > > 						    val, sizeof(val));
> > > > > 		if (ret) {
> > > > > 			...can't read... (debug message?)
> > > > > 		} else {
> > > > > 			unsigned int i;
> > > > > 
> > > > > 			for (i = 0; i < 1 + num_lanes; i++)
> > > > > 				bitmap_set_value8(polarity, val[i], i * BITS_PER_BYTE);
> > > > 
> > > > You'll still needed to access invididual bits in val.
> > > 
> > > I didn't get this. The below is what it does in most efficient way.
> > 
> > Ah. You're assining eight bits at a time.
> 
> > Then the loop ends too late as i refers to a byte, not bit. This can be
> > addressed though. And a BUILD_BUG_ON() check for polarity being large
> > enough will be needed.
> 
> You probably meant static_assert(), but see my reply to my reply where
> I caught up this. Yes, the loop conditional should rely on byte count.
> 
> > I still find this more complicated than the original code that also does
> > not need a temporary buffer.
> 
> Your magic formula with bit shifts and conjunctions is so hard to read
> and error prone, that makes me think of the proper APIs in the first place.
> That's why I'm tending to use this code, because it's much easier to get
> and maintain.
> 
> > > > > 			// assuming that lane_polarities is zeroed by default...
> > > > > 			for_each_set_bit(i, polarity, 1 + num_lanes)
> > > > > 				port->lane_polarities[i] = 1;

This even can be optimized much more if we put a constant bit numbers and if
it's less than or equal to BITS_PER_LONG.

			for_each_set_bit(i, polarity, MAX_LANES(port))

> > > Note that his code lacks of endianess issues.
> > > 
> > > > > 		}

-- 
With Best Regards,
Andy Shevchenko


