Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631502F854E
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 20:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAOTWh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 14:22:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:59259 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbhAOTWh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 14:22:37 -0500
IronPort-SDR: ChPwO4nRHwXl8m/da5kgJEmoruzWBwyExD/doS4N8H60V73R0QQqiOGiKI7U4l2laJcLeZKWCR
 /JB3DpZK8h6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="240139538"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="240139538"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:20:55 -0800
IronPort-SDR: TMWEcl7HEN3UAK++9qiRCLToFbr9DqLGM1oYfB1eCw6eAW0JaE1ZkxPsWBq9Yrs42bhntA3hXr
 TMnAZ5kiRQjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="425417903"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2021 11:20:55 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Al Stone <ahs3@ahs3.net>, Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 7/9] ACPICA: Remove the VRTC table
Date:   Fri, 15 Jan 2021 10:48:24 -0800
Message-Id: <20210115184826.2250-8-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115184826.2250-1-erik.kaneda@intel.com>
References: <20210115184826.2250-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Al Stone <ahs3@ahs3.net>

ACPICA commit 4534cc3700f73c88e2f6a0e0f0b9efe4fc644757

The VRTC table is no longer in use and is not defined by the ACPI
specification.  Remove the table from the known, allowed tables.

Link: https://github.com/acpica/acpica/commit/4534cc37
Signed-off-by: Al Stone <ahs3@ahs3.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl3.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index bdcac69fa6bd..d90c3e1978e6 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -33,7 +33,6 @@
 #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
 #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
-#define ACPI_SIG_VRTC           "VRTC"	/* Virtual Real Time Clock Table */
 #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
@@ -484,28 +483,6 @@ struct acpi_table_uefi {
 	u16 data_offset;	/* Offset of remaining data in table */
 };
 
-/*******************************************************************************
- *
- * VRTC - Virtual Real Time Clock Table
- *        Version 1
- *
- * Conforms to "Simple Firmware Interface Specification",
- * Draft 0.8.2, Oct 19, 2010
- * NOTE: The ACPI VRTC is equivalent to The SFI MRTC table.
- *
- ******************************************************************************/
-
-struct acpi_table_vrtc {
-	struct acpi_table_header header;	/* Common ACPI table header */
-};
-
-/* VRTC entry */
-
-struct acpi_vrtc_entry {
-	struct acpi_generic_address physical_address;
-	u32 irq;
-};
-
 /*******************************************************************************
  *
  * WAET - Windows ACPI Emulated devices Table
-- 
2.29.2

