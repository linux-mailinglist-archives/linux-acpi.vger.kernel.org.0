Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F68A2FF9AA
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 02:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbhAVA5K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 19:57:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:34968 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbhAVA5C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 19:57:02 -0500
IronPort-SDR: FUs0xunQCYXAqW4tG8SGngGjAtDR2bh6Debr6GRf86YqiQulpdGN7iHNo/H5MulZJzSX5gfq5M
 E6JlHEaoTe1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240908708"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="240908708"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:56:21 -0800
IronPort-SDR: t78x6BQScjotYTKcGEXhxDdEtKUJATr6SJ+dsUj29oub9J7R/hA+wl6MwjrGnpGR7QC3LkxB1B
 M5Jdop0Y4duQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427595528"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2021 16:56:21 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 1/9] ACPICA: Fix exception code class checks
Date:   Thu, 21 Jan 2021 16:23:49 -0800
Message-Id: <20210122002357.370836-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122002357.370836-1-erik.kaneda@intel.com>
References: <20210122002357.370836-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Maximilian Luz <luzmaximilian@gmail.com>

ACPICA commit 1a3a549286ea9db07d7ec700e7a70dd8bcc4354e

The macros to classify different AML exception codes are broken. For
instance,

  ACPI_ENV_EXCEPTION(Status)

will always evaluate to zero due to

  #define AE_CODE_ENVIRONMENTAL      0x0000
  #define ACPI_ENV_EXCEPTION(Status) (Status & AE_CODE_ENVIRONMENTAL)

Similarly, ACPI_AML_EXCEPTION(Status) will evaluate to a non-zero value
for error codes of type AE_CODE_PROGRAMMER, AE_CODE_ACPI_TABLES, as well
as AE_CODE_AML, and not just AE_CODE_AML as the name suggests.

This commit fixes those checks.

Fixes: e884d78aab26 ("AML Parser: ignore all exceptions that result from incorrect AML during table load")

Link: https://github.com/acpica/acpica/commit/1a3a5492
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acexcep.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 2fc624a61769..f8a4afb0279a 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -59,11 +59,11 @@ struct acpi_exception_info {
 
 #define AE_OK                           (acpi_status) 0x0000
 
-#define ACPI_ENV_EXCEPTION(status)      (status & AE_CODE_ENVIRONMENTAL)
-#define ACPI_AML_EXCEPTION(status)      (status & AE_CODE_AML)
-#define ACPI_PROG_EXCEPTION(status)     (status & AE_CODE_PROGRAMMER)
-#define ACPI_TABLE_EXCEPTION(status)    (status & AE_CODE_ACPI_TABLES)
-#define ACPI_CNTL_EXCEPTION(status)     (status & AE_CODE_CONTROL)
+#define ACPI_ENV_EXCEPTION(status)      (((status) & AE_CODE_MASK) == AE_CODE_ENVIRONMENTAL)
+#define ACPI_AML_EXCEPTION(status)      (((status) & AE_CODE_MASK) == AE_CODE_AML)
+#define ACPI_PROG_EXCEPTION(status)     (((status) & AE_CODE_MASK) == AE_CODE_PROGRAMMER)
+#define ACPI_TABLE_EXCEPTION(status)    (((status) & AE_CODE_MASK) == AE_CODE_ACPI_TABLES)
+#define ACPI_CNTL_EXCEPTION(status)     (((status) & AE_CODE_MASK) == AE_CODE_CONTROL)
 
 /*
  * Environmental exceptions
-- 
2.29.2

