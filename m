Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595573ED794
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhHPNhx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 09:37:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:60290 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237230AbhHPNhR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 09:37:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="237925164"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="237925164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 06:35:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="509701852"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 06:35:45 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mFcmA-00APGI-NO; Mon, 16 Aug 2021 16:35:38 +0300
Date:   Mon, 16 Aug 2021 16:35:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/1] x86/platform: Increase maximum GPIO number for
 X86_64
Message-ID: <YRppqnAqJ1G+4mva@smile.fi.intel.com>
References: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iTNwQfh6ZZxry16hOjokGOOSZthq6C_yed07a2HQ7h2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iTNwQfh6ZZxry16hOjokGOOSZthq6C_yed07a2HQ7h2Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 03:25:13PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 6, 2021 at 4:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > By default the 512 GPIOs is a maximum on any x86 platform.
> > With, for example, Intel Tiger Lake-H the SoC based controller
> > occupies up to 480 pins. This leaves only 32 available for
> > GPIO expanders or other drivers, like PMIC. Hence, bump the
> > maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.

Thanks for review, my answers below.

> > +# The GPIO number here must be sorted by descending number. In case of
> > +# a multiplatform kernel, we just want the highest value required by the
> > +# selected platforms.
> > +config ARCH_NR_GPIO
> > +       int
> > +       default 1024 if X86_64
> > +       default 512 if X86_32
> > +       default 0
> 
> Wouldn't
> 
> default 1024 if X86_64
> default 512
> 
> be sufficient?
> 
> It's either X86_64 or X86_32 anyway AFAICS.

I guess so.

> > +       help
> > +         Maximum number of GPIOs in the system.
> > +
> > +         If unsure, leave the default value.

Btw, what do you think. do we need comment above and help text here? I copied
these from ARM, but I'm not sure it would be useful on x86 as much.


-- 
With Best Regards,
Andy Shevchenko


