Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810F535484C
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbhDEVuI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:38284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241689AbhDEVuG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:06 -0400
IronPort-SDR: CSvt6EQIAA6+CGJBEmo4Em8arWsm3T5/5C3SvikKsmwfBx2QPc3lOoRH1oTyYL1IneQBVF5+NE
 QgGtuLuqP5dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914964"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914964"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: jVia7AlPlZsng9vPnEwx6xQ+HwFqX0sOAFmriNM4F6e4++suIKbrxOYST8yiUduBF1v7SmamUY
 NETxq5wktdhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673594"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Elyes HAOUAS <ehaouas@noos.fr>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 07/22] ACPICA: ACPI 6.4: PPTT: add new version of subtable type 1
Date:   Mon,  5 Apr 2021 14:14:55 -0700
Message-Id: <20210405211510.484603-8-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

