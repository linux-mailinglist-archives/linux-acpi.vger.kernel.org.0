Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A611CC2F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2019 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfLLL2a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Dec 2019 06:28:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:63001 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbfLLL2a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Dec 2019 06:28:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 03:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,305,1571727600"; 
   d="scan'208";a="203922519"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2019 03:28:25 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ifMdt-0002Dn-6U; Thu, 12 Dec 2019 13:28:25 +0200
Date:   Thu, 12 Dec 2019 13:28:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
Message-ID: <20191212112825.GK32742@smile.fi.intel.com>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
 <20191108042225.45391-2-dmitry.torokhov@gmail.com>
 <CGME20191212111237eucas1p1a278d2d5d2437e3219896367e82604cc@eucas1p1.samsung.com>
 <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f6ca8b-dbdf-0cec-aa8f-47ffcc5c5307@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 12, 2019 at 12:12:36PM +0100, Marek Szyprowski wrote:
> Dear All,
> 
> On 08.11.2019 05:22, Dmitry Torokhov wrote:
> > We do not need a special flag to know if we are dealing with an array,
> > as we can get that data from ratio between element length and the data
> > size, however we do need a flag to know whether the data is stored
> > directly inside property_entry or separately.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Today I've noticed that this patch got merged to linux-next as commit 
> e6bff4665c595b5a4aff173848851ed49ac3bfad. Sadly it breaks DWC3/xHCI 
> driver operation on Samsung Exynos5 SoCs (and probably on other SoCs 
> which use DWC3 in host mode too). I get the following errors during boot:
> 
> dwc3 12000000.dwc3: failed to add properties to xHCI
> dwc3 12000000.dwc3: failed to initialize host
> dwc3: probe of 12000000.dwc3 failed with error -61
> 
> Here is a full kernel log from Exynos5250-based Snow Chromebook on KernelCI:
> 
> https://storage.kernelci.org/next/master/next-20191212/arm/exynos_defconfig/gcc-8/lab-collabora/boot-exynos5250-snow.txt
> 
> (lack of 'ref' clk is not related nor fatal to the driver operation).
> 
> The code which fails after this patch is located in 
> drivers/usb/dwc3/host.c. Let me know if I can help more in locating the bug.

Thank you for report.

I think we should not have that patch in the fist place... I used to have
a bad feeling about it and then forgot about it existence.

-- 
With Best Regards,
Andy Shevchenko


