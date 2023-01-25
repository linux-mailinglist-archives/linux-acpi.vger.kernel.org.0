Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7367B1D6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjAYLq2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAYLq1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:46:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118D47D8F;
        Wed, 25 Jan 2023 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674647187; x=1706183187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LEsZU5oU0nUET33htT8onhPY0yVQJFPqvzOjU3nXvpM=;
  b=SNR0jSSbpVhf82/I3O6BnT7riJUJdWJKT7JPrAeLcnmz/UHKW7dJzQyW
   bZ7EFIQkXBvPGaigdgrpriaVd0LbKnEhR5EAv36QCDGfaMoo9hDKc45CV
   gMaKBZCAf2/lgYFo5+/a2F8O635N8fxnyv6f2X8Sk+SEbxnseY9KCUDZ2
   W56mg0qmkcVZVvPAOc5qtsuQEqkSsrOtJb9S8Kd8Z7i1WZiz3ujIt1bSc
   xJRnjmmSetL3Rdq3w/pdzsRdimdmdJEKrH7thHwiTlr9PPxi5hnQbijnK
   hy0WeKvNrx8Y55mm941YLceCZGSp0v4XL4DKY0iXg0SiApe5rGnE0KTqq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306199302"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306199302"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 03:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="804978703"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="804978703"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2023 03:46:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKeEO-00EpVX-1V;
        Wed, 25 Jan 2023 13:46:20 +0200
Date:   Wed, 25 Jan 2023 13:46:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9EWjBEwu4s96DPa@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
 <Y9DuyZUr3McCPGuh@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9DuyZUr3McCPGuh@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 25, 2023 at 10:56:41AM +0200, Sakari Ailus wrote:
> On Tue, Jan 24, 2023 at 09:26:31PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:

...

> > > +		if (num_lanes > ARRAY_SIZE(port->data_lanes)) {
> > 
> > 		>= MAX_LANES(port)
> 
> I find the original better: it does this by referring to the array itself.

Whatever, it's just an example to show where it's being used.

> > > +			acpi_handle_warn(acpi_device_handle(device),
> > > +					 "too many data lanes (%u)\n",
> > > +					 num_lanes);
> > > +			num_lanes = ARRAY_SIZE(port->data_lanes);
> > 
> > 			= MAX_LANES(port) - 1;
> > 
> > > +		}

...

> > 	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-dlane-polarities");
> > 	if (ret < 0) {
> > 		acpi_handle_debug(acpi_device_handle(device),
> > 				  "no lane polarity provided\n");
> > 	} else if (ret < 1 + num_lanes) {
> > 		acpi_handle_warn(acpi_device_handle(device),
> > 				 "too few lane polarity bytes (%u)\n", bytes);
> > 	} else {
> > 		// assuming we dropped the union and renamed to val...
> > 		ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> > 						    "mipi-img-lane-polarities",
> > 						    val, sizeof(val));
> > 		if (ret) {
> > 			...can't read... (debug message?)
> > 		} else {
> > 			unsigned int i;
> > 
> > 			for (i = 0; i < 1 + num_lanes; i++)
> > 				bitmap_set_value8(polarity, val[i], i * BITS_PER_BYTE);
> 
> You'll still needed to access invididual bits in val.

I didn't get this. The below is what it does in most efficient way.

> > 			// assuming that lane_polarities is zeroed by default...
> > 			for_each_set_bit(i, polarity, 1 + num_lanes)
> > 				port->lane_polarities[i] = 1;

Note that his code lacks of endianess issues.

> > 		}
> > 	}

-- 
With Best Regards,
Andy Shevchenko


