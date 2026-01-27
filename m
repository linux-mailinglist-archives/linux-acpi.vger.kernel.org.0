Return-Path: <linux-acpi+bounces-20696-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGxqOn87eWkmwAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20696-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 23:26:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 728799B019
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 23:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA72C3011BFA
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99B3570C8;
	Tue, 27 Jan 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec7Mlq26"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD00350288;
	Tue, 27 Jan 2026 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552684; cv=none; b=ik/J4Ot/t1WpTJqC5dfZi5hqF6wKnVD6OjpeOB5Jc/IWvq7Qt7i1NL5sx7sO7mU1E7HAiQVKy6i6YjrPsnRec0w9DF8SYvzUzH2I+/AbAYJP6Xve0SijcBL44lgo/O55EFecFvZw6ixE0mhTxW6oIF/DAjoQ9dELEjE343VJdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552684; c=relaxed/simple;
	bh=XAyXKUf6q/0z3PUr5sC//LrqmgO0EPfzDjK+XCHmP/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=snFbJG3gEDNRIzGMKWjT+3ujYhZ6cTtlwm6O4fKY81Nny9dVokfJmOop9+y3zztFlIwXjhOjVJ/wNejJ3Yb3L2RaTd0zqxUmAMrFsN4ZxnCBLdmuV3VmseCvfLO9uv229DvJTOP/Dns/iMSfV3VlsGRYPiaa0TB71lIuqAiPniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec7Mlq26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B8C116C6;
	Tue, 27 Jan 2026 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769552683;
	bh=XAyXKUf6q/0z3PUr5sC//LrqmgO0EPfzDjK+XCHmP/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ec7Mlq26+vqOlpYOZBpxXb0vji+31/Ak5zmDkDh5FN9xMmbs4r0QOiKPUM8p8v3CJ
	 71DY16D+R+d7+2FfPIbCt0FK+WOf8LTQNE6XhxMTYGnGwivvgATkI4GrURtlxn1wr1
	 GjvYRrQ6A72582sJhwh85d9hIRuv2kHjqrgQ74a2iM1XG0PGvo98glYn/51o6qwccR
	 iwsdsUNCGDvAEYxVAaBRvuL+dZFwjaVcYNnZ5765xGn1+TSAFuZ4e4TQ0ELEudDB8o
	 i1vSWdgS/fylsVdc96IsQLxn1r3s9QaQDSq5MvZ6nmF3TZ8vh8MZNU84ZdJG+zeKL8
	 APFASB2wtRdRw==
Date: Tue, 27 Jan 2026 16:24:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Williamson <alex@shazbot.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] PCI/ACPI: Confine program_hpx_type2 to the AER
 bits
Message-ID: <20260127222442.GA379147@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122130957.68757-3-haakon.bugge@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20696-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,kernel.org,gmail.com,suse.de,jp.fujitsu.com,shazbot.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 728799B019
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:09:54PM +0100, Håkon Bugge wrote:
> program_hpx_type2() is today unconditionally called, despite the fact
> that when the _HPX was added to the ACPI spec. v3.0, the description
> stated:
> 
>  OSPM [1] will only evaluate _HPX with Setting Record – Type 2 if OSPM
>  is not controlling the PCI Express Advanced Error Reporting
>  capability.
> 
> Hence, we only call program_hpx_type2() when the OSPM owns the PCIe
> hotplug capability but not the AER.
> 
> The Advanced Configuration and Power Interface (ACPI) Specification
> version 6.6 has a provision that gives the OSPM the ability to control
> the other PCIe Device Control bits any way. In a note in section
> 6.2.9, it is stated:
> 
> "OSPM may override the settings provided by the _HPX object's Type2
> record (PCI Express Settings) or Type3 record (PCI Express Descriptor
> Settings) when OSPM has assumed native control of the corresponding
> feature."
> 
> So, in order to preserve the non-AER bits in PCIe Device Control, in
> particular the performance sensitive ExtTag and RO, we make sure
> program_hpx_type2() if called, doesn't modify any non-AER bits.
> 
> Also, when program_hpx_type2() is called, we completely avoid
> modifying any bits in the Link Control register. However, if the _HPX
> type 2 records contains bits indicating such modifications, we print
> an info message.
> 
> [1] Operating System-directed configuration and Power Management

I looked at the specs again and pulled out some more details.  Here's
what seemed relevant to me:

    PCI/ACPI: Restrict program_hpx_type2() to AER bits
    
    Previously program_hpx_type2() applied PCIe settings unconditionally, which
    could incorrectly change bits like Extended Tag Field Enable and Enable
    Relaxed Ordering.
    
    When _HPX was added to ACPI r3.0, the intent of the PCIe Setting Record
    (Type 2) in sec 6.2.7.3 was to configure AER registers when the OS does not
    own the AER Capability:
    
      The PCI Express setting record contains ... [the AER] Uncorrectable Error
      Mask, Uncorrectable Error Severity, Correctable Error Mask ... to be used
      when configuring registers in the Advanced Error Reporting Extended
      Capability Structure ...
    
      OSPM will only evaluate _HPX with Setting Record – Type 2 if OSPM is not
      controlling the PCI Express Advanced Error Reporting capability.
    
    ACPI r3.0b, sec 6.2.7.3, added more AER registers, including registers in
    the PCIe Capability with AER-related bits, and the restriction that the OS
    use this only when it owns PCIe native hotplug:
    
      ... when configuring PCI Express registers in the Advanced Error
      Reporting Extended Capability Structure *or PCI Express Capability
      Structure* ...
    
      An OS that has assumed ownership of native hot plug but does not ... have
      ownership of the AER register set must use ... the Type 2 record to
      program the AER registers ...
    
      However, since the Type 2 record also includes register bits that have
      functions other than AER, the OS must ignore values ... that are not
      applicable.
    
    Restrict program_hpx_type2() to only the intended purpose:
    
      - Apply settings only when OS owns PCIe native hotplug but not AER,
    
      - Only touch the AER-related bits (Error Reporting Enables) in Device
        Control
    
      - Don't touch Link Control at all, since nothing there seems AER-related,
        but log _HPX settings for debugging purposes
    
    Note that Read Completion Boundary is now configured elsewhere, since it is
    unrelated to _HPX.

> +	/* Log if _HPX attempts to modify PCIe Link Control register */
>  	if (pcie_cap_has_lnkctl(dev)) {
> -
> -		/*
> -		 * If the Root Port supports Read Completion Boundary of
> -		 * 128, set RCB to 128.  Otherwise, clear it.
> -		 */
> -		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
> -		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
> -		if (pcie_root_rcb_set(dev))
> -			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
> -
> -		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> -			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
> +		if (hpx->pci_exp_lnkctl_and)
> +			pci_info(dev,
> +				 "_HPX attempts to reset the following bits in PCIe Link Control: 0x%04x\n",
> +				 hpx->pci_exp_lnkctl_and);
> +		if (hpx->pci_exp_lnkctl_or)
> +			pci_info(dev,
> +				 "_HPX attempts to set the following bits in PCIe Link Control: 0x%04x\n",
> +				 hpx->pci_exp_lnkctl_or);

Again I'm afraid I suggested some over-engineering, and even worse, I
misinterpreted the pci_exp_lnkctl_and and pci_exp_lnkctl_or usage when
I said "if pci_exp_lnkctl_and or pci_exp_lnkctl_or are *non-zero*".

Per spec, we are supposed to AND the register with pci_exp_lnkctl_and,
so the interesting value would be anything other than 0xffff.  Since
we OR it with pci_exp_lnkctl_or, the interesting values there would be
anything non-zero.  So I think what we would want is something like
this:

+	/* Log if _HPX attempts to modify PCIe Link Control register */
 	if (pcie_cap_has_lnkctl(dev)) {
-
-		/*
-		 * If the Root Port supports Read Completion Boundary of
-		 * 128, set RCB to 128.  Otherwise, clear it.
-		 */
-		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
-		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
-		if (pcie_root_rcb_set(dev))
-			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
-
-		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
+		if (hpx->pci_exp_lnkctl_and != 0xffff ||
+		    hpx->pci_exp_lnkctl_or != 0)
+			pci_info(dev, "_HPX attempts Link Control setting (AND %#06x OR %#06x)\n",
+				 hpx->pci_exp_lnkctl_and,
+				 hpx->pci_exp_lnkctl_or);
 	}

