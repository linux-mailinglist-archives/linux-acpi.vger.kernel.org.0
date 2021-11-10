Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9229144C1ED
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhKJNP6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 08:15:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:27513 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhKJNP6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 08:15:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="212690953"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="212690953"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 05:13:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="546096100"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 05:13:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mknPM-005QKU-Ai;
        Wed, 10 Nov 2021 15:12:56 +0200
Date:   Wed, 10 Nov 2021 15:12:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] ACPI: Get acpi_device's parent from the parent field
Message-ID: <YYvFWE3aFq5L2CM4@smile.fi.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
 <20211109111935.1627406-2-sakari.ailus@linux.intel.com>
 <YYpnQaZ7u9Zqr0Qb@smile.fi.intel.com>
 <YYt+IDubi6ib/Iko@paasikivi.fi.intel.com>
 <YYuATCA2yyCFBFN5@smile.fi.intel.com>
 <YYuBEFXINuk6zmL8@paasikivi.fi.intel.com>
 <YYuJSsNRFDvBZ6LP@smile.fi.intel.com>
 <YYu07IEMU17Z+6UQ@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYu07IEMU17Z+6UQ@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2021 at 02:02:52PM +0200, Sakari Ailus wrote:
> On Wed, Nov 10, 2021 at 10:56:42AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 10, 2021 at 10:21:36AM +0200, Sakari Ailus wrote:
> > > On Wed, Nov 10, 2021 at 10:18:20AM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 10, 2021 at 10:09:04AM +0200, Sakari Ailus wrote:
> > > > > On Tue, Nov 09, 2021 at 02:19:13PM +0200, Andy Shevchenko wrote:
> > > > > > On Tue, Nov 09, 2021 at 01:19:34PM +0200, Sakari Ailus wrote:

...

> > > > > > > -	} else if (is_acpi_device_node(fwnode)) {
> > > > > > > +	}
> > > > > > 
> > > > > > > +	if (is_acpi_device_node(fwnode)) {
> > > > > > 
> > > > > > Unneeded change. Yes I know that 'else' here can be skipped. But in such cases
> > > > > > it's a trade-off between changes, code readability and maintenance. Since here
> > > > > > it's a fix, backporting concerns are also play role.
> > > > > 
> > > > > The patch applies cleanly to 5.5, the oldest kernel where it's needed.
> > > > 
> > > > Why? I don't see how this affects the workflow.
> > > > 
> > > > > Do you prefer another patch to remove the else clause?
> > > > 
> > > > Nope.
> > > > 
> > > > > I think it's a bit overkill...
> > > > 
> > > > Exactly, that's why the question is why have you split the if-else-if to
> > > > two if:s?
> > > 
> > > The else clause is useless, I think the code simply looks better without
> > > it.
> > 
> > I see a contradiction here:
> > 
> > Statement 1: 'else' is useless.
> > Statement 2: patch to remove it is overkill.
> 
> There's no contradiction.
> 
> I argue doing that in a separate patch is waste of everyone's time. As
> simple as that.

And this is precisely my point. But my other point is that doing this in the
fix patch is a churn. Bottom line, this part of the change shouldn't be here.

Also, it increases LOC counts. You may submit a separate patch to fix all of
the redundant 'else':s and we will see the necessity of them. But it's does
not belong to the patch you provided here.

Hope this clarifies my point.

-- 
With Best Regards,
Andy Shevchenko


