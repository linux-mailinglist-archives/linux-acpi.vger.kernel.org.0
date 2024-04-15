Return-Path: <linux-acpi+bounces-5017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BE8A560C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E25A281CDA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F62762E0;
	Mon, 15 Apr 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WCu6IOXV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2507602A
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193803; cv=none; b=oyYoLVLKJtO6k+s1BGD6t4nJHzbOGkoCffSqnNx8lBxZ0y6w8qogO2DqIWwIN4NS83wWIjKFZNIfE4ApK89rSk01+uFqv8M2TzI+PT1wAE9CHWJsTEN4m6+pmSoyLn5e9Kh6DTZQimhwtXM5t5C7JqApAqUDh/5OKCFYdAunMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193803; c=relaxed/simple;
	bh=j1x0UxzeXvLPbbNyhZHSxPWm4VxjffamP8nzex+JrHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2mzxtvn/FgYseEehMYm1WIAhRpw5KlJA84TZ/YAbw7We0IMMAo1zlsvI0nRPfmtoex3XO7lN0R0jDJotCDHtyq8d01kT4qIVY0J+riA3t20T7J7G0RRE29iuykBwQ+jkpetoLu8iGm4dT7sRem843sEIy0KYXLfc2YA8dtIu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WCu6IOXV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so17573105ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713193800; x=1713798600; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUTjRYw2QSF7yq7TkGCMX42B7x4BBoP+ynBiomiZSA8=;
        b=WCu6IOXVSVMCxDziLABukGzNh/BBrulinJOsNTYfpJA7h7grFfwH7zxlmMRVc7K+Kb
         G2H8fRwkscfHHPi8Eyk2j9gxnLgrKXWj8WdNsCQEKVJdiGZ8+SG0Lc4IGrDe25B90G8A
         AmYrl5E2JMJ/23pNtKJ9d9AJFQdkeD/UIXn/ADnXQdhxo7Sl8rMM0ikIxa9RgiNGhaqD
         pVX5i4zAepbq7C1Uj/XjjzPITg2DomriJL3Dv9Sbh356gK/k2SgukTiiINBVBBYyuyfS
         EA+G9WT3tIEvxVTLXn9ptanYkmR0PH4x46nm3RMBb1GwD0CXkRRYQePvzagTi0lFrLQE
         8FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193800; x=1713798600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUTjRYw2QSF7yq7TkGCMX42B7x4BBoP+ynBiomiZSA8=;
        b=fmzL04ihb64hUrPKxpgDR8L0b0KwUCsALS3jl00KTQ9p3jls5u4kHOmT/uA3MPWkTj
         A2GgldbiuJDxana8egfYxVAZazLfasoILpE2Et2bgOToLiNk71zSXnKmsFw3G3nYZS52
         +3SxR2ilcBRkIZBl6RUjdaKyL7eqnxFePAZBb3pWhe9qO4YKuYTU5cKbpGN42hBxbZrt
         qfZhnIrYtSGUmdYA7yoYoikkINlYv/MaiWI6hGTbk+OufHmi4nZuBvPLzMrvtznbVscn
         iymZ6pgy+xUTzvw/2wPvbBfi8EqfLR/Vfme2br+PuWEQ2apOj6E0eQGmIsyxGxmjKPbb
         J1qA==
X-Forwarded-Encrypted: i=1; AJvYcCWgs43v8rFrrfuhL4BiEZMInZNu6hSKKEozNN2aTThOmWbp2U+1yHUUTspkhbtjQ4/eWja4NJAmldwHTJpOuJ+hxLZPRGIBcE/5YA==
X-Gm-Message-State: AOJu0YzYM3cM/oz+wOhvcSfxlwdDO8ERUFu3UZC4ZO82H8W0tYWxqP5V
	mmLNTDoHJsvdzixo/PaS8MYd2GfdF9yHY8+vtVSZiAewidoLF95tQJ5CwrqKLR4=
X-Google-Smtp-Source: AGHT+IGn7pZ58bJwCSsiauIBDNVX2UFdCiTs5jbjy2Z3dKH6jKEfU0xiZ2+wL5xBe2lNgZ7BIAy5FQ==
X-Received: by 2002:a17:903:2303:b0:1e2:bb09:6270 with SMTP id d3-20020a170903230300b001e2bb096270mr13204613plh.28.1713193800102;
        Mon, 15 Apr 2024 08:10:00 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c24400b001dd578121d4sm8030488plg.204.2024.04.15.08.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:09:59 -0700 (PDT)
Date: Mon, 15 Apr 2024 20:39:51 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v3 00/17] RISC-V: ACPI: Add external interrupt
 controller support
Message-ID: <Zh1DP8YnjPlie4+S@sunil-laptop>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
 <CAJZ5v0j6Veze8xDFKTbVZ5=WAfmLdeJ8NXRnh9kwCZgyaDdgew@mail.gmail.com>
 <ZbiQ/tO/odnJCBD1@sunil-laptop>
 <CAJZ5v0gnH0uPEM0q9VzJOg2Z_7bOP9XdQbOttpRtnkLGej45Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gnH0uPEM0q9VzJOg2Z_7bOP9XdQbOttpRtnkLGej45Sw@mail.gmail.com>

On Thu, Feb 01, 2024 at 07:10:28PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 30, 2024 at 7:02 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Dec 19, 2023 at 06:50:19PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 19, 2023 at 6:45 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >
> > > > This series adds support for the below ECR approved by ASWG.
> > > > 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> > > >
> > > > The series primarily enables irqchip drivers for RISC-V ACPI based
> > > > platforms.
> > > >
> > > > The series can be broadly categorized like below.
> > > >
> > > > 1) PCI ACPI related functions are migrated from arm64 to common file so
> > > > that we don't need to duplicate them for RISC-V.
> > > >
> > > > 2) Introduced support for fw_devlink for ACPI nodes for IRQ dependency.
> > > > This helps to support deferred probe of interrupt controller drivers.
> > > >
> > > > 3) Modified pnp_irq() to try registering the IRQ  again if it sees it in
> > > > disabled state. This solution is similar to how
> > > > platform_get_irq_optional() works for regular platform devices.
> > > >
> > > > 4) Added support for re-ordering the probe of interrupt controllers when
> > > > IRQCHIP_ACPI_DECLARE is used.
> > > >
> > > > 5) ACPI support added in RISC-V interrupt controller drivers.
> > > >
> > > > This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
> > > > not merged yet and first time introducing fw_devlink, deferred probe and
> > > > reordering support for IRQCHIP probe, this series is still kept as RFC.
> > > > Looking forward for the feedback!
> > > >
> > > > Changes since RFC v2:
> > > >         1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> > > >         2) Dropped patches in drivers which are not required due to
> > > >            fw_devlink support.
> > > >         3) Dropped pci_set_msi() patch and added a patch in
> > > >            pci_create_root_bus().
> > > >         4) Updated pnp_irq() patch so that none of the actual PNP
> > > >            drivers need to change.
> > > >
> > > > Changes since RFC v1:
> > > >         1) Abandoned swnode approach as per Marc's feedback.
> > > >         2) To cope up with AIA series changes which changed irqchip driver
> > > >            probe from core_initcall() to platform_driver, added patches
> > > >            to support deferred probing.
> > > >         3) Rebased on top of Anup's AIA v11 and added tags.
> > > >
> > > > To test the series,
> > > >
> > > > 1) Qemu should be built using the riscv_acpi_b2_v8 branch at
> > > > https://github.com/vlsunil/qemu.git
> > > >
> > > > 2) EDK2 should be built using the instructions at:
> > > > https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
> > > >
> > > > 3) Build Linux using this series on top of Anup's AIA v11 series.
> > > >
> > > > Run Qemu:
> > > > qemu-system-riscv64 \
> > > >  -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic \
> > > >  -m 2G -smp 8 \
> > > >  -serial mon:stdio \
> > > >  -device virtio-gpu-pci -full-screen \
> > > >  -device qemu-xhci \
> > > >  -device usb-kbd \
> > > >  -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
> > > >  -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
> > > >  -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
> > > >  -kernel arch/riscv/boot/Image \
> > > >  -initrd rootfs.cpio \
> > > >  -append "root=/dev/ram ro console=ttyS0 rootwait earlycon=uart8250,mmio,0x10000000"
> > > >
> > > > To boot with APLIC only, use aia=aplic.
> > > > To boot with PLIC, remove aia= option.
> > > >
> > > > This series is also available in acpi_b2_v3_riscv_aia_v11 branch at
> > > > https://github.com/vlsunil/linux.git
> > > >
> > > > Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
> > > > (https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.com/)
> > > >
> > > > Sunil V L (17):
> > > >   arm64: PCI: Migrate ACPI related functions to pci-acpi.c
> > > >   RISC-V: ACPI: Implement PCI related functionality
> > > >   PCI: Make pci_create_root_bus() declare its reliance on MSI domains
> > > >   ACPI: Add fw_devlink support for ACPI fwnode for IRQ dependency
> > > >   ACPI: irq: Add support for deferred probe in acpi_register_gsi()
> > > >   pnp.h: Reconfigure IRQ in pnp_irq() to support deferred probe
> > > >   ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
> > > >     probe
> > > >   ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
> > > >   irqchip: riscv-intc: Add ACPI support for AIA
> > > >   irqchip: riscv-imsic: Add ACPI support
> > > >   irqchip: riscv-aplic: Add ACPI support
> > > >   irqchip: irq-sifive-plic: Add ACPI support
> > > >   ACPI: bus: Add RINTC IRQ model for RISC-V
> > > >   ACPI: bus: Add acpi_riscv_init function
> > > >   ACPI: RISC-V: Create APLIC platform device
> > > >   ACPI: RISC-V: Create PLIC platform device
> > > >   irqchip: riscv-intc: Set ACPI irqmodel
> > >
> > > JFYI, I have no capacity to provide any feedback on this till 6.8-rc1 is out.
> > >
> > Hi Rafael,
> >
> > Gentle ping.
> >
> > Could you please provide feedback on the series? Patches 4, 5, 6, 7 and
> > 8 are bit critical IMO. So, I really look forward for your and other
> > ACPI experts!.
> 
> There was quite a bit of discussion on patch [6/21] and it still seems
> relevant to me.
> 
> ACPI actually has a way to at least indicate what the probe ordering
> should be which is _DEP.
> 
> The current handling of _DEP in the kernel may not be covering this
> particular use case, but I would rather extend it (if necessary)
> instead of doing all of the -EPROBE_DEFER dance which seems fragile to
> me.
> 
Hi Rafael,                                                                                                                                                                                                  
                                                                                                                                                                                                            
I found that _DEP is better than fw_devlink for ACPI since it works                                                                                                                                         
during scan itself. For ex: the way PCI host bridges are scanned in                                                                                                                                         
ACPI, PNP device handling. While some hacky solution could be done like                                                                                                                                     
I did in v3 (pnp_irq() changes), _DEP way seems much better.                                                                                                                                                
                                                                                                                                                                                                            
So, we decided to go with your suggested approach and defined namespace                                                                                                                                     
devices for PLIC and APLIC required to create dependency mechanism.                                                                                                                                         
However, there are concerns that every device will have to add _DEP now                                                                                                                                     
and whether it is intended for this use case. Also, actually the                                                                                                                                            
dependency is already available in the form of GSI number mapping.                                                                                                                                          
Hence, instead of explicit dependency, we would like to create implicit                                                                                                                                     
dependency. So, I will send RFC v4 series with those changes. Please                                                                                                                                        
help us with feedback. If you could provide quick high level go/no-go,                                                                                                                                      
that will help us a lot since we need to finalize the spec whether to                                                                                                                                       
mandate _DEP or not.                                                                                                                                                                                        
                                                                                                                                                                                                            
I request you to provide some high level feedback in the RFC v4 I am                                                                                                                                        
going to send.                                                                                                                                                                                              
                                                                                                                                                                                                            
1) Creation of implicit dependency.                                                                                                                                                                         
2) Handling PNP devices as part of clearing dependency                                                                                                                                                      
3) IRQCHIP probing reordering when there are multiple irqchips.                                                                                                                                             
                                                                                                                                                                                                            
Thanks,                                                                                                                                                                                                     
Sunil                  

