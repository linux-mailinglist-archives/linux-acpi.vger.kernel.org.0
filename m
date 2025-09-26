Return-Path: <linux-acpi+bounces-17322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC3BA22DD
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 04:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881D11C270C5
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 02:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA723B638;
	Fri, 26 Sep 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VktWaqHH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E317C220;
	Fri, 26 Sep 2025 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758852426; cv=none; b=okcJ7vGG7XXbyJWhxLaaJO6Oop31eMem69GzqEQGydoLnvhRUOtVs6DSB5vd9NTTXZeftUuM1RdhYDfjWtxByk9rknHXL1+w2D9Gtu7/BnKna1ZbHFfPmprQWixPDEA1TTrLIj/IcxEGXa22GUBl04ajJoAa9qOzrHuzIUM1dBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758852426; c=relaxed/simple;
	bh=2YJDK99s0lMvRJGOHiSJOwxLZMxkVYoczRMWoF8baEc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=STfXkZzVDrm6MgdI4mZI+i6kiCunjC+s6XRDHu0RUdMVsXQA61pCHiqHBbR3e1dlmaLaDuRNtELzZ146qhvCei/N/WiGBm96Uyzc5p+Mz9rkk6KYcEpX2+np6PXxBUoU0+Se4iIj1eB1BFpa/p2Hx07zDCvLJrSMEelGfIL5nn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VktWaqHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F46C4CEF0;
	Fri, 26 Sep 2025 02:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758852425;
	bh=2YJDK99s0lMvRJGOHiSJOwxLZMxkVYoczRMWoF8baEc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VktWaqHHYYs86nihTQyoku8q1eGcuuMXhC4UHSJV+//JfmezDua+vtqRiiRV6Mqc4
	 UHjry0UpMkwXw8qX58EgbafwWPFKgTAzhUCud8zlCN6SfxxfJCOJxc9JHMLOTdzL/e
	 9ckLgp9O+6+k+9MZtD+pSI+jncUUpcSL6mODwS8KzWOsGmIiPSKMNJdsnfkbc2Pg3Y
	 NeIzOpY7exAmHlyolxKFPx64f5zFpZ5Qm0wJG6djlhqA48FAa95rNVkYXNWnOODn+d
	 v8ePPOjLn7H/ZlOT6xmIvuj5uAVxs9RVu7hjFgqORzi1kAW19WbmeAGcSvhgrYIMe8
	 wqIOHczzBbfQQ==
Date: Thu, 25 Sep 2025 20:06:59 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Rahul Pathak <rpathak@ventanamicro.com>
cc: Anup Patel <apatel@ventanamicro.com>, 
    Michael Turquette <mturquette@baylibre.com>, 
    Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Bartosz Golaszewski <brgl@bgdev.pl>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, 
    devicetree@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>, 
    Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
    Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, 
    Samuel Holland <samuel.holland@sifive.com>, linux-acpi@vger.kernel.org, 
    Palmer Dabbelt <palmer@dabbelt.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, 
    Len Brown <lenb@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 10/24] clk: Add clock driver for the RISC-V RPMI
 clock service group
In-Reply-To: <20250818040920.272664-11-apatel@ventanamicro.com>
Message-ID: <823e11f3-ba2b-f0ec-8bb9-0785c89e8234@kernel.org>
References: <20250818040920.272664-1-apatel@ventanamicro.com> <20250818040920.272664-11-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Rahul,

On Mon, 18 Aug 2025, Anup Patel wrote:

> From: Rahul Pathak <rpathak@ventanamicro.com>
> 
> The RPMI specification defines a clock service group which can be
> accessed via SBI MPXY extension or dedicated S-mode RPMI transport.
> 
> Add mailbox client based clock driver for the RISC-V RPMI clock
> service group.
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>

a few minor comments:

> diff --git a/drivers/clk/clk-rpmi.c b/drivers/clk/clk-rpmi.c
> new file mode 100644
> index 000000000000..7a0a62456314
> --- /dev/null
> +++ b/drivers/clk/clk-rpmi.c
> @@ -0,0 +1,616 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V MPXY Based Clock Driver
> + *
> + * Copyright (C) 2025 Ventana Micro Systems Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/riscv-rpmi-message.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/wordpart.h>
> +
> +#define RPMI_CLK_DISCRETE_MAX_NUM_RATES		16
> +#define RPMI_CLK_NAME_LEN			16
> +
> +#define to_rpmi_clk(clk)	container_of(clk, struct rpmi_clk, hw)
> +
> +#define rpmi_clkrate_u64(__hi, __lo)	(((u64)(__hi) << 32) | (u32)(__lo))

I'd prefer to see code like this implemented as static inline functions, 
rather than macros.

> +static int rpmi_clk_get_attrs(u32 clkid, struct rpmi_clk *rpmi_clk)
> +{

[ ... ]
> +
> +	format = le32_to_cpu(resp->flags) & 3U;

And similarly, it's best to pull these kinds of magic numbers up into 
appropriately-named macros, to help reviewers understand your intention.

Since we're pretty close to the merge window opening, and the changes are 
minor, I've gone ahead and just made these two changes in the patch, and 
queued it for v6.18 (hopefully).  But maybe you can keep them in mind for 
next time.


thanks,

- Paul

