Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACBF33223C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 10:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCIJlr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 04:41:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:43335 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhCIJl1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Mar 2021 04:41:27 -0500
IronPort-SDR: YAXP2GH/e0kOetX0FCCuqEs15INVoUonjJNl8qBL0EQlQIly1hrDFtnX6wQCfR5XWedZVvAJ0F
 R/+4+H8DJa1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188241596"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="188241596"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 01:41:26 -0800
IronPort-SDR: BdkZpLfxzqmExKJN/qVCYqQXuxLHx/PHNnHpY5k/VZ15joBiqkNA1LCWCeYf5u64BzOg/ajAOv
 +8B9cctpTMow==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="437841215"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 01:41:24 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJYrh-00B1mG-3h; Tue, 09 Mar 2021 11:41:21 +0200
Date:   Tue, 9 Mar 2021 11:41:21 +0200
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
Message-ID: <YEdCwfYRaQuKJFtA@smile.fi.intel.com>
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com>
 <CAMpxmJUQ3r0YCeQvPq=SW57w-5BLtoTO1_bv=2uw6CX_1-EXcQ@mail.gmail.com>
 <CAJZ5v0h7zUMU9DMofa3fhop9fYY6UJQ6Nm3xBOmG48bcmLCj3w@mail.gmail.com>
 <CAMpxmJXa2Qxznss3c79Zf-PzsX=SY6WOJorAMvS-UxKoViKP_w@mail.gmail.com>
 <YEZ81OraApPIu8d9@smile.fi.intel.com>
 <YEaAY37PsqT6WQB9@smile.fi.intel.com>
 <CAMpxmJUQ+Fhz8XTh14eHiqdQc3jBEwr8wuezw+NcgtU8XXFUQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJUQ+Fhz8XTh14eHiqdQc3jBEwr8wuezw+NcgtU8XXFUQg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 09, 2021 at 09:19:19AM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 8, 2021 at 8:52 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Mar 08, 2021 at 09:36:52PM +0200, Andy Shevchenko wrote:

...

> > So, I will send v6 with those included.
> 
> Does this series depend on patches already in Rafael's tree? If so,
> maybe Rafael can provide me with an immutable tag to merge in?

Not anymore since v5.12-rc2 has a necessary fix.

In any case I have sent a v6. It should be clean to apply on top of your for-next.

-- 
With Best Regards,
Andy Shevchenko


