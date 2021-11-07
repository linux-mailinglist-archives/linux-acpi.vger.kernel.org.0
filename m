Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799A944744C
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Nov 2021 18:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhKGRLD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 12:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKGRLD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 12:11:03 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F11C061714;
        Sun,  7 Nov 2021 09:08:20 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id o83so23898966oif.4;
        Sun, 07 Nov 2021 09:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tdjg7OFm02RxoZkWdNYUJLWTVIAPxTK8o9TtiXrumos=;
        b=TxOMGGlgYCG6dkxhcHrWleMH5bQzzwXZ9FgwNICO938yYvOADrHCJxaIH+GmktBmdj
         VF/g/5abCbj1SCo77l//+Q8ZaEKZ59DzYbLYNazQAh1d/LI9QSnOgttApF1NrD9BSZdp
         gXEIPq4X5WBftSdrWeIB1XoHAUTyRVaiGJM3hjDVKwLTIaIl/5BV9x60u06nn/MoayP2
         XKdxX9rsONJssDlEkPGWyc5+2eLAU/A93X+4aNShdnC/nVsO9kvbYnMJEh3NiFo/gq2s
         n/ryBqjSn/iug4O0nxdm910/aVIInOrXjz5uU8hb+PebuTd+WVfeeVeSdkkUcfpq82Ph
         3xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tdjg7OFm02RxoZkWdNYUJLWTVIAPxTK8o9TtiXrumos=;
        b=o01CA2rlseTd83pk0rgiOMXUbLLFprEmw+1MveX6GpvI1Nds3bxcPT/GBI+ltPuAXK
         D6RDgsftI3EPC2dDteVwWofyxU8YXSZWYJ9p7Fs9LiWLaqI6XPgN7bxtDN4c204El4MK
         h1AneDhU5p3KP5DzixaMAHS+D8hGxD0nBMH392FtHTW+elojv/akVieWgvtBo9aDSQbd
         l27wDg64145Eb/OcScrhpa2M/xVKtkFwMyW5dVecC2yfl3ghSMnpHNgnRLfBqon1Zecm
         jhr0VLpNgSQKikVeXW/tbHUJzrt5Wtaum2F77EcYT/DX/ByzicDJjYis6PqQVqpzUVmM
         HKmg==
X-Gm-Message-State: AOAM533SWzOG0921x3lAcBf8YQdvQ3S6O1FHIiVG6OzedhqYTFKRJDrQ
        jYfZr5dLFei1vDUwe4fojk79tHIuxKE=
X-Google-Smtp-Source: ABdhPJwtuSZgtmAkEs0Dks9+MnuUhljSkzaFgRaxP+iMBCUUKLEs54Fh1SgZ30w0yfdl8sLFhcnMyg==
X-Received: by 2002:a05:6808:158a:: with SMTP id t10mr3003509oiw.24.1636304899015;
        Sun, 07 Nov 2021 09:08:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i18sm3076850oik.6.2021.11.07.09.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 09:08:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 27/45] mfd: ntxec: Use devm_register_power_handler()
To:     Dmitry Osipenko <digetx@gmail.com>,
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9a22c22d-94b1-f519-27a2-ae0b8bbf6e99@roeck-us.net>
Date:   Sun, 7 Nov 2021 09:08:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <be0c74c6-05a9-cad5-c285-6626d05f8860@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/7/21 8:53 AM, Dmitry Osipenko wrote:
> 06.11.2021 23:54, Jonathan Neuschäfer пишет:
>> Hi,
>>
>> On Thu, Oct 28, 2021 at 12:16:57AM +0300, Dmitry Osipenko wrote:
>>> Use devm_register_power_handler() that replaces global pm_power_off
>>> variable and allows to register multiple power-off handlers. It also
>>> provides restart-handler support, i.e. all in one API.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>
>> When I boot with (most of) this patchset applied, I get the warning at
>> kernel/reboot.c:187:
>>
>> 	/*
>> 	 * Handler must have unique priority. Otherwise call order is
>> 	 * determined by registration order, which is unreliable.
>> 	 */
>> 	WARN_ON(!atomic_notifier_has_unique_priority(&restart_handler_list, nb));
>>
>> As the NTXEC driver doesn't specify a priority, I think this is an issue
>> to be fixed elsewhere.
>>
>> Other than that, it works and looks good, as far as I can tell.
>>
>>
>> For this patch:
>>
>> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
>> Tested-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> Thank you. You have conflicting restart handlers, apparently NTXEC
> driver should have higher priority than the watchdog driver. It should
> be a common problem for the watchdog drivers, I will lower watchdog's
> default priority to fix it.
> 

The watchdog subsystem already uses "0" as default priority, which was
intended as priority of last resort for restart handlers. I do not see
a reason to change that.

Guenter
