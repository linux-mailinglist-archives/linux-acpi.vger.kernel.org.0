Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A306664A8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jan 2023 21:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbjAKUQG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Jan 2023 15:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjAKUQE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2023 15:16:04 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30CF2606
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 12:16:02 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id hw16so27832016ejc.10
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 12:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1z4PL/IN1LIv7OyxQoymzmK/KzEPD/HExGAo5iOmQg=;
        b=TWy7Za/03wzouD5yah/vW/b1BYLNreyWC7oROzkAkZX6cY2z+S7QvJEJcw+ociDUwc
         jNcVxsmmaI8MuWv1LFZ/cQ8fzqYLtzedxekENdL0WX8DTS9P/aZjL764MD8JqY4LG/7E
         sDsTfux8mp+8Fgo+HEnVY4Id4V4R8OILh3NVp2VoqqJgDQNmlkeRIq4LxUKiqbICfwRM
         OLnPtOzlzA38Qi0EV7/FObe65XeKNKifT0rKxP0S0M9DhuT2TqHDItjGvJ6X/7cz3c7L
         8JEBEoxnount1HIbhf1YbU8nu37Xt9leQVCt2S7kBmeweOE6c9ecTzGljuiDjBJHp8Lo
         FPfg==
X-Gm-Message-State: AFqh2kpArlkwDFdNEJC7SO3MW619t868TszVSp1EhYu/xo8uPUgIqDRr
        MyI5ifjIxe+AlbTcXNYokSIR2BIpqCuIGuI0/UA=
X-Google-Smtp-Source: AMrXdXuSJbGFSCkkaAXUdQYkZIuuWjMUfbCPchNpj7QpD2vsG8xLKF1RBydeaZBMkDnUHCjoweDtFLi1hGcx8ALhxWI=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr5386606ejc.246.1673468161612; Wed, 11
 Jan 2023 12:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20230109191811.53961-1-hdegoede@redhat.com>
In-Reply-To: <20230109191811.53961-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 21:15:50 +0100
Message-ID: <CAJZ5v0i6iLPRctJ7cwGoBVmDDhQgbGw9cvqVu_Q8mebjkP7Dwg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Allow selecting NVidia-WMI-EC or Apple GMUX
 backlight from the cmdline
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 9, 2023 at 8:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The patches adding NVidia-WMI-EC and Apple GMUX backlight detection
> support to acpi_video_get_backlight_type(), forgot to update
> acpi_video_parse_cmdline() to allow manually selecting these from
> the commandline.
>
> Add support for these to acpi_video_parse_cmdline().
>
> Fixes: fe7aebb40d42 ("ACPI: video: Add Nvidia WMI EC brightness control detection (v3)")
> Fixes: 21245df307cb ("ACPI: video: Add Apple GMUX brightness control detection")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 1b78c7434492..8a541efc5675 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -50,6 +50,10 @@ static void acpi_video_parse_cmdline(void)
>                 acpi_backlight_cmdline = acpi_backlight_video;
>         if (!strcmp("native", acpi_video_backlight_string))
>                 acpi_backlight_cmdline = acpi_backlight_native;
> +       if (!strcmp("nvidia_wmi_ec", acpi_video_backlight_string))
> +               acpi_backlight_cmdline = acpi_backlight_nvidia_wmi_ec;
> +       if (!strcmp("apple_gmux", acpi_video_backlight_string))
> +               acpi_backlight_cmdline = acpi_backlight_apple_gmux;
>         if (!strcmp("none", acpi_video_backlight_string))
>                 acpi_backlight_cmdline = acpi_backlight_none;
>  }
> --

Applied as 6.2-rc material, thanks!
