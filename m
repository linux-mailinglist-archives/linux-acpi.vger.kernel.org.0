Return-Path: <linux-acpi+bounces-15353-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED810B13681
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD217189A02E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3025CC52;
	Mon, 28 Jul 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+MA3y3c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0A260583;
	Mon, 28 Jul 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691099; cv=none; b=GHAgVZGkyE+TIr2O9b+9F87idD4sJhNV2Z+CWpqyXXLwvXDyg2g2laDjUsZMiemFp9E/n+YGZmnTFKKjmYLdXwgycCDuEh4J5gSIcLL6eqYqCeQ8D2b2Gp6B4MhBwcvHs1ecTSINImmQWBbLEI2fX9XPbb1luRzOaAynUBZhqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691099; c=relaxed/simple;
	bh=xXa2Ur7OfAmDJDEohmixjhF6aazj1qpqn2Wkg4V9Nnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EmiP8F/58oxg9tlro5j3Y6oHw0uTJe6I5Hru8eVxjdOFzRlA+DOh27WyjqCtRkI715nctlpUMaLLS4EMhdyRYj4SFX8vIo8Ww4fDv9eLryic1R2dmSCCNadKr4u7qAoMLEUqTkQXCbcz7nccyc0xfm0hnoWSopIaFWGJ4+YnDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+MA3y3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B3BC113CF;
	Mon, 28 Jul 2025 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691098;
	bh=xXa2Ur7OfAmDJDEohmixjhF6aazj1qpqn2Wkg4V9Nnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G+MA3y3cVypLaiGLcLbATR3gQzX85CCve8BJXS/VmDZbKCqq2k+xKD9JmpjDmBmXN
	 syDlQd8Ks6Zs2ueCDDfxk1VJvjfY0flOXd609+5RXGVBfMiGCc2q63DJMUfFn3KQjO
	 oic9+rOboUZ+kQ/GBGQjymC0uvnDZsli8fhQiyoPoXQsAHEgxJuU5NeDmEktq9XG17
	 uYok2zJHpHIW8UvMkokGsAeD2uUtXwNh9nBv84m7pGciENrNCCwStuMc0hWpZJZukp
	 SJQSdBauzUrH+EvXd6zlj6GnUd5nxUMPOuk2Lktqj7qNeGs9C+msXk2UTzZhAuDqQj
	 y5+rjLbpusRow==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:47 -0700
Subject: [PATCH RFC 17/25] PCI/LUO: Restore the no_d3cold flag
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-17-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

From: Jason Miu <jasonmiu@google.com>

When the PCI bus adds a device, restore the saved no_d3cold flag
before the bus does the D3 checking for the bridge. This tells the
bridge the current D3cold availability of the device.

Tested: QEMU VM boot test.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 69048869ef1c378454f86091ddb2b59a3c3d53ec..e9c7a6dc643d3534755e4ef5218fb6f90d5dcd65 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -353,6 +353,11 @@ void pci_bus_add_device(struct pci_dev *dev)
 		of_pci_make_dev_node(dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
+	/*
+	 * Restore the no_d3cold flag for the device before we start to update
+	 * the D3 state for the bridge.
+	 */
+	dev->no_d3cold = PCI_SER_GET(dev, no_d3cold, dev->no_d3cold);
 	pci_bridge_d3_update(dev);
 
 	/*

-- 
2.50.1.487.gc89ff58d15-goog


