Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3D44E5A9
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Nov 2021 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhKLLp0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Nov 2021 06:45:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:22242 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234144AbhKLLp0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Nov 2021 06:45:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="213156428"
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="213156428"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 03:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,229,1631602800"; 
   d="scan'208";a="670627857"
Received: from srpawnik-desktop.iind.intel.com ([10.223.141.119])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2021 03:42:33 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, lenb@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: DPTF: Update device ID information under comment
Date:   Fri, 12 Nov 2021 17:30:29 +0530
Message-Id: <20211112120029.10851-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Update device ID information appropriately under comment section.
It seems previously this comment was added considering this driver
used for Tiger Lake based systems. But, now this is being used by
Alder Lake based systems as well as per this commit 38748bcb940e
("ACPI: DPTF: Support Alder Lake"). So, updating the comment for
more generic type from INT1045 to INT10xx and also correcting it
from INT to INTC string for this device ID information under
comment section.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/dptf/dptf_pch_fivr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index f4e9c2ef2f88..e7ab0fc90db9 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -46,7 +46,7 @@ static int pch_fivr_read(acpi_handle handle, char *method, struct pch_fivr_resp
 }
 
 /*
- * Presentation of attributes which are defined for INT1045
+ * Presentation of attributes which are defined for INTC10xx
  * They are:
  * freq_mhz_low_clock : Set PCH FIVR switching freq for
  *			FIVR clock 19.2MHz and 24MHz
-- 
2.17.1

