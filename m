Return-Path: <linux-acpi+bounces-17160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D70B8E1A6
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5D189B224
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 17:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5456E264A9C;
	Sun, 21 Sep 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0OaBZS9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552E2BB1D;
	Sun, 21 Sep 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475508; cv=none; b=XhpxB5cV/UgNF4N94RAF+RA6/M/iC345MQ6W66ytLYQYi3FZ0dvG49dQ6MEscbCRppAaV6b1EvBdgbSfv4Dc2CUiXBIM/JVwNKrSgtc0Y82zXePZgaPModDcYoXbIn0WoAjFiTekhAy/0kzXfKRuHOb5gQTkpCN7NGutUwm8yfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475508; c=relaxed/simple;
	bh=WKwhxvq7jY3OZNVkywwrxdkcffohNo1hcW1y9XvV6Vs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=eQerUoVMSDu8jMOEFJsHFKziabQu20XVat5PdxI79MiloYTcLMOgw+1ZEfQpROonubUFoEErzZbppVuSbSDlSLboJ+2n8NP8C/U1SkzO8OalzYbZszU1byrHVWpuwnaUKH6mTFJwZ2Lo0N90Nnzuv1by0I/1AtSe9muDIN8BZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0OaBZS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849EBC4CEE7;
	Sun, 21 Sep 2025 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758475507;
	bh=WKwhxvq7jY3OZNVkywwrxdkcffohNo1hcW1y9XvV6Vs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=c0OaBZS9yKp9WHcw4ElnO4EXvPtp2u/u8xRmD4tCK1EW5wMuUNxGbK4cSa2LlgBEG
	 ulSLvr8OIZI0BQaKmRvo3SLXtI4meKy6aa4StSY9FJYT1BbOqdcYXPA/dJftS/qOCj
	 YIQ0SiL0lSPD5S6zBIQ/iIk0Rk1wOMdoVPYeu2qzAFOi56IPQ0j7OEDFJCx7W0lncv
	 MwiUF3qwWJ3doA81mqzIm3TgEZsIygvvCyC10ZvycRDExQ2MxrFqZagdGhL0Nxw+ei
	 2KCN4bZ/kyUj3CPCABT06BJEFmyul7Pm8EyGOGnQuEGEkLssa7dEQNJS1JW2oRNEzP
	 dw8mapgNhUOMA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250818040920.272664-9-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com> <20250818040920.272664-9-apatel@ventanamicro.com>
Subject: Re: [PATCH v10 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Anup Patel <apatel@ventanamicro.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Date: Sun, 21 Sep 2025 10:25:06 -0700
Message-ID: <175847550625.4354.7736204929282849019@lazor>
User-Agent: alot/0.11

Quoting Anup Patel (2025-08-17 21:09:04)
> Add device tree bindings for the RPMI clock service group based
> message proxy implemented by the SBI implementation (machine mode
> firmware or hypervisor).
>=20
> The RPMI clock service group is defined by the RISC-V platform
> management interface (RPMI) specification.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

