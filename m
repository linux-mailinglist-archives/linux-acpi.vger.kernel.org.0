Return-Path: <linux-acpi+bounces-1070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E982C7DA096
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 20:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5B3B20C49
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2D3D389
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xXX2ovs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWHizKPP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778951946F
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 17:45:45 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988ABF3;
	Fri, 27 Oct 2023 10:45:40 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698428739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vCF2sTMjoJARe87DP7lAD8rcZvlM4BFzZKH7cV3QuU8=;
	b=xXX2ovs1OHhXbwDuZac6CP8IsOrVj54bZeD5nyxWlPUBOXUniX1BJWPV+PcVr7obtLN3eF
	I6uPBnLwqsSeXJfTpISEjW/ksbeWDMkDlGhuSLkQd0gwCvAm+Ogc1qakMhd99FaKFmFOz6
	1GIjy1E+N/YDe03TxrnRIU53J4jidS28NuERCZkDyMkX8X5wFJu/OtV20oF773goJYLcMm
	/ktLuCbvSshkq1Zxca8OxoWF8VJ4zqw5Ohr8CYTRGpLm9x96JuE60jmezp5gm6X3Yn94AK
	7ns6idG1lqprpc0Y27+8vH0y0yrCC8o1DwW3zTycAy/bFh5YoXh4wv0+CbwiwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698428739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vCF2sTMjoJARe87DP7lAD8rcZvlM4BFzZKH7cV3QuU8=;
	b=WWHizKPPbjghvXPvf1/QyrM9sNTsNYrmVq6GoM+JMN89I9M6CgHAYJRHoOSGLIiqmVpfsl
	B+qpDGnW7YiT4hDg==
To: Bjorn Helgaas <helgaas@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 13/21] irqchip: riscv-intc: Add ACPI support for AIA
In-Reply-To: <20231026165150.GA1825130@bhelgaas>
References: <20231026165150.GA1825130@bhelgaas>
Date: Fri, 27 Oct 2023 19:45:38 +0200
Message-ID: <87jzr82c3h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 26 2023 at 11:51, Bjorn Helgaas wrote:
> On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
>> The RINTC subtype structure in MADT also has information about other
>> interrupt controllers like MMIO. So, save those information and provide
>> interfaces to retrieve them when required by corresponding drivers.
>
>> @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
>
>> +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
>> +	 * IMSIC is discovered, set system wide MSI support as
>> +	 * unsupported. Once IMSIC is probed, MSI support will be set.
>> +	 */
>> +	pci_no_msi();
>
> It doesn't seem like we should have to tell the PCI core about
> functionality we *don't* have.
>
> I would think IMSIC would be detected before enumerating PCI devices
> that might use it, and if we *haven't* found an IMSIC by the time we
> get to pci_register_host_bridge(), would/should we set
> PCI_BUS_FLAGS_NO_MSI there?
>
> I see Thomas is cc'd; he'd have better insight.

I was not really involved with this bus and MSI domain logic. Marc
should know. CC'ed.

Thanks,

        tglx



