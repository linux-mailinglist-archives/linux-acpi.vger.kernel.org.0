Return-Path: <linux-acpi+bounces-20859-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZiazIoIKhGl5xQMAu9opvQ
	(envelope-from <linux-acpi+bounces-20859-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 04:12:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0200FEE35D
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 04:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9395B3002306
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 03:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA732C21C1;
	Thu,  5 Feb 2026 03:11:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190F22301;
	Thu,  5 Feb 2026 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261117; cv=none; b=S6oy+mCehBGGZale5z3QElHBXDVa56xZ8+s9dXxFT6vxv0zTMNSNrEj+wudA2Bz1B4q3QdIqRRG4DuU5g+HfyEfPA/YWGGFxdfKehF5jq6xd18A5a6iVbZjF7vESzH+1pWOiEwmBFfKjG3IRli802Pni6fhM80C9zUuOqcx0Vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261117; c=relaxed/simple;
	bh=tdcT9d6Ulb6bJp6Iwr41iIbhSSo00n9iFwjHBhaWh4E=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JrTzZe6yEiaqbxpLGk/LSDsKCSuE3mrAVwTBmlzFNKx4sv1/1AUXitd5lEiPO1DI4/09vaiva2HoAa8M0DtMvyb1fBZn8gYeDSb5tl3egArasYicTpbOFa/Ogz0yN4+lIm6NBR/4P2POH5EbEx194xxiP9c1tgzLgrO7KBpHrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1770261063t216t55729
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3806064462394497
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Tony Luck'" <tony.luck@intel.com>,
	"'Borislav Petkov'" <bp@alien8.de>,
	"'Hanjun Guo'" <guohanjun@huawei.com>,
	"'Mauro Carvalho Chehab'" <mchehab@kernel.org>,
	"'Shuai Xue'" <xueshuai@linux.alibaba.com>,
	"'Len Brown'" <lenb@kernel.org>,
	"'Shiju Jose'" <shiju.jose@huawei.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Tony Luck'" <tony.luck@intel.com>,
	"'Borislav Petkov'" <bp@alien8.de>,
	"'Hanjun Guo'" <guohanjun@huawei.com>,
	"'Mauro Carvalho Chehab'" <mchehab@kernel.org>,
	"'Shuai Xue'" <xueshuai@linux.alibaba.com>,
	"'Len Brown'" <lenb@kernel.org>,
	"'Shiju Jose'" <shiju.jose@huawei.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <06ed01dc957a$7823c0b0$686b4210$@trustnetic.com> <20260204214604.GA17868@bhelgaas>
In-Reply-To: <20260204214604.GA17868@bhelgaas>
Subject: RE: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in ghes_estatus_pool_region_free
Date: Thu, 5 Feb 2026 11:11:02 +0800
Message-ID: <07a701dc964d$0f0c1310$2d243930$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJdagHdXnF9bnaF3NMLB0e73wbeZrRxwfEQ
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MYha8DeKTomkiaPZZ5ku871BEON8y3Vjdmc/AzBG449tzhIBcPR3ZjK/
	LgVwxbwmowodWjuIwrcnDyA/hwkrstkaR5XG0lzYrzRmBx+PVkOORGDvMin3YhxsE062CFd
	BPpzzmfCCwGsc999DP0Mvxom+78KXkrqk9CEK6y6PwjqCEN5kbpM2DatT3nZcerbvGafuLC
	VahrsbWBAL7JEPcg47nAiV91VnxJtCrnusuFzkHoVNkNvSpGi+KGjNlGQwzD/TXY2e1mgfI
	Pxsb0xXpazwk0T77A+CI7FWCRyfZrPzwdqyKX6McoAAQ/r7Vjx2c6XQ7JNfmZ7hba6FXXU/
	aMJyTaZop4jzyQ/V0EBpjM9nRU5aBxJIHLHxDpEPnSSFIbmvyUwj2NqgWSRB52Czuhnvhh0
	6R6PN5+lDaqDqOSfzFhQGzmLHVVHGOFWfrd5b57qhvyBeyE7LpBU963UeIFIrsqdFwPGLAM
	2MWafojuUbwj6pTIGqGFNoMJEcpPGG2YDLViIE03EJXHOuOmJEPKGiCIhqKHtn3CGKSo/5A
	dzngOfhVk/+yzB593jZEB8f4+9hqzm2q8obTe/dean0PkQDM9s9b540471f9aKWbNL4obQS
	eVWlUjaOTPS8L++CRZ/j5lkU2U09xxLKmS9BYMEwlv+N3hhuOP3inPLMf41T6HY3xrskBoP
	krxxzDwAkKZLU0gwMllDUEbIxZjzt0TR9QBZSISJy4YplU2RlkXqV2Rz+UkyfR8kLHRZ83D
	bC68AsHqbfJITSO0WXRKHdfvfmu/fwlolqup6PFUYvRbTOtuMTtM8aT/7u5K8lJg6g3mv41
	XKEpe0CvAaXIVBNGlWyXQTHSFz0Tx2KcPabyJPQM/2D9TQF5+OoAAwfhIzjycPyKZAoAsuy
	hLZAuZLVHFkgkP2IXPGM8NjVegQfgIqB3+46tDRbj4fPC53R2OBzbSJL00aAqeFzwZoIYsv
	Np4AuM9LnVaSNq+mSw3xwqXsfInIilV9NSXhJAfo8S7u2Z2vbpRZAk61MfF/B7QyznNc98x
	FWvQMyNC3PlN3y31htAKAmwaem+PU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20859-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0200FEE35D
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 5:46 AM, Bjorn Helgaas wrote:
> On Wed, Feb 04, 2026 at 10:03:34AM +0800, Jiawen Wu wrote:
> > On Wed, Feb 4, 2026 6:55 AM, Bjorn Helgaas wrote:
> > > On Tue, Feb 03, 2026 at 10:12:32AM +0800, Jiawen Wu wrote:
> > > > The function ghes_estatus_pool_region_free() is exported and be called
> > > > by the PCIe AER recovery path, which unconditionally invokes it to free
> > > > aer_capability_regs memory.
> > > >
> > > > Although current AER usage assumes memory comes from the GHES pool,
> > > > robustness requires guarding against pool unavailability. Add a NULL check
> > > > before calling gen_pool_free() to prevent crashes when the pool is not
> > > > initialized. This also makes the API safer for potential future use by
> > > > non-GHES callers.
> > >
> > > I'm not sure what you mean by "pool unavailability."  I think getting
> > > here with ghes_estatus_pool==NULL means we have a logic error
> > > somewhere, and I don't think we should silently hide that error.
> > >
> > > I'm generally in favor of *not* checking so we find out if the caller
> > > forgot to keep track of the pointer correctly.
> >
> > "pool unavailability" means that when I attempt to call
> > aer_recover_queue() in a ethernet driver, which does not create
> > ghes_estatus_pool, it leads to a NULL pointer dereference.
> 
> I guess that means you contemplate having an ethernet driver allocate
> and manage its own struct aer_capability_regs to pass to
> aer_recover_queue().  But I don't understand why such a driver would
> be involved in this part of the AER processing.
> 
> Normally a device like a NIC that detects an error logs something in
> its local AER Capability, then sends an ERR_* message upstream.  The
> Root Port that receives that ERR_* message generates an interrupt.  In
> the native AER case, the Linux AER driver handles that interrupt,
> reads the error logs from the AER Capability of the device that sent
> the ERR_* message, and logs it.  In the firmware-first case used by
> GHES, platform firmware handles the interrupt, reads the error logs,
> packages them up, and sends them to the Linux AER driver via GHES and
> aer_recover_queue().
> 
> What's the PCIe hardware flow that would lead to an ethernet driver
> calling aer_recover_queue()?  An Endpoint driver wouldn't receive the
> AER interrupt generated by the Root Port.
> 
> I suppose a NIC could generate its own device-specific interrupt when
> it logs an error in its local AER Capability, but if it conforms to
> the PCIe spec, it should also send an ERR_* message, which would feed
> into the existing AER path.  I don't think we'd want the existing AER
> path racing with a parallel AER path in the Endpoint driver.

Thank you for your detailed explanation.

I fully agree that aer_recover_queue() is intended for firmware-first error
reporting via GHES, and an endpoint driver should not normally invoke it
directly.

However, in practice, we've encountered platforms where AER interrupts are not
delivered reliably. For example, due to BIOS misconfiguration, disabled AER in
firmware, or hardware that fails to generate ERR_* messages correctly. On such
systems, when a PCIe error occurs, the standard AER path is never triggered,
and the device remains in a stuck state.

To verify this, I simulated a PCIE error by injecting it into the NIC register.
But the Linux AER driver didn't respond at all, on many platforms.

As a device driver, we'd like to ensure best-effort recovery regardless of
platform AER support. Since pcie_do_recovery() encapsulates the complete and
correct recovery sequence, it's exactly what we need-but it's not exported.

Given this, could you advise on the proper way for an endpoint driver to
initiate full PCIe error recovery when AER is unavailable? Is there a
recommended pattern that safely achieves the same effect as pcie_do_recovery()
without duplicating its logic?

Thank you again for your guidance.


