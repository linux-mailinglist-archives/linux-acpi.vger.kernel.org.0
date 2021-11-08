Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9902C447EF5
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 12:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhKHLjb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 06:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhKHLja (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2021 06:39:30 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31329C061714;
        Mon,  8 Nov 2021 03:36:46 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d11so7696680ljg.8;
        Mon, 08 Nov 2021 03:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X+QlLlo/0/3EVdBxA2kw9RSD+7dI68j0akmWtlfHVoc=;
        b=aZVzW8uInA8LU/x+WSDcs8GL423pa/2TbHlNFMZCd9U6UTTINhRxHwWgMG+VIGRFXX
         YHsHS1Zp8SLg7g0I8x9US08hxM80ZghlJabXZBFwbjt/NZTi8D93A6u3DdWQsriGAEMv
         bFmB7LTf3DQwVbSm6WogHRt9oYdTZJJwV6Cdja/STeDW7/10QbzkyuPD5z+/FAuGPwej
         XDOG6vFO/moWThDJAR559rbcfRfK+AgOLrilun42rQLGkujwn1pckpcm4TgSB3WIb1LP
         WWP0u+S7lmnv27N0vKhUH9Av/RJV5C0NJsxi8Lo9cU/Zh/pB4HH/qd8XqYWZNDXsqTHX
         YlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X+QlLlo/0/3EVdBxA2kw9RSD+7dI68j0akmWtlfHVoc=;
        b=KWZdk7RIX27jzq4RWHkl++6p6t82eepplG51Hg6iBlvnXdeiNGg5mWFtBTgM55fD7r
         XaIcxM0I9HVYSuwEcBCiArXlfnjus7cT9ZZ6iMzQF2pJKl4TpaiZpgKqRZH7d3DEo4Dn
         uvhpIT2CpKXKxDgJ/yBdCo1CWE8bTJqe7wdeVeEhl5iwBR/NsMnhlMhwyIJKj8NKcQrq
         IWba0h+ROl9jelRGhDswgqd4dLCsuPegDv//UT7Hzc6OQKftauIME2n+0p/8opchtOcN
         QJ8Z+DkbR+WsvH7yCQBhWIuqXTl3AYGiG0kohknrg8xW+MA86Ja7rV7VJQDBR6pi66gG
         09dA==
X-Gm-Message-State: AOAM5318fCuZW4f5bQvwbv1aWwofiCGjZ7druMr/mD/F+riYA9nvuZM9
        B6LlG+MxfE+0FzcGt1tuJcOi/G4F1CM=
X-Google-Smtp-Source: ABdhPJzzWZ+q13ptoCU5JHKLBozyl2qyG0di7fj7GC0x6tQVXWEZ5utjk3vHuuOVClKYY3WCOwTKiw==
X-Received: by 2002:a2e:bd88:: with SMTP id o8mr69963654ljq.197.1636371404363;
        Mon, 08 Nov 2021 03:36:44 -0800 (PST)
Received: from [192.168.2.145] (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.googlemail.com with ESMTPSA id q6sm1523591ljh.1.2021.11.08.03.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 03:36:44 -0800 (PST)
Subject: Re: [PATCH v2 27/45] mfd: ntxec: Use devm_register_power_handler()
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Chen-Yu Tsai <wens@csie.org>, Tony Lindgren <tony@atomide.com>,
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
 <20211027211715.12671-28-digetx@gmail.com> <YYbqlmOM95q7Hbjo@latitude>
 <be0c74c6-05a9-cad5-c285-6626d05f8860@gmail.com>
 <9a22c22d-94b1-f519-27a2-ae0b8bbf6e99@roeck-us.net>
 <658cf796-e3b1-f816-1e15-9e9e08b8ade0@gmail.com>
 <5a17fee3-4214-c2b9-abc1-ab9d6071591b@roeck-us.net>
 <c0b52994-51f5-806b-b07e-3e70d8217ffc@gmail.com> <YYkIeBSCFka9yrqC@latitude>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <04103df3-1ef4-b560-a5cb-fa51737d28ad@gmail.com>
Date:   Mon, 8 Nov 2021 14:36:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYkIeBSCFka9yrqC@latitude>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

08.11.2021 14:22, Jonathan Neuschäfer пишет:
> On Sun, Nov 07, 2021 at 08:42:33PM +0300, Dmitry Osipenko wrote:
> [...]
>> EC drivers tend to use higher priority in general. Jonathan, could you
>> please confirm that NTXEC driver is a more preferable restart method
>> than the watchdog?
> 
> Yes. The original firmware uses the NTXEC to restart, and it works well,
> so I do think it's preferable.

Thank you, then I'll update the NTXEC patch like this:

https://github.com/grate-driver/linux/commit/22da3d91f1734d9a0ed036220ad4ea28465af988

