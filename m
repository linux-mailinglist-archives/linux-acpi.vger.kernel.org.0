Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370B42ADD77
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKJRy1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 12:54:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJRy0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 12:54:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id l36so13405638ota.4;
        Tue, 10 Nov 2020 09:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuhBKn9T70emUXp0lWIimSs1Bb3f7nN4finvqgFApgI=;
        b=qz+GSuIXvyqls2Q6QfQhjShFM9rYeWspcj/jp+6/4HsoYpPQ7jtQhCsiwQXQfjWK8I
         W4eqCaFTbHOB+cvAXKCw+qVdkoeWA6k+zWrMXbmt2dAVNX1TW7cRk0gu7NOMbANsO/ur
         s15zcozXL4vrY+LkuW0LZBh67LyEOjQHyFGeMyWfIMql1VDSzTD0c/rbTW6owudu05A7
         plNrNoTm6IMOuc8XsBfozrBnJSclJ/xLWS1SYSpfjnAn15AplBHNcOZ8R2lmD4Q9CePL
         0/bry+Ne660X0xSP+6VEqwLQ6X9VkrRNZfWZ4ERti68exMbcuuLs/Ycxl5PLVqznwBmf
         rxcw==
X-Gm-Message-State: AOAM532dqmHxARXZl2v7SjNZLCwvtV3rzQDRXNsNOP+z4EpCMPp3K9oo
        iCcUqd6aWBBGd/eTQJ8qki1b1bKZPBlWKGHdtjI=
X-Google-Smtp-Source: ABdhPJwlU4Si33JnBCbivOsXaCPRdYN8rmY2Jb54Dlvtpw9A+Q3/+AoTfojEGvnYhSMKePSjbVNkWRSvxM9QROSDB0I=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr15780131otu.206.1605030865528;
 Tue, 10 Nov 2020 09:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20201110175058.88137-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20201110175058.88137-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 18:54:14 +0100
Message-ID: <CAJZ5v0ieN3TowOwM1KAmkZu9bd_NEiZDFx2ptf2_KXj0gswwxw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Support Alder Lake
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 6:51 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add Alder Lake ACPI IDs for DPTF devices.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/dptf/dptf_pch_fivr.c   | 1 +
>  drivers/acpi/dptf/dptf_power.c      | 2 ++
>  drivers/acpi/dptf/int340x_thermal.c | 6 ++++++
>  drivers/acpi/fan.c                  | 1 +
>  4 files changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
> index 4c1992fce150..5fca18296bf6 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -106,6 +106,7 @@ static int pch_fivr_remove(struct platform_device *pdev)
>
>  static const struct acpi_device_id pch_fivr_device_ids[] = {
>         {"INTC1045", 0},
> +       {"INTC1049", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
> index 06741305fc77..a24d5d7aa117 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -229,6 +229,8 @@ static const struct acpi_device_id int3407_device_ids[] = {
>         {"INT3532", 0},
>         {"INTC1047", 0},
>         {"INTC1050", 0},
> +       {"INTC1060", 0},
> +       {"INTC1061", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
> index 8d420c7e7178..d14025a85ce8 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -25,10 +25,16 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
>         {"INT340A"},
>         {"INT340B"},
>         {"INTC1040"},
> +       {"INTC1041"},
>         {"INTC1043"},
>         {"INTC1044"},
>         {"INTC1045"},
> +       {"INTC1046"},
>         {"INTC1047"},
> +       {"INTC1048"},
> +       {"INTC1049"},
> +       {"INTC1060"},
> +       {"INTC1061"},
>         {""},
>  };
>
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 62873388b24f..48354f82fba6 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -27,6 +27,7 @@ static const struct acpi_device_id fan_device_ids[] = {
>         {"PNP0C0B", 0},
>         {"INT3404", 0},
>         {"INTC1044", 0},
> +       {"INTC1048", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, fan_device_ids);
> --

Applied as 5.10-rc material, thanks!
