Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801CD67ABDC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 09:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjAYIfG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 03:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjAYIfF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 03:35:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063C1449E;
        Wed, 25 Jan 2023 00:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674635698; x=1706171698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+cMHH+hV8T3hgfEPVg2jlFJxktRQQRXVpCUwb4gt8gw=;
  b=gHfRSf25KcBnFEax0pq9WWRf/FoeziJwNsY4OG7CgAN9IEfeXXN8lhGs
   2Ji2d/Dsn72X6Lx1rkzoesQ/UoAS9AzpNFZ9HoOQy/vXW/wURvzr3JUC5
   NpiAAPLeqAMTtrw786OTawtCj+fHgj/dAZPjyth+12Bc9Ub2P0vSM7EKr
   cbPXyiv9Y14Dmggc0izlyI4Hjawb4o1PuKx0ng7dECjFgeDLJcQeTvGie
   tG7CGZvvrjhrbdsrVqvq4P2mtaXtQVWDZUemJZcnHn5JGAM4FdPhmadrr
   vQqtgIYjUhcW5X6Iyq8DzX1BKqCNqipjEXkJwxWPUslF0DvmBLWNF+yf+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="327762290"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="327762290"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:34:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="786360254"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="786360254"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 00:34:56 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 6C420120C31;
        Wed, 25 Jan 2023 10:34:53 +0200 (EET)
Date:   Wed, 25 Jan 2023 10:34:53 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9DprUZN1OCHszjU@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y86mhdQrcWMr58wV@smile.fi.intel.com>
 <Y8/8moorDUIseO3/@kekkonen.localdomain>
 <Y9AJgpG0KlbA302N@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9AJgpG0KlbA302N@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Tue, Jan 24, 2023 at 06:38:26PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 24, 2023 at 05:43:22PM +0200, Sakari Ailus wrote:
> > On Mon, Jan 23, 2023 at 05:23:49PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> > > > +						  unsigned int port)
> > > > +{
> > > 
> > > > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> > > 
> > > It's used only once in this function, why not keeping it in the format string?
> > 
> > Twice, not once. My point was that it's critical the strings remain the
> > same length, and certainly what that string actually is, is less important.
> 
> Still can be placed twice as is. But fine, I leave it to maintainers.
> 
> > > > +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> > > > +
> > > > +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> > > > +		     mipi_port_prefix, port) > sizeof(mipi_port_name)) {
> 
> Btw, seems also a candidate for >= ?

Good catch. snprintf() excludes '\0' from the return value.

> 
> > > > +		acpi_handle_info(acpi_device_handle(device),
> > > > +				 "mipi port name too long for port %u\n", port);
> > > > +		return NULL;
> > > > +	}
> > > > +
> > > > +	return fwnode_get_named_child_node(acpi_fwnode_handle(device),
> > > > +					   mipi_port_name);
> > > > +}
> 
> ...
> 
> > > > +			/* Move polarity bits to the lane polarity u32 array */
> > > > +			for (i = 0; i < 1 + num_lanes; i++)
> > > > +				port->lane_polarities[i] =
> > > > +					(u.val8[i >> 3] & (1 << (i & 7))) ?
> > > > +					1U : 0U;
> > > 
> > > Wouldn't
> > > 
> > > 				port->lane_polarities[i] =
> > > 					!!(u.val8[i >> 3] & (1 << (i & 7)));
> > > 
> > > be better?
> > 
> > It would work, yes, although the target is a u32. Casting to bool would
> > look nicer to me. I lean towards what it is at the moment but bool seems
> > fairly reasonable, too.
> 
> I think we can do even better and switch this to bitmap APIs.
> 
> I'll comment separately with the better context given.

The problem with the bitmap APIs is that they work on unsigned long, so
there are endian issues that will need to be handled. I thing it's simply
not worth it: either you have temporary space for this or a new API is
needed. What the line above is, after all, fairly trivial.

> 
> ...
> 
> > dev->fwnode hasn't been set when assigning the secondary fwnode in
> > acpi_init_swnodes(), therefore set_secondary_fwnode() won't do what it
> > should.
> > 
> > It can be still called here as it just sets dev->fwnode->secondary NULL.
> > 
> > I can add a comment mentioning this.
> 
> Or maybe drop the use of the specific API and rather do something similar
> to the above?

Yes, that's what I actually thought. But still a comment is good to have
here, so someone doesn't try to convert this to use the functions intended
for this (!).

> 
> > I think it'd be better to have a set of fwnodes attached to a device rather
> > than one primary and another secondary, with various levels of success
> > depending on the order of assigning them. But I think it's out of scope of
> > this set.
> 
> Yeah, but it's quite a big topic out of the scope of this series.

Yes.

-- 
Regards,

Sakari Ailus
