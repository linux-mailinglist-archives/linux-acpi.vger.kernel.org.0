Return-Path: <linux-acpi+bounces-326-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9597B552B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 97A87281761
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF141A5BF
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F8171AA;
	Mon,  2 Oct 2023 13:32:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367B91;
	Mon,  2 Oct 2023 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696253550; x=1727789550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDAqfAvJkp0xhbjXWLoPesIG5pkXB+BnJ5EhDi7GpC0=;
  b=D3/3IJgKV6Xb9p62TCYIQoq/m/4N2FS94/KuTkm2VDhN6S7wlu7tFBxk
   nVAnAqZpWM/bTMU+ADlgyBELw2esObPDDl1GnuwdodZemfIciGsLp2rsx
   Dwrw952k/iDApSLvKgrPdgEbmnfl43rKfUklUrNJObAfix9vp/hhdJmyv
   ekK+NAMtnT0sp2FgiVajAcd8bQfEVQCpXW5ZSVQF5C4dqkcDMyjWAm0Ws
   tN2+GbfwGmjlgre3Ci/s6RygUlt2vD+I+1s+D4gwQEiqv5FRiCKxeMAVJ
   Cq/5Qg+ryh+d9Ux6jOvSHQBfA3wkmBB35vaDVgJtKU/Z6I0nPCfBmzYAC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="379923408"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379923408"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754048986"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754048986"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2023 06:26:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2F42B1A7; Mon,  2 Oct 2023 16:26:41 +0300 (EEST)
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
Subject: [PATCH v2 2/2] amba: bus: Enable compile testing
Date: Mon,  2 Oct 2023 16:26:35 +0300
Message-Id: <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002132635.2595382-1-andriy.shevchenko@linux.intel.com>
References: <20231002132635.2595382-1-andriy.shevchenko@linux.intel.com>
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

v2: new patch to make it easier to compile test on non-ARM

 drivers/amba/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
index fb6c7e0b4cce..9ff4638550c8 100644
--- a/drivers/amba/Kconfig
+++ b/drivers/amba/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARM_AMBA
-	bool
+	bool "AMBA bus support" || if COMPILE_TEST
 
 if ARM_AMBA
 
-- 
2.40.0.1.gaa8946217a0b


