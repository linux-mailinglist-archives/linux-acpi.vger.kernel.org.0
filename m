Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDE389008
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbhESOOK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:44083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347106AbhESOOE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:04 -0400
IronPort-SDR: xH71pwCdMAH6WkWjIgd5LtfvZ4ljbR+rGU0/YGZZNp+sskhMXWwRnnDT/yE9338eqNJKfMeXsl
 +2XS05vvKspg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262212437"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262212437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:44 -0700
IronPort-SDR: f7pNrtv77+rYnbm4yJSDypEu3WpgcOYCEJ0B/lEcBj+0QMUC957kHA8FrmH205KOW93mGKwZRO
 NHxwkX2E/CJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="394421816"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2021 07:12:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9B27F643; Wed, 19 May 2021 17:12:59 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Casey G Bowman <casey.g.bowman@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6/9] thunderbolt: Move nvm_write_ops to tb.h
Date:   Wed, 19 May 2021 17:12:56 +0300
Message-Id: <20210519141259.84839-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rajmohan Mani <rajmohan.mani@intel.com>

Currently these write ops are used for updating router firmware images
only. Moving to tb.h helps the retimers also to use the same ops.

Also add tb_ prefix to the enum while there.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 5 -----
 drivers/thunderbolt/tb.h     | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index dae59919e2bf..bf4821d3bbab 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -26,11 +26,6 @@ struct nvm_auth_status {
 	u32 status;
 };
 
-enum nvm_write_ops {
-	WRITE_AND_AUTHENTICATE = 1,
-	WRITE_ONLY = 2,
-};
-
 /*
  * Hold NVM authentication failure status per switch This information
  * needs to stay around even when the switch gets power cycled so we
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 341e8443a22d..863d80ad44ab 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -58,6 +58,11 @@ struct tb_nvm {
 	bool flushed;
 };
 
+enum tb_nvm_write_ops {
+	WRITE_AND_AUTHENTICATE = 1,
+	WRITE_ONLY = 2,
+};
+
 #define TB_SWITCH_KEY_SIZE		32
 #define TB_SWITCH_MAX_DEPTH		6
 #define USB4_SWITCH_MAX_DEPTH		5
-- 
2.30.2

