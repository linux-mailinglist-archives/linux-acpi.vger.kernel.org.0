Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE160F6D0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Oct 2022 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiJ0MJo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Oct 2022 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiJ0MJm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Oct 2022 08:09:42 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECA8FD1B;
        Thu, 27 Oct 2022 05:09:39 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id t25so678514qkm.2;
        Thu, 27 Oct 2022 05:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zob33Kla+RLsm+RvZFRkkpciG4NSOFsYMv+2iMSvbU8=;
        b=CnFRBN6hqsiJfJbaCHQYVuEvwtRot4dkP0yK/+f0RL2koht3pbZHzKonwcD/JaNR2S
         HXdvrYNS6/B+VblmqwL7DKtpHpJ4Pt3CJwoXZpqakSKbBO7/bEPwK9snds4ZwiVx5BU4
         2Sv7/B0ymXKEZeJZVM3OJPtCAc676k8v5I+rbvhHz68HGnVY4N5qyRC0ohyGnLhgytJF
         JRm3JCMvP0iCxCeY2EnM7U7KQwV1EH6fK+YmkA/oumpQet4PyeTDOwD4jtNMxDgTufHi
         i2T7i4g+rbKJcehvqzE/oOCm5aR954HhnzGBGnoLv3KUeDbWBAHZ7+hG+q6paA4H0Lk9
         lBLA==
X-Gm-Message-State: ACrzQf1njF7lrOrqWZFkDmMnc0FBxemIFKV7Otde9LG0PVcNp9h936lw
        qs+948jlkAdW//Ne+Hl6KsE4ir+MaEJcjkA6UnM=
X-Google-Smtp-Source: AMsMyM6NeMFZa4GPKFIdb5StMWZOoUw58iXZAY6R77ZAJLEXASKkFV1w1vtNejdRxPCAyFXWVssLUx0L9nTXahQ4MDI=
X-Received: by 2002:a05:620a:4626:b0:6ee:b43:d2bc with SMTP id
 br38-20020a05620a462600b006ee0b43d2bcmr32868704qkb.764.1666872578327; Thu, 27
 Oct 2022 05:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221025193248.GA21457@srcf.ucam.org> <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
 <20221025204043.GA23306@srcf.ucam.org> <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
 <20221025234040.GA27673@srcf.ucam.org> <fa6cc1d9-6740-b495-2c72-cae18c429ca6@redhat.com>
 <20221026204920.GA15326@srcf.ucam.org> <099dee98-8aeb-af36-828c-110f5ac6e9a3@redhat.com>
 <20221027091123.GA28089@srcf.ucam.org> <933be908-0bc2-56cc-8d6f-38f2d208ef20@redhat.com>
 <20221027095249.GA28666@srcf.ucam.org> <6df2016d-ed2d-57fa-dcad-48537732895f@redhat.com>
In-Reply-To: <6df2016d-ed2d-57fa-dcad-48537732895f@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Oct 2022 14:09:27 +0200
Message-ID: <CAJZ5v0jM1JAySagv=u2be1bAmfTt3jJgVnOEjGzskBvZY7k6aw@mail.gmail.com>
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitry Osipenko <digetx@gmail.com>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui <Xinhui.Pan@amd.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 27, 2022 at 12:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 10/27/22 11:52, Matthew Garrett wrote:
> > On Thu, Oct 27, 2022 at 11:39:38AM +0200, Hans de Goede wrote:
> >
> >> The *only* behavior which actually is new in 6.1 is the native GPU
> >> drivers now doing the equivalent of:
> >>
> >>      if (acpi_video_get_backlight_type() != acpi_backlight_native)
> >>              return;
> >>
> >> In their backlight register paths (i), which is causing the native
> >> backlight to disappear on your custom laptop setup and on Chromebooks
> >> (with the Chromebooks case being already solved I hope.).
> >
> > It's causing the backlight control to vanish on any machine that isn't
> > ((acpi_video || vendor interface) || !acpi). Most machines that fall
> > into that are either weird or Chromebooks or old, but there are machines
> > that fall into that.
>
> I acknowledge that their are machines that fall into this category,
> but I expect / hope there to be so few of them that we can just DMI
> quirk our way out if this.
>
> I believe the old group to be small because:
>
> 1. Generally speaking the "native" control method is usually not
> present on the really old (pre ACPI video spec) mobile GPUs.
>
> 2. On most old laptops I would still expect there to be a vendor
> interface too, and if both get registered standard desktop environments
> will prefer the vendor one, so then we need a native DMI quirk to
> disable the vendor interface anyways and we already have a bunch of
> those, so some laptops in this group are already covered by DMI quirks.
>
> And a fix for the Chromebook case is already in Linus' tree, which
> just leaves the weird case, of which there will hopefully be only
> a few.
>
> I do share your worry that this might break some machines, but
> the only way to really find out is to get this code out there
> I'm afraid.
>
> I have just written a blog post asking for people to check if
> their laptop might be affected; and to report various details
> to me of their laptop is affected:
>
> https://hansdegoede.dreamwidth.org/26548.html
>
> Lets wait and see how this goes. If I get (too) many reports then
> I will send a revert of the addition of the:
>
>         if (acpi_video_get_backlight_type() != acpi_backlight_native)
>                 return;
>
> check to the i915 / radeon / amd / nouveau drivers.
>
> (And if I only get a couple of reports I will probably just submit
> DMI quirks for the affected models).

Sounds reasonable to me, FWIW.

And IIUC the check above can be overridden by passing
acpi_backlight=native in the kernel command line, right?
