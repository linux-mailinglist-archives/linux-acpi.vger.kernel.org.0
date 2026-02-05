Return-Path: <linux-acpi+bounces-20865-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBXQE8i5hGnG4wMAu9opvQ
	(envelope-from <linux-acpi+bounces-20865-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 16:39:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EDCF4AF7
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 16:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A8AE300DA43
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93831421F1B;
	Thu,  5 Feb 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqdY2Jqr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70949410D3B;
	Thu,  5 Feb 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305971; cv=none; b=thqXDH0ZQxm/o0e4YWCwgYY9h/vp71uPTIb8J/hpfinbw1yS7sIRGuJyfJRmQ82CpN4trLxmnrnH6EMTqbHO5wlgSCrJ6MrUurp9MYCvPGZdUMDO4RA4Whr0xCUsrSIFPs4xHmWPX7SKxVVKns6+A8XVEMcn5GcTjzgzVN5FNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305971; c=relaxed/simple;
	bh=R44qjdQeuJLwXIuUlveykWRLl4w5yLSopZONz5WJ90A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=opFx7VYGEhW6CQ2Vlq0upnMpO/H5ScGA7FCyn1KyC0oajPyh6Zyo7QhtBQqAfnh6E9usFkrHcgeYo9GWPaYddjGDJsqgbBE/Sf3bpWsFPDJme9VbsPpZPEf6J1AkVDd8uQ3trT4nmyJwmQlS2ZS20ydlToGaTmri9mYNKWFT0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqdY2Jqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258B1C4CEF7;
	Thu,  5 Feb 2026 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770305971;
	bh=R44qjdQeuJLwXIuUlveykWRLl4w5yLSopZONz5WJ90A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JqdY2JqrxomK4oZPek2GbcBdUlmLDFaoxSdvcQV/1wr39GubAtyrEGEn+HeS6umdf
	 FciJUyeJyq1VxaZ7WjHXgArpl4owYdIazmBLTRMlNSslVzQVhn6jyFo5I4EqP0SLM4
	 8j4NRFZXYiT8O4M5jXpLj+4lsf1EBkxnYjCRvTHePNaLM6w9PCfFMjcNPSbvvNCvSG
	 ImYGyrZW/zADWtF6eVqf6x0IU9qy6tfmdJPeamDi1PyFvdIxvYAOyLN38WjeceMPAJ
	 2hni2YqVQgpOt9c4x20c5paWZiqjiCyEAbU/hoNV7XWeYW94uG0LsiKemkXM7P0+Ot
	 3xlyHgfOPbJGQ==
Date: Thu, 5 Feb 2026 09:39:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	'Tony Luck' <tony.luck@intel.com>, 'Borislav Petkov' <bp@alien8.de>,
	'Hanjun Guo' <guohanjun@huawei.com>,
	'Mauro Carvalho Chehab' <mchehab@kernel.org>,
	'Shuai Xue' <xueshuai@linux.alibaba.com>,
	'Len Brown' <lenb@kernel.org>, 'Shiju Jose' <shiju.jose@huawei.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in
 ghes_estatus_pool_region_free
Message-ID: <20260205153929.GA39360@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a701dc964d$0f0c1310$2d243930$@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20865-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4EDCF4AF7
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:11:02AM +0800, Jiawen Wu wrote:
> On Thu, Feb 5, 2026 5:46 AM, Bjorn Helgaas wrote:
> > On Wed, Feb 04, 2026 at 10:03:34AM +0800, Jiawen Wu wrote:
> > > On Wed, Feb 4, 2026 6:55 AM, Bjorn Helgaas wrote:
> > > > On Tue, Feb 03, 2026 at 10:12:32AM +0800, Jiawen Wu wrote:
> > > > > The function ghes_estatus_pool_region_free() is exported and
> > > > > be called by the PCIe AER recovery path, which
> > > > > unconditionally invokes it to free aer_capability_regs
> > > > > memory.
> > > > >
> > > > > Although current AER usage assumes memory comes from the
> > > > > GHES pool, robustness requires guarding against pool
> > > > > unavailability. Add a NULL check before calling
> > > > > gen_pool_free() to prevent crashes when the pool is not
> > > > > initialized. This also makes the API safer for potential
> > > > > future use by non-GHES callers.
> > > >
> > > > I'm not sure what you mean by "pool unavailability."  I think
> > > > getting here with ghes_estatus_pool==NULL means we have a
> > > > logic error somewhere, and I don't think we should silently
> > > > hide that error.
> > > >
> > > > I'm generally in favor of *not* checking so we find out if the
> > > > caller forgot to keep track of the pointer correctly.
> > >
> > > "pool unavailability" means that when I attempt to call
> > > aer_recover_queue() in a ethernet driver, which does not create
> > > ghes_estatus_pool, it leads to a NULL pointer dereference.
> > 
> > I guess that means you contemplate having an ethernet driver
> > allocate and manage its own struct aer_capability_regs to pass to
> > aer_recover_queue().  But I don't understand why such a driver
> > would be involved in this part of the AER processing.
> > 
> > Normally a device like a NIC that detects an error logs something
> > in its local AER Capability, then sends an ERR_* message upstream.
> > The Root Port that receives that ERR_* message generates an
> > interrupt.  In the native AER case, the Linux AER driver handles
> > that interrupt, reads the error logs from the AER Capability of
> > the device that sent the ERR_* message, and logs it.  In the
> > firmware-first case used by GHES, platform firmware handles the
> > interrupt, reads the error logs, packages them up, and sends them
> > to the Linux AER driver via GHES and aer_recover_queue().
> > 
> > What's the PCIe hardware flow that would lead to an ethernet
> > driver calling aer_recover_queue()?  An Endpoint driver wouldn't
> > receive the AER interrupt generated by the Root Port.
> > 
> > I suppose a NIC could generate its own device-specific interrupt
> > when it logs an error in its local AER Capability, but if it
> > conforms to the PCIe spec, it should also send an ERR_* message,
> > which would feed into the existing AER path.  I don't think we'd
> > want the existing AER path racing with a parallel AER path in the
> > Endpoint driver.
> 
> Thank you for your detailed explanation.
> 
> I fully agree that aer_recover_queue() is intended for
> firmware-first error reporting via GHES, and an endpoint driver
> should not normally invoke it directly.
> 
> However, in practice, we've encountered platforms where AER
> interrupts are not delivered reliably. For example, due to BIOS
> misconfiguration, disabled AER in firmware, or hardware that fails
> to generate ERR_* messages correctly. On such systems, when a PCIe
> error occurs, the standard AER path is never triggered, and the
> device remains in a stuck state.
> 
> To verify this, I simulated a PCIE error by injecting it into the
> NIC register.  But the Linux AER driver didn't respond at all, on
> many platforms.
> 
> As a device driver, we'd like to ensure best-effort recovery
> regardless of platform AER support. Since pcie_do_recovery()
> encapsulates the complete and correct recovery sequence, it's
> exactly what we need-but it's not exported.
> 
> Given this, could you advise on the proper way for an endpoint
> driver to initiate full PCIe error recovery when AER is unavailable?
> Is there a recommended pattern that safely achieves the same effect
> as pcie_do_recovery() without duplicating its logic?

It makes sense to try to work around broken hardware, and I think we
should try to identify exactly what is broken and address it directly.

If the NIC itself is broken, the problem should happen on every
platform, and a quirk or the driver might be the best place to deal
with it.

If the platform is broken, we should see problems with many devices,
and it would be better to deal with it more centrally instead of a
single endpoint driver.

I know about several platforms that don't support the architected AER
interrupt, e.g.,
https://lore.kernel.org/all/20250702223841.GA1905230@bhelgaas/t/#u
There is some work in progress to address this particular problem.

Do you have any specifics about the devices and platforms where you're
seeing issues?

Bjorn


