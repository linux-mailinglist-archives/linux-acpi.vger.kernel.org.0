Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A22A0C5B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3R0H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:26:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:57807 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgJ3R0G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 13:26:06 -0400
IronPort-SDR: Ruvi4JrFEU/U9prgAZopmQ9YR12SO7alOgoXdbMQMeb88OQX/RwoPm+cj8xyy0VCQwjBwjFM5R
 bGBZIPvjM+rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230276202"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="230276202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:26:05 -0700
IronPort-SDR: KV0PcvUkEhofrq/UJzqL/EPvLT5tog6OTME0fzQNN09VTwy9GjS6UDFU1ptNJTn3J2J6u1LAWI
 2qA9JxZtIuyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="395541897"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Oct 2020 10:26:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DD975B; Fri, 30 Oct 2020 19:26:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/6] resource: Simplify region_intersects() by reducing conditionals
Date:   Fri, 30 Oct 2020 19:25:51 +0200
Message-Id: <20201030172556.21686-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
References: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
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

