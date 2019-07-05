Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14F56039A
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfGEJ6p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:58:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:42367 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfGEJ6I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 02:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="166448218"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2019 02:58:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0AD0E445; Fri,  5 Jul 2019 12:58:01 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 5/8] thunderbolt: Hide switch attributes that are not set
Date:   Fri,  5 Jul 2019 12:57:57 +0300
Message-Id: <20190705095800.43534-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
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
---
 drivers/thunderbolt/switch.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index eac62ff1b85c..e84067084dcd 100644
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

