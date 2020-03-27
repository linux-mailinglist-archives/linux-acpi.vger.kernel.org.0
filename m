Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28941196169
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgC0WnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgC0WnN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:13 -0400
IronPort-SDR: bDV+EgKXNgCWbB71D5F7QbHxkXsS/Br5Z/eQtqeOubh6v0mFq7h5RPfHEL3QT7XhdCD5gGUoWw
 a40AbhX+YHUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:13 -0700
IronPort-SDR: MGsgKWM/pim5i10wFlxcEZYNScuA8T9OsDlv4gCQLM/0tE64LJJwz4oQLX4XjGgUwD+VBN07CZ
 MHWTj67V/ozQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051983"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:12 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 07/10] ACPICA: WSMT: Fix typo, no functional change
Date:   Fri, 27 Mar 2020 15:21:07 -0700
Message-Id: <20200327222110.1204634-8-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 764d18c5a83949ff3b0dbda6055cee1929b9caa2

The table signature WSMT stands for "Windows SMM Mitigations Table".
It is not "Windows SMM Migrations Table".

Link: https://github.com/acpica/acpica/commit/764d18c5
Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl3.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 2bf3baf819bb..b0b163b9efc6 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -39,7 +39,7 @@
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
 #define ACPI_SIG_WPBT           "WPBT"	/* Windows Platform Binary Table */
-#define ACPI_SIG_WSMT           "WSMT"	/* Windows SMM Security Migrations Table */
+#define ACPI_SIG_WSMT           "WSMT"	/* Windows SMM Security Mitigations Table */
 #define ACPI_SIG_XENV           "XENV"	/* Xen Environment table */
 #define ACPI_SIG_XXXX           "XXXX"	/* Intermediate AML header for ASL/ASL+ converter */
 
@@ -673,10 +673,10 @@ struct acpi_table_wpbt {
 
 /*******************************************************************************
  *
- * WSMT - Windows SMM Security Migrations Table
+ * WSMT - Windows SMM Security Mitigations Table
  *        Version 1
  *
- * Conforms to "Windows SMM Security Migrations Table",
+ * Conforms to "Windows SMM Security Mitigations Table",
  * Version 1.0, April 18, 2016
  *
  ******************************************************************************/
-- 
2.25.1

