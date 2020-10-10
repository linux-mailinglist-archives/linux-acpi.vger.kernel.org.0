Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3AC289D8A
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Oct 2020 04:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgJJCgO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 22:36:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:57783 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgJJC00 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Oct 2020 22:26:26 -0400
IronPort-SDR: 2TIsLqBOiSpvm+GgIrm1gWbPP4W3gYt/dbJ0+fBW2MbKgKvJOd9Ck8wPKDhXefKG9Co63qJ6Kq
 gnRGQhNOiCFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="165669753"
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="165669753"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 19:26:08 -0700
IronPort-SDR: fuUo3wUtHngd8LxHqK9efmt7IPF1UVCqO2Ekyo8/R++wQVLjAivVUPb8wloj0p6XIJkhH0RZO4
 x+X+6Z/v6QTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="350031268"
Received: from lkp-server02.sh.intel.com (HELO inn.sh.intel.com) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2020 19:26:07 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     sukumar.ghorai@intel.com, rui.zhang@intel.com
Subject: [PATCH] acpi: reboot: fix racing after writing to ACPI RESET_REG
Date:   Sat, 10 Oct 2020 10:26:06 +0800
Message-Id: <20201010022606.27669-1-rui.zhang@intel.com>
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
 drivers/acpi/reboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
index ca707f5b521d..88e6b083d702 100644
--- a/drivers/acpi/reboot.c
+++ b/drivers/acpi/reboot.c
@@ -3,6 +3,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <acpi/reboot.h>
+#include <linux/delay.h>
 
 #ifdef CONFIG_PCI
 static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
@@ -66,4 +67,10 @@ void acpi_reboot(void)
 		acpi_reset();
 		break;
 	}
+
+	/*
+	 * delay for 15ms in case the system does not shutdown immediately after
+	 * writing to the ACPI reset register
+	 */
+	mdelay(15);
 }
-- 
2.17.1

