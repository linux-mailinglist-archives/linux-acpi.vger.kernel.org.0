Return-Path: <linux-acpi+bounces-975-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F67D7350
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446E8B20D88
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7457847B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA1auGb6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B727702
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 18:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76765C433C9;
	Wed, 25 Oct 2023 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698257189;
	bh=TjPM4IUHZFeN5SC8qO/PKZAR4LKbys4t4FhjaQKNlpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FA1auGb6vfdKd2ep3peuFgkHN25Eck/KxDbmTJ5LHvEf9WcUm9E8+xlbzj15MML4m
	 sbrbseIezz0rt/qX458xFvQSmew0cCpKAKlFy0sAAQIoOTvalyjz0DXAuPGwPOS3sU
	 nZIA/8s5NwrwsNrN1p1KKW2FfwEvvyIzhM9q5JLpioTpNlE4EP8ATBRphOMcR6WQRD
	 Ux2Mf+CctvmMGYMbEiZIuO+UZRhwMO+qerXVHVDh+J4NqCUNXPAvHocZBzNpC0lTWY
	 vCOVAXItEj32o8Cbl7CNEju4R3MwlGTPhBmRu1pYTqH+u/YlR7750KMzZOgVw4gyrL
	 XSvKpTWsDUqAg==
Date: Wed, 25 Oct 2023 13:06:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Darren Hart <darren@os.amperecomputing.com>,
	patches@amperecomputing.com
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
Message-ID: <20231025180627.GA1756475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ttqe4n1h.fsf@scott-ph-mail.amperecomputing.com>

On Wed, Oct 25, 2023 at 10:41:46AM -0700, D Scott Phillips wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Fri, Sep 29, 2023 at 05:20:36PM -0700, D Scott Phillips wrote:
> >> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> >> also present to request system firmware control of attention LEDs. Add an
> >> ACPI PCI Hotplug companion driver to support attention LED control.
> >> ...
> >
> >> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> >> +		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,
> >
> > pci_domain_nr() returns "int" (normally 32 bits), but since this is an
> > ACPI system, the domain comes from _SEG, which is defined to be 16
> > bits (ACPI r6.5, sec 6.5.6).
> >
> > So it looks like ORing in the "slot << 4" clobbers the upper 12 bits
> > of _SEG.
> >
> > Is this code doing the right thing?
> 
> Hi Bjorn,
> 
> on these Altra platforms _SEG is limited within 0-11. I can add an `&
> 0xf` to pci_domain_nr() to make it clear that the segment number is
> encoded down into 4 bits in the smc request.

If the following looks OK, we're all set.  I put these on pci/hotplug
for v6.7, thanks!

+static int set_attention_status(struct hotplug_slot *slot, u8 status)
+{
+	struct arm_smccc_res res;
+	struct pci_bus *bus;
+	struct pci_dev *root_port;
+	unsigned long flags;
+	u32 handle;
+	int ret = 0;
+
+	bus = slot->pci_slot->bus;
+	root_port = pcie_find_root_port(bus->self);
+	if (!root_port)
+		return -ENODEV;
+
+	local_irq_save(flags);
+	arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
+		      led_service_id[2], led_service_id[3], 0, 0, 0, &res);
+	if (res.a0) {
+		ret = -ENODEV;
+		goto out;
+	}
+	handle = res.a1 & 0xffff0000;
+
+	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
+		     PCI_SLOT(root_port->devfn) << 4 | pci_domain_nr(bus) & 0xf,
+		     0, 0, handle, &res);
+	if (res.a0)
+		ret = -ENODEV;
+
+	arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
+
+ out:
+	local_irq_restore(flags);
+	return ret;
+}

