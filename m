Return-Path: <linux-acpi+bounces-833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C77D2A71
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 08:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C4528132F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7992C6FA7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqfhDOae"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42155398
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 05:36:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62BFD60;
	Sun, 22 Oct 2023 22:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698039385; x=1729575385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kUk0ItiaVjzsfP94oC1IH39uZvUKoEr3WDbUZtzQLOo=;
  b=TqfhDOaeFBtb4wF2pLDQkFapff1OAkEtVjJNTsX3TfrbdnoFsYJYmAa8
   gqVe4RlsGh68HSlQCwoq6SFufOIJ9j/SJvhb31u5iFfYMTjx0IPIy2nDA
   gr9rYul8G/OqFfkPZd3Qv6nIYC6FVi0T/SSOhc3hGagkcps+fyLEGPgq0
   3IGJIKwASfWkV8aQg6XQYy9CS68i2DjW2XscN/U7sj+MhZzfMgULAFAyW
   B08qaIKc4fTwIZYv175M2xBWwqikDlLgpdIf9mj75N2y+lQXsfELYeMfu
   2GVNb2N85LhHAmd2Thr+885T0LU/t9PdGCNOmY5iwfr4B4Ie2dZPHPlA6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417905394"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417905394"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 22:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734556683"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734556683"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2023 22:36:04 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com,
	will@kernel.org,
	linux@roeck-us.net,
	Jonathan.Cameron@Huawei.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/6] pinctrl: intel: use acpi_dev_uid_match() for matching _UID
Date: Mon, 23 Oct 2023 11:05:26 +0530
Message-Id: <20231023053530.5525-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231023053530.5525-1-raag.jadav@intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Convert manual _UID references to use the standard ACPI helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3be04ab760d3..999f453344d2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1694,7 +1694,7 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 		unsigned int i;
 
 		for (i = 0; table[i]; i++) {
-			if (!strcmp(adev->pnp.unique_id, table[i]->uid)) {
+			if (acpi_dev_uid_match(adev, table[i]->uid)) {
 				data = table[i];
 				break;
 			}
-- 
2.17.1


