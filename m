Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD54411F6
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 02:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKACAG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 22:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhKACAF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 31 Oct 2021 22:00:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96C77610E5;
        Mon,  1 Nov 2021 01:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635731852;
        bh=fuaUan8WpsO3AU0Pd876OqdiQB5S59Rz/RFmfxHCqFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WTZ2r/aqsZBJ/SEMp/W5aRRvu0wWWG+qZmM8hZPwjrObwwMpW1TgXwf1zWnw0Qa9i
         Zv/YGYWGYxl7myNvWxfw0CIgJUc9b2/XePq2AH0H37XLuqx44GHHVjgkb3ys6UwuYH
         QFUJSlyCI2x3AldpppHi6cKlbUrpf5epTIwYkQ0LyIddZNVrNNmKUj9pq1nkh3vhav
         ePFznWLS5KXHwuBhRZexeraVkFwzXRLP/38HX/OFwy/5mrR8Hs9LdC9PbwjoOwqbNV
         ADgrJu7beLvyyJTcpsvn3lAsea5miSCymSsM2dL/H4uMyDHc1oqmdVcUWCHL7cYIF+
         w+SQ6/88DMfNA==
Received: by mail-yb1-f173.google.com with SMTP id q74so34927729ybq.11;
        Sun, 31 Oct 2021 18:57:32 -0700 (PDT)
X-Gm-Message-State: AOAM532NZZipZ4PmQd8aebdgMaPN+5gcICkzFLd/y8dVP59BicYUBfRR
        GiO3PJt2T6KiHFhFuW8wOniKZgqQn/AFtYLfgjc=
X-Google-Smtp-Source: ABdhPJwLzr48xvkbPUYNSwW4wG4jcRHULAsaxHDgvLOaeOhiDi1MY+7mZCeP1WaifSe+QfUYgjKQrdu4XIYT2pTMgvI=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr16913634uar.66.1635731841194;
 Sun, 31 Oct 2021 18:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211027211715.12671-1-digetx@gmail.com> <20211027211715.12671-13-digetx@gmail.com>
In-Reply-To: <20211027211715.12671-13-digetx@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Nov 2021 09:57:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT+EsLt+pnYyTw_B0C8isho=E4tfOWROe9h-GZpYjET=w@mail.gmail.com>
Message-ID: <CAJF2gTT+EsLt+pnYyTw_B0C8isho=E4tfOWROe9h-GZpYjET=w@mail.gmail.com>
Subject: Re: [PATCH v2 12/45] csky: Use do_kernel_power_off()
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Only for this patch, Acked-by: Guo Ren <guoren@kernel.org>

On Thu, Oct 28, 2021 at 5:18 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Kernel now supports chained power-off handlers. Use do_kernel_power_off()
> that invokes chained power-off handlers. It also invokes legacy
> pm_power_off() for now, which will be removed once all drivers will
> be converted to the new power-off API.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/csky/kernel/power.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/csky/kernel/power.c b/arch/csky/kernel/power.c
> index 923ee4e381b8..86ee202906f8 100644
> --- a/arch/csky/kernel/power.c
> +++ b/arch/csky/kernel/power.c
> @@ -9,16 +9,14 @@ EXPORT_SYMBOL(pm_power_off);
>  void machine_power_off(void)
>  {
>         local_irq_disable();
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         asm volatile ("bkpt");
>  }
>
>  void machine_halt(void)
>  {
>         local_irq_disable();
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         asm volatile ("bkpt");
>  }
>
> --
> 2.33.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
