Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A8446566
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhKEPFR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 11:05:17 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33503 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhKEPFR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 11:05:17 -0400
Received: by mail-oi1-f169.google.com with SMTP id bl27so12075248oib.0;
        Fri, 05 Nov 2021 08:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vX8f2vS+zMIuTQAbDXugdUdsKE/s6J0wYaU1pfRJZTA=;
        b=vo0Whb2Ddah0QED+fI/Veeg9aieXC26B5VGhl1TGxG1KpxVXJIMxZwEbJjsFekboSt
         35vMb9h5sMArqFGgFLctxWlOQNSed/obcg4jDjfDEaF4iGUc6RCzNBAW9AkxJlY759zg
         eEa0k5WFE2ytG4M9vSZYY1IdouNMg2F0uSqLGKSVLYABxqg1TeQ+qg+OuCi4lTXv3pAk
         tKm+Ho3Gdqkj4hMvgc2p40sq6CasKe9cz+aD127MhOovXN0RSKGOSCM15znomzLgoibk
         KuB9yzLKIjZp7kWgxjGFjqE8xPK0B7Y5joEryRTvs2vtkwlxhaGnj/paRu2pk4Zqn+6s
         8YtA==
X-Gm-Message-State: AOAM530ierKqZvwQYUQ3tHik13xp+Hxrt6VaAJechCn04pg+jhNJyEgd
        xjzGwdzux/fYABSsITQx37bNjrAiUUpqtQzWwR8=
X-Google-Smtp-Source: ABdhPJzZPXVrhnJ4VEWfPpiFT1J/OH74jFYU7MUBQgbFjtakZukbwVdozEMRwT4eEbgU6rlsIDrdGPvBNzPSWPxkBsM=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr22276883oif.154.1636124557321;
 Fri, 05 Nov 2021 08:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com> <20211029063228.578909-3-AjitKumar.Pandey@amd.com>
In-Reply-To: <20211029063228.578909-3-AjitKumar.Pandey@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 16:02:26 +0100
Message-ID: <CAJZ5v0jXnwC-C8mAWtQDtoPko9ALAYhpm3X-TZ5L83ROEUJWmA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 2/5] drivers: acpi: acpi_apd: Remove unused
 device property "is-rv"
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, Vijendar.Mukunda@amd.com,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 29, 2021 at 8:33 AM Ajit Kumar Pandey
<AjitKumar.Pandey@amd.com> wrote:
>
> Initially "is-rv" device property is added for 48MHz fixed clock
> support on Raven or RV architecture. It's unused now as we moved
> to clock config based selection to extend such support on others
> architecture. This change removed unused code from acpi driver.
>
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>

Is this and the [3/5] applicable without the [1/5]?

If so, I can pick them up once they are approved by some other AMD
folks, preferably Mario.

> ---
>  drivers/acpi/acpi_apd.c               | 3 ---
>  include/linux/platform_data/clk-fch.h | 1 -
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 6e02448d15d9..6913e9712852 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -87,9 +87,6 @@ static int fch_misc_setup(struct apd_private_data *pdata)
>         if (ret < 0)
>                 return -ENOENT;
>
> -       if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
> -               clk_data->is_rv = obj->integer.value;
> -
>         list_for_each_entry(rentry, &resource_list, node) {
>                 clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
>                                               resource_size(rentry->res));
> diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
> index b9f682459f08..850ca776156d 100644
> --- a/include/linux/platform_data/clk-fch.h
> +++ b/include/linux/platform_data/clk-fch.h
> @@ -12,7 +12,6 @@
>
>  struct fch_clk_data {
>         void __iomem *base;
> -       u32 is_rv;
>  };
>
>  #endif /* __CLK_FCH_H */
> --
> 2.25.1
>
