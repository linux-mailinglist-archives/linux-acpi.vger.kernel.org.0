Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E738E8CA
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhEXOfa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 10:35:30 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36404 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhEXOfa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 10:35:30 -0400
Received: by mail-oi1-f174.google.com with SMTP id t24so11720728oiw.3;
        Mon, 24 May 2021 07:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIQFsFAcuT6ezcc/lSj+Ubd3KgT48ueLGhHc3ywPu98=;
        b=LLomuOFbkgpfhQ9zKze2u0D3Hti6/9ZMdLLCI+U2O4Ny3Z4WWk3IlhqDznPQKiJn1k
         6pgVYsP7q27AdtdGjFl0B2vFJLnB/zPiTclYdmFHOdCFkoLkIUC69REZqyXvetGgW/aP
         jQh2eJDWRkjfVPGG2lrshU8gpLOfCa0eujidyZaWsbVWr+7RJS9GpCysRni6oo8mR/JK
         Ru3E6neryFBhVS8L+Rty/hPfN/kZOdsv/4ZlPhQwSXbB1UveqVL9+xs4naIIfGrAhU+6
         YXF/1WG1YBoUlBc5bi+iCwPlnP8lFQMSxAbhL3IeuE7ukO4eWB5udaXqlcE3a8qBTMFj
         yJDg==
X-Gm-Message-State: AOAM533S0dXxU1C09h8FVBLA7UdBSkW7X7pkKqQeeUrdzmmUwjLx/GCT
        bPUrLhKwnvm781I/DTP2q0T8y3Y23GWk9Jr7dYE=
X-Google-Smtp-Source: ABdhPJxLYWYIr1dHL5IvKWcX5gy28IJjtUtHR22kN8XQzyQ4zVA6C24pJNV4vzR5FyP2pmGBmiWYwB9Lnyn1cwQX3Js=
X-Received: by 2002:aca:380a:: with SMTP id f10mr11399113oia.157.1621866842300;
 Mon, 24 May 2021 07:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210524120832.1580247-1-liushixin2@huawei.com>
In-Reply-To: <20210524120832.1580247-1-liushixin2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 May 2021 16:33:46 +0200
Message-ID: <CAJZ5v0gZYupB2w4oU1QGvE5aohcyPXk=BJVRvSrApGzp=sXkMQ@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: LPSS: Replaced simple_strtol() with kstrtol()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 24, 2021 at 1:35 PM Liu Shixin <liushixin2@huawei.com> wrote:
>
> The simple_strtol() function is deprecated in some situation since
> it does not check for the range overflow. Use kstrtol() instead.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/acpi/acpi_lpss.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index ca742f16a507..1b46e00cad3a 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -186,13 +186,12 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
>         long uid = 0;
>
>         /* Expected to always be true, but better safe then sorry */
> -       if (uid_str)
> -               uid = simple_strtol(uid_str, NULL, 10);
> -
> -       /* Detect I2C bus shared with PUNIT and ignore its d3 status */
> -       status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
> -       if (ACPI_SUCCESS(status) && shared_host && uid)
> -               pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
> +       if (uid_str && !kstrtol(uid_str, 10, &uid)) {
> +               /* Detect I2C bus shared with PUNIT and ignore its d3 status */
> +               status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
> +               if (ACPI_SUCCESS(status) && shared_host && uid)
> +                       pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
> +       }

This is not a simple replacement.

Why are you making the other changes?

>
>         lpss_deassert_reset(pdata);
>
> --
