Return-Path: <linux-acpi+bounces-20492-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFAOM3IrcWniewAAu9opvQ
	(envelope-from <linux-acpi+bounces-20492-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 20:39:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2A5C5A1
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 20:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79F707A892C
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E00333759;
	Wed, 21 Jan 2026 17:50:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE031A7E1;
	Wed, 21 Jan 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017825; cv=none; b=RlzVXxSw8cnlKTGLpY2zauc7m7hH3MtNGh0xwXRIV/zcHlZOUJC0G631GimEGAfSzriqRUz0AsjKrzU5sz2svLh7Hm8h5uKmdaCPObI8cBrs+Wf4rnTPe7vXwcS7RMn1x8XOBiw9WuOOinzKtNmUz22uqyOn9U0WuBYGuB9BUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017825; c=relaxed/simple;
	bh=wXhkrXas7afKk2bXMs2SmgD8smLMiLuYZL4Dcq7EA0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m70t6uaxJk9MxruFuN+pi99cuaq4/Iz4G0/SiJiHjsXDAoPVAlG39MA7vxADhmkxEFjIcTYPUgvczeTCmgFmsBc1YaIeNdaL6Z50ytIgR3UKZWcpz90uHgxjUIjeTwAR7aCQdJvmNO9EH67WILNKZ/WEur9xMmT+dQtBMjWvSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 933B02C000A9;
	Wed, 21 Jan 2026 18:41:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7784330ED2; Wed, 21 Jan 2026 18:41:19 +0100 (CET)
Date: Wed, 21 Jan 2026 18:41:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <aXEPv8BChwIhlZPa@wunner.de>
References: <20260121113544.4163457-1-haakon.bugge@oracle.com>
 <20260121113544.4163457-2-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121113544.4163457-2-haakon.bugge@oracle.com>
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20492-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,wunner.de:mid]
X-Rspamd-Queue-Id: A2D2A5C5A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 12:35:40PM +0100, Håkon Bugge wrote:
> +	if (pcie_cap_has_lnkctl(dev) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    !dev->is_virtfn && pcie_root_rcb_set(dev)) {
> +		u16 lnkctl;
> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +		if (lnkctl & PCI_EXP_LNKCTL_RCB)
> +			return;
> +
> +		pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl | PCI_EXP_LNKCTL_RCB);

You may want to use pcie_capability_set_word() for brevity.

Thanks,

Lukas

