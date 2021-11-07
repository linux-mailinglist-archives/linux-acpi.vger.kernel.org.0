Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5C4474A9
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Nov 2021 18:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhKGRpX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 12:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhKGRpX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 12:45:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF0C061714;
        Sun,  7 Nov 2021 09:42:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u11so31024580lfs.1;
        Sun, 07 Nov 2021 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yp6jZ6b/7UxZJRYtTwXk1ZheTwTRVWw2YizZoWEGBFY=;
        b=Kz4LsYWHF1VLAkkHNhWuY0M4e42sK4F6sbepl/m1LlUZc7d3ve0+PCaFGV/EW5J0Qp
         q3gOw3u9HDrcvbcy0ihsCdfp4jZucUbKQSHRkLa1MP7e5ywuxBNTRkBRVQjdXS9WYB4a
         75JZ2tni2XNEB9cE2UtRo1WCAu8alZQtGLiKAGmbi/fYYSN/XzQ2AMB855RVvlrPgYwR
         rhnxfzYw0xMwDEQtzpN4vSGSTSGsur7/4vd8RZnKhOdoVQg9OK2TefhJzCLnTq9oEqOU
         +An3rMVrqt5asX/Z17ZvVIT93/IFfnrUb7jTwuCOBo+NhYvWwEU+N1HBtnKoiVp4DFnC
         c3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yp6jZ6b/7UxZJRYtTwXk1ZheTwTRVWw2YizZoWEGBFY=;
        b=M+bMt8VjNyaToWKWZ/AeJsMAP8/qXT+MxdHs1IoYW//TmfYRj1mykH3nJRjQGDfOWq
         sGTnKVBE/fMCREWgTuMFXS9ufZQjyZt8nZABckOMH+mcIeC1J41qafvIGoxUZ5wpX+OW
         Qzbu+dX94CWi7cy7xMNwbAv9M+8lDgbWZcWbBqTOwRpAYCA8mL+wO6fHeSNU4J3jWMUY
         8Xc4L3GUs+JnJa76THceclht4eRg+BoZJGTqjGf2ceX4Kd2zqWX5eVug09OUeQOjTx4E
         Qina0TUnb7BZsc5zbdL1N3V9eiO/+6QSamqFRK5ByI7ZTvtbUjE2Q4Bp8Olui6CkKt7i
         QOoQ==
X-Gm-Message-State: AOAM531SrdkgY4C8GymRN07DLodrtRnfzRmcUloxmwO7SnTavvwnYkVA
        WvA0Yu0Maq0qgMu3qzSx8CUdwtMTbEk=
X-Google-Smtp-Source: ABdhPJxbnSyAP7uVMoABCneWUE/0znULgGMoNtn8dVGgMW1HOHcNNIL0n14F/iW1e4ue0spHO1DEGA==
X-Received: by 2002:ac2:4c55:: with SMTP id o21mr18358331lfk.527.1636306956359;
        Sun, 07 Nov 2021 09:42:36 -0800 (PST)
Received: from [192.168.2.145] (79-139-182-132.dynamic.spd-mgts.ru. [79.139.182.132])
        by smtp.googlemail.com with ESMTPSA id o1sm1351686ljg.130.2021.11.07.09.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 09:42:35 -0800 (PST)
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
 <658cf796-e3b1-f816-1e15-9e9e08b8ade0@gmail.com>
 <5a17fee3-4214-c2b9-abc1-ab9d6071591b@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c0b52994-51f5-806b-b07e-3e70d8217ffc@gmail.com>
Date:   Sun, 7 Nov 2021 20:42:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5a17fee3-4214-c2b9-abc1-ab9d6071591b@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

07.11.2021 20:32, Guenter Roeck пишет:
> On 11/7/21 9:16 AM, Dmitry Osipenko wrote:
>> 07.11.2021 20:08, Guenter Roeck пишет:
>>> On 11/7/21 8:53 AM, Dmitry Osipenko wrote:
>>>> 06.11.2021 23:54, Jonathan Neuschäfer пишет:
>>>>> Hi,
>>>>>
>>>>> On Thu, Oct 28, 2021 at 12:16:57AM +0300, Dmitry Osipenko wrote:
>>>>>> Use devm_register_power_handler() that replaces global pm_power_off
>>>>>> variable and allows to register multiple power-off handlers. It also
>>>>>> provides restart-handler support, i.e. all in one API.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>
>>>>> When I boot with (most of) this patchset applied, I get the warning at
>>>>> kernel/reboot.c:187:
>>>>>
>>>>>      /*
>>>>>       * Handler must have unique priority. Otherwise call order is
>>>>>       * determined by registration order, which is unreliable.
>>>>>       */
>>>>>      WARN_ON(!atomic_notifier_has_unique_priority(&restart_handler_list,
>>>>>
>>>>> nb));
>>>>>
>>>>> As the NTXEC driver doesn't specify a priority, I think this is an
>>>>> issue
>>>>> to be fixed elsewhere.
>>>>>
>>>>> Other than that, it works and looks good, as far as I can tell.
>>>>>
>>>>>
>>>>> For this patch:
>>>>>
>>>>> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>>>>> Tested-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>>>>
>>>> Thank you. You have conflicting restart handlers, apparently NTXEC
>>>> driver should have higher priority than the watchdog driver. It should
>>>> be a common problem for the watchdog drivers, I will lower watchdog's
>>>> default priority to fix it.
>>>>
>>>
>>> The watchdog subsystem already uses "0" as default priority, which was
>>> intended as priority of last resort for restart handlers. I do not see
>>> a reason to change that.
>>
>> Right, I meant that watchdog drivers which use restart handler set the
>> level to the default 128 [1]. Although, maybe it's a problem only for
>> i.MX drivers in practice, I'll take a closer look at the other drivers.
>>
> 
> They don't have to do that. The default is priority 0. It is the decision
> of the driver author to set the watchdog's restart priority. So it is wrong
> to claim that this would be "a common problem for the watchdog drivers",
> because it isn't. Presumably there was a reason for the driver author
> to select the default priority of 128. If there is a platform which has
> a better means to restart the system, it should select a priority of
> 129 or higher instead of affecting _all_ platforms using the imx watchdog
> to reset the system.
> 
> Sure, you can negotiate that with the driver author, but the default should
> really be to change the priority for less affected platforms.

Yes, looks like there is no common problem for watchdog drivers.
Initially I was recalling that watchdog core uses 128 by default and
typed the message without verifying it. I see now that it's incorrect,
my bad.

EC drivers tend to use higher priority in general. Jonathan, could you
please confirm that NTXEC driver is a more preferable restart method
than the watchdog?
