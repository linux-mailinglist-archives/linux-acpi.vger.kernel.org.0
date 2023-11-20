Return-Path: <linux-acpi+bounces-1628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA37F1CC0
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 19:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B67CB20C71
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD77249FF
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2F1A1;
	Mon, 20 Nov 2023 08:38:44 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1cc28719cb0so8098135ad.0;
        Mon, 20 Nov 2023 08:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498324; x=1701103124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQOioIBEe44MwPtkyvqYFQAPmWMTxr0AHcSiFY3JvEw=;
        b=DnMQudJR3Wr000u/XnmjMYt2A53FuvP8uzDUW823YlkmghXdCM5i1gY/U9Pg21fI6N
         TT4NdHgZVXsMe95I4wZ3Oq5Yj8001scT01LUkPp8xNXK2/yFoilF49kFW8B2qmWFyy3a
         4lWsbES7L4/3vpfzhtCXEGmA29XR2ArwGGXfY2pY+rdI0BBdMxhp5IxJK7iCsNf3SiZU
         TksD4eC5W83vGD+MStab9ROqXvcMaovdq+MmqlTcOzKZTKMZa8OTVTsbUnXUarFseS9b
         c006qR++YBT4FsiXJw3XJlAM6XHQlVteF+TNQvtZvVDf3hyz6LTpSdfklUdWzQKS5pL+
         VarA==
X-Gm-Message-State: AOJu0YzDTui567Q3OQ4E/KKPxu1kiAx6l4uBDubDqsnDnoN9y2C1vHnk
	HtefUtKoHFuss7vviFDUXynf9C4IBIxstB5rXYY=
X-Google-Smtp-Source: AGHT+IHZxZmoC+y3JhyFoImDC8R1QNZWBDz2hZ4XJpcQr4bg8N5VcIMpm08Ag25h8Eor/wZ2zmtn31A4efX9X1F30zY=
X-Received: by 2002:a05:6a20:e125:b0:187:df59:5c43 with SMTP id
 kr37-20020a056a20e12500b00187df595c43mr12459064pzb.2.1700498323819; Mon, 20
 Nov 2023 08:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com> <CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com>
 <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com>
In-Reply-To: <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 17:38:32 +0100
Message-ID: <CAJZ5v0jNOXKv2fHNGUDjDvvg6FGbXuahhH9dBhWiAwiPv3fH8A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sam Edwards <cfsworks@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Dan Williams <dan.j.williams@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 5:19=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 11/20/23 08:46, Rafael J. Wysocki wrote:
> > On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com=
> wrote:
> >>
> >> On 11/13/23 16:08, Linus Walleij wrote:
> >>> After commit a103f46633fd the kernel stopped compiling for
> >>> several ARM32 platforms that I am building with a bare metal
> >>> compiler. Bare metal compilers (arm-none-eabi-) don't
> >>> define __linux__.
> >>
> >> Hi Linus,
> >>
> >> I saw the same baremetal-compiler error here on the ARM64 side of the
> >> fence, and narrowed the problem to the same commit as you.
> >>
> >>>
> >>> This is because the header <acpi/platform/acenv.h> is now
> >>> in the include path for <linux/irq.h>:
> >>
> >> More generally, I think it's because of this addition to linux/acpi.h:
> >> +#include <linux/fw_table.h>
> >>
> >> linux/acpi.h is supposed to ensure _LINUX is defined (if it isn't
> >> already done by a non-baremetal compiler) before we start pulling in
> >> ACPICA includes, so that ACPICA knows the platform. But because
> >> fw_table.h contains:
> >> #include <linux/acpi.h>
> >> #include <acpi/acpi.h>
> >>
> >> ...the circular include does nothing (linux/acpi.h's include guard sto=
ps
> >> the include before _LINUX is defined) and we end up pulling in
> >> acpi/acpi.h before we're ready.
>
> Not including either causes compile errors for me.

Interesting.  What errors do you get if you include linux/acpi.h only?

It should not be necessary to include acpi/acpi.h in addition to
linux/acpi.h, because the latter is expected to include the former.
If it doesn't do that, something is amiss.

> And directly including acpi/acpi.h w/o linux/acpi.h causes triggering the=
 #error and some other stuff:
>
> ./include/acpi/platform/aclinux.h:18:2: error: #error "Please don't inclu=
de <acpi/acpi.h> directly, include <linux/acpi.h> instead."
>    18 | #error "Please don't include <acpi/acpi.h> directly, include <lin=
ux/acpi.h> instead."
>       |  ^~~~~
>
>
> Only including linux/acpi.h:
> In file included from ./include/linux/acpi.h:18,
>                  from init/main.c:30:
> ./include/linux/fw_table.h:32:37: error: field =E2=80=98common=E2=80=99 h=
as incomplete type
>    32 |         struct acpi_subtable_header common;
>       |                                     ^~~~~~
> ./include/linux/fw_table.h:33:36: error: field =E2=80=98hmat=E2=80=99 has=
 incomplete type
>    33 |         struct acpi_hmat_structure hmat;
>       |                                    ^~~~
> ./include/linux/fw_table.h:34:40: error: field =E2=80=98prmt=E2=80=99 has=
 incomplete type
>    34 |         struct acpi_prmt_module_header prmt;
>       |                                        ^~~~
> ./include/linux/fw_table.h:35:33: error: field =E2=80=98cedt=E2=80=99 has=
 incomplete type
>    35 |         struct acpi_cedt_header cedt;
>       |                                 ^~~~
>
>
> >
> > Yes, that's the problem AFAICS.  Dave?
> >
> > What about moving the fw_table.h include in linux/acpi.h below the
> > mutex.h one, along with the EXPORT_SYMBOL_ACPI_LIB-related
> > definitions?
>
> This builds cleanly for me.

OK, so I'm wondering if this also helps the other people in this thread.

