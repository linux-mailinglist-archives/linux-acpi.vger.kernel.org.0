Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1128C97A
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390183AbgJMHgA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 03:36:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:56233 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390384AbgJMHgA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 03:36:00 -0400
IronPort-SDR: 7+yGIyBNuXdXeCx4HwHf/fng5JqtInXU09c8/2u5J+rhzf0mFGRPwkhYjOi4YzGeecJ1gsiEyF
 vWPv3sWZruYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152798297"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="152798297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 00:35:59 -0700
IronPort-SDR: P9O0t4Hamz5UJ1bEkVTgPUrx+UnMpAnFYxBFM4vks5YKO67i9rE2fnHE8hSm2EhNIQ5I9KDqld
 ndiD1ElcNB2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="313713138"
Received: from lkp-server02.sh.intel.com (HELO inn.sh.intel.com) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Oct 2020 00:35:57 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     sukumar.ghorai@intel.com, rui.zhang@intel.com
Subject: [PATCH V2] acpi: reboot: fix racing after writing to ACPI RESET_REG
Date:   Tue, 13 Oct 2020 15:35:57 +0800
Message-Id: <20201013073557.4580-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

According to the ACPI spec, "The system must reset immediately following
the write to the ACPI RESET_REG register.", but there are cases that the
system does not follow this and results in racing with the subsequetial
reboot mechanism, which brings unexpected behavior.

Fix this by adding a 15ms delay after writing to the ACPI RESET_REG.

Reported-by: Ghorai, Sukumar <sukumar.ghorai@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index ca707f5b521d..0e357cb5612f 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -3,6 +3,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
+#include <linux/delay.h>
 
 #ifdef CONFIG_PCI
 static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
@@ -66,4 +67,13 @@ void acpi_reboot(void)
 		acpi_reset();
 		break;
 	}
+
+	/*
+	 * Some platforms do not shutdown immediately after writing to the
+	 * ACPI reset register, and this results in racing with the
+	 * subsequetial reboot mechanism.
+	 * Delay for 15ms has been proved to be long enough for the system
+	 * to reboot, for these platforms.
+	 */
+	mdelay(15);
 }
-- 
2.17.1

