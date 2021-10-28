Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5568D43F24B
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 00:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhJ1WI0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJ1WIZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 18:08:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1CBC061745;
        Thu, 28 Oct 2021 15:05:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h11so13245548ljk.1;
        Thu, 28 Oct 2021 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QdlXzZMWoVtcTasTaLsmBsOCqsQBbCgeCfcj0o9XtUc=;
        b=OJvAD8QIK23NiAd5gHFgNc2jMlnwbUhscd64oItZCjDzpbaa9HqfW53eGYcjGvS+Hd
         8DJvk+brxf2GEvT4zQ6W/ef2iXaKU3cVUF0C3X+R0CYtCLZK9UxcbzlXYXArEArHwTk8
         vcyalmRFTF2jyokLO2ef7zgVnqs7E2ea+6mOp4eaXLCsLH7zqMUa5b9lGYh++3iI3c5l
         5SNXuX8KUFV580Mc9ixmfzVIv8iajcv/gjbcoXvjaxxhRQdJfHyZ96a4PDZESCiQ0JsQ
         ezipbNgT7rnH4g7QwqVqZwJlBhjMy6NJ72j6JC2Ohga6KFFIy4TxdzbmMsSK+f4qNFMJ
         K+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QdlXzZMWoVtcTasTaLsmBsOCqsQBbCgeCfcj0o9XtUc=;
        b=FFtfODnscTIteEXyrJi6kL1Dpwqi8C/D+UVWrvuHnM9aUzpyZFovcdVToOP+DOWFKV
         ZmZP2BY978KdWG/9LKuCo12P/uGCC41z4IvtdOxz9zNUKPIEJc9S0ElczH1QB+lEQdmd
         iG95rrm7cCDYvQeKPyCR9INrO+6TWUnCzV6VuayP1q/69OiQB6fIcm73XG34OOEt9mhc
         /vriJ6KzAd0u2DNTrrCKa06DKxIeQvhkz/O11kAsALLGTlToPQbfD902Bkr9jIrSGXwo
         6GPxTWQ0ajxRKzYUChvDAjeMIEyx7PeLK54rOXFou6WvTOTgEb2SAi+K9XFi2w3Yr2nG
         dHVw==
X-Gm-Message-State: AOAM531WZ8gzxeBDcYcdJ467VcP0Y65s+wsCc8Y8dy1nx+4E8g9QHWJJ
        W31EkxPsyIXig9GsUU4fBES6+i3WLMk=
X-Google-Smtp-Source: ABdhPJzozZj+Szoqatj9JJ7zamkbp5Jf8v8z0Y7vkU95q/rca882+TrclSa79lyDyuur0f9DZkdGEw==
X-Received: by 2002:a2e:99da:: with SMTP id l26mr5923422ljj.508.1635458756009;
        Thu, 28 Oct 2021 15:05:56 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id v13sm444651ljk.72.2021.10.28.15.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 15:05:55 -0700 (PDT)
Subject: Re: [PATCH v2 00/45] Introduce power-off+restart call chain API
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-omap@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
References: <20211027211715.12671-1-digetx@gmail.com>
Message-ID: <92067c5e-a256-ff45-eae2-21033c6a83d2@gmail.com>
Date:   Fri, 29 Oct 2021 01:05:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

28.10.2021 00:16, Dmitry Osipenko пишет:
>   mfd: ab8500: Use devm_register_trivial_power_off_handler()
>   reset: ath79: Use devm_register_simple_restart_handler()
>   reset: intel-gw: Use devm_register_simple_restart_handler()
>   reset: lpc18xx: Use devm_register_prioritized_restart_handler()
>   reset: npcm: Use devm_register_prioritized_restart_handler()

These patches got lost because Gmail gave me ban after 40's email. I
think it doesn't worth to re-send them now since you should get an idea
about how API usage looks like without the lost patches.
