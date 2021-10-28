Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2BF43F1E3
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhJ1Vi6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 17:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhJ1Viz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 17:38:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B963CC061767;
        Thu, 28 Oct 2021 14:36:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u21so16448958lff.8;
        Thu, 28 Oct 2021 14:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=thttoNtx85IqBzMI/c95u4NQI+WEGNQqD09v61bWPkE=;
        b=Y9ted3wnUvFPZbztZa+QHRbohuO2ujzfF68/pFicW5dA7D1yuFrKCL4aTWk/1AChzB
         fKwgUocsDwuNOGM2+iseiHe/bj2d1v3+dSRNtXKqEmTsyBkz7IWQs8pVvc2a2gvGjfup
         yLqAO4u/w7mjCphm/lBZwptgCTPupkSC+307KKr7OHU7po5AtPQB8ZhrguBiu6yERIjH
         bK0WN85VLNpdVAhT7soiJpVcCZ4Sp0KIHJV14Uu8RloVE9YJBCz/nPhBHDPyGgkjYHQ0
         imoJdP8GopH3zoQfTkWNgL4xsg20XHFvSLev9dZQthSUfjSrDblQ5bVzKxHiquLI0ZeF
         3ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thttoNtx85IqBzMI/c95u4NQI+WEGNQqD09v61bWPkE=;
        b=nYSnXZavKW0ZBXFLYw/bG0w08UCeXCgOfejTobR/okc9jQG4/1mv0ovitxn3rS4PhC
         as1cpAXGegPO6kfDj1fZNQC7bDwxKirAd8xum3aj7Dpric3aPPqg2DHMCOoYgITpaZXz
         8YLgn+fM3JWl0v3wEF99uRTiMkPDhXAPNwXAk++8JkiUhCihtPuK6lcLevz1tqfAo/ZP
         pja6UZeSqB7Mtzf6oTf5V+YtjPOPC/iusY2d9VJxKH74WzRHmj4F4yA5GyoNtX6gza4o
         oIBL+CqaX1JPvb5PM+qrdqbhjhhOfn5BMFj2SrRebFzsh3HpbZefryFMB14kme7BWaAA
         wseQ==
X-Gm-Message-State: AOAM532mtM9bLBIaAURTdFBBFjZ7Z8ETZFCCmRHym104NOECln8zm8Fg
        +8bYaBYBiaGcUaxfIty8Gp9dJYbbgQU=
X-Google-Smtp-Source: ABdhPJzbYSC0nWI15MXaoXJe2SikVhRJRnLxoLeSiSPsVfPjrcP1DbWpe0jTqiEw6MLnleJHOc1O3g==
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr6437448lfu.619.1635456985989;
        Thu, 28 Oct 2021 14:36:25 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id s9sm396521ljg.76.2021.10.28.14.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 14:36:25 -0700 (PDT)
Subject: Re: [PATCH v2 08/45] kernel: Add combined power-off+restart handler
 call chain API
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
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
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20211027211715.12671-1-digetx@gmail.com>
 <20211027211715.12671-9-digetx@gmail.com>
 <CAJZ5v0jMdSjmkswzu18LSxcNk+k92Oz5XFFXmu-h=W8aPP4Oig@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d1837954-bd70-460d-3548-0d5ec5b75704@gmail.com>
Date:   Fri, 29 Oct 2021 00:36:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jMdSjmkswzu18LSxcNk+k92Oz5XFFXmu-h=W8aPP4Oig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

28.10.2021 12:53, Rafael J. Wysocki пишет:
>> +/**
>> + * struct power_handler - Machine power-off + restart handler
>> + *
>> + * Describes power-off and restart handlers which are invoked by kernel
>> + * to power off or restart this machine.  Supports prioritized chaining for
>> + * both restart and power-off handlers.  Callback's priority must be unique.
>> + * Intended to be used by device drivers that are responsible for restarting
>> + * and powering off hardware which kernel is running on.
>> + *
>> + * Struct power_handler can be static.  Members of this structure must not be
>> + * altered while handler is registered.
>> + *
>> + * Fill the structure members and pass it to register_power_handler().
>> + */
>> +struct power_handler {
> The name of this structure is too generic IMV.  There are many things
> that it might apply to in principle.
> 
> What about calling power_off_handler or sys_off_handler as it need not
> be about power at all?

I didn't like much the 'power' either, but couldn't come up with a
better variant. Will change it in v3, thank you.
