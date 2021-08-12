Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E523EA8F5
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhHLRBQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 13:01:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:1108 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhHLRBQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 13:01:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="300986774"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="300986774"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 10:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="517527485"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2021 10:00:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30EA5238; Thu, 12 Aug 2021 20:00:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v4 4/4] clk: fractional-divider: Document the arithmetics used behind the code
Date:   Thu, 12 Aug 2021 20:00:25 +0300
Message-Id: <20210812170025.67074-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It appears that some code lines raise the question why they are needed
and how they are participated in the calculus of the resulting values.

Document this in a form of the top comment in the module file.

Reported-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: rebased on top of latest CLK codebase

 drivers/clk/clk-fractional-divider.c | 35 +++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 6a3ed82fdae9..b4f365d97bd0 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -3,8 +3,39 @@
  * Copyright (C) 2014 Intel Corporation
  *
  * Adjustable fractional divider clock implementation.
- * Output rate = (m / n) * parent_rate.
  * Uses rational best approximation algorithm.
+ *
+ * Output is calculated as
+ *
+ *	rate = (m / n) * parent_rate				(1)
+ *
+ * This is useful when on die we have a prescaler block which asks for
+ * m (numerator) and n (denominator) values to be provided to satisfy
+ * the (1) as much as possible.
+ *
+ * Since m and n have the limitation by a range, e.g.
+ *
+ *	n >= 1, n < N_width, where N_width = 2^nwidth		(2)
+ *
+ * for some cases the output may be saturated. Hence, from (1) and (2),
+ * assuming the worst case when m = 1, the inequality
+ *
+ *	floor(log2(parent_rate / rate)) <= nwidth		(3)
+ *
+ * may be derived. Thus, in cases when
+ *
+ *	(parent_rate / rate) >> N_width				(4)
+ *
+ * we might scale up the rate by 2^scale (see the description of
+ * CLK_FRAC_DIVIDER_POWER_OF_TWO_PS for additional information), where
+ *
+ *	scale = floor(log2(parent_rate / rate)) - nwidth	(5)
+ *
+ * and assume that the IP, that needs m and n, has also its own
+ * prescaler, which is capable to divide by 2^scale. In this way
+ * we get the denominator to satisfy the desired range (2) and
+ * at the same time much much better result of m and n than simple
+ * saturated values.
  */
 
 #include <linux/clk-provider.h>
@@ -81,6 +112,8 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
 	 * for m and n. In the result it will be the nearest rate left shifted
 	 * by (scale - fd->nwidth) bits.
+	 *
+	 * For the detailed explanation see the top comment in this file.
 	 */
 	if (fd->flags & CLK_FRAC_DIVIDER_POWER_OF_TWO_PS) {
 		unsigned long scale = fls_long(*parent_rate / rate - 1);
-- 
2.30.2

