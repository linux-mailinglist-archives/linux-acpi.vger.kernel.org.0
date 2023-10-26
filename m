Return-Path: <linux-acpi+bounces-1030-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B317D885A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CD6281FC2
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC23AC0A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Escr5IAb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D138BA0
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 17:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6849CC433C8;
	Thu, 26 Oct 2023 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698339850;
	bh=lohn07v+85pAnB2Smu7iOTuTgIcJkgpWbWvasyT0Fgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Escr5IAbmRkywpD2oy80GZ3HPbUNYPxv48Yrj/nfqrSprJK3BJmybCJQwbFisJOjy
	 NrPuQWhwMOQvib+LwQXPASzj+Jyg12NTH2EGevoiJ4zXjWl5BDARgpagN13VoFZwcY
	 6xdVtztFRh3d3ukt8I/e+qpzBO8CYpcnaWAMpqGwO5WbEORXXThtSLF2G6haunf86F
	 pL3KUoqYEvk9PvF99SIzEEDiSDrmZQwjPFjbwUIaw9JU0WlXEj1qIRchKwFdWqPrw6
	 MPQdaZZrSB/9NQZ1Zoinq/WAh5vDMUB9YW+eyh9N2zc7VRPkH5LMo4lBpOiORHFGRw
	 Ife18O45et1cw==
Date: Thu, 26 Oct 2023 12:04:08 -0500
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
Subject: Re: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe
 for ACPI systems
Message-ID: <20231026170408.GA1825378@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025202344.581132-7-sunilvl@ventanamicro.com>

On Thu, Oct 26, 2023 at 01:53:29AM +0530, Sunil V L wrote:
> On RISC-V platforms, apart from root interrupt controllers (which
> provide local interrupts and IPI), other interrupt controllers in the
> hierarchy are probed late. Enable this select this CONFIG option for
> RISC-V platforms so that device drivers which connect to deferred
> interrupt controllers can take appropriate action.

Quite a bit of this series seems related to the question of interrupt
controllers being probed "late".

I don't see anything specific about *how* late this might be, but from
the use of -EPROBE_DEFER in individual drivers (8250_pnp explicitly,
and acpi_register_gsi() and pnp_irq() and acpi_pci_irq_enable(), which
are called from driver .probe() paths) it seems like interrupt
controllers might be detected even after devices that use them.

That seems like a fairly invasive change to the driver probe flow.
If we really need to do that, I think it might merit a little more
background as justification since we haven't had to do it for any
other arch yet.

Bjorn

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8c105a151e12..b62441aefa6a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,6 +12,7 @@ config 32BIT
>  
>  config RISCV
>  	def_bool y
> +	select ARCH_ACPI_DEFERRED_GSI if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_MCFG if (ACPI && PCI)
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

