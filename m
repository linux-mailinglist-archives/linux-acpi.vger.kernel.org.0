Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BE355E68
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbhDFWF1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:54926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242751AbhDFWFT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:19 -0400
IronPort-SDR: qPzx2Z+mw4VwABr5yHJcKqORbw7zLP7Md264ibloWjzJXCxgGNrsUNKLC6vwLxmTRzgVSb+Wr/
 hTxigYMH8BXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640460"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640460"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:09 -0700
IronPort-SDR: eIJx9or04TN9TGPLjR9aoDI2PBrhr3F+optaRnUYv5i2eBtpPBT5mz5Fks9gBZhKrs4NTGdI8b
 y5jwW3slWIpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581729"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Elyes HAOUAS <ehaouas@noos.fr>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 07/22] ACPICA: ACPI 6.4: PPTT: add new version of subtable type 1
Date:   Tue,  6 Apr 2021 14:30:13 -0700
Message-Id: <20210406213028.718796-8-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This commit squashes the following:

ACPICA commit 475c5e89f8f701ccdfee6ca567e33c854ecd6c9e
ACPICA commit 82cf78ac175a4b7d8842c5b786be24031c817cfd

This new subtable is only valid for PPTT version 3.

Elyes fixed a misspelled identifier in this commit.

Link: https://github.com/acpica/acpica/commit/475c5e89
Link: https://github.com/acpica/acpica/commit/82cf78ac
Signed-off-by: Elyes HAOUAS <ehaouas@noos.fr>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9c674e03eb05..32467a7133c9 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1529,6 +1529,12 @@ struct acpi_pptt_cache {
 	u16 line_size;
 };
 
+/* 1: Cache Type Structure for PPTT version 3 */
+
+struct acpi_pptt_cache_v1 {
+	u32 cache_id;
+};
+
 /* Flags */
 
 #define ACPI_PPTT_SIZE_PROPERTY_VALID       (1)	/* Physical property valid */
@@ -1538,6 +1544,7 @@ struct acpi_pptt_cache {
 #define ACPI_PPTT_CACHE_TYPE_VALID          (1<<4)	/* Cache type valid */
 #define ACPI_PPTT_WRITE_POLICY_VALID        (1<<5)	/* Write policy valid */
 #define ACPI_PPTT_LINE_SIZE_VALID           (1<<6)	/* Line size valid */
+#define ACPI_PPTT_CACHE_ID_VALID            (1<<7)	/* Cache ID valid */
 
 /* Masks for Attributes */
 
-- 
2.29.2

