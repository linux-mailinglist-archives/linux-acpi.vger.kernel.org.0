Return-Path: <linux-acpi+bounces-20694-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1+leFxs1eWnAvwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20694-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:58:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3179ADC7
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C50A301F16C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36E331A7E;
	Tue, 27 Jan 2026 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXjIuUVD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070382264C0;
	Tue, 27 Jan 2026 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551126; cv=none; b=r3CtGehk8n6cBqCTUEBMBObOKvUnvmXiIXI63+GzXlMFfqRXWAuu10PrXXOBlHXwY5f7gKvd45sgfuYrWcQB4apMFoUcOFmuxq4EvBahSqWu1WpQvpBOjYGWyI60l9qJkucpe4B8ipVScE5CdbBFCMVQcH5Ehe3OD0A6Ikgbyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551126; c=relaxed/simple;
	bh=yE6EWJBhRg+mhMUjxt4pWa+SnegdGeopSpPNg/AuhtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XAI7mrHXgk3aezP9zcS4PJW8/ZC7yYN5Mp4vYSlkDXmXO1rK1Wa0YkKKwRZSLdsE9F6s7o/i/YLFEybgdXKDUKiQee4sbZ11BnwWgquudf72zTAnOq0Rqp08XK2QEVNYv+lNQyCqjDEu+KjusbpX79xKoEQi28u0qZqYbXppV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXjIuUVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766D5C116C6;
	Tue, 27 Jan 2026 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769551125;
	bh=yE6EWJBhRg+mhMUjxt4pWa+SnegdGeopSpPNg/AuhtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FXjIuUVDhO4WgYVuk8skgJe2Ez1S/xxdlO8EHP5v7jB/3bN49D8XMuxeecWhp+PDo
	 KA7m0dQsH/tYJ5TEEMc94RpG7aeKNccbH//XxO/jMKJKS6mr2tvvoPgg3zKJ6g0Y8O
	 nIt2+6OKkpuphrVJkDRe2gfjYjSPdkeK4y7ZGa9cg6fwglJYycJW6+DdoiO9isphDZ
	 ubC/W6jKliPfo1P9a82WkuUJujgOdeWF5TooV/6FVY9k5yvKtOpZ7hWxUHWsUMROVa
	 jSY5YoDIjG5CDP2C5qBMy/qDx8D6GVHG8mvSNjmQLPFyn8SahVc0i1nHIiu0mJr3j5
	 RPNjDjISRlrxA==
Date: Tue, 27 Jan 2026 15:58:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260127215844.GA377410@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9979743a-e4e0-fdfc-460b-fcad92d54f94@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,google.com,linux.ibm.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20694-lists,linux-acpi=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB3179ADC7
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:45:58PM +0200, Ilpo Järvinen wrote:
> On Thu, 22 Jan 2026, Håkon Bugge wrote:
> 
> > Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> > Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> > instructed program_hpx_type2() to set the RCB in an endpoint,
> > although it's RC did not have the RCB bit set.

> > +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> > +	if (rcb) {
> > +		if (lnkctl & PCI_EXP_LNKCTL_RCB)
> > +			return;
> > +
> > +		lnkctl |= PCI_EXP_LNKCTL_RCB;
> > +	} else {
> > +		if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> > +			return;
> > +
> > +		pci_info(dev, FW_INFO "clearing RCB (RCB not set in Root Port)\n");
> > +		lnkctl &= ~PCI_EXP_LNKCTL_RCB;
> > +	}
> > +
> > +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
> 
> So this sequence is effectively implementing this simple statement:
> 
> 	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> 					   PCI_EXP_LNKCTL_RCB,
> 					   rcb ? PCI_EXP_LNKCTL_RCB : 0);
> 
> + the print.
> 
> Is there a good reason why you want to avoid the write by using early 
> returns?

Good question, pcie_capability_clear_and_set_word() is much more
readable.

> I also wonder if those clear & set & clean_and_set interfaces should 
> implement the write avoidance if it's an useful thing (callers should be 
> checked they're not used for RW1C bits if that's implemented though).

