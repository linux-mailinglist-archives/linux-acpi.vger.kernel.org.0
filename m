Return-Path: <linux-acpi+bounces-6464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C990B1B3
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB021C22CEC
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2531A2C1B;
	Mon, 17 Jun 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM4l80fG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8A19A2AB;
	Mon, 17 Jun 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631274; cv=none; b=p4S/suiOUZ4H8cBlFxvqN49OiI+7KVzY+XYMfUhgFvYxh9ssDnOKsPMhGwC2LMUl0CWi0Qp+U1i6I2eDccJK5FgNRZfxjgiM38JqALgowqlltWhLqpw9ZwFwmjc7U0WcPgd4m+PaMeIRgINx0MHDojJSVkZAwLO9hSZoImFspA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631274; c=relaxed/simple;
	bh=B1S93Pq7+AlrwtbOQxIsMo+PTww/86FdurCQFQ0V7WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHTvVzLf7iKnCN7fXRq/IIfRKPpzrk66IxpH+94p4zEVXkhdNL0ULTzlbVCK8d07tnTDZrH3Ur24n88peR+i4XZm9x0rsZThse4wLnnQPQJaczaQMivd/ejLWLgZz5VhMjYdqZCRjYV7MmZ/km2x4m/6tFwizQj4nYv3Z7fYxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM4l80fG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cc14815c3so272069e87.0;
        Mon, 17 Jun 2024 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718631271; x=1719236071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlh1MuJTyolH8Bza5fsBuYqZhmwiMHDDS1wFAKMhcW4=;
        b=VM4l80fGB9RFdbh+5VV2pwLZwENWZqPeFRsTY9kyrP0jbeyT814MyFksAMOLho2CA9
         mHF4ENsxe1XkStcKd6vRNYsQI4E1sh1cpr3zdzx1ksjZbDZdRKMkwT5vrSFHs5S0a2SW
         6HisXGCKFlyp2KzjQlnUyTMkxD+pbCH/VshYyqE/b44OkJ6QX8IXM+rg5o+kMNNBeW+C
         2tim5PdLCXvOzXDLhEbXrukkX8LNyMU/nYgkF58cMFLsLWM9QpzsJepphorcvoHvNy3/
         Din6DHbVLKxz0G3dGR7yyFaYrER/6lrWfoB/+kBIsCAVJgZf4j0/YiWuqnCK5X3IheWr
         WS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631271; x=1719236071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlh1MuJTyolH8Bza5fsBuYqZhmwiMHDDS1wFAKMhcW4=;
        b=L/JzjIeE6Irr687QOBeX6QGFxV3klkVtuSjeEgGdmroF+FBWWhpkb69LUqg0jnFLrL
         pw6x8AdS29+65CZCStbyEchhmQ+DIm/+A4pawkyWRlwfwKzbX7ESdkybdZ/SvZO/HczW
         EOUWzNN18SiC4J+TOjCyu61PjluGsLVZ3I01ZFA9rmhga2NmLsx2mR470wb5v+LSvJn2
         wtnjrfF1qZgeeXCmw7xekxhMdooyAp0zkpQOVQjbFqU5UlE3eAvf4VdEwh2S7AZbmQa5
         V4Qz3OoPzJrLIQN4fpjIiQfi/lZk18gK4pxCUdfq/a7vVB/+4fdXbiX9ykdNqjcysF6Z
         3dMw==
X-Forwarded-Encrypted: i=1; AJvYcCVCzXVXgvpY+tka1Es2q7rCT6WcfdKWY+vNkVgVPRrsXW0pgcJEtLrkhYx62Uz7lyG67RzI31fJQxTrlvwPnM0yg0q/YUdr1stsDmsWvJ8KlKBrzrxrm4i5pJ4NuRUBPb7PknvkwdIL6w==
X-Gm-Message-State: AOJu0Yy1aX5QGRmnAzHSeCfF+6sDPxMWyiiRXmaIfU2dDQ+RdwLK6vcH
	ji3l/+AJUNan3VIfeiohkwlxe4lCMpSD4V4afoxGI8LW6EZ9QzWTwX4SVSV/XdIWHgBp72vmlZW
	yHV43yhQGqjdGMIBL42ieQ2xlQlw=
X-Google-Smtp-Source: AGHT+IGxoq/R66V25JVO/HBkhcEl96wxiJMXgGXl/k0tPpvsH4sU61K9F58Kdy+baOZ9nLjumpg95HzDP25Dn6D6uvU=
X-Received: by 2002:ac2:5551:0:b0:52c:893c:6c2c with SMTP id
 2adb3069b0e04-52ca6e6e205mr5569411e87.40.1718631270478; Mon, 17 Jun 2024
 06:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718268003.git.haibo1.xu@intel.com> <f1f96377b8ecd6e3183f28abf5c9ac21cb9855ea.1718268003.git.haibo1.xu@intel.com>
In-Reply-To: <f1f96377b8ecd6e3183f28abf5c9ac21cb9855ea.1718268003.git.haibo1.xu@intel.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 17 Jun 2024 21:34:18 +0800
Message-ID: <CAJve8o=8thBhU3NyTaS6sE9rQ1VR_Qf4O8FkAxpmp1q8P-6VaQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ACPI: NUMA: change the ACPI_NUMA to a hidden option
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, arnd@arndb.de, ajones@ventanamicro.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Zhao Ke <ke.zhao@shingroup.cn>, 
	Andy Chiu <andy.chiu@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Robert Richter <rrichter@amd.com>, Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Catalin Marinas @Huacai Chen

Could you please have a look at this patch for the ACPI_NUMA config on
ARM64 and LOONGARCH respectively.

Thanks!

On Thu, Jun 13, 2024 at 4:37=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> would do the same thing, so change it to a hidden option and the
> select statements except for the X86_64_ACPI_NUMA can also go away.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/arm64/Kconfig        | 1 -
>  arch/loongarch/Kconfig    | 1 -
>  drivers/acpi/numa/Kconfig | 5 +----
>  3 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5d91259ee7b5..5079ad4e21a5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1484,7 +1484,6 @@ config HOTPLUG_CPU
>  config NUMA
>         bool "NUMA Memory Allocation and Scheduler Support"
>         select GENERIC_ARCH_NUMA
> -       select ACPI_NUMA if ACPI
>         select OF_NUMA
>         select HAVE_SETUP_PER_CPU_AREA
>         select NEED_PER_CPU_EMBED_FIRST_CHUNK
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e38139c576ee..8d9e06e4ad84 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -470,7 +470,6 @@ config NR_CPUS
>  config NUMA
>         bool "NUMA Support"
>         select SMP
> -       select ACPI_NUMA if ACPI
>         help
>           Say Y to compile the kernel with NUMA (Non-Uniform Memory Acces=
s)
>           support.  This option improves performance on systems with more
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..f33194d1e43f 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -1,9 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ACPI_NUMA
> -       bool "NUMA support"
> -       depends on NUMA
> -       depends on (X86 || ARM64 || LOONGARCH)
> -       default y if ARM64
> +       def_bool NUMA && !X86
>
>  config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
> --
> 2.34.1
>

