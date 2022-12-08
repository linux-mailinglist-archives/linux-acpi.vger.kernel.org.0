Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653A7646EA0
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 12:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLHLdH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 06:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLHLdG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 06:33:06 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA166CA8
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 03:33:05 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id e1so310533qka.6
        for <linux-acpi@vger.kernel.org>; Thu, 08 Dec 2022 03:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w87TfVGn5PUwe/KKPd/uOeQcjUWN/xjtGNqcaxIYhMM=;
        b=IbnXV1CNCilvjGWQmwAvl/Ru1+uxYr/i1BNWv92EzkjMzSDLa1N7OIK6l72TUP5Be7
         Tdc3QT96A6KKMHif5J65/tzp3Ds+QRq9G6Apq7h4URH76xL55uhNKPEqhKauycnCZzbK
         IIRw546Fh2XdYS4J3T6gBWR73olhYcFhhMEb5AwzlhgwJO5ADKcUBjb9VeFSIYT1eLGo
         SGXpawZlj1hPwDhtyHBQXScrVj89dm+S8F6CNceFcg6dJM9qPUFyte45KhBh7oAuF+Vg
         PubiDXtY3dYf/WSulki3rur1sq/wnut+QT+hldMqjpsO4zofoc3ncsZNH3iC/Jyhft71
         fLyg==
X-Gm-Message-State: ANoB5pmXnpNE63zN4MLCOLfh90Sb3UM0zHXFzMa5Gb94Sru/qA7MJFgs
        u7wlGA9ieG5hu3bsg8z/V/57ZmO7dreVyGGnOoE=
X-Google-Smtp-Source: AA0mqf76Ewz158N05kPTKneS5XKrQagYNX4mcsqZgDDBRvXGV9Q49RFdt3HYFqFsvWInKs66iky0iE3N7ayswexyNKo=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr82252364qki.23.1670499184625; Thu, 08
 Dec 2022 03:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20221208010910.7621-1-mario.limonciello@amd.com> <20221208010910.7621-2-mario.limonciello@amd.com>
In-Reply-To: <20221208010910.7621-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 12:32:53 +0100
Message-ID: <CAJZ5v0jZd=g_TM5OFiVq-WuaRykdtk-sV1VU6=izsvwGhGPALQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: video: Allow GPU drivers to report no panels
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        Daniel Dadap <ddadap@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 8, 2022 at 2:09 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The current logic for the ACPI backlight detection will create
> a backlight device if no native or vendor drivers have created
> 8 seconds after the system has booted if the ACPI tables
> included backlight control methods.
>
> If the GPU drivers have loaded, they may be able to report whether
> any LCD panels were found.  Allow using this information to factor
> in whether to enable the fallback logic for making an acpi_video0
> backlight device.
>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Cancel registration for backlight device instead (Hans)
>  * drop desktop check (Dan)
>
>  drivers/acpi/acpi_video.c | 11 +++++++++++
>  include/acpi/video.h      |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 32953646caeb..f64fdb029090 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2178,6 +2178,17 @@ static bool should_check_lcd_flag(void)
>         return false;
>  }
>
> +/*
> + * At least one graphics driver has reported that no LCD is connected
> + * via the native interface. cancel the registration for fallback acpi_video0.
> + * If another driver still deems this necessary, it can explicitly register it.
> + */
> +void acpi_video_report_nolcd(void)
> +{
> +       cancel_delayed_work(&video_bus_register_backlight_work);
> +}
> +EXPORT_SYMBOL(acpi_video_report_nolcd);
> +
>  int acpi_video_register(void)
>  {
>         int ret = 0;
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index a275c35e5249..1fccb111c197 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -53,6 +53,7 @@ enum acpi_backlight_type {
>  };
>
>  #if IS_ENABLED(CONFIG_ACPI_VIDEO)
> +extern void acpi_video_report_nolcd(void);

It looks like a stub is needed for the other case.  Apparently, things
fail to compile due to the lack of it.

>  extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
>  extern void acpi_video_register_backlight(void);
> --
> 2.34.1
>
