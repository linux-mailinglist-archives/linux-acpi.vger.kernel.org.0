Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C578E3F85E5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbhHZKyT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 06:54:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:11478 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234296AbhHZKyQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Aug 2021 06:54:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="197284447"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="197284447"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 03:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="scan'208";a="444514801"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2021 03:53:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 55DA0167; Thu, 26 Aug 2021 13:53:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 1/1] media: ipu3-cio2: Drop reference on error path in cio2_bridge_connect_sensor()
Date:   Thu, 26 Aug 2021 13:53:24 +0300
Message-Id: <20210826105324.36853-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit 71f642833284 ("ACPI: utils: Fix reference counting in
for_each_acpi_dev_match()") moved adev assignment outside of error
path and hence made acpi_dev_put(sensor->adev) a no-op. We still
need to drop reference count on error path, and to achieve that,
replace sensor->adev by locally assigned adev.

Fixes: 71f642833284 ("ACPI: utils: Fix reference counting in for_each_acpi_dev_match()")
Depends-on: fc68f42aa737 ("ACPI: fix NULL pointer dereference")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v2: added tag (Sakari), Cc'ed to Rafael to pick up (would be nice to push it to v5.14)
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index 59a36f922675..30d29b96a339 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -226,7 +226,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 err_free_swnodes:
 	software_node_unregister_nodes(sensor->swnodes);
 err_put_adev:
-	acpi_dev_put(sensor->adev);
+	acpi_dev_put(adev);
 	return ret;
 }
 
-- 
2.32.0

