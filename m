Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7633ED92D
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhHPOtW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 10:49:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:32699 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232095AbhHPOtW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 10:49:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="196140208"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="196140208"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 07:48:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="504935472"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 07:48:47 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mFduq-00AQUa-Ie; Mon, 16 Aug 2021 17:48:40 +0300
Date:   Mon, 16 Aug 2021 17:48:40 +0300
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
Message-ID: <YRp6yHt7JMmGvvQn@smile.fi.intel.com>
References: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iTNwQfh6ZZxry16hOjokGOOSZthq6C_yed07a2HQ7h2Q@mail.gmail.com>
 <YRppqnAqJ1G+4mva@smile.fi.intel.com>
 <CAJZ5v0ib7oP5EG2k6_Q0Yiq=_WGu01iGVDmV+QoVRLaxTXZHDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ib7oP5EG2k6_Q0Yiq=_WGu01iGVDmV+QoVRLaxTXZHDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 03:55:59PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 16, 2021 at 3:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Aug 16, 2021 at 03:25:13PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 6, 2021 at 4:44 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > Wouldn't
> > >
> > > default 1024 if X86_64
> > > default 512
> > >
> > > be sufficient?
> > >
> > > It's either X86_64 or X86_32 anyway AFAICS.

Fixed in v2.

...

> > Btw, what do you think. do we need comment above and help text here? I copied
> > these from ARM, but I'm not sure it would be useful on x86 as much.
> 
> Both the comment and the help text aren't particularly useful IMO.
> 
> The comment is a bit confusing even, because x86 kernels are
> multiplatform as a rule.

Ditto.


-- 
With Best Regards,
Andy Shevchenko


