Return-Path: <linux-acpi+bounces-20124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E54CFD0C59E
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F685301FB40
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A9533D6C7;
	Fri,  9 Jan 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOG59T8j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E39221F13
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994837; cv=none; b=TmIOaMCD1bUcr9Hs0iEylIlP+xu82xLV8u4g54CshRGkL/dEhmy/YEOrNZtfSSwXYhjmi+44H1dma3JGZ1aJ/A18yo5P1Nbp/vJ+SK/4UjharOrq5teX5U7doiUQGPLkQLadS5Wdoqvv0LFmGzSliA67boIUL1bcHmTY0W/Cxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994837; c=relaxed/simple;
	bh=l76+nwsQ1hjzyfDipkzYBdohDEymfXHrQ/fOea2eBis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5NiDzOgMBuF1dITQxzxiEk/wB86Kj94qGvZqJRgpFkb9xqTm7voCRSpHS+1zEwNt1vow0cfLlSxmIDrHZ+uidnaqt89j1h+Vk3TMYXO4XVmLk8hLdNvhlvnBvxu9AQ67Omd2GgemAm4szs4DyNlAHhQ+sm5SnkaA7gvxycc9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOG59T8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E16C19424
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767994837;
	bh=l76+nwsQ1hjzyfDipkzYBdohDEymfXHrQ/fOea2eBis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KOG59T8jaAuI+lZMtT4lTbOCiwtmpBeY089K846wY98BlAJAQH1d1CzXtGEEf1wkt
	 hObso408mR1nkqQcAfZt2SWj5Mt6ofh2SMWmjTft7em29sIHimChe2z4xjgxp6Ksub
	 WIHavFwDBdmHIPeyJH5JJvqNMwN8G4+/Pg6FFwxVsJXSr0rylx5Kvk3HiGeBxyhEfL
	 HFdANOCNyYPuVZ2ypp30gD7ztmX6E/NVKtk8jZU6VbYH+9sCL8scOsoR4chZCP39i/
	 YKeDWktfBbq8ryqzqo05ldEHYEFJyLT0RqLelEsofsQXZStOLedJkKpQeYNEW2Uath
	 5mQvmkp64PgvQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3f11ad6e76fso3893277fac.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 13:40:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVP7s47yH34Py/cCd3Pju5ILBXiSBef5FOWQiPap+CDp7/u+niEFXXAbv5vaL34ey2XGEX6AId2Y8t0@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJH5kzkZ9ODEoS47F/hzvdL5t0c8pQtAcEwKcc2YHMUbLvBRm
	bD8lUvjnaHW70tzwcgTnwYVMiubSnEDar9rJqpOENz5XMAWqiGV4NYqvD1/v+ZoiHyHYF7YZQkB
	tQr+DvvWdj2488gP1MrJKVGQv1Rv9+34=
X-Google-Smtp-Source: AGHT+IHiZ9jBXrj6oECHxIyvj/9s/4714VxtAKP4qs7etwmuJhMYuCipdV7Jt90YVBJVJOHlCd/B0/XH1w+aPqeZ5L8=
X-Received: by 2002:a05:6871:7a0:b0:3f5:4172:27 with SMTP id
 586e51a60fabf-3ffc0bdd564mr6698895fac.56.1767994836352; Fri, 09 Jan 2026
 13:40:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223100914.2407069-1-lihuisong@huawei.com>
 <20251224020532.GAaUtKbE7vA4ian0LU@renoirsky.local> <20260102101801.GAaVebWWUMQyFs_vHI@fat_crate.local>
In-Reply-To: <20260102101801.GAaVebWWUMQyFs_vHI@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 22:40:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ghMqHtLE++Ehm9ag4jNCB18UEzuRxYy+Gu+j1LPtdDyQ@mail.gmail.com>
X-Gm-Features: AQt7F2r8VnzG1d0zsWRtmBEcyXR4G02K_9bxgxEGJHV-uPoebtjV7as0Gb6ulHQ
Message-ID: <CAJZ5v0ghMqHtLE++Ehm9ag4jNCB18UEzuRxYy+Gu+j1LPtdDyQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] ACPI: processor: Recovery some reverted patches
To: Borislav Petkov <bp@alien8.de>, Huisong Li <lihuisong@huawei.com>
Cc: AmandeepKaur.Longia@amd.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 11:18=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Dec 24, 2025 at 03:05:32AM +0100, Borislav Petkov wrote:
> > On Tue, Dec 23, 2025 at 06:09:08PM +0800, Huisong Li wrote:
> > > Huisong Li (4):
> > >   ACPI: processor: idle: Optimize ACPI idle driver registration
> > >   ACPI: processor: Remove unused empty stubs of some functions
> > >   ACPI: processor: idle: Rearrange declarations in header file
> > >   ACPI: processor: Do not expose global variable acpi_idle_driver
> > >
> > > Rafael J. Wysocki (2):
> > >   ACPI: processor: Update cpuidle driver check in
> > >     __acpi_processor_start()
> > >   ACPI: processor: idle: Redefine two functions as void
> > >
> > >  drivers/acpi/processor_driver.c |  13 +++-
> > >  drivers/acpi/processor_idle.c   | 116 +++++++++++++++++++-----------=
--
> > >  include/acpi/processor.h        |  34 ++--------
> > >  3 files changed, 86 insertions(+), 77 deletions(-)
> >
> > I'll run them on the affected machine once I get to it.
>
> Looks good.
>
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Applied as 6.20 material, thanks!

