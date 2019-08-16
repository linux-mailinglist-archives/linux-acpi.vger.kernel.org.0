Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1170A90A8F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfHPV6d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:56323 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbfHPV6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381378"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:32 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 3/9] ACPICA: Macros: remove pointer math on a null pointer
Date:   Fri, 16 Aug 2019 14:43:22 -0700
Message-Id: <20190816214328.3900-4-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 02bbca5070e42d298c9b824300aa0eb8a082d797

Causes warnings on some compilers and/or tools.
Changed ACPI_TO_POINTER to use ACPI_CAST_PTR instead of using
arithmetic.


Link: https://github.com/acpica/acpica/commit/02bbca50
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index e31ef75a22a1..f52c83eaedc4 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -506,7 +506,7 @@ typedef u64 acpi_integer;
 
 /* Pointer/Integer type conversions */
 
-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0, (acpi_size) (i))
+#define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
 #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
-- 
2.17.2

