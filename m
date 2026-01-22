Return-Path: <linux-acpi+bounces-20555-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI77M9Q2cmmadwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20555-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:40:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52468058
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3483926EC7
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF283090D4;
	Thu, 22 Jan 2026 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uea8msMY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E73595D;
	Thu, 22 Jan 2026 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089566; cv=none; b=sVbzloaCHC5kyWFZKLfyevvc3lhzR9pss66WYmIl96pWnBIpX/pNv3yN4BGw7aNpY8a7KsiDEiOPiks6na0TqtlHtQHp5P6m+rkZcxqUgR1ZPqTmJ7UoEjny04co5D8zEBKWw5rfmhziZi1CJERSmkryRPkX0iI02RdqSIxt5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089566; c=relaxed/simple;
	bh=0x3cAxb13x5tUci1HI/O51KMAWS5Hi7ScpKkrrd8X7g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bONZCVSSsyirtqJWOb0+zKhySbV46N6zB5U8FaMdZDWN9HKmSy5uI9moqd7CKz3ljQ+5WUGadkgmOl7ViR+YJycT5sGX23fzEP7pVWKJc2ErXWXxpQ5Wz0c9NAGVTkV6hlOVCrsRF9fWsgSG/NVceKO7QY2jltiFKC6sN7997G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uea8msMY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769089565; x=1800625565;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0x3cAxb13x5tUci1HI/O51KMAWS5Hi7ScpKkrrd8X7g=;
  b=Uea8msMYhs9bHrzpsVG/VLZIOUVuEgMZ9GD1Acxbcuv/AxpbkbNjzJ2Y
   WAV7OCyh/bShmDZIRcyFt7W1UydID8A/32uiSG9KqpCiF3m6I77vMgRc1
   ZC0RhzKktnmUiVb76wMgtDuPiJ3ZcfepHnYbvtfCRmVhZkgZ9sQovodw8
   cZp6E1Ja360fCUiIuiI7cRrp7a4bMjQD//wRFRoVs5igV7LVUvCuX8PI2
   EoQatu0ELUocYsO9K9mRxjSq8EsMV9ZF/CwWaiFLBxV4khPWM32sA80Lz
   BVST3f51DiUvvPfoK/S3mU7GRc8URejR4/DV7rp9QbMF73WD6VqNLYaXa
   Q==;
X-CSE-ConnectionGUID: baB9ceE4TWKfpSHzzhO6GA==
X-CSE-MsgGUID: vhvDEKrcQ266Y1cWVmt/0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="73958124"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="73958124"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 05:46:04 -0800
X-CSE-ConnectionGUID: JJdtMj7KSFmlxhdwVgEDKg==
X-CSE-MsgGUID: wa2neuXxQ5ikwFdPiYh5rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="205989946"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 05:46:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Jan 2026 15:45:58 +0200 (EET)
To: =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Alex Williamson <alex@shazbot.org>, 
    Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
In-Reply-To: <20260122130957.68757-2-haakon.bugge@oracle.com>
Message-ID: <9979743a-e4e0-fdfc-460b-fcad92d54f94@linux.intel.com>
References: <20260122130957.68757-1-haakon.bugge@oracle.com> <20260122130957.68757-2-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-229495461-1769089519=:1059"
Content-ID: <bad5a1f4-b981-f1b5-c7fc-b1748f86c423@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,shazbot.org,gmail.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20555-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 4F52468058
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-229495461-1769089519=:1059
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7c78c9ef-8688-ea93-f271-a4df91000c4b@linux.intel.com>

On Thu, 22 Jan 2026, H=E5kon Bugge wrote:

> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> instructed program_hpx_type2() to set the RCB in an endpoint,
> although it's RC did not have the RCB bit set.
>=20
> e42010d8207f fixed that by qualifying the setting of the RCB in the
> endpoint with the RC supporting an 128 byte RCB.
>=20
> In retrospect, the program_hpx_type2() should only modify the AER
> bits, and stay away from fiddling with the Link Control Register.
>=20
> Hence, we explicitly program the RCB from pci_configure_device().
>=20
> According to PCIe r7.0, sec 7.5.3.7, RCB is only valid for Root Ports
> (where it is Read-Only), Bridges, and Endpoints. The bit is 'RsvdP'
> for Virtual Functions. Hence, for other cases than Bridges and Physical
> Endpoints, we bail out early from pci_configure_rcb().
>=20
> If the Root Port's RCB cannot be determined, we do nothing.
>=20
> If RCB is set in the Root Port and not in the device, we set it. If it
> is set in the device but not in the Root Port, we print an info
> message and reset it.
>=20
> Fixes: Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff=
 Root Port supports it (_HPX)")
> Signed-off-by: H=E5kon Bugge <haakon.bugge@oracle.com>
>=20
> ---
>=20
> Note, that the current duplication of pcie_root_rcb_set() will be
> removed in the next commit.
>=20
> v2 -> v3:
>    * Qualified the device types more strictly
>    * s/pcie_root_rcb_set/pcie_read_root_rcb/ and changed signature
>    * Do nothing if the RP's RCB cannot be determined
>    * Reset the device's RCB if not set in the RP
> ---
>  drivers/pci/probe.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 41183aed8f5d9..7165ac4065c97 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2410,6 +2410,58 @@ static void pci_configure_serr(struct pci_dev *dev=
)
>  =09}
>  }
> =20
> +static bool pcie_read_root_rcb(struct pci_dev *dev, bool *rcb)
> +{
> +=09struct pci_dev *rp =3D pcie_find_root_port(dev);
> +=09u16 lnkctl;
> +
> +=09if (!rp)
> +=09=09return false;
> +
> +=09pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> +
> +=09*rcb =3D !!(lnkctl & PCI_EXP_LNKCTL_RCB);
> +=09return true;
> +}
> +
> +static void pci_configure_rcb(struct pci_dev *dev)
> +{
> +=09u16 lnkctl;
> +=09bool rcb;
> +
> +=09/*
> +=09 * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root
> +=09 * Ports (where it is read-only), Endpoints, and Bridges.  It
> +=09 * may only be set for Endpoints and Bridges if it is set in
> +=09 * the Root Port. For Endpoints, it is 'RsvdP' for Virtual
> +=09 * Functions. If the Root Port's RCB cannot be determined, we
> +=09 * bail out.
> +=09 */
> +=09if (!pci_is_pcie(dev) ||
> +=09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +=09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_UPSTREAM ||
> +=09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
> +=09    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC ||
> +=09    dev->is_virtfn || !pcie_read_root_rcb(dev, &rcb))
> +=09=09return;
> +
> +=09pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +=09if (rcb) {
> +=09=09if (lnkctl & PCI_EXP_LNKCTL_RCB)
> +=09=09=09return;
> +
> +=09=09lnkctl |=3D PCI_EXP_LNKCTL_RCB;
> +=09} else {
> +=09=09if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> +=09=09=09return;
> +
> +=09=09pci_info(dev, FW_INFO "clearing RCB (RCB not set in Root Port)\n")=
;
> +=09=09lnkctl &=3D ~PCI_EXP_LNKCTL_RCB;
> +=09}
> +
> +=09pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);

So this sequence is effectively implementing this simple statement:

=09pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
=09=09=09=09=09   PCI_EXP_LNKCTL_RCB,
=09=09=09=09=09   rcb ? PCI_EXP_LNKCTL_RCB : 0);

+ the print.

Is there a good reason why you want to avoid the write by using early=20
returns?


I also wonder if those clear & set & clean_and_set interfaces should=20
implement the write avoidance if it's an useful thing (callers should be=20
checked they're not used for RW1C bits if that's implemented though).

--
 i.
--8323328-229495461-1769089519=:1059--

