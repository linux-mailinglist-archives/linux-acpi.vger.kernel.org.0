Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5390B44746F
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Nov 2021 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhKGRTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 12:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbhKGRTb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 12:19:31 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F34C061714;
        Sun,  7 Nov 2021 09:16:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d11so3674339ljg.8;
        Sun, 07 Nov 2021 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jV9RGgGqsoNpHnAdElYoxsETzdtFTgnoU+evNHPJvgw=;
        b=XcS1vFi7jvcKKMU+Vh16iv2r+zEgY2qHFwfEvUkTbUqhYfGd/aHwUSSPvlkmYZnUDY
         yKyQ/S1MODqE5UdkEERTRM+mtxI1gBtYC+YHMFR0Q7VUSP941Fv1rRNweTBgkgPsVjOi
         /VhimMLC6erylFfqa93dW9OuY6rPJeGZgNEfAStOSIcxbKlGE8kYSWtur2agIS+KxZBT
         uxw/ElMwoYX/SIJQ69spejui0ImHzrQg/eO3RQFc7ylvx2K4v5e4KD8cBjKF0cCi6jz/
         kU0RJ2R+nsOSEtcz9pzFEbzI1pboWLlqc1bt4/UyILzUL1onLEjZ1y8wuTJEXkf/BE4p
         Mk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jV9RGgGqsoNpHnAdElYoxsETzdtFTgnoU+evNHPJvgw=;
        b=Gz5RLul7BH1ZKABdxFuZNqCFkWhagPypgYVycwuP4mVYEK1zFl7TrbWsEL73GM59dp
         W0CcpAKT+6ubm7F2GZvtm644vAoOFiKuvW9f8WnOCM1tqoZDfRHMa6hB+PxY8kdguaQj
         4hv+0Kpvm0BYTj8VNMGqpcNTcAZIkcj2vA23XRoZmxhXDU8x+Cuz+vWTUJaxUgi53unU
         +0WYJLJeiLU2h/6bj4dBTE4WB0zSod2NEyDn9w3jce7Al/doRdXwo5xopI5CjdSuHB9D
         p7AI+i4ZlAUXaDAUPGSfyAV+WDgw7ETUfxmK5pZNLjtOBmudV4gxNBTSs7ieaQFo0EXw
         4NOg==
X-Gm-Message-State: AOAM531+/ZgOXkJRTXwgujXSUXyZJbaqIfXff2/oQodLr6OWDDrmape8
        6/rcW7+u9U85xOHZBVUpFtLrBwl8MR8=
X-Google-Smtp-Source: ABdhPJxvgxAU8oisB10upx88enZ2ZbX58EuDflf4IdQYDWaIcA3t9DPLAVkvy85p5EpHAL+e+Eae8Q==
X-Received: by 2002:a2e:92c4:: with SMTP id k4mr61687714ljh.271.1636305406651;
        Sun, 07 Nov 2021 09:16:46 -0800 (PST)
Received: from [192.168.2.145] (79-139-182-132.dynamic.spd-mgts.ru. [79.139.182.132])
        by smtp.googlemail.com with ESMTPSA id h14sm1531135lfv.83.2021.11.07.09.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 09:16:46 -0800 (PST)
Subject: Re: [PATCH v2 27/45] mfd: ntxec: Use devm_register_power_handler()
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <658cf796-e3b1-f816-1e15-9e9e08b8ade0@gmail.com>
Date:   Sun, 7 Nov 2021 20:16:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9a22c22d-94b1-f519-27a2-ae0b8bbf6e99@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

07.11.2021 20:08, Guenter Roeck пишет:
> On 11/7/21 8:53 AM, Dmitry Osipenko wrote:
>> 06.11.2021 23:54, Jonathan Neuschäfer пишет:
>>> Hi,
>>>
>>> On Thu, Oct 28, 2021 at 12:16:57AM +0300, Dmitry Osipenko wrote:
>>>> Use devm_register_power_handler() that replaces global pm_power_off
>>>> variable and allows to register multiple power-off handlers. It also
>>>> provides restart-handler support, i.e. all in one API.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>
>>> When I boot with (most of) this patchset applied, I get the warning at
>>> kernel/reboot.c:187:
>>>
>>>     /*
>>>      * Handler must have unique priority. Otherwise call order is
>>>      * determined by registration order, which is unreliable.
>>>      */
>>>     WARN_ON(!atomic_notifier_has_unique_priority(&restart_handler_list,
>>> nb));
>>>
>>> As the NTXEC driver doesn't specify a priority, I think this is an issue
>>> to be fixed elsewhere.
>>>
>>> Other than that, it works and looks good, as far as I can tell.
>>>
>>>
>>> For this patch:
>>>
>>> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>>> Tested-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>>
>> Thank you. You have conflicting restart handlers, apparently NTXEC
>> driver should have higher priority than the watchdog driver. It should
>> be a common problem for the watchdog drivers, I will lower watchdog's
>> default priority to fix it.
>>
> 
> The watchdog subsystem already uses "0" as default priority, which was
> intended as priority of last resort for restart handlers. I do not see
> a reason to change that.

Right, I meant that watchdog drivers which use restart handler set the
level to the default 128 [1]. Although, maybe it's a problem only for
i.MX drivers in practice, I'll take a closer look at the other drivers.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/imx2_wdt.c#L318
