Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA72324F26
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 12:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhBYL22 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 06:28:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12577 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhBYL1c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 06:27:32 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DmVnC71ndzMf2k;
        Thu, 25 Feb 2021 19:24:47 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 19:26:40 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <devel@acpica.org>, <linux-acpi@vger.kernel.org>
CC:     <Robert.Moore@intel.com>, <erik.kaneda@intel.com>,
        <robin.murphy@arm.com>, <rafael.j.wysocki@intel.com>,
        <guohanjun@huawei.com>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3 subtable
Date:   Thu, 25 Feb 2021 19:26:20 +0800
Message-ID: <20210225112620.1827-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As per the IORT spec, this field overrides the value in SMMU_IRD0.HTTU
which should always have been 2 bits.

Fixes: 9f7c3e148f44 ("IORT: Add in support for the SMMUv3 subtable")
Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 source/common/dmtbinfo2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/common/dmtbinfo2.c b/source/common/dmtbinfo2.c
index 17a80ba21..321f106fa 100644
--- a/source/common/dmtbinfo2.c
+++ b/source/common/dmtbinfo2.c
@@ -343,7 +343,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
     {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (BaseAddress),            "Base Address", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Flags (decoded below)", 0},
     {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "COHACC Override", 0},
-    {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU Override", 0},
+    {ACPI_DMT_FLAGS1,   ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU Override", 0},
     {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "Proximity Domain Valid", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Reserved", 0},
     {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VATOS Address", 0},
-- 
2.19.1

