Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400371A26E5
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Apr 2020 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgDHQJd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Apr 2020 12:09:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:63799 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730173AbgDHQJc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:32 -0400
IronPort-SDR: foenlJ2M7o8tKKwL1irB0KshPl6Y/DRb+j04OlmMEUtCh/ipM7ov5o4GjTKbyy/7gWB9ZDJVBg
 HzNVo+zAcbCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:09:29 -0700
IronPort-SDR: X7K3cfxw9wb/vfWmFA7aza0AMK/BaIgSjTFpumBZKNg0NHDglshgz7FL84CbVTmJFgTfPFMiE+
 csmp79d02iJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="451655834"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2020 09:09:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95B9279A; Wed,  8 Apr 2020 19:09:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/6] platform/x86: intel_cht_int33fe: Convert to use set_secondary_fwnode()
Date:   Wed,  8 Apr 2020 19:09:04 +0300
Message-Id: <20200408160905.12101-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In one place we open coded set_secondary_fwnode().
Let's replace it with a helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe_typec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe_typec.c b/drivers/platform/x86/intel_cht_int33fe_typec.c
index 0f547d35c90d..904e75d39953 100644
--- a/drivers/platform/x86/intel_cht_int33fe_typec.c
+++ b/drivers/platform/x86/intel_cht_int33fe_typec.c
@@ -239,8 +239,7 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
 	if (max17047) {
 		/* Pre-existing i2c-client for the max17047, add device-props */
-		fwnode->secondary = ERR_PTR(-ENODEV);
-		max17047->dev.fwnode->secondary = fwnode;
+		set_secondary_fwnode(&max17047->dev, fwnode);
 		/* And re-probe to get the new device-props applied. */
 		ret = device_reprobe(&max17047->dev);
 		if (ret)
-- 
2.25.1

