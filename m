Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F929318F12
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhBKPpv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 10:45:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:52779 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhBKPoM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Feb 2021 10:44:12 -0500
IronPort-SDR: JpQupExjmq6mtb9pF/I915wBApfbGedsPOlt6XjSmXyo8Xm8HSeUpiQ6eeM4P4ZCl5dmEJWEpy
 D+gzr/MSvDAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="182332443"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="182332443"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 07:42:22 -0800
IronPort-SDR: 1bj7VsNtsDJU38kaYGWQgyRAa6CpRn5nQBB9VLr6ny7kZ2w25e3QviKjulCGQKZj12/UeaVrrb
 jnrYHSKXgIYw==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="437156945"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 07:42:20 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lAE6k-004Fw6-16; Thu, 11 Feb 2021 17:42:18 +0200
Date:   Thu, 11 Feb 2021 17:42:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Subject: Re: [PATCH v1 7/7] ACPI: property: Allow counting a single value as
 an array of 1 element
Message-ID: <YCVQWgg6L5YcAXO1@smile.fi.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
 <3881654.NPl3a4M0kB@kreacher>
 <1946478.1QpZic6vku@kreacher>
 <YCPyKjO7XPBFAgbn@smile.fi.intel.com>
 <CAJZ5v0jq1+q3HKDEzgBUWtZY8H0kaiR=bNi1WUsdg3BTAyiPgw@mail.gmail.com>
 <YCP+xOuic5fPx+7i@smile.fi.intel.com>
 <CAJZ5v0iCe=GuauCVzLG83urBHghO0suabHcMg2Kw54XFjBqCbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iCe=GuauCVzLG83urBHghO0suabHcMg2Kw54XFjBqCbw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 04:44:34PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 10, 2021 at 4:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Feb 10, 2021 at 04:01:16PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Feb 10, 2021 at 3:48 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Feb 10, 2021 at 02:48:09PM +0100, Rafael J. Wysocki wrote:
> > > > > On Wednesday, February 10, 2021 2:31:48 PM CET Rafael J. Wysocki wrote:
> > > > > > On Wednesday, February 10, 2021 1:36:00 PM CET Rafael J. Wysocki wrote:
> > > > > > > On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > > > > > -       if (val && nval == 1) {
> > > > > > > > +       /* Try to read as a single value first */
> > > > > > > > +       if (!val || nval == 1) {
> > > > > > > >                 ret = acpi_data_prop_read_single(data, propname, proptype, val);
> > > > > > >
> > > > > > > This returns -EINVAL if val is NULL.
> > > >
> > > > Nope. That's why it's a patch 7. Patch 6 solves this.
> > >
> > > That's my point.  Patch 7 should be the first one in the series.
> >
> > Ah, okay. Since you want this let me rebase.
> 
> Thanks!

I started rebasing and realised that your approach has swapped the error codes,
i.e. if it's a single-value and it is, e.g., 16-bit wide, the u8 read will
return 1, while it has to return -EOVERFLOW.

If you prefer, I can move two patches to the beginning, so one will be a good
prerequisite for this fix. And I'm still unsure about stable (Fixes tag is okay
to me), because the counting never worked from the day 1.

-- 
With Best Regards,
Andy Shevchenko


