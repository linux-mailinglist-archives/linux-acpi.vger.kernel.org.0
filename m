Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C627A5261
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIRSyB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 18 Sep 2023 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIRSyA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 14:54:00 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE602112
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 11:53:54 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5769a4d011cso271733eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 11:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063234; x=1695668034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPFJeeBxPS3vFECXGXjz6zN4u5TksE1DbJlZDnhD32A=;
        b=k62a2vGmT3w0iylYxbqlwnvPKw1q5dT/UXzhwnDQzIhu7zde9LANrgi/x4s5MxHYcl
         5hDraMSgV5+ac8nwnASv+aWl5QliMWtkSVeyJnxHJkqxvr3t0L55pZr3Ov2UhbLJDrbA
         Kkl3bZsmFEAAuWzL9j8hlaL/7NNwYxTZI80A6pF6aHkDpMZ2J20gwa4K6gZ56vbwEFvz
         oOlqb8qKb31OelQYwvaLacAeaBuzUplf4DvVG2IioMj9EUhhsjKthUcevp8+clLDC4HF
         VmV38n3KATO5HYn/+rPinQ4FAv24SOh5Qj/wbR1Aj/PivCsCM4nT81dsIzAt/YJmv/cF
         t/WA==
X-Gm-Message-State: AOJu0YxPU4YtCcZ+DR6eyk9O6NvgonqRpzQUwO2f/3G91AwgS9yL4VAi
        mEjUom/0i43eCFcHLK+f8aUevsVY2+jH8/dq9pM=
X-Google-Smtp-Source: AGHT+IGXkDmPT2btxcAlt+X5VvVwLUOAd/xDo4b4U0soPOUWVeISDRhDjXloaK48Vhguj1CZhbE6gCSWC/FDIi2mrQU=
X-Received: by 2002:a4a:dc93:0:b0:573:4a72:6ec with SMTP id
 g19-20020a4adc93000000b005734a7206ecmr9908159oou.1.1695063234172; Mon, 18 Sep
 2023 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230915212902.59586-1-hdegoede@redhat.com>
In-Reply-To: <20230915212902.59586-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 20:53:43 +0200
Message-ID: <CAJZ5v0jECqi-6da5=JfotG+_aHG75gN2q4edo+CDzrDGHW_9qA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: video: Move Xiaomi Mi Pad 2 quirk to its own section
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 15, 2023 at 11:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Xiaomi Mi Pad 2 is currently listed under the:
> "Models which should use the vendor backlight interface,
> because of broken ACPI video backlight control." section.
>
> But this is not 100% correct. The Xiaomi Mi Pad 2 is one of a set of
> x86 tablets which shipped with Android as factory OS. These tablets
> have a TI LP8557 backlight controller with its PWM input _not_
> connected to the PMIC or chipset (LPSS) PWM output.
>
> Instead the backlight can be controlled by configuring the LP8557
> for direct control through its brightness I2C register and then
> using the lp855x driver.
>
> This setup means that neither i915's native or acpi_video backlight
> control works, so a "vendor" quirk is added for these tablets to
> disable both the native and acpi_video backlight devices, but these
> devices do not use vendor control in the typical meaning of
> vendor specific SMBIOS or ACPI calls being used.
>
> This patch is a preparation patch for adding "vendor" quirks
> for a couple more such tablet models.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 442396f6ed1f..889902a4fdfe 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -229,14 +229,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_BOARD_NAME, "NC210/NC110"),
>                 },
>         },
> -       {
> -        .callback = video_detect_force_vendor,
> -        /* Xiaomi Mi Pad 2 */
> -        .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
> -               },
> -       },
>
>         /*
>          * Models which should use the vendor backlight interface,
> @@ -799,6 +791,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 15 3535"),
>                 },
>         },
> +
> +       /*
> +        * x86 android tablets which directly control the backlight through
> +        * an external backlight controller, typically TI's LP8557.
> +        * The backlight is directly controlled by the lp855x driver on these.
> +        * This setup means that neither i915's native nor acpi_video backlight
> +        * control works. Add a "vendor" quirk to disable both. Note these
> +        * devices do not use vendor control in the typical meaning of
> +        * vendor specific SMBIOS or ACPI calls being used.
> +        */
> +       {
> +        .callback = video_detect_force_vendor,
> +        /* Xiaomi Mi Pad 2 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
> +               },
> +       },
>         { },
>  };
>
> --

Applied as 6.7 material along with the [2/2], thanks!
