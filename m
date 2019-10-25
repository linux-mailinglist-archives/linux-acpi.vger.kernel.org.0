Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7859E469F
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 11:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438255AbfJYJGh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 05:06:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34821 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438235AbfJYJGh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 05:06:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so1545271otb.2;
        Fri, 25 Oct 2019 02:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDgT5MmYqtTT0sYWHOCRWb0XKj7gKyLkavkUIES1WE8=;
        b=nwXvrqTQDHY1honcVzpS4v0BmdFulLdPOAjxQZyZIwk5QDt6cTXbF5Kb6YGgVgLsMg
         c76Pi8uj4z3KVG1/jXz6KT9bBOvlHixfJlIIRBqOwclxU3NZ4rTpTMGrJqWc249Eh4Cj
         FkSDWR771PmL+AxRQDwlfUcAQ9fA2VprBctlfAnJNXxySJWrS7fgHMb+1ZqF2XS17YQB
         zWgZWb42MsbMfqVITNi3LmpGCHJruwLJZLlmsWUYGZAWV2jhOM6T+SHQ/B5qg8Knfypo
         yN1R1SkqtOdjEtgjzlqRzJcB2AS2/pFX3ISiWuTegzKb//flqvTE5GCNjv+9HxcCU8aS
         G0+g==
X-Gm-Message-State: APjAAAWwMdVjI+UKhzdVNYNVpHw/WsQkJMEAT+YTSgsduriRXY8+WEtA
        bYIwfQwKMg6FuyGV//OGRyNaMF5pPY3PIcxlNuY=
X-Google-Smtp-Source: APXvYqwX4liB39Q3E0FtAZ2ZvfRmJDoANpbEdIrYBRx0GaFjcnCXPUXl+a0SqZPYBkiY6leZHWOKUDrT1/cbKHPRSfI=
X-Received: by 2002:a9d:664:: with SMTP id 91mr1813498otn.189.1571994396308;
 Fri, 25 Oct 2019 02:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191024070420.4512-1-fengwei.yin@intel.com>
In-Reply-To: <20191024070420.4512-1-fengwei.yin@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Oct 2019 11:06:25 +0200
Message-ID: <CAJZ5v0hU9z3BfAK5x1i4Qw334Wf8o5azaKL9kyAJoADcau3hxA@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI/processor_idle: Remove dummy wait if kernel is in guest
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2019 at 9:04 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>
> In function acpi_idle_do_entry(), an ioport access is used for
> dummy wait to guarantee hardware behavior. But it could trigger
> unnecessary VMexit if kernel is running as guest in virtualization
> environment.
>
> If it's in virtualization environment, the deeper C state enter
> operation (inb()) will trap to hypervisor. It's not needed to do
> dummy wait after the inb() call. So we could just remove the
> dummy io port access to avoid unnecessary VMexit.
>
> And keep dummy io port access to maintain timing for native
> environment.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
> ChangeLog:
> v3 -> v4:
>  - Drop overengineered function pointer and do check whether
>    we are in guest before dummy inl call.
>
> v2 -> v3:
>  - Remove dummy io port access totally for virtualization env.
>
> v1 -> v2:
>  - Use ndelay instead of dead loop for dummy delay.
>
>  drivers/acpi/processor_idle.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index ed56c6d20b08..2ae95df2e74f 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -642,6 +642,19 @@ static int acpi_idle_bm_check(void)
>         return bm_status;
>  }
>
> +static void wait_for_freeze(void)
> +{
> +#ifdef CONFIG_X86
> +       /* No delay is needed if we are in guest */
> +       if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +               return;
> +#endif
> +       /* Dummy wait op - must do something useless after P_LVL2 read
> +          because chipsets cannot guarantee that STPCLK# signal
> +          gets asserted in time to freeze execution properly. */
> +       inl(acpi_gbl_FADT.xpm_timer_block.address);
> +}
> +
>  /**
>   * acpi_idle_do_entry - enter idle state using the appropriate method
>   * @cx: cstate data
> @@ -658,10 +671,7 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
>         } else {
>                 /* IO port based C-state */
>                 inb(cx->address);
> -               /* Dummy wait op - must do something useless after P_LVL2 read
> -                  because chipsets cannot guarantee that STPCLK# signal
> -                  gets asserted in time to freeze execution properly. */
> -               inl(acpi_gbl_FADT.xpm_timer_block.address);
> +               wait_for_freeze();
>         }
>  }
>
> @@ -682,8 +692,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>                         safe_halt();
>                 else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
>                         inb(cx->address);
> -                       /* See comment in acpi_idle_do_entry() */
> -                       inl(acpi_gbl_FADT.xpm_timer_block.address);
> +                       wait_for_freeze();
>                 } else
>                         return -ENODEV;
>         }
> --

Applying as 5.5 material, thanks!
