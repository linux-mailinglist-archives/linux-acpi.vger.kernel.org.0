Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589EB196162
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgC0WnM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgC0WnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:12 -0400
IronPort-SDR: dfu2FATabOKgeSSVAJ9m1LVgVga05VnGJ/EzP1NPO8meH8PcvR/sqO82RqSQ1YgUlapJhSzr5V
 Kr2rMq0XdERQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:12 -0700
IronPort-SDR: RkD8fRJzT0T69WqeOl+dg6R6+HETAYcb1OPVoQjm5P6IEs3JBaKDyxvKwo9jZu872fo73gmgSK
 L4ozl72nfELg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051966"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:10 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20=C5=BBygowski?= <michal.zygowski@3mdeb.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 02/10] ACPICA: Implement IVRS IVHD type 11h parsing
Date:   Fri, 27 Mar 2020 15:21:02 -0700
Message-Id: <20200327222110.1204634-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Michał Żygowski <michal.zygowski@3mdeb.com>

ACPICA commit 6ddc19419896e4149ced1b5f35f0dc12516c0399

The AMD IVRS table parsing supported only IVHD type 10h structures.
Parsing an IVHD type 11h caused the iasl to report unknown subtable type.
Add necessary structure definition for IVHD type 11h and apply correct
parsing method based on subtable type.

Link: https://github.com/acpica/acpica/commit/6ddc1941
Signed-off-by: Michał Żygowski <michal.zygowski@3mdeb.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index b818ba60e19d..93323aeddc5a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -274,7 +274,8 @@ struct acpi_ivrs_header {
 /* Values for subtable Type above */
 
 enum acpi_ivrs_type {
-	ACPI_IVRS_TYPE_HARDWARE = 0x10,
+	ACPI_IVRS_TYPE_HARDWARE1 = 0x10,
+	ACPI_IVRS_TYPE_HARDWARE2 = 0x11,
 	ACPI_IVRS_TYPE_MEMORY1 = 0x20,
 	ACPI_IVRS_TYPE_MEMORY2 = 0x21,
 	ACPI_IVRS_TYPE_MEMORY3 = 0x22
@@ -301,7 +302,7 @@ enum acpi_ivrs_type {
 
 /* 0x10: I/O Virtualization Hardware Definition Block (IVHD) */
 
-struct acpi_ivrs_hardware {
+struct acpi_ivrs_hardware_10 {
 	struct acpi_ivrs_header header;
 	u16 capability_offset;	/* Offset for IOMMU control fields */
 	u64 base_address;	/* IOMMU control registers */
@@ -310,6 +311,19 @@ struct acpi_ivrs_hardware {
 	u32 reserved;
 };
 
+/* 0x11: I/O Virtualization Hardware Definition Block (IVHD) */
+
+struct acpi_ivrs_hardware_11 {
+	struct acpi_ivrs_header header;
+	u16 capability_offset;	/* Offset for IOMMU control fields */
+	u64 base_address;	/* IOMMU control registers */
+	u16 pci_segment_group;
+	u16 info;		/* MSI number and unit ID */
+	u32 attributes;
+	u64 efr_register_image;
+	u64 reserved;
+};
+
 /* Masks for Info field above */
 
 #define ACPI_IVHD_MSI_NUMBER_MASK   0x001F	/* 5 bits, MSI message number */
-- 
2.25.1

