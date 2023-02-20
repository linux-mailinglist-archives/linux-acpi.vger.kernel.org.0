Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4169D0BE
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Feb 2023 16:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjBTPgG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Feb 2023 10:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjBTPgF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2023 10:36:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEA38A67;
        Mon, 20 Feb 2023 07:36:04 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="334625333"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="334625333"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:36:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="735170166"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="735170166"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2023 07:36:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pU8Ct-009ZIY-32;
        Mon, 20 Feb 2023 17:35:59 +0200
Date:   Mon, 20 Feb 2023 17:35:59 +0200
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
Message-ID: <Y/OTX2Z6N0ZhLOvW@smile.fi.intel.com>
References: <20230218103235.6934-1-hdegoede@redhat.com>
 <20230218103235.6934-2-hdegoede@redhat.com>
 <Y/N2/+UgH6MRUSOr@smile.fi.intel.com>
 <e61c78ea-e2b8-8c7f-c55f-a500036982a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e61c78ea-e2b8-8c7f-c55f-a500036982a1@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 20, 2023 at 04:23:33PM +0100, Hans de Goede wrote:
> On 2/20/23 14:34, Andy Shevchenko wrote:
> > On Sat, Feb 18, 2023 at 11:32:33AM +0100, Hans de Goede wrote:
> >> x86 ACPI boards which ship with only Android as their factory image usually
> >> have pretty broken ACPI tables, relying on everything being hardcoded in
> >> the factory kernel image and often disabling parts of the ACPI enumeration
> >> kernel code to avoid the broken tables causing issues.
> >>
> >> Part of this broken ACPI code is that sometimes these boards have _AEI
> >> ACPI GPIO event handlers which are broken.
> >>
> >> So far this has been dealt with in the platform/x86/x86-android-tablets.c
> >> module, which contains various workarounds for these devices, by it calling
> >> acpi_gpiochip_free_interrupts() on gpiochip-s with troublesome handlers to
> >> disable the handlers.
> >>
> >> But in some cases this is too late, if the handlers are of the edge type
> >> then gpiolib-acpi.c's code will already have run them at boot.
> >> This can cause issues such as GPIOs ending up as owned by "ACPI:OpRegion",
> >> making them unavailable for drivers which actually need them.
> >>
> >> Boards with these broken ACPI tables are already listed in
> >> drivers/acpi/x86/utils.c for e.g. acpi_quirk_skip_i2c_client_enumeration().
> >> Extend the quirks mechanism for a new acpi_quirk_skip_gpio_event_handlers()
> >> helper, this re-uses the DMI-ids rather then having to duplicate the same
> >> DMI table in gpiolib-acpi.c .
> >>
> >> Also add the new ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS quirk to existing
> >> boards with troublesome ACPI gpio event handlers, so that the current
> >> acpi_gpiochip_free_interrupts() hack can be removed from
> >> x86-android-tablets.c .
> > 
> > I'm wondering if we can teach acpi_gpio_in_ignore_list() to handle this.
> 
> You mean have it call acpi_quirk_skip_gpio_event_handlers(), or you mean
> extend the DMI matchs inside drivers/gpio/gpiolib-acpi.c to cover these
> cases ?
> 
> These devices with severely broken DSDTs already need a bunch of
> other acpi handling quirks. So the idea is to re-use the existing
> quirk mechanism for these to avoid having to have DMI match table
> entries for a single model in various different places.

I don't like growing amount of compile dependencies between these modules.
(Yes, I'm aware about stubs.)

Can we maybe move other quirks out from gpiolib-acpi.c to something like
PDx86 or another existing board files (with quirks)?

> > P.S. Why do we lock an IRQ before checking acpi_gpio_in_ignore_list() and
> >      why do we not free that if the IRQ is in ignore list?
> 
> The idea was to do the test after other things which can fail, so that
> if there are other reasons to skip the GPIO we don't do the test +
> dev_xxx msg.  But you are right, we should either unlock it when ignoring
> it, or move the acpi_gpio_in_ignore_list() list check up.
> 
> I guess just moving the check up is better, shall I prepare a patch for this?

Yes, please.

-- 
With Best Regards,
Andy Shevchenko


