Return-Path: <linux-acpi+bounces-15016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A82AF89D3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 09:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66C53B2DC8
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52F283FCB;
	Fri,  4 Jul 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHujkzYt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4B1E32D7;
	Fri,  4 Jul 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615125; cv=none; b=s2B82shX+8aEFU+40c/XKhYD5/oeTSn/WcmjAH3v6s6CQmPTXuy1uwxL9Qi+X2e9qJrlNJzvmeplOuzuA2qJ13YszRU1zj57GJN5WKb+fpH4EURglBw93jyS6/GdcU/+bJfNfN75cYuL5cfpnWBFFgMSf3vRM6ASmOMDNGmXEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615125; c=relaxed/simple;
	bh=MlLV85r3dwch+8yN0HFwSMWbY/7x6F5+uh7tSezv4b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTTQbkH3yCEiJgLKKiFp6D8bokAn3I3hv35x0LW0c/KEVCyQ1TXbPAoMaW3gNieuIKenPYay4vGgyAPtv7ZAs1uzcQB47VLPlV1BBFU+QUr2SPSPnvtQU8Tf8Z+1acm8GeFEibCEafJBtL9sTMHPSHJqhYiCQnFR1gAuDYr690o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHujkzYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5B5C4CEED;
	Fri,  4 Jul 2025 07:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751615124;
	bh=MlLV85r3dwch+8yN0HFwSMWbY/7x6F5+uh7tSezv4b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHujkzYtp97aRLHazCUsI85S6dpbcxBwmcEr4EdBdU3tB//eDUNo7nxpX0inOtZM8
	 S99Gd4s4B0hgH2Gc+37wa0hN80I19zzylKeqyjBFI4kONb3IdwdGBJBTEbHVWI3V7M
	 rspb2wM2stcGWKO+yTJ7hlmsw7VIyEq2VOVvNeFqzMwAYrWEhzXbhyaHzg63orPQM+
	 /9DihUZRVK2ZzgDsxA10A2iP2eYRAViQr8Xvh/VGpZTxBFCJbkVW2kw139NXcrocxI
	 EHebIEiXi0erzIMAj30yaP4syGBf0VQZorSnIofVHl1qlDQn5RJf5lNZuMyiDHAqq4
	 dd12K6Bexqd1g==
Date: Fri, 4 Jul 2025 09:45:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Rahul Pathak <rpathak@ventanamicro.com>, 
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Atish Patra <atish.patra@linux.dev>, 
	Andrew Jones <ajones@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/24] Linux SBI MPXY and RPMI drivers
Message-ID: <20250704-attractive-sawfly-of-artistry-1c86a3@krzk-bin>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250704070356.1683992-1-apatel@ventanamicro.com>

On Fri, Jul 04, 2025 at 12:33:32PM +0530, Anup Patel wrote:
> The SBI v3.0 (MPXY extension) [1] and RPMI v1.0 [2] specifications
> are frozen and finished public review at the RISC-V International.
> 
> Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
> Linux only has SBI MPXY mailbox controller driver, RPMI clock driver
> and RPMI system MSI driver This series also includes ACPI support
> for SBI MPXY mailbox controller and RPMI system MSI drivers.
> 
> These patches can be found in the riscv_sbi_mpxy_mailbox_v8 branch
> at: https://github.com/avpatel/linux.git
> 
> To test these patches, boot Linux on "virt,rpmi=on,aia=aplic-imsic"
> machine with OpenSBI and QEMU from the dev-upstream branch at:
> https://github.com/ventanamicro/opensbi.git
> https://github.com/ventanamicro/qemu.git
> 
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> [2] https://github.com/riscv-non-isa/riscv-rpmi/releases
> 
> Changes since v7:
>  - Addressed comments on PATCH3, PATCH7, PATCH10, PATCH14, and PATCH21

Which comments? What exactly did you change? Provide in-patch changelogs
explaining this, because what you wrote is way too vague.

Best regards,
Krzysztof


