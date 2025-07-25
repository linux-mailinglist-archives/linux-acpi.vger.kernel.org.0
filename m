Return-Path: <linux-acpi+bounces-15314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC0B11690
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jul 2025 04:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38F81CE4E9C
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jul 2025 02:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494AF234973;
	Fri, 25 Jul 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q05+ipRq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DE54F81;
	Fri, 25 Jul 2025 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411325; cv=none; b=YnSYsgT7MNKlyAeebW7r+D71WELXNVe34YwDkFTgvBRTvy9VPdsLNumjyRRsdEqhjTd8Uf228NlC382OcebaUIRz1XBAIRZhg2VQxNW9m/GFjjpajyyCo+tUECZf7uIGy3nTjAKURZ7UoN+aFkM1wEfl3XuMYNYADOkdkPYepqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411325; c=relaxed/simple;
	bh=/Wzdxi+FPpqqrFYqJSRrwfVEvytWS2E7haaA0G+djCQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=pLl8qMv0SX3aD4KC79S7bHbGJJ7X3G+Ujfm0wpM/dt4Lq9kk+ZxCbVU23iZ+I+HuVeFUAlZRvw5nOLwt7Pbk/J5nn+DFeLT+YU+LzKgnyPkYICEviPwL8FubZL3my3LU4WwA5W4t7m9aoUOr4l8nRpvbHVN0c1dQ9rOVWe3dTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q05+ipRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C483C4CEED;
	Fri, 25 Jul 2025 02:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753411324;
	bh=/Wzdxi+FPpqqrFYqJSRrwfVEvytWS2E7haaA0G+djCQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Q05+ipRqgOKM9ulQakC4Kame56xoZ1ktwQHG4p2XBCrUmptyrixMs8W8cOvssYCow
	 SWBf+2skMIYvclwUtHY3/YFK/UX5AOCoBMWxcxUT+YeFIVQTbZIcuYEaoeKhX+kXrL
	 01haOR6mUd1yntkZX/f/zSjiuWUpVAGqlXdf/koCEXeNHG3VB7H29ygNRZyoj3sFUL
	 A6KVg7mtkASoNgEZNnRSwB8hVkUFf27iIQS1H3cqfbmhKC0LqxQ4/cYT6MhfoLaXah
	 SlU7/TNbf8Q1pyv3YMZU7dZscywJvpjvS2DtoFSV9jHEbJU+w9gbw7JY3uNfDhvqdY
	 Uh5du55PTEkEQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250704070356.1683992-9-apatel@ventanamicro.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <20250704070356.1683992-9-apatel@ventanamicro.com>
Subject: Re: [PATCH v8 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Anup Patel <apatel@ventanamicro.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Date: Thu, 24 Jul 2025 19:42:03 -0700
Message-ID: <175341132347.3513.7184287611040628050@lazor>
User-Agent: alot/0.11

Quoting Anup Patel (2025-07-04 00:03:40)
> Add device tree bindings for the RPMI clock service group based
> message proxy implemented by the SBI implementation (machine mode
> firmware or hypervisor).
>=20
> The RPMI clock service group is defined by the RISC-V platform
> management interface (RPMI) specification.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
[...]
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {

Maybe the name should be 'clock-service' then? I don't understand SBI so
not sure why this is in DT to begin with. Is something consuming this
node? Or a driver is binding to it?

> +        compatible =3D "riscv,rpmi-mpxy-clock";
> +        mboxes =3D <&rpmi_shmem_mbox 0x8>;
> +        riscv,sbi-mpxy-channel-id =3D <0x1000>;
> +    };

