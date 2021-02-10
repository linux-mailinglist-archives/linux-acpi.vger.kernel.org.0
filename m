Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF7316968
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 15:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBJOuC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 09:50:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:13533 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhBJOuC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 09:50:02 -0500
IronPort-SDR: xvWYcWCc+ABBAU9n+CTk/O48wMYVAFUzmW+n7F3pc0Yl4eGj54ztMO1m+87BP6k5DXGwQdixpU
 bqFZgeF+T9NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="178573131"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="178573131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 06:48:14 -0800
IronPort-SDR: Fz0huz8BxvaKkQQkanZeVSu1UIU6Bo+Wu0wJVcXCJ0Pjnmyd43g1oBvY+jOVmOuS7MjfRsgyyo
 4lzoiv+3soVw==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="436696420"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 06:48:12 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9qmo-003kft-6W; Wed, 10 Feb 2021 16:48:10 +0200
Date:   Wed, 10 Feb 2021 16:48:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Subject: Re: [PATCH v1 7/7] ACPI: property: Allow counting a single value as
 an array of 1 element
Message-ID: <YCPyKjO7XPBFAgbn@smile.fi.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
 <3881654.NPl3a4M0kB@kreacher>
 <1946478.1QpZic6vku@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1946478.1QpZic6vku@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 02:48:09PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 10, 2021 2:31:48 PM CET Rafael J. Wysocki wrote:
> > On Wednesday, February 10, 2021 1:36:00 PM CET Rafael J. Wysocki wrote:
> > > On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

Rafael, thanks for the review, my answers below.

> > > > We allow to read the single value as a first element in the array.
> > > > Unfortunately the counting doesn't work in this case and we can't
> > > > call fwnode_property_count_*() API without getting an error.
> > > 
> > > It would be good to mention what the symptom of the issue is here.

fwnode_property_match_string() is not working as reported by Calvin.

> > > > Modify acpi_data_prop_read() to always try the single value read
> > > > and thus allow counting the single value as an array of 1 element.
> > > >
> > > > Reported-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > This is a bug fix, so it should go in before the cleanups in this series IMO.

Seems it was never worked, hence neither Fixes tag nor...

> > > Also it looks like stable@vger material.

...Cc to stable@.

> > > > -       if (val && nval == 1) {
> > > > +       /* Try to read as a single value first */
> > > > +       if (!val || nval == 1) {
> > > >                 ret = acpi_data_prop_read_single(data, propname, proptype, val);
> > > 
> > > This returns -EINVAL if val is NULL.

Nope. That's why it's a patch 7. Patch 6 solves this.

> > > >                 if (ret >= 0)
> > > > -                       return ret;
> > > > +                       return val ? ret : 1;
> > > 
> > > So val cannot be NULL here.

Why not? I have changed conditional.

> > > >         }

> > > To me, acpi_fwnode_property_read_string_array() needs to special-case
> > > val == NULL and nval == 0.

nval can be anything in the case of val==NULL. So far neither of your proposals
conform this.




-- 
With Best Regards,
Andy Shevchenko


