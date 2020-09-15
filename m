Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990EA26A89D
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIOPTj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 11:19:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:55866 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgIOPTB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Sep 2020 11:19:01 -0400
IronPort-SDR: 2chJRFLSFNuT/Kkuae5HXmkw/8FMkvRN8lDL1YeFnashK5waWb8Ii4YsB3pveE+O61ObSnsXll
 Wjokkuxs/Wbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="138780933"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="138780933"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 08:18:49 -0700
IronPort-SDR: +u98r1VJ5hfuSzKW7eq119tHZTmZ6xSzduMV9nVTCfBCdlZPXBYMmDhz7V26qbX8CW/Jm0vgo1
 GX7CnnWld/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="335699967"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 15 Sep 2020 08:18:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kICh5-00Grgs-SW; Tue, 15 Sep 2020 18:16:31 +0300
Date:   Tue, 15 Sep 2020 18:16:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/3] gpiolib: generalize GPIO line names property
Message-ID: <20200915151631.GD3956970@smile.fi.intel.com>
References: <20200908125813.8809-1-brgl@bgdev.pl>
 <CADYN=9+3kHG0CexzZiMQoXdF2piN2ZhOTObhY=7VCKrnFVN0Kw@mail.gmail.com>
 <20200915131228.GX3956970@smile.fi.intel.com>
 <CAMRc=MdGwkEp4sL=oBuk-x4cd7BWga76X0Rvq8PN-P+vjvp=Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdGwkEp4sL=oBuk-x4cd7BWga76X0Rvq8PN-P+vjvp=Fg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 03:16:42PM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 15, 2020 at 3:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 02:01:56PM +0200, Anders Roxell wrote:
> > > On Tue, 8 Sep 2020 at 18:40, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > I initially sent this as part of the gpio-mockup overhaul but since
> > > > these patches are indepentent and the work on gpio-mockup may become
> > > > more complicated - I'm sending these separately.
> > > >
> > > > The only change is adding additional property helpers to count strings
> > > > in array.
> > > >
> > > > Bartosz Golaszewski (3):
> > > >   device: property: add helpers to count items in string arrays
> > > >   gpiolib: generalize devprop_gpiochip_set_names() for device properties
> > > >   gpiolib: unexport devprop_gpiochip_set_names()
> >
> > Ha-ha, OF unittest is of_node centric. definitely there is no backed device.
> >
> > Bart, it seems we are stuck with fwnode interface.
> >
> 
> Wait what?! This means the implementation is wrong - the whole concept
> of device properties is to be generic and to hide the underlying
> fwnode or OF properties. If anything we should fix
> device/base/property.c to fall back to OF.
> 
> What is happening exactly? If all fwnode code compiled out?
> 
> I'll try to give it a spin and see what can be done but I don't like
> that device_property_* functions fail if you have OF but not fwnode.

Read my next reply. It seems only OF unittest issue

% git grep -n -w fwnode -- drivers/of/unittest* | wc -l
0
% git grep -n -w fwnode -- drivers/of/ | wc -l
50

-- 
With Best Regards,
Andy Shevchenko


