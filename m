Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490703423FF
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSSGr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 14:06:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:56593 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhCSSGY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 14:06:24 -0400
IronPort-SDR: ckvKblsVR9f4OeKUSW5ZpmtlVEG5iI3k78uid9Gxz/rDlco5AHmmS1zlv6Myx61k3lwHKCiSu2
 dbh5bLHxnNaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="187595067"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="187595067"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:06:23 -0700
IronPort-SDR: /AnKk4h0Ng4+xzjWlggIp7YBDN2uKRn8cfFOGGOWQ3cP2q9+QqcPybMg/CwhcEXHPYnS/erhWA
 JUHfBruesqNA==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="450954496"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:06:21 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lNJVq-00Dw7c-LM; Fri, 19 Mar 2021 20:06:18 +0200
Date:   Fri, 19 Mar 2021 20:06:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: scan: Use unique number for instance_no
Message-ID: <YFToGiFbGkJDDaMF@smile.fi.intel.com>
References: <20210312160137.19463-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jHXQC+P1_FTq6TkMKAb=FsBH=cw3mUkp9rJUC7R1B-5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jHXQC+P1_FTq6TkMKAb=FsBH=cw3mUkp9rJUC7R1B-5A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 06:00:38PM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 12, 2021 at 5:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Current mechanism of incrementing and decrementing plain integer
> > to get a next free instance_no when creating an ACPI device is fragile.
> >
> > In case of hot plug event or namespace removal of the device instances
> > with the low numbers the plain integer counter can't cover the gaps
> > and become desynchronized with real state of affairs. If during next
> > hot plug event or namespace injection the new instances of
> > the devices need to be instantiated, the counter may mistakenly point
> > to the existing instance_no and kernel will complain:
> > "sysfs: cannot create duplicate filename '/bus/acpi/devices/XXXX1234:02'"
> 
> This is a slightly convoluted way of stating that there is a bug in
> acpi_device_del().

Any suggestion how to massage the above?
But in the dry end, yes, decrementing is a bug.

> Yes, there is one, the instance_no decrementation is clearly incorrect.
> 
> > Replace plain integer approach by using IDA framework.
> 
> Also the general idea of using IDA for the instance numbering is a good one IMO.

...

> > -       unsigned int instance_no;
> > +       struct ida no;
> 
> struct ida instance_ida; ?

Will rename.

...

> > +       p = strrchr(dev_name(&device->dev), ':');
> > +       if (!p)
> > +               return -ENODATA;
> > +
> > +       error = kstrtoint(p + 1, 16, &result);
> > +       if (error)
> > +               return error;
> > +
> > +       return result;
> 
> I don't like the above at all.
> 
> I would just store the instance number in struct acpi_device_pnp (say).

TBH, I simply didn't know which struct to touch and left this one and I also
don't like it. Lemme see if acpi_device_pnp is good enough for that.

-- 
With Best Regards,
Andy Shevchenko


