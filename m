Return-Path: <linux-acpi+bounces-1058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF07D9873
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F091C20F29
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189228DB2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="StVDK6iW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D9BA50
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 11:55:08 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5CD48
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 04:55:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c87a85332bso17550355ad.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698407703; x=1699012503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5FujhKIaH/uwx0lIrEstVD0nII/dzmNIeNJ8ebqYu0=;
        b=StVDK6iWENOIw4cbhc1kGnRGHoFOc+mmrjv3JwtRZMaGFn6+6vv1FCNwb9w+V1F9lF
         X+fCT1jk9DSxIIMBWzhcis5IcSUn6wvFM2mgb+hDXzkEEddNoSnXJ5seAJG3sIMafw70
         GXzinIDEgB3EJ/ka2nAJzSjgTFE6xIC1bx/qpxBSNOCoD+OdKQM3INsvkQc55IaqodfW
         vyY8uLyrndhYDr/4vpABnT00QCaw9BLbck4k2IoRC2RYdeoVdTqd6/MSd+iUqq408SDK
         fofxJnHChiqm/zSWNkBCj017d+6VVAMtLPob7rXYl/fuNwX6jCMqdrKfLG4kdW61d0qS
         1njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407703; x=1699012503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5FujhKIaH/uwx0lIrEstVD0nII/dzmNIeNJ8ebqYu0=;
        b=FYGZ5vJWUgFdILRByhhu4qE3nBzWaH/lIu1zCLVq13it/vhnrgpyxjDMHZT4iVM7Zl
         UheFgRTveS98/S6neBRI9yhjkBO9nNmzzpc0iVZ6Ejj6ivMibdcPWcwn84yRGq71wz6X
         vhh1WLammpmAVnG6KCgtuYCcE4hzi6j0VcNoHi3T81TW92omTaI2iOrrAxu98liNiZBv
         k6Pgyh8T3z3PR9ejfMEEB7DcZRTtTdZM7g8Xx1xVFh7X6aCedtDeB5TRg5wWmc4RaNmZ
         JAopQhSKIjC085WchshCKTm8ft5xrTz3l/oneYc8uIGJpb0HJw2+juqdhsstIx03jXWi
         a+xA==
X-Gm-Message-State: AOJu0YxLHX3eLX3EhD3PGUUoSDy+V9TfZmYgb6gFJuJuipeqDiaAcaZx
	E7NVNhGjNJUTeSfmEhhsVWdlag==
X-Google-Smtp-Source: AGHT+IHUO3uODEbp/2xpVvuNkWZLUzFgyUmu6ctAkgCEdcwdjl1R6oJFy7lgIUS+r693E6SqK+uHMg==
X-Received: by 2002:a17:902:cf41:b0:1ca:7086:60f7 with SMTP id e1-20020a170902cf4100b001ca708660f7mr3256113plg.28.1698407703704;
        Fri, 27 Oct 2023 04:55:03 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001b9f032bb3dsm1424132pln.3.2023.10.27.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:55:03 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:24:51 +0530
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
Message-ID: <ZTulC3tUuTm92/Li@sunil-laptop>
References: <20231025202344.581132-14-sunilvl@ventanamicro.com>
 <20231026165150.GA1825130@bhelgaas>
 <ZTufD/InY/gwpE+Q@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTufD/InY/gwpE+Q@sunil-laptop>

On Fri, Oct 27, 2023 at 04:59:31PM +0530, Sunil V L wrote:
> Hi Bjorn,
> 
> On Thu, Oct 26, 2023 at 11:51:50AM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
> > > The RINTC subtype structure in MADT also has information about other
> > > interrupt controllers like MMIO. So, save those information and provide
> > > interfaces to retrieve them when required by corresponding drivers.
> > 
> > > @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> > 
> > > +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
> > > +	 * IMSIC is discovered, set system wide MSI support as
> > > +	 * unsupported. Once IMSIC is probed, MSI support will be set.
> > > +	 */
> > > +	pci_no_msi();
> > 
> > It doesn't seem like we should have to tell the PCI core about
> > functionality we *don't* have.
> > 
> > I would think IMSIC would be detected before enumerating PCI devices
> > that might use it, and if we *haven't* found an IMSIC by the time we
> > get to pci_register_host_bridge(), would/should we set
> > PCI_BUS_FLAGS_NO_MSI there?
> >
> The check in pci_register_host_bridge() is like below.
> 
> if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
>             !pci_host_of_has_msi_map(parent))
>                 bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> 
> When there is no IMSIC, bridge->msi_domain is 0 and hence
> PCI_BUS_FLAGS_NO_MSI will never be set. Do you recommend to set
> PCI_BUS_FLAGS_NO_MSI if bridge->msi_domain is 0? Let me know if I am
> missing something.
> 
What seems to work is, setting bridge->msi_domain = true in
pci_create_root_bus() similar to how pci_host_common_probe() sets for OF
framework. Would that be better solution?

Thanks,
Sunil

