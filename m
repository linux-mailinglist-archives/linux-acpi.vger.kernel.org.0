Return-Path: <linux-acpi+bounces-17323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA102BA22E6
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 04:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A726E4E056E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 02:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF123FC66;
	Fri, 26 Sep 2025 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPXq2mR5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35823D7E6;
	Fri, 26 Sep 2025 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758852476; cv=none; b=kSYDP8XFnqx/2TWi2ht4Io/Wqh+CwOFNs+OIXbitYmeP0UuU+A1Gd4C13PiECIuvs+dJ5H3qHN4Vh/XRhdOxknbcuppv7YEH3DEG1oYUvCVIEbU+/6Bl2cwCuhQHgYzknrQW22UQ8IAzsfwXrRuIeaZFz2L5v7PPPAd6f5YNGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758852476; c=relaxed/simple;
	bh=uN2UFL7M3Wj5OaaqksHU4neh8HYrJwUdMjuaAycHFlE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XzPqhjmuUXq2HOy0ZZOkJDm4M9CV4eaVRiw/p79+7BtWLRG0QCIX7WO7Rdlqz71pqUkw33zrnrtyUfBIXsu1QeG+x50R9nWvSf4rwthkyEyGlySB9zp8lFkV7hyXBYY+LrTHBVVGDVAWNkpyXZWbKEaHKXezgmxmmAL0/eZtPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPXq2mR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91848C4CEF0;
	Fri, 26 Sep 2025 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758852476;
	bh=uN2UFL7M3Wj5OaaqksHU4neh8HYrJwUdMjuaAycHFlE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oPXq2mR5I63npQJuqqwLWbiSyJLEipDv14/6HBV4MW/RTth6GxwDgcALvuVwuOB0m
	 8fcN3jG/A3XysoLGxFj9RNyVMmjdQ4rXvsl5REvgBZFZP7QDc5j/s7lN482GdUZn1h
	 MhZo/Es5/3nd0wkW1ezLECgGLd/caqhfUIiMAC+6IsOn5Tkgi2oS7j6SfTPb12NMGn
	 zLQlDPIHTe9Ic5DfR7sxrfDL28nALucWfPWoaJsxWBnsgnsc0dZglOJcjvCkyrL73O
	 hDEsi4pbyvHQRXHyCpqk4RSqui2Y2DekhsX3e1UEYJg6/w58LVueUT2k7MB/aZauoL
	 2DGniZ4+OTsHg==
Date: Thu, 25 Sep 2025 20:07:53 -0600 (MDT)
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
Subject: Re: [PATCH v10 00/24] Linux SBI MPXY and RPMI drivers
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
Message-ID: <6d91bd27-bdad-1348-661a-cd2eb84f6250@kernel.org>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Aug 2025, Anup Patel wrote:

> The SBI v3.0 (MPXY extension) [1] and RPMI v1.0 [2] specifications
> are ratified by the RISC-V International.
> 
> Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
> Linux only has SBI MPXY mailbox controller driver, RPMI clock driver
> and RPMI system MSI driver This series also includes ACPI support
> for SBI MPXY mailbox controller and RPMI system MSI drivers.
> 
> These patches can be found in the riscv_sbi_mpxy_mailbox_v10 branch
> at: https://github.com/avpatel/linux.git
> 
> To test these patches, boot Linux on "virt,rpmi=on,aia=aplic-imsic"
> machine with OpenSBI and QEMU from the dev-upstream branch at:
> https://github.com/ventanamicro/opensbi.git
> https://github.com/ventanamicro/qemu.git
> 
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> [2] https://github.com/riscv-non-isa/riscv-rpmi/releases

Thanks, queued for v6.18 (hopefully).


- Paul

