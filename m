Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2892354850
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhDEVuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:38289 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241747AbhDEVuH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:07 -0400
IronPort-SDR: nebSh9Z9dR+ZlFw6yCex8l2lYEMd3dYdi1O4H1XyZndQx8AScrSnX3SloKn9P/YPcvl0gpvMJa
 yZyhHZ8cyS6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256914966"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="256914966"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:59 -0700
IronPort-SDR: FpbXA3SlGkEVk79JRcLitcL2jLhgV12ytqmVGNmgZiVX9OKhM1EOcDdDbBFrr5B9izQvG2ZD3u
 7naTZHK4epEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673598"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 08/22] ACPICA: Tree-wide: fix various typos and spelling mistakes
Date:   Mon,  5 Apr 2021 14:14:56 -0700
Message-Id: <20210405211510.484603-9-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210405211510.484603-1-erik.kaneda@intel.com>
References: <20210405211510.484603-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

This commit squashes the following:
ACPICA commit bc8939e2d902653e71bb1601b129a993c37fcfad
ACPICA commit 2d9e5e98e23f2a569e5691e6bed183146e25798d
ACPICA commit 937358156631ea7a0eef3569c213c82a031097d5

Fix more spelling issues found using the codespell checker and found
without tools.

Link: https://github.com/acpica/acpica/commit/bc8939e2
Link: https://github.com/acpica/acpica/commit/2d9e5e98
Link: https://github.com/acpica/acpica/commit/93735815

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acoutput.h           | 2 +-
 include/acpi/platform/acgcc.h     | 2 +-
 tools/power/acpi/common/cmfsize.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 1538a6853822..1b4c45815695 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -362,7 +362,7 @@
  *
  * A less-safe version of the macros is provided for optional use if the
  * compiler uses excessive CPU stack (for example, this may happen in the
- * debug case if code optimzation is disabled.)
+ * debug case if code optimization is disabled.)
  */
 
 /* Exit trace helper macro */
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 0cd4f61d4248..f6656be81760 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -61,7 +61,7 @@ typedef __builtin_va_list va_list;
 #endif
 
 /*
- * Explictly mark intentional explicit fallthrough to silence
+ * Explicitly mark intentional explicit fallthrough to silence
  * -Wimplicit-fallthrough in GCC 7.1+.
  */
 
diff --git a/tools/power/acpi/common/cmfsize.c b/tools/power/acpi/common/cmfsize.c
index 9ea2c0aeb86c..185b8c588e1d 100644
--- a/tools/power/acpi/common/cmfsize.c
+++ b/tools/power/acpi/common/cmfsize.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
 /******************************************************************************
  *
- * Module Name: cfsize - Common get file size function
+ * Module Name: cmfsize - Common get file size function
  *
  * Copyright (C) 2000 - 2021, Intel Corp.
  *
-- 
2.29.2

