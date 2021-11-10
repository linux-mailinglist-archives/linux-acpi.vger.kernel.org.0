Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1993A44C233
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 14:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKJNlA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 08:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhKJNk7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Nov 2021 08:40:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE8C061766;
        Wed, 10 Nov 2021 05:38:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u11so6136538lfs.1;
        Wed, 10 Nov 2021 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WtBceGsuNkvJWXKObFPMz3/faWDyi74JI/F+pRXLbvs=;
        b=lD15/VjqUInHM3dZidzqbDMtU49DALHBS4Ay1C40nUi5lxcF7BMQ5EnHXXzG4e6Wu9
         KEtaN/+P0k1Njtg3ToWP1/KM8wIXtXfb2GMI1jVOw30JDescBKoGZyWGQkHaeFFMF1Cx
         557WfM+CudsCe0rfY4tn9Qu/fZ6FXK7hdk9Wu9dTaZ71QukQt6Mf26SjkHrJIeq+MupJ
         /vckqogxswS5UmhYqlk9vNHYa1S8ChRuc7OrOB+B+82hPJEZwrpCBIceX5S6KM+5NMWF
         FSm1MYMPHMKiWtHmf2u4gxwpqn+oAaxX8rT7fWDE5HDvTnS5+IytbAjE77fEnTdMp1QG
         4sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WtBceGsuNkvJWXKObFPMz3/faWDyi74JI/F+pRXLbvs=;
        b=dR7RIwju1mPuGWy/xF/xjTUNZDjxCj7/xLYHZ0G4XEgsLYxEjxWiODFMVLchb39Avf
         3PT2MHTzkGrGi0VkpWGh8JBrkkVqXmjWqSKSVyvWcCMiXSGvYEt0sIVmubHV/fSpSCDn
         XcnTjHclx1GUlEfvJUz81b0scOwyGZUoEB3BOBud7SA5LMvReiMMPqRSgtZYYzfs5+kC
         B/tgHbJGdHTstc4S9x+4aCkUlxKwkQQCkgvgyY2KwKqnk4wtJwi1y1sx1dz+OWbAvIIl
         kU6+G5olyje+XVnVW0fELBGXM78/eYCOT44u7snurcXBDph8CIks7m7VABfrstWQQ0cZ
         znzA==
X-Gm-Message-State: AOAM530ZdC16NX6+rQ2X0060vkY8vZzZ1rZjM3h6fLK8seXOLgbpewIz
        S/8sUX6ZWf7JKvuXIGQm32YE88HSLQg=
X-Google-Smtp-Source: ABdhPJxBHb2JNLIS70NEJi27Oqj8IHGODoK0u1oyS1uV5awJ6mpkyMTiHwL65DF0nZiuWJMJYZ6aSw==
X-Received: by 2002:a05:6512:c02:: with SMTP id z2mr14599668lfu.445.1636551490068;
        Wed, 10 Nov 2021 05:38:10 -0800 (PST)
Received: from [192.168.2.145] (79-139-177-117.dynamic.spd-mgts.ru. [79.139.177.117])
        by smtp.googlemail.com with ESMTPSA id z25sm60391lja.99.2021.11.10.05.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 05:38:09 -0800 (PST)
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
 <04103df3-1ef4-b560-a5cb-fa51737d28ad@gmail.com> <YYuia9KFdi+ETT+I@latitude>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ceefc854-5d15-b73c-0135-c1cbbbb473b7@gmail.com>
Date:   Wed, 10 Nov 2021 16:38:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYuia9KFdi+ETT+I@latitude>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

10.11.2021 13:43, Jonathan Neuschäfer пишет:
> On Mon, Nov 08, 2021 at 02:36:42PM +0300, Dmitry Osipenko wrote:
>> 08.11.2021 14:22, Jonathan Neuschäfer пишет:
>>> On Sun, Nov 07, 2021 at 08:42:33PM +0300, Dmitry Osipenko wrote:
>>> [...]
>>>> EC drivers tend to use higher priority in general. Jonathan, could you
>>>> please confirm that NTXEC driver is a more preferable restart method
>>>> than the watchdog?
>>>
>>> Yes. The original firmware uses the NTXEC to restart, and it works well,
>>> so I do think it's preferable.
>>
>> Thank you, then I'll update the NTXEC patch like this:
>>
>> https://github.com/grate-driver/linux/commit/22da3d91f1734d9a0ed036220ad4ea28465af988
> 
> I tested again, but sys_off_handler_reboot called a bogus pointer
> (probably reboot_prepare_cb). I think it was left uninitialized in
> ntxec_probe, which uses devm_kmalloc. I guess we could switch it to
> devm_kzalloc:
> 
> diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> index 1f55dfce14308..30364beb4b1d0 100644
> --- a/drivers/mfd/ntxec.c
> +++ b/drivers/mfd/ntxec.c
> @@ -144,7 +144,7 @@ static int ntxec_probe(struct i2c_client *client)
>  	const struct mfd_cell *subdevs;
>  	size_t n_subdevs;
>  
> -	ec = devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> +	ec = devm_kzalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
>  	if (!ec)
>  		return -ENOMEM;
>  
> 
> 
> With that done, it works flawlessly.

Good catch, thank you! I'll correct this patch and add yours t-b.

