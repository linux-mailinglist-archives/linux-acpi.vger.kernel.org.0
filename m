Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C5244C96
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHNQXT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 12:23:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:48562 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgHNQXT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Aug 2020 12:23:19 -0400
IronPort-SDR: sQZDqB8//LxIRwEw9LL+N/xf8AFZriJAqgem/gGAKZtePWYBJTaETbUU2Ai7hDH6/+vP9s+kyZ
 /4qG9x3P6pOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="153682449"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="153682449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 09:23:18 -0700
IronPort-SDR: fGrQeeP7cib9WX8F4TsE5BKlmHSUut85bG79KBOrPmpCVk+10VKB6RIus0ranb4CMVC4Bid4H8
 fZFKB2cWBbOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="325766963"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 09:23:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6cS1-008gVM-Bw; Fri, 14 Aug 2020 19:21:05 +0300
Date:   Fri, 14 Aug 2020 19:21:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] resource: Introduce resource_union() for
 overlapping resources
Message-ID: <20200814162105.GX1891694@smile.fi.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <20200813175729.15088-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iDZ6UZK_WW6pvWCqsrUH3uqfjRXSoMDTsAcbXoBuMYqw@mail.gmail.com>
 <20200814153730.GQ1891694@smile.fi.intel.com>
 <CAJZ5v0jOA30iL6AQq3BEY=N3xQdvpC0BJEcLzz2Frv+CByKhPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jOA30iL6AQq3BEY=N3xQdvpC0BJEcLzz2Frv+CByKhPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 14, 2020 at 06:09:53PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 14, 2020 at 5:37 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Aug 14, 2020 at 05:23:07PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > Well, what about using min() and max() here?
> >
> > I devoted one paragraph in the commit message to answer this. The kernel.h
> > (which I'm planning to split at some point) is a monster which brings more pain
> > than solves here. Note, this is a header file and it's quite clean from
> > dependencies perspective.
> 
> But this is code duplication (even if really small) and it is not
> entirely clean too.
> 
> Maybe move the definitions of min() and max() to a separate header file?

That is the plan in the kernel.h splitting project. But do you want me to do it
here? I can try to bring that patch into this series.

-- 
With Best Regards,
Andy Shevchenko


