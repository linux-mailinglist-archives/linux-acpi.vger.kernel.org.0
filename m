Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B646A43F375
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 01:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhJ1Xaq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 19:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhJ1Xap (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 19:30:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AFC061745;
        Thu, 28 Oct 2021 16:28:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c28so16877445lfv.13;
        Thu, 28 Oct 2021 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1ASowQL1SYh3xyvjjnrsnFWzhxhuZ1FkP7TdHa31mE=;
        b=or9I8eXmdc6hOUu3ilMz+ymgHlGQQmwFfcjANI787MFy3461r29Qlx4Drko3A82jiZ
         /Dxbh+rXJkVd+vSmZQz7ByF21FNMWE7Msuh2tmQH7FzEaAaJykw/79BGIIrJtKwboRDm
         04V8OvO+c+XCXlI7f4QRPE7cqx6GZulezk5I+0MnmugoyzWrW9wGp3T/sQ+0YL50opsM
         PEj+17btedXyPtu3l7DUltlj+rCIDD63O2gZoZwfDEKUeboD39P9kLuxM5uqsYcKe9n/
         MuNWRD7sUlbhLEou6B/xsQNLsenMP/929SI9uvSZZXHuqFx/YvhRAZPMrz7X4+YxCerI
         /TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1ASowQL1SYh3xyvjjnrsnFWzhxhuZ1FkP7TdHa31mE=;
        b=cOkqdGeNEuZcAHnpdUXk1+5EmFZRDGpC5tRffGYu/vF24A+jKJL7M9mnRkN7nhE4Y/
         LlIOgzW7RGRIJLf6h/kSoUNlwyZ7r+bA3TrLtwBqHtuMzlXD/f4ggUxwqYZRPJpIHsIb
         HuGEwaz/RCE2Gy2MXOoZ2zktFpQ5HhPFbSh1cbImIdWP/A+HLdqoy5buIrsEyfkUkJKZ
         2tHzxnOJ/HcMzTARcchnIxOCgLkWturaRU9Za11tsOnWz0gkufF/9iFPnwYjiT0RUJa0
         aZJ8hVZGX/ODzwg7U52cNmRwEUG18a+RScItWUvS/hh1vxdhHaTsYpYo/cRUMnMWPcmr
         YeFg==
X-Gm-Message-State: AOAM533VU1mbUz4A00epD7HQENnplQUD31uOpugw3cw/JurTbdWCBjVV
        F8WtTJ0H/i4piMeiXBS1RTNW4VX7J48=
X-Google-Smtp-Source: ABdhPJwV2hV4le461ll7P/MiVtzPzva4GF7PaVejAVvhmYPc9uewsxLl7FIVcxk+rSnnrtvlDg/jfg==
X-Received: by 2002:a19:760a:: with SMTP id c10mr6627861lff.302.1635463695803;
        Thu, 28 Oct 2021 16:28:15 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id bn3sm414682ljb.7.2021.10.28.16.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 16:28:15 -0700 (PDT)
Subject: Re: [PATCH v2 03/45] notifier: Add
 atomic/blocking_notifier_has_unique_priority()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
 <20211027211715.12671-4-digetx@gmail.com>
 <YXqCz/utp2DFJJ45@smile.fi.intel.com>
 <c5fb7590-03a7-0eea-4040-07472a5c9710@gmail.com>
Message-ID: <8a9c4a9a-ea0d-4bc9-cf57-9bd99b211d47@gmail.com>
Date:   Fri, 29 Oct 2021 02:28:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c5fb7590-03a7-0eea-4040-07472a5c9710@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

29.10.2021 00:32, Dmitry Osipenko пишет:
>>> +	/*
>>> +	 * This code gets used during boot-up, when task switching is
>>> +	 * not yet working and interrupts must remain disabled.  At
>> One space is enough.
> This comment is replicated multiple times over this source file. You can
> find it before each down_write(). I borrowed the text as-is, for
> consistency.

Actually, it should be down_read() here since there are no writes. I'll
correct it in v3.
