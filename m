Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF2460A00
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Nov 2021 22:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbhK1VJb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 16:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358715AbhK1VHa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Nov 2021 16:07:30 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF4C061763;
        Sun, 28 Nov 2021 13:04:13 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u22so30582768lju.7;
        Sun, 28 Nov 2021 13:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wtn5Hkee5e4Yh99ylBrB3oNbIRTQMbXx6i2LcHRuAAA=;
        b=D7axuJW5K4soTW7ePg2XEY/iNxftObXK2r+AyGGcLpSZUVVVDeOdARXPvJKsrnTiWz
         AoAXcXPY5kZDAFmNd2VORgyu8fNJK2h3Akf7Z4wOIV4j7hl4k+Lg94oWKvPyZvxvLsrU
         gHjqykqz9pVTUOOpARf13AebW7syYSoupun9EMn0XvrUZckKr/LqJa+4eSWKEzDWJLdo
         K7OPzWs09+Av5yHcfZj3Q7MZQ+BDltCGiVFFVwhBt7T15YiSiT0WAJ3uiNnPq9pF4dyU
         I8pWXsXnC3XNCL+7zY4D1T6JR7EW9moTsiVuNSfEmpW1ojxHFbjsYoYQXbcJq5XV5+Um
         iPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wtn5Hkee5e4Yh99ylBrB3oNbIRTQMbXx6i2LcHRuAAA=;
        b=vrIZVpDT3tnzcveZGsfsZ+sQpoSpPnctxxF5MXi6Ki48xD5/nIR3HxPBhqg9ZbfsCn
         4ZevCQ6yGiBw0SuAoZbvGQAwtmQXJcm9ehhj1Xm8fkwAT89v4n6U3GxZZQh93rwEUZon
         sXsUxKnnTjb1iEA45kQH5/ObPXpXN4nv+oiJ2/oNYxkwqDJeGDbjzNRcw6h2zG1t3qi4
         tcQul+/L9S82LkeDFeJbiGhN98c+Bh10RpBJ0Pqiu1LGtu6kWUwFbkyCdDbbkyRwSVwE
         PJbp7X0RwNtRCbA3qfSsppTgZJ04LOr9/P5GG5wEn//PG06Yl0HhUPhDayocwjEDRlPB
         XMqg==
X-Gm-Message-State: AOAM533w/p62Q3K+3XACckNIHGvJlSknW5xp4/rx1IFpYmeM0rcYt3Bg
        LHouOxz4uJAURZYFCLWgys7ZLXmTFFA=
X-Google-Smtp-Source: ABdhPJxH7knkFdz7TFpFlawyIdB41srtPJMqsrOfzCPJDLK6AlWk3m8N6okcECoeJRZyDtP9PR9VhQ==
X-Received: by 2002:a05:651c:1257:: with SMTP id h23mr44458754ljh.17.1638133451873;
        Sun, 28 Nov 2021 13:04:11 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id c17sm1100736lfr.235.2021.11.28.13.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 13:04:11 -0800 (PST)
Subject: Re: [PATCH v4 08/25] kernel: Add combined power-off+restart handler
 call chain API
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20211126180101.27818-1-digetx@gmail.com>
 <20211126180101.27818-9-digetx@gmail.com> <YaLQqks8cB0vWp6Q@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9213569e-0f40-0df1-4710-8dab564e12d6@gmail.com>
Date:   Mon, 29 Nov 2021 00:04:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaLQqks8cB0vWp6Q@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

28.11.2021 03:43, Michał Mirosław пишет:
> On Fri, Nov 26, 2021 at 09:00:44PM +0300, Dmitry Osipenko wrote:
>> SoC platforms often have multiple ways of how to perform system's
>> power-off and restart operations. Meanwhile today's kernel is limited to
>> a single option. Add combined power-off+restart handler call chain API,
>> which is inspired by the restart API. The new API provides both power-off
>> and restart functionality.
>>
>> The old pm_power_off method will be kept around till all users are
>> converted to the new API.
>>
>> Current restart API will be replaced by the new unified API since
>> new API is its superset. The restart functionality of the sys-off handler
>> API is built upon the existing restart-notifier APIs.
>>
>> In order to ease conversion to the new API, convenient helpers are added
>> for the common use-cases. They will reduce amount of boilerplate code and
>> remove global variables. These helpers preserve old behaviour for cases
>> where only one power-off handler is expected, this is what all existing
>> drivers want, and thus, they could be easily converted to the new API.
>> Users of the new API should explicitly enable power-off chaining by
>> setting corresponding flag of the power_handler structure.
> [...]
> 
> Hi,
> 
> A general question: do we really need three distinct chains for this?

Hello Michał,

At minimum this makes code easier to follow.

> Can't there be only one that chain of callbacks that get a stage
> (RESTART_PREPARE, RESTART, POWER_OFF_PREPARE, POWER_OFF) and can ignore
> them at will? Calling through POWER_OFF_PREPARE would also return
> whether that POWER_OFF is possible (for kernel_can_power_off()).

I'm having trouble with parsing this comment. Could you please try to
rephrase it? I don't see how you could check whether power-off handler
is available if you'll mix all handlers together.

> I would also split this patch into preparation cleanups (like wrapping
> pm_power_off call with a function) and adding the notifier-based
> implementation.

What's the benefit of this split up will be? Are you suggesting that it
will ease reviewing of this patch or something else?
