Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7AF69CC22
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Feb 2023 14:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjBTNfC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Feb 2023 08:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjBTNfC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2023 08:35:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400DF1A941;
        Mon, 20 Feb 2023 05:35:00 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="330114942"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="330114942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 05:34:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="703706530"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="703706530"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 20 Feb 2023 05:34:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pU6Jj-009R0s-1l;
        Mon, 20 Feb 2023 15:34:55 +0200
Date:   Mon, 20 Feb 2023 15:34:55 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/3] ACPI: x86: Introduce an
 acpi_quirk_skip_gpio_event_handlers() helper
Message-ID: <Y/N2/+UgH6MRUSOr@smile.fi.intel.com>
References: <20230218103235.6934-1-hdegoede@redhat.com>
 <20230218103235.6934-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218103235.6934-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 18, 2023 at 11:32:33AM +0100, Hans de Goede wrote:
> x86 ACPI boards which ship with only Android as their factory image usually
> have pretty broken ACPI tables, relying on everything being hardcoded in
> the factory kernel image and often disabling parts of the ACPI enumeration
> kernel code to avoid the broken tables causing issues.
> 
> Part of this broken ACPI code is that sometimes these boards have _AEI
> ACPI GPIO event handlers which are broken.
> 
> So far this has been dealt with in the platform/x86/x86-android-tablets.c
> module, which contains various workarounds for these devices, by it calling
> acpi_gpiochip_free_interrupts() on gpiochip-s with troublesome handlers to
> disable the handlers.
> 
> But in some cases this is too late, if the handlers are of the edge type
> then gpiolib-acpi.c's code will already have run them at boot.
> This can cause issues such as GPIOs ending up as owned by "ACPI:OpRegion",
> making them unavailable for drivers which actually need them.
> 
> Boards with these broken ACPI tables are already listed in
> drivers/acpi/x86/utils.c for e.g. acpi_quirk_skip_i2c_client_enumeration().
> Extend the quirks mechanism for a new acpi_quirk_skip_gpio_event_handlers()
> helper, this re-uses the DMI-ids rather then having to duplicate the same
> DMI table in gpiolib-acpi.c .
> 
> Also add the new ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS quirk to existing
> boards with troublesome ACPI gpio event handlers, so that the current
> acpi_gpiochip_free_interrupts() hack can be removed from
> x86-android-tablets.c .

I'm wondering if we can teach acpi_gpio_in_ignore_list() to handle this.

P.S. Why do we lock an IRQ before checking acpi_gpio_in_ignore_list() and
     why do we not free that if the IRQ is in ignore list?

-- 
With Best Regards,
Andy Shevchenko


