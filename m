Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26222A59D0
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 23:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgKCUhc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 15:37:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:55780 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbgKCUg7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 15:36:59 -0500
IronPort-SDR: ai4HFeNoj4yAxv7GHJnvmrYNgl+j1xPn8G0Z/1V3drTvmLl3tmjYsP2KKn8hMBL4bRQA4RmWna
 RcmVjBKTknYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="156898586"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="156898586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:36:58 -0800
IronPort-SDR: e5PDvl26kLk85maj16Uz1egsPA5EMIrn5wj6JkUk196w8F0tKQ7GHWiDWtf0+Ox8i7Wuwq29YJ
 0a3Snq+9AdNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="352454753"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2020 12:36:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E32A376; Tue,  3 Nov 2020 22:36:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 1/7] resource: Simplify region_intersects() by reducing conditionals
Date:   Tue,  3 Nov 2020 22:36:49 +0200
Message-Id: <20201103203655.17701-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103203655.17701-1-andriy.shevchenko@linux.intel.com>
References: <20201103203655.17701-1-andriy.shevchenko@linux.intel.com>
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

