Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFE57BC04
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jul 2022 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiGTQxt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jul 2022 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiGTQxt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2022 12:53:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E42691C1;
        Wed, 20 Jul 2022 09:53:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z22so11556406edd.6;
        Wed, 20 Jul 2022 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ8S55elQG8rT6GpyiUvZTI+ZRSSMG/MOcad0kU1mxc=;
        b=fsHG/tQ4hTj8OchDkCs08gXQinTEKkqANQIVGZu5jhS2nxVa/dLXfRrEDvqcEGfXyE
         tnXR+ggv6i6pm67wO0K5naCIiAkIaL4iq3HB1owXFBR0TBO9DzEJXdAxdJcb04p4J5UC
         C/2QyHd765C3vFaqc7P0VNDqmLXJjwIFr1wcRQ0DsXydOh+QbfreWjQwOiBkUntg6s97
         jok35PJYMERSzCG62ZArthSoxwphhsEDYj+EDK/txbYVipBhcAPS9EbYRhul40ZkknTo
         D1ejvE5QxUlXYgaGB8VSR7D63iFmwqvFDAxM2q7XZJlPdrK8SB2MjGWbM91DxYTn43Mq
         wviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ8S55elQG8rT6GpyiUvZTI+ZRSSMG/MOcad0kU1mxc=;
        b=5CaURZvRMUvqBhFladllmhGF7ZlVml/hTV89wq73G4oFoZYizHmf4/X3fdODRo26OU
         bV/yVSpwcCrT+VYfUhu37GE9Dph3BSuBCEuiRox+wn/8Ab9kWrYX/W7SEXL4jkydUIO1
         xrr41YOXJma5DktUb28Gm6vs8KXUyBm5MilVrcd19kfbJNP2MgJC20CtgNvmP3IvKTmP
         z7nQzvcamv78DxbO9nl2L76H4G5uP5atVrEdXoJJFH6bPpK+mmmJsBiC/tcfOqU/mw5M
         ryKUv8BvNWxVbrv/5D0O2klJvQezm5z1I0FzGzFET7mN4QY0hhrWxuf0AgSGX8CWtFPA
         MQ1Q==
X-Gm-Message-State: AJIora/vNBhepkYSvsxgEJhDJ4jUWdMbWtBRmKG+2Cb5Se49zOyki0pQ
        WUeLdV+I1PDUu0Vmw1S34Z/7+3eO1A+yn3U/X6I=
X-Google-Smtp-Source: AGRyM1uB7u0FCxKz1D9dYX/QTZ94wPS45vrIR6JXhCAzgfaN+XvDpYj5HMov9bLxiYLAehJj1UyobwdKqbQoMfQbmHM=
X-Received: by 2002:a05:6402:d0a:b0:437:f9a1:8493 with SMTP id
 eb10-20020a0564020d0a00b00437f9a18493mr52228238edb.226.1658336026370; Wed, 20
 Jul 2022 09:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220712193910.439171-1-hdegoede@redhat.com> <20220712193910.439171-14-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-14-hdegoede@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jul 2022 12:53:34 -0400
Message-ID: <CADnq5_Mwri5mb5JBvRU9Spn72xKid-R83NoBp8Pc2LVGsCDttQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/29] drm/amdgpu: Register ACPI video backlight when
 skipping amdgpu backlight registration
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
> Typically the acpi_video driver will initialize before amdgpu, which
> used to cause /sys/class/backlight/acpi_video0 to get registered and then
> amdgpu would register its own amdgpu_bl# device later. After which
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
> Add a call to the new acpi_video_register_backlight() when amdgpu skips
> registering its own backlight device because of either the firmware_flags
> or the acpi_video_get_backlight_type() return value. This ensures that
> if the acpi_video backlight device should be used, it will be available
> before the amdgpu drm_device gets registered with userspace.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c    | 9 +++++++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index abf209e36fca..45cd9268b426 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -184,11 +184,11 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
>                 return;
>
>         if (!(adev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
> -               return;
> +               goto register_acpi_backlight;
>
>         if (!acpi_video_backlight_use_native()) {
>                 DRM_INFO("Skipping amdgpu atom DIG backlight registration\n");
> -               return;
> +               goto register_acpi_backlight;
>         }
>
>         pdata = kmalloc(sizeof(struct amdgpu_backlight_privdata), GFP_KERNEL);
> @@ -225,6 +225,11 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
>  error:
>         kfree(pdata);
>         return;
> +
> +register_acpi_backlight:
> +       /* Try registering an ACPI video backlight device instead. */
> +       acpi_video_register_backlight();
> +       return;

Can drop the return here.  Either way,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>  }
>
>  void
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3b03a95e59a8..a667e66a9842 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4054,6 +4054,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
>
>         if (!acpi_video_backlight_use_native()) {
>                 DRM_INFO("Skipping amdgpu DM backlight registration\n");
> +               /* Try registering an ACPI video backlight device instead. */
> +               acpi_video_register_backlight();
>                 return;
>         }
>
> --
> 2.36.0
>
