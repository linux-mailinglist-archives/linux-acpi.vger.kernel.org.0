Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA36838900B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbhESOOK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 10:14:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:44083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347137AbhESOOH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 10:14:07 -0400
IronPort-SDR: Mn0fK9FSWKZSqFphqtXIYGFLxkJZD5MXfIB5QD+od9bPyY9IPsIWgTdBbu3PWKBzjiacMUedMr
 l0rlMqo370jQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262212444"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262212444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 07:12:45 -0700
IronPort-SDR: 5Tk8rI7+8PDVU7+GLdA9xSnhjYipPOnTcuwRb3NyaJ44pYbwTrZYcT4TEXJY+2gUAJdHTlMvAH
 If6ppvmaEiFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="394421820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2021 07:12:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BDA80836; Wed, 19 May 2021 17:12:59 +0300 (EEST)
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
Subject: [PATCH 9/9] thunderbolt: Check for NVM authentication status after the operation started
Date:   Wed, 19 May 2021 17:12:59 +0300
Message-Id: <20210519141259.84839-10-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
References: <20210519141259.84839-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If the NVM authentication fails immediately, like if the firmware
detects that the image is not valid for some reason, better to read the
status once and if set to non-zero fail the operation accordingly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/retimer.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 3aa790aa6500..722694052f4a 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -151,6 +151,7 @@ static int tb_retimer_nvm_validate_and_write(struct tb_retimer *rt)
 
 static int tb_retimer_nvm_authenticate(struct tb_retimer *rt, bool auth_only)
 {
+	u32 status;
 	int ret;
 
 	if (auth_only) {
@@ -159,7 +160,24 @@ static int tb_retimer_nvm_authenticate(struct tb_retimer *rt, bool auth_only)
 			return ret;
 	}
 
-	return usb4_port_retimer_nvm_authenticate(rt->port, rt->index);
+	ret = usb4_port_retimer_nvm_authenticate(rt->port, rt->index);
+	if (ret)
+		return ret;
+
+	usleep_range(100, 150);
+
+	/*
+	 * Check the status now if we still can access the retimer. It
+	 * is expected that the below fails.
+	 */
+	ret = usb4_port_retimer_nvm_authenticate_status(rt->port, rt->index,
+							&status);
+	if (!ret) {
+		rt->auth_status = status;
+		return status ? -EINVAL : 0;
+	}
+
+	return 0;
 }
 
 static ssize_t device_show(struct device *dev, struct device_attribute *attr,
-- 
2.30.2

