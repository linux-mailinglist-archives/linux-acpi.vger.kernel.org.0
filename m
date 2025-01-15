Return-Path: <linux-acpi+bounces-10689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A7AA127D6
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEA51672A5
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05335143725;
	Wed, 15 Jan 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+gAcSQq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7724A7C4;
	Wed, 15 Jan 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956311; cv=none; b=SfuFq69tr89Pq3sRmIXI2pUhT7Eml13yVF3+7kVPbU8ojzec5ibFx93q8/YFCRsilijFgxP/elvjfuNQ5Rguhi8koeW7k1eTSwgvRIi8RaJQHRIrxkjuZ+IRAL8csLpAS5pVdoEvH5S0YtzfC4EXYlGeubk1LLmJgTVRvcFWP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956311; c=relaxed/simple;
	bh=+wl3pQAKYeMXVCQglm4sKNNEwAwTzhLLned1AYx4s0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAlVfTaIzKM4x26LWt9sk6k9Kclck65UsO8JbFJOmvLgSY9LApDFupnm4S2Z8H+VFntRMgoFdWJX0W8zlSZaEQ1tlVq41mHEO5d0vK7WYnisnOvwVktFRZAoqSSiLkAMxFrXsaJGH0se6ndIZiP5hcOVxozkg8YGVaAmq8z16Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+gAcSQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51208C4CED1;
	Wed, 15 Jan 2025 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736956311;
	bh=+wl3pQAKYeMXVCQglm4sKNNEwAwTzhLLned1AYx4s0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f+gAcSQq+PLQ0dLZ9MhStFcr31SGGZC+O9UVAfLpuaRctL1wtBFcgvulw8mBsaZkm
	 n2OfAq1HMYbgl1WetcySPw9xnsAxJeRfvKnbzZ/X2LtFYWX9PIEi+pzMt252/M9tI6
	 XaGZAVCNY10YZURln6mS6djZTqHUyK8uNRc8KdCKLk4gn0jHY0O1rYoKuOAQNVThd5
	 +ZAj2QLr5ELjP6jKuxist7wRJyfJJymdzqWhNaipJxA2KR8YouA8rwRClOefcwvABz
	 3Oor9EoLrrrJyjWY73qVRjle6s3gHw62JGcOM0Z0ywGmcSAzZ1k4z1AzZL3ZxYUweU
	 e1k8dZckexk0Q==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f2e2608681so3460572eaf.1;
        Wed, 15 Jan 2025 07:51:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk+QSujJtMfxVTK6tfuygaLvQh8ZEJBVXWJtSf6jAdPx7IKoIDNwvccMAEcCJSLu94B0RdX5u2EQu8@vger.kernel.org, AJvYcCXEp2akSwF8QwS82Rq+AGSqpT+vNfgnGoUgQSoHKPxIX+pQzp2J+jhjFpvIkcKBMKI6KSpqfwdJmUOL5AVt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CEmhoMwlP1cxMoobcOfkR+KkeymVJ6q/QNjPp8d1FP+rp3nT
	F7rP09/eciXbsYO560TNPU+Q2A1/vCml9CsR2buVM0lW7SSn/HRD+1E82Jcqx5+rGAPVxThdZ47
	BWZEd0VuDYfOkA+pEOB0JTf/6sRU=
X-Google-Smtp-Source: AGHT+IFrDWoratZ+p6B9NLt3569kfgtAy5r4vPZUNzi2d7t+v51Jp+omENv1UlvW8k5RwDihPkxNRms+d5+E4tAawMo=
X-Received: by 2002:a05:6871:3a90:b0:277:caf7:3631 with SMTP id
 586e51a60fabf-2aa065102e4mr18155929fac.5.1736956310686; Wed, 15 Jan 2025
 07:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115123149.3324733-1-tanxiaofei@huawei.com>
In-Reply-To: <20250115123149.3324733-1-tanxiaofei@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 16:51:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWPkmvpPGMO5fbXfrOcAgofML+WQE54cwiwDbaK6vfZw@mail.gmail.com>
X-Gm-Features: AbW1kvb-CJI8bcsiQQyx-Oomqu7mg_i43mKpW7V8iXaxA-i0B2u_GJ2uoa0d0sg
Message-ID: <CAJZ5v0gWPkmvpPGMO5fbXfrOcAgofML+WQE54cwiwDbaK6vfZw@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: Fix HED module initialization order when it is built-in
To: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com, 
	mchehab+huawei@kernel.org, roberto.sassu@huawei.com, shiju.jose@huawei.com, 
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 1:38=E2=80=AFPM Xiaofei Tan <tanxiaofei@huawei.com>=
 wrote:
>
> When the module HED is built-in, the init order is determined by
> Makefile order. That order violates expectations. Because the module
> HED init is behind evged. RAS records can't be handled in the
> special time window that evged has initialized while HED not.
> If the number of such RAS records is more than the APEI HEST error
> source number, the HEST resources could be occupied all, and then
> could affect subsequent RAS error reporting.
>
> If build HED as a module, the problem remains. To solve this problem
> completely, change the ACPI_HED from tristate to bool.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/Kconfig  | 2 +-
>  drivers/acpi/Makefile | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d81b55f5068c..7f10aa38269d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -452,7 +452,7 @@ config ACPI_SBS
>           the modules will be called sbs and sbshc.
>
>  config ACPI_HED
> -       tristate "Hardware Error Device"
> +       bool "Hardware Error Device"
>         help
>           This driver supports the Hardware Error Device (PNP0C33),
>           which is used to report some hardware errors notified via
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 40208a0f5dfb..b50d1baeb71f 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -15,6 +15,13 @@ endif
>
>  obj-$(CONFIG_ACPI)             +=3D tables.o
>
> +#
> +# The hed.o needs to be in front of evged.o to avoid the problem that
> +# RAS errors cannot be handled in the special time window of startup
> +# phase that evged has initialized while hed not.
> +#
> +obj-$(CONFIG_ACPI_HED)         +=3D hed.o
> +

I'm not sure why you are insisting on this Makefile ordering change.

It would be much more robust to run the hed driver init at a different
initcall level than evged.

If there is a problem with this approach, it needs to be mentioned in
the changelog or in the comment above.

>  #
>  # ACPI Core Subsystem (Interpreter)
>  #
> @@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) +=3D ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)     +=3D battery.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbshc.o
>  obj-$(CONFIG_ACPI_SBS)         +=3D sbs.o
> -obj-$(CONFIG_ACPI_HED)         +=3D hed.o
>  obj-$(CONFIG_ACPI_EC_DEBUGFS)  +=3D ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)                +=3D bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)    +=3D cppc_acpi.o
> --

