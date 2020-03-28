Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9A196616
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Mar 2020 13:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1M1C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Mar 2020 08:27:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39716 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgC1M1C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2020 08:27:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id x11so12745872otp.6;
        Sat, 28 Mar 2020 05:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqZqx/CZapn9pjHWc5U/GpwtVDNOyuhdLo9WIuYYHzs=;
        b=EBXslbwSVxQMvD7p0Fbv8bGNpGGWlC//DVEBxK/Hd9yXzVb2V8nvzMQHAEvUeUOFXQ
         pKbcvul8rR5aA5Uxm6uCiYiGJ3fd4FBxfiVBNIyvgBhohSrSKJePmamnJnO79p7OFnXm
         NHA+6wRQd/kqPq6EB6L70zzDk2uAKGyZn6HFmyIYyTU3TV4bYtUvvFbB+C7/FGJ5tijc
         bDGeLuSPSmMyJDOg58hQ1EAvKjKutruC03+a2S3xAxlKnd8OKZnBbF/a5PKbP62otpzy
         QkhgsiiLkwvL3g64SGOSb1Op8KTBC3E1moJ5XLEvmuETeCMH8jl+1h93cuR6G+1iCImW
         XK4g==
X-Gm-Message-State: ANhLgQ3z/SqYdmRuaccjBmk7HVkJSp5dJ9YAVCg8udsWuWbLkN7aun1T
        9mpqFf50X0+csyAWT8zHZOcwB+djWxe+5KjEkbw/oQ==
X-Google-Smtp-Source: ADFU+vsArV3PTBfft2PPvi8tTIA1oPns/rtyEPF4hkM8KSyoQ62DSh333n/cvkQBgecEbD8PmQ+F31OqWR+fY+raqQ8=
X-Received: by 2002:a05:6830:14cc:: with SMTP id t12mr2427440otq.118.1585398421290;
 Sat, 28 Mar 2020 05:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <1585232950-123704-1-git-send-email-zhangliguang@linux.alibaba.com>
In-Reply-To: <1585232950-123704-1-git-send-email-zhangliguang@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 28 Mar 2020 13:26:48 +0100
Message-ID: <CAJZ5v0iwZq-F=WAztLaLKBrU7UeWq_W5U+mTTvvpFo32y6COUA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / CPPC: clean up acpi_get_psd_map
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 26, 2020 at 3:29 PM luanshi <zhangliguang@linux.alibaba.com> wrote:
>
> This patch cleans up acpi_get_psd_map function. If got here,
> variable all_cpu_data[] can't be NULL. Variable match_cpc_ptr has been
> checked before, no need check again at the end of the funchtion. Then
> some code logic should be optimized.
>
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  drivers/acpi/cppc_acpi.c | 33 +++++++--------------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a1a858a..8b2e89c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -438,13 +438,10 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
>          * domain info.
>          */
>         for_each_possible_cpu(i) {
> -               pr = all_cpu_data[i];
> -               if (!pr)
> -                       continue;
> -
>                 if (cpumask_test_cpu(i, covered_cpus))
>                         continue;
>
> +               pr = all_cpu_data[i];
>                 cpc_ptr = per_cpu(cpc_desc_ptr, i);
>                 if (!cpc_ptr) {
>                         retval = -EFAULT;
> @@ -495,44 +492,28 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
>                         cpumask_set_cpu(j, pr->shared_cpu_map);
>                 }
>
> -               for_each_possible_cpu(j) {
> +               for_each_cpu(j, pr->shared_cpu_map) {
>                         if (i == j)
>                                 continue;
>
>                         match_pr = all_cpu_data[j];
> -                       if (!match_pr)
> -                               continue;
> -
> -                       match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
> -                       if (!match_cpc_ptr) {
> -                               retval = -EFAULT;
> -                               goto err_ret;
> -                       }
> -
> -                       match_pdomain = &(match_cpc_ptr->domain_info);
> -                       if (match_pdomain->domain != pdomain->domain)
> -                               continue;
> -
>                         match_pr->shared_type = pr->shared_type;
>                         cpumask_copy(match_pr->shared_cpu_map,
>                                      pr->shared_cpu_map);
>                 }
>         }
> +       goto out;
>
>  err_ret:
>         for_each_possible_cpu(i) {
>                 pr = all_cpu_data[i];
> -               if (!pr)
> -                       continue;
>
>                 /* Assume no coordination on any error parsing domain info */
> -               if (retval) {
> -                       cpumask_clear(pr->shared_cpu_map);
> -                       cpumask_set_cpu(i, pr->shared_cpu_map);
> -                       pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> -               }
> +               cpumask_clear(pr->shared_cpu_map);
> +               cpumask_set_cpu(i, pr->shared_cpu_map);
> +               pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
>         }
> -
> +out:
>         free_cpumask_var(covered_cpus);
>         return retval;
>  }
> --

Applied as 5.7 material with some changes in the changelog and subject, thanks!
