Return-Path: <linux-acpi+bounces-1057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8827D9870
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE36A1C20ED8
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 12:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB01EB21
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FkLUCTFa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598DF18AE4
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 11:29:34 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7984F129
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 04:29:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso247882a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698406172; x=1699010972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI28YtitrNIniIpGPiCXYWH3fIICBsHFcX18SbMwXaI=;
        b=FkLUCTFaZcySOAam9iz6DHlyvMFgwb0dciaQzfdEKzSevC6tu7bXghqDN03SvNdfXI
         TpVwftwoRNylOP52CRKkfEd+HY6JOQtmKcnBIu1bAyG/Ld23VYJTHCS830eXVN/+1WBM
         kaAWuFHIbGb+5FObTqY8EYp0t1xctpoP6eFlbLuTew1V6TZOKIBp1igLyRcrviXNXMzZ
         sLDZszDFDI7J368kdHkZ+dvHbQnlRjH9r8pmTeCi5gny46waklCU9d/weTWNNrqjP2wr
         EkuRxqDu1n98QeIm87t0zIce4WfpuNi1WOKztgx7E1VzD51Vg5wY81r+AEulrqMDvYHq
         c9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698406172; x=1699010972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI28YtitrNIniIpGPiCXYWH3fIICBsHFcX18SbMwXaI=;
        b=cQYkLMNASnjBe4ki8RS+Wu4O5jzPkkxM02OxAUuJiL+ppLyZscOtV9BiCv9sQLvhGX
         fULPyIRWZ5g9nP9+8NeLMmVEBE1XeVx+ZVgduacfN90FVFVp7ZAZAI5LfMYLM+0R88UM
         uX2AxKKiefQ7XDu+505L+6KTmGt0q1IAqu7J9w3SjqZ0YTBLldYWu/4Q4u4X6R8oaJfk
         lpTS1Ccd4bRC2u/8o1L1OoNDCz8drp4hDQs1rrfGGsJQhqh1y3bV/dVOgvfUbqrw9EEC
         8AAhIxwT8vMd5ryjkMvwGqu6+dOGyPPLJhMnTRYqX/EeZpp6//q+iQxS0p3/8zCj4HD1
         bOSg==
X-Gm-Message-State: AOJu0Yxg2IBqK7pCnKAslMOyzOQ9OJL/V8KN0JjwW40dbvLinbQRsLlC
	KgttpfYniSu/bKVyV/meaGCVHA==
X-Google-Smtp-Source: AGHT+IG13tL5qlADUCcZnk0Slm9dLAj/0ICfwInuvtA89OSHyk/VCX3hGHfCAQFvPk1ScgHB/OgdWA==
X-Received: by 2002:a17:90b:100b:b0:27d:1051:83c4 with SMTP id gm11-20020a17090b100b00b0027d105183c4mr2196967pjb.12.1698406171798;
        Fri, 27 Oct 2023 04:29:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id r65-20020a17090a43c700b0028018af8dc2sm252642pjg.23.2023.10.27.04.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:29:31 -0700 (PDT)
Date: Fri, 27 Oct 2023 16:59:19 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZTufD/InY/gwpE+Q@sunil-laptop>
References: <20231025202344.581132-14-sunilvl@ventanamicro.com>
 <20231026165150.GA1825130@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026165150.GA1825130@bhelgaas>

Hi Bjorn,

On Thu, Oct 26, 2023 at 11:51:50AM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
> > The RINTC subtype structure in MADT also has information about other
> > interrupt controllers like MMIO. So, save those information and provide
> > interfaces to retrieve them when required by corresponding drivers.
> 
> > @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> 
> > +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
> > +	 * IMSIC is discovered, set system wide MSI support as
> > +	 * unsupported. Once IMSIC is probed, MSI support will be set.
> > +	 */
> > +	pci_no_msi();
> 
> It doesn't seem like we should have to tell the PCI core about
> functionality we *don't* have.
> 
> I would think IMSIC would be detected before enumerating PCI devices
> that might use it, and if we *haven't* found an IMSIC by the time we
> get to pci_register_host_bridge(), would/should we set
> PCI_BUS_FLAGS_NO_MSI there?
>
The check in pci_register_host_bridge() is like below.

if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
            !pci_host_of_has_msi_map(parent))
                bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;

When there is no IMSIC, bridge->msi_domain is 0 and hence
PCI_BUS_FLAGS_NO_MSI will never be set. Do you recommend to set
PCI_BUS_FLAGS_NO_MSI if bridge->msi_domain is 0? Let me know if I am
missing something.

Thanks,
Sunil

