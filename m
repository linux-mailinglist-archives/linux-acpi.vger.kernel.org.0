Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089AD43F260
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 00:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhJ1WMx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 18:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhJ1WMu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 18:12:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE6C061745;
        Thu, 28 Oct 2021 15:10:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d23so11860785ljj.10;
        Thu, 28 Oct 2021 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oJ/0ZuzBVjUo38Wh85+gleqyoNxUo2tupcS3OG//HMk=;
        b=oyp+4ZpoBN8sNbj4o8xY6UXK7DWV+2AXCzvhz53IZDVW7yBXuU0WcYtlG9nrr26Gko
         pspAZNzk5nSawwOoCboqqIBx1NtwU9YP7ClGYgBOs5f5QS+oYjdLS6Chq+lHwnAJsaRE
         aw808EWXPhfWuOImaYWLgQPkx/4+EXGI76qDso1CJ2aKNZ2aChJYUzNXxoU4wlUL2Pxg
         oy7RsSyXKkJJvyMzgbQsMkVQ26q7g1vnPJco9ifX2k6oVsTB9g0J3QdHglNbFRrrT6c8
         P9uyPf++7eB6LV3eSwFOc5BxbfYBVDwZrUUANM1FlvuP72N8IokbXokq1o8sSzQ34LI5
         dsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJ/0ZuzBVjUo38Wh85+gleqyoNxUo2tupcS3OG//HMk=;
        b=MTHRbrM9miWhpDv3S4ohBdxiL0k5FXKagXCD7o2/OXFmkUr3QPxPkFEA/VZtwN0Ors
         IfrKlaFoe9B+8pe/4dMrVPebFb7WPBNqdTv6UeF0komMG6oTitrmMtSARMYQpQX3O67j
         /YwkAgyv1ad7oTCgYYZJ2eD3ApfOnIROAS1tvWhscHbdmmkQI7UOY+BfH8VCAftQMhJg
         ISfYG2Jh1iIh5dao/Ci5sQb0n9PvqVnxcOiBAgUXkiAMSb0/86ih62g5Z33YTWQoOlEg
         z62Q3Vc0BB/02GyGbxtIBRADqYIXr9oMsPiB5N8rV0J9xFd9wYy0xUx9iEFDnVVNrc5D
         186Q==
X-Gm-Message-State: AOAM532y01YfBEk+ZN6Hwrig4x0kKrQqxyF9kOYOpWKMdafzt2PPsDo5
        8lvgoOiDq8KeEJTYS8v4Jei9mOnjyYA=
X-Google-Smtp-Source: ABdhPJykwIAUVmO5wKdpzX+/iWk6pBH4AnIAWbvXPbs4nxxBZpydFbV5fsYhpk8QZgUr9D29NxqkEQ==
X-Received: by 2002:a2e:361a:: with SMTP id d26mr7788286lja.104.1635459020939;
        Thu, 28 Oct 2021 15:10:20 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id x26sm406331ljh.24.2021.10.28.15.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 15:10:20 -0700 (PDT)
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
Message-ID: <ba9d1a3f-c3e4-7060-9859-97014aa633b4@gmail.com>
Date:   Fri, 29 Oct 2021 01:10:18 +0300
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
>> +	while ((*nl) != NULL && (*nl)->priority >= n->priority) {
> ' != NULL' is not needed.
> 

I'll change it in v3, thanks.
