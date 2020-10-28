Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E6229EE70
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgJ2OiI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 10:38:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:64019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgJ2OiH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 10:38:07 -0400
IronPort-SDR: fCqCEaEd2NM0LfBWEZUxLSsLu3AcPKz7KVm5O/Tg/J2/vSE0KbQNPmPmBRIQ4v63TmctjoaOk8
 5P7BqtCEpBCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="230079413"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="230079413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 07:38:06 -0700
IronPort-SDR: AatJukX5pNEnTmW5wJ6ITt5+S+XxjM0NpZEeqMaKBr1HDxPHNatAkiTub5DVOoesrza9LzlVBW
 xM3znpFxrHdA==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="351474361"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 07:38:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kY94z-001JMX-RU; Thu, 29 Oct 2020 16:39:05 +0200
Date:   Wed, 28 Oct 2020 20:27:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Support GpioInt with active_low polarity
Message-ID: <20201028182744.GZ4077@smile.fi.intel.com>
References: <20201028171757.765866-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028171757.765866-1-ribalda@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 28, 2020 at 06:17:57PM +0100, Ricardo Ribalda wrote:
> On the current implementation we only support active_high polarity for
> GpioInt.
> 
> There can be cases where a GPIO has active_low polarity and it is also a
> IRQ source.
> 
> De-couple the irq_polarity and active_low fields instead of re-use it.
> 
> With this patch we support ACPI devices such as:

Is it real device on the market?!

This table is broken. _DSD GPIO active_low is only for GpioIo().

If it is a ChromeBook, please fix the firmware.

> Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> {
>         GpioInt (Edge, ActiveBoth, Exclusive, PullDefault, 0x0000,
>         "\\_SB.PCI0.GPIO", 0x00, ResourceConsumer, ,
>         )
>         {   // Pin list
>                 0x0064
>         }
> })
> Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
>         Package (0x01)
>         {
>         Package (0x02)
>         {
>                 "privacy-gpio",
>                 Package (0x04)
>                 {
>                 \_SB.PCI0.XHCI.RHUB.HS07,
>                 Zero,
>                 Zero,
>                 One
>                 }
>         }
>         }
> })


-- 
With Best Regards,
Andy Shevchenko


