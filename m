Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A639C323
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhFDWCv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:48296 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231465AbhFDWCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:47 -0400
IronPort-SDR: LI5MVWgsfV/YGHnpS+mS5fPFVfN97j12FAHcgJ0IzBhIVLkUxdXVlS7g1BHt78271x7sKRRCMR
 Q8qIPfTTh4UQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="191710778"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="191710778"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:57 -0700
IronPort-SDR: DDywi45OCnDCel0XVjIKt6d7b4qengAh5pQ49ZcRioAU1nbwURCyGB+tBYFCUH7GXcRtezr3D4
 0eLZTnSKm++Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146732"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:56 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 11/14] ACPICA: Add the CFMWS structure definition to the CEDT table
Date:   Fri,  4 Jun 2021 14:26:05 -0700
Message-Id: <20210604212608.2604267-12-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

ACPICA commit 699fc72e56936bebf3b9ba39b6e91bd957b44452

The CXL Fixed Memory Window Structure (CFMWS) is added to the
CXL Early Discovery Table (CEDT). This new structure is defined
in an ECN to the CXL 2.0 specification.

https://www.computeexpresslink.org/spec-landing

Link: https://github.com/acpica/acpica/commit/699fc72e
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl1.h | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8532f56a51d6..ef2872dea01c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -327,7 +327,8 @@ struct acpi_cedt_header {
 
 enum acpi_cedt_type {
 	ACPI_CEDT_TYPE_CHBS = 0,
-	ACPI_CEDT_TYPE_RESERVED = 1
+	ACPI_CEDT_TYPE_CFMWS = 1,
+	ACPI_CEDT_TYPE_RESERVED = 2,
 };
 
 /* Values for version field above */
@@ -355,6 +356,34 @@ struct acpi_cedt_chbs {
 	u64 length;
 };
 
+/* 1: CXL Fixed Memory Window Structure */
+
+struct acpi_cedt_cfmws {
+	struct acpi_cedt_header header;
+	u32 reserved1;
+	u64 base_hpa;
+	u64 window_size;
+	u8 interleave_ways;
+	u8 interleave_arithmetic;
+	u16 reserved2;
+	u32 granularity;
+	u16 restrictions;
+	u16 qtg_id;
+	u32 interleave_targets[];
+};
+
+/* Values for Interleave Arithmetic field above */
+
+#define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO	(0)
+
+/* Values for Restrictions field above */
+
+#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2		(1)
+#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3		(1<<1)
+#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE	(1<<2)
+#define ACPI_CEDT_CFMWS_RESTRICT_PMEM		(1<<3)
+#define ACPI_CEDT_CFMWS_RESTRICT_FIXED		(1<<4)
+
 /*******************************************************************************
  *
  * CPEP - Corrected Platform Error Polling table (ACPI 4.0)
-- 
2.29.2

