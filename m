Return-Path: <linux-acpi+bounces-6260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5D48FFE3D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 10:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B921B239AC
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9415B15F;
	Fri,  7 Jun 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kOSKNW0W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9015B136
	for <linux-acpi@vger.kernel.org>; Fri,  7 Jun 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749891; cv=none; b=kKOl8TMBM58KP1Jd7Thc0DwC59cIZr0SG5QdT5tVxQ6GjLC62wQl1DprD8kNkYvJn/Qg1rmL6qj8VYNP2ey5VgQyQfpXuG6hA5UpZiMw9O1OGVkgzCqQUj/RZI5XXOfZDL10PhcY41R0CJH/MDNUVxYTLyIEZP/fSY4WY6gwZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749891; c=relaxed/simple;
	bh=+6hBIEM5DyxzhidynlmsTx8Qt+LbFMnw7Rl6jR3aSWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WKgFbVsMNRPPqnKPjvLeNJ/yaXGL+2I5WIIpgYn9Jgreg1hh0Fdb7j+v5LpIeyLJuM/3pX8o28lKlSNWUN0N1AKP3YX8kS2LDCX/kZ6B+RKisWHEQ4nvCsmR9wLM7d4dq4Fjb+Br3Mlf/S9zoGDK2TPJ6h38i3QlL1qUh0Jg+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kOSKNW0W; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-250bbae0ff6so821105fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jun 2024 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717749888; x=1718354688; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBhYSibF+a35hxu2YgVd+MGY4jpXCfFZWPQQChFfVoE=;
        b=kOSKNW0WuZplVQ2LUfwSIr//znyUPsshFDZmKwHs68+6AxeUYpWC0vqc6uSG9DHQxl
         ZE8ybDZSroyDg5KXccseFZIKs4Qj/ADuaUl2MeDqNQdvPlur0O9qHTt7Wfl5DVKksjDh
         VRjlsDYzsLqJOaRBRaGwpGrzqRLajEHNprasDVw7FGLMGYGJmiPhdH9qUQ/GPMTMLLzh
         JFUyGIesVQE2if7FJyETRSZjnCmL0zukZKsNkI5FnaEBfodaqZFZIzYPgBsP1MSlJMkD
         wUzoMEOX6XUqdynXVr9mVKEPZMiWxAhXUiruzWR/ZBKpGn/VJjVWfrW7+6lMnZD+5ase
         zmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749888; x=1718354688;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBhYSibF+a35hxu2YgVd+MGY4jpXCfFZWPQQChFfVoE=;
        b=f3e+S8B7YYusIcesymNoUKyH88pbPnr/L4SW4GjoZXBfdXIJEtNx+j/B8vZDYSSnIV
         lJNOAEMnE4mBpSNNJ7m/0jlq6d+87jNpl51Si1wdIE8o/jSrRQ8AdwoZVZg8C1JXVwAK
         dHFm0mSPGNNvPxMqXFH74tEFUPUTHMaKp9ED0YYjmzngSwhJk0WGaNJLXgKzsBIv5atv
         8gbODMbhNEuTHHa9yGIbN0AaDqvhN04XzhoN9eyKNAclkpq2D+CGM8SqF1PRToqDSBLW
         n7h0zv44h5BAh6zLl8UkWmfBKrniMJ0W/x3Xg5d/Pon7mbU0UW98oJqnz22TLb1pboAw
         zomg==
X-Forwarded-Encrypted: i=1; AJvYcCVAprrehepRLCV5J39td2aOIsPmH8+Ux+YDP0H2S5Wygzqbs3Z0KVdPrEKe4NkWVpt0d2hp2Aq/08W6vnbIGoEOhVzgkKVJNBA6pQ==
X-Gm-Message-State: AOJu0Yw7D3Sns4rRMJL5+zZjBkl3EtcyY0vTuR+dLrFRMGfZZt1I0ot3
	KqkC5WJQSAL7wjLgEvpIguA8zYQPe6DpeWdZZRIblMr6xOS/pRmy+B7xfUtPNVLHHR18ljsfuYl
	iuJVaCZMl7VNKthllhnNI/3XhEm72g14iCYOVBA==
X-Google-Smtp-Source: AGHT+IH4QZY+ZKLUXRGchLj2W3aOWavVA61yDoBIwSD9qlh7Awpft0cnk5o+nzwjFobUUAl+CGuWVVoAbw5HqZ8ZVjs=
X-Received: by 2002:a05:6870:1690:b0:24f:c2c8:4d3e with SMTP id
 586e51a60fabf-254402bc340mr2461247fac.3.1717749887788; Fri, 07 Jun 2024
 01:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523111322.19243-1-cuiyunhui@bytedance.com>
 <20240523111322.19243-3-cuiyunhui@bytedance.com> <CAEEQ3wnE+8FXXf76zapqNnC5vruoR9C-y0qjjFw47cHYP57MmQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wnE+8FXXf76zapqNnC5vruoR9C-y0qjjFw47cHYP57MmQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 7 Jun 2024 16:44:36 +0800
Message-ID: <CAEEQ3w==wueTSDvEtJe+t7jamH2ERxta4uPLUFVwX2ueRLJ3Bw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 3/3] RISC-V: Select ACPI PPTT drivers
To: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunilvl,


On Mon, May 27, 2024 at 8:51=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Palmer,
>
> Gentle ping ...
>
> On Thu, May 23, 2024 at 7:13=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > After adding ACPI support to populate_cache_leaves(), RISC-V can build
> > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > configuration.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index f961449ca077..a9ebecd72052 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -14,6 +14,7 @@ config RISCV
> >         def_bool y
> >         select ACPI_GENERIC_GSI if ACPI
> >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > +       select ACPI_PPTT if ACPI
> >         select ARCH_DMA_DEFAULT_COHERENT
> >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRAT=
ION
> >         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> > --
> > 2.20.1
> >
>
> Thanks,
> Yunhui

Could you please review or ack this patchset again? Palmer did not respond.

Link:
https://lore.kernel.org/linux-riscv/20240523111322.19243-3-cuiyunhui@byteda=
nce.com/T/

Thanks,
Yunhui

