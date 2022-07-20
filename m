Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66F57BBAF
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jul 2022 18:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiGTQpm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jul 2022 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiGTQpm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2022 12:45:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68B33E21;
        Wed, 20 Jul 2022 09:45:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id va17so34164477ejb.0;
        Wed, 20 Jul 2022 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lhjBvCngZcD3eYFG+VgqvQKBCFQwBVHGg9SXj+Md1w=;
        b=iFtYsHMenhSIDlABmUAS1jjiPCkj6FzGXekJRXlKLKIzXe8Q5D8GuZulZJfSgJBY5N
         Tt/uLOhTwJXmS2uI4Pc4uwYLcFKvgca9EkV1516SJjuQHhJTpq/z7OIG5116BlqAS5zc
         eqIu+0ufdIas6MxB9jTCkhbpoNMvVt6Bc/c0S13HV4XjUFlAf9LRZLtHxog/U57adcwQ
         fzDJ5tD83uKE3ko1Fw/CA/9TE6E3kp2Y/XC/BqjYonDk5/Wu9bJL8bcVsfgzcUzh9lV6
         pVWtLxIfNmjdr+Cobf9roof271taWKKTTtGpp3UQnPuKYLzAkARHXel5awt2cdndCfHf
         T1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lhjBvCngZcD3eYFG+VgqvQKBCFQwBVHGg9SXj+Md1w=;
        b=hWhlFwa0cMtnelfhO8wia76YbViJBB/4RoYYLR/iSHfcEt4d+C4fKnpKLcizg9GbMB
         mGNWJlBYSDPcHQmRVFaPzzNphMKHnY1OWy/My3cBOn+8NBPdgWm6C72QPfYLoM7NU8v6
         kQgEUzHP+zYTBMSScvp9EdGL1LRWFq8mCe5ZLkr+PojeXeLyKRjoWHarK+7Cuhh3q/UP
         /TStTDr1khIIzE3QjcT1zWCHUouxwDGhxOH1KiVc4yzxCrIbbLghhBOYMbyCGysvZYAH
         8kVPnm/xvgDh1rZ51M+xSObINJ/DiiMWFV44GQfSElEyp6vQ/De/fB0yz0OuTlUgkQRT
         rRMA==
X-Gm-Message-State: AJIora/sgLY2cVn8BOXM5qDTKyTixY2M0ZVNXbW3iweLV2XEG1hGhtHy
        8TgnOVc3rB2g9jKKIQrTPu/Kc9d3eM+DRicQeyg=
X-Google-Smtp-Source: AGRyM1sbtpOtX80WQvwwZef1d+CM4RjDZajsDZMmd7hJfZaiFaw7wTsx/omatuR7Pjdjkf0cfNc3ld06CqoTYICwqFY=
X-Received: by 2002:a17:907:a427:b0:72b:8cc5:5487 with SMTP id
 sg39-20020a170907a42700b0072b8cc55487mr35782199ejc.354.1658335539501; Wed, 20
 Jul 2022 09:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220712193910.439171-1-hdegoede@redhat.com> <20220712193910.439171-5-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-5-hdegoede@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jul 2022 12:45:27 -0400
Message-ID: <CADnq5_NGqboyz_eav09R7+oHyfOT656s9O+b_EvZ-tHSSmp2oQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/29] drm/radeon: Don't register backlight when
 another backlight should be used
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude <lyude@redhat.com>, Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@freedesktop.org, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 12, 2022 at 3:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Before this commit when we want userspace to use the acpi_video backlight
> device we register both the GPU's native backlight device and acpi_video's
> firmware acpi_video# backlight device. This relies on userspace preferring
> firmware type backlight devices over native ones.
>
> Registering 2 backlight devices for a single display really is
> undesirable, don't register the GPU's native backlight device when
> another backlight device should be used.
>
> Changes in v2:
> - To avoid linker errors when radeon is builtin and video_detect.c is in
>   a module, select ACPI_VIDEO and its deps if ACPI && X86 are enabled.
>   When these are not set, ACPI_VIDEO is disabled, ensuring the stubs
>   from acpi/video.h will be used.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/Kconfig                         | 6 ++++++
>  drivers/gpu/drm/radeon/atombios_encoders.c      | 7 +++++++
>  drivers/gpu/drm/radeon/radeon_legacy_encoders.c | 7 +++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index d65119860760..a07b76e06f84 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -234,6 +234,12 @@ config DRM_RADEON
>         select HWMON
>         select BACKLIGHT_CLASS_DEVICE
>         select INTERVAL_TREE
> +       # radeon depends on ACPI_VIDEO when X86 and ACPI are both enabled
> +       # for select to work, ACPI_VIDEO's dependencies must also be selected
> +       select INPUT if ACPI && X86
> +       select X86_PLATFORM_DEVICES if ACPI && X86
> +       select ACPI_WMI if ACPI && X86
> +       select ACPI_VIDEO if ACPI && X86
>         help
>           Choose this option if you have an ATI Radeon graphics card.  There
>           are both PCI and AGP versions.  You don't need to choose this to
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
> index c93040e60d04..958920230d6f 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -32,6 +32,8 @@
>  #include <drm/drm_file.h>
>  #include <drm/radeon_drm.h>
>
> +#include <acpi/video.h>
> +
>  #include "atom.h"
>  #include "radeon_atombios.h"
>  #include "radeon.h"
> @@ -209,6 +211,11 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
>         if (!(rdev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
>                 return;
>
> +       if (!acpi_video_backlight_use_native()) {
> +               DRM_INFO("Skipping radeon atom DIG backlight registration\n");
> +               return;
> +       }
> +
>         pdata = kmalloc(sizeof(struct radeon_backlight_privdata), GFP_KERNEL);
>         if (!pdata) {
>                 DRM_ERROR("Memory allocation failed\n");
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> index 1a66fb969ee7..d24cedf20c47 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> @@ -33,6 +33,8 @@
>  #include <drm/drm_util.h>
>  #include <drm/radeon_drm.h>
>
> +#include <acpi/video.h>
> +
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_legacy_encoders.h"
> @@ -387,6 +389,11 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
>                 return;
>  #endif
>
> +       if (!acpi_video_backlight_use_native()) {
> +               DRM_INFO("Skipping radeon legacy LVDS backlight registration\n");
> +               return;
> +       }
> +
>         pdata = kmalloc(sizeof(struct radeon_backlight_privdata), GFP_KERNEL);
>         if (!pdata) {
>                 DRM_ERROR("Memory allocation failed\n");
> --
> 2.36.0
>
