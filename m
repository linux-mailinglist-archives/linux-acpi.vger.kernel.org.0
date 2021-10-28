Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C043E0C8
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJ1MY1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 08:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1MY0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 08:24:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27A2C061570;
        Thu, 28 Oct 2021 05:21:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so4527788pjb.4;
        Thu, 28 Oct 2021 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sEQTGe1SdVzMEvdAS+JHzGs+s//rKDLb3zrHBeoZhQ4=;
        b=iTF+KxXEUPxEL0X/A/h2gzR6rfhKbueZtpV43T9ecbwhzi0t+l3q/o5Ua3AWvU+Enc
         ByGkTqENMRntgh3iznFMDxu2CMYcinTkd+zVseDqmIBVqNiOOl7jtDTN28tXnXeh/eHS
         f+SIvvi2YC7tI22dM3EDibcHeQLa3iIqsv5H8CiejoyVxtmYKOA3VOetskmtU4Lx+Pqb
         LjWvbMeTK5pVAec3h6exgixTZBuA0b6b4pLrHZnH5EOvWXMCcJgTfSDot7PpiFpwOrmA
         UDe0Zf8yyrgR8VQIYltC0W9ualVYljq6alX4ZkNWzu2NeGmBPW3wY5ZPA2p2XVSWoIe3
         jylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sEQTGe1SdVzMEvdAS+JHzGs+s//rKDLb3zrHBeoZhQ4=;
        b=7UqHXmGC7VkoA7cxNiyG2I8GDN5WsK6Och2jEsorg2xs71y3Lkvwssk0SnKFNsdplI
         dh9gh/HtHNCaNWgyruD7azzfURKvRfLsCaTyz9yZltjXJSlQyCToBnvvsxfVbOODZFr1
         0wIvD84ktyB1DQHE8VDXMyPpiurY55RzfEWrwCyYVtM0NfgY59IdfXSur/j+Aq1nOT9G
         lKDHoMFXwSJ5xSZiLuhkYkgZ3T6qAj4biP00/S633Lw5Lo0dcLdjjP3YvCiSk0Jc1F0E
         CCaB4QjYRIQgb/RS24uT+cGediLLJq+3iuGafwAUTWqWyHj6Yo/1zTlZHINhmPpdTB5k
         e1mA==
X-Gm-Message-State: AOAM5325AblF+P/V0liVZGz7oMHsAm7WzDnbJwgCDC6XrUpk4VtHIxIc
        /oggQY6Bo6nw0nQ1Ep511ihPaMOHnJ4PPNxL890=
X-Google-Smtp-Source: ABdhPJwgRG6Z5IlQAMmxkEb7xwk/3DRskWOoc9lq5s+Jze0PB67uqVa13ZU9GrnI44E+cb/61DiEpYjC8sFDBN8RSYA=
X-Received: by 2002:a17:902:b716:b0:13f:b2d1:f316 with SMTP id
 d22-20020a170902b71600b0013fb2d1f316mr3644234pls.24.1635423719258; Thu, 28
 Oct 2021 05:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211027211715.12671-1-digetx@gmail.com> <20211027211715.12671-16-digetx@gmail.com>
In-Reply-To: <20211027211715.12671-16-digetx@gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 28 Oct 2021 20:20:00 +0800
Message-ID: <CAEbi=3eTruN6rYvEHCtyhTEZ=Ep8n6g75UMpHffc=0UrVTGbdQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/45] nds32: Use do_kernel_power_off()
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
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
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
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-omap@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Alan Kao <alankao@andestech.com>,
        =?UTF-8?B?Sy5DLiBLdWVuLUNoZXJuIExpbijmnpflnaTmiJAp?= 
        <kclin@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=885:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Kernel now supports chained power-off handlers. Use do_kernel_power_off()
> that invokes chained power-off handlers. It also invokes legacy
> pm_power_off() for now, which will be removed once all drivers will
> be converted to the new power-off API.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/nds32/kernel/process.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
> index 49fab9e39cbf..0936dcd7db1b 100644
> --- a/arch/nds32/kernel/process.c
> +++ b/arch/nds32/kernel/process.c
> @@ -54,8 +54,7 @@ EXPORT_SYMBOL(machine_halt);
>
>  void machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>  }
>
>  EXPORT_SYMBOL(machine_power_off);
> --
> 2.33.1
>

Loop in Alan and KC
