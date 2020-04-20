Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6D1B0596
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Apr 2020 11:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgDTJ2C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Apr 2020 05:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTJ2C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Apr 2020 05:28:02 -0400
Received: from sudo.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF6FA20CC7;
        Mon, 20 Apr 2020 09:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587374881;
        bh=jSEKGWqsrT6A07i0d90hlri1Jat4wE9wmFvoKlPRqM0=;
        h=From:To:Cc:Subject:Date:From;
        b=mq0viWMww53XTmD3oHdx/2kondNR/5TNTFZTHZwB2Z0xNMl2NYS8b/nODRRi1efll
         RB5Fg9YGAMc0RWZoTh6xo3htp7Sth3FH6fcbBmZeVBgO6XNp776QwlzJOKRN8rJggr
         6rwkChmt9mJdPIkHqaGcLonX4zt4hwP/wyFGvJRE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Andrei Warkentin <awarkentin@vmware.com>
Subject: [PATCH v2] ACPI/IORT: take _DMA methods into account for named components
Date:   Mon, 20 Apr 2020 11:27:53 +0200
Message-Id: <20200420092753.9819-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Where IORT nodes for named components can describe simple DMA limits
expressed as the number of address bits a device can drive, _DMA methods
in AML can express more complex topologies, involving DMA translation in
particular.

Currently, we only take this _DMA method into account if it appears on a
ACPI device node describing a PCIe root complex, but it is perfectly
acceptable to use them for named components as well, so let's ensure
we take them into account in those cases too.

Note that such named components are expected to reside under a
pseudo-bus node such as the ACPI0004 container device, which should be
providing the _DMA method as well as a _CRS (as mandated by the ACPI
spec). This is not enforced by the code however.

Reported-by: Andrei Warkentin <awarkentin@vmware.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/arm64/iort.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1a7ae9..07eb78baf198 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1146,13 +1146,10 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	else
 		size = 1ULL << 32;
 
-	if (dev_is_pci(dev)) {
-		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
-		if (ret == -ENODEV)
-			ret = rc_dma_get_range(dev, &size);
-	} else {
-		ret = nc_dma_get_range(dev, &size);
-	}
+	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
+	if (ret == -ENODEV)
+		ret = dev_is_pci(dev) ? rc_dma_get_range(dev, &size)
+				      : nc_dma_get_range(dev, &size);
 
 	if (!ret) {
 		/*
-- 
2.20.1

