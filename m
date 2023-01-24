Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA34679EE5
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 17:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjAXQjS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 11:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjAXQjL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 11:39:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574364C6E1;
        Tue, 24 Jan 2023 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674578342; x=1706114342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIXyguJNRfQn6s5SUu15l7psD2cK2vPchwRM4Gqqy4E=;
  b=CWSZznFDqxF88y20Knb2y9IWaPcY4mXRXGT2FQutQPN3tybzU1tD+hcc
   NW4HnRe3QvVPxQyqA4R9O9vtb83xcJ26NCwsEg1xFyYcczwDe4Mv5igtN
   gbc8tn22CYIffXPY9lR+53W0Yyc1c0wxXChNXA5i5mq7S0Eya1mHEBZEp
   liEQyIwQbyyVLa6H+giMNYyEoRUA/+iw3eoiNdY5FY4fdaVuudNboEaGN
   ccYJh+Zoi0MTtuzU3YEoNXAM0iuyMN/VAd28w7XYXi1hJJoI0koiflC6K
   SWbBwBQgOX1VMr6x2jShvQf0LhTBkVTDaIe0coMu/PnrfO8kfgCKGnEz1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="388682561"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="388682561"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:38:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="836035487"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="836035487"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2023 08:38:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKMJW-00ERCy-2e;
        Tue, 24 Jan 2023 18:38:26 +0200
Date:   Tue, 24 Jan 2023 18:38:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9AJgpG0KlbA302N@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y86mhdQrcWMr58wV@smile.fi.intel.com>
 <Y8/8moorDUIseO3/@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/8moorDUIseO3/@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2023 at 05:43:22PM +0200, Sakari Ailus wrote:
> On Mon, Jan 23, 2023 at 05:23:49PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:

...

> > > +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> > > +						  unsigned int port)
> > > +{
> > 
> > > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> > 
> > It's used only once in this function, why not keeping it in the format string?
> 
> Twice, not once. My point was that it's critical the strings remain the
> same length, and certainly what that string actually is, is less important.

Still can be placed twice as is. But fine, I leave it to maintainers.

> > > +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> > > +
> > > +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> > > +		     mipi_port_prefix, port) > sizeof(mipi_port_name)) {

Btw, seems also a candidate for >= ?

> > > +		acpi_handle_info(acpi_device_handle(device),
> > > +				 "mipi port name too long for port %u\n", port);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	return fwnode_get_named_child_node(acpi_fwnode_handle(device),
> > > +					   mipi_port_name);
> > > +}

...

> > > +			/* Move polarity bits to the lane polarity u32 array */
> > > +			for (i = 0; i < 1 + num_lanes; i++)
> > > +				port->lane_polarities[i] =
> > > +					(u.val8[i >> 3] & (1 << (i & 7))) ?
> > > +					1U : 0U;
> > 
> > Wouldn't
> > 
> > 				port->lane_polarities[i] =
> > 					!!(u.val8[i >> 3] & (1 << (i & 7)));
> > 
> > be better?
> 
> It would work, yes, although the target is a u32. Casting to bool would
> look nicer to me. I lean towards what it is at the moment but bool seems
> fairly reasonable, too.

I think we can do even better and switch this to bitmap APIs.

I'll comment separately with the better context given.

...

> dev->fwnode hasn't been set when assigning the secondary fwnode in
> acpi_init_swnodes(), therefore set_secondary_fwnode() won't do what it
> should.
> 
> It can be still called here as it just sets dev->fwnode->secondary NULL.
> 
> I can add a comment mentioning this.

Or maybe drop the use of the specific API and rather do something similar
to the above?

> I think it'd be better to have a set of fwnodes attached to a device rather
> than one primary and another secondary, with various levels of success
> depending on the order of assigning them. But I think it's out of scope of
> this set.

Yeah, but it's quite a big topic out of the scope of this series.

-- 
With Best Regards,
Andy Shevchenko


