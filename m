Return-Path: <linux-acpi+bounces-6537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E547690FAF2
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABB11F217C3
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B610A3D;
	Thu, 20 Jun 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ac3vsA+J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C712B6C
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846912; cv=none; b=MnilVBdzgunTjU8qu1cFWiLgp8rniQ8bYT5EcFWKS0js8YsUaqwJcFhUghcx2L+OJ4KWZGd7KYaEZVRDnQMiBvVYdXI03+q/jSxTmePEDOpILDTJ8Vc9jT+BW2jVq7wa01PTm0rsp9Wvzvas6KeF+5tkSfswttlh4BMeWGpWRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846912; c=relaxed/simple;
	bh=H6vCEco6jQVwaOX7xUNWdQhOvu/xshILozEhAN0RF6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXvCBXpIO7iC/6k3/cbs/uefoStLYWlHZQES6Ka5YCzvEepzX0nacrj9M/LmvCNjpBL3qOqAtg3juYdqmf1EBl7PET0dMMPKFYZnGhoTslT6N6D6b5TKwzcZnbQWt2BHPDUwSDdJ5PjYrO02D7jsGQvZRkWWqFAGMm1LkuIQOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ac3vsA+J; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7005c84e525so223019a34.3
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718846909; x=1719451709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/ekbBeZLQlbT2zg5ACeIcCnuktUUqjjWBwu4AREAPo=;
        b=Ac3vsA+J4TlIo9yDoKGnepxJthAbJFF0JQm1AEG1fEXrJK/RYhXxYJFd7+CeA4/XJY
         3kgeJHqOHcoqP9spKzmGjCA0PHoI1QNvsm87rSltLoV+1J3UTDZKZ+eeXwBVSdAm/6p+
         6Iju8rQg2atR4hkcBF1Yk0Rtp0gLumoUXq72wjnwl2qV2A/JpKfedhfPjbEdiwVqDUAw
         aAT6FvsB/LTgylH4RgA/+1vASpwkrtVEPw99+FSKm2zLce89HwMxDwAHIPWYP4ACKtYn
         RQDBpoOwtW06vR/krk96mIUP7kYrqNAOUWo4OZYr2nEsU2xs3vZWErbrVHs0jdGPYtCm
         RWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718846909; x=1719451709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/ekbBeZLQlbT2zg5ACeIcCnuktUUqjjWBwu4AREAPo=;
        b=YG5KaoKGBY0ct22NyiYbXTFjGcNRxLTN0wxDEdQfwXLrZFGCznNuJM8y+JEoRmXDzH
         t9CSLw49eaJLUKdyoUNzI8WdgyZ+EzPb/2aE/HN6RqEmOI7Xk0gngC0yCe+4sLdfduJP
         rOZImSONYCCKZoGOHn+9sy2+lQirVOermrCWfajOumIu7A0fYIBaIbXk/dyElbil/IlA
         4+1Gj/2+UmQSzygNSSoAKOT+9IeCRbRHpT305WDIKiN5zNCFCUJ12Xfwc32lOfDRpS18
         FaaHgosYRps8DMQqeoGiH8IzrIXKU4PW0L0bwqhu7xQIGez3BfmnPgSdBNATOUAXd9xQ
         MhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpXXJ814lnCnlfNOqisCDiH9D3E/mXsT2YsMuDQIdO6W0KLp27m6oVcse6SNakEUhy4Y37fC1PKnWMmY5CqmzQrjAK7d95ey7ZrA==
X-Gm-Message-State: AOJu0YxdViEZ2xXbz7QZbuy+tNRorI6SC6j3+8YPj/PXjXds0Q/EKy/M
	hGlOXSSWBcYBCcibrWnJFVBBn1kkFc0D3voo7SUB6ev1DipTmKAm/fNVhzrQ4qG/xkJlGtEFo7J
	1aT/z7NOREQXBXdYbdd0GvgyRPye/Z1oQuv+cxw==
X-Google-Smtp-Source: AGHT+IGBBD4sgjyzChNhQD41x5cYm6++WrkWNpZZqXfJd6go6IeSymufFhAE2wLDdg5D7Zri2qLbf+MT7kpvOJiYs18=
X-Received: by 2002:a05:6870:148d:b0:259:8b2f:8d76 with SMTP id
 586e51a60fabf-25c9498dc84mr4604434fac.20.1718846909622; Wed, 19 Jun 2024
 18:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
 <20240617131425.7526-3-cuiyunhui@bytedance.com> <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>
 <ZnLY3mNxyv9QOmGn@sunil-laptop>
In-Reply-To: <ZnLY3mNxyv9QOmGn@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 20 Jun 2024 09:28:18 +0800
Message-ID: <CAEEQ3wmarOoWWYrdpf7YNQdZG4rf_O4dHkeiO3W1cuavVh8TMQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, 
	pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Wed, Jun 19, 2024 at 9:11=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Wed, Jun 19, 2024 at 07:32:18PM +0800, yunhui cui wrote:
> > Hi Sunil,
> >
> > On Mon, Jun 17, 2024 at 9:14=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > After adding ACPI support to populate_cache_leaves(), RISC-V can buil=
d
> > > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > > configuration.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/riscv/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 9f38a5ecbee3..1b4c310a59fb 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -13,6 +13,7 @@ config 32BIT
> > >  config RISCV
> > >         def_bool y
> > >         select ACPI_GENERIC_GSI if ACPI
> > > +       select ACPI_PPTT if ACPI
> > >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > >         select ARCH_DMA_DEFAULT_COHERENT
> > >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGR=
ATION
> > > --
> > > 2.20.1
> > >
> >
> > Gentle ping.
> >
> Actually, my RB is still valid. Anyway, here again.
>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
>
> Thanks,
> Sunil

Okay, thank you. BTW, when will this patchset be picked up to linux-next?


Thanks,
Yunhui

