Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCF4A3F3C
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 10:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiAaJ3M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 04:29:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39558
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233106AbiAaJ3L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jan 2022 04:29:11 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3BB393FFFC
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jan 2022 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643621349;
        bh=dkzBuNd+uNU6CfCWtlWJDYP24x7ho0sbzpUOr5OCq8A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=npnL6kukN3MGgHvQMuvDwX7ll4GcEVBGbnNeLSG8MOxDYBx8AGAWrKuIcGS0Gxhkq
         W+QcqyIM/SOtFaV/yWWSZVN/Hjbzn1XTENWVzSbsBq1po2R1CjTqSfygYOL6rYDvkZ
         aLsbIHRxDBKJUhuJFfxOUZezDEwM8MoKt4La4Wwra4iQtu8bnZLvSSNqyZlTmetiic
         Fhwm8/V4G/tIUC3G+n6vmgXHQ/MaW+aCawtOPSuhoZyOZ10yyRJ8jd/gVrUHAN0rJR
         gi8zESP4PiQF0DA1XJDqfOAMAQjVg0OCqpQ6GnM5cqf4zcc6KW1oYq0HV0pU4/1vcm
         lunq5rksaaTMA==
Received: by mail-wm1-f70.google.com with SMTP id s1-20020a1ca901000000b0034ece94dd8cso10085994wme.5
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jan 2022 01:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dkzBuNd+uNU6CfCWtlWJDYP24x7ho0sbzpUOr5OCq8A=;
        b=K60i7UfGkGuo1ffKKqg8gF16HayzvY0lz5NVZ1AZkDRpP3iLh6yxirYjdOq3gnJ3h+
         BL8UpFfcfAscH4mQbXY4CUCfyVt2a6cbqbzKP3laUzHjqOeA2IoUDIx0XE/OPMzCUMhd
         LIMQuYp0djobl8uXa/sxavnKG4YJWXsmZMRVVWpbzkuUog7Lwr+Yi6nRrXxhFucQndcQ
         T/mqWVIZQiNl2uwuYNvirJHJhMaXPjXL4YZi8HP0FkwSXFbg9sPmOcSh9kwwWz2xTjLi
         K/dlCo7KTuOsooniLXB5RqLb4So8m1etr6m0dvpczre0ZWww+1AM0Ujs/LfBZ6Xu4PWR
         jWfw==
X-Gm-Message-State: AOAM531nInOel0YQwSdr5Z2EufSyxm2BGms3A/6pBYBf+NgZeDQxcKtc
        1i4a1JrnbNrCPdsomSuQh9xPSVIy5kSwLqq2cYk+0FtXtrRy1HPxZjEooMhTIrbOrNpXelaKowR
        za3OkgrXoKle8FCAJt5OKc1fFWF44x2dOhaNhZ7I=
X-Received: by 2002:a17:907:d88:: with SMTP id go8mr16082674ejc.343.1643621337687;
        Mon, 31 Jan 2022 01:28:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwUgdzk1HBzC4qCevIT6t5qYbRcRcbKgCipd7W6AaFHRRw14fKuy7dvOGc19/jX8mpPV7Ajw==
X-Received: by 2002:a17:907:d88:: with SMTP id go8mr16082640ejc.343.1643621337451;
        Mon, 31 Jan 2022 01:28:57 -0800 (PST)
Received: from [192.168.0.71] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z2sm2645158ejn.117.2022.01.31.01.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 01:28:56 -0800 (PST)
Message-ID: <1e22e171-9d13-5763-a9e2-a24e7d98e130@canonical.com>
Date:   Mon, 31 Jan 2022 10:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 18/21] memory: emif: Use kernel_can_power_off()
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20220130233718.21544-1-digetx@gmail.com>
 <20220130233718.21544-19-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220130233718.21544-19-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 31/01/2022 00:37, Dmitry Osipenko wrote:
> Replace legacy pm_power_off with kernel_can_power_off() helper that
> is aware about chained power-off handlers.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/emif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
