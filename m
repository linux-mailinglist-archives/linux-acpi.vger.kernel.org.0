Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C49234497
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbgGaLdi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 07:33:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40075 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLdi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2020 07:33:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id u24so16553690oiv.7;
        Fri, 31 Jul 2020 04:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpZwL9ptFKxq7FoZCH1xjumTWQNcssejfeTwP6RoxpQ=;
        b=diuHMLwFGE03iB6FycWL3gzVKV7vJzuDP40K9hGRPOQcLzQIi9LpAbE+bb+iu1Zva7
         b7hj6RtcnDvzlg7h3eYbSZvJLmYlNeNiRCKL900jpKHwv5KXYbY7L3g/VaYc1GjEyoJz
         EE8UibbNHAQ2xvP8l3MH4L5l0FT4XlCfQzCJza6pD2tBjS5oTSksRX8gkBKX5BTHbyAj
         SNrwrRNcYA3QhnfE9ylEFohlC84WnJz2erwTT4CWf6vKCMDutiNwj6fk+z3+F0SBtbNO
         EugJdjKvoeNHJYWBqakqrimVl0NheHFYPhWy6JR2X2uYm3YS8xkhOyZaGfRIrMZeD5Ah
         eHbA==
X-Gm-Message-State: AOAM530dUNDrNfQUhFqddHrZ4wxeJDT4smiaX9qYbSJjy0kPyRTht2Sh
        oStEZMDE27hETN8WPbTTQSjTqHdUHemGtOqXmik=
X-Google-Smtp-Source: ABdhPJwjnTZ4vCcK+PJMw9f0cgXjEhaXp88nRbYUPJxc2xho6yL2W9vIsfi0PJ+loYFbKG0KfjHoOo6H/h7XzI4Nqoc=
X-Received: by 2002:aca:a88e:: with SMTP id r136mr2704600oie.110.1596195217368;
 Fri, 31 Jul 2020 04:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <1596166744-2954-1-git-send-email-neal.liu@mediatek.com> <1596166744-2954-2-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1596166744-2954-2-git-send-email-neal.liu@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jul 2020 13:33:24 +0200
Message-ID: <CAJZ5v0gk9a-PVr4+zerNWdBORyC563K8XgUdgxENAQ+Y5-85tg@mail.gmail.com>
Subject: Re: [PATCH] acpi: fix 'return' with no value build warning
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 31, 2020 at 5:39 AM Neal Liu <neal.liu@mediatek.com> wrote:
>
> Fixing CFI issue which introduced by commit efe9711214e6 is
> incomplete.
> Add return value to fix return-type build warning.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>

Applied with edited subject and changelog, but ->

> ---
>  drivers/acpi/processor_idle.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 6ffb6c9..6870020 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -664,11 +664,11 @@ static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>                 struct acpi_processor *pr = __this_cpu_read(processors);
>
>                 if (unlikely(!pr))
> -                       return;
> +                       return -EFAULT;

-> there is no point returning an error code here, so I've made it
just return 0.

>
>                 if (pr->flags.bm_check) {
>                         acpi_idle_enter_bm(pr, cx, false);
> -                       return;
> +                       return 0;
>                 } else {
>                         ACPI_FLUSH_CPU_CACHE();
>                 }
> --
