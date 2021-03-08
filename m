Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A7331816
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 21:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhCHUEh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 15:04:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:33975 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhCHUEK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:10 -0500
IronPort-SDR: dMGZtC/6aHVzLlF/j18MJzrsW7+6zIPifwbIE+iiPJGCQZtT3a2aR7h4z1H3ZAZ5rVtbnqVgKH
 aNkXsbgKFvxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175209351"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="175209351"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:04:09 -0800
IronPort-SDR: C+R0BDcgPI2ASX/LPI8Cu18hmU7Wro/FWotAcJsXIhySnXp40/vBqVlWWSCFq/gmTkYMk4Srxy
 t0CHeehCLnBA==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="369526868"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:04:07 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJM6m-00Au0K-0I; Mon, 08 Mar 2021 22:04:04 +0200
Date:   Mon, 8 Mar 2021 22:04:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 6/6] gpiolib: Fold conditionals into a simple ternary
 operator
Message-ID: <YEaDM1lpqmn6lBv9@smile.fi.intel.com>
References: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com>
 <20210308194535.66394-7-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gUDtpJE0Byw765yFr-5nOsxjPd5tH8_PGsr-gVZ-XSog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gUDtpJE0Byw765yFr-5nOsxjPd5tH8_PGsr-gVZ-XSog@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2021 at 08:47:47PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 8, 2021 at 8:45 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > It's quite spread code to initialize IRQ domain options.
> > Let's fold it into a simple oneliner.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Please see the comments I've just sent:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0gpNzyBDKfBXoBYskUXs15GrZAe-E2vzhSEu2Nrj7wa7g@mail.gmail.com/T/#u

Yeah, I answered there, thanks!

-- 
With Best Regards,
Andy Shevchenko


