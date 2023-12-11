Return-Path: <linux-acpi+bounces-2271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23D80C7BE
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 12:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA4FB20E36
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0460F347B6;
	Mon, 11 Dec 2023 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoGV9h0P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48784B0;
	Mon, 11 Dec 2023 03:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702293280; x=1733829280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OipROKW5VBxxm71BUaF5x+0BsRhlCsdbu7scxfSZVNo=;
  b=QoGV9h0PA0mtNDQBlR/+N1UoJfmuaWqhaH1vBUglW3lspQE5Mr7EuWig
   TUI30+QqvS1dGWjjq66i6ne6x+DCQ0qwOwP9WkrVkaGoJHCyhKXw0mOLD
   M9+G/sF/GUwqOTvQsI+vC3KJKC3tkRms62hzF0T2u/JHJry7YA0wk5p+r
   mGVM2AwBc9NWbXeF5cBxmevKd2+bGckJ5/3QnM+hSZnBXU/Tf5M4znrVP
   0bqLhZSxPibALHfwx1jaLTiHfFcq1IdVncmZiRbUjbYpuxy/vLyqnwMxz
   ZRZ48Ecr1FU5UDqrKlb8AMA7/Y+QvfAXQJWQQ5RmAAVmiRG4+Al4BeCSO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="16184459"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="16184459"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 03:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="863731599"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="863731599"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2023 03:14:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C518630D; Mon, 11 Dec 2023 13:14:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v1 1/1] ACPI: LPSS: Fix the fractional clock divider flags
Date: Mon, 11 Dec 2023 13:14:29 +0200
Message-ID: <20231211111430.3910049-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conversion to CLK_FRAC_DIVIDER_POWER_OF_TWO_PS uses wrong flags
in the parameters and hence miscalculates the values in the clock
divider. Fix this by applying the flag to the proper parameter.

Fixes: 82f53f9ee577 ("clk: fractional-divider: Introduce POWER_OF_TWO_PS flag")
Reported-by: Alex Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 79f4fc7d6871..6f454f61a432 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -453,8 +453,9 @@ static int register_device_clock(struct acpi_device *adev,
 		if (!clk_name)
 			return -ENOMEM;
 		clk = clk_register_fractional_divider(NULL, clk_name, parent,
+						      0, prv_base, 1, 15, 16, 15,
 						      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
-						      prv_base, 1, 15, 16, 15, 0, NULL);
+						      NULL);
 		parent = clk_name;
 
 		clk_name = kasprintf(GFP_KERNEL, "%s-update", devname);
-- 
2.43.0.rc1.1.gbec44491f096


