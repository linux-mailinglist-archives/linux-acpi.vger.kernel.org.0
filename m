Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939DE354859
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbhDEVuP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:26874 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242331AbhDEVuL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:11 -0400
IronPort-SDR: RX2a3ninTge4TfGtWKTKyarOhBwaLeZLNOfnOuvFRKv15H21QXAaTBIyNzYjMBX7EMsHDWyo3d
 xVbSIKfhwERA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278760"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278760"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: uSskN1DU7uQyQqojk8xVko6i2svCw/CxN8CjUwK/oWQWstP9eEnyUVM439XMpiGDCu+k6xrkRO
 UfKDF/QHr86Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673633"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 19/22] ACPICA: iASL: Decode subtable type field for VIOT
Date:   Mon,  5 Apr 2021 14:15:07 -0700
Message-Id: <20210405211510.484603-20-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

For the table disassembler, decode the subtable type field to a descriptive string.

ACPICA commit 2197e354fb5dcafaddd2016ffeb0620e5bc3d5e2

Link: https://github.com/acpica/acpica/commit/2197e354
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl3.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index e9bd7ce65f7c..c0e68331f1fc 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -514,6 +514,7 @@ enum acpi_viot_node_type {
 	ACPI_VIOT_NODE_MMIO = 0x02,
 	ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI = 0x03,
 	ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO = 0x04,
+	ACPI_VIOT_RESERVED = 0x05
 };
 
 /* VIOT subtables */
-- 
2.29.2

