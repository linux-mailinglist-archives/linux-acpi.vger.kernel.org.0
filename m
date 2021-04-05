Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82825354855
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbhDEVuM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:38289 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241805AbhDEVuL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:11 -0400
IronPort-SDR: QSl+Iq42T/cwiVkzZigb4PZSJyQGDQzsHGj3mePNSUVaj0laDf2Zmo28xm0ufqB6oqM05rFIM1
 zaB07g/fsZXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914967"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914967"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: pi173Z09pIkXlzKeWJC/WMM4GVdzTtkrmn0ML8hgtOK/jPdOD2/TIDjCojE66xcoWm8WDpHGLr
 EPHS39/LAObQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673601"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 09/22] ACPICA: ACPI 6.4: NFIT: add Location Cookie field
Date:   Mon,  5 Apr 2021 14:14:57 -0700
Message-Id: <20210405211510.484603-10-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit af60199a9a1de9e6844929fd4cc22334522ed195

Link: https://github.com/acpica/acpica/commit/af60199a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 2 ++
 1 file changed, 2 insertions(+)

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

