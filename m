Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C493317C7
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCHTwT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:52:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:32862 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231793AbhCHTwK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:52:10 -0500
IronPort-SDR: sUw9a/cCFsBK7QMw0XrNG6QnVMFSpiir0/QptO77m5NvHCMApewaFPkHPIrQ/4S9PukWHMiZmS
 /6atf+JGygCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175207312"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="175207312"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:52:10 -0800
IronPort-SDR: 7uFkCqmgKRiEzh33tkOxdcdNEvYjXVov1HReAGzHtzQLwUOY4xUCOd+LG5No+4Z7fDSE4jlwzM
 S4BYrMQiw8mQ==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="385969574"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:52:07 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJLv9-00Atos-3L; Mon, 08 Mar 2021 21:52:03 +0200
Date:   Mon, 8 Mar 2021 21:52:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/5] gpiolib: switch to fwnode in the core
Message-ID: <YEaAY37PsqT6WQB9@smile.fi.intel.com>
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com>
 <CAMpxmJUQ3r0YCeQvPq=SW57w-5BLtoTO1_bv=2uw6CX_1-EXcQ@mail.gmail.com>
 <CAJZ5v0h7zUMU9DMofa3fhop9fYY6UJQ6Nm3xBOmG48bcmLCj3w@mail.gmail.com>
 <CAMpxmJXa2Qxznss3c79Zf-PzsX=SY6WOJorAMvS-UxKoViKP_w@mail.gmail.com>
 <YEZ81OraApPIu8d9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEZ81OraApPIu8d9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2021 at 09:36:52PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 08, 2021 at 08:29:27PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Mar 8, 2021 at 8:26 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Mon, Mar 8, 2021 at 8:23 PM Bartosz Golaszewski
> > > <bgolaszewski@baylibre.com> wrote:
> 
> ...
> 
> > > My impression was that Andy wanted me to take them.
> > >
> > > However, if you'd rather take care of them yourself, there you go!
> > >
> > > I'll drop them now and assume that they will be routed through the GPIO tree.
> > >
> > > Thanks!
> > 
> > They touch a lot of core GPIO code and are likely to conflict if any
> > other changes show up this release cycle. I'd rather take them through
> > the usual channel. Thanks!
> 
> Since now we have v4 based on Rafael's bleeding-edge, what do you want me to
> do? Resend a v5 with all patches included?

I have decided to resend as usually it's better for maintainers.

But it appears I was too quick to miss Rafael's review tag / comments.

So, I will send v6 with those included.

-- 
With Best Regards,
Andy Shevchenko


