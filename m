Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42E934F1D0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhC3TvC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 15:51:02 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39889 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhC3Tuy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2021 15:50:54 -0400
Received: by mail-oi1-f173.google.com with SMTP id i81so17646434oif.6;
        Tue, 30 Mar 2021 12:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OsQBiPW2+qSyK7XtpnyjKRwJp3ErW6pxOJ2xNA96P8=;
        b=OgjRiKYIbVWoarqHF2+PrlCwSgYXK6qDBmAHc9Ee2Q/zuAZ5GC0qLxS2MeAzla8JwO
         K1Z1JmOxTpfBAGuZwuq00rzzTnjKvjZWcJGwXS1pdFlaYTKV9pH8gp8yn+x5owQMUlxA
         Z6S2jXqwf0RKGC+HcUxe7w8/xdXn0W4GpuIgIft8IF614OwoCMpw1AVIQ1bIU8G45tSf
         IP6stNA94dp3tlwmUGemPF1mie6DzAY9BZe/ngZIRDbsxn1tLl5ZwGBHrddzqH0jY27J
         65CaFxBPGaSquzJmWxRsqoQ5h71U1r7Gf+idw96DoN17pHO92Uj+pJfh2Pb2WfpY/W4P
         h2gg==
X-Gm-Message-State: AOAM532XT1zEnQuHGLmyxSPYXms6e5XE9tbehMMLwW30CaqCsjCjih2C
        v22nzOVygnRnmv7YBTofmutrDHUSSdLqFOBvOoHFETLU
X-Google-Smtp-Source: ABdhPJw2TUG7q5gjj1ldr/4lTAxw9SuGzOzc4JneZySDSRG3r14SpL98P/g+CzqaNgcIOS/DQ+tSEio6pMgSdALic5w=
X-Received: by 2002:aca:c4c5:: with SMTP id u188mr4480930oif.71.1617133853481;
 Tue, 30 Mar 2021 12:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210330102630.264398-1-vkuznets@redhat.com>
In-Reply-To: <20210330102630.264398-1-vkuznets@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Mar 2021 21:50:42 +0200
Message-ID: <CAJZ5v0hg3smHRVQNDDQmq94Ss-WH1xkeYaVZ62JPAUadMZuzFw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Fix build when !CONFIG_HOTPLUG_CPU
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 30, 2021 at 12:27 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Kernel test robot reports build breakage with commit 5f5e49e999ac
> ("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()") when
> !CONFIG_HOTPLUG_CPU/!CONFIG_SMP. wakeup_cpu0() is defined under
> CONFIG_SMP and start_cpu0() under CONFIG_HOTPLUG_CPU which, in its turn,
> depend on CONFIG_SMP. Add #ifdef CONFIG_HOTPLUG_CPU to the block, this
> should be sufficient.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 5f5e49e999ac ("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()")

Folded into the above patch, thanks!

> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/acpi/processor_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f0c73f658880..0925b1477230 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -539,7 +539,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>                 } else
>                         return -ENODEV;
>
> -#ifdef CONFIG_X86
> +#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
>                 /* If NMI wants to wake up CPU0, start CPU0. */
>                 if (wakeup_cpu0())
>                         start_cpu0();
> --
> 2.30.2
>
