Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9639689E8E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfHLMi5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 08:38:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:54173 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHLMi4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Aug 2019 08:38:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 05:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="375218552"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2019 05:38:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4984A38E; Mon, 12 Aug 2019 15:38:48 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 5/8] thunderbolt: Hide switch attributes that are not set
Date:   Mon, 12 Aug 2019 15:38:44 +0300
Message-Id: <20190812123847.50802-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812123847.50802-1-mika.westerberg@linux.intel.com>
References: <20190812123847.50802-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thunderbolt host routers may not always contain DROM that includes
device identification information. This is mostly needed for Ice Lake
systems but some Falcon Ridge controllers on PCs also do not have DROM.

In that case hide the identification attributes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
 drivers/thunderbolt/switch.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 64f845fe4690..bd3eaaf34ea1 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1337,7 +1337,19 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	if (attr == &dev_attr_key.attr) {
+	if (attr == &dev_attr_device.attr) {
+		if (!sw->device)
+			return 0;
+	} else if (attr == &dev_attr_device_name.attr) {
+		if (!sw->device_name)
+			return 0;
+	} else if (attr == &dev_attr_vendor.attr)  {
+		if (!sw->vendor)
+			return 0;
+	} else if (attr == &dev_attr_vendor_name.attr)  {
+		if (!sw->vendor_name)
+			return 0;
+	} else if (attr == &dev_attr_key.attr) {
 		if (tb_route(sw) &&
 		    sw->tb->security_level == TB_SECURITY_SECURE &&
 		    sw->security_level == TB_SECURITY_SECURE)
-- 
2.20.1

