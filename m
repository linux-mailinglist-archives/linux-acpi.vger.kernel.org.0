Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352E33A6954
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhFNOw3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 10:52:29 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40625 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhFNOw2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 10:52:28 -0400
Received: by mail-ot1-f54.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so11033827otr.7
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2021 07:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aumRp7CjUJDsHwDbosNyKINAILTvPiHM3xZTtVywEsE=;
        b=CzLQqLr6MHQMZIBjQFfrpdi0vlPgnHR760NlLhjIdJOP8+ORlR1FJtrjYxWW/hctEf
         l7oDT1dNhnU5lIzGwxbSNCr6kkiEdf7D0QnLdxOv1tWVY7rLa7Ohp2xde6o/YfxeRVbr
         VRxUSy5hialjFbxI2RCEL+TOMjMXL44yVjqJKo4jg7+mX0bLnwjuFDaWMY39d6tE1E4L
         34uWfcfd+A64VeZXorqJA7vlZvASpXR78PQL9M28/ryCPHiYaqM016jy+BmGGlFKTtpN
         L59oK7i90A56Zlko57iwJ0v1mCty/NNDGs3HjU+1wmaPI4zCYJ4nE6hwH6MSptpnj3H0
         XamQ==
X-Gm-Message-State: AOAM533X3e8hBtaxj9U9RR++Zym8d0z284J8mm2NpLbIHp0chEyWUbuS
        SmFkYKw9frwAtqwnUe9oUB3dZZKXMeSF1n6Bkv/Eopb0
X-Google-Smtp-Source: ABdhPJxHaK/C3NJ7Jg9YKAM26clwxW7FRAPxn3hSUQM9BWAc6Raw0s1piS7DZ1ov58CXmFCdw2eceNkrvrMRsUVb85E=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr13644517otg.260.1623682216538;
 Mon, 14 Jun 2021 07:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210612184008.666840-1-majortomtosourcecontrol@gmail.com>
In-Reply-To: <20210612184008.666840-1-majortomtosourcecontrol@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 16:50:05 +0200
Message-ID: <CAJZ5v0izub_zSJih1_5rznQPzgpHJ7-LhcWGarg7iyh+U2g-9A@mail.gmail.com>
Subject: Re: [PATCH] acpi: acpi_video: Fixed comment style code issues
To:     Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 12, 2021 at 8:42 PM Clayton Casciato
<majortomtosourcecontrol@gmail.com> wrote:
>
> Fixed coding style issues.

The comments are broken the way they are to avoid going over 80
characters.  What's wrong with them?

> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> ---
>  drivers/acpi/acpi_video.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 0c884020f74b..61e52ab5aab6 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -134,8 +134,7 @@ struct acpi_video_device_attrib {
>         u32 display_type:4;     /* Describe the specific type in use */
>         u32 vendor_specific:4;  /* Chipset Vendor Specific */
>         u32 bios_can_detect:1;  /* BIOS can detect the device */
> -       u32 depend_on_vga:1;    /* Non-VGA output device whose power is related to
> -                                  the VGA device. */
> +       u32 depend_on_vga:1;    /* Non-VGA output device whose power is related to the VGA device */
>         u32 pipe_id:3;          /* For VGA multiple-head devices. */
>         u32 reserved:10;        /* Must be 0 */
>
> @@ -1581,13 +1580,11 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
>         input = video->input;
>
>         switch (event) {
> -       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch,
> -                                        * most likely via hotkey. */
> +       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch, most likely via hotkey. */
>                 keycode = KEY_SWITCHVIDEOMODE;
>                 break;
>
> -       case ACPI_VIDEO_NOTIFY_PROBE:   /* User plugged in or removed a video
> -                                        * connector. */
> +       case ACPI_VIDEO_NOTIFY_PROBE:   /* User plugged in or removed a video connector. */
>                 acpi_video_device_enumerate(video);
>                 acpi_video_device_rebind(video);
>                 keycode = KEY_SWITCHVIDEOMODE;
> --
> 2.31.1
>
