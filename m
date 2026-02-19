Return-Path: <linux-acpi+bounces-21016-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O92FIIxl2kcvgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21016-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 16:51:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CF160630
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A8F3047410
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Feb 2026 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A934A3CD;
	Thu, 19 Feb 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiFvl9yQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DD349B18;
	Thu, 19 Feb 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771516041; cv=none; b=u0pwKUJEPVklrzcrMTITRWoztv2+ZM/wujb2QEssByMR4smsAPEtxxH9P6RRGXJldSn+N16kpcrD7yCJt8D1PClinX0fgxzNHmdSijDKl8ObrmvYIDXoVacxbcx7QZGell/aYuYc8dcRqXBzrSavrv67RG19LP8FaV4gIHRClG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771516041; c=relaxed/simple;
	bh=6jZLbT+JuUsgAjaLJvA0T7UDOHhQK4+JWXfz+1inNe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tapOqTYsMmWwDTSom1DXnpA85L2mFsVsUkcVqKJriApFSYX6FuG1RK89yTEdBOT5l3GCGPSxUAZtwwFoINohyab+7mIbewj4Z247H9dRyUZymy2+5vIX0Gv0GRM1MMJX5stOp0sbbVyxBPVPHG1rjp76r8Kn94rXmSnRgGFRva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiFvl9yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02A2C4CEF7;
	Thu, 19 Feb 2026 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771516041;
	bh=6jZLbT+JuUsgAjaLJvA0T7UDOHhQK4+JWXfz+1inNe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiFvl9yQEqPgVMa17paCcsApkXqXxPDC9INi1Es2mmdAetSjEQ0C6iYgWwRZDGBPl
	 T5q2p4xK5DJSE+ax2Hoz09rQk5fv0YvwjEGmVz0trJeqhE3W3byvZuFumBEQl61ssF
	 cayjjGSqQU6eGeVGCmRc/OFBNOWfgPM8oDLWkPfGsgJ9+pQiEIOT68q6C90nwJatVP
	 4bvJDf/hfPBV7jkpsVOlipwi+COGGqHuMrFczDEr0ZpeQaaIcS7OkRpG/ESSwihg29
	 a6fD+1rduNex036MvIhfIfItvvcJH/+f4AWeHzq7IsUVYS1FkhqkXugAJjZrAXoMha
	 j+xsRubgHcR6A==
Date: Thu, 19 Feb 2026 16:47:09 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, huyuye <huyuye812@163.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn, wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn, Sunil V L <sunilvl@oss.qualcomm.com>
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
Message-ID: <aZcwfeG3y7EuLDzB@lpieralisi>
References: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
 <20260127194648.GA368841@bhelgaas>
 <aXtld38sQ9qFoNKk@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXtld38sQ9qFoNKk@sunil-laptop>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21016-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,163.com,google.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,intel.com,vger.kernel.org,lists.infradead.org,zte.com.cn,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lpieralisi@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE3CF160630
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:19:43PM +0530, Sunil V L wrote:
> On Tue, Jan 27, 2026 at 01:46:48PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 27, 2026 at 06:50:24PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Jan 27, 2026 at 6:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> > > > > On Mon, Jan 12, 2026 at 3:17 PM huyuye <huyuye812@163.com> wrote:
> > > > > >
> [...]
> 
> > > Not really.
> > > 
> > > acpi_dev_clear_dependencies() is related to the way Linux uses _DEP
> > > which is to defer the enumeration of dependent devices until the
> > > devices they depend on are ready.
> > > 
> > > So by calling acpi_dev_clear_dependencies() the driver basically
> > > allows other drivers to bind to devices.
> > 
> > I assumed the dependency expressed by _DEP would be satisfied by the
> > execution of some other ACPI method.  E.g., the dependency might be
> > satisfied when a _REG method makes an opregion available (although the
> > spec seems to suggest that's only one of the possible dependencies).
> > 
> > But in this case it sounds like RISC-V is using _DEP not because of
> > any ACPI-related ordering requirement, but simply to enforce the OS
> > enumeration order (and therefore naming).  I guess this refers to PCI
> > device naming, so I suppose that dependency is on
> > pci_acpi_scan_root().
> > 
> Right. Devices that use wired interrupts (or GSIs) depend on the APLIC
> interrupt controller being probed first. ACPI uses the _DEP mechanism to
> enforce this probe order. However, when multiple dependent PCI bridges
> are present in the system, there is no guarantee that they will be
> probed in the same order on every reboot. This patch addresses the issue
> by adding _DEP relationships between the PCI bridge nodes in the
> platform, ensuring that they are always probed in a deterministic
> order.
> 
> > I thought udev was supposed to be the real solution for consistent
> > naming.  Is this sort of a workaround to accomplish the same end?
> >
> Yes, Marc had suggested this as well, but it looks like it’s not easy to
> use in this environment [1].

FWIW I agree with Marc - I read [1] and still don't understand what the problem
is with implementing a udev set of rules to fix it.

> > In any case, your IS_ENABLED(CONFIG_RISCV) proposal seems fine to me.
> > I think it's nice if we can avoid adding another __weak function.
> > 
> I agree. But I am not sure if ARM also can get into this situation with
> GICv5. Adding Lorenzo.

It can happen with GICv5 but I don't think that's the point. It can happen
on any arch regardless of interrupt controller probe ordering and udev is
the de facto solution to this problem AFAIU, please correct me if I am wrong.

Lorenzo

