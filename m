Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD86355E6D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbhDFWFc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:54928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhDFWFY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:24 -0400
IronPort-SDR: 8fVE8PG/dmc/EFd+Af5sDPwl4eb3Tx+WDt1ybQ637Wyng+e+txeTKAhR0AlCiJmTlf4uuj7Wi9
 Sp+nAlryXtRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640463"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640463"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: 1l+UvTDF3eATuh3BzT/B+Ajo3pH0ZhfoBTmzmdWtu1oATHhuMceuNugDcn9mooTSDmbtYar/x+
 s8nZ+d/eQo6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581736"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 09/22] ACPICA: ACPI 6.4: NFIT: add Location Cookie field
Date:   Tue,  6 Apr 2021 14:30:15 -0700
Message-Id: <20210406213028.718796-10-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Also, update struct size to reflect these changes in nfit core driver.

ACPICA commit af60199a9a1de9e6844929fd4cc22334522ed195

Link: https://github.com/acpica/acpica/commit/af60199a
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 include/acpi/actbl2.h    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 8c5dde628405..09b05f720b25 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3831,7 +3831,7 @@ static __init int nfit_init(void)
 	int ret;
 
 	BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
-	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 56);
+	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 64);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_memory_map) != 48);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_interleave) != 20);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_smbios) != 9);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 32467a7133c9..31ed30208c8a 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1008,12 +1008,14 @@ struct acpi_nfit_system_address {
 	u64 address;
 	u64 length;
 	u64 memory_mapping;
+	u64 location_cookie;	/* ACPI 6.4 */
 };
 
 /* Flags */
 
 #define ACPI_NFIT_ADD_ONLINE_ONLY       (1)	/* 00: Add/Online Operation Only */
 #define ACPI_NFIT_PROXIMITY_VALID       (1<<1)	/* 01: Proximity Domain Valid */
+#define ACPI_NFIT_LOCATION_COOKIE_VALID (1<<2)	/* 02: SPA location cookie valid (ACPI 6.4) */
 
 /* Range Type GUIDs appear in the include/acuuid.h file */
 
-- 
2.29.2

