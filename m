Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64ED354861
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbhDEVuR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:38302 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242340AbhDEVuP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:15 -0400
IronPort-SDR: 8lMKu1gmCj9MiNaVv0zxgNo2ij6d/kyTbCRzHoBN1go38D+SECLv55yfLVtklYdFMWRS8lP+Qe
 pL+DccXSKPOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914976"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914976"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: 0paTDKHz2X3Q/GtDw2SWjSCJs/8voRLF0bVJ+rRNg4vbxU059Jn8gHK/BFywrWgJ3ACTE9Pj0o
 QLuQRhVZTmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673635"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 20/22] ACPICA: acpisrc: Add missing conversion for VIOT support
Date:   Mon,  5 Apr 2021 14:15:08 -0700
Message-Id: <20210405211510.484603-21-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

ACPICA commit 856a96fdf4b51b2b8da17529df0255e6f51f1b5b

struct acpi_viot_header is missing from identifier table, causing linuxize
failures.

Link: https://github.com/acpica/acpica/commit/856a96fd
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl3.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index c0e68331f1fc..86903ac5bbc5 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -520,7 +520,7 @@ enum acpi_viot_node_type {
 /* VIOT subtables */
 
 struct acpi_viot_pci_range {
-	ACPI_VIOT_HEADER header;
+	struct acpi_viot_header header;
 	u32 endpoint_start;
 	u16 segment_start;
 	u16 segment_end;
@@ -531,7 +531,7 @@ struct acpi_viot_pci_range {
 };
 
 struct acpi_viot_mmio {
-	ACPI_VIOT_HEADER header;
+	struct acpi_viot_header header;
 	u32 endpoint;
 	u64 base_address;
 	u16 output_node;
@@ -539,14 +539,14 @@ struct acpi_viot_mmio {
 };
 
 struct acpi_viot_virtio_iommu_pci {
-	ACPI_VIOT_HEADER header;
+	struct acpi_viot_header header;
 	u16 segment;
 	u16 bdf;
 	u8 reserved[8];
 };
 
 struct acpi_viot_virtio_iommu_mmio {
-	ACPI_VIOT_HEADER header;
+	struct acpi_viot_header header;
 	u8 reserved[4];
 	u64 base_address;
 };
-- 
2.29.2

