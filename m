Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F168932DAFF
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 21:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhCDUPu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 15:15:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:51698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233551AbhCDUPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 15:15:25 -0500
IronPort-SDR: AcOUKR8SFHqKIVIre+FYi4+titko+hWui7jjXmJwMsCYGb5jHG9hf+UIq6mIS7K/8067vGtS3L
 kLSj8FrJqphQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187607434"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="187607434"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:13:39 -0800
IronPort-SDR: V6+l76/uiezSct0jjCoKbVkaqppcJD7GAc8jWNDu0+tyqjlsOBzpFrFHKmLrSlJYbPzO+DQZJM
 hK74uWNz08jQ==
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="435967426"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:13:37 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHuLm-009xyA-6O; Thu, 04 Mar 2021 22:13:34 +0200
Date:   Thu, 4 Mar 2021 22:13:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] irqdomain: Introduce irq_domain_create_simple()
 API
Message-ID: <YEE/bnLUXhOibq3/@smile.fi.intel.com>
References: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com>
 <20210304150215.80652-2-andriy.shevchenko@linux.intel.com>
 <87lfb2zsab.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfb2zsab.wl-maz@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 04, 2021 at 06:29:32PM +0000, Marc Zyngier wrote:
> On Thu, 04 Mar 2021 15:02:11 +0000,
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Please move this as an inline helper in linux/irqdomain.h, so that we
> can drop this export altogether.

Done in v3, thanks!

-- 
With Best Regards,
Andy Shevchenko


