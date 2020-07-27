Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED822ED49
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgG0N2l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 09:28:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42216 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgG0N2l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 09:28:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id v21so5015602otj.9;
        Mon, 27 Jul 2020 06:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyBt54tE9HNpCn7MfHA5YP/4SLINbBOxbN35N0rBINs=;
        b=IlwxGG60AiP/v/DeC4spUtO0QJMQdLm3ThLkzZKqumIuJElVjEUrqTgJJiOf8ZW2lN
         JAX237kM74JxjnmG1dUwMiNvaatwCXOyxs1TErbtaoDbZ5H5zsv6JnOO1wRpvEV4jH7W
         EElVAC6SFvvIAR0h1wbjJcdsFHlQJ7Jq2TDqyyWorGc9adobzHI+uNfiiwr4hmKVUeUP
         meX0gTKBV1Fox2A4+VigYHoNkTK2pEgbr2bh5+Ew41iAnh/kg4I+FQeMq9gHPEv4nE1q
         CxftrLoS0PYNVuoKSjp2J97krQyG2SCHJi1LryP1gT9Wtu+6Mce203/acj7E93Wn7sp+
         u8GQ==
X-Gm-Message-State: AOAM530NVuCDWaNP35J2ftDoGIKArtiYKts0NF+SO1F3FcEGatQdsgKn
        6a6eibU+7QcSqjPlzIf+Ki2z+lM9GxBHCY1Ij/s=
X-Google-Smtp-Source: ABdhPJxA6L3ew5rkyAd8d0RHF2JbupA8LXHj2xjbAHpaL5OkleNr5cEb8uUy78H10Of4PCFPHoQWYZm5TV/JSsEHy1Q=
X-Received: by 2002:a9d:306:: with SMTP id 6mr10506313otv.167.1595856519954;
 Mon, 27 Jul 2020 06:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200720050500.23357-1-akshu.agrawal@amd.com> <20200720050500.23357-2-akshu.agrawal@amd.com>
In-Reply-To: <20200720050500.23357-2-akshu.agrawal@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 15:28:29 +0200
Message-ID: <CAJZ5v0j264hcr0AbwXou240K73xfQ5Q0pF4TEP11SAOT2nuOjA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: APD: Change name from ST to FCH
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 20, 2020 at 7:06 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> AMD SoC general pupose clk is present in new platforms with
> same MMIO mappings. We can reuse the same clk handler support
> for other platforms. Hence, changing name from ST(SoC) to FCH(IP)
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

This patch and the [3/4] appear to be part of a larger series which
isn't visible to me as a whole.

Do you want me to apply them nevertheless?

> ---
>  drivers/acpi/acpi_apd.c                            | 14 +++++++-------
>  .../linux/platform_data/{clk-st.h => clk-fch.h}    | 10 +++++-----
>  2 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/linux/platform_data/{clk-st.h => clk-fch.h} (53%)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index ba2612e9a0eb..2d99e46add1a 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -8,7 +8,7 @@
>   */
>
>  #include <linux/clk-provider.h>
> -#include <linux/platform_data/clk-st.h>
> +#include <linux/platform_data/clk-fch.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/clkdev.h>
> @@ -79,11 +79,11 @@ static int misc_check_res(struct acpi_resource *ares, void *data)
>         return !acpi_dev_resource_memory(ares, &res);
>  }
>
> -static int st_misc_setup(struct apd_private_data *pdata)
> +static int fch_misc_setup(struct apd_private_data *pdata)
>  {
>         struct acpi_device *adev = pdata->adev;
>         struct platform_device *clkdev;
> -       struct st_clk_data *clk_data;
> +       struct fch_clk_data *clk_data;
>         struct resource_entry *rentry;
>         struct list_head resource_list;
>         int ret;
> @@ -106,7 +106,7 @@ static int st_misc_setup(struct apd_private_data *pdata)
>
>         acpi_dev_free_resource_list(&resource_list);
>
> -       clkdev = platform_device_register_data(&adev->dev, "clk-st",
> +       clkdev = platform_device_register_data(&adev->dev, "clk-fch",
>                                                PLATFORM_DEVID_NONE, clk_data,
>                                                sizeof(*clk_data));
>         return PTR_ERR_OR_ZERO(clkdev);
> @@ -135,8 +135,8 @@ static const struct apd_device_desc cz_uart_desc = {
>         .properties = uart_properties,
>  };
>
> -static const struct apd_device_desc st_misc_desc = {
> -       .setup = st_misc_setup,
> +static const struct apd_device_desc fch_misc_desc = {
> +       .setup = fch_misc_setup,
>  };
>  #endif
>
> @@ -239,7 +239,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>         { "AMD0020", APD_ADDR(cz_uart_desc) },
>         { "AMDI0020", APD_ADDR(cz_uart_desc) },
>         { "AMD0030", },
> -       { "AMD0040", APD_ADDR(st_misc_desc)},
> +       { "AMD0040", APD_ADDR(fch_misc_desc)},
>  #endif
>  #ifdef CONFIG_ARM64
>         { "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
> diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-fch.h
> similarity index 53%
> rename from include/linux/platform_data/clk-st.h
> rename to include/linux/platform_data/clk-fch.h
> index 7cdb6a402b35..850ca776156d 100644
> --- a/include/linux/platform_data/clk-st.h
> +++ b/include/linux/platform_data/clk-fch.h
> @@ -1,17 +1,17 @@
>  /* SPDX-License-Identifier: MIT */
>  /*
> - * clock framework for AMD Stoney based clock
> + * clock framework for AMD misc clocks
>   *
>   * Copyright 2018 Advanced Micro Devices, Inc.
>   */
>
> -#ifndef __CLK_ST_H
> -#define __CLK_ST_H
> +#ifndef __CLK_FCH_H
> +#define __CLK_FCH_H
>
>  #include <linux/compiler.h>
>
> -struct st_clk_data {
> +struct fch_clk_data {
>         void __iomem *base;
>  };
>
> -#endif /* __CLK_ST_H */
> +#endif /* __CLK_FCH_H */
> --
> 2.20.1
>
