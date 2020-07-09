Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9716E219FDF
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 14:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGIMS0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 08:18:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43278 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgGIMS0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 08:18:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id x83so1671643oif.10;
        Thu, 09 Jul 2020 05:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHVNxL+/4Dut3OSZTR+rYs7XqFLN3i0nnfmN8u7+xOA=;
        b=HsPvqGX/GQ4OR4PD8qcCtxVGfclDRun1lAmESdkuU5btq7AutoGcvN2+yohnLpnadd
         tO60+9ABX4LJe7VCGmwf3pMI0Wt1N8tamr/dvrWsGebqc3FP3mb9sonTbgnWOl2SQJlL
         XrMcCPoWHbBo1ReQEkC5cDiVhkDhg/amdZE7fFBqo6gU3bkQKQ/Af52flG6sJY2c8EI7
         d8f/IOU/hs3D5OqeNUDtC5WOWMs620lKXhe0IQgsWQZWUMi/uGVUYieMxucFV7xyzYcs
         EzH+gn1USAQ2/QGft1FL1b4AIs4vs8pz6/nhGibMmQkjTqmyS7KOxkq3mjRBGnsYvNiJ
         HYeQ==
X-Gm-Message-State: AOAM532wTK2f2HpwOkCilCgt7dQ/Nsva5wPIK2qVvOttSL6JD3fYtrE9
        5NR/R1T7hZM+PT3ikdyQUQB0WiT8/B8serd8Okc=
X-Google-Smtp-Source: ABdhPJxtj1vjB44EgNVrKbINxMf3MLBQQVOimbtqX57PoimFmHD9A3C9Fv4wq87LSAfsDKch7XlhTuenX5e7j0W2xjI=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr11420648oia.103.1594297104569;
 Thu, 09 Jul 2020 05:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com> <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1594005196-16327-2-git-send-email-neal.liu@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 14:18:13 +0200
Message-ID: <CAJZ5v0ihB5AJwSRpjaOnXAmciregzxARL5xfudu1h+=_LXaE_w@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: change enter_s2idle() prototype
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
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 6, 2020 at 5:13 AM Neal Liu <neal.liu@mediatek.com> wrote:
>
> Control Flow Integrity(CFI) is a security mechanism that disallows
> changes to the original control flow graph of a compiled binary,
> making it significantly harder to perform such attacks.
>
> init_state_node() assign same function callback to different
> function pointer declarations.
>
> static int init_state_node(struct cpuidle_state *idle_state,
>                            const struct of_device_id *matches,
>                            struct device_node *state_node) { ...
>         idle_state->enter = match_id->data; ...
>         idle_state->enter_s2idle = match_id->data; }
>
> Function declarations:
>
> struct cpuidle_state { ...
>         int (*enter) (struct cpuidle_device *dev,
>                       struct cpuidle_driver *drv,
>                       int index);
>
>         void (*enter_s2idle) (struct cpuidle_device *dev,
>                               struct cpuidle_driver *drv,
>                               int index); };
>
> In this case, either enter() or enter_s2idle() would cause CFI check
> failed since they use same callee.

Can you please explain this in a bit more detail?

As it stands, I don't understand the problem statement enough to apply
the patch.

> Align function prototype of enter() since it needs return value for
> some use cases. The return value of enter_s2idle() is no
> need currently.

So last time I requested you to document why ->enter_s2idle needs to
return an int in the code, which has not been done.  Please do that.

> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>  drivers/acpi/processor_idle.c   |    6 ++++--
>  drivers/cpuidle/cpuidle-tegra.c |    8 +++++---
>  drivers/idle/intel_idle.c       |    6 ++++--
>  include/linux/cpuidle.h         |    6 +++---
>  4 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 75534c5..6ffb6c9 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -655,8 +655,8 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
>         return index;
>  }
>
> -static void acpi_idle_enter_s2idle(struct cpuidle_device *dev,
> -                                  struct cpuidle_driver *drv, int index)
> +static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
> +                                 struct cpuidle_driver *drv, int index)
>  {
>         struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>
> @@ -674,6 +674,8 @@ static void acpi_idle_enter_s2idle(struct cpuidle_device *dev,
>                 }
>         }
>         acpi_idle_do_entry(cx);
> +
> +       return 0;
>  }
>
>  static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index 1500458..a12fb14 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -253,11 +253,13 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>         return err ? -1 : index;
>  }
>
> -static void tegra114_enter_s2idle(struct cpuidle_device *dev,
> -                                 struct cpuidle_driver *drv,
> -                                 int index)
> +static int tegra114_enter_s2idle(struct cpuidle_device *dev,
> +                                struct cpuidle_driver *drv,
> +                                int index)
>  {
>         tegra_cpuidle_enter(dev, drv, index);
> +
> +       return 0;
>  }
>
>  /*
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index f449584..b178da3 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -175,13 +175,15 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>   * Invoked as a suspend-to-idle callback routine with frozen user space, frozen
>   * scheduler tick and suspended scheduler clock on the target CPU.
>   */
> -static __cpuidle void intel_idle_s2idle(struct cpuidle_device *dev,
> -                                       struct cpuidle_driver *drv, int index)
> +static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
> +                                      struct cpuidle_driver *drv, int index)
>  {
>         unsigned long eax = flg2MWAIT(drv->states[index].flags);
>         unsigned long ecx = 1; /* break on interrupt flag */
>
>         mwait_idle_with_hints(eax, ecx);
> +
> +       return 0;
>  }
>
>  /*
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index ec2ef63..bee10c0 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -66,9 +66,9 @@ struct cpuidle_state {
>          * suspended, so it must not re-enable interrupts at any point (even
>          * temporarily) or attempt to change states of clock event devices.
>          */
> -       void (*enter_s2idle) (struct cpuidle_device *dev,
> -                             struct cpuidle_driver *drv,
> -                             int index);
> +       int (*enter_s2idle)(struct cpuidle_device *dev,
> +                           struct cpuidle_driver *drv,
> +                           int index);
>  };
>
>  /* Idle State Flags */
> --
> 1.7.9.5
