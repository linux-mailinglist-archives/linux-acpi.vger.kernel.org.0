Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA1E35485D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbhDEVuQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:38289 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242300AbhDEVuP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:15 -0400
IronPort-SDR: HjMSHHzv+eqSa80FDHTTo7gL6++dpS+/6S4i6Dy6DUPVrwiHzmpTPtNujSJOID0r6Q7YnOb5DN
 Srljox/bHSjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914975"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914975"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: wnfRUnUnMt3XH01fsEixSbNdhwRanYEfxw1MpFtgdTwAuNXqe9rex5NUekkWI805rjF8bqdvjn
 4CfOLGs22lXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673629"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 18/22] ACPICA: iASL: Add support for CEDT table
Date:   Mon,  5 Apr 2021 14:15:06 -0700
Message-Id: <20210405211510.484603-19-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
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

