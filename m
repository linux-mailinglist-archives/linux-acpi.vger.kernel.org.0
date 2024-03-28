Return-Path: <linux-acpi+bounces-4354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D47987E320
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 06:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0355D1C20AA4
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 05:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CEF20DFF;
	Mon, 18 Mar 2024 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="OGv5/0FI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998D200C7
	for <linux-acpi@vger.kernel.org>; Mon, 18 Mar 2024 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740001; cv=none; b=uonsvUDQAUxo+loq+88ASaCtfn6SIRvUnIAeSsIhETochtdozoZP8UIjPVIM+MaQ8QStjOxeVaMMFp+Iz+kuK4LpxPQOz6ArXao2+L5hln2RxkHszI9C2us5ldTJYZQJJsofVBGPMcyBEriFCPC+8iq7h+q1wNNrV9WTBRjG+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740001; c=relaxed/simple;
	bh=D3MlfTcfSnhis8wh58YsJaEgeII+n2TR1pW5NmD7KTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvEGoCVTMaXJwAExEu1l+NztqenQROMHJjB5pe51c0+0DV1kr0vLtNpsKcmJuaDcu4ejFDz0UYOK2P0Y0jM7dcLKsbqln8STkMITAl15vP36kQHb/WkdsSkpRg0x3AkkcQb0yPP16PoWN+3wTUv1tMy4L+RjeXeDLZsF4KpBWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=OGv5/0FI; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c37af44dcbso1393218b6e.3
        for <linux-acpi@vger.kernel.org>; Sun, 17 Mar 2024 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1710739999; x=1711344799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWRZ40BNt+9+ua5/5bnw5+zj2uIfGjzQzzruwRXNga4=;
        b=OGv5/0FIFDqXtrSx4cuc/cPX1IhbcMsw0K+lSX36oNfYUhn+O8NCpAhJBU3SZTPetl
         NiNriImrDO/RZBiSDZrTLre6Yf1cw+dOaMKvTteV4dB5byPOQsFM774K6XS4x3P4udVd
         61MIm5IOl7t+aEBW5t6TEgkqF0yuycN7CXNGHgvei8GAVbH1AzjZaqHmmyM06WeTgEyG
         JuizO6NRkcdrouVkFtnKvW7BZY88EymY93HBVk5bGseuvNzGhIyvH1TbzOSw16VNek27
         4Cqts/csXY3fKHf7txY2w4TkMmO8fkUDUwJO6AXI0tfQKo3vWUu9qLgJ9vhO9D8putzr
         j+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710739999; x=1711344799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWRZ40BNt+9+ua5/5bnw5+zj2uIfGjzQzzruwRXNga4=;
        b=geLVfmqQCtQofF352KU62rbFg+en1v12koEgnZ3bALkO2VTefLn6jhM6zn5ZHvBufQ
         eKxj+PWtwJukVx9SWMVBW25smm2N63KK/4DFR8RHgWdy4Tedu36BUtSgT6qn3foh6dMS
         EbERfldRl0yHitAM3oJfr1IkJ03lkaGSEFnaf8aNeJleqK7Fc/lSFSNKrWLljnelcyyB
         1BMmUa6iCUTrKCDXkFl2fjAI9GEvF8AmgWZ2puqUnDrueGKtsU36pc+hcrEcHyZQKdTS
         hdyR74cDuaJiKMP5oRmwhIRtP94Zqo1mFLLx3s1HH4DmxwITNbaRi3p8J6XmIo8ad6Rj
         Dyqw==
X-Forwarded-Encrypted: i=1; AJvYcCV+eWJ8qNqOWjOMouy2TljQXZSvqRc2/8G7eTiZUnl6OnxNBd1iFJe5xoF4jUfX+eqBX9okrlfyCDHbLNPzU3+syfwK8P8BT+5Eag==
X-Gm-Message-State: AOJu0YzQBdo+wrBC6JUZGcvCum8NtezYnd58BjcPvyISJPrFgoCbIJos
	+YqCzzNQU92Yk7CjBkoe4izE2eNVYpq0cyU1W0Qq+jecUEZVc+QFB4bRJAOYCBE=
X-Google-Smtp-Source: AGHT+IHW74pCefBxgXC9bUaOUNulduaCuiC/cQ7K1s9b2+CZQGbJO8gEmKtgPX/AZbXdvuVHFdeWYw==
X-Received: by 2002:a05:6870:c1d0:b0:21f:dfb9:c150 with SMTP id i16-20020a056870c1d000b0021fdfb9c150mr12627865oad.54.1710739998924;
        Sun, 17 Mar 2024 22:33:18 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:a790:6fd1:40df:32a3:69cf])
        by smtp.gmail.com with ESMTPSA id a26-20020a62e21a000000b006e6ae26625asm6967593pfi.68.2024.03.17.22.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 22:33:18 -0700 (PDT)
Date: Sun, 17 Mar 2024 22:33:15 -0700
From: Drew Fustini <drew@pdp7.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 2/3] ACPI: RISC-V: Add LPI driver
Message-ID: <ZffSG6LKCjkX+/vO@x1>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
 <20240118062930.245937-3-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118062930.245937-3-sunilvl@ventanamicro.com>

On Thu, Jan 18, 2024 at 11:59:29AM +0530, Sunil V L wrote:
> Enable Low Power Idle (LPI) based cpuidle driver for RISC-V platforms.
> It depends on SBI HSM calls for idle state transitions.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/acpi/riscv/Makefile  |  3 +-
>  drivers/acpi/riscv/cpuidle.c | 81 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/riscv/cpuidle.c
> 
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index 8b3b126e0b94..7309d92dd477 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y 	+= rhct.o
> +obj-y					+= rhct.o
> +obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
> diff --git a/drivers/acpi/riscv/cpuidle.c b/drivers/acpi/riscv/cpuidle.c
> new file mode 100644
> index 000000000000..624f9bbdb58c
> --- /dev/null
> +++ b/drivers/acpi/riscv/cpuidle.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024, Ventana Micro Systems Inc
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <acpi/processor.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/cpuidle.h>
> +#include <linux/suspend.h>
> +#include <asm/cpuidle.h>
> +#include <asm/sbi.h>
> +#include <asm/suspend.h>
> +
> +#define RISCV_FFH_LPI_TYPE_MASK	GENMASK_ULL(63, 60)
> +#define RISCV_FFH_LPI_RSVD_MASK	GENMASK_ULL(59, 32)
> +
> +#define RISCV_FFH_LPI_TYPE_SBI	BIT_ULL(60)
> +
> +static int acpi_cpu_init_idle(unsigned int cpu)
> +{
> +	int i;
> +	struct acpi_lpi_state *lpi;
> +	struct acpi_processor *pr = per_cpu(processors, cpu);
> +
> +	if (unlikely(!pr || !pr->flags.has_lpi))
> +		return -EINVAL;
> +
> +	if (!riscv_sbi_hsm_is_supported())
> +		return -ENODEV;
> +
> +	if (pr->power.count <= 1)
> +		return -ENODEV;
> +
> +	for (i = 1; i < pr->power.count; i++) {
> +		u32 state;
> +
> +		lpi = &pr->power.lpi_states[i];
> +
> +		/*
> +		 * Validate Entry Method as per FFH spec.
> +		 * bits[63:60] should be 0x1
> +		 * bits[59:32] should be 0x0
> +		 * bits[31:0] represent a SBI power_state
> +		 */
> +		if (((lpi->address & RISCV_FFH_LPI_TYPE_MASK) != RISCV_FFH_LPI_TYPE_SBI) ||
> +		    (lpi->address & RISCV_FFH_LPI_RSVD_MASK)) {
> +			pr_warn("Invalid LPI entry method %#llx\n", lpi->address);
> +			return -EINVAL;
> +		}
> +
> +		state = lpi->address;

It seems that acpi_lpi_state.address is u64, so shouldn't state be u64
instead of u32?

thanks,
drew

