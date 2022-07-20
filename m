Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1657BC11
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jul 2022 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiGTQy7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jul 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiGTQy4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2022 12:54:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7369869F2F;
        Wed, 20 Jul 2022 09:54:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id va17so34210529ejb.0;
        Wed, 20 Jul 2022 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJnc07zqN8Uo4UvUaljLOYZFnviJ9P8iNPOnwTu14I4=;
        b=Y6pbjajsctFjZSoED0Cs1ua/GKW3LfgmuRNTcGPciVK3aZF8ewVtwNz+0YWkx+Sf9e
         ToPuuKyyR11/PMFju/xwZbAC03cBo0QqHATq4YglrLIRV2BMU3LhEo535+BTpmY11b9r
         88RKBUajnpyMW7HQfK/nx4J/wxm0dXptlktHxsQArH7rvMGt9SH0FgHlcWHqXQ3XMBvW
         EPLEnid12mNehX7u3fKk+jRAmDOq6oXk8T+MpCJQDogPwWIxo9FAc3SmBUnzlSiJcESh
         MbocDtjUxHUAfH5DpWsJdQ2fjXwgtizNdIiULNv6yXsO4UaJPHwRkoKlKXBx7VzGjOFS
         eRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJnc07zqN8Uo4UvUaljLOYZFnviJ9P8iNPOnwTu14I4=;
        b=Pui6+2v2DpBQK30ywNrpnWjmqTyJGNzo5djEBulp1eYFptE2LyjTZmxzj4IEcP+Syy
         Xt19zJFUrBEs0GoWGQzlku9AAF2dIFxC3MpYvoO3quGCPpxiZIw9Gg0yS9b/BN6Qvd0d
         ZW5dOCYDpStB2w4UTD70BfaKkcJQIv/JwqBn+kuaIzKs0DAfNd/TQrRhvViozWFgXXn6
         2CGbnmu7EJZ+RfdAU43gVfpP+8BY9/qoNvedQiH/mmfXWaYO8yLAtR55Yi9Rg1R+SQL0
         d/NdaZSru8GimRp24wFgkxYpvnQgb7/wZLpGWX0qT1NNN3jYyhWBlJgivkOSFdm6ujvD
         qsSQ==
X-Gm-Message-State: AJIora+IFQ6NosTw4G/uu6K6XH1qqyBDY1I6XlDc5NsBcL1tAwOXn7TR
        CSNJXUc0BjSdsdnvOKYwTd9v7F66vInKir54Ddg=
X-Google-Smtp-Source: AGRyM1sJbnpvMcDLP+GUx8jP5LqLOrqTB40lzbLLU6RfYZJnzUHLf5CJWzlf9rtQpvcYU1jOG2hNDebloGE30lfZNeU=
X-Received: by 2002:a17:907:2e01:b0:72b:740c:1543 with SMTP id
 ig1-20020a1709072e0100b0072b740c1543mr36293825ejc.571.1658336093066; Wed, 20
 Jul 2022 09:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220712193910.439171-1-hdegoede@redhat.com> <20220712193910.439171-15-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-15-hdegoede@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jul 2022 12:54:41 -0400
Message-ID: <CADnq5_NqO210gk3AxfU2wow4xqAgEaF2=5qtr29zS=K75ExQtg@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] drm/radeon: Register ACPI video backlight when
 skipping radeon backlight registration
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

On Tue, Jul 12, 2022 at 3:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Typically the acpi_video driver will initialize before radeon, which
> used to cause /sys/class/backlight/acpi_video0 to get registered and then
> radeon would register its own radeon_bl# device later. After which
> the drivers/acpi/video_detect.c code unregistered the acpi_video0 device
> to avoid there being 2 backlight devices.
>
> This means that userspace used to briefly see 2 devices and the
> disappearing of acpi_video0 after a brief time confuses the systemd
> backlight level save/restore code, see e.g.:
> https://bbs.archlinux.org/viewtopic.php?id=269920
>
> To fix this the ACPI video code has been modified to make backlight class
> device registration a separate step, relying on the drm/kms driver to
> ask for the acpi_video backlight registration after it is done setting up
> its native backlight device.
>
> Add a call to the new acpi_video_register_backlight() when radeon skips
> registering its own backlight device because of e.g. the firmware_flags
> or the acpi_video_get_backlight_type() return value. This ensures that
> if the acpi_video backlight device should be used, it will be available
> before the radeon drm_device gets registered with userspace.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_encoders.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
> index 46549d5179ee..c1cbebb51be1 100644
> --- a/drivers/gpu/drm/radeon/radeon_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_encoders.c
> @@ -30,6 +30,8 @@
>  #include <drm/drm_device.h>
>  #include <drm/radeon_drm.h>
>
> +#include <acpi/video.h>
> +
>  #include "radeon.h"
>  #include "radeon_atombios.h"
>  #include "radeon_legacy_encoders.h"
> @@ -167,7 +169,7 @@ static void radeon_encoder_add_backlight(struct radeon_encoder *radeon_encoder,
>                 return;
>
>         if (radeon_backlight == 0) {
> -               return;
> +               use_bl = false;
>         } else if (radeon_backlight == 1) {
>                 use_bl = true;
>         } else if (radeon_backlight == -1) {
> @@ -193,6 +195,13 @@ static void radeon_encoder_add_backlight(struct radeon_encoder *radeon_encoder,
>                 else
>                         radeon_legacy_backlight_init(radeon_encoder, connector);
>         }
> +
> +       /*
> +        * If there is no native backlight device (which may happen even when
> +        * use_bl==true) try registering an ACPI video backlight device instead.
> +        */
> +       if (!rdev->mode_info.bl_encoder)
> +               acpi_video_register_backlight();
>  }
>
>  void
> --
> 2.36.0
>
