Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08C960D819
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Oct 2022 01:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiJYXl7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Oct 2022 19:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiJYXlm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2022 19:41:42 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900995D135;
        Tue, 25 Oct 2022 16:40:42 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 9794340A8A; Wed, 26 Oct 2022 00:40:40 +0100 (BST)
Date:   Wed, 26 Oct 2022 00:40:40 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>, Lyude <lyude@redhat.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        Jani Nikula <jani.nikula@intel.com>,
        nouveau@lists.freedesktop.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
Message-ID: <20221025234040.GA27673@srcf.ucam.org>
References: <20220825143726.269890-1-hdegoede@redhat.com>
 <20220825143726.269890-3-hdegoede@redhat.com>
 <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
 <42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com>
 <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
 <20221025193248.GA21457@srcf.ucam.org>
 <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
 <20221025204043.GA23306@srcf.ucam.org>
 <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 26, 2022 at 01:27:25AM +0200, Hans de Goede wrote:

> this code should actually set the ACPI_VIDEO_BACKLIGHT flag:
> drivers/acpi/scan.c:
> 
> static acpi_status
> acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
>                           void **return_value)
> {
>         long *cap = context;
> 
>         if (acpi_has_method(handle, "_BCM") &&
>             acpi_has_method(handle, "_BCL")) {
>                 acpi_handle_debug(handle, "Found generic backlight support\n");
>                 *cap |= ACPI_VIDEO_BACKLIGHT;
>                 /* We have backlight support, no need to scan further */
>                 return AE_CTRL_TERMINATE;
>         }
>         return 0;
> }

Ah, yeah, my local tree no longer matches the upstream behaviour because 
I've hacked the EC firmware to remove the backlight trigger because it 
had an extremely poor brightness curve and also automatically changed it 
on AC events - as a result I removed the backlight code from the DSDT 
and just fell back to the native control. Like I said I'm a long way 
from the normal setup, but this did previously work.

The "right" logic here seems pretty simple: if ACPI backlight control is 
expected to work, use it. If it isn't, but there's a vendor interface, 
use it. If there's no vendor interface, use the native interface. The 
problem you're dealing with is that the knowledge of whether or not 
there's a vendor interface isn't something the core kernel code knows 
about. What you're proposing here is effectively for us to expose 
additional information about whether or not there's a vendor interface 
in the system firmware, but since we're talking in some cases about 
hardware that's almost 20 years old, we're not realistically going to 
get those old machines fixed. So, it feels like there's two choices:

1) Make a default policy decision, but then allow that decision to be 
altered later on (eg, when a vendor-specific platform driver has been 
loaded) - you've said this poses additional complexities.

2) Move the knowledge of whether or not there's a vendor interface into 
the core code. Basically take every platform driver that exposes a 
vendor interface, and move the detection code into the core.

I think any other approach is going to result in machines that 
previously worked no longer working (and you can't just make the 
vendor/native split dependent on the Coreboot DMI BIOS string, because 
there are some Coreboot platforms that implement the vendor interface 
for compatibility, and you also can't ask all Coreboot users to update 
their firmware to fix things)
