Return-Path: <linux-acpi+bounces-1624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DBF7F18B5
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D0282099
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCA81E508
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E139610E;
	Mon, 20 Nov 2023 07:46:58 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58a106dd421so165476eaf.0;
        Mon, 20 Nov 2023 07:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495218; x=1701100018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjSE7oP7NG2cczV9fpstRxmalzuxbmeoxKfXPkfwwRE=;
        b=OO67O2u0QRy5L986+KQCK8sHljYDSrLHkxaYLPlHgUcDHhudtMxqC6ZDx84TIURC1x
         C9X1C/f3H2qE9iJVWfCl+46JTRlQxwar24iofwC0XdGStOxXJIEPSlkZYb0C5Ifeo/1G
         iJ4bvfXfZrMGVyhonACl7dGgGW8Qe/lcvj/tYH0jy+f0S7CHHT/k0j5XlDekvlNAI/ob
         12PO4DJYd+sAYT3LmJseFgcSAsQHrSBpsVjyA8Q1ERvt8Hu4/8Vtb9NrLXBclcWC9O+6
         G8tnuhh0pS3GRQRMhVHH9cFlpb05RLM4zl8sLOsWdotBQu3xzmSnj/YYCaoRtvKD/XWM
         0zrg==
X-Gm-Message-State: AOJu0YxwlEhdwrcrPQaAeX2tpVOUAIKNEOivxIlY9fORosRqYAuejhTa
	GbDgNUHicLNO7ndqeBvJly7grhvMmiaROfBKEvU=
X-Google-Smtp-Source: AGHT+IF0w8dT0dsQcke/RI/ugTr4jkyMaBThGYEFkJM/nDqNjScokn4kspjDiPX/DaycLn0KeXjKH1ZjcAW/f8oWkKw=
X-Received: by 2002:a4a:e783:0:b0:589:daaf:44a1 with SMTP id
 x3-20020a4ae783000000b00589daaf44a1mr7217546oov.0.1700495218082; Mon, 20 Nov
 2023 07:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org> <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
In-Reply-To: <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 16:46:46 +0100
Message-ID: <CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To: Sam Edwards <cfsworks@gmail.com>, Dave Jiang <dave.jiang@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> On 11/13/23 16:08, Linus Walleij wrote:
> > After commit a103f46633fd the kernel stopped compiling for
> > several ARM32 platforms that I am building with a bare metal
> > compiler. Bare metal compilers (arm-none-eabi-) don't
> > define __linux__.
>
> Hi Linus,
>
> I saw the same baremetal-compiler error here on the ARM64 side of the
> fence, and narrowed the problem to the same commit as you.
>
> >
> > This is because the header <acpi/platform/acenv.h> is now
> > in the include path for <linux/irq.h>:
>
> More generally, I think it's because of this addition to linux/acpi.h:
> +#include <linux/fw_table.h>
>
> linux/acpi.h is supposed to ensure _LINUX is defined (if it isn't
> already done by a non-baremetal compiler) before we start pulling in
> ACPICA includes, so that ACPICA knows the platform. But because
> fw_table.h contains:
> #include <linux/acpi.h>
> #include <acpi/acpi.h>
>
> ...the circular include does nothing (linux/acpi.h's include guard stops
> the include before _LINUX is defined) and we end up pulling in
> acpi/acpi.h before we're ready.

Yes, that's the problem AFAICS.  Dave?

What about moving the fw_table.h include in linux/acpi.h below the
mutex.h one, along with the EXPORT_SYMBOL_ACPI_LIB-related
definitions?

BTW, I'm not really sure why fw_table.h needs to include both
linux/acpi.h and acpi/acpi.h, because it should get the latter through
the former anyway.

> >
> >    CC      arch/arm/kernel/irq.o
> >    CC      kernel/sysctl.o
> >    CC      crypto/api.o
> > In file included from ../include/acpi/acpi.h:22,
> >                   from ../include/linux/fw_table.h:29,
> >                   from ../include/linux/acpi.h:18,
> >                   from ../include/linux/irqchip.h:14,
> >                   from ../arch/arm/kernel/irq.c:25:
> > ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target en=
vironment
> >    218 | #error Unknown target environment
> >        |  ^~~~~
> >
> > One solution to make compilation with a bare metal compiler
> > work again is to say the file is used with Linux from within
> > the kernel if __KERNEL__ is defined so I did that.
>
> I am not an ACPI subsystem maintainer, but my understanding is that the
> files in include/acpi/ are copied verbatim from ACPICA, so any change to
> those files will have to be sent to the ACPICA project and wouldn't be
> accepted here.

There are exceptions, but generally you are right.

> More likely, we'd want to do something about the circular-include
> situation between linux/fw_table.h<->linux/acpi.h. That may have further
> consequences down the road than just our problem here. Perhaps just
> dropping both #includes from fw_table.h, and lowering the fw_table.h
> include from within linux/acpi.h to be below <acpi/acpi.h>, is the way
> to go?

Something like that.

