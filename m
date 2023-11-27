Return-Path: <linux-acpi+bounces-1837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC87FABB4
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 21:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CAE281A01
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E873BB2D
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A234BD59
	for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2023 11:02:06 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58787a6583aso160487eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Nov 2023 11:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111726; x=1701716526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdsTl5rWV3utr8k2SOTr1s1vYNkLtM43pdQdoLeN1Fk=;
        b=J3x/NrrCsRB0PlAC8b2l1DGRPv+3aar6MXhPdY/m1y13o7oqQOddRAiIlHrfXKgXTM
         sbBgMi2IGUuWaoOfnhMQQqgtQGCAEumWujPgcJ9xNXXpigId5WiIHs+20Ul+BD/+zICb
         4uts6HAiCd6FRmgeKbPTgTTLX8l7/nQbkilkLsQpSS3yW5NX61g5BUApyYT9XqKLbAB2
         rzgXocZhjDGj4/O1chNqcznktCXhKiaeGfW/B7M+eJb/Obt/tkyrmugBRAwEhJQ3AsR4
         1OA6hXVZVId4PKst3oGMpE0lwBuH3h1cpq+NUMLiTid/ejjNHrJhOCgrmxdd2bKn6o7F
         Xlew==
X-Gm-Message-State: AOJu0YztWqlpQfLuaops8qxTYddOe7LTzvtU8iKS2xjFDATOsdz1JRQg
	9MwrA2qwqn+Dwm5jO/aekP1oL/M9eZLemSPs8zYJASEH
X-Google-Smtp-Source: AGHT+IGN2/gZB0W7FECUzfB8kNhuf33FuIdLJ0Q9TaQlc1oX9LwrBVq5KaS9kVedXpAI5GAyJ64X1KeyAb9GtdNH668=
X-Received: by 2002:a4a:eb86:0:b0:58d:5302:5b18 with SMTP id
 d6-20020a4aeb86000000b0058d53025b18mr7613563ooj.1.1701111725532; Mon, 27 Nov
 2023 11:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127145907.131160-1-dmantipov@yandex.ru>
In-Reply-To: <20231127145907.131160-1-dmantipov@yandex.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Nov 2023 20:01:54 +0100
Message-ID: <CAJZ5v0hrMy8c_eA+TxBb=gFF5tS147v3wORrQq=YTpuBDp5hKg@mail.gmail.com>
Subject: Re: [PATCH] pnp: acpi: fix fortify warning
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 4:00=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> When compiling with gcc version 14.0.0 20231126 (experimental)
> and CONFIG_FORTIFY_SOURCE=3Dy, I've noticed the following:
>
> In file included from ./include/linux/string.h:295,
>                  from ./include/linux/bitmap.h:12,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/paravirt.h:17,
>                  from ./arch/x86/include/asm/cpuid.h:62,
>                  from ./arch/x86/include/asm/processor.h:19,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:9,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/pnp/pnpacpi/rsparser.c:11:
> In function 'fortify_memcpy_chk',
>     inlined from 'pnpacpi_parse_allocated_vendor' at drivers/pnp/pnpacpi/=
rsparser.c:158:3,
>     inlined from 'pnpacpi_allocated_resource' at drivers/pnp/pnpacpi/rspa=
rser.c:249:3:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflo=
w2_field'
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>
> According to the comments in include/linux/fortify-string.h, 'memcpy()',
> 'memmove()' and 'memset()' must not be used beyond individual struct
> members to ensure that the compiler can enforce protection against
> buffer overflows, and, IIUC, this also applies to partial copies from
> the particular member ('vendor->byte_data' in this case). So it should
> be better (and safer) to do both copies at once (and 'byte_data' of
> 'struct acpi_resource_vendor_typed' seems to be a good candidate for
> '__counted_by(byte_length)' as well).
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/pnp/pnpacpi/rsparser.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparse=
r.c
> index 4f05f610391b..af51f893525e 100644
> --- a/drivers/pnp/pnpacpi/rsparser.c
> +++ b/drivers/pnp/pnpacpi/rsparser.c
> @@ -152,12 +152,12 @@ static void pnpacpi_parse_allocated_vendor(struct p=
np_dev *dev,
>                                     struct acpi_resource_vendor_typed *ve=
ndor)
>  {
>         if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
> -               u64 start, length;
> +               struct { u64 start, length; } range;
>
> -               memcpy(&start, vendor->byte_data, sizeof(start));
> -               memcpy(&length, vendor->byte_data + 8, sizeof(length));
> +               memcpy(&range, vendor->byte_data, 16);

sizeof(range) instead of 16 here?

>
> -               pnp_add_mem_resource(dev, start, start + length - 1, 0);
> +               pnp_add_mem_resource(dev, range.start, range.start +
> +                                    range.length - 1, 0);
>         }
>  }
>
> --

