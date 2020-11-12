Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410462B0B14
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgKLRPG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 12:15:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:14969 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgKLRPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 12:15:06 -0500
IronPort-SDR: hBFCkbwwopfbrQMyL+Vrys5kw+bIj+VgtO8U4O6bwzQhIwW+J8l6jfo23Cvdw9kiyvXML6hFlr
 klt08jnPAgLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="231964592"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="231964592"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:15:02 -0800
IronPort-SDR: l+u88JxfY5do4LGUjvztuH2gtx4vuAlTHI6mZA2F1X6qP1VA63dhVnjAfaZoCVbLMw4UIaUN5N
 pAZtikZZJKyg==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="357164194"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:15:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kdGCX-006GSl-TV; Thu, 12 Nov 2020 19:16:01 +0200
Date:   Thu, 12 Nov 2020 19:16:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Tin Huynh <tnhuynh@apm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rtc: ds1307: Remove non-valid ACPI IDs
Message-ID: <20201112171601.GL4077@smile.fi.intel.com>
References: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
 <20201112163617.GE4556@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112163617.GE4556@piout.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 05:36:17PM +0100, Alexandre Belloni wrote:
> On 12/11/2020 17:57:51+0200, Andy Shevchenko wrote:
> > The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added non-valid
> > ACPI IDs (all of them abusing ACPI specification). Moreover there is
> > no even a single evidence that vendor registered any of such device.
> > 
> > Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
> > with device tree defined bindings. The following patches will add support
> > of that to the driver.
> 
> I'm intrigued, how does PRP0001 work? Where would the device tree come
> from?

From nowhere :-)

There is no device tree. The properties are coming from _DSD ACPI Method with
compatible string provided. ACPI glue layer provides a mechanism to parse that
and match against OF ID table (even when CONFIG_OF=n!).

More about PRP0001 is in documentation [1].

> You probably want to have a look at:
> https://lore.kernel.org/linux-rtc/20201112130734.331094-3-ch@denx.de/T/#u

Thanks for heads up!
I'll check that thread and answer there.

[1]: Documentation/firmware-guide/acpi/enumeration.rst

-- 
With Best Regards,
Andy Shevchenko


