Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3703B399800
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 04:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCCZs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 22:25:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:27733 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhFCCZr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Jun 2021 22:25:47 -0400
IronPort-SDR: CzJohndd7QaxK8n3lhUc1p0ViPwK3dWg1dAtg8I+hXMj7MX3qLK/tnsVGAiHKr2T5XzvkpQrxI
 FdswmsRPSwJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="202088924"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="202088924"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:24:04 -0700
IronPort-SDR: aIZOKToExNYR7hZjdoY0X95KYcPF1JRLwrAgB5/CanGt3xcgE+DagP5U3MKWrCzmPNFpOVuxRO
 rEJcyUzoR13w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="479980898"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2021 19:24:02 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rjw@rjwysocki.net, guohanjun@huawei.com, rui.zhang@intel.com
Subject: [PATCH] Revert "ACPI: sleep: Put the FACS table after using it"
Date:   Thu,  3 Jun 2021 10:34:14 +0800
Message-Id: <20210603023414.2389-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 95722237cb2a ("ACPI: sleep: Put the FACS table after using it")
puts the FACS table during initialization.
But the hardware signature bits in the FACS table need to be accessed,
after every hibernation, to compare with the original hardware signature.

So there is no reason to release the FACS table mapping after
initialization.

This reverts commit 95722237cb2ae4f7b73471058cdb19e8f4057c93.

An alternative solution is to use acpi_gbl_FACS variable instead, which
is mapped by the ACPICA core and never released.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212277
Reported-by: Stephan Hohe <sth.dev@tejp.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/sleep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index df386571da98..3bb2adef8490 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1009,10 +1009,8 @@ static void acpi_sleep_hibernate_setup(void)
 		return;
 
 	acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
-	if (facs) {
+	if (facs)
 		s4_hardware_signature = facs->hardware_signature;
-		acpi_put_table((struct acpi_table_header *)facs);
-	}
 }
 #else /* !CONFIG_HIBERNATION */
 static inline void acpi_sleep_hibernate_setup(void) {}
-- 
2.17.1

