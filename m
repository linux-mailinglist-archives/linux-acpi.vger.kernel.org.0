Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3573AA204
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhFPRFn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:05:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:61468 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhFPRFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:05:41 -0400
IronPort-SDR: WOjpzz011ZUgdnVaglVipYfrqcpYllI1OhzwsoOGBZq/DATe1ZNENHKhAq+JGW0vzBrSWTU82u
 jFrSUK3zmdJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="267367479"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="267367479"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 10:03:32 -0700
IronPort-SDR: XPa3QheejKa7cc5DroKsDdKOQzb6e5GcdrWa/7Nw1E7w3oneN5/z3JzuFUTT5/e4kl+sQz/oRI
 qMxsoU1n7yLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="488260773"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2021 10:03:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 622365B5; Wed, 16 Jun 2021 20:03:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 7/7] ACPI: sysfs: Sort headers alphabetically
Date:   Wed, 16 Jun 2021 20:03:38 +0300
Message-Id: <20210616170338.23057-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
References: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For the sake of better maintenance, sort included headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 5474563d72b8..00c0ebaab29f 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -5,11 +5,11 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
-#include <linux/acpi.h>
 
 #include "internal.h"
 
-- 
2.30.2

