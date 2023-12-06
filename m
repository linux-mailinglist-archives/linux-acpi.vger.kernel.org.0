Return-Path: <linux-acpi+bounces-2188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0299A80796B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99007B20F44
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5674B147
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:35:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88193C6
	for <linux-acpi@vger.kernel.org>; Wed,  6 Dec 2023 12:04:05 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b8bbc9904cso36573b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 06 Dec 2023 12:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893045; x=1702497845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+672n1eIAc4n2NSoBsarq79HoVitsHpGyprVoI2afY=;
        b=Rkc4kHlTvBmyBIQ7Hl4I+yU0SNIIbJxHerCweWZGMBryEEGevkWxJDPl3fc28sTn05
         +u3dobf/yAaHYwHqY2i9LdRyYp+jk04qvq5g1crWdhXHLLgJtTsitm0DiCcIsF2cP+1G
         rC8Nzk/otUp4nR6beBToL/a2SxDALGhXTj5dmPF/DrIy096SlrGGKc95yz2Oa7msUYTH
         1YlpuYtz9S75SDC4tQiMYIZwLaN5AfMWiN3JyxKu77hEyHviEnTRGKYzmZF9YExK5z+R
         Drs4+XjtZo7AFMv8ed1b3IffeebjUvJIpa22bczD1bDz1P292/OHU5pjJprYUKFAJJuD
         W7bQ==
X-Gm-Message-State: AOJu0YzpE0Cy36ene6xrJygJQUqphq9u3kcKLLEq7gjy+OHSQWklQe9+
	z51ko7vRBcSqkG8E2j4bpZ6Yb24NLvLlHfI8tq4=
X-Google-Smtp-Source: AGHT+IHyQoBdsGl38iL+WQd9k264RvlAdK4q2M2A4gD1glbm4OPhpp12sgq88hPtpqqY728ruzFeSqS0Bgcor+5tRug=
X-Received: by 2002:a05:6870:b69a:b0:1fb:9b:3d4c with SMTP id
 cy26-20020a056870b69a00b001fb009b3d4cmr2833811oab.0.1701893043275; Wed, 06
 Dec 2023 12:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hrMy8c_eA+TxBb=gFF5tS147v3wORrQq=YTpuBDp5hKg@mail.gmail.com>
 <20231128025411.141602-1-dmantipov@yandex.ru> <202311301528.EC95F51@keescook>
In-Reply-To: <202311301528.EC95F51@keescook>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 21:03:52 +0100
Message-ID: <CAJZ5v0j+2YN7Vs+euouJ=+HUg+e6s8O0mmqk-vY6WEsci_Ji_A@mail.gmail.com>
Subject: Re: [PATCH] [v2] pnp: acpi: fix fortify warning
To: Kees Cook <keescook@chromium.org>, Dmitry Antipov <dmantipov@yandex.ru>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 12:29=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Nov 28, 2023 at 05:52:10AM +0300, Dmitry Antipov wrote:
> > When compiling with gcc version 14.0.0 20231126 (experimental)
> > and CONFIG_FORTIFY_SOURCE=3Dy, I've noticed the following:
> >
> > In file included from ./include/linux/string.h:295,
> >                  from ./include/linux/bitmap.h:12,
> >                  from ./include/linux/cpumask.h:12,
> >                  from ./arch/x86/include/asm/paravirt.h:17,
> >                  from ./arch/x86/include/asm/cpuid.h:62,
> >                  from ./arch/x86/include/asm/processor.h:19,
> >                  from ./arch/x86/include/asm/cpufeature.h:5,
> >                  from ./arch/x86/include/asm/thread_info.h:53,
> >                  from ./include/linux/thread_info.h:60,
> >                  from ./arch/x86/include/asm/preempt.h:9,
> >                  from ./include/linux/preempt.h:79,
> >                  from ./include/linux/spinlock.h:56,
> >                  from ./include/linux/mmzone.h:8,
> >                  from ./include/linux/gfp.h:7,
> >                  from ./include/linux/slab.h:16,
> >                  from ./include/linux/resource_ext.h:11,
> >                  from ./include/linux/acpi.h:13,
> >                  from drivers/pnp/pnpacpi/rsparser.c:11:
> > In function 'fortify_memcpy_chk',
> >     inlined from 'pnpacpi_parse_allocated_vendor' at drivers/pnp/pnpacp=
i/rsparser.c:158:3,
> >     inlined from 'pnpacpi_allocated_resource' at drivers/pnp/pnpacpi/rs=
parser.c:249:3:
> > ./include/linux/fortify-string.h:588:25: warning: call to '__read_overf=
low2_field'
> > declared with attribute warning: detected read beyond size of field (2n=
d parameter);
> > maybe use struct_group()? [-Wattribute-warning]
> >   588 |                         __read_overflow2_field(q_size_field, si=
ze);
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >
> > According to the comments in include/linux/fortify-string.h, 'memcpy()'=
,
> > 'memmove()' and 'memset()' must not be used beyond individual struct
> > members to ensure that the compiler can enforce protection against
> > buffer overflows, and, IIUC, this also applies to partial copies from
> > the particular member ('vendor->byte_data' in this case). So it should
> > be better (and safer) to do both copies at once (and 'byte_data' of
> > 'struct acpi_resource_vendor_typed' seems to be a good candidate for
> > '__counted_by(byte_length)' as well).
> >
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> > ---
> > v2: prefer sizeof(range) over hardcoded constant (Rafael J. Wysocki)
>
> Yeah, this looks good to me. Thanks for the fix!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied as 6.8 material, thanks!

