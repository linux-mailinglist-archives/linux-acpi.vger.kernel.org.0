Return-Path: <linux-acpi+bounces-15325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72EFB12DE1
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Jul 2025 08:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EE91742C8
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Jul 2025 06:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8F1A23AC;
	Sun, 27 Jul 2025 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWhjhQ6K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216680BEC;
	Sun, 27 Jul 2025 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753597397; cv=none; b=PwmrsakhrrzYZr1v2GsujI2j0KSTM4Ws273Tov8H9sJdHKpuJv8FPBNzKb7FpVHRy8YfMPzGJ/uUoX1tj+TkEMqKY4fscfomf6SUGd53hJeCxYLbuTllHvlVTIgW06ErWja52lG+HaKKwWtnqEUf+MhkfCsPaMyhFIVdm1LYLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753597397; c=relaxed/simple;
	bh=oJXTL/Zk785tlpPm70/cIQWrdlgSqqCiqp958NXEF5M=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=P26EQ3N+S1CUPuNQYjuuKPo7Z05ewgdPyGQOXyGG3fZEA5EwUWoqs1EYuituCyMVjN9l0bA4X6kCQt94NEV1hv46YfFfmJjQdReBO1p8VNrdbuvmuXs/of5ysCNM2Ds/8TNt2Hxu3JhzYePOH1U8N+joFEsNQVv+QWwAsot0Ajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWhjhQ6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8408C4CEEB;
	Sun, 27 Jul 2025 06:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753597396;
	bh=oJXTL/Zk785tlpPm70/cIQWrdlgSqqCiqp958NXEF5M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HWhjhQ6KbKLXoPdeTyB5LOXufqiM2iT/wrf+qvxaU0LpSZagfsiI+PQ5bCdQfMQnC
	 TTQPSqWPZTYTetLcLBauOKSMTT6bvhmyYjcQX58vuxWYDVe+1EjZ0HyRq8kU72iSK4
	 CpbL42eBkBClBpYWDe+8VdUEY7QuSOXvRGpzj9djFYCI8lro4bmrdQ3vB7xkM1VNjJ
	 +qLDX3Cmpv0mRFn2MyMaX9tIkUG735pg248E1egfKCZV+KWGkWx32oSZdoVLbaRCbr
	 poIB3YhbgyAojRjMuMKpqPvWohdYcv14K2uszRVdOaBY8Oq5ok2WyJJ+RN2vP6X+eL
	 MlhS5B2p+1Vdg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAK9=C2UDV3xCpKxZmT4NsRvN=hCcQrcx0fr-QFD2fuOrqmXmHA@mail.gmail.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <20250704070356.1683992-9-apatel@ventanamicro.com> <175341132347.3513.7184287611040628050@lazor> <CAK9=C2UDV3xCpKxZmT4NsRvN=hCcQrcx0fr-QFD2fuOrqmXmHA@mail.gmail.com>
Subject: Re: [PATCH v8 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-acp
 i@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
To: Anup Patel <apatel@ventanamicro.com>
Date: Sat, 26 Jul 2025 23:23:15 -0700
Message-ID: <175359739515.3513.8664828076215459722@lazor>
User-Agent: alot/0.11

Quoting Anup Patel (2025-07-25 09:16:12)
> On Fri, Jul 25, 2025 at 8:12=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Anup Patel (2025-07-04 00:03:40)
> > > Add device tree bindings for the RPMI clock service group based
> > > message proxy implemented by the SBI implementation (machine mode
> > > firmware or hypervisor).
> > >
> > > The RPMI clock service group is defined by the RISC-V platform
> > > management interface (RPMI) specification.
> > >
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > [...]
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    clock-controller {
> >
> > Maybe the name should be 'clock-service' then? I don't understand SBI so
> > not sure why this is in DT to begin with. Is something consuming this
> > node? Or a driver is binding to it?
>=20
> SBI is a syscall style interface between SBI implementation (aka
> M-mode firmware or hypervisor) and supervisor software (aka
> Linux kernel).
>=20
> We have DT based drivers in OpenSBI (M-mode firmware). This
> binding allows Clock message proxy driver to be probed on the
> OpenSBI side. The clock message proxy driver allows Linux
> RPMI clock driver to send RPMI messages via OpenSBI as
> proxy thereby sharing the RPMI transport between OpenSBI
> and Linux kernel.

Let me try to clarify my confusion. A 'clock-controller' node without a
'#clock-cells' property is confusing.

It's not providing clks? The SBI firmware is not discoverable? Do you
have a pointer to the DTS for this node and the clock controller node in
the next patch? I'd like to understand why this is named a clock
controller when it doesn't provide clks.

