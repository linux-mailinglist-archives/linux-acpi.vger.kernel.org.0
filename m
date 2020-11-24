Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEA22C222E
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgKXJ4q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Nov 2020 04:56:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:2854 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731304AbgKXJ4p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Nov 2020 04:56:45 -0500
IronPort-SDR: 7Ct1CpyRo8q2Sk5vTMPeUl/ZzHBZs39miV+F6dfdGrhiU7crC6mvqd66vVPV56KW8OGJdi9wOb
 rg+dZ9vRYeFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233527608"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="233527608"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 01:56:43 -0800
IronPort-SDR: 5jd8yRAizv3BSsVWv7oyy6W6Jpg58Nv7gkOtYzcelj/HiH/RC+y3+AuVcVtzuzLqsXwHlgX5+o
 7qyyatCQkdOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="358764289"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Nov 2020 01:56:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A4FEFC; Tue, 24 Nov 2020 11:56:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of resource_intersection()
Date:   Tue, 24 Nov 2020 11:56:28 +0200
Message-Id: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have resource_intersection() helper, let's utilize it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Promised clean up for recently introduced helper.

This has dependency to the patches currently in linux-pm tree. Other than that
everything else is already in upstream. Hence, logically it's better to push
thru Rafael's tree than wait one more cycle.

 sound/soc/intel/catpt/core.h   | 11 -----------
 sound/soc/intel/catpt/loader.c |  2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/intel/catpt/core.h b/sound/soc/intel/catpt/core.h
index 0f53a0d43254..a64a0a77dcb7 100644
--- a/sound/soc/intel/catpt/core.h
+++ b/sound/soc/intel/catpt/core.h
@@ -22,17 +22,6 @@ void catpt_sram_free(struct resource *sram);
 struct resource *
 catpt_request_region(struct resource *root, resource_size_t size);
 
-static inline bool catpt_resource_overlapping(struct resource *r1,
-					      struct resource *r2,
-					      struct resource *ret)
-{
-	if (!resource_overlaps(r1, r2))
-		return false;
-	ret->start = max(r1->start, r2->start);
-	ret->end = min(r1->end, r2->end);
-	return true;
-}
-
 struct catpt_ipc_msg {
 	union {
 		u32 header;
diff --git a/sound/soc/intel/catpt/loader.c b/sound/soc/intel/catpt/loader.c
index 40c22e4bb263..ff7b8f0d34ac 100644
--- a/sound/soc/intel/catpt/loader.c
+++ b/sound/soc/intel/catpt/loader.c
@@ -267,7 +267,7 @@ static int catpt_restore_fwimage(struct catpt_dev *cdev,
 		r2.start = off;
 		r2.end = r2.start + info->size - 1;
 
-		if (!catpt_resource_overlapping(&r2, &r1, &common))
+		if (!resource_intersection(&r2, &r1, &common))
 			continue;
 		/* calculate start offset of common data area */
 		off = common.start - r1.start;
-- 
2.29.2

