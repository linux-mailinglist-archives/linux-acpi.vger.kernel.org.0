Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3712C8E66
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 20:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgK3Tsd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 14:48:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:18524 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgK3Tsc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Nov 2020 14:48:32 -0500
IronPort-SDR: ir2feVfZVrUWOpQkmHxLG+f7LPrW6JNyKyMLz8pzg2pY8Av2s9nsnQ2Wo2HYiIPuMDsZGkTFwP
 AfJgbkv/jbeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151954737"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151954737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:52 -0800
IronPort-SDR: jI7g0WILlQMkHpYpzzysrNztOZF3CvBKODa9w7D3A7uwcnX4xpjfetruyRGD4HyQ8L9Dc7SoeJ
 kiTU+lpvBYXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404844865"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2020 11:47:52 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 1/6] ACPICA: Add 5 new UUIDs to the known UUID table
Date:   Mon, 30 Nov 2020 11:20:43 -0800
Message-Id: <20201130192048.3093726-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130192048.3093726-1-erik.kaneda@intel.com>
References: <20201130192048.3093726-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

All UUID entries are related to NVDIMM and the NFIT table.

ACPICA commit c114a02798dd07ccc7e51ffa4365bf039a0dd8d5

Link: https://github.com/acpica/acpica/commit/c114a027
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acuuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 10e30a5030ee..fb7d8d1fd93c 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -39,6 +39,7 @@
 
 /* NVDIMM - NFIT table */
 
+#define UUID_NFIT_DIMM                  "4309ac30-0d11-11e4-9191-0800200c9a66"
 #define UUID_VOLATILE_MEMORY            "7305944f-fdda-44e3-b16c-3f22d252e5d0"
 #define UUID_PERSISTENT_MEMORY          "66f0d379-b4f3-4074-ac43-0d3318b78cdb"
 #define UUID_CONTROL_REGION             "92f701f6-13b4-405d-910b-299367e8234c"
@@ -47,6 +48,10 @@
 #define UUID_VOLATILE_VIRTUAL_CD        "3d5abd30-4175-87ce-6d64-d2ade523c4bb"
 #define UUID_PERSISTENT_VIRTUAL_DISK    "5cea02c9-4d07-69d3-269f-4496fbe096f9"
 #define UUID_PERSISTENT_VIRTUAL_CD      "08018188-42cd-bb48-100f-5387d53ded3d"
+#define UUID_NFIT_DIMM_N_MSFT           "1ee68b36-d4bd-4a1a-9a16-4f8e53d46e05"
+#define UUID_NFIT_DIMM_N_HPE1           "9002c334-acf3-4c0e-9642-a235f0d53bc6"
+#define UUID_NFIT_DIMM_N_HPE2           "5008664b-b758-41a0-a03c-27c2f2d04f7e"
+#define UUID_NFIT_DIMM_N_HYPERV         "5746c5f2-a9a2-4264-ad0e-e4ddc9e09e80"
 
 /* Processor Properties (ACPI 6.2) */
 
-- 
2.25.1

