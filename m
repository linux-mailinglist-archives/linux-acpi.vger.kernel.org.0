Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C30355E6E
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhDFWFc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:54929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242361AbhDFWF3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:29 -0400
IronPort-SDR: 8mvzsGI2+5hInFeKwp3Q8kdR09ayvl4WLcAXpNW/MsfAaFJE95NmYOw1peTfdrOokwP3ByOuAr
 0NUbV2RIjy7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640466"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640466"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: 1UfJSm2+Xj1H9INtHCB8mSZOVTIjp7otd3TUo0+Ni8RaRwYw2wrJmKKfmscTSa/yWTjU7OH0nQ
 4GcNPZvVvW9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581742"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 11/22] ACPICA: ACPI 6.4: Add new flags in SRAT
Date:   Tue,  6 Apr 2021 14:30:17 -0700
Message-Id: <20210406213028.718796-12-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
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

