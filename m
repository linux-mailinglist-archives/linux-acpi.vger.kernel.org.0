Return-Path: <linux-acpi+bounces-1026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1C7D884B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 20:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C6D2820A3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AF3AC02
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlavQRLW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1F2D78B
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 16:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283EDC433C7;
	Thu, 26 Oct 2023 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698339112;
	bh=V8qM86kYWnahH8L8to5RnmhawuvXMtXfMH61MytOS1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BlavQRLWWVuUARbinIctcKA8CrUyeRJJCzAYRa0Fnlh/gujQqIpQDkbPZLXuTsxB2
	 anoCTsLnIYAxfr4tz2637av8xqeK14rbMoxBmRXEei5mUPe81JdX75sAvTlkKPRNqV
	 aynexxIOqntWEOLzZPUH5nNkvFYeW0ENy6fgdQP35bLmHR0J1eUHWj6v7oBJfkeF9r
	 QCu85klS6/56jeSeth5ZOSf58mkffvvnAjmJn+9muzJEhOFbbnf3HVpv6YH7BlEevY
	 /nN6PwqU4zJ5iUO6kAuM0XyjWTf/804GKb8OJVf4hoVSFGWdZyt/87Y+yIhWIg3Hfp
	 kQuiBNn/fG3wA==
Date: Thu, 26 Oct 2023 11:51:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 13/21] irqchip: riscv-intc: Add ACPI support for
 AIA
Message-ID: <20231026165150.GA1825130@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025202344.581132-14-sunilvl@ventanamicro.com>

On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
> The RINTC subtype structure in MADT also has information about other
> interrupt controllers like MMIO. So, save those information and provide
> interfaces to retrieve them when required by corresponding drivers.

> @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,

> +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
> +	 * IMSIC is discovered, set system wide MSI support as
> +	 * unsupported. Once IMSIC is probed, MSI support will be set.
> +	 */
> +	pci_no_msi();

It doesn't seem like we should have to tell the PCI core about
functionality we *don't* have.

I would think IMSIC would be detected before enumerating PCI devices
that might use it, and if we *haven't* found an IMSIC by the time we
get to pci_register_host_bridge(), would/should we set
PCI_BUS_FLAGS_NO_MSI there?

I see Thomas is cc'd; he'd have better insight.

Bjorn

