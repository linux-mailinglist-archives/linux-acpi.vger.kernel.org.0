Return-Path: <linux-acpi+bounces-20528-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HD3CK78cWmvZwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20528-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:32:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40A6549D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4973E8266E6
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A834AB0D;
	Thu, 22 Jan 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4+YbGt0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D822F388;
	Thu, 22 Jan 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077379; cv=none; b=DaGnONje+ecBPeoTxw+MqkpedjnDxZm46cspfHKQz1WM0Cf+nsSlBZwXQic3gDGjExIcKdR71p4LYnmvX3E8LOn8Qkg/o4RP8r0N9U3b7RqO3LT4FCErH+GgGXCQfvQqBwIl17jneYwjp7IJjACzc2H2iUQZxP4KvXszjHBtCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077379; c=relaxed/simple;
	bh=kT4mlWylBTehL4zttxMz1bZDT7RsJT3UKca38Q2+FGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rP3mmO0F7Jo/yIWjmKqexvpeIt/r2safBwsfe7C00pt62Q+v2pXr2sgs7uKwfSgCiOfHJHKpATX86qa4zlheDzMX7I2Vl7OqR8mSXbB/rv5uFQVfCkumpip+NWqbc+f1gGU8sv9QSRxUvOhqpewxA2JO4e1fqaPa52rCf2XH0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4+YbGt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ED8C116C6;
	Thu, 22 Jan 2026 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769077379;
	bh=kT4mlWylBTehL4zttxMz1bZDT7RsJT3UKca38Q2+FGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z4+YbGt0EmMwS3RGo8HvrjHlLUTH1r1IGaR7g3wmuvJw47MW8qV3hLYZxAfsWxb6J
	 N2WCyOZpXhjYxB8NIBBb2By6KYm6gIMdlGNGjbvDV5wzK5RANt1nN9Oq5Q/KjC+LI9
	 9FbcviqlQSA9xxhI+pa4V4HlydvJf+A3uQ1URBf9TdH0VVGOU0NdML1R+aqu/k8enV
	 o54UUy8Z7dQubUMWqAwNypLN3UOMDyNZnAMtreVL6EOQ/Exw3x6hDbI8HIW++lrQlf
	 3kcGwT0VQmP/B/tfh0vRgWMU/jldIqLyUSgFkvVMH95IiTSA+hXq8b02qDmAadmj2L
	 HGnELr2WMLXkQ==
Date: Thu, 22 Jan 2026 04:22:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260122102257.GA1239174@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2C6ECE99-B9CD-4325-87D2-A2E212BDBDA3@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20528-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B40A6549D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:42:46AM +0000, Haakon Bugge wrote:
> > On Wed, Jan 21, 2026 at 12:35:40PM +0100, Håkon Bugge wrote:
> > [snip]
> 
> > RCB isn't meaningful for switches, so we'll read their LNKCTL
> > unnecessarily.  I propose something like this, which also clears RCB
> > if it's set when it shouldn't be (I think this would indicate a
> > firmware defect):
> > 
> >        /*
> >         * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root Ports
> >         * (where it is read-only), Endpoints, and Bridges.  It may only be
> >         * set for Endpoints and Bridges if it is set in the Root Port.
> >         */
> >        if (!pci_is_pcie(dev) ||
> >            pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >            pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
> >            pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> >            dev->is_virtfn)
> 
> I see that sec 1.3.2 defines "Endpoints are classified as either
> legacy, PCI Express, or Root Complex Integrated Endpoints (RCiEPs)."
> But, shouldn't we also exclude Root Complex Event Collectors
> (PCI_EXP_TYPE_RC_EC)?

Yes, probably so.

