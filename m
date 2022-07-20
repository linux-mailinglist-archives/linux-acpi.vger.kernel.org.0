Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730657BBE6
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jul 2022 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGTQui (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jul 2022 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGTQuh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2022 12:50:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853241D2C;
        Wed, 20 Jul 2022 09:50:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t3so24563576edd.0;
        Wed, 20 Jul 2022 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWwm2vwY0mPc83AQwb60Ft68A5hUQCaRBAq697Ik0tk=;
        b=G8FF83lDzwo2o9hXc6yBF5FjoExYKyA556Pe6419Ga75J1r4C+crFprz4fxer17c+G
         CIWQa8c4CT6apvfpUyZ6Cg5hPA+UB3n1hKx8swYvo1dSLx9T8elfho5sv39QGXjp4nEY
         NbyfXu+j/Vj/cifNgE+GinBnuEOD3aRiwPHFBhoCtPvdVqxiszzuXz3ZccFZJ1Xa4gep
         /P1mhxoT+bw+834tCu9bY1lAV01KnpVlxHBwBghKbZv7zGTdT+KJGmS1wceNOsdn6NuP
         RNfUU6xHe8barzl+/4Iyd85IYr4/K2mpXm1iR5cphB2CxyZ/09JTcFua8LTxGvF8DR+0
         XfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWwm2vwY0mPc83AQwb60Ft68A5hUQCaRBAq697Ik0tk=;
        b=gmDmqEC5w7r6lhYWdhiZVAwd6A653c6kJVuIh2Qi9qGz/0QY9us4ExCckii42mHOPr
         wZSLjA47f1qoBw1XmC/TQSKcduui2x0SeW9/uYEXu0asEXPkRwYhFnEgcHYRBjz8Lyq1
         HaORHjFQt08Dev5TthGW3TexiMwB+udQXz6/+G7jw2XfUzr9Z6wN3cQdrxHPX+uBLZv+
         DBEBK9cmO1vs+PxSCjgR+6EWvCQqmX2NP8ZW7D3p068TphNHBAsGfoPMLP6fq7XIlQ9w
         hazrPwpOyNR4EfnLMv+HodZXEcuYWZxRYUyJP1YNBrhAaIjYckE5YfkXfCB4OtnW2yBM
         aVew==
X-Gm-Message-State: AJIora+FvvlvLnMSY6IF3qM4M9PCEaWjHE8P2wjudrHlWWBuprfd0B3L
        PXjSid42m2AX9tT41d2GNpPACtgix0VH5otx7Z8=
X-Google-Smtp-Source: AGRyM1v1VHeMTHXHTQjAgGPHdg9YyLFCckQivVVr4VVsXYz/2qVZT3OxGu2vW3tT9LaHT/A5LbPQNFGs9LkDPsqh0nE=
X-Received: by 2002:a05:6402:f12:b0:43a:7eac:296e with SMTP id
 i18-20020a0564020f1200b0043a7eac296emr52187605eda.115.1658335832497; Wed, 20
 Jul 2022 09:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220712193910.439171-1-hdegoede@redhat.com> <20220712193910.439171-10-hdegoede@redhat.com>
In-Reply-To: <20220712193910.439171-10-hdegoede@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jul 2022 12:50:20 -0400
Message-ID: <CADnq5_Pp+trT8F1StcMa2Kc9x1QV8=W_s_+JDjLXcqhGderw=Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/29] ACPI: video: Make backlight class device
 registration a separate step
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
> On x86/ACPI boards the acpi_video driver will usually initializing before

initializing -> initialize

> the kms driver (except i915). This causes /sys/class/backlight/acpi_video0
> to show up and then the kms driver registers its own native backlight
> device after which the drivers/acpi/video_detect.c code unregisters
> the acpi_video0 device (when acpi_video_get_backlight_type()==native).
>
> This means that userspace briefly sees 2 devices and the disappearing of
> acpi_video0 after a brief time confuses the systemd backlight level
> save/restore code, see e.g.:
> https://bbs.archlinux.org/viewtopic.php?id=269920
>
> To fix this make backlight class device registration a separate step
> done by a new acpi_video_register_backlight() function. The intend is for
> this to be called by the drm/kms driver *after* it is done setting up its
> own native backlight device. So that acpi_video_get_backlight_type() knows
> if a native backlight will be available or not at acpi_video backlight
> registration time, avoiding the add + remove dance.
>
> Note the new acpi_video_register_backlight() function is also called from
> a delayed work to ensure that the acpi_video backlight devices does get
> registered if necessary even if there is no drm/kms driver or when it is
> disabled.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_video.c | 45 ++++++++++++++++++++++++++++++++++++---
>  include/acpi/video.h      |  2 ++
>  2 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 6944794797a5..c4c3a9e7ce69 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -31,6 +31,12 @@
>  #define ACPI_VIDEO_BUS_NAME            "Video Bus"
>  #define ACPI_VIDEO_DEVICE_NAME         "Video Device"
>
> +/*
> + * Display probing is known to take up to 5 seconds, so delay the fallback
> + * backlight registration by 5 seconds + 3 seconds for some extra margin.
> + */
> +#define ACPI_VIDEO_REGISTER_BACKLIGHT_DELAY    (8 * HZ)
> +
>  #define MAX_NAME_LEN   20
>
>  MODULE_AUTHOR("Bruno Ducrot");
> @@ -81,6 +87,9 @@ static LIST_HEAD(video_bus_head);
>  static int acpi_video_bus_add(struct acpi_device *device);
>  static int acpi_video_bus_remove(struct acpi_device *device);
>  static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
> +static void acpi_video_bus_register_backlight_work(struct work_struct *ignored);
> +static DECLARE_DELAYED_WORK(video_bus_register_backlight_work,
> +                           acpi_video_bus_register_backlight_work);
>  void acpi_video_detect_exit(void);
>
>  /*
> @@ -1865,8 +1874,6 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
>         if (video->backlight_registered)
>                 return 0;
>
> -       acpi_video_run_bcl_for_osi(video);
> -
>         if (acpi_video_get_backlight_type() != acpi_backlight_video)
>                 return 0;
>
> @@ -2092,7 +2099,11 @@ static int acpi_video_bus_add(struct acpi_device *device)
>         list_add_tail(&video->entry, &video_bus_head);
>         mutex_unlock(&video_list_lock);
>
> -       acpi_video_bus_register_backlight(video);
> +       /*
> +        * The userspace visible backlight_device gets registered separately
> +        * from acpi_video_register_backlight().
> +        */
> +       acpi_video_run_bcl_for_osi(video);
>         acpi_video_bus_add_notify_handler(video);
>
>         return 0;
> @@ -2131,6 +2142,11 @@ static int acpi_video_bus_remove(struct acpi_device *device)
>         return 0;
>  }
>
> +static void acpi_video_bus_register_backlight_work(struct work_struct *ignored)
> +{
> +       acpi_video_register_backlight();
> +}
> +
>  static int __init is_i740(struct pci_dev *dev)
>  {
>         if (dev->device == 0x00D1)
> @@ -2241,6 +2257,17 @@ int acpi_video_register(void)
>          */
>         register_count = 1;
>
> +       /*
> +        * acpi_video_bus_add() skips registering the userspace visible
> +        * backlight_device. The intend is for this to be registered by the
> +        * drm/kms driver calling acpi_video_register_backlight() *after* it is
> +        * done setting up its own native backlight device. The delayed work
> +        * ensures that acpi_video_register_backlight() always gets called
> +        * eventually, in case there is no drm/kms driver or it is disabled.
> +        */
> +       schedule_delayed_work(&video_bus_register_backlight_work,
> +                             ACPI_VIDEO_REGISTER_BACKLIGHT_DELAY);
> +
>  leave:
>         mutex_unlock(&register_count_mutex);
>         return ret;
> @@ -2251,6 +2278,7 @@ void acpi_video_unregister(void)
>  {
>         mutex_lock(&register_count_mutex);
>         if (register_count) {
> +               cancel_delayed_work_sync(&video_bus_register_backlight_work);
>                 acpi_bus_unregister_driver(&acpi_video_bus);
>                 register_count = 0;
>                 has_backlight = false;
> @@ -2259,6 +2287,17 @@ void acpi_video_unregister(void)
>  }
>  EXPORT_SYMBOL(acpi_video_unregister);
>
> +void acpi_video_register_backlight(void)
> +{
> +       struct acpi_video_bus *video;
> +
> +       mutex_lock(&video_list_lock);
> +       list_for_each_entry(video, &video_bus_head, entry)
> +               acpi_video_bus_register_backlight(video);
> +       mutex_unlock(&video_list_lock);
> +}
> +EXPORT_SYMBOL(acpi_video_register_backlight);
> +
>  void acpi_video_unregister_backlight(void)
>  {
>         struct acpi_video_bus *video;
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index 4705e339c252..0625806d3bbd 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -53,6 +53,7 @@ enum acpi_backlight_type {
>  #if IS_ENABLED(CONFIG_ACPI_VIDEO)
>  extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
> +extern void acpi_video_register_backlight(void);
>  extern int acpi_video_get_edid(struct acpi_device *device, int type,
>                                int device_id, void **edid);
>  extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
> @@ -69,6 +70,7 @@ extern int acpi_video_get_levels(struct acpi_device *device,
>  #else
>  static inline int acpi_video_register(void) { return -ENODEV; }
>  static inline void acpi_video_unregister(void) { return; }
> +static inline void acpi_video_register_backlight(void) { return; }
>  static inline int acpi_video_get_edid(struct acpi_device *device, int type,
>                                       int device_id, void **edid)
>  {
> --
> 2.36.0
>
