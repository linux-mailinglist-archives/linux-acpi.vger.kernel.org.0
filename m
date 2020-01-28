Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7E014BD23
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 16:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA1PmL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 10:42:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:38063 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgA1PmL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 10:42:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 07:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="222786951"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2020 07:42:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E15F913F; Tue, 28 Jan 2020 17:42:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Sort entries in database for X-POWERS AXP288
Date:   Tue, 28 Jan 2020 17:42:00 +0200
Message-Id: <20200128154200.65317-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Run parse-maintainers.pl and choose X-POWERS AXP288 record. Fix it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb25407e665a..3e9951659c52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18140,8 +18140,8 @@ F:	Documentation/core-api/workqueue.rst
 X-POWERS AXP288 PMIC DRIVERS
 M:	Hans de Goede <hdegoede@redhat.com>
 S:	Maintained
-N:	axp288
 F:	drivers/acpi/pmic/intel_pmic_xpower.c
+N:	axp288
 
 X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Chen-Yu Tsai <wens@csie.org>
-- 
2.24.1

