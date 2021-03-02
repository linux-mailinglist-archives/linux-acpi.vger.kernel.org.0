Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5132B452
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Mar 2021 06:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353041AbhCCE6X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 23:58:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:57664 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1579384AbhCBQrY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Mar 2021 11:47:24 -0500
IronPort-SDR: bYA0YSrq+LdLItA5eqeca4AaKJraG028FSlzDt4gbofaMjrNk8yW8rVKs/r26RfEJ8c9jRjr4m
 J4ebXZ7UMhgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174022800"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="174022800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 08:35:52 -0800
IronPort-SDR: 41xwIflETVnqcb/i9sleajl0rcYzTTQRCtDclrG0dPYLDMLi7foC75wgfWRx95ZyxAGf3dAUrf
 7UpcIDyMxW2g==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="506392141"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 08:35:49 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lH7zr-009Qkx-UP; Tue, 02 Mar 2021 18:35:43 +0200
Date:   Tue, 2 Mar 2021 18:35:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/3] gpiolib: acpi: Add
 ACPI_GPIO_QUIRK_ABSOLUTE_NUMBER quirk
Message-ID: <YD5pX2tOano7peGk@smile.fi.intel.com>
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
 <20210225163320.71267-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdZj4TqOoJmfDhL1MuZCT9quz+5Gj8C6ckZ1i6cYCq9SOA@mail.gmail.com>
 <YD5VJMDC1TmIN/T8@smile.fi.intel.com>
 <20210302151430.GY2542@lahna.fi.intel.com>
 <YD5X7XUrx9AQvaXP@smile.fi.intel.com>
 <CAMpxmJX5sKwuta_Ws-VLuA_95ji6xaSB-0ZoNtQ-dL5mAwQcpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJX5sKwuta_Ws-VLuA_95ji6xaSB-0ZoNtQ-dL5mAwQcpg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 05:07:55PM +0100, Bartosz Golaszewski wrote:
> On Tue, Mar 2, 2021 at 4:21 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> Do you want me to take these, or will you include them in your PR?

I'll send PR.
I'm waiting for vger to process the queue (it has some lags).

-- 
With Best Regards,
Andy Shevchenko


