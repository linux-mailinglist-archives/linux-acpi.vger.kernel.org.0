Return-Path: <linux-acpi+bounces-20678-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGuqMDP7eGlfuQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20678-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:51:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455698A78
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0C6303FF33
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC843115B1;
	Tue, 27 Jan 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz8wkdhf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846113254BC
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536239; cv=none; b=PzjhAtXVUsutovnx04WYWh4L1e0z+1IDdo9gnBGtrvsG35DLxXORg9rIi8wXVi1X3HfUzBKaLComPJuvwuP5tuO3ogRaZsXBvf9lf3DMA4mjoJJ4T3s23jKofv0bGi3p5IH/LXlZvjFFQFix/xpYs580OgbJojfwEEyUnMN9t5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536239; c=relaxed/simple;
	bh=vMhVuToLIag3bSMP5xMCZderMPeMrUpStjag0O75BxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKLr9B8cyaCoEpd0PWK8dI+TozU3rL8JPrpwAGcgQs88kGbA1yVW+rTaqsIqsjvW8e4e2w1qm6mFWKndIG/KDH22UvgZHbMEuMrRXX7ZeEVCt8yG6CdquSqD7MCn8rCyzCgY8Jsq8N7ZSsX3MAnOhny6mhjNGTsMo3NydaskVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz8wkdhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6B7C2BCB0
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536239;
	bh=vMhVuToLIag3bSMP5xMCZderMPeMrUpStjag0O75BxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qz8wkdhfyK8A+2Af8FXEmFdvklwXjP2iLe3Umozm2CpLEnwER2YvfVqDrbkHiwPtk
	 TUYc3TrE2jppxdgPyfd1sLjvj0kn2pCd8AXOB5jmSXGFQlPS1l0GYg4mXDwezc0bah
	 VMwVy/1D/HpDRhb+fvYpRbhdaBdsrrLEU0F4i6GHQaiDphm7EPjUnsf7OxQLgFgcts
	 YDtrsRAqOqaJAQYuklEsYcdI7RyA1+xoNbS1h8CaP4cmo6XTfTLA2RUWr4V6+TZEbf
	 F8DEIqOMGBBtAK5iJ5QEk4REM3HnvL2DjYawDqxZLJ4BdaiaZIwoOicQOvK+S0nlbS
	 bVr6Iid+6WLew==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45efe81556fso433120b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 09:50:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfnOuYpqLQtsplyX29MoKtqHocIbRngONP8Kqiy7CRc36l7m0zfW7xqY9cn0QrD+p8syUi4qUfxWeH@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvVOT13O6C+EIsGEjJNBy5IjJ060E1JHvnTVwUJXI92xy478K
	6Is5rC7X+OkApenxQq87ezYATDbSxF+ijqj1XevVR1bhrknMCk+15BRsndOHeFaxyqRqIVnGalg
	l1fgxN6+wHi7Fbw5rHtgd5zpR7hCPIRM=
X-Received: by 2002:a05:6808:250a:b0:45e:dbc7:2cce with SMTP id
 5614622812f47-45efc4a9c66mr1563505b6e.7.1769536238219; Tue, 27 Jan 2026
 09:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0ixBFGHwvSEp3Ae_s0tyhK338Gju=1+vb+O3_pH2mHyGA@mail.gmail.com>
 <20260127172557.GA364754@bhelgaas>
In-Reply-To: <20260127172557.GA364754@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 18:50:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
X-Gm-Features: AZwV_QgiG--Rm2Nj4QEnZklC8c4MsqiqsLSdiwY26DiPpRQjB7sBwYL6cIEaQKo
Message-ID: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, huyuye <huyuye812@163.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn, 
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn, liu.qingtao2@zte.com.cn, 
	wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn, 
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn, li.kunpeng@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20678-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,163.com,google.com,ventanamicro.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,intel.com,vger.kernel.org,lists.infradead.org,zte.com.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2455698A78
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 6:26=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM huyuye <huyuye812@163.com> wrot=
e:
> > >
> > > Hi Rafael,
> > > Thank you for your thorough review and valuable comments on v1.
> > > I've updated the patch as follows:
> > > 1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled)
> > > guard as you pointed out. The entire code block indeed already depend=
s
> > > on CONFIG_ACPI at a higher level, making the inner guard unnecessary.
> > > 2. Moved acpi_dev_clear_dependencies to RISC-V specific architecture
> > > code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI dependenc=
y
> > > clearing is handled within the appropriate architectural context.
> > >
> > > Best regards
> > > Signed-off-by: huyuye <huyuye812@163.com>
> > > ---
> > >  drivers/acpi/pci_root.c       |  6 ++++++
> > >  drivers/acpi/riscv/Makefile   |  2 +-
> > >  drivers/acpi/riscv/acpi_pci.c | 11 +++++++++++
> > >  include/acpi/acpi_bus.h       |  1 +
> > >  4 files changed, 19 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/acpi/riscv/acpi_pci.c
> > >
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index 9d7f85dadc48..a16eb9097cdc 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -30,6 +30,11 @@ static int acpi_pci_root_add(struct acpi_device *d=
evice,
> > >                              const struct acpi_device_id *not_used);
> > >  static void acpi_pci_root_remove(struct acpi_device *device);
> > >
> > > +
> > > +void __weak arch_acpi_pci_root_add_clear_dep(struct acpi_device *dev=
ice)
> > > +{
> > > +}
> > > +
> > >  static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
> > >  {
> > >         acpiphp_check_host_bridge(adev);
> > > @@ -760,6 +765,7 @@ static int acpi_pci_root_add(struct acpi_device *=
device,
> > >         pci_lock_rescan_remove();
> > >         pci_bus_add_devices(root->bus);
> > >         pci_unlock_rescan_remove();
> > > +       arch_acpi_pci_root_add_clear_dep(device);
> >
> > Actually, this could be as simple as
> >
> >        if (IS_ENABLED(CONFIG_RISCV))
> >               acpi_dev_clear_dependencies(device);
> >
> > with a brief comment explaining why it is needed.
> >
> > Bjorn, any thoughts?
>
> The justification ("If a host bridge B depends on host bridge A (via
> _DEP), this call allows bridge B to proceed with enumeration after
> bridge A is fully initialized") doesn't sound specific to RISC-V.

But there are no _DEP dependencies between host bridgers on other
architectures in practice.

acpi_dev_clear_dependencies() could be called unconditionally here,
but it would be useless overhead if no such dependencies existed.

> For that matter, it doesn't sound specific to host bridges either.

No, it is not specific to host bridges.

> The _DEP spec language is a bit vague.  ACPI r6.6, sec 6.5.8, says:
>
>   _DEP evaluates to a package and designates device objects that OSPM
>   should assign a higher priority in start ordering due to
>   dependencies between devices (for example, related to future
>   operation region accesses).
>
> I don't know what "device start" means.  It sounds like this alludes
> to the order in which OSPM runs some device start method?  _INI?
> Should acpi_dev_clear_dependencies() be done at the point where that
> device start method is run?

Not really.

acpi_dev_clear_dependencies() is related to the way Linux uses _DEP
which is to defer the enumeration of dependent devices until the
devices they depend on are ready.

So by calling acpi_dev_clear_dependencies() the driver basically
allows other drivers to bind to devices.

