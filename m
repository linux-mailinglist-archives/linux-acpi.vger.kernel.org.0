Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E994752DC6C
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbiESSJM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 May 2022 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbiESSJL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2022 14:09:11 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172FDE324
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 11:09:10 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id i11so10383965ybq.9
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 11:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOEwORekU2PbBRSUAiEplY6lGrIo0HbWFDZMLqy82uA=;
        b=1n7D2jp6/94DQPF+pML+KuEzEAV5TjOXZxoIkPQuUGkDxXfxINFGuK6Pg+FOgqWMd0
         Jd/V7lBvRpI/xGJd+PuQwaS/CYSVFarwbEySZ2HrPLTc8TAH3GE2oEeXEfp/K6fN5UvH
         rrFDQ7UGRp1/5qW7bsjeuKy/Ikox2DN2l8YNmDWzknigtn1puIOrMqNO8LDmW8ToKvy8
         jSGBZxs8LHCrclX5zKpV1Fq858XEbO+AMzM2275rpExph+mdWnwOSeWlTFeG65Kw6OTv
         MRsKOGbPrkuVdaGqtYTvdwZUUOfF4E6w6WwM7YDBAbcnK/l4JSRjP7rzMQyZKPnGMzBc
         hdng==
X-Gm-Message-State: AOAM531swgPae3UAD3ov1GWGc6SVzQUbf0BJMdAV7iWuSj/gkPpEsZC1
        ddwmiQij94HW33rqUrZ26mi3FsjjAXEe/WicLMDiERYnT4I=
X-Google-Smtp-Source: ABdhPJxf1DJHG3GFi7f+c4JPdvOKo7CjZRo++PcL9besnNrqsePdHi97qTt8WYkIOfFfobkMNdXY5wDbHKsK54HZGjc=
X-Received: by 2002:a25:d687:0:b0:64e:3a41:8d5 with SMTP id
 n129-20020a25d687000000b0064e3a4108d5mr5618889ybg.622.1652983748168; Thu, 19
 May 2022 11:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143732.3804174-1-rui.zhang@intel.com>
In-Reply-To: <20220519143732.3804174-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 20:08:57 +0200
Message-ID: <CAJZ5v0iUafX-xEezJE=SjpujgUgWVXCpwDzGoRYRPoZ_7tRy1Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: improve PM notifer callback
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Thu, May 19, 2022 at 4:37 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> PM notifier callbacks should check for supported events rather than filter
> out the unsupported events. So that it won't break when a new event is
> introduced.
>
> No functional change in this patch.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/acpi_video.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 990ff5b0aeb8..e07782b1fbb6 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1707,24 +1707,23 @@ static int acpi_video_resume(struct notifier_block *nb,
>         int i;
>
>         switch (val) {
> -       case PM_HIBERNATION_PREPARE:
> -       case PM_SUSPEND_PREPARE:
> -       case PM_RESTORE_PREPARE:
> -               return NOTIFY_DONE;
> -       }
> -
> -       video = container_of(nb, struct acpi_video_bus, pm_nb);
> -
> -       dev_info(&video->device->dev, "Restoring backlight state\n");
> +       case PM_POST_HIBERNATION:
> +       case PM_POST_SUSPEND:
> +       case PM_POST_RESTORE:
> +               video = container_of(nb, struct acpi_video_bus, pm_nb);
> +
> +               dev_info(&video->device->dev, "Restoring backlight state\n");
> +
> +               for (i = 0; i < video->attached_count; i++) {
> +                       video_device = video->attached_array[i].bind_info;
> +                       if (video_device && video_device->brightness)
> +                               acpi_video_device_lcd_set_level(video_device,
> +                                               video_device->brightness->curr);
> +               }
>
> -       for (i = 0; i < video->attached_count; i++) {
> -               video_device = video->attached_array[i].bind_info;
> -               if (video_device && video_device->brightness)
> -                       acpi_video_device_lcd_set_level(video_device,
> -                                       video_device->brightness->curr);
> +               return NOTIFY_OK;
>         }
> -
> -       return NOTIFY_OK;
> +       return NOTIFY_DONE;
>  }
>
>  static acpi_status
> --

Applied as 5.19 material, thanks!
