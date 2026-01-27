Return-Path: <linux-acpi+bounces-20676-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO4UJov1eGnYuAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20676-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:27:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F17E0986DC
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49AAD3011C7F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58B2E7BD9;
	Tue, 27 Jan 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+zOukIu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F12DF14B;
	Tue, 27 Jan 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534759; cv=none; b=VxowROiVHtZWeLd9MyPsCRuwE5+kag766DxjNDJnV6DxvbTrSQk3SCv7FGYnLDbXIa96z9IkPZTtz6+rjzs283/cYJD5svvo/mKqBQYXEbidKje/+DuLWXkg3/vsuk4OcnvneX73ghbCKvhJd1N4bT6wZEDSMiNMViHtI/9Crns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534759; c=relaxed/simple;
	bh=t/ydFRl1MmbIcWNVKHLGwRuO9FF4WkDsBr1/8JHY4s4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qkDCJ0+uvHoQXI30ZN50qvfd0tKVzKHxyO0Um1/UjNwbZfLLLeLVzRDgJWLITH29eMF92+UFypnlyIv/3WKLDx/yXjgClRqS3C8Wha9PD6fCj/2GSVLZGyhZWenYVCWZ76kqinPDBDM0j3Cauh+BG29D/VLxSDyDsmHLDipbx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+zOukIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452BFC116C6;
	Tue, 27 Jan 2026 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769534759;
	bh=t/ydFRl1MmbIcWNVKHLGwRuO9FF4WkDsBr1/8JHY4s4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q+zOukIug1vRhuzYf7KNMJ3WcKdiE325FzhZI/Jj6ni+swckuhql3g5kSCbltdEJC
	 8OspZU7ujKjis1YkKY4+NZjdtvtKRR510Fqyi7MGWCWfZMOx7WhNvjhTmXUi1k3YNt
	 FNqqBj8LKJ9vQHLozgwL8Wi1k/uO+9niMhewMCXOVsRnKX1dbNCQDjp8C4XG35bQA8
	 61Mv18mmaw0nVJwZX3TVa4cMmdy72HlEQXS4dhrGqT4eAIjLyi5XpmGq6xqxKN228d
	 /Yg0lEVl+WZJEme+q/UVcDarOpljm7aPuTk7U9GmrpT4s7Qjmljm0B0fKgozVGR6jd
	 pjAdz/JaE/hcA==
Date: Tue, 27 Jan 2026 11:25:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: huyuye <huyuye812@163.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn, wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
Message-ID: <20260127172557.GA364754@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ixBFGHwvSEp3Ae_s0tyhK338Gju=1+vb+O3_pH2mHyGA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20676-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,google.com,ventanamicro.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,intel.com,vger.kernel.org,lists.infradead.org,zte.com.cn];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zte.com.cn:email]
X-Rspamd-Queue-Id: F17E0986DC
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 12, 2026 at 3:17 PM huyuye <huyuye812@163.com> wrote:
> >
> > Hi Rafael,
> > Thank you for your thorough review and valuable comments on v1.
> > I've updated the patch as follows:
> > 1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled)
> > guard as you pointed out. The entire code block indeed already depends
> > on CONFIG_ACPI at a higher level, making the inner guard unnecessary.
> > 2. Moved acpi_dev_clear_dependencies to RISC-V specific architecture
> > code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI dependency
> > clearing is handled within the appropriate architectural context.
> >
> > Best regards
> > Signed-off-by: huyuye <huyuye812@163.com>
> > ---
> >  drivers/acpi/pci_root.c       |  6 ++++++
> >  drivers/acpi/riscv/Makefile   |  2 +-
> >  drivers/acpi/riscv/acpi_pci.c | 11 +++++++++++
> >  include/acpi/acpi_bus.h       |  1 +
> >  4 files changed, 19 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/acpi/riscv/acpi_pci.c
> >
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 9d7f85dadc48..a16eb9097cdc 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -30,6 +30,11 @@ static int acpi_pci_root_add(struct acpi_device *device,
> >                              const struct acpi_device_id *not_used);
> >  static void acpi_pci_root_remove(struct acpi_device *device);
> >
> > +
> > +void __weak arch_acpi_pci_root_add_clear_dep(struct acpi_device *device)
> > +{
> > +}
> > +
> >  static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
> >  {
> >         acpiphp_check_host_bridge(adev);
> > @@ -760,6 +765,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
> >         pci_lock_rescan_remove();
> >         pci_bus_add_devices(root->bus);
> >         pci_unlock_rescan_remove();
> > +       arch_acpi_pci_root_add_clear_dep(device);
> 
> Actually, this could be as simple as
> 
>        if (IS_ENABLED(CONFIG_RISCV))
>               acpi_dev_clear_dependencies(device);
> 
> with a brief comment explaining why it is needed.
> 
> Bjorn, any thoughts?

The justification ("If a host bridge B depends on host bridge A (via
_DEP), this call allows bridge B to proceed with enumeration after
bridge A is fully initialized") doesn't sound specific to RISC-V.

For that matter, it doesn't sound specific to host bridges either.

The _DEP spec language is a bit vague.  ACPI r6.6, sec 6.5.8, says:

  _DEP evaluates to a package and designates device objects that OSPM
  should assign a higher priority in start ordering due to
  dependencies between devices (for example, related to future
  operation region accesses).

I don't know what "device start" means.  It sounds like this alludes
to the order in which OSPM runs some device start method?  _INI?
Should acpi_dev_clear_dependencies() be done at the point where that
device start method is run?

> >         return 1;
> >
> >  remove_dmar:
> > diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> > index 1284a076fa88..5b1bd0298fb9 100644
> > --- a/drivers/acpi/riscv/Makefile
> > +++ b/drivers/acpi/riscv/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -obj-y                                  += rhct.o init.o irq.o
> > +obj-y                                  += rhct.o init.o irq.o acpi_pci.o
> >  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)      += cpuidle.o
> >  obj-$(CONFIG_ACPI_CPPC_LIB)            += cppc.o
> >  obj-$(CONFIG_ACPI_RIMT)                        += rimt.o
> > diff --git a/drivers/acpi/riscv/acpi_pci.c b/drivers/acpi/riscv/acpi_pci.c
> > new file mode 100644
> > index 000000000000..368ff113e5c6
> > --- /dev/null
> > +++ b/drivers/acpi/riscv/acpi_pci.c
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2026, ZTE Corporation
> > + *  Author: Yu Ye Hu <hu.yuye@zte.com.cn>
> > + */
> > +#include <linux/acpi.h>
> > +
> > +void arch_acpi_pci_root_add_clear_dep(struct acpi_device *device)
> > +{
> > +       acpi_dev_clear_dependencies(device);
> > +}
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index aad1a95e6863..c00b523a6ebd 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -996,6 +996,7 @@ int acpi_wait_for_acpi_ipmi(void);
> >
> >  int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
> >  u32 arch_acpi_add_auto_dep(acpi_handle handle);
> > +void arch_acpi_pci_root_add_clear_dep(struct acpi_device *device);
> >  #else  /* CONFIG_ACPI */
> >
> >  static inline int register_acpi_bus_type(void *bus) { return 0; }
> > --
> > 2.43.0
> >

