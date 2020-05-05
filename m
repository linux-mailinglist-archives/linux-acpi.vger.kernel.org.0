Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93C1C4B3F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 03:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgEEBIh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 21:08:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:50714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgEEBIg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 21:08:36 -0400
IronPort-SDR: NvOZxq5yyPK5PEcFGQFIUeHx4q2rv6Xvq+naPQm0P4kn93/0ZFIXRQzw698CiCSIP+15kgpLuF
 Aow/QK2calOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:08:36 -0700
IronPort-SDR: w8fiM1mmUcq1rOpOjS15evfn/Eo/ZMRrKaoEtpSgKrAR1fuwudbsCxe+810pFqmMy+03gptZju
 rr/B+GGMR1fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460865792"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 18:08:35 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Hulk Robot <hulkci@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/6] ACPICA: Move acpi_gbl_next_cmd_num definition to acglobal.h
Date:   Mon,  4 May 2020 17:46:50 -0700
Message-Id: <20200505004654.2870591-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505004654.2870591-1-erik.kaneda@intel.com>
References: <20200505004654.2870591-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 8296a24f33984c26a61103c590b049de3c9b61ff

This commit cleans up the code by moving the global definition out of
dbhistry.c to acglobal.h.

Link: https://github.com/acpica/acpica/commit/8296a24f
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 1 +
 drivers/acpi/acpica/dbhistry.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 38ffa2c0a496..1030a0ce1599 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -290,6 +290,7 @@ ACPI_GLOBAL(struct acpi_external_file *, acpi_gbl_external_file_list);
 #ifdef ACPI_DEBUGGER
 ACPI_INIT_GLOBAL(u8, acpi_gbl_abort_method, FALSE);
 ACPI_INIT_GLOBAL(acpi_thread_id, acpi_gbl_db_thread_id, ACPI_INVALID_THREAD_ID);
+ACPI_INIT_GLOBAL(u32, acpi_gbl_next_cmd_num, 1);
 
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_ini_methods);
 ACPI_GLOBAL(u8, acpi_gbl_db_opt_no_region_support);
diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index bb9600b867ee..f5fba14461a6 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -27,7 +27,6 @@ static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
 static u16 acpi_gbl_lo_history = 0;
 static u16 acpi_gbl_num_history = 0;
 static u16 acpi_gbl_next_history_index = 0;
-u32 acpi_gbl_next_cmd_num = 1;
 
 /*******************************************************************************
  *
-- 
2.25.1

