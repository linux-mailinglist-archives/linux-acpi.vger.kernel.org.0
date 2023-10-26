Return-Path: <linux-acpi+bounces-1014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709527D82B4
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 14:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B71C20E85
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC8D273D1
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee4JLB4A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E513FEB
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 11:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D038FC433C8;
	Thu, 26 Oct 2023 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698318261;
	bh=zAWNDV1QACGe4sNSDg9lH+60bzBC5gSITQe/C78KYjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ee4JLB4AYviw9HLvajoxwp7u8UXbV/5VX32Qoguopvbh+oPFIFQz3ZAP0R9+Vm5v2
	 NqU0EI0LwBZIY1OsUywmuL8bgmJZPQUkkuqst85RI9T9kbSWXQxIAuDsw5Pq2feoTr
	 n5lE/qAolm4NelYcXCqcx53SPdr38DdThPhmhgx1GaXld2n5z/c/Ss49kYAWl/nLXy
	 YCk3EwjRQXqUxnsxHrnekv80mmb2VA2zCdBgu37cCowmCbnfyqnoi1mwK45H9LsJRR
	 8nl8lboyweXRtTXVfABegB90VTVuMWiSi2AROzDmMPkcGEf14HCVRo/Evq/+ebNkHa
	 AN/yHr9bNexzA==
Date: Thu, 26 Oct 2023 06:04:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: D Scott Phillips <scott@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Darren Hart <darren@os.amperecomputing.com>,
	patches@amperecomputing.com, sfr@canb.auug.org.au,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
Message-ID: <20231026110418.GA1787436@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026104731.GA1296512@mutt>

On Thu, Oct 26, 2023 at 12:47:31PM +0200, Anders Roxell wrote:
> On 2023-10-25 13:06, Bjorn Helgaas wrote:
> > On Wed, Oct 25, 2023 at 10:41:46AM -0700, D Scott Phillips wrote:
> > > Bjorn Helgaas <helgaas@kernel.org> writes:
> > > 
> > > > On Fri, Sep 29, 2023 at 05:20:36PM -0700, D Scott Phillips wrote:
> > > >> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> > > >> also present to request system firmware control of attention LEDs. Add an
> > > >> ACPI PCI Hotplug companion driver to support attention LED control.
> > > >> ...
> > > >
> > > >> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> > > >> +		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,
> > > >
> > > > pci_domain_nr() returns "int" (normally 32 bits), but since this is an
> > > > ACPI system, the domain comes from _SEG, which is defined to be 16
> > > > bits (ACPI r6.5, sec 6.5.6).
> > > >
> > > > So it looks like ORing in the "slot << 4" clobbers the upper 12 bits
> > > > of _SEG.
> > > >
> > > > Is this code doing the right thing?
> > > 
> > > Hi Bjorn,
> > > 
> > > on these Altra platforms _SEG is limited within 0-11. I can add an `&
> > > 0xf` to pci_domain_nr() to make it clear that the segment number is
> > > encoded down into 4 bits in the smc request.
> > 
> > If the following looks OK, we're all set.  I put these on pci/hotplug
> > for v6.7, thanks!
> > 
> > +static int set_attention_status(struct hotplug_slot *slot, u8 status)
> > +{
> > +	struct arm_smccc_res res;
> > +	struct pci_bus *bus;
> > +	struct pci_dev *root_port;
> > +	unsigned long flags;
> > +	u32 handle;
> > +	int ret = 0;
> > +
> > +	bus = slot->pci_slot->bus;
> > +	root_port = pcie_find_root_port(bus->self);
> > +	if (!root_port)
> > +		return -ENODEV;
> > +
> > +	local_irq_save(flags);
> > +	arm_smccc_smc(HANDLE_OPEN, led_service_id[0], led_service_id[1],
> > +		      led_service_id[2], led_service_id[3], 0, 0, 0, &res);
> > +	if (res.a0) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +	handle = res.a1 & 0xffff0000;
> > +
> > +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
> > +		     PCI_SLOT(root_port->devfn) << 4 | pci_domain_nr(bus) & 0xf,
> > +		     0, 0, handle, &res);
> > +	if (res.a0)
> > +		ret = -ENODEV;
> > +
> > +	arm_smccc_smc(HANDLE_CLOSE, handle, 0, 0, 0, 0, 0, 0, &res);
> > +
> > + out:
> > +	local_irq_restore(flags);
> > +	return ret;
> > +}
> 
> Hi,
> 
> Building todays linux-next tag next-20231026 for arm64 with
> CONFIG_HOTPLUG_PCI_ACPI_AMPERE_ALTRA=m I see the following build error.
> 
> drivers/pci/hotplug/acpiphp_ampere_altra.c: In function 'set_attention_status':
> drivers/pci/hotplug/acpiphp_ampere_altra.c:63:75: error: suggest parentheses around arithmetic in operand of '|' [-Werror=parentheses]
>    63 |                      PCI_SLOT(root_port->devfn) << 4 | pci_domain_nr(bus) & 0xf,
>       |                                                        ~~~~~~~~~~~~~~~~~~~^~~~~
> include/linux/arm-smccc.h:382:44: note: in definition of macro 'arm_smccc_smc'
>   382 | #define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)
>       |                                            ^~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:243: drivers/pci/hotplug/acpiphp_ampere_altra.o] Error 1

My fault, fixed.

Bjorn

