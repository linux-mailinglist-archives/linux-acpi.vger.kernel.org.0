Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197F1460A19
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Nov 2021 22:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358141AbhK1VLr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 16:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359340AbhK1VJr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Nov 2021 16:09:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B6C06175D;
        Sun, 28 Nov 2021 13:06:30 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u3so39266904lfl.2;
        Sun, 28 Nov 2021 13:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dBFzSL4UYCAYQqmDupNTSShpvRMUEbaJ9Mx4K7HGHPc=;
        b=oml1oX0ZWjhkzuRjHJtH1XTn55+HCuWM51eukHmTMUsqYvepCYTnsQ8nmJ1fi6Ny8O
         hk+9nsbkv1H426inD0KEeQ2Fx2c/aojT5orC8a1HaRiSAHCfbZ4GibLUq6jXw8umdLa+
         7Npmf61QEFnfrTJUhnvyNQXEcG3o44nwO/yhewKgQ2Tv5+cyXPwRAr9avOHgipiR7uOU
         3lG/X5TvXt9e7Baba1QmnryaUy282ao9aOX5wnj9w2azfGP26R8Qk0MYK0SZQyDuBX5E
         nJWhN9xVkrVnERfId0Z6c0a3FiVVFjBlUiijA64WcIz/4PjWlAuAjWR6TMU93ETZJ9CC
         EpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dBFzSL4UYCAYQqmDupNTSShpvRMUEbaJ9Mx4K7HGHPc=;
        b=Yip37KurCU7ycRoSso/+7kke8bcWLD11iKtrG+Kjn5blL5nUFrrTdSozvjf/WxPYd4
         L6NVXHHG9dUMYKmZx54NC/HMUCGqFnl+vMSMd/Le0JBYHH67tcu8znjmH8D+sE3lNefC
         anrClhUa5BFGT5g1gON7ZUiAYnvqEmNfvuOJvZPAgZtxomHS/Qv9fkMY3J+jpm+lRVgm
         e59Apth/AX8+KMNjMj6K8MP7ImeN65PL4MlbCz1b4091RsuL5imAbd6X/53jPfCB3Cdt
         f0NfWCAeevGBtut++UlgbA2ivxWCwAMlq39IEfldBQiLun5I2Eka7TaibwcrsMqv/yAD
         lWvQ==
X-Gm-Message-State: AOAM531Bgc2V7PBZ5bq9xPXkyUXbX0iUrcapZL1f6QvKNRBR+YnbopFT
        54EqTXB0HhU9/nnkJQGkpfocvZDnzlU=
X-Google-Smtp-Source: ABdhPJw8DbrxRHQUKfkUrzcq3jrRe892hdaQjtTmhQ/Pf+osYN9e0RKllfwyJmy+SLn8xY0V3MlxVg==
X-Received: by 2002:a05:6512:3fa1:: with SMTP id x33mr34004371lfa.676.1638133588639;
        Sun, 28 Nov 2021 13:06:28 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id v2sm1096217lfb.258.2021.11.28.13.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 13:06:28 -0800 (PST)
Subject: Re: [PATCH v4 05/25] reboot: Warn if restart handler has duplicated
 priority
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
 <20211126180101.27818-6-digetx@gmail.com> <YaLNOJTM+lVq+YNS@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <033ddf2a-6223-1a82-ec64-30f17c891f67@gmail.com>
Date:   Mon, 29 Nov 2021 00:06:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaLNOJTM+lVq+YNS@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

28.11.2021 03:28, Michał Mirosław пишет:
> On Fri, Nov 26, 2021 at 09:00:41PM +0300, Dmitry Osipenko wrote:
>> Add sanity check which ensures that there are no two restart handlers
>> registered with the same priority. Normally it's a direct sign of a
>> problem if two handlers use the same priority.
> 
> The patch doesn't ensure the property that there are no duplicated-priority
> entries on the chain.

It's not the exact point of this patch.

> I'd rather see a atomic_notifier_chain_register_unique() that returns
> -EBUSY or something istead of adding an entry with duplicate priority.
> That way it would need only one list traversal unless you want to
> register the duplicate anyway (then you would call the older
> atomic_notifier_chain_register() after reporting the error).

The point of this patch is to warn developers about the problem that
needs to be fixed. We already have such troubling drivers in mainline.

It's not critical to register different handlers with a duplicated
priorities, but such cases really need to be corrected. We shouldn't
break users' machines during transition to the new API, meanwhile
developers should take action of fixing theirs drivers.

> (Or you could return > 0 when a duplicate is registered in
> atomic_notifier_chain_register() if the callers are prepared
> for that. I don't really like this way, though.)

I had a similar thought at some point before and decided that I'm not in
favor of this approach. It's nicer to have a dedicated function that
verifies the uniqueness, IMO.
