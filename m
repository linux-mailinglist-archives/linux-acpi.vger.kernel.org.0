Return-Path: <linux-acpi+bounces-20876-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANPYJmqjhWmSEQQAu9opvQ
	(envelope-from <linux-acpi+bounces-20876-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 09:16:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202BFB58D
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 09:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C986300337D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFA33C50F;
	Fri,  6 Feb 2026 08:16:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09530AD1A;
	Fri,  6 Feb 2026 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365799; cv=none; b=DT978/BD+/oaQ9Q16kVouucJlQR55PaiNL68Zm4lPDxHt7s2oQ/3MHgOGOAOcdof5W+HijVEeNer6f5YiWjidn+KkZevuMGZlwaq+DiP/ojn2+M/7c2Lkw4+qPoDSauuG4RD7ng4m9m5vxQJRi+YXSbVgl6AH26hU/MQaVjUdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365799; c=relaxed/simple;
	bh=KRkLOZUXlOqN2/vUjxLJO6GBbTG8MnsLEcsCHoaqOO8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4oHLmmkBjdnT37czpFE2YKIgjO6JtU4qgtv8ljabWajNf3qZ75DQZ7rltNPqhwM+zspcQSaH709Kr8Lu7DIJ2lLdB2CUdzWehiYewfW+kvSWYovppxsxwCHM6IazYByIOvBCLpZwxJji6zpp6w4ZSzJM4wsgEg0aUgFRF7O8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1770365740t249t53373
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8297871022067864192
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
References: <07a701dc964d$0f0c1310$2d243930$@trustnetic.com> <20260205153929.GA39360@bhelgaas>
In-Reply-To: <20260205153929.GA39360@bhelgaas>
Subject: RE: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in ghes_estatus_pool_region_free
Date: Fri, 6 Feb 2026 16:15:39 +0800
Message-ID: <001c01dc9740$c7722540$56566fc0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQK/Rwp0xf4/4skqrjcqwFfAPkG5irOvnocw
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MXZrlka9y5vPAHdxJUHfps/DMxgikmh0USDVwX+v57V5/cTbMnSpRAyT
	6C6c3yDt0X/KpaISBwz6zXXR0Wat1rcZ0ACFvqzg89OL7ve/v1iNmn1e8mVOm5hTLpOI6JS
	YnwjyY98TT8R3+C1i+1aO7m2SFVpREM6YOb48gnrOavBD40iPtAKPP6jUt3dlaizpc14fTl
	kuP2JG7u+UlwcNLnZn0hS28rrvV5PABLuZLeljWAnQO+/v2r+X1L6EVPuTf9jumpZfN33Li
	vBetzzKu/ujULjz2Gx+8qT/mra9zEnTaD3fPA7K+qdHI3uV+o9YvFZ46N1oKG5C8j9yCmtb
	7kgPO5LdG396NtzdEz+HLX5ELF7L8pIbm8d2IVvuXKLN9XEuDTuHP0ZSkaFBC4U2YPOQ7uG
	56uR595/JVA8OzwcG9nVfkNiZ/vE8uNcOiKcttZ0WF9NoRIbXqgmNB3KkjPRHCb8JU33POD
	ZA9lrIXCM42+Dstf/Cnys2xJiOFMV0SnELeXXfc/6eGYkvT3MIax91jGfXz5NVKjS4J68lE
	j98XqVycQoyhLleFfKjqcAQeyCO/IVxLySQZrIAZ8Jgh2MLQr+JjRsfiKVCq7yCe1uIAToR
	ItWzBsbhF/GnqFJAcKyGnl/cTEL7VTPr+ySKtffO3vGZIxXYid/d8H5sanesEp7AI+4hZFe
	xYFk61/M7IfL7cxBWNgD70A0SpDQ6Mcg7ohLCh3ks/XyuqEGXKLtYERjrI1YTOzoe8JReDa
	kaxX0/Mk3A7FfB/k+P8oWXHykLj/5iRRTGubtmNRQZsO1KDWDzd0HcHaaN+nsTP3VLH4hu5
	k/3X3WeBMGqMcVOp1eCfkKIvjg6mbbp2Son6s+ZuwlJTF+H3gYgrNDUVDthqNZkaQPDrubk
	UJhjbBG+uowm44noRR8CANFH074yoMJyl7KECNfrE4145AOiJNutE7DH3S6TVgYQ2Q4V4U2
	Uws4V8HGM+yTpoIaVVer9w3vxsb1UElKZlMAilyePhlcRcpjL4/NHG74XEYMHHsFRgxc27p
	9TFpPv/9/HrxIuU3V00rvKQv/nm79rwWAvTLwG075uabAJ4/ds
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20876-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2202BFB58D
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 11:39 PM, Bjorn Helgaas wrote:
> On Thu, Feb 05, 2026 at 11:11:02AM +0800, Jiawen Wu wrote:
> > On Thu, Feb 5, 2026 5:46 AM, Bjorn Helgaas wrote:
> > > On Wed, Feb 04, 2026 at 10:03:34AM +0800, Jiawen Wu wrote:
> > > > On Wed, Feb 4, 2026 6:55 AM, Bjorn Helgaas wrote:
> > > > > On Tue, Feb 03, 2026 at 10:12:32AM +0800, Jiawen Wu wrote:
> > > > > > The function ghes_estatus_pool_region_free() is exported and
> > > > > > be called by the PCIe AER recovery path, which
> > > > > > unconditionally invokes it to free aer_capability_regs
> > > > > > memory.
> > > > > >
> > > > > > Although current AER usage assumes memory comes from the
> > > > > > GHES pool, robustness requires guarding against pool
> > > > > > unavailability. Add a NULL check before calling
> > > > > > gen_pool_free() to prevent crashes when the pool is not
> > > > > > initialized. This also makes the API safer for potential
> > > > > > future use by non-GHES callers.
> > > > >
> > > > > I'm not sure what you mean by "pool unavailability."  I think
> > > > > getting here with ghes_estatus_pool==NULL means we have a
> > > > > logic error somewhere, and I don't think we should silently
> > > > > hide that error.
> > > > >
> > > > > I'm generally in favor of *not* checking so we find out if the
> > > > > caller forgot to keep track of the pointer correctly.
> > > >
> > > > "pool unavailability" means that when I attempt to call
> > > > aer_recover_queue() in a ethernet driver, which does not create
> > > > ghes_estatus_pool, it leads to a NULL pointer dereference.
> > >
> > > I guess that means you contemplate having an ethernet driver
> > > allocate and manage its own struct aer_capability_regs to pass to
> > > aer_recover_queue().  But I don't understand why such a driver
> > > would be involved in this part of the AER processing.
> > >
> > > Normally a device like a NIC that detects an error logs something
> > > in its local AER Capability, then sends an ERR_* message upstream.
> > > The Root Port that receives that ERR_* message generates an
> > > interrupt.  In the native AER case, the Linux AER driver handles
> > > that interrupt, reads the error logs from the AER Capability of
> > > the device that sent the ERR_* message, and logs it.  In the
> > > firmware-first case used by GHES, platform firmware handles the
> > > interrupt, reads the error logs, packages them up, and sends them
> > > to the Linux AER driver via GHES and aer_recover_queue().
> > >
> > > What's the PCIe hardware flow that would lead to an ethernet
> > > driver calling aer_recover_queue()?  An Endpoint driver wouldn't
> > > receive the AER interrupt generated by the Root Port.
> > >
> > > I suppose a NIC could generate its own device-specific interrupt
> > > when it logs an error in its local AER Capability, but if it
> > > conforms to the PCIe spec, it should also send an ERR_* message,
> > > which would feed into the existing AER path.  I don't think we'd
> > > want the existing AER path racing with a parallel AER path in the
> > > Endpoint driver.
> >
> > Thank you for your detailed explanation.
> >
> > I fully agree that aer_recover_queue() is intended for
> > firmware-first error reporting via GHES, and an endpoint driver
> > should not normally invoke it directly.
> >
> > However, in practice, we've encountered platforms where AER
> > interrupts are not delivered reliably. For example, due to BIOS
> > misconfiguration, disabled AER in firmware, or hardware that fails
> > to generate ERR_* messages correctly. On such systems, when a PCIe
> > error occurs, the standard AER path is never triggered, and the
> > device remains in a stuck state.
> >
> > To verify this, I simulated a PCIE error by injecting it into the
> > NIC register.  But the Linux AER driver didn't respond at all, on
> > many platforms.
> >
> > As a device driver, we'd like to ensure best-effort recovery
> > regardless of platform AER support. Since pcie_do_recovery()
> > encapsulates the complete and correct recovery sequence, it's
> > exactly what we need-but it's not exported.
> >
> > Given this, could you advise on the proper way for an endpoint
> > driver to initiate full PCIe error recovery when AER is unavailable?
> > Is there a recommended pattern that safely achieves the same effect
> > as pcie_do_recovery() without duplicating its logic?
> 
> It makes sense to try to work around broken hardware, and I think we
> should try to identify exactly what is broken and address it directly.
> 
> If the NIC itself is broken, the problem should happen on every
> platform, and a quirk or the driver might be the best place to deal
> with it.
>
> If the platform is broken, we should see problems with many devices,
> and it would be better to deal with it more centrally instead of a
> single endpoint driver.

Thank you for the thoughtful response.

We are the NIC vendor, and our hardware (like many high-speed PCIe devices)
can occasionally encounter PCIe errors due to real-world factors such as signal
integrity issues, or marginal link training. These are not necessarily design
flaws in the NIC itself, but rather transient conditions that can occur in
field deployments.

While we agree that platforms should properly deliver AER interrupts, in
practice we see many customer environments (especially in embedded or custom
server platforms) where:
* AER is disabled in BIOS
* The root port does not generate the architected interrupt
* Firmware simply fails to report the error via GHES

As a driver vendor, we have no ability to fix or even influence these
platform-level issues. Yet from the user's perspective, the result is the same:
the NIC becomes unusable (config space reads return 0xFFFFFFFF), and the
network interface hangs indefinitely.

Our goal is not to bypass the AER architecture, but to provide a last-resort
recovery mechanism when the standard path is broken through no fault of our
own. Since pcie_do_recovery() already implements the correct sequence, it would
be ideal if endpoint drivers could safely invoke a similar flow when they
detect a local failure (e.g., via MMIO timeout or Tx stall). I understand the
concern about layering, but without any way to trigger recovery, the device
remains dead. I think the driver only can do is copy the code of
pcie_do_recovery() to restore the device. Would it be reasonable to consider
exporting a recovery helper for use by endpoint drivers?

> I know about several platforms that don't support the architected AER
> interrupt, e.g.,
> https://lore.kernel.org/all/20250702223841.GA1905230@bhelgaas/t/#u
> There is some work in progress to address this particular problem.
> 
> Do you have any specifics about the devices and platforms where you're
> seeing issues?

The test platform I'm currently using:
* CPU: AMD Ryzen 9 7950X 16-Core Processor
* BIOS version: E7E16AMS.190
* OS: Ubuntu 25.04
* Kernel: Linux 6.19.0-rc7+

The device is our NIC, the driver is in the directory:
drivers/net/ethernet/wangxun/

If you need more detailed information, please let me know.
Thanks again for your time and support.




