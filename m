Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7F35485B
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbhDEVuP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:38284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242340AbhDEVuM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:12 -0400
IronPort-SDR: rPYeKcM8z4XRXhtAl/nAcg6ZB5hHinYXUsFeUOIGQXSKYtPrbO14obz4n6/AY+WYnG/u8DzO+d
 PnOOAxVqZE2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914970"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914970"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: yHV6ZXTOlh0kRwBB8ilnB7+EABFlLu3Ibq+lwByPWY87c0f3WYC1mqXBHA1xcPecd+bn3mjHiQ
 m97asRcDAolg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673610"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 11/22] ACPICA: ACPI 6.4: Add new flags in SRAT
Date:   Mon,  5 Apr 2021 14:14:59 -0700
Message-Id: <20210405211510.484603-12-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 44633fa72f1e4ede718733aec16e7fb7572042f8

Link: https://github.com/acpica/acpica/commit/44633fa7
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl3.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index df5f4b27f3aa..bf61a70deb22 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -285,7 +285,8 @@ struct acpi_srat_generic_affinity {
 
 /* Flags for struct acpi_srat_generic_affinity */
 
-#define ACPI_SRAT_GENERIC_AFFINITY_ENABLED (1)	/* 00: Use affinity structure */
+#define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)	/* 00: Use affinity structure */
+#define ACPI_SRAT_ARCHITECTURAL_TRANSACTIONS   (1<<1)	/* ACPI 6.4 */
 
 /*******************************************************************************
  *
-- 
2.29.2

