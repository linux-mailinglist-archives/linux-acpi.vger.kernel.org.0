Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0529B22C74
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2019 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfETG6k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 May 2019 02:58:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfETG6j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 May 2019 02:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TjqTyf/kATJ8gNJlCjxVaaIrHquChWso/9puDre/evU=; b=sJWiX3EH4zQasg+oANpWkJZQh
        F3a7GF2yhetYBwfh0nN0Cv14ArKWEx0nPUZ62CthyXrs7R6/yALOmIkcRreLuoYC1a7R3QV4kC0J+
        f8EmoQDfPS//0/QSXQUyGCso97V8koScq81FDW3qrVY4aHvDBxhDXaRRZfR6QNjzBNu2A05SxnhfE
        6lPXlZ94UfUHb72QPZRFwl/ekRivS8r5jEeUi3krkyWe2JngcERDX/1vlxPNWrXDkdl78h10KMMTM
        Jh0GCyd727qx84zQGUr0EpkRVjOFKrx9Kso+nVxVfoifpknxpiwJiYIHyUsIr4tSheVIilsPH9HT/
        lfM97/MQw==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hScFq-0007WP-MK; Mon, 20 May 2019 06:58:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     will.deacon@arm.com
Cc:     jean-philippe.brucker@arm.com, lorenzo.pieralisi@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/IORT: Fix build without CONFIG_IOMMU_API
Date:   Mon, 20 May 2019 08:57:46 +0200
Message-Id: <20190520065746.17068-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

IOMMU_FWSPEC_PCI_RC_ATS is only defined if CONFIG_IOMMU_API is
enabled.

Fixes: 5702ee24182f ("ACPI/IORT: Check ATS capability in root complex nodes")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/acpi/arm64/iort.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9058cb084b91..3e542b5d2a2d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1074,9 +1074,10 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
-
+#ifdef CONFIG_IOMMU_API
 		if (!err && iort_pci_rc_supports_ats(node))
 			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+#endif
 	} else {
 		int i = 0;
 
-- 
2.20.1

