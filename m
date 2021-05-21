Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13938CB7C
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhEURDP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 13:03:15 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41947 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhEURDP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 13:03:15 -0400
Received: by mail-oi1-f174.google.com with SMTP id c3so20241652oic.8;
        Fri, 21 May 2021 10:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9C98G11I159xCAmRmPZJx0v65Ewxd+8YGwIKf62AnL4=;
        b=AEHvmvP6+GGdRgG60nX66nJZ3r3LjON+tw1d3TwWzWtBI/uPNoOz3Z8J6hA6sTZ9A0
         nJZjEW28LJr2Kp3EzsWgY6ML8swxn4NyMtan97uyo4648ILrmjVSbi05EbUtu2zyKjZl
         jki5Zr4RQv5/uyJge2fP1w5LUrvNiFU21SN94MUNh/L41aQpkV/Q6Tyqb8nroqrEW/JS
         S/m3fCe/Ue7x0T7SjKO7PIWEgBpJRX9MTBKtb/jApkXmFbSrMqcbqCX8UrzBxLyJSpq4
         bTBcy2yGpL63sbmH2ElAGIsAkkyrKiHzt3ePlvWl3eQzZawILKosNauvLizyLPk7S0zR
         J2xQ==
X-Gm-Message-State: AOAM530E6Duky7HNspw7CjR9aTR/UGF789Snig1wG60oDILFSJQxxC9I
        eftwGuO4TrMmZUQ9557PgNAh6av66iBTObhGb/5GEHv5
X-Google-Smtp-Source: ABdhPJyIAQ3s/2NL/yasB6QVU69t2XaJ1Xwd7HHq1NFq2LpppSDPpm0ujp8Y/arMxWgzAtoBN4Pv6rmuXXu4ON9KHxc=
X-Received: by 2002:aca:4758:: with SMTP id u85mr2907446oia.71.1621616511532;
 Fri, 21 May 2021 10:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210514153414.847902-1-jonathanh@nvidia.com>
In-Reply-To: <20210514153414.847902-1-jonathanh@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 19:01:40 +0200
Message-ID: <CAJZ5v0han6dvOrEciq4CTqvsED76B33WzZ_naCr92QuOH_40Ng@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Don't warn if ACPI is disabled
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 14, 2021 at 5:34 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> If ACPI is not enabled but support for ACPI and APEI is enabled in the
> kernel, then the following warning is seen on boot ...
>
>  WARNING KERN EINJ: ACPI disabled.
>
> For ARM64 platforms, the 'acpi_disabled' variable is true by default
> and hence, the above is often seen on ARM64. Given that it can be
> normal for ACPI to be disabled, make this an informational print rather
> that a warning.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Please note that the motivation for this change is to filter out
> any warnings that might not be actual issues. We have some automated
> tests that we run to catch warnings and errors and although we could
> add this to a list of non critical warnings, it is preferred to make
> this an informational print.
>
>  drivers/acpi/apei/einj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 328e8aeece6c..2882450c443e 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -673,7 +673,7 @@ static int __init einj_init(void)
>         struct apei_exec_context ctx;
>
>         if (acpi_disabled) {
> -               pr_warn("ACPI disabled.\n");
> +               pr_info("ACPI disabled.\n");
>                 return -ENODEV;
>         }
>
> --

Applied as 5.14 material, thanks!
