Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49FD331766
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCHTfl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:35:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:48972 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhCHTfe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:35:34 -0500
IronPort-SDR: GYy1pWgaiIsb7EaqdoOMK8I9ZiwbGB6lMZT1N2NFrXhwVScNUu6D9GgenMWEZFLWkwkaiLss7T
 Wt89UHyzMxKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="207861284"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="207861284"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:35:33 -0800
IronPort-SDR: Avg4evT/rxHYkCzbs6nn161uyQe8wHCr26e3ZFPgMfdltdCJN4UIqX7HkUWM8W27SbO5gaefad
 a/V9jFlDOS/A==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="385964640"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:35:31 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJLf5-00AteC-Vo; Mon, 08 Mar 2021 21:35:27 +0200
Date:   Mon, 8 Mar 2021 21:35:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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
Message-ID: <YEZ8f3En2ZEqJX+X@smile.fi.intel.com>
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com>
 <CAMpxmJUQ3r0YCeQvPq=SW57w-5BLtoTO1_bv=2uw6CX_1-EXcQ@mail.gmail.com>
 <CAJZ5v0h7zUMU9DMofa3fhop9fYY6UJQ6Nm3xBOmG48bcmLCj3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h7zUMU9DMofa3fhop9fYY6UJQ6Nm3xBOmG48bcmLCj3w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2021 at 08:26:39PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 8, 2021 at 8:23 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> > On Mon, Mar 8, 2021 at 7:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Mar 4, 2021 at 9:13 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

> > AFAICT this should go through the GPIO tree as usual. Any reason for
> > you to pick these patches this time?
> 
> My impression was that Andy wanted me to take them.

Hmm... I guess the MAINTAINERS pointed to your name due to changes in GPIO ACPI
library, but most of them indeed are GPIO core ones. Perhaps I have to clarify
that in the cover letter.

> However, if you'd rather take care of them yourself, there you go!
> 
> I'll drop them now and assume that they will be routed through the GPIO tree.

Anyway, thank you for the review, it is useful!

-- 
With Best Regards,
Andy Shevchenko


