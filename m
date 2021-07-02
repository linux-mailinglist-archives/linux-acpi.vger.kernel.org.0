Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0513B9CB4
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 09:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGBHGA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 03:06:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:46298 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhGBHF7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jul 2021 03:05:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="230353251"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="230353251"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 00:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="482194000"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.122])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jul 2021 00:03:26 -0700
From:   Aubrey Li <aubrey.li@intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH 1/2] ACPI: Correct \_SB._OSC bit definition for PRM
Date:   Fri,  2 Jul 2021 15:03:49 +0800
Message-Id: <1625209430-19934-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Accord to Platform Runtime Mechanism Specification v1.0 [1],
Page 42, _OSC bit (BIT 21) is used to indicate OS support of
platform runtime mechanism..

[1]: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b338613..4df6a81 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -551,8 +551,8 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
-#define OSC_SB_PRM_SUPPORT			0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
+#define OSC_SB_PRM_SUPPORT			0x00200000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
-- 
2.7.4

