Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928F2BA8A6
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2019 21:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfIVTGX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Sep 2019 15:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405610AbfIVTAg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Sep 2019 15:00:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88D7C208C2;
        Sun, 22 Sep 2019 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178835;
        bh=QJorBsuu7/I+O7IoyuxkA/c3Do8nJw9lZYvwg/ZsupQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cn/Wa4hA1NJYeYktjDSEXGpZacN8u6jufHZ2TNoHgCuHg+Mc2bWeZdhA2gV64OUbg
         MR7g5yywZWjLRNsNIZbJ8I8z2ZWjrEA/X6JsK02Dtmdj+3/UpsYGxdGBuv4qPwWjCU
         hlnDUh9h8VDsFiJHq/sY1v/KH75M95AE+G2OynuE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 44/60] ACPI / PCI: fix acpi_pci_irq_enable() memory leak
Date:   Sun, 22 Sep 2019 14:59:17 -0400
Message-Id: <20190922185934.4305-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185934.4305-1-sashal@kernel.org>
References: <20190922185934.4305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 29b49958cf73b439b17fa29e9a25210809a6c01c ]

In acpi_pci_irq_enable(), 'entry' is allocated by kzalloc() in
acpi_pci_irq_check_entry() (invoked from acpi_pci_irq_lookup()). However,
it is not deallocated if acpi_pci_irq_valid() returns false, leading to a
memory leak. To fix this issue, free 'entry' before returning 0.

Fixes: e237a5518425 ("x86/ACPI/PCI: Recognize that Interrupt Line 255 means "not connected"")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pci_irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index c576a6fe4ebb3..94ded9513c73b 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -462,8 +462,10 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		 * No IRQ known to the ACPI subsystem - maybe the BIOS /
 		 * driver reported one, then use it. Exit in any case.
 		 */
-		if (!acpi_pci_irq_valid(dev, pin))
+		if (!acpi_pci_irq_valid(dev, pin)) {
+			kfree(entry);
 			return 0;
+		}
 
 		if (acpi_isa_register_gsi(dev))
 			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
-- 
2.20.1

