Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD2437969
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhJVO63 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 10:58:29 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:34734 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhJVO62 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2021 10:58:28 -0400
Received: by mail-oi1-f170.google.com with SMTP id v77so5356346oie.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Oct 2021 07:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSOo89jx1nB+VhEuw9D+wcsjp9IWuFg+NUsJ/MXsd4U=;
        b=d/AvIVuNFtKqybKUmGQ0iSqD3J3EWplihUr5G1+WD7Rm/epT5uwZeY7Yc6CAkI1eTf
         ddZ/39XCQevi3mtQAjx3WijTAe4S0TAxxF0X7kXYe9UvmQtMYyOvID3/v/ZGn5CgsVhy
         wtaNkeSMATTOTOQTOBLuJDI3N4zd8dChicUkktsFKAvy2FKGMjsqY1OhCYi7+sUI60s5
         /+xszGbrHYrM55hgDZ+f9l9vQ1Kml0D77JRbSr01U+LRoh7ce1GcVfExbfPZlTlwUbre
         /q2Mfv5rfgr11x307AdOT8zRyHmOR3G5042yXwzgLF+UkMJhgX2YRyh0UQllm9Hyzo0r
         UH/Q==
X-Gm-Message-State: AOAM533R9RVL75ort5Y3g0z157BkNZ5Y/zJ5X/DmmoR52IFaKaTgTHsl
        5XCb+GpXXBBCk5yvFEc9kbgqQ7nnxYQFKyBN+8AVO+Uvc8s=
X-Google-Smtp-Source: ABdhPJyhnTVCnmklOJDDNMXkchSf0PRGC3zDD8QdZ5QDbjURc9vcO6Dq2Ebl0hGZT9jNw5lgT9UMcfK+kkCT4jrO+wU=
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr120101oil.166.1634914570656;
 Fri, 22 Oct 2021 07:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211022011833.24308-1-james.liu@hpe.com>
In-Reply-To: <20211022011833.24308-1-james.liu@hpe.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Oct 2021 16:55:59 +0200
Message-ID: <CAJZ5v0iaiZTCSqLgC8X03118m4WL2AGvQiGh+bo2KMho9MZZXA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: OSL: Handle the return value of acpi_os_map_generic_address()
 for a non-register GAS
To:     james.liu@hpe.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 3:18 AM <james.liu@hpe.com> wrote:
>
> From: James Liu <james.liu@hpe.com>
>
> Modify acpi_os_map_generic_address() to correctly handle a non-register
> GAS (i.e., a pointer to a data structure), whose bit width is expected
> to be 0 according to Table 5.1 in ACPI spec. 6.4.
>
> For example, the RegisterRegion field in SET_ERROR_TYPE_WITH_ADDRESS is a
> non-register GAS, which points to a data structure whose format is defined
> in Table 18.30 in ACPI Spec. 6.4.

IIUC, the RegisterRegion field is defined in Section 18.6.2 that says
"This structure describes the physical address of a register as well
as the bit range that corresponds to a desired region of the
register".  This doesn't appear to be a non-register GAS to me.

> This fix can prevent EINJ (Error Injection module) from loading failure
> when a platform firmware can correctly support the format of Injection
> Instruction Entry in an EINJ table.
>
> Signed-off-by: James Liu <james.liu@hpe.com>
> ---
>  drivers/acpi/osl.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 45c5c0e45e33..74de9341fadf 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -456,13 +456,23 @@ void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
>
>         if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 return NULL;
> +       /* Handle a non-register GAS (i.e., a pointer to a data structure),

Check CodingStyle for the expected format of comments.

> +        * whose bit width is expected to be 0 according to ACPI spec. 6.4.
> +        * For example, The RegisterRegion field in SET_ERROR_TYPE_WITH_ADDRESS
> +        * points to a data structure whose format is defined in Table 18.30 in
> +        * ACPI Spec. 6.4
> +        */
> +       if (!gas->bit_width) {
> +               pr_info("Mapping IOMEM for a non-register GAS.\n");
> +               return  acpi_os_map_iomem(addr, sizeof(unsigned long long));

It is not clear to me at all why sizeof(unsigned long long) is the
right size to use here.

IIUC, there is a data structure located at addr that needs to be
accessed, but what if it is larger than the above size?

> +       }
>
>         /* Handle possible alignment issues */
>         memcpy(&addr, &gas->address, sizeof(addr));
> -       if (!addr || !gas->bit_width)
> +       if (!addr)
>                 return NULL;
> -
> -       return acpi_os_map_iomem(addr, gas->bit_width / 8);
> +       else
> +               return acpi_os_map_iomem(addr, gas->bit_width / 8);
>  }
>  EXPORT_SYMBOL(acpi_os_map_generic_address);
>
> --
