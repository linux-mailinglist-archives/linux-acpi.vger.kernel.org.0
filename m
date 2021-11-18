Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB95C455A6E
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbhKRLdp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 06:33:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:56980 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343900AbhKRLbV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 06:31:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="231650762"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="231650762"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 03:28:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="505572339"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 03:28:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mnfaE-0088PW-UP;
        Thu, 18 Nov 2021 13:28:02 +0200
Date:   Thu, 18 Nov 2021 13:28:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH v2 3/3] pinctrl: cherryview: Ignore INT33FF UID 5 ACPI
 device
Message-ID: <YZY4wj5AHhzFSwdD@smile.fi.intel.com>
References: <20211118105650.207638-1-hdegoede@redhat.com>
 <20211118105650.207638-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118105650.207638-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 11:56:50AM +0100, Hans de Goede wrote:
> Many Cherry Trail DSDTs have an extra INT33FF device with UID 5,
> the intel_pinctrl_get_soc_data() call will fail for this extra
> unknown UID, leading to the following error in dmesg:
> 
>  cherryview-pinctrl: probe of INT33FF:04 failed with error -61
> 
> Add a check for this extra UID and return -ENODEV for it to
> silence this false-positive error message.

Hmm... Interesting. Why do they have it?
Give me some time to check this...

-- 
With Best Regards,
Andy Shevchenko


