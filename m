Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E85444815
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 19:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhKCSQy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 14:16:54 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37626 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhKCSQx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 14:16:53 -0400
Received: by mail-oi1-f174.google.com with SMTP id o83so4990898oif.4
        for <linux-acpi@vger.kernel.org>; Wed, 03 Nov 2021 11:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KS1PDgoIfAnaRTdB3tJipwqX0gGS3+Xy8mevkGMGDa4=;
        b=1LNDCa+kXI9Yy9tzPdOVPUa0XHhEx43crVjvHhTAhriW6LC9M7kbQUxOjz7zDdn+zt
         Q4SR72YZrACLLEeb++UV6OI5Z+l+xoR9rrTBUjKXweBRmTOjsVvPG3Zk33t0rR7rTR1O
         yRSy3LvgOUzavSQ+daSLTctXpl8QEQXmh0JNbfFDBrPOvy6y+bXbiDctbCkEo6luWva0
         qXtGa/jgYAVw0ElquIJH+R/0Rs6J21IdjdZnGGaPZzzKlff6Zos4+MzgEZ6HjPbHSBIE
         UcpxYjz9BFZ5cubwel0LyEXS3dzY4f0/DlZmV7wEVwfduTT5bNrJc/00x6AfqqQHXjh7
         LNnw==
X-Gm-Message-State: AOAM531V+Fh7wzHt0hdpGLGZDUvlFYPWIzI6WE7Yndgb59tTihMHqhOS
        SBvKUQysxWLvWR/hW8zqN+kc1orETEswHAsQMh0=
X-Google-Smtp-Source: ABdhPJxKX+clGNVfZZAQ/LWXEI3QGyGeoN4RVZcVWsG6xAC0229kHZZWYrPJJTqaFI9Y4ctRJSdDABPxQ0tHAB1DEOI=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr11910089oil.166.1635963256439;
 Wed, 03 Nov 2021 11:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211028134432.31719-1-zhoubinbin@uniontech.com>
In-Reply-To: <20211028134432.31719-1-zhoubinbin@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Nov 2021 19:14:05 +0100
Message-ID: <CAJZ5v0iOqnZkzN8dZUyW76Oi_wcKcT5+i2mFjFWzG89sRdoCkQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / EC: Use ec_no_wakeup on HP ZHAN 66 Pro
To:     zhoubinbin@uniontech.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        zhoubb.aaron@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 28, 2021 at 3:44 PM <zhoubinbin@uniontech.com> wrote:
>
> From: Binbin Zhou <zhoubinbin@uniontech.com>
>
> EC interrupts constantly wake up system from s2idle.
> So make ec_no_wakeup be true as default to keep system in s2idle mode
> and reduce power consumption.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@uniontech.com>
> ---
>  drivers/acpi/ec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e629e891d1bb..7c32da8f51ed 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2152,6 +2152,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>                         DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
>                 },
>         },
> +       {
> +               .ident = "HP ZHAN 66 Pro",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
> +               },
> +       },
>         { },
>  };
>
> --

Applied as 5.16-rc material with some edits in the subject and
changelog, thanks!
