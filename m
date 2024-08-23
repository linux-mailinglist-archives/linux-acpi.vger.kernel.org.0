Return-Path: <linux-acpi+bounces-7798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B7695D4A2
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 19:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB4E1C22975
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856591917DB;
	Fri, 23 Aug 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHPWSEM9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A292191493;
	Fri, 23 Aug 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435155; cv=none; b=VIWwLscxtrhdh/c8LdSE9ys6bkxZrqCElGi4QFcLEw40czrnJS+/xJXoPIBRz5iV8fa0XKsJ0MxxqRR1Crc+mSpTvKhndLTelTklbw6nhVtiGmwfob8x5slzO9XJ+9zxqZu9i5V36QqrbB0nY98SbDszHne0w+/2dI5++3DKHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435155; c=relaxed/simple;
	bh=mr01yUEvX26NmVp0jXUcMup0uPWebEfYc7j3GsM8fjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jDOAupVUdyzbauKUJHpulGD3RrcOJzoSLW44Mm/qSZAPWSD5YZb3QFEPwx5uXoLoUkzzraUgfgBY4dQFKTqb51kWis9pp9gSDht47zqMQ2MO1T1CA0sVwMTk29RcNW+2DO0uWRRZPS29Y0Wshajd2EQPPfPH51avvk2sCwncz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHPWSEM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86113C32786;
	Fri, 23 Aug 2024 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724435154;
	bh=mr01yUEvX26NmVp0jXUcMup0uPWebEfYc7j3GsM8fjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eHPWSEM9ZihA42Y4ZITQjghgyKSJcIG+f546BaW4ykszsvYxOtxHN3kY+roDFfypS
	 1Z9tclp0ated/Dhp/CvM2h9Ud1w3QZ0bHZ2CTxLSlxzllhTeLw5uPjmHTGHMKpkj4/
	 lmXTBuktRhntuUv0huFq2r3cauXx9sAoYuaR7MG4J2Gfb81ZobYpbyP1N+62I+hBEx
	 5mrnYORL607W41D7saiW13gfbqhH9lxljbJxnnkQOkizrXTjNhjEQPOsvWSUTv6MV/
	 MhbpPkybGZDDzm0hTA/q1WEp4NF7mpuV2RFgVBiP/sTbhrP6B7qssbGeadwmnRBufj
	 LJkiPqsE47CKQ==
Date: Fri, 23 Aug 2024 12:45:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v8 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <20240823174552.GA375227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsgtNbBLfP3SygYv@sunil-laptop>

On Fri, Aug 23, 2024 at 12:03:25PM +0530, Sunil V L wrote:
> On Thu, Aug 22, 2024 at 04:44:15PM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 12, 2024 at 06:29:20AM +0530, Sunil V L wrote:
> > > RISC-V platforms need to use dependencies between PCI host bridge, Link
> > > devices and the interrupt controllers to ensure probe order. The
> > > dependency is like below.
> > > 
> > > Interrupt controller <-- Link Device <-- PCI Host bridge.
> > > 
> > > If there is no dependency between Link device and PCI Host Bridge,
> > > then PCI devices may be probed prior to Link devices.  If a PCI
> > > device is probed before its Link device, we won't be able to find
> > > its INTx mapping.
> > 
> > This seems to explain why we want these dependencies, which is useful,
> > but *this* patch only removes the dependencies.
> > 
> > Maybe this description should be in the patch that *adds* the
> > dependencies, e.g., "ACPI: RISC-V: Implement function to add implicit
> > dependencies"?
> >
> Okay. Let me move this to the patch you suggested.

Given my forgetfulness and your pointing out that this *does* add the
dependencies (by virtue of adding PNP0C0F to the acpi_honor_dep_ids[]
list), it does make sense here.

> > > So, add the link device's HID to dependency honor list and clear the
> > > dependency after probe is done so that the dependent devices are
> > > unblocked to probe.

Maybe expanding this to "Add the link devices HID (PNP0C0F) to the
acpi_honor_dep_ids[] dependency list" would help connect this all
together?

> > This still claims this patch adds HID, which I don't think it does.
> >
> Please see below.
>  
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Tested-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
> > > ---
> > >  drivers/acpi/pci_link.c | 2 ++
> > >  drivers/acpi/scan.c     | 1 +
> > >  2 files changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > > index aa1038b8aec4..b727db968f33 100644
> > > --- a/drivers/acpi/pci_link.c
> > > +++ b/drivers/acpi/pci_link.c
> > > @@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
> > >  	if (result)
> > >  		kfree(link);
> > >  
> > > +	acpi_dev_clear_dependencies(device);
> > > +
> > >  	return result < 0 ? result : 1;
> > >  }
> > >  
> > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > index 28a221f956d7..753539a1f26b 100644
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
> > >  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
> > >  	"RSCV0001", /* RISC-V PLIC */
> > >  	"RSCV0002", /* RISC-V APLIC */
> > > +	"PNP0C0F",  /* PCI Link Device */
>
> This is the change which I meant adding HID to the honor list. Do you
> recommend to make this change separate patch so that it doesn't confuse
> with adding a new HID to the probe match table?

Oh, right, sorry.  I remember working this out in the past, but I had
forgotten.

I think it makes sense in this patch because the add and removal are
matched when they're in the same patch.

Sorry for the noise!

Bjorn

