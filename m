Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC8A39BD9F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFDQwZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 12:52:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:56388 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhFDQwY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:52:24 -0400
IronPort-SDR: KfucV+FVcD5GuI6TPFi3Ako5Do0kuDUn7VyNwy0MHJG4ac4qbgrK1aAhwIL7Pxg3OA+KNfaDAe
 6bUTmI4H3Xog==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="184008919"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="184008919"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:50:34 -0700
IronPort-SDR: N5LXwJMvgp3m7Ry5PmKkpXvI9J5zliqZXZx2OBsWkJSTGOcdtMYGP0V0BIQm3GWRsBVNU00KY/
 zInwbfPFujjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="412420880"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2021 09:50:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8510B67; Fri,  4 Jun 2021 19:50:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v3 2/3] ACPI: bus: Constify acpi_dma_supported() helper function
Date:   Fri,  4 Jun 2021 19:50:46 +0300
Message-Id: <20210604165047.13243-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210604165047.13243-1-andriy.shevchenko@linux.intel.com>
References: <20210604165047.13243-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Constify arguments to acpi_dma_supported(). The function doesn't need
to change the content of the passed argument and when it's const it
allows to supply the result of other functions that may return a pointer
to a constant object.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
 drivers/acpi/scan.c     | 2 +-
 include/acpi/acpi_bus.h | 2 +-
 include/linux/acpi.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a2df7bcf4d07..5040ce3c3ed1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1405,7 +1405,7 @@ void acpi_free_pnp_ids(struct acpi_device_pnp *pnp)
  *
  * Return false if DMA is not supported. Otherwise, return true
  */
-bool acpi_dma_supported(struct acpi_device *adev)
+bool acpi_dma_supported(const struct acpi_device *adev)
 {
 	if (!adev)
 		return false;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a82faac5767..2fbd2c2e0568 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -586,7 +586,7 @@ struct acpi_pci_root {
 
 /* helper */
 
-bool acpi_dma_supported(struct acpi_device *adev);
+bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
 int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 		       u64 *size);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 40657f220f8b..97f1c5588b5a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -911,7 +911,7 @@ acpi_create_platform_device(struct acpi_device *adev,
 	return NULL;
 }
 
-static inline bool acpi_dma_supported(struct acpi_device *adev)
+static inline bool acpi_dma_supported(const struct acpi_device *adev)
 {
 	return false;
 }
-- 
2.30.2

