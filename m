Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0540D3AA1FE
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFPRFl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:05:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:26597 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhFPRFf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:05:35 -0400
IronPort-SDR: c+zUCe8JgMw+OA2Yl0YBcGvyWMM21gIVfn6Y20E+gqck0vJYpa2RYaYM6+D0on+uVDx2lH0H5z
 5xSy4Z5Kb+EQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="203195505"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="203195505"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 10:03:29 -0700
IronPort-SDR: ip+QDHi0IfmyDvJTVitmin1dOGNiEY2towS6YV8PGPNkigyVsOrwh7j3GwWzq9iyEbuSZvnxZv
 jvr4qbMI9djg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="415812669"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2021 10:03:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 358012AA; Wed, 16 Jun 2021 20:03:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/7] ACPI: sysfs: Make sparse happy about address space in use
Date:   Wed, 16 Jun 2021 20:03:32 +0300
Message-Id: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sparse is not happy about address space in use in acpi_data_show():

drivers/acpi/sysfs.c:428:14: warning: incorrect type in assignment (different address spaces)
drivers/acpi/sysfs.c:428:14:    expected void [noderef] __iomem *base
drivers/acpi/sysfs.c:428:14:    got void *
drivers/acpi/sysfs.c:431:59: warning: incorrect type in argument 4 (different address spaces)
drivers/acpi/sysfs.c:431:59:    expected void const *from
drivers/acpi/sysfs.c:431:59:    got void [noderef] __iomem *base
drivers/acpi/sysfs.c:433:30: warning: incorrect type in argument 1 (different address spaces)
drivers/acpi/sysfs.c:433:30:    expected void *logical_address
drivers/acpi/sysfs.c:433:30:    got void [noderef] __iomem *base

Indeed, acpi_os_map_memory() returns a void pointer with dropped specific
address space. Hence, we don't need to carry out __iomem in acpi_data_show().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 88629d26bd48..767aa65e4bdd 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -419,7 +419,7 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
 			      loff_t offset, size_t count)
 {
 	struct acpi_data_attr *data_attr;
-	void __iomem *base;
+	void *base;
 	ssize_t rc;
 
 	data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
-- 
2.30.2

