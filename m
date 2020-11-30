Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96372C8E6C
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbgK3TtA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 14:49:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:18516 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388096AbgK3TtA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Nov 2020 14:49:00 -0500
IronPort-SDR: FsK29jSdC8JmzV1v+0vozUb3tEEUqkdArzPjczhj1Hz46HnvWjVkgVhv5hBa2Zvj40WJJ+4/sJ
 pSVhYdAGErQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151954754"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151954754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:48:01 -0800
IronPort-SDR: QnqgbhkOzej+iBScMWawlAf1LMjiji6soeJIqTjRUxSKythKG+SdtOBOFB+iQla9O+PFuXsF9+
 zIbOeU4Tlqog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404844953"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2020 11:48:01 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 6/6] ACPICA: Update version to 20201113
Date:   Mon, 30 Nov 2020 11:20:48 -0800
Message-Id: <20201130192048.3093726-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130192048.3093726-1-erik.kaneda@intel.com>
References: <20201130192048.3093726-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 090f0444238bd49f563bf80f4f3a863463dfdf78

Version 20201113.

Link: https://github.com/acpica/acpica/commit/090f0444
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index be7de305a622..0bba8b8c350e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20200925
+#define ACPI_CA_VERSION                 0x20201113
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.25.1

