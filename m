Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44435417878
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhIXQZJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 12:25:09 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42705 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbhIXQZI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 12:25:08 -0400
Received: by mail-oi1-f176.google.com with SMTP id x124so15106201oix.9;
        Fri, 24 Sep 2021 09:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSEXygsL3UWJLgUyzQZz+MLQB2MjhzN5ePUr9DIGp/I=;
        b=MSLvX7bmgXR5FaW5+z5pMhj4WpsLHVuBwE+CKA1U2/6ey3ItH3RjOwfD5nBqb9poPp
         jaArWk+ps8TooWiVCyFsaEZAKhUVtfGf58IN6flHRj5c+0qY5azd1QV+oGemOHd2dOm3
         nLpYFz8hFH2CNz9pBJCZDUzfMpBKQVoKtvITeqOfu5wsSBcOnPgc84avPpFsHzoxCyF5
         2BV68GB1DwUi/ewCSScrk+iYyT5DR2wVeWSlh3pbU885OSWDxM5ikgkiCDKoLfp1zmWD
         Jsnj6+eaXP0A/7hIVYuq0dyQlt5TK5AsG8vS4QnalimzRFyxMjn8eGFjGBG0jGSaThNm
         Qd0Q==
X-Gm-Message-State: AOAM53267FP0dCcVLupapYXbcIP8VdimQtZkYDqjPJsZpAVOyTnDxshM
        9/Rt2MoXikRT5j8GABLUTIL+roX0sCbOZlfcfW7ygpvR
X-Google-Smtp-Source: ABdhPJzdy7CQbWSQmdLrzlfqBN5IdWweBN19HoBiAY8lmNN0mDJTjWO2JDOuhkb06CWi3grlO5sLtrB6flhyLrLucnU=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr2120463oib.69.1632500614884;
 Fri, 24 Sep 2021 09:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210921062124.250165-1-standby24x7@gmail.com>
In-Reply-To: <20210921062124.250165-1-standby24x7@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 18:23:24 +0200
Message-ID: <CAJZ5v0i9NBmap3smR4=NuSfFuwGj9Qj+gK6hf0xN0f1ZB=G9Dg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Kconfig: Fix a typo in Kconfig
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 21, 2021 at 8:21 AM Masanari Iida <standby24x7@gmail.com> wrote:
>
> This patch fixes a spelling typo in acpi/Kconfig
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1da360c51d66..cdbdf68bd98f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -71,7 +71,7 @@ config ACPI_DEBUGGER
>  if ACPI_DEBUGGER
>
>  config ACPI_DEBUGGER_USER
> -       tristate "Userspace debugger accessiblity"
> +       tristate "Userspace debugger accessibility"
>         depends on DEBUG_FS
>         help
>           Export /sys/kernel/debug/acpi/acpidbg for userspace utilities
> --

Applied as 5.16 material, thanks!
