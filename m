Return-Path: <linux-acpi+bounces-473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417AC7BBCD7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DD71C20966
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D034128E03
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTCz/cNV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754F1CA9A;
	Fri,  6 Oct 2023 14:57:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17266A6;
	Fri,  6 Oct 2023 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696604266; x=1728140266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pwbbbgcEIxTYBd2yOIqpmkQsPrsV9eQPsSf0L3T2NTk=;
  b=NTCz/cNVB31ceIYjJDZbdiayHxTba4rhA3Ai5BlWPLjtTLBV44Ob6Zid
   RW77iatlzfSWExIvJDYhpQfQF6FZmSjmNw4oRakTLgziJZO4Dj8sFzIgz
   5FilqeBM0wzTrRV+1bspSqryd5CFl8XCI5fGVRSHOZMWF0MBmMWUVgDz6
   Rz5pQPyELxBRuFxF0gXRpMkZnXPkUEAi88mV0WvWXO3CHBXl/ljNuW1dG
   yx7Zo3j+FKa6wwcu0oYHYLE5jcofiYepewXG7WprOINxTCowqDduWSunT
   OpaLQwHkvsIErCOaUjnYxjKMZd9wbhDUk93QAdNi5/iP8q5aiL48vEdhi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="368840637"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="368840637"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="755880712"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="755880712"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2023 07:57:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AB142430; Fri,  6 Oct 2023 17:57:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 2/2] amba: bus: Enable compile testing
Date: Fri,  6 Oct 2023 17:57:32 +0300
Message-Id: <20231006145732.3419115-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
References: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is no architecture specific code in the implementation of
AMBA bus, let's enable compile testing for it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: fixed compilation error (LKP, Rob), amended summary (Rob)
v2: new patch to make it easier to compile test on non-ARM

 drivers/amba/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
index fb6c7e0b4cce..21fa17697b48 100644
--- a/drivers/amba/Kconfig
+++ b/drivers/amba/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARM_AMBA
-	bool
+	bool "Arm (AMBA) Primecell Device bus" if COMPILE_TEST
 
 if ARM_AMBA
 
-- 
2.40.0.1.gaa8946217a0b


