Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67A62FE811
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 11:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbhAUKvi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 05:51:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:47845 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729800AbhAUKv2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 05:51:28 -0500
IronPort-SDR: LX5cH+jqCv7lJ255IediMs20JFOIv0AJM2zREfSZfsZZ5Debv8mFAT4s+0Xdu9xMQjqhudN2Th
 BTNdhyTpDjOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158430067"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="158430067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:49:41 -0800
IronPort-SDR: ytMdTu6t6jXggkalWWS/ai6nveuZOIW76KCY5D+jBagvuZvS7Ro/IHCNSzdRDFkHw0H3Gl1Bsp
 oPOgvSNikulg==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="356419120"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:49:38 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Jan 2021 12:49:34 +0200
Date:   Thu, 21 Jan 2021 12:49:34 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible"
 modalias
Message-ID: <20210121104934.GS1988617@lahna.fi.intel.com>
References: <20210119081513.300938-1-kai.heng.feng@canonical.com>
 <YAaXz9Pg5x3DsCs3@kroah.com>
 <CAAd53p7tdFiARtW1RXsjN8+OwRXWzMnok_rfKHDHCh-JSam3cQ@mail.gmail.com>
 <20210119094159.GQ4077@smile.fi.intel.com>
 <YAa1ygjr2L3VxBKF@kroah.com>
 <CAAd53p4MTSzuPEp3Y5=wP3HwguTOkyTrVZpi6xOCS0_Q1qcMdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4MTSzuPEp3Y5=wP3HwguTOkyTrVZpi6xOCS0_Q1qcMdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 21, 2021 at 02:22:43PM +0800, Kai-Heng Feng wrote:
> On Tue, Jan 19, 2021 at 6:34 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jan 19, 2021 at 11:41:59AM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 19, 2021 at 04:41:48PM +0800, Kai-Heng Feng wrote:
> > > > On Tue, Jan 19, 2021 at 4:27 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Tue, Jan 19, 2021 at 04:15:13PM +0800, Kai-Heng Feng wrote:
> > >
> > > ...
> > >
> > > > > Who will use OF_MODALIAS and where have you documented it?
> > > >
> > > > After this lands in mainline, I'll modify the pull request for systemd
> > > > to add a new rule for OF_MODALIAS.
> > > > I'll modify the comment on the function to document the change.
> > >
> > > I'm wondering why to have two fixes in two places instead of fixing udev to
> > > understand multiple MODALIAS= events?
> >
> > It's not a matter of multiple events, it's a single event with a
> > key/value pair with duplicate keys and different values.
> >
> > What is this event with different values supposed to be doing in
> > userspace?  Do you want multiple invocations of `modprobe` or something
> > else?
> >
> > Usually a "device" only has a single "signature" that modprobe uses to
> > look up the correct module for.  Modules can support any number of
> > device signatures, but traditionally it is odd to think that a device
> > itself can be supported by multiple modules, which is what you are
> > saying is happening here.
> >
> > So what should userspace do with this, and why does a device need to
> > have multiple module alias signatures?
> 
> >From the original use case [1], I think the "compatible" modalias
> should be enough.
> Andy and Mika, what do you think? Can we remove the ACPI modalias for this case?

Yes, I think that should work. After all we want the match to happen
through the DT compatible string if the property is present, not through
ACPI IDs.
