Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF29438E8B8
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhEXOaR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 10:30:17 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34343 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhEXOaR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 10:30:17 -0400
Received: by mail-ot1-f54.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso25413472ote.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 May 2021 07:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U14v+DdrGbltVL89SjU3It8u828Vw8uaWRrfE3ghzIo=;
        b=Tywk9N3rRTArA2jlxvV9ygdWzAwj7+sAn7Na2w03epnDfSzxx0yRTgrxqQyIZXf6HY
         VJETibhxP1kXAc5b+f8x8LV/+TrR5svuvTyPCCINoPkYFza6GmIcY0y2BYtbLdxR/3u/
         bdmgf6rf0qxivSbLZQfr/wR7YpeN6Xp6ylHjqv1gl6wwLYVsm88laawPG42OxE2EPumN
         ePaTSDBOHWuI50Ew87A/bhU/HkI0Bfz9Pg8Mz2QVrz01sQrJy6fRSvbA+yapgZS3MUz3
         BcI4HBA++kEb0nZuBZz6TAedjgeYSpN6ZDi2mizaYrn0nLSEfKekVnIJLKg849juGoxx
         /Q1g==
X-Gm-Message-State: AOAM533+b6W2XQnRRsxchiTiaB5+wcv+py3KArkEBMQsmnbEWfOoRzkG
        UghR0k2PCBOhoPzrnMMe3BFpTff/Q3Qc6R5J7mLOtbfp
X-Google-Smtp-Source: ABdhPJwRELhMRRk8gMHrIqS8NkXBmWJsrjm7xbCYi0/xh3YIX8LgfPnYJEsuH9Ul48MMYMrAy+XTZdFXQBleGdxltrg=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr18728238otq.260.1621866528684;
 Mon, 24 May 2021 07:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1621845308-19052-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1621845308-19052-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 May 2021 16:28:33 +0200
Message-ID: <CAJZ5v0iWUu7ZFY5bAucubawPeKTkFf4AJfaXofyENBGa0Pd7uA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: ipmi: Remove address space handler in error path
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 24, 2021 at 10:45 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> The acpi_install_address_space_handler() is coupled with
> acpi_remove_address_space_handler() in ipmi module init/exit, but failed
> to remove the handler in acpi_ipmi_init() if the ipmi_smi_watcher_register()
> failed, so adding the removal of the address space handler in error path.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/acpi/acpi_ipmi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index bbd00d9..a5fe292 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -597,9 +597,14 @@ static int __init acpi_ipmi_init(void)
>                 pr_warn("Can't register IPMI opregion space handle\n");
>                 return -EINVAL;
>         }
> +
>         result = ipmi_smi_watcher_register(&driver_data.bmc_events);
> -       if (result)
> +       if (result) {
> +               acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
> +                                                                                 ACPI_ADR_SPACE_IPMI,
> +                                                                                 &acpi_ipmi_space_handler);
>                 pr_err("Can't register IPMI system interface watcher\n");
> +       }
>
>         return result;
>  }
> --

Applied as 5.14 material with some edits in the changelog, thanks!
