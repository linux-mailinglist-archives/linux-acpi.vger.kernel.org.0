Return-Path: <linux-acpi+bounces-1480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD77EB66F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 19:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2B31C2091F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5926AC3
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj4Due+V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88812C1BB
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 18:09:41 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F019120;
	Tue, 14 Nov 2023 10:09:40 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-359d796abd6so152575ab.0;
        Tue, 14 Nov 2023 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699985379; x=1700590179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxYwdpdF8JJ3J8eR5fcrs9vFQuvJKtKmfDNv9P4y+IA=;
        b=kj4Due+VxC0eBjuUNFu/x5bKCBu4pT7/jcXIlet9Fs3d6NN4YhWg3T4JECIYEkzWz9
         2Tfn78u4wnKTrC2WGn04ubK7eUirYGdTx8U8i5o3SJcw5NN9S57HfPkYd7oiVocTlc4D
         HFf65K7tHPKYabo0v+z8gXWwvcCeMVNPjHIAliCdh3rVfMx0A0MBzighb+yLDbyFr4vo
         oqrUp/S+PcPvvcpcS0obNwItFIh0EikPUTrDsSlEWb6xiVNcQVIaydf1zx/mUnG9ZN9D
         wNe3GL/TKLIXcA7eIalDtya93nKc/hIt3TD/vdlo/XdxexhfLeAnL8pQeMRnv8UWAptj
         hReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985379; x=1700590179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxYwdpdF8JJ3J8eR5fcrs9vFQuvJKtKmfDNv9P4y+IA=;
        b=ZiLR8zzGZPXgAYlTnA+eOTcTBeUE0uV8tlfALwNLxT9k4RU47ywDS7uXUgDaquFqdR
         Hy0w5/StLJutpnrvstJG9rTzLOJd5QAHbA+NMpP/x92wgp2Wqe6XPeDMUmaTNxmymNnS
         QpZQCgYBcX5OUqWWr+/ou+oXmAyjDBqM7Y7G8UPOds6hTduf8X/3jiboXkzlQes6aRhG
         0PRqGmHBXWIHQw2WtcMPNpQ57ahlDJbrZOI+AsHKWIzPVusUgIGOxl0/SXjDyu1DT+2O
         sTBHpci95+/R4MC+jf/I6dX9YhA6jaX9xhVYEw0y90JRsLBqDHAXzfHxYAE7pOupobIt
         Nc7w==
X-Gm-Message-State: AOJu0Yy3Zu6Cay1hcEaecBdn2zYzbH9BcnAGTI09xpUbN9xVZQAwn0lT
	4W1c6CggFjS8vFdYODvpKes=
X-Google-Smtp-Source: AGHT+IFRlkfEouch/0EEOLd8mbYLL0IWatZQFkhv2orilRN+MVYu2ZPc6Aiq2uW+RdzhcoQXU8703A==
X-Received: by 2002:a05:6e02:1b05:b0:359:315c:368b with SMTP id i5-20020a056e021b0500b00359315c368bmr3551685ilv.4.1699985379589;
        Tue, 14 Nov 2023 10:09:39 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:767d:e2ee:ed0:5f02? ([2001:470:42c4:101:767d:e2ee:ed0:5f02])
        by smtp.gmail.com with ESMTPSA id i15-20020a056e021b0f00b0035acf801fe5sm347413ilv.64.2023.11.14.10.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 10:09:39 -0800 (PST)
Message-ID: <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
Date: Tue, 14 Nov 2023 11:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/23 16:08, Linus Walleij wrote:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.

Hi Linus,

I saw the same baremetal-compiler error here on the ARM64 side of the 
fence, and narrowed the problem to the same commit as you.

> 
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:

More generally, I think it's because of this addition to linux/acpi.h:
+#include <linux/fw_table.h>

linux/acpi.h is supposed to ensure _LINUX is defined (if it isn't 
already done by a non-baremetal compiler) before we start pulling in 
ACPICA includes, so that ACPICA knows the platform. But because 
fw_table.h contains:
#include <linux/acpi.h>
#include <acpi/acpi.h>

...the circular include does nothing (linux/acpi.h's include guard stops 
the include before _LINUX is defined) and we end up pulling in 
acpi/acpi.h before we're ready.

> 
>    CC      arch/arm/kernel/irq.o
>    CC      kernel/sysctl.o
>    CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                   from ../include/linux/fw_table.h:29,
>                   from ../include/linux/acpi.h:18,
>                   from ../include/linux/irqchip.h:14,
>                   from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>    218 | #error Unknown target environment
>        |  ^~~~~
> 
> One solution to make compilation with a bare metal compiler
> work again is to say the file is used with Linux from within
> the kernel if __KERNEL__ is defined so I did that.

I am not an ACPI subsystem maintainer, but my understanding is that the 
files in include/acpi/ are copied verbatim from ACPICA, so any change to 
those files will have to be sent to the ACPICA project and wouldn't be 
accepted here.

More likely, we'd want to do something about the circular-include 
situation between linux/fw_table.h<->linux/acpi.h. That may have further 
consequences down the road than just our problem here. Perhaps just 
dropping both #includes from fw_table.h, and lowering the fw_table.h 
include from within linux/acpi.h to be below <acpi/acpi.h>, is the way 
to go?

Kind regards,
Sam

