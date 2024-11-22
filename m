Return-Path: <linux-acpi+bounces-9764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4829D64EB
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 21:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8981618A0
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922317BB13;
	Fri, 22 Nov 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNH98kde"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352D19BBA
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307648; cv=none; b=ttq/ZjzHkrm6t84zdBCRXBOEYmLrH6bCJ9fN3qYte7YcdeWEDRdfaQi+AVizVuZ4ZQ7MUq8BrQTu31u1u8AFP6+INM/9LRslS+Ec8cS40U+glDqC8AE81Zwsm9hCSkysHjy9AdHGzxMEgrltIgis5QpJkiW5qjceZkTvrSNEMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307648; c=relaxed/simple;
	bh=TcHCg6aN8mkh9HyNHFWkSQK0mjWOBxhwbHsro+MsW9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obB/YbeSmTpBQtI3/TY8aQPRTuayq6dDPBCUP8cbt0mmudofA6ykOeiXxem2k5nT0rbLx7lHhnkZiXHFGffOphKxK6G9Rd4GNb195EgBvcynRqHmfNcx1DKidRUo6r+dCU7HyGpbXWoXKQXLyzYkAkIFcvX2VI/4wDUfO9kC0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNH98kde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF70C4CED2
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732307648;
	bh=TcHCg6aN8mkh9HyNHFWkSQK0mjWOBxhwbHsro+MsW9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PNH98kde2U4k7sWcPZ9YIaMv+tnRyZSc8CpRzqTc0v3Fi0c1xYzlDNqBgclHUe6gu
	 U0tGVF/m8dBOKa5bkseWM3FduuOojhl3z2USAN8/pSwjfPClDkwOs2NViQLFIbLWg3
	 OiDHfNg34qczlG5DSqWxZpWKzhfATuDViBxednrqQeOvstr9yFaM4BO/dpIqh2HiTp
	 0DvoNFV7EpsoE1S6H65/FrU2jiPfrg4jKDEEwBh9NVNiV/ZCXy3ZkeecrpZ7qTzcjd
	 pGhxgUa+4sFH4nWuiyX5DI4xBDQNOKwT6xlSK7Rxx6lUIapqQBZqwVHqZt8H/8bSfS
	 kC6IMmiO65FKA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29645a83b1bso1543284fac.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 12:34:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVys8UqEvQdSTtk7hCJclfulfgRTIvBkS2MEf5+2amTHgqdLula9yhtL2ugZ20dO4UmE3wH58I/DdF3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4di9Zn22yHk/fpVWuSb6FzblMoTE+/uh7yKlmetPhRhZUSmPI
	+tRUMKB9AzZ8GVpK9RvHIacy1bAt5Z6T3tXMJ/MRYURkoiDcP98uhsqKHKHE3jHN/9zWi8mmxqH
	RgmEiRbLZBk5HblK9XsWNgZLwxus=
X-Google-Smtp-Source: AGHT+IGXWpH3f+Kr55W7HkdCqx5mQR/15zrCInu/7hL9xRBP/V3xL9ZNnuFy+ofcmgd6X8E/49jQLyy2xHXJ99+oHj0=
X-Received: by 2002:a05:6870:4192:b0:296:e00e:22e9 with SMTP id
 586e51a60fabf-29720e5f19amr4285335fac.36.1732307647677; Fri, 22 Nov 2024
 12:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-intro-acpi-arch-init-v4-1-b1fb517e7d8b@gmail.com>
In-Reply-To: <20241121-intro-acpi-arch-init-v4-1-b1fb517e7d8b@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Nov 2024 21:33:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmDghrLAx_ZpFS0oK8UAPLE8A2Mzt4yVJG7CtYYy0VUw@mail.gmail.com>
Message-ID: <CAJZ5v0gmDghrLAx_ZpFS0oK8UAPLE8A2Mzt4yVJG7CtYYy0VUw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: introduce acpi_arch_init
To: shankerwangmiao@gmail.com
Cc: Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 3:25=E2=80=AFPM Miao Wang via B4 Relay
<devnull+shankerwangmiao.gmail.com@kernel.org> wrote:
>
> From: Miao Wang <shankerwangmiao@gmail.com>
>
> To avoid arch-specific code in general ACPI initialization flow,
> we introduce a weak symbol acpi_arch_init. Currently, arm64 and
> riscv can utillize this to insert their arch-specific flow. In
> the future, other architectures can also have chance to define
> their own arch-specific acpi initialization process if necessary.
>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
> Changes from v1
> - Change acpi_arch_init from a static inline stub to a weak function
>   according to Haijun Guo's advice
> ---
> Changes from v2:
> - Add __init attribute to the weak acpi_arch_init stub
> - Link to v2: https://lore.kernel.org/r/20240807-intro-acpi-arch-init-v2-=
1-9231e23a7721@gmail.com
> ---
> Changes in v4:
> - Rebased to recent Linus's tree
> - Consolidate acpi_arm_init and acpi_riscv_init into acpi_arch_init
> - Link to v3: https://lore.kernel.org/r/20240808-intro-acpi-arch-init-v3-=
1-ba510859baff@gmail.com
> ---
>  drivers/acpi/arm64/init.c |  2 +-
>  drivers/acpi/bus.c        |  5 +++--
>  drivers/acpi/riscv/init.c |  2 +-
>  include/linux/acpi.h      | 12 +-----------
>  4 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> index d0c8aed90fd16f9a7fe62b8c551c0cd091cb91ec..7a47d8095a7dd5f3dac6e0754=
d6271bf6de269ff 100644
> --- a/drivers/acpi/arm64/init.c
> +++ b/drivers/acpi/arm64/init.c
> @@ -2,7 +2,7 @@
>  #include <linux/acpi.h>
>  #include "init.h"
>
> -void __init acpi_arm_init(void)
> +void __init acpi_arch_init(void)
>  {
>         if (IS_ENABLED(CONFIG_ACPI_AGDI))
>                 acpi_agdi_init();
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 16917dc3ad604cc537d05bb2c0034ff5a9181fd0..058910af82bca689577909e89=
67073ca3198b3c8 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1434,6 +1434,8 @@ static int __init acpi_bus_init(void)
>  struct kobject *acpi_kobj;
>  EXPORT_SYMBOL_GPL(acpi_kobj);
>
> +void __weak __init acpi_arch_init(void) { }
> +
>  static int __init acpi_init(void)
>  {
>         int result;
> @@ -1461,8 +1463,7 @@ static int __init acpi_init(void)
>         acpi_viot_early_init();
>         acpi_hest_init();
>         acpi_ghes_init();
> -       acpi_arm_init();
> -       acpi_riscv_init();
> +       acpi_arch_init();
>         acpi_scan_init();
>         acpi_ec_init();
>         acpi_debugfs_init();
> diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
> index 5ef97905a72759ea2aab3195e56b7ee580eded96..673e4d5dd752719ae7ed0017c=
8b5b1c688cf9b4b 100644
> --- a/drivers/acpi/riscv/init.c
> +++ b/drivers/acpi/riscv/init.c
> @@ -7,7 +7,7 @@
>  #include <linux/acpi.h>
>  #include "init.h"
>
> -void __init acpi_riscv_init(void)
> +void __init acpi_arch_init(void)
>  {
>         riscv_acpi_init_gsi_mapping();
>  }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7dd24acd9ffeedbe47ac392bd939309408c0afa3..05f39fbfa4856d2e6b7d45d95=
80cc82963764d55 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1530,17 +1530,7 @@ static inline int find_acpi_cpu_topology_hetero_id=
(unsigned int cpu)
>  }
>  #endif
>
> -#ifdef CONFIG_ARM64
> -void acpi_arm_init(void);
> -#else
> -static inline void acpi_arm_init(void) { }
> -#endif
> -
> -#ifdef CONFIG_RISCV
> -void acpi_riscv_init(void);
> -#else
> -static inline void acpi_riscv_init(void) { }
> -#endif
> +void acpi_arch_init(void);
>
>  #ifdef CONFIG_ACPI_PCC
>  void acpi_init_pcc(void);
>
> ---

Applied as 6.13-rc material, thanks!

