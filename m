Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6DF6782FC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 18:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjAWRYl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 12:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjAWRYk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 12:24:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78758A275;
        Mon, 23 Jan 2023 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674494678; x=1706030678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zl8C9FX9Kwb+SUc6XRL7M9CKn/LKKz+nfvnr/MjjKm0=;
  b=aUTGG0yTNRDbEAIYXobtHoKKHYddVLuT6ZnAHSKfG2ENtP38P6hnV+9N
   GT7zfUZiSdMSDvnADSm0M3D+TLkPd0G/f4ZIaVJCbwQvg8KBJ7HuKGwha
   KIyQ/6m+Y4NhcNadfWP6CGNO2c4TG1aE/iGen8ildAXXpQuUtx/nwNsD1
   hxpfkD5NLUChbgFsiT4jbxCcB5WkuEQUZ05DsHPRpOdJGTWXwawrDRAH/
   7V/K0T0j5zbSbmnOi5sKsLmRpNgnBtvzj2HYe27FaRPmZQNJhAzq+1P2/
   6pUdcM78ImDCFSX9McRJsR/2vGCbhGpHgfnpSV2ct8rEbIX5MMjjSd0hb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305756555"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="305756555"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="611697261"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="611697261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 23 Jan 2023 09:19:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pK0Tx-00DqdO-1j;
        Mon, 23 Jan 2023 19:19:45 +0200
Date:   Mon, 23 Jan 2023 19:19:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 1/8] ACPI: property: Parse data node string references
 in properties
Message-ID: <Y87Bsf7xaFmqmgU8@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-2-sakari.ailus@linux.intel.com>
 <Y86e9YeHXrNLfwHY@smile.fi.intel.com>
 <Y86tl2YIP5ZX5W7p@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86tl2YIP5ZX5W7p@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 05:53:59PM +0200, Sakari Ailus wrote:
> On Mon, Jan 23, 2023 at 04:51:33PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 23, 2023 at 03:46:10PM +0200, Sakari Ailus wrote:

...

> > > - * Copyright (C) 2014, Intel Corporation
> > > + * Copyright (C) 2014--2023, Intel Corporation
> > 
> > Isn't one dash enough? 
> > 
> > $ git grep -n 'opyright.*[0-9]--[0-9]' | wc -l
> > 37
> > 
> > $ git grep -n 'opyright.*[0-9]-[0-9]' | wc -l
> > 15064
> 
> This is a range, not hyphenation. There's no different character in the
> ASCII character set for the former, commonly two regular dashes are used.
> There probably would be a correct Unicode character though.

Fine, but it's not even close to be called "a common use" as I showed by
running `git grep`.

> > >   * All rights reserved.
> > >   *
> > >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >   *          Darren Hart <dvhart@linux.intel.com>
> > >   *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > + *	    Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > Seems wrong indentation in comparison to the others.
> 
> Tabs are preferred for intendation. I can change all the lines to use tab.

Dunno, not a maintainer. I just pointed to inconsistency in the comment lines.

> > >   */

...

> > > +static struct fwnode_handle *
> > > +acpi_parse_string_ref(const struct fwnode_handle *fwnode, const char *refstring)
> > > +{
> > > +	acpi_handle scope, handle;
> > > +	struct acpi_data_node *dn;
> > > +	struct acpi_device *device;
> > > +	acpi_status status;
> > > +
> > > +	if (is_acpi_device_node(fwnode)) {
> > 
> > > +		scope = to_acpi_device_node(fwnode)->handle;
> > 
> > Interestingly that we have a helper for this -- ACPI_HANDLE_FWNODE()...
> > 
> > > +	} else if (is_acpi_data_node(fwnode)) {
> > 
> > > +		scope = to_acpi_data_node(fwnode)->handle;
> > 
> > ...but not for this.
> 
> I'd either prefer to keep them as-is, as it's easy to see what's being done
> there, or add a new macro --- or a function to do this.  Say,
> acpi_fwnode_acpi_handle(), as this is clearly ACPI specific and to
> differentiate between ACPI handles and fwnode handles.

Since it's an ACPI glue layer code, I'm not insisting on changes. Just pointed
out that we have a helper function for one of the cases.

> ACPI_HANDLE_FWNODE()'s name suggests it would do something else than it
> does, if you consider the current fwnode API.

-- 
With Best Regards,
Andy Shevchenko


