Return-Path: <linux-acpi+bounces-17294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB60B9CE36
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 02:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AB817F50B
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 00:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40227B4E1;
	Thu, 25 Sep 2025 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJwcg9bF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BD849C;
	Thu, 25 Sep 2025 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760030; cv=none; b=aLQCddq7VTdc537w7jE8OnvghjD2fUE4Ysh23nDpTEir9nSevuKnKH0BxOtC351rF3qEAU0dK4sPXTRO5094tq5EWGnp1XjwOweR1fdSrli/72E8+fItR34Z8wvt0R4aM1XN8euraRCzStzMQvNtazw7dwj5BtEXv690pSENuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760030; c=relaxed/simple;
	bh=SCbE9/zMp7eylZtDStOIb2RUlKH9zJzpcDZgJG8aLCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fy8IoU7ria3VGD7Wnfhl3cpvNPDPOexc/kpX2uK8GzCGlYVQvAXQnHaDsZZyrlEw/tMLH2pSOSZEhz7opIMkk9zFLPKkGMdyJVZPEKk3bJQq8gBIBprUQ8zL7LxyEDCTVbA0YChMnOrfP3Cl+kt/c5dZlMMPp0KUhXFOTFfOx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJwcg9bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5326BC4CEE7;
	Thu, 25 Sep 2025 00:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758760029;
	bh=SCbE9/zMp7eylZtDStOIb2RUlKH9zJzpcDZgJG8aLCw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BJwcg9bFpip0s5gqGKUUrRxODmLmubuYf+e39NgHOTqHatgAs3Axi/hHiOJ1cgR+U
	 TukKw2OBmRP2e4AlipJlkzhvkoy8s7zQjuWSqykxMLRMQly55uLdR/TNQWppIzrOkt
	 7laYo/gcAjrgWZBHLmLIa0z4bPcKOxprprqYy4bwXNNVagF4uy6YRqxAwF5rsYux4p
	 VfJB4KXrYkOF2XEtTrPY4ugIo9WLfHfzpzNEjvpJTdjOXeAGG7sPT7o4n4NnYilXiY
	 E3cYFayZuOeBV2Kb9s7dEpfhJHolXIIsc09jPVp9pXQ0YAgmM7OARc7JsrnCKE563k
	 Zo7mTdPWZAH5g==
Date: Wed, 24 Sep 2025 18:27:03 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
cc: Michael Turquette <mturquette@baylibre.com>, 
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
    Len Brown <lenb@kernel.org>, linux-clk@vger.kernel.org, 
    Rahul Pathak <rpathak@ventanamicro.com>
Subject: Re: [PATCH v10 07/24] mailbox: Add RISC-V SBI message proxy (MPXY)
 based mailbox driver
In-Reply-To: <20250818040920.272664-8-apatel@ventanamicro.com>
Message-ID: <405a78ce-de03-382b-cab9-bb086e28505b@kernel.org>
References: <20250818040920.272664-1-apatel@ventanamicro.com> <20250818040920.272664-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Aug 2025, Anup Patel wrote:

> Add a mailbox controller driver for the new SBI message proxy extension
> which is part of the SBI v3.0 specification.
> ---
>  drivers/mailbox/Kconfig               |  11 +
>  drivers/mailbox/Makefile              |   2 +
>  drivers/mailbox/riscv-sbi-mpxy-mbox.c | 994 ++++++++++++++++++++++++++
>  3 files changed, 1007 insertions(+)
>  create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
> 
> diff --git a/drivers/mailbox/riscv-sbi-mpxy-mbox.c b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
> new file mode 100644
> index 000000000000..21404baa6df0
> --- /dev/null
> +++ b/drivers/mailbox/riscv-sbi-mpxy-mbox.c

[ ... ]

> +
> +static int mpxy_mbox_populate_channels(struct mpxy_mbox *mbox)
> +{
> +	u32 i, *channel_ids __free(kfree) = NULL;
> +	struct mpxy_mbox_channel *mchan;
> +	int rc;
> +
> +	/* Find-out of number of channels */
> +	rc = mpxy_get_channel_count(&mbox->channel_count);
> +	if (rc)
> +		return dev_err_probe(mbox->dev, rc, "failed to get number of MPXY channels\n");
> +	if (!mbox->channel_count)
> +		return dev_err_probe(mbox->dev, -ENODEV, "no MPXY channels available\n");
> +
> +	/* Allocate and fetch all channel IDs */
> +	channel_ids = kcalloc(mbox->channel_count, sizeof(*channel_ids), GFP_KERNEL);

Should this be devm_kcalloc() ?


- Paul

