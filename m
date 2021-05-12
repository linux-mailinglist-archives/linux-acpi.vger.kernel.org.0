Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32FC37BED1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELNvH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 09:51:07 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:47095 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhELNvH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 09:51:07 -0400
Received: by mail-ot1-f53.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso20542903otb.13;
        Wed, 12 May 2021 06:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mG4BDahR3iB45OP4gYv0F9gGuZ/XZy4giEMKlCWJqUA=;
        b=e+3jS8QyDx0HNeozopytk7b0bwkBaxJjrBYHYub9xVwNt9p1vlqmbqJnz5+a9YtqQm
         1V2rQBBHs957nmxZ9bxC6GxT297GmXiYvsFoUrvhBBJG12AerySnOP8JfKoXfRYM1o4k
         dKdNHonXNUBB8gv4tM3ls+a5rZytUJ3Tyi/FcoO6SmNhuybmrmVPAJUt80RYXLOb1Tv3
         bSoVsJeSwvM/upi9BAVJek+qH65k84tQjk3+uoLL7b7u5IZ+AEFNrxglv0WPpvMh4qzD
         4QNM+68z9OaQGi3CMbtuFqTnh2AtkHEjLa6G96Fy7sCGXFKYcebdI/4PWdRoJilJA0MI
         zmhw==
X-Gm-Message-State: AOAM533Wu4UqBk6hMM30+yWQOZxpuax1dBLtGHPtwsG0PomDYzzeYh0z
        6n7WcvgOBxotGYiecuvh2zksqElxTze7dXsGLx3wzThm
X-Google-Smtp-Source: ABdhPJxrwpETA5Dt0x93sE0FGhvMx5Y6zTk65fr+3+JGUuZRs8AKfe0bwxkyx4N8Ir4PVO/rD0p8SujH4bEvnhf7IaM=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr31863830otc.206.1620827397947;
 Wed, 12 May 2021 06:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210510155819.29595-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20210510155819.29595-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 May 2021 15:49:46 +0200
Message-ID: <CAJZ5v0iu4bRfi8ECi1QUvK3KResqatp6z5jYT4+PP2R0R12BHw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Add battery participant for Intel SoCs
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 6:09 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add ACPI Device ID for DPTF battery participant for the Intel
> Jasper Lake (INT3532) and Tiger Lake (INTC1050) SoC based platforms.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/dptf/int340x_thermal.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
> index d14025a85ce8..da5d5f0be2f2 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -24,6 +24,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
>         {"INT3409"},
>         {"INT340A"},
>         {"INT340B"},
> +       {"INT3532"},
>         {"INTC1040"},
>         {"INTC1041"},
>         {"INTC1043"},
> @@ -33,6 +34,7 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
>         {"INTC1047"},
>         {"INTC1048"},
>         {"INTC1049"},
> +       {"INTC1050"},
>         {"INTC1060"},
>         {"INTC1061"},
>         {""},
> --

Applied as 5.14 material, thanks!
