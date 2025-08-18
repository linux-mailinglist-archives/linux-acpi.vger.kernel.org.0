Return-Path: <linux-acpi+bounces-15808-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D53B2ADD6
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8953B33D7
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BD32A3D9;
	Mon, 18 Aug 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ6eMRyh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D7322546;
	Mon, 18 Aug 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533502; cv=none; b=BWWaCyZKtBch5PVhwlHBmyLGtJMx+NEv9Crjtvlx8mW9VYkiRdcizHgl7n3Q+28gzzEh8wuZ+g8ZNLLYnwAt8goKsVYg/uHCs3wBHNblrcfHmg8aaQhKg0MzPin9gPRbVahnZwj59K9CZ9ppfAaciTUWX3NROysjmlWDCTK8yj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533502; c=relaxed/simple;
	bh=DA2OL45OCBR1TJ2bykT55Ml1phhesDr/KzBENSzRPoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdSSD1OJilFwYPbMqFDyam7jzhZcz8DhP2aUncl8QMJn5dqbBNnKUkBcXtfGBzEsRiq5yppnfMWN1y+LQHxKHmm7wyzoWgd0zeqn2da0+CWUL+w0j2g8XYkVE6gUHE+OzcdHIrKFX0h6FjeMPfAn1IN7c1hE760XfvJTi7ytEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ6eMRyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9996DC4AF09;
	Mon, 18 Aug 2025 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755533501;
	bh=DA2OL45OCBR1TJ2bykT55Ml1phhesDr/KzBENSzRPoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nQ6eMRyhcJaRYj88m0OBCu19k0BuZR6ddgKbe1p6UefKyG2ibNz8uATq5a9qstqD4
	 9ILu9m/QvrqsNHFfJ/RKUSWj9c5xJI0Tvf44+45iL414sq2TBRzXMhmpShqSQn1Eqd
	 0gplahw+vYZJiGfnReKptDmtltfP/9eAlNf3yY3QmNo77lqASeeFHmHexB4eU57fxS
	 pWZ+1qZyX74ee5ybVdLw6z773fOSm0oSdOLyQRlfeJxl1kDL5c2RHIdi3VgVAfx7Rk
	 ZirpEDrCpX/TFptiSg3RzjAq4dqUui5dfZzMg9A1Bj4tBi9Ylneq8K6xcpHG7PHDtZ
	 eK4MnvlbEfBdQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3110269717aso193974fac.1;
        Mon, 18 Aug 2025 09:11:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+HBMjiUjU/BjH2lxihE2w3GXA6dTfgOvFli9R1DTKb83H9QuPJEHCIRK8evIuwglhePY/qviADnHtIpuI@vger.kernel.org, AJvYcCVsxqBLOWAyTuo7AdwJUWpxcTYkZxLxcl4gAUJCMQSMmVVCQCUDiru+dw/Iwshn3HnE6WaV3C0xz5Xu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywykel/XDCZoBrdEcXX8B8UH5bZ1+XaGJ9cXZJ5SV7U+9YrHYlD
	d/JFV1JF5KQKM4+jl5YgJc+DYRasv001oDbA49Fhea9kEPH7DsLlPy7TvcZlsKauaDkU2woEnBZ
	hrxEGvdbc8hUwQHqUf4Ftl2bsQ8JYkhc=
X-Google-Smtp-Source: AGHT+IGRp9f0ioUBjySVzfXidVBa+XHyCZfz8f8VuFeDGWT+KV57H8QNmIA3QWX4Ufn7LrA+hEC1Rjs7o0cf48peGh0=
X-Received: by 2002:a05:6870:1f19:b0:2e9:925b:206f with SMTP id
 586e51a60fabf-3110842a516mr89866fac.17.1755533500977; Mon, 18 Aug 2025
 09:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815024207.3038-1-hanchunchao@inspur.com> <547301a8-5a66-7958-15be-0bcf01dd8a62@huawei.com>
In-Reply-To: <547301a8-5a66-7958-15be-0bcf01dd8a62@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Aug 2025 18:11:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTc+F8AX_sOY_79A9AeTJMe+QiCdK9ZTSwJ8fi4djB=Q@mail.gmail.com>
X-Gm-Features: Ac12FXwNWiT8VzzqS9Kmb7N0NYAwTVvby8mVUV2dCdK4l0REuhuU_SXYD5Nmzz8
Message-ID: <CAJZ5v0iTc+F8AX_sOY_79A9AeTJMe+QiCdK9ZTSwJ8fi4djB=Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: fix potential NULL dereference in __einj_error_inject
To: Hanjun Guo <guohanjun@huawei.com>, tony.luck@intel.com, 
	Charles Han <hanchunchao@inspur.com>
Cc: bp@alien8.de, mchehab@kernel.org, xueshuai@linux.alibaba.com, 
	lenb@kernel.org, ira.weiny@intel.com, zaidal@os.amperecomputing.com, 
	Jonathan.Cameron@huawei.com, colin.i.king@gmail.com, dan.carpenter@linaro.org, 
	dan.j.williams@intel.com, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:07=E2=80=AFPM Hanjun Guo <guohanjun@huawei.com> w=
rote:
>
> On 2025/8/15 10:42, Charles Han wrote:
> > The __einj_error_inject() function allocates memory via kmalloc()
> > without checking for allocation failure, which could lead to a
> > NULL pointer dereference.
> >
> > Return -ENOMEM in case allocation fails.
> >
> > Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections"=
)
> > Signed-off-by: Charles Han <hanchunchao@inspur.com>
> > ---
> >   drivers/acpi/apei/einj-core.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-cor=
e.c
> > index bf8dc92a373a..93a3ae1325e5 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -540,6 +540,9 @@ static int __einj_error_inject(u32 type, u32 flags,=
 u64 param1, u64 param2,
> >               struct set_error_type_with_address *v5param;
> >
> >               v5param =3D kmalloc(v5param_size, GFP_KERNEL);
> > +             if (!v5param)
> > +                     return -ENOMEM;
> > +
> >               memcpy_fromio(v5param, einj_param, v5param_size);
> >               v5param->type =3D type;
> >               if (type & ACPI5_VENDOR_BIT) {
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Applied as 6.17-rc material, thanks!

