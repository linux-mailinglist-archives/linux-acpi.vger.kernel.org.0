Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EED355E6B
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhDFWFb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:51785 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243391AbhDFWFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:21 -0400
IronPort-SDR: XsZcWh4R4FPUt+9F3rmjYjssNQ5F8HvjI+C3j13Wo99SB5PwQgYcUeqKXu4uy8koDIRIMH4tKK
 dsJePFDfjlGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="173244345"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="173244345"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:10 -0700
IronPort-SDR: yrMQInZiuW7ubPej9Qkjgm0TSYfinqqen44Li+Nlb8CCjOu5vjxuF2XzyTI0EKd8mbelSZB/1h
 Fy+8Uk8T1zJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581765"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:09 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 18/22] ACPICA: iASL: Add support for CEDT table
Date:   Tue,  6 Apr 2021 14:30:24 -0700
Message-Id: <20210406213028.718796-19-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Also, update the CEDT template.

ACPICA commit 1e6dded267b13c4aa0c3e16de0fa89d3b9c880e9

Link: https://github.com/acpica/acpica/commit/1e6dded2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7b286766e810..ce59903c2695 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -327,6 +327,7 @@ struct acpi_cedt_header {
 
 enum acpi_cedt_type {
 	ACPI_CEDT_TYPE_CHBS = 0,
+	ACPI_CEDT_TYPE_RESERVED = 1
 };
 
 /*
@@ -336,7 +337,7 @@ enum acpi_cedt_type {
 /* 0: CXL Host Bridge Structure */
 
 struct acpi_cedt_chbs {
-	ACPI_CEDT_HEADER header;
+	struct acpi_cedt_header header;
 	u32 uid;
 	u32 cxl_version;
 	u32 reserved;
-- 
2.29.2

