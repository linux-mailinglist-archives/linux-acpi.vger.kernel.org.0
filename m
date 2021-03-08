Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1126331770
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCHThS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:37:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:49835 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231556AbhCHTg7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:36:59 -0500
IronPort-SDR: u5Rqsf8rmZcyopYdOQ2eSq2/pU61Sdk++TWsWFfrz4lXV/0/uYDglnhlFN2wIe1SqpYrhcUzd/
 z8XdOySOUnKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273121247"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="273121247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:36:59 -0800
IronPort-SDR: r/fPpzFDexipQ3qbIF2/fhhMhywaaHnqBtW3RzysJoSvubAzJUL/6CtBmWIylLJVFO2LKIF4Mo
 NcBXSLF/gOXA==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="437601268"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:36:55 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJLgS-00Atf7-35; Mon, 08 Mar 2021 21:36:52 +0200
Date:   Mon, 8 Mar 2021 21:36:52 +0200
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
Message-ID: <YEZ81OraApPIu8d9@smile.fi.intel.com>
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com>
 <CAMpxmJUQ3r0YCeQvPq=SW57w-5BLtoTO1_bv=2uw6CX_1-EXcQ@mail.gmail.com>
 <CAJZ5v0h7zUMU9DMofa3fhop9fYY6UJQ6Nm3xBOmG48bcmLCj3w@mail.gmail.com>
 <CAMpxmJXa2Qxznss3c79Zf-PzsX=SY6WOJorAMvS-UxKoViKP_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXa2Qxznss3c79Zf-PzsX=SY6WOJorAMvS-UxKoViKP_w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2021 at 08:29:27PM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 8, 2021 at 8:26 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Mar 8, 2021 at 8:23 PM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:

...

> > My impression was that Andy wanted me to take them.
> >
> > However, if you'd rather take care of them yourself, there you go!
> >
> > I'll drop them now and assume that they will be routed through the GPIO tree.
> >
> > Thanks!
> 
> They touch a lot of core GPIO code and are likely to conflict if any
> other changes show up this release cycle. I'd rather take them through
> the usual channel. Thanks!

Since now we have v4 based on Rafael's bleeding-edge, what do you want me to
do? Resend a v5 with all patches included?


-- 
With Best Regards,
Andy Shevchenko


