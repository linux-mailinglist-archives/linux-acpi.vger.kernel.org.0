Return-Path: <linux-acpi+bounces-20695-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHIgLEU4eWkJwAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20695-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 23:12:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0139AEFB
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 23:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D1C3019BB1
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757BA33436D;
	Tue, 27 Jan 2026 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7cdMBNB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4A2F83A7;
	Tue, 27 Jan 2026 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551921; cv=none; b=MVdG7lkSvkDzYyKWHuv6B7NFBlptIxXzP/+eOHKJJvNix34+azQGo3bka2oXNoEqet3I5HPogOwf4bC66Y7sOUFk3KuLp9Im0zR1aaiT1mOT+faCGBoFIT9vaZg8iLXkWwp9yQrL9S4jMiVCG42Tj1rDOt8wQRlmNVqLOs2mVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551921; c=relaxed/simple;
	bh=Xi8htZFXlUFQe0eFoTR6GDj0piUTtEg3/7KPD2jedak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xhr+SuhpA3ziRGqVlCUzxjUPyj+RS71n2fK9/hnrfAST71KEQGW0os2PZmewvlVxtN4cnRBqKiCW92ey5UeJhAtYNz3u6+294yvrE2890ROT62pggP6purcOcTviQ1+aqwNfVM+sGEfNSDNwpz+Aqd3bBLsDyYEDHSeNNw4hics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7cdMBNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C581AC116C6;
	Tue, 27 Jan 2026 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769551920;
	bh=Xi8htZFXlUFQe0eFoTR6GDj0piUTtEg3/7KPD2jedak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o7cdMBNBynksXFHu2YjKCWVtSh/SALBPrscv17eKiNhR6+LjZFRV5VLSZePc18Ixo
	 3iGL7U+wAxTQrvMvvJI5p7Lr9j1kiBq9elES1MWks5i643r26BDZRgVkln/Ks4TThq
	 4+i8p2tfnuNeUwadeibjKg8BQUYJcrm4peRiHW285pIoRARJN34a/ji7GImuwMsyjY
	 qxxGowyrTvmfjNri948lQDzUyFpsbhLDhEKoSixPLoQuQ4nbgiaFABWH2m5t5SOAhZ
	 r46IHL6wgJTPvvNi2zG2FmmIYbMEmNtJ+wd74/QUtP/dnBUynFqk0gMjrsiqZwUDMG
	 BFo3n5CpAalhg==
Date: Tue, 27 Jan 2026 16:11:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260127221159.GA378928@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122130957.68757-2-haakon.bugge@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20695-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E0139AEFB
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:09:53PM +0100, Håkon Bugge wrote:
> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> instructed program_hpx_type2() to set the RCB in an endpoint,
> although it's RC did not have the RCB bit set.
> ...

> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +	if (rcb) {
> +		if (lnkctl & PCI_EXP_LNKCTL_RCB)
> +			return;
> +
> +		lnkctl |= PCI_EXP_LNKCTL_RCB;
> +	} else {
> +		if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> +			return;
> +
> +		pci_info(dev, FW_INFO "clearing RCB (RCB not set in Root Port)\n");

I know I suggested all this code and the message, but I'm not sure
it's worth it.  If the device doesn't work, that will be obvious
anyway, so this all feels over-engineered.

> +		lnkctl &= ~PCI_EXP_LNKCTL_RCB;
> +	}
> +
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
> +}

What do you think about this?

    PCI: Initialize RCB from pci_configure_device()
    
    Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root
    Port supports it (_HPX)") worked around a bogus _HPX type 2 record, which
    caused program_hpx_type2() to set the RCB in an endpoint even though the
    Root Port did not have the RCB bit set.
    
    e42010d8207f fixed that by setting the RCB in the endpoint only when it was
    set in the Root Port.
    
    In retrospect, program_hpx_type2() is intended for AER-related settings,
    and the RCB should be configured elsewhere so it doesn't depend on the
    presence or contents of an _HPX record.
    
    Explicitly program the RCB from pci_configure_device() so it matches the
    Root Port's RCB.  The Root Port may not be visible to virtualized guests;
    in that case, leave RCB alone.
    
    Fixes: e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX)")

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..8571c7c6e1a0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2410,6 +2410,37 @@ static void pci_configure_serr(struct pci_dev *dev)
 	}
 }
 
+static void pci_configure_rcb(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+	u16 rp_lnkctl;
+
+	/*
+	 * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root Ports
+	 * (where it is read-only), Endpoints, and Bridges.  It may only be
+	 * set for Endpoints and Bridges if it is set in the Root Port. For
+	 * Endpoints, it is 'RsvdP' for Virtual Functions.
+	 */
+	if (!pci_is_pcie(dev) ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
+	    dev->is_virtfn)
+		return;
+
+	/* Root Port often not visible to virtualized guests */
+	rp = pcie_find_root_port(dev);
+	if (!rp)
+		return;
+
+	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &rp_lnkctl);
+	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_RCB,
+					   (rp_lnkctl & PCI_EXP_LNKCTL_RCB) ?
+					   PCI_EXP_LNKCTL_RCB : 0);
+}
+
 static void pci_configure_device(struct pci_dev *dev)
 {
 	pci_configure_mps(dev);
@@ -2419,6 +2450,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_aspm_l1ss(dev);
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
+	pci_configure_rcb(dev);
 
 	pci_acpi_program_hp_params(dev);
 }

