Return-Path: <linux-acpi+bounces-15451-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420AB17612
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0553A9AB2
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11F2C1592;
	Thu, 31 Jul 2025 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh77aC3B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C8239E91
	for <linux-acpi@vger.kernel.org>; Thu, 31 Jul 2025 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985891; cv=none; b=CQMEOUyiWxQqq0rqHLDw7kbRpjNfB+B64L5ka5pDpcFOEp1scCcvSn3+tAHpwFpZ66hCAJ/gzqLS5VCd2IOCoYGqstunqaOnQD4Ws1Q2qotffpow65j3P+WtWarGY/n0f6fH1y9/dFp+Lc5KwHZJLZPu26bUETG98ZUsmjCOSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985891; c=relaxed/simple;
	bh=2cLq6ukYlaFpgGQBtKOou69OVdEUdYfHbEKfkg++xcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cj26ZmInkuQOZhnWjg05gt48vfEM12zNcyDZC0P2omjViGsP7O1d0qlR2y/QXMOFfgU7HRZNeqjlqndckVAOO1DwXzGMgQkqcTPhojmTDPj5tR35mtDY6VJhcd7ruzf9QDlsiu/tFY5YouQlq/03069e8Pk6Mjtc+O0WoHAwQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh77aC3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979F1C4CEFE;
	Thu, 31 Jul 2025 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753985889;
	bh=2cLq6ukYlaFpgGQBtKOou69OVdEUdYfHbEKfkg++xcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hh77aC3BVVgvZ/0eUIH95b7LMb+StQr0x8xMg9K0rC10cjy9vJdM9ifdt8QEJQBlY
	 54a/f1XwxZcsLX0TbkU9KBRpkZ04X2ppFibxzZEsmdZwY9KCy0QTJJlMNjZNBh0b6e
	 DMdnBn9OYW6C/pNhdZJXAEZaPo7HWKEfwqOSB7FH+99EXZ/8YKWkRn+VF3j3x9UTvT
	 gjw1NOTSS/2l3CbGkeh/6kofdoH26oN6+BLHUGY08NtmPpnoNwgiOW+RY2Wkivb/pK
	 jCNSTBYO6qypl/eV7LNRhvJOaUH7sS+zLYpwh3GdwqJTeVMj9DtNaMFGqOgEBMb8Bp
	 w/KHCG7aa5bAg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61594007beeso10202eaf.3;
        Thu, 31 Jul 2025 11:18:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRS0P4c8WN6XAO+JP3QnfhCnHAash3S6A3DAtLmYw6NW3IWIy/xhMCC33jEJRkIkzUHA8WufUJmLr6xw==@vger.kernel.org, AJvYcCXSflwxg+WFu+SJRSJX+oqZoAKi4kXK321ZXTy5mipcnYbuKQDSR4phgoJ+5MMVjDg2bfa/6tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcc69Iw8iQGkmR5LtxrILeQAINIT2Fg8jtUquq0+mAKPQ4zpSK
	ythbOoevqnU2y2fXcEec72/zhsvMXcSENzuDTX5gkbuMx3efbW3xwZZzFU8A2rjTcoHiesudr0X
	ptxNXLkjtl4mNIvqP8ZDWShsgf20yoIA=
X-Google-Smtp-Source: AGHT+IFPUom2p903mHPUTDU4ONASdutryjcvQHiJdb35lmiGjDZYxh6K4+M78CRYbhmxfLP+Nmr9+TUYV8a6Mz74FWQ=
X-Received: by 2002:a05:6820:152a:b0:619:7ffe:b0c6 with SMTP id
 006d021491bc7-6197ffec3e6mr554355eaf.8.1753985888743; Thu, 31 Jul 2025
 11:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
 <20250729131535.522205-3-heinrich.schuchardt@canonical.com> <84a22949-88e7-4a6c-b14e-e8448724b034@ghiti.fr>
In-Reply-To: <84a22949-88e7-4a6c-b14e-e8448724b034@ghiti.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 31 Jul 2025 20:17:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hvaw=m8zPDJn0vPvw5RBxUsRzyvjHPiganPkxHGCisRw@mail.gmail.com>
X-Gm-Features: Ac12FXxSy76Neb_YIdL32z9WvuqzYoazaALdgfoMCCtIkVT-a0GD5NPPLdPSJv0
Message-ID: <CAJZ5v0hvaw=m8zPDJn0vPvw5RBxUsRzyvjHPiganPkxHGCisRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: support BGRT table on RISC-V
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kernel@vger.kernel.org, 
	Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 3:13=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Heinrich,
>
> On 7/29/25 15:15, Heinrich Schuchardt wrote:
> > The BGRT table is used to display a vendor logo in the boot process.
> > There is no good reason why RISC-V should not support it.
> >
> > Remove the architecture constraint.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >   drivers/acpi/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index 7bc40c2735ac0..2b83c91bb1a78 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -460,7 +460,7 @@ config ACPI_HED
> >
> >   config ACPI_BGRT
> >       bool "Boottime Graphics Resource Table support"
> > -     depends on EFI && (X86 || ARM64 || LOONGARCH)
> > +     depends on EFI
> >       help
> >         This driver adds support for exposing the ACPI Boottime Graphic=
s
> >         Resource Table, which allows the operating system to obtain
>
>
> @Rafael: If you ack this patch, I can merge that for 6.17 as I haven't
> sent my PR yet, just let me know!

There you go:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

