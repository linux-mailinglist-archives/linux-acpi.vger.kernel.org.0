Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2C3D2CF1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jul 2021 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGVTJa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jul 2021 15:09:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:6320 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhGVTJa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jul 2021 15:09:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="192001291"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="192001291"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 12:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="433256852"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2021 12:49:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 040CC12B; Thu, 22 Jul 2021 22:50:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 2/4] clk: fractional-divider: Hide clk_fractional_divider_ops from wide audience
Date:   Thu, 22 Jul 2021 22:50:08 +0300
Message-Id: <20210722195010.45940-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722195010.45940-1-andriy.shevchenko@linux.intel.com>
References: <20210722195010.45940-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The providers are all located in drivers/clk/ and hence no need
to export the clock operations to wider audience. Hide them by
moving to drivers/clk/clk-fractional-divider.h.

While at it, unexport since no module uses it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
 drivers/clk/clk-fractional-divider.c | 1 -
 drivers/clk/clk-fractional-divider.h | 2 ++
 drivers/clk/imx/clk-composite-7ulp.c | 1 +
 include/linux/clk-provider.h         | 1 -
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 535d299af646..53943f45b1ca 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -153,7 +153,6 @@ const struct clk_ops clk_fractional_divider_ops = {
 	.round_rate = clk_fd_round_rate,
 	.set_rate = clk_fd_set_rate,
 };
-EXPORT_SYMBOL_GPL(clk_fractional_divider_ops);
 
 struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
diff --git a/drivers/clk/clk-fractional-divider.h b/drivers/clk/clk-fractional-divider.h
index 4fa359a12ef4..aaaef90b2777 100644
--- a/drivers/clk/clk-fractional-divider.h
+++ b/drivers/clk/clk-fractional-divider.h
@@ -2,6 +2,8 @@
 
 struct clk_hw;
 
+extern const struct clk_ops clk_fractional_divider_ops;
+
 void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 						  unsigned long rate,
 						  unsigned long *parent_rate,
diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index 7c4f31b31eb0..d85ba78abbb1 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include "../clk-fractional-divider.h"
 #include "clk.h"
 
 #define PCG_PCS_SHIFT	24
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d83b829305c0..acb8e10d2898 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1023,7 +1023,6 @@ struct clk_fractional_divider {
 #define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
 #define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
 
-extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
-- 
2.30.2

