Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C950D67B20E
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjAYLxl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjAYLxk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:53:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237DA65B3;
        Wed, 25 Jan 2023 03:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674647617; x=1706183617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dOwA2cWlgPJQMWl6A12oq4lOK6Kv7W9UQv5lJOQ8VCg=;
  b=K3cJqVvPZ/etejUDqPH/Hwx9tZHbc8d8jDKPRmi4BQupLNjGTSIGnfq6
   Uwt08BrmbjBuHvTvMSkFqujgz2nB+SehY5gZ33QAuRVkdQ/3i6EhI9UJ0
   9FSlpmZrYeu25VM9kBWuEenrT9PcqHaJchZMU6yhfoGy5GlRIWwJjUrbP
   bPSR+u1NEOQ6+XdwOoim0lnoh1mV+c06C+Ar5VK5NkQY4jPHLDIN2rDU+
   fw8FwOrAwzWWw5wxDDv792dYKREI79ZE0j+bsoKYp+O2g1xSK1DyREJB1
   5eJjFhUb6kA9jm52pe+6CZuxZ+q3RgRRHILQyo73eCTASfWAqLXJYwdo5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306886609"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306886609"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 03:53:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="770698426"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="770698426"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 03:53:35 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id D669B120C31;
        Wed, 25 Jan 2023 13:53:32 +0200 (EET)
Date:   Wed, 25 Jan 2023 13:53:32 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9EYPOmy2vEIzP7i@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
 <Y9DuyZUr3McCPGuh@kekkonen.localdomain>
 <Y9EWjBEwu4s96DPa@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9EWjBEwu4s96DPa@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, Jan 25, 2023 at 01:46:20PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 25, 2023 at 10:56:41AM +0200, Sakari Ailus wrote:
> > On Tue, Jan 24, 2023 at 09:26:31PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > +		if (num_lanes > ARRAY_SIZE(port->data_lanes)) {
> > > 
> > > 		>= MAX_LANES(port)
> > 
> > I find the original better: it does this by referring to the array itself.
> 
> Whatever, it's just an example to show where it's being used.
> 
> > > > +			acpi_handle_warn(acpi_device_handle(device),
> > > > +					 "too many data lanes (%u)\n",
> > > > +					 num_lanes);
> > > > +			num_lanes = ARRAY_SIZE(port->data_lanes);
> > > 
> > > 			= MAX_LANES(port) - 1;
> > > 
> > > > +		}
> 
> ...
> 
> > > 	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-dlane-polarities");
> > > 	if (ret < 0) {
> > > 		acpi_handle_debug(acpi_device_handle(device),
> > > 				  "no lane polarity provided\n");
> > > 	} else if (ret < 1 + num_lanes) {
> > > 		acpi_handle_warn(acpi_device_handle(device),
> > > 				 "too few lane polarity bytes (%u)\n", bytes);
> > > 	} else {
> > > 		// assuming we dropped the union and renamed to val...
> > > 		ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> > > 						    "mipi-img-lane-polarities",
> > > 						    val, sizeof(val));
> > > 		if (ret) {
> > > 			...can't read... (debug message?)
> > > 		} else {
> > > 			unsigned int i;
> > > 
> > > 			for (i = 0; i < 1 + num_lanes; i++)
> > > 				bitmap_set_value8(polarity, val[i], i * BITS_PER_BYTE);
> > 
> > You'll still needed to access invididual bits in val.
> 
> I didn't get this. The below is what it does in most efficient way.

Ah. You're assining eight bits at a time.

Then the loop ends too late as i refers to a byte, not bit. This can be
addressed though. And a BUILD_BUG_ON() check for polarity being large
enough will be needed.

I still find this more complicated than the original code that also does
not need a temporary buffer.

> 
> > > 			// assuming that lane_polarities is zeroed by default...
> > > 			for_each_set_bit(i, polarity, 1 + num_lanes)
> > > 				port->lane_polarities[i] = 1;
> 
> Note that his code lacks of endianess issues.
> 
> > > 		}
> > > 	}
> 

-- 
Kind regards,

Sakari Ailus
