Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1F16BF21
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgBYKyj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 05:54:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:3648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYKyi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 05:54:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 02:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="260657825"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 25 Feb 2020 02:54:35 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j6XrJ-004dcq-S1; Tue, 25 Feb 2020 12:54:37 +0200
Date:   Tue, 25 Feb 2020 12:54:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
Message-ID: <20200225105437.GG10400@smile.fi.intel.com>
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225102753.8351-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2020 at 11:27:52AM +0100, Hans de Goede wrote:
> Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
> quirk mechanism") was added to deal with spurious wakeups on one specific
> model of the HP x2 10 series. In the mean time I have learned that there
> are at least 3 variants of the HP x2 10 models:
> 
> Bay Trail SoC + AXP288 PMIC
> Cherry Trail SoC + AXP288 PMIC
> Cherry Trail SoC + TI PMIC
> 
> It turns out that the need to ignore wakeup on *all* ACPI GPIO event
> handlers is unique to the Cherry Trail SoC + TI PMIC variant for which
> the first quirk was added.
> 
> The 2 variants with the AXP288 PMIC only need to have wakeup disabled on
> the embedded-controller event handler. We want to e.g. keep wakeup on the
> event handler connected to the GPIO for the lid open/closed sensor.
> 
> Since the honor_wakeup option was added to be able to ignore wake events,
> the name was perhaps not the best, this commit renames it to ignore_wake,
> this version of the option has te following possible values:
> 
> values >= 0: a pin number on which to ignore wakeups, the ACPI wake flag
> will still be honored on all other pins
> value -1: auto: check for DMI quirk, otherwise honor the flag on all pins
> value -2: all:  ignore the flag on all pins
> value -3: none: honor wakeups on all pins
> 
> Note that it is possible for an ACPI table to request events on the same
> pin-number on multiple GPIO controllers, in that case if such a pin-number
> is used as ignore_wake value then wakeups will be ignored for that pin on
> all GPIO controllers.
> 
> The existing quirk for the Cherry Trail + TI PMIC models is changed to
> IGNORE_WAKE_ALL, keeping the current behavior; and a new quirk is added
> for the Bay Trail + AXP288 model, ignoring wakeups on the EC GPIO pin only.

In general I'm fine with this, but looking to the history of your changes I'm
afraid that in future it will require more than one pin to be listed or
something like this.

...

> +static int ignore_wake = IGNORE_WAKE_AUTO;
> +module_param(ignore_wake, int, 0444);
> +MODULE_PARM_DESC(ignore_wake,
> +	"Ignore ACPI wake flag: x=ignore-for-pin-x, -1=auto, -2=all, -3=none");

Perhaps we may take list of pins or a bitmap (see bitmap list parsers API).

...

> -static int honor_wakeup = -1;
> -module_param(honor_wakeup, int, 0444);
> -MODULE_PARM_DESC(honor_wakeup,
> -		 "Honor the ACPI wake-capable flag: 0=no, 1=yes, -1=auto");

Isn't it now a part of ABI? I don't think we may remove it, though we may ignore it.
Or do something else.

(One of the reasons why I hate module parameters)

> +			ignore_wake = (s16)(quirks & QUIRK_IGNORE_WAKE_MASK);

It's casted to signed because ..?

-- 
With Best Regards,
Andy Shevchenko


