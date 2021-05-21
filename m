Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4315D38D1CE
	for <lists+linux-acpi@lfdr.de>; Sat, 22 May 2021 01:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhEUXEU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 19:04:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:11009 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhEUXET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 May 2021 19:04:19 -0400
IronPort-SDR: +ZBvmjp8SAYA+Inn+UUW04yrf6eGrP07Hk5TWZ6Pv5j4BxOL2K1av+aRPIjG5K4sVNFIwQ1h7N
 mW+f7Vohg4wQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="265494911"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265494911"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 16:02:56 -0700
IronPort-SDR: oTi5bua53XFi6OMW6VoIRbJZvHk0QFmf7C1hG4OtKd6aStlRpyW4jGCG4vgdvIgyd3R/MKR9wG
 fOnFRchGP2dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="544253758"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2021 16:02:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        John Garry <john.garry@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 1/1] ACPICA: Clean up context mutex during object deletion
Date:   Fri, 21 May 2021 15:28:08 -0700
Message-Id: <20210521222808.2174134-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210521222808.2174134-1-erik.kaneda@intel.com>
References: <20210521222808.2174134-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit bc43c878fd4ff27ba75b1d111b97ee90d4a82707

Fixes: c27f3d011b08 ("Fix race in GenericSerialBus (I2C) and GPIO OpRegion parameter handling")

Link: https://github.com/acpica/acpica/commit/bc43c878
Reported-by: John Garry <john.garry@huawei.com>
Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utdelete.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 624a26794d55..e5ba9795ec69 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -285,6 +285,14 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 		}
 		break;
 
+	case ACPI_TYPE_LOCAL_ADDRESS_HANDLER:
+
+		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
+				  "***** Address handler %p\n", object));
+
+		acpi_os_delete_mutex(object->address_space.context_mutex);
+		break;
+
 	default:
 
 		break;
-- 
2.29.2

