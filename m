Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D637E100A28
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 18:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKRRXX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 12:23:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:7477 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfKRRXX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 12:23:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 09:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="406159014"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2019 09:23:21 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iWkkC-0005at-Mx; Mon, 18 Nov 2019 19:23:20 +0200
Date:   Mon, 18 Nov 2019 19:23:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/1] pinctrl: baytrail: Really serialize all register
 accesses
Message-ID: <20191118172320.GX32742@smile.fi.intel.com>
References: <20191118142020.22256-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118142020.22256-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 18, 2019 at 03:20:19PM +0100, Hans de Goede wrote:
> Hi All,
> 
> First let me copy-paste a bit of the commit msg for background:
> 
> ---begin commit msg---
> Commit 39ce8150a079 ("pinctrl: baytrail: Serialize all register access")
> added a spinlock around all register accesses because:
> 
> "There is a hardware issue in Intel Baytrail where concurrent GPIO register
>  access might result reads of 0xffffffff and writes might get dropped
>  completely."
> 
> Testing has shown that this does not catch all cases, there are still
> 2 problems remaining
> 
> 1) The original fix uses a spinlock per byt_gpio device / struct,
> additional testing has shown that this is not sufficient concurent
> accesses to 2 different GPIO banks also suffer from the same problem.
> 
> This commit fixes this by moving to a single global lock.
> 
> 2) The original fix did not add a lock around the register accesses in
> the suspend/resume handling.
> 
> Since pinctrl-baytrail.c is using normal suspend/resume handlers,
> interrupts are still enabled during suspend/resume handling. Nothing
> should be using the GPIOs when they are being taken down, _but_ the
> GPIOs themselves may still cause interrupts, which are likely to
> use (read) the triggering GPIO. So we need to protect against
> concurrent GPIO register accesses in the suspend/resume handlers too.
> 
> This commit fixes this by adding the missing spin_lock / unlock calls.
> ---end commit msg---
> 
> I was discussing the problem at my local hackerspace yesterday with
> someone who knows quite a bit low-level details about Intel CPUs.
> He said that on "big" core's all the GPIO islands sit behind the IOSF
> and that there is a bridge which make their registers look like regular
> mmio registers.
> 
> I wonder if the same is happening on BYT, that would point to an issue
> with concurent accesses being done through the IOSF bridge, which would
> explain why I've found that we need a single global lock for all GPIO
> islands (*).

> But that in turn would mean that we really need global lock
> for _all_ accesses done through the IOSF bridge, not just GPIO register
> accesses...  Which would explain why on some machines BYT has never been
> really stable with Linux.

I don't think so. The Cherriview seems inherited the same silicon issue (see
comment near to chv_lock), though it seems to be fixed for all new hardware
(Skylake+).

> Can someone at Intel with access to internal docs about BYT dig a bit into
> the docs and see if 1. this theory makes sense, 2. if it does if there us
> anything else behind the IOSF for which we also need to serialize accesses?

Unfortunately I have no time to dig into this right now.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> *) It seems that the GPIO interrupt storm on the test device I hit
> this is really good in triggering this
> 

-- 
With Best Regards,
Andy Shevchenko


