Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18583E2B45
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 15:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbhHFNXz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 09:23:55 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46632 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhHFNXx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 09:23:53 -0400
Received: by mail-ot1-f42.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso8827224ota.13;
        Fri, 06 Aug 2021 06:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7a1wEFJxsZNYTEDT4I7VC8DBT+Dj66bXnWNfWhfqGg=;
        b=DiXEA5kJy9UQ5ulbAssNkZZlwyh+PDM4897z9fVX8cBdePvgrG3HU2fztcYemkqaBz
         mUBsrYS+mVW2a2U7/lpAT1P0YGBjQ4BYahsF95A5bw9QLg3gMHPq1zFYAtjM9bE0w9XK
         Dc28n+/h/vgkEUagUhwLY5sb5gzk4CHxdy81lejfKs9/TBrmYBhjZNdHiyNdv80Nchgw
         j61ulyuCo3YZfdOdsYLlnoVCQpE0OniFQUYaF6BW2mKfxQteqHENN2/292YBRlLnUp1d
         Q3j6+o9xPhHFBoE4SpoiY3W3wGMsL2/CjqH47uu3ZTnz+mpQe6lSY/XtKu3N8BMEpkBS
         8AFA==
X-Gm-Message-State: AOAM530ef403DQBZbmg6DHuq1IywR1r3hxCUMH3IJoDbvdJ4bEfnkYiC
        73TH2jfecOoao6A/ZSzDvFWl+M9cteCKA9rFjwk=
X-Google-Smtp-Source: ABdhPJx8d5EFqp2lAyy2TUrXmQRHicbFMyRqCXBdAe0pVVxPjCgD5t3ysNgWrOAOM9SAT5j5alkAFe31tkx5LDwRsLg=
X-Received: by 2002:a05:6830:30a2:: with SMTP id g2mr4684399ots.206.1628256216819;
 Fri, 06 Aug 2021 06:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <1628210784-136676-1-git-send-email-aubrey.li@intel.com>
In-Reply-To: <1628210784-136676-1-git-send-email-aubrey.li@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Aug 2021 15:23:25 +0200
Message-ID: <CAJZ5v0hYVMnQFBkQ_yhF83q-CEJuQ7-TN_Hh2P6b2bM9K--xFQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PRM: Deal with table not present or no module found
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 6, 2021 at 2:48 AM Aubrey Li <aubrey.li@intel.com> wrote:
>
> On the system PRMT table is not present, dmesg output:
>
>         $ dmesg | grep PRM
>         [    1.532237] ACPI: PRMT not present
>         [    1.532237] PRM: found 4294967277 modules
>
> The result of acpi_table_parse_entries need to be checked and return
> immediately if PRMT table is not present or no PRM module found.
>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  drivers/acpi/prmt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 31cf9ae..1f6007a 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -292,6 +292,12 @@ void __init init_prmt(void)
>         int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>                                           sizeof (struct acpi_table_prmt_header),
>                                           0, acpi_parse_prmt, 0);
> +       /*
> +        * Return immediately if PRMT table is not present or no PRM module found.
> +        */
> +       if (mc <= 0)
> +               return;
> +
>         pr_info("PRM: found %u modules\n", mc);
>
>         status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
> --

Applied as 5.14-rc material, thanks!

However, since I'm on vacation next week, it will get into linux-next
after -rc6.
