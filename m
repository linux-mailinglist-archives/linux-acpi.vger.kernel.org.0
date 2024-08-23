Return-Path: <linux-acpi+bounces-7796-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EAB95C580
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 08:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5210A283C7F
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 06:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8F7E111;
	Fri, 23 Aug 2024 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OcJXGAEv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B594A08
	for <linux-acpi@vger.kernel.org>; Fri, 23 Aug 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394825; cv=none; b=f0L/CIq9fJwQ05Y3tdYF6bZZyqFwW5w1hDt+t0Daqroce3GGUm5Jig9NmWbAur1HwlsR2gyKArO0NQu3H2DT7gZ13bqYeEbT0X9NdQE0kkPWSKI24eFHBmGKagnhI+kmWC9c81fXJJX62qLNBfatkABCADILJk+tyh1Zvvknp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394825; c=relaxed/simple;
	bh=x0K0LEJWtcXiX9pS8782m4VauBznWN2r2hfMVYg5vPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YempgddsI+WhmegPlfsOWpBs0gCUupN7aCvrTe/TH7UF3MZNpQ07moNqDS25YXzQ0l7dw1b5/ziv+6vWdKIcQAmLE7Qy7I+7lmEQnGXTTzxvpe6BCijfdhd0C53pQR+qH+nMC/Jv2QvDoGlHM8DaLKmea+ppkLOpt/TjR/90W6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OcJXGAEv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e1915e18so11495275e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Aug 2024 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724394820; x=1724999620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nwwa4zZWKWT0C7ngpvIXaYQp8a5Xf4joWxzD56LK+ns=;
        b=OcJXGAEvncq1vA++wqBA8XrMes7MqVuYJleTISB0jENgykYHprtV0bu7wSND9gD/qF
         f367NasEWjxNQvTThuy04t0GDrl69lWVWPrnZcJ7aAytt5aTy2j6zfYfvrn1tR2M1Da9
         GlPcAfa845erHh+CwxNhNy+ZozBQQxLGNVDzZFdEztI3Zo2PtiuPyH5OANSgybXThKw1
         SlyGXjOTMblUXQEQ7Yl3cI4txiw2rvuYgQ9r63pJaedwBog4sQzlz7c0ety1nLkB1OTR
         Z0aAU2qhLmXnQZVWAqGJJxJU5HMoLNOLE8svIkgY7DUU48PJ0lupfC6j0EPOZcNo1BXx
         BM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724394820; x=1724999620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwwa4zZWKWT0C7ngpvIXaYQp8a5Xf4joWxzD56LK+ns=;
        b=Ns6Yw65sdTRsXaVCfsUoHI4J2qcNtOnkBndZdPI40wRvWk6iZq244rkSlPNe/eD7fA
         n/qkcfUhQs66Yy6UNCRzmQJwfwIS/tCd7FpyZ3K1+GdFcpXD8vY3vFrtdkDMoNRv2qo3
         v5uVc6wkJoUKCg9kkSxnedB4zOehmzrpdGjGcRUYeXQ0By0H1RAiqNW8VTwolrDcJpQR
         H7vsuxMawqwQdsBRq9G0d5OTx43Ww1pEKy/MPkte/wJdTPmsCGCQmU6ocimcsluTuz7J
         777oLvMf1XsdUDvTLkAGirtbOnHl3J3XfOEGoaxX4T4k0LDv93I+cvuxFk8G14tpKof4
         16Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVKxCQjtlmwG6vlNjThpUfNiSxcd17bQIlkTRk+E4jc40g+r0P3OORZ1H2HOQt328EohJSS5c61NePo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1x8WiEgSZ8ym07xrHxmlphNPpc8INuS4Ma6tWkheKpT+M98NT
	+4gk1mnl8TTwQSnQIJeqRvoCNTgTJs/dWiObgDULrdLX9TSdaBGYR3X2KbWMm3g=
X-Google-Smtp-Source: AGHT+IE1rLgEUi/E+JRWhk5yegpaazjUMmQ/t/cN3D8r5PCsnRrmCPHJTAiKkoCLeX2MUJRaLJ7WWw==
X-Received: by 2002:a05:600c:4e01:b0:426:654e:16da with SMTP id 5b1f17b1804b1-42acd39e07cmr7246735e9.0.1724394820150;
        Thu, 22 Aug 2024 23:33:40 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8c2dbsm83828835e9.21.2024.08.22.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:33:39 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:03:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZsgtNbBLfP3SygYv@sunil-laptop>
References: <20240812005929.113499-9-sunilvl@ventanamicro.com>
 <20240822214415.GA351762@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822214415.GA351762@bhelgaas>

Hi Bjorn,

On Thu, Aug 22, 2024 at 04:44:15PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 12, 2024 at 06:29:20AM +0530, Sunil V L wrote:
> > RISC-V platforms need to use dependencies between PCI host bridge, Link
> > devices and the interrupt controllers to ensure probe order. The
> > dependency is like below.
> > 
> > Interrupt controller <-- Link Device <-- PCI Host bridge.
> > 
> > If there is no dependency between Link device and PCI Host Bridge,
> > then PCI devices may be probed prior to Link devices.  If a PCI
> > device is probed before its Link device, we won't be able to find
> > its INTx mapping.
> 
> This seems to explain why we want these dependencies, which is useful,
> but *this* patch only removes the dependencies.
> 
> Maybe this description should be in the patch that *adds* the
> dependencies, e.g., "ACPI: RISC-V: Implement function to add implicit
> dependencies"?
>
Okay. Let me move this to the patch you suggested.
 
> > So, add the link device's HID to dependency honor list and clear the
> > dependency after probe is done so that the dependent devices are
> > unblocked to probe.
> 
> This still claims this patch adds HID, which I don't think it does.
>
Please see below.
 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Tested-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
> > ---
> >  drivers/acpi/pci_link.c | 2 ++
> >  drivers/acpi/scan.c     | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > index aa1038b8aec4..b727db968f33 100644
> > --- a/drivers/acpi/pci_link.c
> > +++ b/drivers/acpi/pci_link.c
> > @@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
> >  	if (result)
> >  		kfree(link);
> >  
> > +	acpi_dev_clear_dependencies(device);
> > +
> >  	return result < 0 ? result : 1;
> >  }
> >  
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 28a221f956d7..753539a1f26b 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
> >  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
> >  	"RSCV0001", /* RISC-V PLIC */
> >  	"RSCV0002", /* RISC-V APLIC */
> > +	"PNP0C0F",  /* PCI Link Device */
This is the change which I meant adding HID to the honor list. Do you
recommend to make this change separate patch so that it doesn't confuse
with adding a new HID to the probe match table?

Thanks!
Sunil

