Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205322C8E67
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 20:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgK3Tsf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 14:48:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:18529 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgK3Tse (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Nov 2020 14:48:34 -0500
IronPort-SDR: AasYzb2aURz8t85f/aY4pdnmNWeqDyeQ71OLlVYhc/zooD8Th0/DAuk92QanbvjTvyxy13rMrN
 WY3oZBlc8VaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151954741"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151954741"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:54 -0800
IronPort-SDR: B6US28f6gWyR3edampRRKRGUCMpUDnvHMgLo2HZAatYUeXirgI2ozPhS51oz26ceoaT5gX+Bjt
 bhoZwPNHTMUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404844874"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2020 11:47:54 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 2/6] ACPICA: Remove extreaneous "the" in comments
Date:   Mon, 30 Nov 2020 11:20:44 -0800
Message-Id: <20201130192048.3093726-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130192048.3093726-1-erik.kaneda@intel.com>
References: <20201130192048.3093726-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit f6eae3961bf39ad8beda70c001d1815780600e39

There are several ocurrances of "the the", remove the extraneous
"the".

Link: https://github.com/acpica/acpica/commit/f6eae396
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/accommon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 89101e53324b..94e18bb76556 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -13,7 +13,7 @@
 /*
  * Common set of includes for all ACPICA source files.
  * We put them here because we don't want to duplicate them
- * in the the source code again and again.
+ * in the source code again and again.
  *
  * Note: The order of these include files is important.
  */
-- 
2.25.1

