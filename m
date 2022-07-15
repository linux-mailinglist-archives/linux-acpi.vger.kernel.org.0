Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0F576689
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiGOSJS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiGOSJN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 14:09:13 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E13B483
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 11:09:12 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ef5380669cso54351827b3.9
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 11:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bw1uSs/Eb9GIVkRMCQsvV0qbfxa71eYd3J16aantJus=;
        b=OJmeaxaHzuv8V6hRHDtkAd8n8oEs+1x9OU7nWmHfigGy5OGRYFsRu2Gd32Zyn66+/g
         WXh1NEZX342ig7qSXQmWdHZ0V5hppwIZlKAaAKAdn7G48l+Kti1Kc+YQDHiReYdcz6jQ
         Nv+oMV9IH8qvna5Dxa8UcL+H7jQAC0siOZwAtac1oUB4sWfnEKun5t4+zU+Shtzv4wqf
         gAAi8imRCu6h4mg1ASDYDg2mIaoI2h4uUV963rGfZCOCQqkzumK641bUGTABX95PG9aw
         Fw1psUfiG3Z7B+PMaS4y/VoHYvyrxrApA9GROgW2p80yzJG+sKr4rCiPTHPVrIKzFanB
         I39Q==
X-Gm-Message-State: AJIora9jte0TtoIMGTZY5ln4sY4Hy/OxC059hlA+tnXXrjjFbHJIIUTe
        fcMP/TYKv9cUA3rS2u9C9tsMqciboHvyyqxLHLfW6ikj
X-Google-Smtp-Source: AGRyM1uqyNC9nXCnwE5sdUmHoJ8Yda1Urfw0Y+cslvJ0gSy8jaxgyQF8wuMbv4GMbqrbyZGLKECcU65ZE8nkfQCFgkg=
X-Received: by 2002:a81:a184:0:b0:31c:b00e:b5c4 with SMTP id
 y126-20020a81a184000000b0031cb00eb5c4mr17862915ywg.149.1657908552288; Fri, 15
 Jul 2022 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220714191611.10242-1-hdegoede@redhat.com>
In-Reply-To: <20220714191611.10242-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 20:09:01 +0200
Message-ID: <CAJZ5v0hA9H-ZHU5BfZeurnB_kGnpsq5ehkjQYwjpi5xwwaza=w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Use native backlight on Dell Inspiron N4010
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ben Greening <bgreening@gmail.com>
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

On Thu, Jul 14, 2022 at 9:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Dell Inspiron N4010 does not have ACPI backlight control,
> so acpi_video_get_backlight_type()'s heuristics return vendor as
> the type to use.
>
> But the vendor interface is broken, where as the native (intel_backlight)
> works well, add a quirk to use native.
>
> Link: https://lore.kernel.org/regressions/CALF=6jEe5G8+r1Wo0vvz4GjNQQhdkLT5p8uCHn6ZXhg4nsOWow@mail.gmail.com/
> Reported-and-tested-by: Ben Greening <bgreening@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index becc198e4c22..4099140bbd5f 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -347,6 +347,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
>                 },
>         },
> +       {
> +        .callback = video_detect_force_native,
> +        /* Dell Inspiron N4010 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron N4010"),
> +               },
> +       },
>         {
>          .callback = video_detect_force_native,
>          /* Dell Vostro V131 */
> --

Applied as 5.20 material, thanks!
