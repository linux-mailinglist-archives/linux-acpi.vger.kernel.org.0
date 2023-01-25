Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D295267B21F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjAYMAf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 07:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYMAe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 07:00:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE72D70;
        Wed, 25 Jan 2023 04:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674648033; x=1706184033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jgdxXNI94wDshH/yv91B7jKm6srZihyxwlNtMSuJA6g=;
  b=lo58o7jKcsh5rDtu4b1tpDoHpghf0dYnT7H5llgJV8zqgVz2zJ1BNWYG
   uhOSYBkumwAoWD9HQ8OH3lq6auhkaeu0tz+qaqINYzdrsTG1fnTQ2G1bV
   wPaoFAPUCJHWxrjuucHioIKMoKZy4tz6/XJVsbOHcgROSplt5C/fyUklD
   mMNAj4tCdW6Gw8LMSyzxjGOQ2MQEEyFAj8+d5os+mscYZjDo8hf+vFOt9
   J9lxKg6aACp3RmGS/OGIHVtbhbAkVBBT38WXF2O6Ak2tubclwvIMlhcgl
   VXvetLIesZpz0QL80IdHX3bwpi59YW3uthVfkkLNRVucFaP874HptXMoB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="326565470"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="326565470"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="655782380"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="655782380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2023 04:00:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKeS1-00Epnd-2H;
        Wed, 25 Jan 2023 14:00:25 +0200
Date:   Wed, 25 Jan 2023 14:00:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9EZ2eoQxnvQJPtd@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
 <Y9DuyZUr3McCPGuh@kekkonen.localdomain>
 <Y9EWjBEwu4s96DPa@smile.fi.intel.com>
 <Y9EYPOmy2vEIzP7i@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9EYPOmy2vEIzP7i@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 25, 2023 at 01:53:32PM +0200, Sakari Ailus wrote:
> On Wed, Jan 25, 2023 at 01:46:20PM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 25, 2023 at 10:56:41AM +0200, Sakari Ailus wrote:
> > > On Tue, Jan 24, 2023 at 09:26:31PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:

...

> > > > 		// assuming we dropped the union and renamed to val...
> > > > 		ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> > > > 						    "mipi-img-lane-polarities",
> > > > 						    val, sizeof(val));
> > > > 		if (ret) {
> > > > 			...can't read... (debug message?)
> > > > 		} else {
> > > > 			unsigned int i;
> > > > 
> > > > 			for (i = 0; i < 1 + num_lanes; i++)
> > > > 				bitmap_set_value8(polarity, val[i], i * BITS_PER_BYTE);
> > > 
> > > You'll still needed to access invididual bits in val.
> > 
> > I didn't get this. The below is what it does in most efficient way.
> 
> Ah. You're assining eight bits at a time.

> Then the loop ends too late as i refers to a byte, not bit. This can be
> addressed though. And a BUILD_BUG_ON() check for polarity being large
> enough will be needed.

You probably meant static_assert(), but see my reply to my reply where
I caught up this. Yes, the loop conditional should rely on byte count.

> I still find this more complicated than the original code that also does
> not need a temporary buffer.

Your magic formula with bit shifts and conjunctions is so hard to read
and error prone, that makes me think of the proper APIs in the first place.
That's why I'm tending to use this code, because it's much easier to get
and maintain.

> > > > 			// assuming that lane_polarities is zeroed by default...
> > > > 			for_each_set_bit(i, polarity, 1 + num_lanes)
> > > > 				port->lane_polarities[i] = 1;
> > 
> > Note that his code lacks of endianess issues.
> > 
> > > > 		}

-- 
With Best Regards,
Andy Shevchenko


