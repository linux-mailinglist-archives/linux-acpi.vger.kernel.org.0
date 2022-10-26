Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2108060EA8D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Oct 2022 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiJZUtb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Oct 2022 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiJZUta (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2022 16:49:30 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A39148FDC;
        Wed, 26 Oct 2022 13:49:22 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id CF10840A8A; Wed, 26 Oct 2022 21:49:20 +0100 (BST)
Date:   Wed, 26 Oct 2022 21:49:20 +0100
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
Message-ID: <20221026204920.GA15326@srcf.ucam.org>
References: <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
 <42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com>
 <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
 <20221025193248.GA21457@srcf.ucam.org>
 <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
 <20221025204043.GA23306@srcf.ucam.org>
 <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
 <20221025234040.GA27673@srcf.ucam.org>
 <fa6cc1d9-6740-b495-2c72-cae18c429ca6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6cc1d9-6740-b495-2c72-cae18c429ca6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 26, 2022 at 11:59:28AM +0200, Hans de Goede wrote:

> Ok, so this is a local customization to what is already a custom BIOS
> for a custom motherboard. There is a lot of custom in that sentence and
> TBH at some point things might become too custom for them to be expected
> to work OOTB.

But it *did* work OOTB before. You broke it. I accept that I'm a 
ludicrously weird corner case here, but there are going to be other 
systems that are also affected by this.

> I'm afraid things are not that simple. I assume that with
> "if ACPI backlight control is expected to work" you mean don't
> use ACPI backlight control when (acpi_osi_is_win8() && native_available)
> evaluates to true because it is known to be broken on some of
> those systems because Windows 8 stopped using it ?

Correct.

> Unfortunately something similar applies to vendor interfaces,
> When Windows XP started using (and mandating for certification
> IIRC) ACPI backlight control, vendors still kept their own
> vendor specific EC/smbios/ACPI/WMI backlight interfaces around for
> a long long time, except they were often no longer tested.

The current situation (both before your patchset and with its current 
implementation) is that vendor is preferred to native, so if the vendor 
interface is present then we're already using it.

> > The 
> > problem you're dealing with is that the knowledge of whether or not 
> > there's a vendor interface isn't something the core kernel code knows 
> > about. What you're proposing here is effectively for us to expose 
> > additional information about whether or not there's a vendor interface 
> > in the system firmware, but since we're talking in some cases about 
> > hardware that's almost 20 years old, we're not realistically going to 
> > get those old machines fixed.
> 
> I don't understand why you keep talking about the old vendor interfaces,
> at least for the chromebook part of this thread the issue is that
> the i915 driver no longer registers the intel_backlight device which
> is a native device type, which is caused by the patch this email
> thread is about (and old vendor interfaces do not come into play
> at all here). So AFAICT this is a native vs acpi backlight control
> issue ?

I'm referring to your proposed patch that changed the default from 
backlight_vendor to backlight_native, which would fix my machine and 
Chromebooks but break anything that relies on the vendor interfaces.

> I really want to resolve your bug, but I still lack a lot of info,
> like what backlight interface you were actually using in 6.0 ?

Native.

>         {
>          .callback = video_detect_force_video,
>          /* ThinkPad X201s */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
>                 },
>         },
> 
> will trigger.

In this case you'd break anyone else running the system who isn't using 
the hacked EC and different ACPI tables - obviously there's ways round 
this, but realistically since I'm (as far as I know) the only person in 
this situation it makes more sense for me to add a kernel parameter than 
carry around an exceedingly niche DMI quirk. I'm fine with that. But the 
point I'm trying to make is that the machines *are* telling you whether 
they'd prefer vendor or native, and you're not taking that into account 
in the video_detect code.
