Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863592A58CF
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 22:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgKCVzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 16:55:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:43677 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbgKCUpN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 15:45:13 -0500
IronPort-SDR: 69dTiWPgBMP0GUpSsmNilEVpBw68vH8hiscihniKkdf6fVAGkWSXvbZaPBo8wLsXCY49KyDjKy
 b86YhcPJvp6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="168336471"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="168336471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:45:13 -0800
IronPort-SDR: K1e7s1hXQuhsHjIMcZMBp0MkYi007D4ZNy/YyMnW9MFaKbbZALwiVE8mAOkyHAmBDz6JNsO87s
 uq/6tjxkBUxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="357803002"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2020 12:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C50E876; Tue,  3 Nov 2020 22:45:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 1/7] resource: Simplify region_intersects() by reducing conditionals
Date:   Tue,  3 Nov 2020 22:45:04 +0200
Message-Id: <20201103204510.19154-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now we have for 'other' and 'type' variables

other	type	return
  0	  0	REGION_DISJOINT
  0	  x	REGION_INTERSECTS
  x	  0	REGION_DISJOINT
  x	  x	REGION_MIXED

Obviously it's easier to check 'type' for 0 first instead of
currently checked 'other'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/resource.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 3ae2f56cc79d..82df80417489 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -557,13 +557,13 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 	}
 	read_unlock(&resource_lock);
 
-	if (other == 0)
-		return type ? REGION_INTERSECTS : REGION_DISJOINT;
+	if (type == 0)
+		return REGION_DISJOINT;
 
-	if (type)
-		return REGION_MIXED;
+	if (other == 0)
+		return REGION_INTERSECTS;
 
-	return REGION_DISJOINT;
+	return REGION_MIXED;
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
-- 
2.28.0

