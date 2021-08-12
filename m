Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57C63EA8EA
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhHLRBC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 13:01:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:13232 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233728AbhHLRBB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 13:01:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="212287081"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="212287081"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 10:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="446614409"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2021 10:00:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2786B1E0; Thu, 12 Aug 2021 20:00:29 +0300 (EEST)
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
Subject: [PATCH v4 3/4] clk: fractional-divider: Introduce POWER_OF_TWO_PS flag
Date:   Thu, 12 Aug 2021 20:00:24 +0300
Message-Id: <20210812170025.67074-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
References: <20210812170025.67074-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The newly introduced POWER_OF_TWO_PS flag, when set, makes the flow
to skip the assumption that the caller will use an additional 2^scale
prescaler to get the desired clock rate.

Reported-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: rebased on top of latest CLK codebase

 drivers/acpi/acpi_lpss.c             |  4 ++--
 drivers/clk/clk-fractional-divider.c | 10 ++++++----
 drivers/mfd/intel-lpss.c             |  3 ++-
 include/linux/clk-provider.h         | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 7f163074e4e4..30b1f511c2af 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -436,8 +436,8 @@ static int register_device_clock(struct acpi_device *adev,
 		if (!clk_name)
 			return -ENOMEM;
 		clk = clk_register_fractional_divider(NULL, clk_name, parent,
-						      0, prv_base,
-						      1, 15, 16, 15, 0, NULL);
+						      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
+						      prv_base, 1, 15, 16, 15, 0, NULL);
 		parent = clk_name;
 
 		clk_name = kasprintf(GFP_KERNEL, "%s-update", devname);
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 535d299af646..6a3ed82fdae9 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -76,16 +76,18 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 						  unsigned long *m, unsigned long *n)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
-	unsigned long scale;
 
 	/*
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
 	 * for m and n. In the result it will be the nearest rate left shifted
 	 * by (scale - fd->nwidth) bits.
 	 */
-	scale = fls_long(*parent_rate / rate - 1);
-	if (scale > fd->nwidth)
-		rate <<= scale - fd->nwidth;
+	if (fd->flags & CLK_FRAC_DIVIDER_POWER_OF_TWO_PS) {
+		unsigned long scale = fls_long(*parent_rate / rate - 1);
+
+		if (scale > fd->nwidth)
+			rate <<= scale - fd->nwidth;
+	}
 
 	rational_best_approximation(rate, *parent_rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index a9bf10bee796..0e15afc39f54 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -301,7 +301,8 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 
 	snprintf(name, sizeof(name), "%s-div", devname);
 	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
-					      0, lpss->priv, 1, 15, 16, 15, 0,
+					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
+					      lpss->priv, 1, 15, 16, 15, 0,
 					      NULL);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d8609aef2394..f59c875271a0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1001,6 +1001,12 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
  * CLK_FRAC_DIVIDER_BIG_ENDIAN - By default little endian register accesses are
  *	used for the divider register.  Setting this flag makes the register
  *	accesses big endian.
+ * CLK_FRAC_DIVIDER_POWER_OF_TWO_PS - By default the resulting fraction might
+ *	be saturated and the caller will get quite far from the good enough
+ *	approximation. Instead the caller may require, by setting this flag,
+ *	to shift left by a few bits in case, when the asked one is quite small
+ *	to satisfy the desired range of denominator. It assumes that on the
+ *	caller's side the power-of-two capable prescaler exists.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -1020,8 +1026,9 @@ struct clk_fractional_divider {
 
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
-#define CLK_FRAC_DIVIDER_ZERO_BASED	BIT(0)
-#define CLK_FRAC_DIVIDER_BIG_ENDIAN	BIT(1)
+#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+#define CLK_FRAC_DIVIDER_BIG_ENDIAN		BIT(1)
+#define CLK_FRAC_DIVIDER_POWER_OF_TWO_PS	BIT(2)
 
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
-- 
2.30.2

