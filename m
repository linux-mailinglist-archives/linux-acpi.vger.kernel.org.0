Return-Path: <linux-acpi+bounces-20684-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MXsKSwWeWmyvAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20684-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:46:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD59A1A2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D1FE3017C1D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D9D326D50;
	Tue, 27 Jan 2026 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzVwAMjh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05790314B77;
	Tue, 27 Jan 2026 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543210; cv=none; b=nyB5p618ig3UuILGYlxVP1VnJnua2DT15B9u1nvUad5VvsoWar/+xuBKxL/S2aZtJJqv3RSs3zzx6wOh75QfUiRCp5I92wHHLbfJqrE2FLQ4oRTQpvyEmmEWBZ6+oUbpl7dZKa+Gt6OQBFA0T8drLTB6I5JS2ghnYXmMy+hWh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543210; c=relaxed/simple;
	bh=6zzqTvzS5DHCYoYSRUuj5mBiQsR0b51DagWgcJsJYhU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JRCk5o2iT4pA0ZfDmb6dxOx7TwesTa6eyfC8PY96hfBe6dFG2MXQeAPdaO59RM0BrBotjmqzBqSJQoXK5bUsKC9IMh/Qkl0R45kaOC4g+QPPZt0i2saae1rdFhCcw+SWWiARSddUbY14ORqhiX+kgaOT2tNCdpQq6XcN0kkfpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzVwAMjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91452C116C6;
	Tue, 27 Jan 2026 19:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769543209;
	bh=6zzqTvzS5DHCYoYSRUuj5mBiQsR0b51DagWgcJsJYhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rzVwAMjhzljCHaesiIHAsEth7UpXtkosTgOiArpsAlbB11kjmuQi8PFrwu+lPLHaB
	 uPNv8FcHMCX0RhjVcEcuqjCBvIHZ6FoZONsqUgyhsK/uHLxT3M2zJPfSIMgfnMicvQ
	 XzTy6f6UAKYw0zgkZsoTUmiZxRDy3MO24dlXIRuUcNS/63IAO4HS/KrGDVIzQvsuS8
	 lYBc1EwB39JbDPgulW0yfV0//G7DX/ZJHT22khTURGSsLCr7Bj+k2ZFhWtnrRfrkEp
	 GbesbUa/PqqBOrNhVZ3M9pv2Idma69X5779MqAGP64I4LAZ8vL8eAMoAgZHq/wHu1g
	 D+NpUC/+uogDQ==
Date: Tue, 27 Jan 2026 13:46:48 -0600
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
Message-ID: <20260127194648.GA368841@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20684-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[163.com,google.com,ventanamicro.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,intel.com,vger.kernel.org,lists.infradead.org,zte.com.cn];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0ABD59A1A2
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 06:50:24PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 27, 2026 at 6:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Jan 12, 2026 at 3:17 PM huyuye <huyuye812@163.com> wrote:
> > > >
> > > > Hi Rafael,
> > > > Thank you for your thorough review and valuable comments on v1.
> > > > I've updated the patch as follows:
> > > > 1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled)
> > > > guard as you pointed out. The entire code block indeed already depends
> > > > on CONFIG_ACPI at a higher level, making the inner guard unnecessary.
> > > > 2. Moved acpi_dev_clear_dependencies to RISC-V specific architecture
> > > > code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI dependency
> > > > clearing is handled within the appropriate architectural context.
> > > >
> > > > Best regards
> > > > Signed-off-by: huyuye <huyuye812@163.com>
> > > > ---
> > > >  drivers/acpi/pci_root.c       |  6 ++++++
> > > >  drivers/acpi/riscv/Makefile   |  2 +-
> > > >  drivers/acpi/riscv/acpi_pci.c | 11 +++++++++++
> > > >  include/acpi/acpi_bus.h       |  1 +
> > > >  4 files changed, 19 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/acpi/riscv/acpi_pci.c
> > > >
> > > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > > index 9d7f85dadc48..a16eb9097cdc 100644
> > > > --- a/drivers/acpi/pci_root.c
> > > > +++ b/drivers/acpi/pci_root.c
> > > > @@ -30,6 +30,11 @@ static int acpi_pci_root_add(struct acpi_device *device,
> > > >                              const struct acpi_device_id *not_used);
> > > >  static void acpi_pci_root_remove(struct acpi_device *device);
> > > >
> > > > +
> > > > +void __weak arch_acpi_pci_root_add_clear_dep(struct acpi_device *device)
> > > > +{
> > > > +}
> > > > +
> > > >  static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
> > > >  {
> > > >         acpiphp_check_host_bridge(adev);
> > > > @@ -760,6 +765,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
> > > >         pci_lock_rescan_remove();
> > > >         pci_bus_add_devices(root->bus);
> > > >         pci_unlock_rescan_remove();
> > > > +       arch_acpi_pci_root_add_clear_dep(device);
> > >
> > > Actually, this could be as simple as
> > >
> > >        if (IS_ENABLED(CONFIG_RISCV))
> > >               acpi_dev_clear_dependencies(device);
> > >
> > > with a brief comment explaining why it is needed.
> > >
> > > Bjorn, any thoughts?
> >
> > The justification ("If a host bridge B depends on host bridge A (via
> > _DEP), this call allows bridge B to proceed with enumeration after
> > bridge A is fully initialized") doesn't sound specific to RISC-V.
> 
> But there are no _DEP dependencies between host bridgers on other
> architectures in practice.
> 
> acpi_dev_clear_dependencies() could be called unconditionally here,
> but it would be useless overhead if no such dependencies existed.
> 
> > For that matter, it doesn't sound specific to host bridges either.
> 
> No, it is not specific to host bridges.
> 
> > The _DEP spec language is a bit vague.  ACPI r6.6, sec 6.5.8, says:
> >
> >   _DEP evaluates to a package and designates device objects that OSPM
> >   should assign a higher priority in start ordering due to
> >   dependencies between devices (for example, related to future
> >   operation region accesses).
> >
> > I don't know what "device start" means.  It sounds like this alludes
> > to the order in which OSPM runs some device start method?  _INI?
> > Should acpi_dev_clear_dependencies() be done at the point where that
> > device start method is run?
> 
> Not really.
> 
> acpi_dev_clear_dependencies() is related to the way Linux uses _DEP
> which is to defer the enumeration of dependent devices until the
> devices they depend on are ready.
> 
> So by calling acpi_dev_clear_dependencies() the driver basically
> allows other drivers to bind to devices.

I assumed the dependency expressed by _DEP would be satisfied by the
execution of some other ACPI method.  E.g., the dependency might be
satisfied when a _REG method makes an opregion available (although the
spec seems to suggest that's only one of the possible dependencies).

But in this case it sounds like RISC-V is using _DEP not because of
any ACPI-related ordering requirement, but simply to enforce the OS
enumeration order (and therefore naming).  I guess this refers to PCI
device naming, so I suppose that dependency is on
pci_acpi_scan_root().

I thought udev was supposed to be the real solution for consistent
naming.  Is this sort of a workaround to accomplish the same end?

In any case, your IS_ENABLED(CONFIG_RISCV) proposal seems fine to me.
I think it's nice if we can avoid adding another __weak function.

Bjorn

