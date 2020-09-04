Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82A25E0B2
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIDR0N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:26:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57984 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDR0N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:26:13 -0400
Received: from 89-64-89-131.dynamic.chello.pl (89.64.89.131) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id ca0f1db468709f69; Fri, 4 Sep 2020 19:26:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 6/6] ACPI: OSL: Make ACPICA use logical addresses of GPE blocks
Date:   Fri, 04 Sep 2020 19:25:29 +0200
Message-ID: <8097951.ATsSJIO6Si@kreacher>
In-Reply-To: <1748021.N9i9sLPJ40@kreacher>
References: <1748021.N9i9sLPJ40@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Define ACPI_GPE_USE_LOGICAL_ADDRESSES in aclinux.h and modify
acpi_os_initialize() to store the logical addresses of the FADT GPE
blocks 0 and 1 in acpi_gbl_xgpe0_block_logical_address and
acpi_gbl_xgpe1_block_logical_address, respectively, so as to allow
ACPICA to use them for accessing GPE registers in system memory,
instead of using their physical addresses and looking up the
corresponding logical addresses on every access attempt, which is
inefficient.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c              | 12 ++++++++++--
 include/acpi/platform/aclinux.h |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3a50d8fa310b..0002973fbcde 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1744,8 +1744,12 @@ acpi_status __init acpi_os_initialize(void)
 {
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
-	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
-	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
+
+	acpi_gbl_xgpe0_block_logical_address =
+		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
+	acpi_gbl_xgpe1_block_logical_address =
+		acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
+
 	if (acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) {
 		/*
 		 * Use acpi_os_map_generic_address to pre-map the reset
@@ -1783,8 +1787,12 @@ acpi_status acpi_os_terminate(void)
 
 	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
 	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
+	acpi_gbl_xgpe0_block_logical_address = NULL;
+	acpi_gbl_xgpe1_block_logical_address = NULL;
+
 	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
 	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+
 	if (acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER)
 		acpi_os_unmap_generic_address(&acpi_gbl_FADT.reset_register);
 
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 987e2af7c335..4151c76141fa 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -118,6 +118,10 @@
 
 #define USE_NATIVE_ALLOCATE_ZEROED
 
+/* Use logical addresses for accessing GPE registers in system memory */
+
+#define ACPI_GPE_USE_LOGICAL_ADDRESSES
+
 /*
  * Overrides for in-kernel ACPICA
  */
-- 
2.26.2




