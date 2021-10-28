Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A3F43F1C7
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhJ1VfQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 17:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhJ1VfJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 17:35:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229FEC061227;
        Thu, 28 Oct 2021 14:32:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l2so13056363lji.6;
        Thu, 28 Oct 2021 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FNhb8m0Up8WrlODFU5XusWNjgw7FYM5tGcizMhHIPzY=;
        b=USVIOuLFNftY9TSlAv8GQB7acWI1sWWXinRBTyt58drm2RaLh5La11nG4ixMTMewfR
         mX32BgQ2N30EhppM8q0HGzyhqJFMUCJMnblCfs4t5KonQ44KE0wlYv2W8rFYqs4V2koj
         XX371v1ONZUx01vnBeB6kBqd5XtkGxjVTj1e6iP0L3n7qnRFNsZrpRBj/O9TAqf3J13f
         DVFT1FMABW5ltJOUpFKPkQHX+APbXjkM1X+NMw4LCmok7h64fUY8hoIatZpEbYmauo9R
         3tzIe6iUnZRzMnNPnMBZ+KjZo2BGgmZ8KUvvaXZMV9Llm3C259zfQ4YRn+8CQPkkCOFN
         RJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FNhb8m0Up8WrlODFU5XusWNjgw7FYM5tGcizMhHIPzY=;
        b=x1/SikoFEcrTbmPz93P/kN5wRqho0t39OVDAJv+OHPpejl3BDkhaQa+Q9zEimY+lTG
         pkmzIEiDMujGUPeupqDWi3XMPXC96Px1Jxizh+kdbxxNsUO7bOtSnkm7FzjaSeDbR7tF
         al46WibVXIEkI5bzTADQl/TbhehmBadMq/7qTE0YlWDMUetLZYpVygysz6pjV4tE1iIs
         H2Vra42snnaOazZwAVdNz84+0KUKOu/7i+LOsK2rmMd1q04WGPxoXq66L7XX3/eWxPdu
         OXFkwYpBBn8m8whifSIt3NH8bLkW+cFeJQJIABshOqUEDc3smi2IznpVKm0USjFTNCzs
         RRww==
X-Gm-Message-State: AOAM532nyuVTlKEcTJTTLcJNf+3yw3C5RkKuj29rxy1FGshrRdwapLvb
        Zf8n43psf8yToj5DIHTaLofjTTmfMmI=
X-Google-Smtp-Source: ABdhPJwcWGds1J/UVngHunSwfN7ztb9W9OVxlAX827dktWLGe1JrS01AY9nWnDg96vqg3wWMmL+l6Q==
X-Received: by 2002:a2e:9b0e:: with SMTP id u14mr7220400lji.247.1635456760396;
        Thu, 28 Oct 2021 14:32:40 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id bi14sm474384lfb.290.2021.10.28.14.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 14:32:39 -0700 (PDT)
Subject: Re: [PATCH v2 03/45] notifier: Add
 atomic/blocking_notifier_has_unique_priority()
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c5fb7590-03a7-0eea-4040-07472a5c9710@gmail.com>
Date:   Fri, 29 Oct 2021 00:32:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXqCz/utp2DFJJ45@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

28.10.2021 14:00, Andy Shevchenko пишет:
> On Thu, Oct 28, 2021 at 12:16:33AM +0300, Dmitry Osipenko wrote:
>> Add atomic/blocking_notifier_has_unique_priority() helpers which return
>> true if given handler has unique priority.
> 
> ...
> 
>> +/**
>> + *	atomic_notifier_has_unique_priority - Checks whether notifier's priority is unique
>> + *	@nh: Pointer to head of the atomic notifier chain
>> + *	@n: Entry in notifier chain to check
>> + *
>> + *	Checks whether there is another notifier in the chain with the same priority.
>> + *	Must be called in process context.
>> + *
>> + *	Returns true if priority is unique, false otherwise.
> 
> Why this indentation?

This is the same doc-comment style used by this file in general. I
haven't tried to invent anything new.


> ...
> 
>> +	/*
>> +	 * This code gets used during boot-up, when task switching is
>> +	 * not yet working and interrupts must remain disabled.  At
> 
> One space is enough.

This comment is replicated multiple times over this source file. You can
find it before each down_write(). I borrowed the text as-is, for
consistency.
