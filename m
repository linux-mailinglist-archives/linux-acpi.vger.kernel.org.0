Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C724C4F23
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 20:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiBYT6Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 14:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiBYT6X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 14:58:23 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D405674A;
        Fri, 25 Feb 2022 11:57:50 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id u12so7948434ybd.7;
        Fri, 25 Feb 2022 11:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wk8QcEWvaTEgu+zJAmFRTMbhtVwPnp1G6zUVaC7ysZM=;
        b=19xBXEDlQPY/8butZnaZaWsE4/61injou19eOw4XrkO9RUs9mOJlF2Y7lBGOhddM2p
         bP9jWxjSiNQTCCuZqhVHrHqBxdReJZUHbk011tMCq3la93BTt9lmKgFOTAAuYfni4Gm4
         /ayAZYi7tyvnsURNAUrOHjKhAyoWRpdWTFQonLlD9C2KTVUiP/q0qG5hrbxQsxVQlbRz
         IPoTj5rXMT4KoLo8Lb69tCmBG93t3rkveM3A3IBnGCZgMXPowisGI6gofMXerL8F7qPz
         0EID+HgP/SQfySPieAChFR9OJQMobAWXn1/bufhsDr/l5vRuUXpiRd/eal9w5pl4qoSZ
         2BBQ==
X-Gm-Message-State: AOAM532WXS4KhRQn8zrkxlyqK+5g4Ds5Z5+cuFoEwVpW6FMd1HoL1kna
        IuLec+o1cdPgr6ReC23hA+43Z5p8/Bgyz3/Ydsk=
X-Google-Smtp-Source: ABdhPJxvTl7Zj3GFzJQbsZAxzJKKXXqAvcRfOEm3IDuy/P3RQHGXt//ZN/cuD42MSaXFxSpXsViqU8Cn+8g8hlOHJVM=
X-Received: by 2002:a25:d90d:0:b0:615:e400:94c1 with SMTP id
 q13-20020a25d90d000000b00615e40094c1mr8762763ybg.81.1645819069661; Fri, 25
 Feb 2022 11:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20220224110241.9613-1-hdegoede@redhat.com> <20220224110241.9613-2-hdegoede@redhat.com>
In-Reply-To: <20220224110241.9613-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Feb 2022 20:57:38 +0100
Message-ID: <CAJZ5v0h3_PAwMZxOkqJ-H2ppjgu=3eOUYFuOpipqe_6F+aBjdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: soc_button_array - add support for Microsoft
 Surface 3 (MSHW0028) buttons
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 12:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The drivers/platform/surface/surface3_button.c code is alsmost a 1:1 copy
> of the soc_button_array code.
>
> The only big difference is that it binds to an i2c_client rather then to
> a platform_device. The cause of this is the ACPI resources for the MSHW0028
> device containing a bogus I2cSerialBusV2 resource which causes the kernel
> to instantiate an i2c_client for it instead of a platform_device.
>
> Add "MSHW0028" to the ignore_serial_bus_ids[] list in drivers/apci/scan.c,
> so that a platform_device will be instantiated and add support for
> the MSHW0028 HID to soc_button_array.
>
> This fully replaces surface3_button, which will be removed in a separate
> commit (since it binds to the now no longer created i2c_client it no
> longer does anyyhing after this commit).
>
> Note the MSHW0028 id is used by Microsoft to describe the tablet buttons on
> both the Surface 3 and the Surface 3 Pro and the actual API/implementation
> for the Surface 3 Pro is quite different. The changes in this commit should
> not impact the separate surfacepro3_button driver:
>
> 1. Because of the bogus I2cSerialBusV2 resource problem that driver binds
>    to the acpi_device itself, so instantiating a platform_device instead of
>    an i2c_client does not matter.
>
> 2. The soc_button_array driver will not bind to the MSHW0028 device on
>    the Surface 3 Pro, because it has no GPIO resources.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the change in scan.c and I'm expecting that you'll take care of
this series yourself.  Otherwise, please let me know.

> ---
>  drivers/acpi/scan.c                   |  5 +++++
>  drivers/input/misc/soc_button_array.c | 24 +++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 4463c2eda61e..e993c8b253f5 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1749,6 +1749,11 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>                 {"INT3515", },
>                 /* Non-conforming _HID for Cirrus Logic already released */
>                 {"CLSA0100", },
> +       /*
> +        * Some ACPI devs contain SerialBus resources even though they are not
> +        * attached to a serial bus at all.
> +        */
> +               {"MSHW0028", },
>         /*
>          * HIDs of device with an UartSerialBusV2 resource for which userspace
>          * expects a regular tty cdev to be created (instead of the in kernel
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index cb6ec59a045d..cbb1599a520e 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -469,6 +469,27 @@ static const struct soc_device_data soc_device_INT33D3 = {
>         .button_info = soc_button_INT33D3,
>  };
>
> +/*
> + * Button info for Microsoft Surface 3 (non pro), this is indentical to
> + * the PNP0C40 info except that the home button is active-high.
> + *
> + * The Surface 3 Pro also has a MSHW0028 ACPI device, but that uses a custom
> + * version of the drivers/platform/x86/intel/hid.c 5 button array ACPI API
> + * instead. A check() callback is not necessary though as the Surface 3 Pro
> + * MSHW0028 ACPI device's resource table does not contain any GPIOs.
> + */
> +static const struct soc_button_info soc_button_MSHW0028[] = {
> +       { "power", 0, EV_KEY, KEY_POWER, false, true, true },
> +       { "home", 1, EV_KEY, KEY_LEFTMETA, false, true, false },
> +       { "volume_up", 2, EV_KEY, KEY_VOLUMEUP, true, false, true },
> +       { "volume_down", 3, EV_KEY, KEY_VOLUMEDOWN, true, false, true },
> +       { }
> +};
> +
> +static const struct soc_device_data soc_device_MSHW0028 = {
> +       .button_info = soc_button_MSHW0028,
> +};
> +
>  /*
>   * Special device check for Surface Book 2 and Surface Pro (2017).
>   * Both, the Surface Pro 4 (surfacepro3_button.c) and the above mentioned
> @@ -535,7 +556,8 @@ static const struct acpi_device_id soc_button_acpi_match[] = {
>         { "ID9001", (unsigned long)&soc_device_INT33D3 },
>         { "ACPI0011", 0 },
>
> -       /* Microsoft Surface Devices (5th and 6th generation) */
> +       /* Microsoft Surface Devices (3th, 5th and 6th generation) */
> +       { "MSHW0028", (unsigned long)&soc_device_MSHW0028 },
>         { "MSHW0040", (unsigned long)&soc_device_MSHW0040 },
>
>         { }
> --
> 2.35.1
>
