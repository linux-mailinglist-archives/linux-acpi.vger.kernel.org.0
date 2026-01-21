Return-Path: <linux-acpi+bounces-20495-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEsEEEVWcWkNEwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20495-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 23:42:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D23BE5EF89
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 23:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B63A66A0D6
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8144D6BA;
	Wed, 21 Jan 2026 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAsU31bZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A344D6B1;
	Wed, 21 Jan 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035212; cv=none; b=Mrp6WqWi9Sk3tsgdwUG6gZ3YvmFtrsXBXKyKtnQypH2svZscqe0ohRHferh3m8jw8/ltGIVL/oH2INBfvG4Jb0TBPKWA/Y4YWL70hNk6ZfDN0zt0P4ingc4hsVMkQvwIo6Nl0DumJejYmukthXfMuOmdIFWTDtabrF1y4Qp9Z7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035212; c=relaxed/simple;
	bh=1OoQzValVImfU4Ve7dxAJHD/4yHyWo6CASzhgZCF7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iMCtXnvv+WTAMDqzPjvG08EBc6Vy3GUEZzDYfTwA28fVf9Z+pgcZFATprnTEQUr8PXom+GwXe6jwOCSapfOFV6EeKkFzXRPNn72dNoMJHZ2DW5CcBHTH6ZzkTzG4gjVOhLd+Y/HvcOYVxdaDviD3bMcHmfGan8wq9yEgRVbDpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAsU31bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF23C16AAE;
	Wed, 21 Jan 2026 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769035211;
	bh=1OoQzValVImfU4Ve7dxAJHD/4yHyWo6CASzhgZCF7DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tAsU31bZ14z3HVxV9JhfXTUzh4G8EiJKfz4H+Hyuyz2yYEaPl8L429ILJXWLJdCk3
	 naZ63mft2iU23O3TTZnKMI7sUA43UtdaCcIC42kkiQfOBYm7dhiLEj0vAECbQ59cd0
	 EmH8WuKsT+pSiq7esKrxnrK/MN6gXKDg6wcDX6Wgjp91Wy9P16USk/kUHNPAimB5Za
	 oJy8lai5Gfz4weybDk0TBqPBfdkzETGGhEIZ+iQspzeTblliaFm99c0KJv17H4QX4q
	 oyAwpdWcYxA/TlXSUm6gpncy3SO3g8qFUK2mvIz7eyudKFdhHrSiLn+99zYC0G6D+b
	 SZJ0sk+69FpIQ==
Date: Wed, 21 Jan 2026 16:40:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260121224010.GA1217051@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121113544.4163457-2-haakon.bugge@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20495-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: D23BE5EF89
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 12:35:40PM +0100, Håkon Bugge wrote:
> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> instructed program_hpx_type2() to set the RCB in an endpoint,
> although it's RC did not have the RCB bit set.
> 
> e42010d8207f fixed that by qualifying the setting of the RCB in the
> endpoint with the RC supporting an 128 byte RCB.
> 
> In retrospect, the program_hpx_type2() should only modify the AER
> bits, and stay away from fiddling with the Link Control Register.
> 
> Hence, we explicitly program the RCB from pci_configure_device(). RCB
> is RO in Root Ports, and in VFs, the bit is RsvdP, so for these two
> cases we skip programming it. Then, if the Root Port has RCB set and
> it is not set in the EP, we set it.
> 
> Fixes: Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX)")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> ---
> 
> Note, that the current duplication of pcie_root_rcb_set() will be
> removed in the next commit.
> ---
>  drivers/pci/probe.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 41183aed8f5d9..347af29868124 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2410,6 +2410,41 @@ static void pci_configure_serr(struct pci_dev *dev)
>  	}
>  }
>  
> +static bool pcie_root_rcb_set(struct pci_dev *dev)
> +{
> +	struct pci_dev *rp = pcie_find_root_port(dev);
> +	u16 lnkctl;
> +
> +	if (!rp)
> +		return false;
> +
> +	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> +
> +	return !!(lnkctl & PCI_EXP_LNKCTL_RCB);
> +}
> +
> +static void pci_configure_rcb(struct pci_dev *dev)
> +{
> +	/*
> +	 * Obviously, we need a Link Control register. The RCB is RO
> +	 * in Root Ports, so no need to attempt to set it for
> +	 * them. For VFs, the RCB is RsvdP, so, no need to set it.
> +	 * Then, if the Root Port has RCB set, then we set for the EP
> +	 * unless already set.
> +	 */
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
> +	}

RCB isn't meaningful for switches, so we'll read their LNKCTL
unnecessarily.  I propose something like this, which also clears RCB
if it's set when it shouldn't be (I think this would indicate a
firmware defect):

        /*
         * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root Ports
         * (where it is read-only), Endpoints, and Bridges.  It may only be
         * set for Endpoints and Bridges if it is set in the Root Port.
         */
        if (!pci_is_pcie(dev) ||
            pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
            pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
            pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
            dev->is_virtfn)
                return;

        rcb = pcie_root_rcb_set(dev);

        pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
        if (rcb) {
                if (lnkctl & PCI_EXP_LNKCTL_RCB)
                        return;

                lnkctl |= PCI_EXP_LNKCTL_RCB;
        } else {
                if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
                        return;

                pci_info(FW_INFO "clearing RCB (RCB not set in Root Port)\n");
                lnkctl &= ~PCI_EXP_LNKCTL_RCB;
        }

        pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);

> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)
>  {
>  	pci_configure_mps(dev);
> @@ -2419,6 +2454,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  	pci_configure_aspm_l1ss(dev);
>  	pci_configure_eetlp_prefix(dev);
>  	pci_configure_serr(dev);
> +	pci_configure_rcb(dev);
>  
>  	pci_acpi_program_hp_params(dev);
>  }
> -- 
> 2.43.5
> 

