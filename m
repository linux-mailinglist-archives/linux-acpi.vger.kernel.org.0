Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B195439C318
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFDWCr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:18462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhFDWCp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:45 -0400
IronPort-SDR: Hxs6BTmPozdaXjpAW2OJxHglZClmdpI6NC1AP3U1QSDjIYunc1Ac1tmuWEOo+BKLOoJmS71A/f
 rBR8kKag/dGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="184060104"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="184060104"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:56 -0700
IronPort-SDR: 4i31ChS5kKmB/0+emtTYq1K++z/RfCedE9RgyLYWdr6IlK5Lm2UMcZmD8BfVx7XEMTP2WFhtOm
 KmtJmH84fP5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146725"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:56 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 09/14] ACPICA: iASL: Add support for the BDAT ACPI table
Date:   Fri,  4 Jun 2021 14:26:03 -0700
Message-Id: <20210604212608.2604267-10-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Includes: Table compiler, disassembler, and template generator.

ACPICA commit 81eb9c383e6dee0f1b6620e91e5c3dbb48234831

Link: https://github.com/acpica/acpica/commit/81eb9c38
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index f1d5e8950527..68a607961b2f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -24,6 +24,7 @@
  * file. Useful because they make it more difficult to inadvertently type in
  * the wrong signature.
  */
+#define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
@@ -65,6 +66,20 @@
  * See http://stackoverflow.com/a/1053662/41661
  */
 
+/*******************************************************************************
+ *
+ * BDAT - BIOS Data ACPI Table
+ *
+ * Conforms to "BIOS Data ACPI Table", Interface Specification v4.0 Draft 5
+ * Nov 2020
+ *
+ ******************************************************************************/
+
+struct acpi_table_bdat {
+	struct acpi_table_header header;
+	struct acpi_generic_address gas;
+};
+
 /*******************************************************************************
  *
  * IORT - IO Remapping Table
-- 
2.29.2

