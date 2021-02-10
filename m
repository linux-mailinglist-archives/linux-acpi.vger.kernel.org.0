Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0837E316A6C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 16:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBJPns (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 10:43:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:18202 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhBJPnr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 10:43:47 -0500
IronPort-SDR: EWSDkVU5rB8MQ3t6ScDSvTudtdKCEoveWlz+M5LbKAVzNZFwLC4Es10SaxzY2bj8E7LCQ3Coc9
 vjTviL1VzFmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178584187"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="178584187"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 07:42:01 -0800
IronPort-SDR: KqKsFD0pE+N6mm+7R8exlCz3NEjFfZvF+j+UWoqctMedEgvXKpSM0oCx5B31seArcurG+Gvjr5
 7aLzwvsxOhuQ==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="436712855"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 07:41:59 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9rcq-003lGo-M0; Wed, 10 Feb 2021 17:41:56 +0200
Date:   Wed, 10 Feb 2021 17:41:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Subject: Re: [PATCH v1 7/7] ACPI: property: Allow counting a single value as
 an array of 1 element
Message-ID: <YCP+xOuic5fPx+7i@smile.fi.intel.com>
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
 <3881654.NPl3a4M0kB@kreacher>
 <1946478.1QpZic6vku@kreacher>
 <YCPyKjO7XPBFAgbn@smile.fi.intel.com>
 <CAJZ5v0jq1+q3HKDEzgBUWtZY8H0kaiR=bNi1WUsdg3BTAyiPgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jq1+q3HKDEzgBUWtZY8H0kaiR=bNi1WUsdg3BTAyiPgw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 04:01:16PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 10, 2021 at 3:48 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Feb 10, 2021 at 02:48:09PM +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, February 10, 2021 2:31:48 PM CET Rafael J. Wysocki wrote:
> > > > On Wednesday, February 10, 2021 1:36:00 PM CET Rafael J. Wysocki wrote:
> > > > > On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > > > -       if (val && nval == 1) {
> > > > > > +       /* Try to read as a single value first */
> > > > > > +       if (!val || nval == 1) {
> > > > > >                 ret = acpi_data_prop_read_single(data, propname, proptype, val);
> > > > >
> > > > > This returns -EINVAL if val is NULL.
> >
> > Nope. That's why it's a patch 7. Patch 6 solves this.
> 
> That's my point.  Patch 7 should be the first one in the series.

Ah, okay. Since you want this let me rebase.

> > > > > >                 if (ret >= 0)
> > > > > > -                       return ret;
> > > > > > +                       return val ? ret : 1;
> > > > >
> > > > > So val cannot be NULL here.
> >
> > Why not? I have changed conditional.
> >
> > > > > >         }
> >
> > > > > To me, acpi_fwnode_property_read_string_array() needs to special-case
> > > > > val == NULL and nval == 0.
> >
> > nval can be anything in the case of val==NULL. So far neither of your proposals
> > conform this.
> 
> That is if !val and nval != 0 is regarded as a valid combination of
> arguments, but is it?

I believe nobody tested that.

> If that is the case, the check in acpi_data_prop_read() in the last
> patch that I posted needs to be (!val || nval == 1), but that would be
> it, no?

I think it also needs the conditional at return as in my patch.

-- 
With Best Regards,
Andy Shevchenko


