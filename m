Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263191A276
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 19:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfEJRhn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 13:37:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:17666 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJRhn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 13:37:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 10:37:43 -0700
X-ExtLoop1: 1
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2019 10:37:42 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 2/2] ACPICA: Update version to 20190509
Date:   Fri, 10 May 2019 10:25:43 -0700
Message-Id: <20190510172543.9831-3-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190510172543.9831-1-erik.schmauss@intel.com>
References: <20190510172543.9831-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 36449fa1dc914113f2b096622d22c2621fd22861

Version 20190509.

Link: https://github.com/acpica/acpica/commit/36449fa1
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 3b1b1d0e4c33..4a8a05401fb5 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20190405
+#define ACPI_CA_VERSION                 0x20190509
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.17.2

