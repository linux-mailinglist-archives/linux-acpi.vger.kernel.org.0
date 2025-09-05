Return-Path: <linux-acpi+bounces-16436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E98B4640F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 22:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9138918935E1
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 20:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD9A28688D;
	Fri,  5 Sep 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiMxoYIZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB9E55A;
	Fri,  5 Sep 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102400; cv=none; b=B77kCY4lXT+PmHibQZbmFL4HzrvyZYDPlDGdV9NcNPHoILpAaEaor9+mPqMldFU166fMpGr4IM4jisxkHhT5qkYG18jjpaXYCG7uHOAoOreTTo9QxSUQo6Q3Ec8zY2Ipp67SZ8/cGVBvedgWfEjUsNDBagyT5eT10SY5TDrPwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102400; c=relaxed/simple;
	bh=x8C9UPRUTrxc5Zi/nWhEszlpqQauRha+3DiPVlkNX60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC5GVQoiUImQN1PtDqNhJ+xyMLxv5dw/CD/j+NKpr+GZ5vu+TyJUeU6vB9S5BcQjMReHyrITCRwuM4uIOk0qHLIWQjeZRvPiTdWry1LbqF/e7hj8X3Pz73Hj1JZrWjVhuXctMYeVcg+QzhiI/tcxhT3J7FSQ8Ig4b1XJw8k/3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiMxoYIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861C9C4CEF1;
	Fri,  5 Sep 2025 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757102399;
	bh=x8C9UPRUTrxc5Zi/nWhEszlpqQauRha+3DiPVlkNX60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OiMxoYIZraq0tecJwIwA21CxGFvz+Oj0W+RTz2vpNJEjDtG41SweS0zW/NtOWq5yM
	 Ve1xSKe8zlECyYUpvz+SFfHeD8ko3Ktca4rsnEc1VmasrLZYzXhDLBUAEQqdrKagbQ
	 YyfJ2WISqV2UgHDjjsM319VYSyFQIixUyPyTErU8Dpox87t6pekFlyvVrX2hIBPBhr
	 l9FGnTvXRgPT5Tp9qagF/FcE6+jtIJYJPe8coPE84X70dw4lHPRGJ8GXNdWOoyxR2L
	 xPbUBwV2c//TystUHHhCh+m84opYRifbLmlcu5IIPfE77+Fks9IgCNLKtx1updmC1h
	 Otq34xVBp5jSQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61e74d0539bso594254eaf.3;
        Fri, 05 Sep 2025 12:59:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFDM74oN7wd8dEnqGP6Iu9g0A8aRK2TqRlVmyNmOaF8yCknsmyt1vgAbuRyWfavqWCuxD2CWi5xgr81B/G@vger.kernel.org, AJvYcCWxotvy9titq6T9jTLq8Hxcau2G8oiySqYeEP/+4zi8ujhQ1HqghOCIcm+8TZbgHXJstV9lib54vBND@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXz3J41S8oE60Rj+c+OD8UdV0JrAdIYKf+2Y73gBnakyqhScs
	FwjWowzqq8vVY8FSc+jhFuhkZrzIEzIE8AfSfVTfDFqFNG5riIRkQ+4ZxTxHMrmmScHFr77ApIL
	xUx2Mx8cxcANUof8YSsqB8rhAicCwJaE=
X-Google-Smtp-Source: AGHT+IHxYs7t0rPDMyWdriWgin9NPgra5z5LHbs8LRF3dZIItii2l45oU1aqQvKuBW+v+t5/xuHux7EyCOC6s4c2amo=
X-Received: by 2002:a05:6820:1609:b0:621:7234:99ce with SMTP id
 006d021491bc7-6217234a05fmr1070099eaf.8.1757102398897; Fri, 05 Sep 2025
 12:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905081900.663869-1-lihuisong@huawei.com> <20250905081900.663869-2-lihuisong@huawei.com>
In-Reply-To: <20250905081900.663869-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 21:59:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joTcDG86wroXG=a5jdCiKLGBdQ21XVNcNp==SBx77L8w@mail.gmail.com>
X-Gm-Features: Ac12FXy3qntI9chim3iHXKgZEGhmRw_JXdeMTe5HZ_F0_r3qFS0IVoLhMfwdN8Q
Message-ID: <CAJZ5v0joTcDG86wroXG=a5jdCiKLGBdQ21XVNcNp==SBx77L8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: Fix function defined but not used warning
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:19=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> If CONFIG_ACPI_PROCESSOR=3Dn and CONFIG_ACPI_PROCESSOR_IDLE=3Dn, we may
> encounter some compling warnings as the following link said.
> The acpi_processor_register/unregister_idle_driver() would not be
> used when CONFIG_ACPI_PROCESSOR_IDLE is n. So remove these empty
> function definition.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508300519.tZQHY6HA-lkp@i=
ntel.com/
> Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver re=
gistration")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  include/acpi/processor.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 360b673f05e5..ff864c1cee3a 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -445,12 +445,6 @@ static inline int acpi_processor_hotplug(struct acpi=
_processor *pr)
>  {
>         return -ENODEV;
>  }
> -static inline void acpi_processor_register_idle_driver(void)
> -{
> -}
> -static inline void acpi_processor_unregister_idle_driver(void)
> -{
> -}
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>
>  /* in processor_thermal.c */
> --

Applied (with a rewritten changelog) as 6.18 material, thanks!

