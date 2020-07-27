Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7F22EBBF
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgG0MKL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 08:10:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36411 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgG0MKK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 08:10:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id s144so4183976oie.3;
        Mon, 27 Jul 2020 05:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MY8NFYemyusLitbLbaMoVSrE9YgFZMePGaF7pe3X/ig=;
        b=faVciNUS/lZe/q44gVqtjyTGYoXpiyBzS48vs5p6TVGDaSPzoIUiEvbfe/uWJw+tM/
         T5inF/dVm4YyICu9IafwEAK0LGPqmZItdeC42GaTYm+PFJwd75SW++3r4SfZ6VSu2Aco
         Mo6r8eXrv67p6caTop1vFJcqWv5/hclJmeYQ8iDCO4tmxtUPn90eyh/xcYKjc29flVzE
         Ph5THp3A/edojAYaqr6WfOku2qKMLSVfonTDcwFJTTjXZVGhE2PU0rj7vgyd/5ZQ51KN
         MvotOfveZwGDtq4kh11gg+Tun3e0NS0CVzOr3KivTIZUmeShlrqskkO1rLTfsbL6J67P
         QWmQ==
X-Gm-Message-State: AOAM533Z/H+EzQeAMhfHd1MgW5gb1IU89b6En6YbS8QplWERnRxQuAgs
        YiZW2MC/9LyYk6KiedmcVgXnf+2FBOupWBujPDs=
X-Google-Smtp-Source: ABdhPJx+eJ2XZmKmc1yyOWlaMremLljLAQsKfx87QRnMm2/D3J76CmRbkiallwCViQ1xjwchuuWJJxzfrCmDO0Cn0+U=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr18642621oia.103.1595851808250;
 Mon, 27 Jul 2020 05:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <1595820346-4361-1-git-send-email-neal.liu@mediatek.com> <1595820346-4361-2-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1595820346-4361-2-git-send-email-neal.liu@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 14:09:39 +0200
Message-ID: <CAJZ5v0ij3KxSyB_06+p0aYcy2pMex8HCmHD5R2B8V90UnynrWQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: change enter_s2idle() prototype
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

On Mon, Jul 27, 2020 at 5:25 AM Neal Liu <neal.liu@mediatek.com> wrote:
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
>
> Align function prototype of enter() since it needs return value for
> some use cases. The return value of enter_s2idle() is no
> need currently.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  drivers/acpi/processor_idle.c   |    6 ++++--
>  drivers/cpuidle/cpuidle-tegra.c |    8 +++++---
>  drivers/idle/intel_idle.c       |    6 ++++--
>  include/linux/cpuidle.h         |    9 ++++++---
>  4 files changed, 19 insertions(+), 10 deletions(-)
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
> index ec2ef63..b65909a 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -65,10 +65,13 @@ struct cpuidle_state {
>          * CPUs execute ->enter_s2idle with the local tick or entire timekeeping
>          * suspended, so it must not re-enable interrupts at any point (even
>          * temporarily) or attempt to change states of clock event devices.
> +        *
> +        * This callback may point to the same function as ->enter if all of
> +        * the above requirements are met by it.
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

Applied as 5.9 material, thanks!
