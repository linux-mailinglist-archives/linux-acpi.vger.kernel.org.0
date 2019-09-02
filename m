Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD31A5B1E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfIBQGM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 12:06:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:54378 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfIBQGM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 12:06:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 09:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="187029255"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2019 09:06:07 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4oqE-0004aN-9z; Mon, 02 Sep 2019 19:06:06 +0300
Date:   Mon, 2 Sep 2019 19:06:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Peter Cai <peter@typeblog.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] gpio: acpi: add quirk to override GpioInt polarity
Message-ID: <20190902160606.GR2680@smile.fi.intel.com>
References: <20190831030916.13172-1-peter@typeblog.net>
 <20190902100141.GW2680@smile.fi.intel.com>
 <CACRpkdaY_TT_m3XEh_J9TqMQijzUieQDBn+t4=uGUyfP+V0Hzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaY_TT_m3XEh_J9TqMQijzUieQDBn+t4=uGUyfP+V0Hzg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 03:36:24PM +0200, Linus Walleij wrote:
> On Mon, Sep 2, 2019 at 12:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Aug 31, 2019 at 11:09:14AM +0800, Peter Cai wrote:
> > > On GPD P2 Max, the firmware could not reset the touch panel correctly.
> > > The kernel needs to take on the job instead, but the GpioInt definition
> > > in DSDT specifies ActiveHigh while the GPIO pin should actually be
> > > ActiveLow.
> > >
> > > We need to override the polarity defined by DSDT. The GPIO driver
> > > already allows defining polarity in acpi_gpio_params, but the option is
> > > not applied to GpioInt.
> > >
> > > This patch adds a new quirk that enables the polarity specified in
> > > acpi_gpio_params to also be applied to GpioInt.
> >
> > Thank you for an update!
> >
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > on the condition that Dmitry and other input / Goodix developers are okay with
> > the approach in general.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> In case Dmitry needs to merge this.
> 
> Or should I simply merge this patch to the GPIO tree?

For my opinion Input subsystem should decide how to proceed with this.

-- 
With Best Regards,
Andy Shevchenko


