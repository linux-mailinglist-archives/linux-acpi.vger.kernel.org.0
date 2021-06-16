Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13DB3AA208
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFPRFs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:05:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:61468 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFPRFn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:05:43 -0400
IronPort-SDR: As6Vmqul+8GujykBRTiBAJ9tHmBM4iyYEoO+LBhjb3Odlcl5lNHXVbbtfDp3xfYX75xFJ3dRwQ
 ou0OhO8OXDSA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="267367482"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="267367482"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 10:03:33 -0700
IronPort-SDR: gloJPuRUnpX+aqThQnHUp0DqZW472ucgdsixzhP556auHGXvfH4EmFPI5DXMVUZIApHkBMZhpk
 ItJFiALyvLkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="452417183"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2021 10:03:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 40C7F50E; Wed, 16 Jun 2021 20:03:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 4/7] ACPI: sysfs: Refactor param_get_trace_state() to drop dead code
Date:   Wed, 16 Jun 2021 20:03:35 +0300
Message-Id: <20210616170338.23057-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
References: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The param_get_trace_state() has a few dead code issues:
 - 'return 0;' is never reachable
 - a few 'else' keywords are redundant

Refactor param_get_trace_state() to drop dead code.

Note, leave one 'else' in order to have the best readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sysfs.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index efb8c2dfa9cb..7239d87e78e6 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -255,16 +255,12 @@ static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
 {
 	if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
 		return sprintf(buffer, "disable\n");
-	else {
-		if (acpi_gbl_trace_method_name) {
-			if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
-				return sprintf(buffer, "method-once\n");
-			else
-				return sprintf(buffer, "method\n");
-		} else
-			return sprintf(buffer, "enable\n");
-	}
-	return 0;
+	if (!acpi_gbl_trace_method_name)
+		return sprintf(buffer, "enable\n");
+	if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
+		return sprintf(buffer, "method-once\n");
+	else
+		return sprintf(buffer, "method\n");
 }
 
 module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
-- 
2.30.2

