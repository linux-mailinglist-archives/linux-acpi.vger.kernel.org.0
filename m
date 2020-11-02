Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCC2A35AF
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 22:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKBVA2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 16:00:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:8786 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgKBVA2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 16:00:28 -0500
IronPort-SDR: 3YqqZpIZ+t3oFqhNumVxgUNXFJTjLpSUfIjwg9FW5uxwLlI2TKZfm3rE1CMHvCylk1xL/sqBDw
 4PP0mx19QDig==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="165447778"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="165447778"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 13:00:28 -0800
IronPort-SDR: RcVEQDFVYqiVW2wmOOWCKjoTqK9l7zYVahdkhu52+N937NDJ7h7PVt6OsDQy1O4ejkr9JB0U7/
 rhThQBwU0Ofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="528149403"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2020 13:00:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3F75B1; Mon,  2 Nov 2020 23:00:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 1/6] resource: Simplify region_intersects() by reducing conditionals
Date:   Mon,  2 Nov 2020 23:00:20 +0200
Message-Id: <20201102210025.53520-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
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

