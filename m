Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F329EEAB
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgJ2Op5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 10:45:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:26328 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgJ2Op4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 10:45:56 -0400
IronPort-SDR: ehqlgiIgw+jVo3sNQsOQdPzNKw40dp9N3NZtnWPq1aFjAV9K1aQyEwRL2aMmEkjStfI3hzkhOi
 1le7M3x33h9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="147723965"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="147723965"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 07:45:56 -0700
IronPort-SDR: oZo9X9lcHoVODPC7Qf1h0zpJ2ps1bbmY/set4adm8ulRc9eH5rGtuaSJZyRsOu6+xZf5/6onLr
 wrBGZorOErvg==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="323725248"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 07:45:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kY9Ca-001Je5-As; Thu, 29 Oct 2020 16:46:56 +0200
Date:   Thu, 29 Oct 2020 16:46:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
Message-ID: <20201029144656.GD4077@smile.fi.intel.com>
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
 <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 28, 2020 at 10:10:42PM +0100, Ricardo Ribalda wrote:
> Hi Andy
> 
> Thanks for your patch and super fast response.
> 
> I think there are two different concepts here:
> 
> 1) when the pin has a low value, it is  0 or a 1? =>active_low

I'm not sure I have got it. GpioIo() has no such property and
_DSD active_low is documented as being polarity setting:

	active_low == 1 => active low polarity.

> 2) when do I get an irq, low->high or high->low => irq polarity

IRQ polarity is clearly defined by GpioInt() resource in the ACPI
specification.

> When I read the acpi spec for GpioInt()
> https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf page
> 934, it has the same problem as for GpioIo(), it does not express the
> active_low and this is where the _DSD field comes handy.

ActiveLevel field is described in 19.6.55 GpioInt (GPIO Interrupt Connection
Resource Descriptor Macro).

> Without using the active_low, how can we describe  a pin that is
> active low and has to trigger an irq on both edges?

This is nonsense.
What does it mean?

-- 
With Best Regards,
Andy Shevchenko


