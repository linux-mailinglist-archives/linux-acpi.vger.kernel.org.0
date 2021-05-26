Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D5391A8A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhEZOpX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 10:45:23 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36382 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhEZOpW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 10:45:22 -0400
Received: by mail-oi1-f179.google.com with SMTP id t24so1726876oiw.3;
        Wed, 26 May 2021 07:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bwx+7lo4SfRWj6YJZuZRRCA4lszy3g5/1sk2W/GIqG8=;
        b=Ecc9Gj7R5DnY5s+2tOjzyHz+UqdCkYy2AcIkQwnOyCkPMtcjdxVXdN7EZiYGnYSYgr
         QbvIiRldX+PTuUSNU00a1XFYk+/tq7gu20uZJ+RrwW5crY6/2D4L0Ky4iLQ7Y+9pupKo
         dQ4b9KB/SapZa3pghlSZANGWtlU3upUmffDhXAlxXct2Yr7wP4Jvj8+KmP3bUt+Ji7h+
         QDcifHOqlPEt4G8HBomBC1cYbP+oUCQY3khSzr4KDgonpikmbZ+0J4dY6YY8O5Tlsmsp
         BidcyIMwiCE7DCHNXTUf/hAiG4nJS3NPSFHMp1dAjmdFkS1Tivfw/NF5WSj1evrclQXk
         6PkQ==
X-Gm-Message-State: AOAM5311Sl9qTi+X9rv+DsoOBjL9f+n6FljMTGkcB45O4znW8BI90hxh
        A1SvmexOuLDn5huA/hlfLhEbZTvd8yrEkj5pDjF/1UdQ/68=
X-Google-Smtp-Source: ABdhPJw/XEgY8ojhUczCLVWlMHRKDt1AP9EPzVWiqzR/icVxLT9qbv6/l4ERqIRVlZZwLbfY0O66rTlT0i4Y5niduus=
X-Received: by 2002:aca:1910:: with SMTP id l16mr2085180oii.69.1622040231145;
 Wed, 26 May 2021 07:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210526141252.3750231-1-colin.king@canonical.com>
In-Reply-To: <20210526141252.3750231-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 May 2021 16:43:40 +0200
Message-ID: <CAJZ5v0hfi9mZb-9Zb5FGUn1mC9L8hAacpmDDzbDtB+prZczt4A@mail.gmail.com>
Subject: Re: [PATCH][next] acpi: power: remove redundant initialization of
 variable result
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 26, 2021 at 4:12 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable result is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 97c9a94a1a30..d86865c04f64 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -919,7 +919,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
>         union acpi_object acpi_object;
>         struct acpi_buffer buffer = { sizeof(acpi_object), &acpi_object };
>         acpi_status status;
> -       int state, result = -ENODEV;
> +       int state, result;
>
>         acpi_bus_get_device(handle, &device);
>         if (device)
> --

Equivalent change is made in

https://patchwork.kernel.org/project/linux-acpi/patch/2786380.e9J7NaK4W3@kreacher/

Thanks!
