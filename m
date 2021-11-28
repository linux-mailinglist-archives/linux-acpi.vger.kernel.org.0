Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4A460A78
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Nov 2021 22:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhK1V7T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 16:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241848AbhK1V5T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Nov 2021 16:57:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D1C06175B;
        Sun, 28 Nov 2021 13:54:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n12so39474234lfe.1;
        Sun, 28 Nov 2021 13:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6vgwLT/ouzyM4jlzEumPwuoC7gyZzE5j02z7WHT5gL0=;
        b=Ve2rGzh1LJA0+OcOlbbQ73O4vszbugE425G36NIT/LJkRhFMX190Vmwf9Z1u+DozQy
         nt7KBoHLP6NcqsCJJVf/XMiWi1msgC02rhfjLu8CKl0SI+0RrFvUKjFjlZH7bdfHOiEX
         jvvRM0yX0DY0N616Cr6USUXBiFSTo4izfqBOoNpjwV+G+cH1cFHUwmonpjoWJX8Ppl5i
         8dEUJUKATxCUbOfS4VM/cGGt6HuPu0povTPAj3Y6GTkQG70Ogmn5eg+CfWVBj+3pxNr6
         ReZIvwRQlO/G/fnEj5DP0/liBCD4UXfZ78eAcvQevgGY/DQsBvKDeMEPHSEvbIQ59N2I
         efCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vgwLT/ouzyM4jlzEumPwuoC7gyZzE5j02z7WHT5gL0=;
        b=ziRflBiVwFZSaAlbPoGqY8FhQyG7DXue76KAUNbpCzp4nMTqkCYU7b2DiJZDfOQvyQ
         EUhwthAedPcegzOwaEXIiJaaJhEUY23fwj9KDy+YoXTr74Bc48JRNvRYnqpgGU6O6+De
         UHPApL0vALkrWahTpUFed5miIYZ1EZ0czdjnrt+KIxj17W2dpB7dBtH0GXxzQ9m69d6P
         ueGs1cPS8W2lJUOgKLnCkLYhDsWgpbk/IyqbsO9nmyjhDBO+QScn9VHpALm+BhOilfoM
         CsVFvlJx5bjh8JFqoXh5+QtHh4pl7/jS6iapH3EkI1wCVCbyFurxE9kbNOqxx398eaS6
         E2gg==
X-Gm-Message-State: AOAM532ENsuO63MSlmzo/fR2l4E+yUSca2m46+WlTBJvcHmy+8ulR7BF
        s96nP4NYcsx1KQTvMAunnvNgJ/BTXIU=
X-Google-Smtp-Source: ABdhPJxrac6Czjs8U2D2QGSscJN4jhlYtGpRqd/e7TNYLEXAP/IVggs/yFEWoCFlClXMagpvBwvrwg==
X-Received: by 2002:a05:6512:3c82:: with SMTP id h2mr44786433lfv.128.1638136440658;
        Sun, 28 Nov 2021 13:54:00 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id w15sm1168884ljo.97.2021.11.28.13.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 13:54:00 -0800 (PST)
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
 <9213569e-0f40-0df1-4710-8dab564e12d6@gmail.com>
 <YaPx0kY7poGpwCL9@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1fa2d9d5-f5f6-77f5-adf6-827921acce49@gmail.com>
Date:   Mon, 29 Nov 2021 00:53:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaPx0kY7poGpwCL9@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

29.11.2021 00:17, Michał Mirosław пишет:
>> I'm having trouble with parsing this comment. Could you please try to
>> rephrase it? I don't see how you could check whether power-off handler
>> is available if you'll mix all handlers together.
> If notify_call_chain() would be fixed to return NOTIFY_OK if any call
> returned NOTIFY_OK, then this would be a clear way to gather the
> answer if any of the handlers will attempt the final action (reboot or
> power off).
> 

Could you please show a code snippet that implements your suggestion?
