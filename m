Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BFB6F71E0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 May 2023 20:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEDSWK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 4 May 2023 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEDSWH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 May 2023 14:22:07 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0665BA;
        Thu,  4 May 2023 11:22:06 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so223977a12.0;
        Thu, 04 May 2023 11:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224525; x=1685816525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDn2w7A3UJg2QORoZpOscVP5cFu3kW0VUEWepoBI4No=;
        b=iV52MUQjnoofc7MlFpZhmcnAkBr0wMT9KU4bmpYndiGsdvp2tC75dz5AkTqp19oVOl
         wQb3BE8CBKK9UxbM00W3RtnchHeiHwiJPe5/7wqHcUtC4v2Ylsrx5h6+om5EpI6YH2fS
         jggv3yrObvUTCVJ+vBYEU7eu/EV+Q8mb8GhnzmK2+H7CWvKkiGbnwYrpcBU/rvTW8PnV
         0liYXG96UinElfuxSVgMM+Ap9TDEUP1TSp+nGSmMJZy0R8LO5wFQsJmyfeEg099464I2
         kHC2ps8Fd6bm5aefnpkks2fiNTSHtrcqoad2GoXoFH2FZi+ja2sMsxfo5P6R91vAlHEl
         wEeA==
X-Gm-Message-State: AC+VfDw8HK3r3lclpvGVJXP924YRjRh8bmPxcwywAkOS3dsJJgKHqfm/
        yEjVzcRQ8fGqem0rzUTsKYv1Gq+FjmffdwEwBbE=
X-Google-Smtp-Source: ACHHUZ7+PpEVFL3uvPmZ0myrCrTbP4NE3kyZZV6fgS59KBkPdLMyoiQHPwXi4caDGnlV6V/WyFtqqh/gAYhOrN4LgDM=
X-Received: by 2002:a17:906:64c2:b0:94f:4ec3:f0f5 with SMTP id
 p2-20020a17090664c200b0094f4ec3f0f5mr19012476ejn.4.1683224524703; Thu, 04 May
 2023 11:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132350.49373-1-hdegoede@redhat.com>
In-Reply-To: <20230428132350.49373-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 May 2023 20:21:53 +0200
Message-ID: <CAJZ5v0hQW6=svqLOrnwsKvotdRMYyfhCEbTvGvXULbpf8aLxAQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Remove acpi_backlight=video quirk for Lenovo
 ThinkPad W530
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?0KDRg9GB0LXQsiDQn9GD0YLQuNC9?= 
        <rockeraliexpress@gmail.com>, stable@vger.kernel.org,
        Daniel Dadap <ddadap@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 28, 2023 at 3:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Remove the acpi_backlight=video quirk for Lenovo ThinkPad W530.
>
> This was intended to help users of the (unsupported) Nvidia binary driver,
> but this has been reported to cause backlight control issues for users
> who have the gfx configured in hybrid (dual-GPU) mode, so drop this.
>
> The Nvidia binary driver should call acpi_video_register_backlight()
> when necessary and this has been reported to Nvidia.
>
> Until this is fixed Nvidia binary driver users can work around this by
> passing "acpi_backlight=video" on the kernel commandline (with the latest
> 6.1.y or newer stable series, kernels < 6.1.y don't need this).
>
> Fixes: a5b2781dcab2 ("ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530")
> Reported-by: Русев Путин <rockeraliexpress@gmail.com>
> Link: https://lore.kernel.org/linux-acpi/CAK4BXn0ngZRmzx1bodAF8nmYj0PWdUXzPGHofRrsyZj8MBpcVA@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Cc: Daniel Dadap <ddadap@nvidia.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 69ef2d9710c2..bcc25d457581 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -293,20 +293,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 },
>         },
>
> -       /*
> -        * Older models with nvidia GPU which need acpi_video backlight
> -        * control and where the old nvidia binary driver series does not
> -        * call acpi_video_register_backlight().
> -        */
> -       {
> -        .callback = video_detect_force_video,
> -        /* ThinkPad W530 */
> -        .matches = {
> -               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -               DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
> -               },
> -       },
> -
>         /*
>          * These models have a working acpi_video backlight control, and using
>          * native backlight causes a regression where backlight does not work
> --

Applied as 6.4-rc material, thanks!
