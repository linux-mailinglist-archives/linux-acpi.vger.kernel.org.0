Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8908A2E7BD5
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgL3SJx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 13:09:53 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34842 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgL3SJx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2020 13:09:53 -0500
Received: by mail-ot1-f42.google.com with SMTP id i6so16079116otr.2;
        Wed, 30 Dec 2020 10:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6wty7uTHzWolWGlLlhLEhZtRaBVxKw4I5dryMThCo0=;
        b=age6wQjF4LuFkyGGXwS0lJEfMB/5b1W81N+bmn60AxnVTNj0Ozyg8e8JHsxrukroqY
         IIV8YOH0y3l8fqdy+kRkWSODu53l8xO/PMlVoQveH4aA/D+CMA3Z2a5aCE+ZggE6Z2hr
         BJU1A9S7Slg4Iu0gH6DJCL8caiqS0qhjPM4fOdPQ1/VXARbYzyYdFfjwLvv4+VYc0Xtg
         fHt2YovPxk8GxW5DqCDfe+pforNhJAWejStyApUBtBrPE2lkvWPENOYp/PVXpHRqnLjW
         3p7CCKYJzZyKvd0Ddcq45avbpBhYDoV8HVKSP+qxBfMLjQYr8Bxq+T3OV/idKxLgz/zp
         zNZA==
X-Gm-Message-State: AOAM533+6HXxSMQKtoinsOCFNuvuwLfMdr0uqmUYcB7T2O6/eS3Gxhna
        vY2XXZ/1RJ8fpSFmv5ffxjS8F6GYJjYB2qp8LYM=
X-Google-Smtp-Source: ABdhPJzXfCjmB1dcSwHsD8IGGfgs1uWGweBPT2mhXlrlobIpnP9CP9YPZ9u9FKtKrYhWlHYY/E6W99gr0mvooWKpwO4=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr40507083otn.321.1609351752581;
 Wed, 30 Dec 2020 10:09:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
 <20201230153744.15612-1-daniel.lezcano@linaro.org>
In-Reply-To: <20201230153744.15612-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Dec 2020 19:09:00 +0100
Message-ID: <CAJZ5v0g7DdGFcvn1bMy5=HmRP5+uA0OcrPVMDnJ4aW+VxVvTpA@mail.gmail.com>
Subject: Re: [PATCH] powercap/drivers/dtpm: Fix __udivdi3 and __aeabi_uldivmod
 unresolved symbols
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 30, 2020 at 4:38 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> 32 bits architectures do not support u64 division, so the macro
> DIV_ROUND_CLOSEST is not adequate as the compiler will replace the
> call to an unexisting function for the platform, leading to an
> unresolved symbols.
>
> Fix this by using the compatible macros:
>
> DIV64_U64_ROUND_CLOSEST and DIV_ROUND_CLOSEST_ULL.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied and pushed into the linux-next branch, thanks!

> ---
>  drivers/powercap/dtpm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 5b6857e9b064..0abcc439d728 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -99,8 +99,8 @@ static void __dtpm_rebalance_weight(struct dtpm *dtpm)
>                 pr_debug("Setting weight '%d' for '%s'\n",
>                          child->weight, child->zone.name);
>
> -               child->weight = DIV_ROUND_CLOSEST(child->power_max * 1024,
> -                                                 dtpm->power_max);
> +               child->weight = DIV64_U64_ROUND_CLOSEST(
> +                       child->power_max * 1024, dtpm->power_max);
>
>                 __dtpm_rebalance_weight(child);
>         }
> @@ -272,7 +272,7 @@ static int __set_power_limit_uw(struct dtpm *dtpm, int cid, u64 power_limit)
>                         } else if (power_limit == dtpm->power_min) {
>                                 power = child->power_min;
>                         } else {
> -                               power = DIV_ROUND_CLOSEST(
> +                               power = DIV_ROUND_CLOSEST_ULL(
>                                         power_limit * child->weight, 1024);
>                         }
>
> --
> 2.17.1
>
