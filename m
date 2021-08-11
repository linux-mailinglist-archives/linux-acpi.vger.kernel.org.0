Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51C33E92DC
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Aug 2021 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhHKNmJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Aug 2021 09:42:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:7976 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhHKNmJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Aug 2021 09:42:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="276158943"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="276158943"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:41:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="503499266"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:41:42 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mDoUB-007uxQ-Nh; Wed, 11 Aug 2021 16:41:35 +0300
Date:   Wed, 11 Aug 2021 16:41:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/1] x86/platform: Increase maximum GPIO number for
 X86_64
Message-ID: <YRPTj1jl8VaRkkk/@smile.fi.intel.com>
References: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
 <CACRpkda+t4ZhL1bP1a6Cwnh9rYH9Hj59_7VLg45KV+Va5iBR9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda+t4ZhL1bP1a6Cwnh9rYH9Hj59_7VLg45KV+Va5iBR9w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 11, 2021 at 03:14:59PM +0200, Linus Walleij wrote:
> On Fri, Aug 6, 2021 at 4:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > By default the 512 GPIOs is a maximum on any x86 platform.
> > With, for example, Intel Tiger Lake-H the SoC based controller
> > occupies up to 480 pins. This leaves only 32 available for
> > GPIO expanders or other drivers, like PMIC. Hence, bump the
> > maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks reasonable to me.
> The goal with the whole descriptor refactoring is to get this
> completely dynamic but it turns out to take forever. It is as it
> is.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

Rafael, can you please review this?

-- 
With Best Regards,
Andy Shevchenko


