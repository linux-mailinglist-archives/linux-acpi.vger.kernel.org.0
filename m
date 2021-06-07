Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C786039DE95
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 16:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFGOXD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 10:23:03 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38667 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGOXC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 10:23:02 -0400
Received: by mail-ot1-f48.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so3256675otk.5;
        Mon, 07 Jun 2021 07:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAsSjfj2SNggq5aDpsaUA7NHuq0dKKwyDcbMekujl4w=;
        b=RwmEGdHhjtG0Ivih9NCEP+hGNcyJsoH82gd2d3yrlgkapOcv/Y6VYlRwORqZkRepWG
         UUD+Ubnfszilv/FAYAJYs5JDEqD8M+oPd8KKU11u7ciq500un/D1EpREHhhqazLtxSHF
         cvguzUpVWu0HIKEmrShScSVrz8JbcY1QHSPF8qQ2yqWnVbwNi3dofBJPvbx1oA/6PdCk
         n+Ua4oO2/4immTHvi24UnuMSKkip9zLJib+oqwHWcBWgODIZ7KjpCSzPKhDkmuHx+S7X
         JxyUd1Hwo59IUTjH25/tSFXeXy7m4Eq536VCqKx7KdhgPmJdzXgCyMq5PUBJB4otXHYT
         eHIQ==
X-Gm-Message-State: AOAM532ZFKmOhPgMWRYPOLL8RFY8fq/mLAsmKpJeut2CsBdU6CiCYMor
        v7zaf9LxjSx4WQGNhi15pPLWLJyxHmhA3wkop5E=
X-Google-Smtp-Source: ABdhPJxxciMU1F+M/NaskPlAZGSFxCEC6DOsxcE1ZgSCqkbP2bWW1JV0lYdePueYXcrZa9fPGHKbLuiXSTVb9OFSlao=
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr14542961otl.206.1623075659890;
 Mon, 07 Jun 2021 07:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210603091204.355720-1-liushixin2@huawei.com>
In-Reply-To: <20210603091204.355720-1-liushixin2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 16:20:48 +0200
Message-ID: <CAJZ5v0jTqE+h3L3od2i7Y8xTTsKTz=26PQzVO8ZWugUJ0uhZDA@mail.gmail.com>
Subject: Re: [PATCH -next v2] ACPI: LPSS: Replaced simple_strtol() with kstrtol()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 3, 2021 at 10:39 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> The simple_strtol() function is deprecated in some situation since
> it does not check for the range overflow. Use kstrtol() instead.
>
> As the variables status and shared_host are valid only when the uid
> is not zero(default to zero). If uid_str is NULL or kstrtol() failed
> or uid is assigned to zero, related operations can be skipped.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> v1->v2: The previous description is inaccurate, so modified it.
>
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
>
>         lpss_deassert_reset(pdata);
>
> --

I've applied this as 5.14 material, but I made some changes to it,
including a subject and changelog rewrite.

Thanks!
