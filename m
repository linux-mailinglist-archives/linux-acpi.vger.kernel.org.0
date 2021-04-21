Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD47A3670AF
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbhDUQ4k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 12:56:40 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38619 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhDUQ4g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Apr 2021 12:56:36 -0400
Received: by mail-ot1-f52.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso13740314ote.5;
        Wed, 21 Apr 2021 09:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChNlrqVlS1136Wfj4Y8Vdn+XtddIYDjGwRvhYBUp11U=;
        b=X/jcdsuP1+5kt0YzamIb90c+Z9XpUGKTidUctAp8A7JqZddn+6LvKiQIKL/JHVTcxn
         6CKDlLGoFs/YeR8S6/QkfIC2AH6sIy0YTV8F++JFSUycVezQAW//ITFWzCi6TbgAfKas
         umaf4/AfwaGhXjbHVdNcway2ZPJ+Gk0muW6EsypOs+U3W4hw11qgKKGTKg0vuDVZtkuD
         0xsY1LIX2WpsHFaWBUyt9KDgaLCjDp/g4nhN0GU/nUxY6va1/j5JobSEP4Y8pDC1ZE8m
         kJb4FL/tZBgzxEPRazlhbDUvBwWsEzMrGuwU5qF3al/ckH6x5zwFNqLT2c7n0S2k9CzG
         M0Tw==
X-Gm-Message-State: AOAM532lGAzJOD4lxXZFDu+ShYJ1qX1N/puKa2QDfcUw/RMi8cXBd/1l
        6ax/0oK2X//zXrsYcJ98vHToj8+KcaJuIq+ZAGq7R2uN
X-Google-Smtp-Source: ABdhPJxwRVA/VN6Opiu8fctg/Gb4T6S6FT8sMKbDgkvbsFSGfe0VESJsx3nbTR1c+Vu/DRlYyqGaYi37q2CXUBOgVOo=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr24237837otd.321.1619024163004;
 Wed, 21 Apr 2021 09:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210419073917.157722-1-luke@ljones.dev>
In-Reply-To: <20210419073917.157722-1-luke@ljones.dev>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Apr 2021 18:55:50 +0200
Message-ID: <CAJZ5v0h5gwcrwTCJhNviojE_ecOsRpuRkmO4Osb=z2etSviwSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: video: use native backlight for GA401/GA502/GA503
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 19, 2021 at 9:39 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> From: Luke D Jones <luke@ljones.dev>
>
> Force backlight control in these models to use the native interface
> at /sys/class/backlight/amdgpu_bl0.
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/acpi/video_detect.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 811d298637cb..bae08bd98817 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -384,6 +384,30 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_BOARD_NAME, "BA51_MV"),
>                 },
>         },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "ASUSTeK COMPUTER INC. GA401",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "GA401"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "ASUSTeK COMPUTER INC. GA502",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "GA502"),
> +               },
> +       },
> +       {
> +       .callback = video_detect_force_native,
> +       .ident = "ASUSTeK COMPUTER INC. GA503",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
> +               },
> +       },
>
>         /*
>          * Desktops which falsely report a backlight and which our heuristics
> --

Applied as 5.13 material, thanks!
