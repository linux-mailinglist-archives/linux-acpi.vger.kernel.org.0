Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991D157BBAA
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jul 2022 18:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiGTQo4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jul 2022 12:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiGTQoz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2022 12:44:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17166BA3;
        Wed, 20 Jul 2022 09:44:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id va17so34160706ejb.0;
        Wed, 20 Jul 2022 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9ujADQ+6uUfQiUV6k7zVP85W+q012PovkMlFhLl5HM=;
        b=d2EXNwdPsm25Qgdijm5q1GXRv8EiDfoGUINDo0Flpw2N7x5JtmHtOe0WaEdCm98EAe
         t3hkPqmQrOjbBvB7Z5mbwNmBthJWYoIjACjajMToaVw7rOjoD+iQGvvAn3+P4k5W1SrT
         9UgQHOMfD4yzE7KaC1G1UgNKlTFuTAv16Fw50Qhc3XcMuDJWPKbHWYo7wHfzQs6YhOZJ
         8BKDG2XwGvwyy3g2lHnvQYnUsRywZOvu2nOUysOYJ/+/3T/SKO9nn4oH1zeXZ3Y+Gwqm
         KHngpg4Y9vEIz5TlYDh/I9uVpbSqxngH/ECwiKjpoPBJ2WHCpttiajyOgA7YKgKJ/SMA
         2fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9ujADQ+6uUfQiUV6k7zVP85W+q012PovkMlFhLl5HM=;
        b=MyLevScf4MXnoB5BR/Nnwl9N1Ws10uxzonHYg/b9bUJ6LEs0yPH1iuf6S0fXQSsc5l
         uFpvoXSkD87VZfBmLGtbnpVEKaHVzGC1VgSps3s25hpOcTqDxEOm4dEQy7YSyILfUFNm
         6vlFwwChEgOZ3Y/pHHpx1NhuXlovvYvOErmkBvgn0+C4fiBnwZiXio68LGPis90eM40I
         /OSZ3+ePCzR/1SeRC0lPL0EuYRuHDigpBSCNPtV5eHsdBexB7UzoCObgy64sIela0gsh
         3eKRZVRLrScIexwn46l6MzIWdCaThm0hM1eEoqyF9GWmdsxGWPsWDwJtttTLeKTIAMtY
         UBfQ==
X-Gm-Message-State: AJIora9VqgS6smwG9f2Ji4QsdxR4+aei1p0enFaKbWmAusH1rEfdJToO
        dCN2I+IYC7FmqO5nVj4mWwE3HQc+IJ/KHx+/c18=
X-Google-Smtp-Source: AGRyM1sMxt5iIjJZaHAcJFwgzttrLeRyTn4gfiagli7Ckr/UFny44wo4mpiuF1Hvpy0Bw61iBdTMjqkWK1dZtDrLtxI=
X-Received: by 2002:a17:907:2722:b0:72b:6a93:bf9a with SMTP id
 d2-20020a170907272200b0072b6a93bf9amr34535266ejl.424.1658335493336; Wed, 20
 Jul 2022 09:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220712193910.439171-1-hdegoede@redhat.com> <20220712193910.439171-4-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-4-hdegoede@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jul 2022 12:44:41 -0400
Message-ID: <CADnq5_PcpwtgdBrn7_1B4Fq5CNGbkSO94c5Qzf8NfbnpwBqHAw@mail.gmail.com>
Subject: Re: [PATCH v2 03/29] drm/amdgpu: Don't register backlight when
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
> - To avoid linker errors when amdgpu is builtin and video_detect.c is in
>   a module, select ACPI_VIDEO and its deps if ACPI && X86 are enabled.
>   When these are not set, ACPI_VIDEO is disabled, ensuring the stubs
>   from acpi/video.h will be used.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/Kconfig                           | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c    | 7 +++++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index aaa7ad1f0614..d65119860760 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -258,6 +258,12 @@ config DRM_AMDGPU
>         select HWMON
>         select BACKLIGHT_CLASS_DEVICE
>         select INTERVAL_TREE
> +       # amdgpu depends on ACPI_VIDEO when X86 and ACPI are both enabled
> +       # for select to work, ACPI_VIDEO's dependencies must also be selected
> +       select INPUT if ACPI && X86
> +       select X86_PLATFORM_DEVICES if ACPI && X86
> +       select ACPI_WMI if ACPI && X86
> +       select ACPI_VIDEO if ACPI && X86
>         help
>           Choose this option if you have a recent AMD Radeon graphics card.
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index fa7421afb9a6..abf209e36fca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -26,6 +26,8 @@
>
>  #include <linux/pci.h>
>
> +#include <acpi/video.h>
> +
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/amdgpu_drm.h>
>  #include "amdgpu.h"
> @@ -184,6 +186,11 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
>         if (!(adev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
>                 return;
>
> +       if (!acpi_video_backlight_use_native()) {
> +               DRM_INFO("Skipping amdgpu atom DIG backlight registration\n");
> +               return;
> +       }
> +
>         pdata = kmalloc(sizeof(struct amdgpu_backlight_privdata), GFP_KERNEL);
>         if (!pdata) {
>                 DRM_ERROR("Memory allocation failed\n");
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5eb111d35793..3b03a95e59a8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -86,6 +86,8 @@
>  #include <drm/drm_audio_component.h>
>  #include <drm/drm_gem_atomic_helper.h>
>
> +#include <acpi/video.h>
> +
>  #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
>
>  #include "dcn/dcn_1_0_offset.h"
> @@ -4050,6 +4052,11 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
>         amdgpu_dm_update_backlight_caps(dm, dm->num_of_edps);
>         dm->brightness[dm->num_of_edps] = AMDGPU_MAX_BL_LEVEL;
>
> +       if (!acpi_video_backlight_use_native()) {
> +               DRM_INFO("Skipping amdgpu DM backlight registration\n");
> +               return;
> +       }
> +
>         props.max_brightness = AMDGPU_MAX_BL_LEVEL;
>         props.brightness = AMDGPU_MAX_BL_LEVEL;
>         props.type = BACKLIGHT_RAW;
> --
> 2.36.0
>
