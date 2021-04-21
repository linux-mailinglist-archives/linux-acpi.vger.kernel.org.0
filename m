Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C33670A4
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 18:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbhDUQxn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 12:53:43 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:38858 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbhDUQxn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Apr 2021 12:53:43 -0400
Received: by mail-oo1-f43.google.com with SMTP id p12-20020a4a2f0c0000b02901ecdbb16887so2422138oop.5;
        Wed, 21 Apr 2021 09:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WcdVAWw1wrE0hCoQ+UXML3T7kI52AZNB5+mZJ4YXyA=;
        b=cQ4bRpTUkpKMKuk/SZmMkvkZhovg70ur5KulEFMV9YTnrLMa9eL8QJATDNtikdem0H
         VTOd8ICaIePVrtuR3sl4gRUohr+xfsk9+5zxq3jn4Rz7FSoMPJfMivkDuL1AgE/4qdDo
         VHysH4Nn4kCxs7tPHEkJjJU/sCdlq+p/JpxoQgzEAlufMHuBJBa+w5iJ1FyiDqF3R08s
         aF3GAgJzG9XGzUUcEs74CY2B1zaS+Un1WiFYaYxEFmUWjjIwln+Gy/L/mSV5YbBzduBF
         4zS/h8l0gouaY80wUg1u1zq35oSllGGgCPTCvfDk3vZlsngD+ELnU0Cctq+Wtf+SLx9f
         V7HQ==
X-Gm-Message-State: AOAM5322bKVvbDQxPXPU4IwtMXw4OE6AxvKX5AAZwN64WmsKABfIYOuu
        9XYiIssSw+McSI2yCqtIneQUUJYG4dedl+D038U=
X-Google-Smtp-Source: ABdhPJxSq8Z7Oay74Ci2aElVdYLnRCXpGGB0j1dzlozKhf7iQegxeIuo8msIODvBqfSxPh1mcqBZT4r7aiHGlWtKT74=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr21492266oou.44.1619023989913;
 Wed, 21 Apr 2021 09:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210415143758.1962567-1-colin.king@canonical.com>
In-Reply-To: <20210415143758.1962567-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Apr 2021 18:52:58 +0200
Message-ID: <CAJZ5v0gogVAEZRP7AoiHhEiYcDtjsUoAUUACSpUcWBEc_qhSSw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: remove redundant assignment to variable rc
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 15, 2021 at 4:38 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable rc is being assigned a value that is never read,
> the assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/apei/einj.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 133156759551..328e8aeece6c 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -725,7 +725,6 @@ static int __init einj_init(void)
>                 goto err_release;
>         }
>
> -       rc = -ENOMEM;
>         einj_param = einj_get_parameter_address();
>         if ((param_extension || acpi5) && einj_param) {
>                 debugfs_create_x32("flags", S_IRUSR | S_IWUSR, einj_debug_dir,
> --

Applied as 5.13 material, thanks!
