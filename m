Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3124681CF0
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 22:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjA3Vjv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 16:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjA3Vjv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 16:39:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77F1BFE;
        Mon, 30 Jan 2023 13:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114788; x=1706650788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7J9t2HM2IrFNmxlK+RmoyN8XqqQ8IpiRNwAmu8uEdv8=;
  b=buEN6SvEeOgYmIsRlK27EdejuPgo45VC2NgIH3WXJpnyKFyES9pCMW24
   KaDfTKovDJ2vUQwvuSTOhg7uOnVvwwKl9QZC1Qmh7w1DE2tXgGbfrkTn4
   pFeJn2Figm4N0eG+pMeCPWhjU+vQHP4RWOqSC/hkXfy6pdVlTrBHazhnf
   GcFYHQb+kyB2KS7lbW4Dys5hslbqzNroHUYJe5MLEWfWRfrpyvOL3s+++
   H1tIts0q6SIJM76WB4IEhteces0CoQsVKkkAiKiANezg3Dr7YGj6/1d2G
   FZarokHTTceWWs6OM1kcdhT96cTfVkA9J7oAQ1rxVSQ5DPEG6g1VDORlx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392227470"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="392227470"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732847320"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="732847320"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2023 13:39:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMbsP-00HZ0k-1F;
        Mon, 30 Jan 2023 23:39:45 +0200
Date:   Mon, 30 Jan 2023 23:39:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9g5ISkhsJs1Dbgf@smile.fi.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-5-sakari.ailus@linux.intel.com>
 <Y9Oo4L0ToRTZye2Z@smile.fi.intel.com>
 <Y9g0+L4zrdBtcpZP@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9g0+L4zrdBtcpZP@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2023 at 11:22:00PM +0200, Sakari Ailus wrote:
> On Fri, Jan 27, 2023 at 12:35:12PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 26, 2023 at 12:40:57AM +0200, Sakari Ailus wrote:

...

> > > +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> > > +						  unsigned int port)
> > > +{
> > > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> > > +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> > 
> > I think the following will be better:
> > 
> > 	char mipi_port_name[16];
> 
> If the array is too short, this will generate a warning but... this is
> already handled better than that. Why not to keep it?

We will get the format string self contained.

> > > +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> > > +		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {
> > 
> > 	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "mipi-img-port-%u",
> > 		     port) >= sizeof(mipi_port_name)) {
> > 
> > > +		acpi_handle_info(acpi_device_handle(device),
> > > +				 "mipi port name too long for port %u\n", port);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	return fwnode_get_named_child_node(acpi_fwnode_handle(device),
> > > +					   mipi_port_name);
> > > +}

...

> > > +	union {
> > > +		u32 val;
> > 
> > OK. I stopped here, because I'm not sure you have really sent an updated
> > version. For sure the val and union is not used.
> 
> Indeed. My apologies --- I missed making a few changes I intended to do.
> I'll go through those once more and then send v4.

Thank you!

> > > +		/* Data lanes + the clock lane */
> > > +		u8 val8[BITS_TO_BYTES(ARRAY_SIZE(port->data_lanes) + 1)];
> > > +	} u;

-- 
With Best Regards,
Andy Shevchenko


