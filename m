Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51118447B55
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 08:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhKHHuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 02:50:17 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:46929 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbhKHHuQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2021 02:50:16 -0500
Received: by mail-qk1-f170.google.com with SMTP id bl12so14637691qkb.13;
        Sun, 07 Nov 2021 23:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niQCVpji9nu8a8Mfie3ofua8MkF1HzpLuS22ys5pvwg=;
        b=QxhKC3BH6UKmsf+en5LDsE2LBeZaA/X8MZ852CifiBk7lxKwvvQ8DvQzVCJxpn5NLP
         sUafxXkCujdPkXdjCp08V3qdDG7N1+RyuQ4yRaYSXr9VC8emQREANOjzOZyjMa/6MyZ1
         ebyXOdDFecNFXOnOI9KCznfXjls9NSdbdlYPIqzXgQKeYmXawyeNbqPk+wpw/iM3p8Qz
         GYnZJI/gOifPb+tn1N/ez25v3Z+EZKbOTcnsyGCUaB1vQAwldUQHRYwqwJ4JsbCGpA52
         q/cZpzUYpazcuYCAjvlNWmBhpUmXw2FumJQh7RMmwOl9AidSO6dCrA3Tw6e+d4XChmpJ
         S2qQ==
X-Gm-Message-State: AOAM533Ndj5HCg9s4l2OPPgz513/MnYueo8JLiwpRssuUn55AVtH5Ycg
        pSYGW71BTe5t90Ouy0Kgyqyh+38S0qx3Jg==
X-Google-Smtp-Source: ABdhPJwQvMewvRjNbN/c0TXq4JonZhcv8d7XAj6/kChLjlMOwqYn6iZDfJo4XDnr1yHj+M1GgRMQ2Q==
X-Received: by 2002:a05:620a:752:: with SMTP id i18mr6713068qki.453.1636357651412;
        Sun, 07 Nov 2021 23:47:31 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id s13sm5045006qtw.33.2021.11.07.23.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 23:47:31 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id gh1so11375219qvb.8;
        Sun, 07 Nov 2021 23:47:31 -0800 (PST)
X-Received: by 2002:a05:6102:3a07:: with SMTP id b7mr71214037vsu.35.1636357641114;
 Sun, 07 Nov 2021 23:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20211108004524.29465-1-digetx@gmail.com> <20211108004524.29465-22-digetx@gmail.com>
In-Reply-To: <20211108004524.29465-22-digetx@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Nov 2021 08:47:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpW0389_uJR2xg+HCstXanutPxrcRdvgu8kxH1J9T++w@mail.gmail.com>
Message-ID: <CAMuHMdXpW0389_uJR2xg+HCstXanutPxrcRdvgu8kxH1J9T++w@mail.gmail.com>
Subject: Re: [PATCH v3 21/25] m68k: Switch to new sys-off handler API
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 8, 2021 at 1:48 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> Kernel now supports chained power-off handlers. Use
> register_power_off_handler() that registers power-off handlers and
> do_kernel_power_off() that invokes chained power-off handlers. Legacy
> pm_power_off() will be removed once all drivers will be converted to
> the new power-off API.
>
> Normally arch code should adopt only the do_kernel_power_off() at first,
> but m68k is a special case because it uses pm_power_off() "inside out",
> i.e. pm_power_off() invokes machine_power_off() [in fact it does nothing],
> while it's machine_power_off() that should invoke the pm_power_off(), and
> thus, we can't convert platforms to the new API separately. There are only
> two platforms changed here, so it's not a big deal.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
