Return-Path: <linux-acpi+bounces-20576-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BGDGGyycmn5ogAAu9opvQ
	(envelope-from <linux-acpi+bounces-20576-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 00:27:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7406E79A
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 00:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1A88300D350
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C613C1FEA;
	Thu, 22 Jan 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCnv/kW6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D83DB255;
	Thu, 22 Jan 2026 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769124456; cv=none; b=lonuHmZ5sUYM7gn0n48O1nL+zPh/egP1i84BoEOjSuuu7inraRop/+C5vdy28M4fLkv0NnYO7LVKxFgZbGKRVj4cxs7WQ/zfC2nckH4gLF+M56jnc8a4iuoU0U+aqZ72Fr2b0MvITYcgrmKXNASMYETdZpTN7VYVqdUxcZQG0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769124456; c=relaxed/simple;
	bh=TpTvuO5OGPCFjh5XFxTMY09tgERrKThZNyQvlUN/g8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I+q9T0grv9m7uHZwQIj9wKjNZfwAQZx9hkJPjnQt/G3syQKjX+Bk0xmYfumqocoiOGtvjRo7jx79tRsrgOcGK+Ny0U6yAiTVFo48xQ6phdnnKv7xYxwyqhdnDizfFvlpLOLEfx3mclK6qAgMsNCYuatu0NU6ZoYmXG3mTbu8GGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCnv/kW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B871AC116C6;
	Thu, 22 Jan 2026 23:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769124454;
	bh=TpTvuO5OGPCFjh5XFxTMY09tgERrKThZNyQvlUN/g8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eCnv/kW66JgUyYthhTx4hls2d3Mf8RMNWBA5dZCbs4Q83J7DI/CZ66KGPPbw35290
	 tLYHqgH/uAkCgXzG3J29QndIfL14nynk8k0jc/OWSlFxv04n/Zg50LWv9wCw15x8zq
	 rgUg4KHK/n3f8/H8FqUW5sHnRLRrMyikqGTaB7Yx9uoBa9bCPKmwweyyJ837kk9VCP
	 5Xjh4IHicmcVCTRXWQQqNrlZ4SyW+90coyQULEg+d06uKvo5RQB7d+j1prY8gbw/Dh
	 cnSBTllpvDVQzJXrzH/cgKQnHLda1DzHYLAo12Jb1AyLAf1/xNMEMFe7fdXikNfsFc
	 ZxlF6Satpm01A==
Date: Thu, 22 Jan 2026 17:27:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Nilawar, Badal" <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, rodrigo.vivi@intel.com,
	varun.gupta@intel.com, ville.syrjala@linux.intel.com,
	uma.shankar@intel.com, karthik.poosa@intel.com,
	matthew.auld@intel.com, sk.anirban@intel.com, raag.jadav@intel.com
Subject: Re: [PATCH v6 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Message-ID: <20260122232733.GA46175@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <531f2fe7-7a17-42cc-8747-ea122fe1c95f@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20576-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B7406E79A
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 09:29:16PM +0530, Nilawar, Badal wrote:
> On 15-01-2026 01:25, Bjorn Helgaas wrote:
> > On Tue, Jan 13, 2026 at 10:12:03PM +0530, Badal Nilawar wrote:
> > > From: Anshuman Gupta <anshuman.gupta@intel.com>
> > > 
> > > Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10, to request
> > > fixed delay in timing between the time the PME_TO_Ack message is received
> > > at the PCI Express Downstream Port that originated the PME_Turn_Off
> > > message, and the time the platform asserts PERST# to the slot during the
> > > corresponding Endpoint’s or PCI Express Upstream Port’s transition to
> > > D3cold while the system is in an ACPI operational state.
> > > Host platform supporting this feature ensures that device is observing
> > > this delay in every applicable D3Cold transition.

> > > +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> > > +{
> ...

> > > +	if (!dev)
> > > +		return -EINVAL;

Calling this with "dev == NULL" is a bug in the caller, so I don't
think we should check for this.  That way we will take the NULL
pointer dereference, cause an oops, and can fix the bug.  If we check
for NULL, the bug is likely to be unnoticed.

> > Sec 4.6.11 also says we should track this per Downstream Port and
> > request the maximum of delays requested by any child.  So I think we
> > need to:
> > 
> >    - add a perst_delay in struct pci_dev
> > 
> >    - when we find this _DSM, set
> >      bdev.perst_delay = max(bdev.perst_delay, delay_us)
> > 
> >    - pass bdev.perst_delay to the _DSM instead of delay_us
> 
> For vrsr use case delay requested is 10ms, which is maximum allowed by this
> _DSM.
> I think we should take care of above suggestion when we implement aux power
> aggregation.
> For now, I can create another list let's call it acpi_perst_delay_list,
> similar to acpi_aux_power_list, and
> allow a only one device to request a PERST delay.

I think lists will be a maintenance headache.

> > > +		handle = ACPI_HANDLE(&bdev->dev);
> > > +		if (handle &&
> > > +		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
> > > +				   1 << DSM_PCI_PERST_ASSERTION_DELAY))
> > > +			break;
> > > +	}
> > > +
> > > +	if (!bdev)
> > > +		return -ENODEV;
> > > +
> > > +	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
> > > +					  &pci_acpi_dsm_guid, 4,
> > > +					  DSM_PCI_PERST_ASSERTION_DELAY,
> > > +					  &in_obj, ACPI_TYPE_INTEGER);
> > > +	if (!out_obj)
> > > +		return -EINVAL;
> > > +
> > > +	result = out_obj->integer.value;
> > > +	ACPI_FREE(out_obj);
> > > +
> > > +	if (result == delay_us) {
> > > +		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
> >
> > I think this message should use "bdev" instead of "dev".  I know the
> > request is for "dev", but the delay connected to bdev and applies to
> > all functions below the Downstream Port.
>
> Since it is set for the device which as requested I kept dev.

It's set for *all* devices below bdev, so I think the message should
give a clue about that.  If we only include "dev", there is no
indication that other devices are affected.  Maybe we could include
both dev and bdev?

  pci_info(bdev, "PERST# assertion delay %u microseconds set as requested by %s\n",
           delay_us, pci_name(bdev));

