Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8623E42B
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Aug 2020 00:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHFWz2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Aug 2020 18:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHFWz1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Aug 2020 18:55:27 -0400
Received: from localhost (130.sub-72-107-113.myvzw.com [72.107.113.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6837A20748;
        Thu,  6 Aug 2020 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596754526;
        bh=/VESiY4Js1fvb74yAYdJ93LE7nAEj6Wi/7SluXHk63A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lCJJkuGRpcJx1pxHEywPN+rD8n9Sy310mqPNIytSzSIBBciBOHBITaFNkYzihMKug
         YmJP7gKfZAqa1351peWLwFqUpz47Fw9Cd7pbYZLPFs4OuU70k2X2sqjDsP41+SHDPW
         9IP9/4vXLefHtNu5pVVJbAJX8ULjaop8TORWV7GA=
Date:   Thu, 6 Aug 2020 17:55:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        patches@amperecomputing.com, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Add Ampere Altra SOC MCFG quirk
Message-ID: <20200806225525.GA706347@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0A228AB4-25C4-40D8-ABA1-CB9C774825B5@amperemail.onmicrosoft.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 06, 2020 at 03:40:41PM -0700, Tuan Phan wrote:
> 
> > On Aug 6, 2020, at 3:27 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > On Thu, Aug 06, 2020 at 02:57:34PM -0700, Tuan Phan wrote:
> >> Ampere Altra SOC supports only 32-bit ECAM reading. Therefore,
> >> add an MCFG quirk for the platform.
> > 
> > This is interesting.  So this host bridge supports sub 32-bit config
> > *writes*, but not reads?
> > 
> > I actually don't know whether that complies with the spec or not.  If
> > config registers are not allowed to have side effects on read, this
> > *would* be compliant.
> > 
> > PCIe r5.0, sec 7.4, doesn't list any register types with read side
> > effects, so there shouldn't be any in the registers defined by the
> > spec.  But I would think device-specific registers could do whatever
> > they wanted, e.g., reading an interrupt status register or something
> > could clear it.
> > 
> > And I think sec 7.2.2 about ECAM implicitly requires sub 32-bit
> > accesses because it mentions the access size and byte enables.
> > 
> > Is this a one-off situation where future hardware will allow sub
> > 32-bit reads and writes?  We don't want a stream of quirks for future
> > devices.
> 
> Actually, this is a silicon bug inside current Altra Soc. Our SOC
> supports sub 32-bit reads and writes. But using byte read for some
> devices like AMD graphic card causing corrupted data due to host
> controller HW errata.
> 
> Future devices will have this issue fixed so this quirk applies only
> for current Altra Soc.
> 
> So you think I can drop the “non-compliant” as there are no read
> side effects for all registers?

No, I actually said that I don't think any *architected* config
registers have read side effects, but I think it *is* allowed for
device-specific registers to have read side effects.

Glad this will be fixed in future devices!

> >> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> >> ---
> >> drivers/acpi/pci_mcfg.c  | 20 ++++++++++++++++++++
> >> drivers/pci/ecam.c       | 10 ++++++++++
> >> include/linux/pci-ecam.h |  1 +
> >> 3 files changed, 31 insertions(+)
> >> 
> >> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> >> index 54b36b7ad47d..e526571e0ebd 100644
> >> --- a/drivers/acpi/pci_mcfg.c
> >> +++ b/drivers/acpi/pci_mcfg.c
> >> @@ -142,6 +142,26 @@ static struct mcfg_fixup mcfg_quirks[] = {
> >> 	XGENE_V2_ECAM_MCFG(4, 0),
> >> 	XGENE_V2_ECAM_MCFG(4, 1),
> >> 	XGENE_V2_ECAM_MCFG(4, 2),
> >> +
> >> +#define ALTRA_ECAM_QUIRK(rev, seg) \
> >> +	{ "Ampere", "Altra   ", rev, seg, MCFG_BUS_ANY, &pci_32b_read_ops }
> >> +
> >> +	ALTRA_ECAM_QUIRK(1, 0),
> >> +	ALTRA_ECAM_QUIRK(1, 1),
> >> +	ALTRA_ECAM_QUIRK(1, 2),
> >> +	ALTRA_ECAM_QUIRK(1, 3),
> >> +	ALTRA_ECAM_QUIRK(1, 4),
> >> +	ALTRA_ECAM_QUIRK(1, 5),
> >> +	ALTRA_ECAM_QUIRK(1, 6),
> >> +	ALTRA_ECAM_QUIRK(1, 7),
> >> +	ALTRA_ECAM_QUIRK(1, 8),
> >> +	ALTRA_ECAM_QUIRK(1, 9),
> >> +	ALTRA_ECAM_QUIRK(1, 10),
> >> +	ALTRA_ECAM_QUIRK(1, 11),
> >> +	ALTRA_ECAM_QUIRK(1, 12),
> >> +	ALTRA_ECAM_QUIRK(1, 13),
> >> +	ALTRA_ECAM_QUIRK(1, 14),
> >> +	ALTRA_ECAM_QUIRK(1, 15),
> >> };
> >> 
> >> static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> >> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> >> index 8f065a42fc1a..b54d32a31669 100644
> >> --- a/drivers/pci/ecam.c
> >> +++ b/drivers/pci/ecam.c
> >> @@ -168,4 +168,14 @@ const struct pci_ecam_ops pci_32b_ops = {
> >> 		.write		= pci_generic_config_write32,
> >> 	}
> >> };
> >> +
> >> +/* ECAM ops for 32-bit read only (non-compliant) */
> >> +const struct pci_ecam_ops pci_32b_read_ops = {
> >> +	.bus_shift	= 20,
> >> +	.pci_ops	= {
> >> +		.map_bus	= pci_ecam_map_bus,
> >> +		.read		= pci_generic_config_read32,
> >> +		.write		= pci_generic_config_write,
> >> +	}
> >> +};
> >> #endif
> >> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> >> index 1af5cb02ef7f..033ce74f02e8 100644
> >> --- a/include/linux/pci-ecam.h
> >> +++ b/include/linux/pci-ecam.h
> >> @@ -51,6 +51,7 @@ extern const struct pci_ecam_ops pci_generic_ecam_ops;
> >> 
> >> #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> >> extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
> >> +extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
> >> extern const struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
> >> extern const struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
> >> extern const struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
> >> -- 
> >> 2.18.4
> >> 
> 
