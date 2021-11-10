Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB644C0B4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 13:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhKJMGu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 07:06:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:21295 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhKJMGi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 07:06:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="213383637"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="213383637"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 04:02:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="492073069"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 04:02:54 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 60272205BA;
        Wed, 10 Nov 2021 14:02:52 +0200 (EET)
Date:   Wed, 10 Nov 2021 14:02:52 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] ACPI: Get acpi_device's parent from the parent field
Message-ID: <YYu07IEMU17Z+6UQ@paasikivi.fi.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
 <20211109111935.1627406-2-sakari.ailus@linux.intel.com>
 <YYpnQaZ7u9Zqr0Qb@smile.fi.intel.com>
 <YYt+IDubi6ib/Iko@paasikivi.fi.intel.com>
 <YYuATCA2yyCFBFN5@smile.fi.intel.com>
 <YYuBEFXINuk6zmL8@paasikivi.fi.intel.com>
 <YYuJSsNRFDvBZ6LP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYuJSsNRFDvBZ6LP@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2021 at 10:56:42AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 10, 2021 at 10:21:36AM +0200, Sakari Ailus wrote:
> > On Wed, Nov 10, 2021 at 10:18:20AM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 10, 2021 at 10:09:04AM +0200, Sakari Ailus wrote:
> > > > On Tue, Nov 09, 2021 at 02:19:13PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Nov 09, 2021 at 01:19:34PM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > > > -	} else if (is_acpi_device_node(fwnode)) {
> > > > > > +	}
> > > > > 
> > > > > > +	if (is_acpi_device_node(fwnode)) {
> > > > > 
> > > > > Unneeded change. Yes I know that 'else' here can be skipped. But in such cases
> > > > > it's a trade-off between changes, code readability and maintenance. Since here
> > > > > it's a fix, backporting concerns are also play role.
> > > > 
> > > > The patch applies cleanly to 5.5, the oldest kernel where it's needed.
> > > 
> > > Why? I don't see how this affects the workflow.
> > > 
> > > > Do you prefer another patch to remove the else clause?
> > > 
> > > Nope.
> > > 
> > > > I think it's a bit overkill...
> > > 
> > > Exactly, that's why the question is why have you split the if-else-if to
> > > two if:s?
> > 
> > The else clause is useless, I think the code simply looks better without
> > it.
> 
> I see a contradiction here:
> 
> Statement 1: 'else' is useless.
> Statement 2: patch to remove it is overkill.

There's no contradiction.

I argue doing that in a separate patch is waste of everyone's time. As
simple as that.

Sure, it could be done, but usually ends up being left as-is.

-- 
Sakari Ailus
