Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2745D27E918
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgI3NBa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 09:01:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:6862 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgI3NBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 09:01:30 -0400
IronPort-SDR: g1fEK2L7fPvdIKWRO9hc22/syh4K3q1/GYPCHvqY5m7WMg0xzuSCVfpzBi5n4iEVlS8RBk7YJW
 IB4RbEFdUd4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="141844306"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="141844306"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 06:01:20 -0700
IronPort-SDR: mqPTbeEKaXW2vX4VANFW/wqP+yBcskH+dqKVF2dBS6+Ye5CRlFNSmmLYc6F3M4JkvCQ7sElUMo
 cQuEXX2Ow2Kw==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="339079199"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 06:01:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kNbjN-00311K-Vz; Wed, 30 Sep 2020 16:01:13 +0300
Date:   Wed, 30 Sep 2020 16:01:13 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to use an ACPI declared GPIO in a userspace ...
Message-ID: <20200930130113.GQ3956970@smile.fi.intel.com>
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
 <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it>
 <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22753b53cd7d4dfba4ef3610f71cc462@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 30, 2020 at 12:04:43PM +0000, Flavio Suligoi wrote:
> > > > > > I was wondering if there is a generic GPIO driver that I can use
> > Maybe I was not so clear, but as Bart mentioned the least you can do
> > is simply define line name via "gpio-line-names" property. The problem
> > here is when and how you would like to have them incorporated.
> 
> I already tried adding the "gpio-line-names" property, but the problem
> is the same: no driver asks for this GPIO, as shown by the following
> kernel messages:
> 
> ACPI: Host-directed Dynamic ACPI Table Load:
> ACPI: SSDT 0xFFFF994034D42A00 0000E8 (v05 ASEMsp GPIO_BTN 00000001 INTL 20200717)
> ACPI: \_SB_.GPO1.BTNS: PRP0001 requires 'compatible' property

> So I'll start to write a simple device driver to use this GPIO.
> I'll keep you informed!
>  
> > When: if ACPI tables are being provided by firmware which you may not
> > alter, then you must use initramfs type of solution (no configfs,
> > don't know about EFI var though). How: In that case you might have a
> > chance to incorporate _DSD() method into *existing* _CRS() one.
> > Possible impediments: if ACPI table from firmware already has a _DSD()
> > defined or above is not working for some reason. In such a case you
> > must upgrade entire DSDT via initramfs.
> > 
> > > > > Adding Andy who knows ACPI GPIO well.
> > > >
> > > > Thanks.
> > > >
> > > > > In general, the "gpio-line-names" property is used for that and it's
> > > > > supported both for device tree as well as ACPI, although I have only
> > > > > ever used the former.
> > > >
> > > > Right. ACPI supports properties via _DSD() method.

I guess you simply didn't get. The "gpio-line-names" property of GPIO
*controller* (provider!) and you are trying to do something with the *consumer*
if I got it right.

And of course GPIO line, which has name, has no difference in use from another
w/o name assigned. You will need to request it by *consumer* either in kernel
or in user space.

To be more precise we have to look at your DSDT.

-- 
With Best Regards,
Andy Shevchenko


