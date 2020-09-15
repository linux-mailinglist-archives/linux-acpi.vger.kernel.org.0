Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1F26B811
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIPAft (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 20:35:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:4815 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgION1S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Sep 2020 09:27:18 -0400
IronPort-SDR: kWaTX6pva6MODCDdzDkCiikrMnt/5VH3mdti3JqxNzAoKTnYzkQo3DSBavNUM1Y7HHFU5VThbJ
 8L8DqkvWzRqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="158537922"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="158537922"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:16:55 -0700
IronPort-SDR: Kf691X6We2njLLlvFwQ3Km+IAdktaTZ+646hQ2Xv1GzgdhxfI5mD870cVwnIT6XQ54bFOV9QKC
 81DAbY0lJQJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="335650948"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 15 Sep 2020 06:16:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kIApE-00GqTB-SS; Tue, 15 Sep 2020 16:16:48 +0300
Date:   Tue, 15 Sep 2020 16:16:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/3] gpiolib: generalize GPIO line names property
Message-ID: <20200915131648.GY3956970@smile.fi.intel.com>
References: <20200908125813.8809-1-brgl@bgdev.pl>
 <CADYN=9+3kHG0CexzZiMQoXdF2piN2ZhOTObhY=7VCKrnFVN0Kw@mail.gmail.com>
 <20200915131228.GX3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915131228.GX3956970@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 04:12:28PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 15, 2020 at 02:01:56PM +0200, Anders Roxell wrote:
> > On Tue, 8 Sep 2020 at 18:40, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > I initially sent this as part of the gpio-mockup overhaul but since
> > > these patches are indepentent and the work on gpio-mockup may become
> > > more complicated - I'm sending these separately.
> > >
> > > The only change is adding additional property helpers to count strings
> > > in array.
> > >
> > > Bartosz Golaszewski (3):
> > >   device: property: add helpers to count items in string arrays
> > >   gpiolib: generalize devprop_gpiochip_set_names() for device properties
> > >   gpiolib: unexport devprop_gpiochip_set_names()
> 
> Ha-ha, OF unittest is of_node centric. definitely there is no backed device.
> 
> Bart, it seems we are stuck with fwnode interface.

Hmm... There is a platform device. So, it means that it fails along these
lines:
  return IS_ENABLED(CONFIG_OF) && dev->of_node ? &dev->of_node->fwnode : dev->fwnode;
so, who should set fwnode for of_node?

> > [ 6186.379069][    T1]  device_property_read_string_array+0x40/0xa0
> > [ 6186.381741][    T1]  devprop_gpiochip_set_names.isra.0+0x4c/0x200
> > [ 6186.384394][    T1]  gpiochip_add_data_with_key+0x75c/0xf80
> > [ 6186.386876][    T1]  unittest_gpio_probe+0xf4/0x1e0
> 
> > [ 6186.433241][    T1] Unable to handle kernel read from unreadable
> > memory at virtual address 0000000000000570
> > [ 6186.437207][    T1] Mem abort info:
> > [ 6186.438639][    T1]   ESR = 0x96000004
> > [ 6186.440536][    T1]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [ 6186.442791][    T1]   SET = 0, FnV = 0
> > [ 6186.444660][    T1]   EA = 0, S1PTW = 0
> > [ 6186.446233][    T1] Data abort info:
> > [ 6186.447938][    T1]   ISV = 0, ISS = 0x00000004
> > [ 6186.449749][    T1]   CM = 0, WnR = 0
> > [ 6186.451222][    T1] [0000000000000570] user address but active_mm is swapper
> > [ 6186.454000][    T1] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [ 6186.456422][    T1] Modules linked in:
> > [ 6186.458232][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B
> > W         5.9.0-rc5-next-20200915-00006-g104c8fe4916b #1
> > [ 6186.462833][    T1] Hardware name: linux,dummy-virt (DT)
> > [ 6186.465170][    T1] pstate: 60400005 (nZCv daif +PAN -UAO BTYPE=--)
> > [ 6186.467910][    T1] pc : device_property_read_string_array+0x40/0xa0
> > [ 6186.470653][    T1] lr : device_property_read_string_array+0x40/0xa0
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


