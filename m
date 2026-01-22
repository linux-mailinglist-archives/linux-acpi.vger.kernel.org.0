Return-Path: <linux-acpi+bounces-20533-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHE0GBgNcmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20533-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:42:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F266287
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D90F36AC88
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9343DA33;
	Thu, 22 Jan 2026 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH5brRZd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0263D6694;
	Thu, 22 Jan 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079856; cv=none; b=umNjZkZc+rpj4Hhc9PAc9m24+TKPlgkcCAce935nf7QPCAIFZ4uzvvAJFvekobh27pBBtq92yPN97putIWWUDBaX4DxNHr45Oh0FHKtoe2lWPmZu2Pznz3HHlb55PmkcTc8BN/pPouiNPhKD1NI56ObjuriKQ+ovxlO1lxALzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079856; c=relaxed/simple;
	bh=rTiDGFeBOJ7NCOx79144IwVyIkXB6dAzlTehnCXCRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hZl3o0/RDRi5bZTe0Pyc1AGmg9Lqn8uPMesYwJw0PNKjOF+05olGncsLeY+EeCnt1o5AxJR8WV0jQTU8ggUPS5jOA3KivjxWy4kSlENApauh4085ngEZrDosmMc//LPA0eNxGXiNob/5ERhIaCa1Y2l9GJCXuriUz4woKk9Bu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH5brRZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803FFC116C6;
	Thu, 22 Jan 2026 11:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769079856;
	bh=rTiDGFeBOJ7NCOx79144IwVyIkXB6dAzlTehnCXCRsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YH5brRZd+DaaJQ2n+2R/hYuPhRRjtGpJI+IeJw5BvomHVEcatxtm+/M+4gxaYgsYs
	 8lOwmCuhCKMyL+UY+KVqZN5CWPVimjKZ9E6xWackfG0Xj4ed/Kp9vMPeN3JQ/tC/Yw
	 rt/jsFhcv07HTUVGXArg9eUWw1XQ2p+jahJObPHE5TrStL3aT8KCmlNFgVvMnhgmpb
	 g+EAljH93VBwYur5XiBVdqyHtHOM8DZBXblIPMk4fU3xJBtM+UiI6i+sYq+nV+dn6Y
	 V+YV+xtA7XhLK0Bshg1+lhzhlVWz7WDTZqoLDPNcE2L4hpekPHPSM/vXsxBBvQDn2F
	 CAIAqOsg2LsbA==
Date: Thu, 22 Jan 2026 05:04:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <20260122110415.GA1241583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81A9E056-115C-4631-92AD-BA148B143DE8@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,shazbot.org,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-20533-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 253F266287
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:49:45AM +0000, Haakon Bugge wrote:
> > On 22 Jan 2026, at 11:36, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jan 21, 2026 at 04:40:10PM -0600, Bjorn Helgaas wrote:
> >> On Wed, Jan 21, 2026 at 12:35:40PM +0100, Håkon Bugge wrote:
> >>> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> >>> Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> >>> instructed program_hpx_type2() to set the RCB in an endpoint,
> >>> although it's RC did not have the RCB bit set.
> >>> 
> >>> e42010d8207f fixed that by qualifying the setting of the RCB in the
> >>> endpoint with the RC supporting an 128 byte RCB.
> >>> 
> >>> In retrospect, the program_hpx_type2() should only modify the AER
> >>> bits, and stay away from fiddling with the Link Control Register.
> >>> 
> >>> Hence, we explicitly program the RCB from pci_configure_device(). RCB
> >>> is RO in Root Ports, and in VFs, the bit is RsvdP, so for these two
> >>> cases we skip programming it. Then, if the Root Port has RCB set and
> >>> it is not set in the EP, we set it.
> >>> 
> >>> Fixes: Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff Root Port supports it (_HPX)")
> >>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >>> 
> >>> ---
> >>> 
> >>> Note, that the current duplication of pcie_root_rcb_set() will be
> >>> removed in the next commit.
> >>> ---
> >>> drivers/pci/probe.c | 36 ++++++++++++++++++++++++++++++++++++
> >>> 1 file changed, 36 insertions(+)
> >>> 
> >>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >>> index 41183aed8f5d9..347af29868124 100644
> >>> --- a/drivers/pci/probe.c
> >>> +++ b/drivers/pci/probe.c
> >>> @@ -2410,6 +2410,41 @@ static void pci_configure_serr(struct pci_dev *dev)
> >>> }
> >>> }
> >>> 
> >>> +static bool pcie_root_rcb_set(struct pci_dev *dev)
> >>> +{
> >>> + struct pci_dev *rp = pcie_find_root_port(dev);
> >>> + u16 lnkctl;
> >>> +
> >>> + if (!rp)
> >>> + return false;
> >>> +
> >>> + pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> >>> +
> >>> + return !!(lnkctl & PCI_EXP_LNKCTL_RCB);
> >>> +}
> >>> +
> >>> +static void pci_configure_rcb(struct pci_dev *dev)
> >>> +{
> >>> + /*
> >>> +  * Obviously, we need a Link Control register. The RCB is RO
> >>> +  * in Root Ports, so no need to attempt to set it for
> >>> +  * them. For VFs, the RCB is RsvdP, so, no need to set it.
> >>> +  * Then, if the Root Port has RCB set, then we set for the EP
> >>> +  * unless already set.
> >>> +  */
> >>> + if (pcie_cap_has_lnkctl(dev) &&
> >>> +     (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> >>> +     !dev->is_virtfn && pcie_root_rcb_set(dev)) {
> >>> + u16 lnkctl;
> >>> +
> >>> + pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> >>> + if (lnkctl & PCI_EXP_LNKCTL_RCB)
> >>> + return;
> >>> +
> >>> + pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl | PCI_EXP_LNKCTL_RCB);
> >>> + }
> >> 
> >> RCB isn't meaningful for switches, so we'll read their LNKCTL
> >> unnecessarily.  I propose something like this, which also clears RCB
> >> if it's set when it shouldn't be (I think this would indicate a
> >> firmware defect):
> >> 
> >>        /*
> >>         * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root Ports
> >>         * (where it is read-only), Endpoints, and Bridges.  It may only be
> >>         * set for Endpoints and Bridges if it is set in the Root Port.
> >>         */
> >>        if (!pci_is_pcie(dev) ||
> >>            pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >>            pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM ||
> >>            pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> >>            dev->is_virtfn)
> >>                return;
> >> 
> >>        rcb = pcie_root_rcb_set(dev);
> >> 
> >>        pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> >>        if (rcb) {
> >>                if (lnkctl & PCI_EXP_LNKCTL_RCB)
> >>                        return;
> >> 
> >>                lnkctl |= PCI_EXP_LNKCTL_RCB;
> >>        } else {
> >>                if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> >>                        return;
> >> 
> >>                pci_info(FW_INFO "clearing RCB (RCB not set in Root Port)\n");
> >>                lnkctl &= ~PCI_EXP_LNKCTL_RCB;
> > 
> > On second thought, I think this is too aggressive.  I think VM
> > guests will often see endpoints but not the Root Port.  In that
> > case, pcie_root_rcb_set() would return false because it couldn't
> > find the RP, but the RP might actually have RCB set.  Then we
> > would clear the endpoint RCB unnecessarily, which should be safe
> > but would reduce performance and will result in annoying
> > misleading warnings.
> 
> If the VM has a PF in pass-through and the RP is not there, you're
> right. If it is a VF, we do not program it anyway.
> 
> > Could either ignore this case (as in your original patch) or bring
> > pcie_root_rcb_set() inline here and return early if we can't find
> > the RP.
> 
> I think pcie_root_rcb_set() should return true when it was able to
> retrieve the RP's RCB value, and if not, we bail out.

Currently it returns:

  - true if we found the RP and it had RCB set

  - false if (a) we couldn't find the RP or (b) we found the RP and it
    had RCB cleared

I don't think it's worth complicating the signature to make (a) and
(b) distinguishable.

Inlining pcie_root_rcb_set() would also remove any ambiguity about
whether pcie_root_rcb_set() actually *sets* RCB or just tests it.  I
think any readability advantage of using a separate function is
minimal.

> >>        }
> >> 
> >>        pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
> >> 
> >>> +}
> >>> +
> >>> static void pci_configure_device(struct pci_dev *dev)
> >>> {
> >>> pci_configure_mps(dev);
> >>> @@ -2419,6 +2454,7 @@ static void pci_configure_device(struct pci_dev *dev)
> >>> pci_configure_aspm_l1ss(dev);
> >>> pci_configure_eetlp_prefix(dev);
> >>> pci_configure_serr(dev);
> >>> + pci_configure_rcb(dev);
> >>> 
> >>> pci_acpi_program_hp_params(dev);
> >>> }
> >>> -- 
> >>> 2.43.5
> 
> 

