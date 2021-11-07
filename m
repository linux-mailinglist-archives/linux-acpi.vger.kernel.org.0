Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43144742C
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Nov 2021 17:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhKGQzs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 11:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhKGQzr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 11:55:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E4CC061714;
        Sun,  7 Nov 2021 08:53:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b40so1362609lfv.10;
        Sun, 07 Nov 2021 08:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FuxjUSeidJvAMVHKU9E/d55P+zyTiwTeSCeqf/uVMDo=;
        b=Lwzfxq5uEYmwUHQaauy1zdfEe4xJydQ9b9Od8uYrwBczi5NJMIekKLJg7wlYTXl+4h
         aBwFrnzPjUuQZKv1Ia+S222jU8dJElyFhzTX7Y6Z3zgW5uo6fxyJ6Ub7QZuJOpIcD/5G
         Z5zvDqw9CupdRxfoeBn7XfS8iSTjIzecdpz5R8YfLYHN44fPq2Sj3DZqQfYaE9SGw4KM
         9QVgWsVoZpReO+np7PVvhGoeoi2Muq2En7xd12JC02FvD5KUvlS8dKa1pfLtqGdyB8C3
         Q31AQZyOLu3Y3rBXma7EsV9dMapOWW+H7dfnyyasqa2gU34jVZGgiKgGYKDrTdyFanCB
         8Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FuxjUSeidJvAMVHKU9E/d55P+zyTiwTeSCeqf/uVMDo=;
        b=3h7BWS4vsfeNsf0u6cAzVWltrHbUiy5pkrxRqklJN0hnSS4vBDCXyZoPdBF3V+jmkP
         10GGVGqmQEzL50PyvVbH5LIqrxSpwV1cC7tdI+BLQXkOXvu1q0bHtt+8JiQ9XxFdVKst
         O4+ZbUJttBQl561kl3AWgu6v3bML18ZBxUTIJkG+rBluCHgD0b15oI38w25pvNkJTYaj
         AFDAl+VF6qxbLisLHPeJgo5dLZ005XN8Fj3oJnSVXfm9SlLUeypKznA9odujmigv1OI3
         UJqIUMXIVOqSaeBe5MtAqJ37C5HkvtamXB2r3VRO9u7bCyzQFDo7EP7hLOeE2i6ynoS6
         p1kA==
X-Gm-Message-State: AOAM532ULEzpzgxyCUvW6BRw4G2YZa2EdEM/UCtsVLRVG/FEx6+x+f8l
        NaOLZBgPXHSUMzK3sJwjtOTTRckjT6o=
X-Google-Smtp-Source: ABdhPJyYdIEr6ONtuDBexIQwg75AwiW2LoF8DEUBqYkEbum61pW0vPuGJTsEH8z54RKtLjaAI2MWow==
X-Received: by 2002:a05:6512:1082:: with SMTP id j2mr64106958lfg.568.1636303982698;
        Sun, 07 Nov 2021 08:53:02 -0800 (PST)
Received: from [192.168.2.145] (79-139-182-132.dynamic.spd-mgts.ru. [79.139.182.132])
        by smtp.googlemail.com with ESMTPSA id c3sm860233lfb.122.2021.11.07.08.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 08:53:02 -0800 (PST)
Subject: Re: [PATCH v2 27/45] mfd: ntxec: Use devm_register_power_handler()
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <be0c74c6-05a9-cad5-c285-6626d05f8860@gmail.com>
Date:   Sun, 7 Nov 2021 19:53:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYbqlmOM95q7Hbjo@latitude>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

06.11.2021 23:54, Jonathan Neuschäfer пишет:
> Hi,
> 
> On Thu, Oct 28, 2021 at 12:16:57AM +0300, Dmitry Osipenko wrote:
>> Use devm_register_power_handler() that replaces global pm_power_off
>> variable and allows to register multiple power-off handlers. It also
>> provides restart-handler support, i.e. all in one API.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> When I boot with (most of) this patchset applied, I get the warning at
> kernel/reboot.c:187:
> 
> 	/*
> 	 * Handler must have unique priority. Otherwise call order is
> 	 * determined by registration order, which is unreliable.
> 	 */
> 	WARN_ON(!atomic_notifier_has_unique_priority(&restart_handler_list, nb));
> 
> As the NTXEC driver doesn't specify a priority, I think this is an issue
> to be fixed elsewhere.
> 
> Other than that, it works and looks good, as far as I can tell.
> 
> 
> For this patch:
> 
> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Tested-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thank you. You have conflicting restart handlers, apparently NTXEC
driver should have higher priority than the watchdog driver. It should
be a common problem for the watchdog drivers, I will lower watchdog's
default priority to fix it.
