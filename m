Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8A66DDB0
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 13:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjAQMee (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 07:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbjAQMed (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 07:34:33 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5635264
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2023 04:34:32 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id v13so10743112eda.11
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2023 04:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdjH7apTcY9B0+5D5jb83+J30HHxoTwlJfxN/zgwRAU=;
        b=pG99hCn33pzLJYPmV+9qufShAplTZU40zG4KjtRh6GPXim78tHM8FMfKuz/U0a4qLL
         f8PnPmUT+8VGVOCastdpQ6qooIPniNRM6Mfx/xjJ1x5xPhrJqWuGTKs4/7zX4l6jMw8z
         BTXC2PrtU0CYudSfbgATbECJPgJTlVKGvACL69VpsCkO0I+50Qqaxaxp4WTayk0HdWqP
         oWijK3NZnqSxQ8S4ZrcBAd5ctzRSfb651fNoKVrymkHDH0Vp7hRQ4lR8w3oWPlHoghp+
         eupVkl0lHDZpph+UCPp/FL+gP36PK3beeUc8elOkeP7kvag1s/Qs+ITlogq1J3bprpz2
         3G2Q==
X-Gm-Message-State: AFqh2kopalLUv6G6A0Df0qK9TFApP4MuChvpx1tGIiivZXG+rOnkNW+x
        tsi5hX26ih9m7vNk6o0I1tq7GUjKXWSow9c7EmI=
X-Google-Smtp-Source: AMrXdXuFCOCNpoVmGyvFxctrN9qZgji19esmpfIQA+tLyPO9tyfRTurcKrMBVsO8XPIhkRuGqWM5x0uBdWAYIX+K37w=
X-Received: by 2002:a05:6402:94a:b0:47f:7465:6e76 with SMTP id
 h10-20020a056402094a00b0047f74656e76mr294884edz.181.1673958870716; Tue, 17
 Jan 2023 04:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20230113114126.172078-1-hdegoede@redhat.com>
In-Reply-To: <20230113114126.172078-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 13:34:14 +0100
Message-ID: <CAJZ5v0jt+AArS=QyuA0mi8c9_f=8mfWgp_kGHk_iR1m15QwHFw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Acer
 Aspire 4810T
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Fri, Jan 13, 2023 at 12:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Acer Aspire 4810T predates Windows 8, so it defaults to using
> acpi_video# for backlight control, but this is non functional on
> this model.
>
> Add a DMI quirk to use the native backlight interface which does
> work properly.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index d4edd64dcc2f..fb526ba8825b 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -515,6 +515,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
>                 },
>         },
> +       {
> +        .callback = video_detect_force_native,
> +        /* Acer Aspire 4810T */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 4810T"),
> +               },
> +       },
>         {
>          .callback = video_detect_force_native,
>          /* Acer Aspire 5738z */
> --

Applied as 6.2-rc material, thanks!
