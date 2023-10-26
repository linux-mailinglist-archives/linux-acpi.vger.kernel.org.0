Return-Path: <linux-acpi+bounces-1010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D357D80E2
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C661C20EAD
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D002D024
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbTQGQUz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458D27EED
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 08:33:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC55128;
	Thu, 26 Oct 2023 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698309233; x=1729845233;
  h=from:to:cc:subject:date:message-id;
  bh=8ikynLCsVFIJGquU/FrUnN4LC+5ZCI0bxGFqtHkRQ2Y=;
  b=QbTQGQUznNRp1vTBVjttVygMayiStSqWBuOvpYdXR+UH7y9moYZ9M+UG
   qiSTSx8hcwQD1ez6wHK0vyKgsZqBJgbVjLvShUhbIpALzZnWpZQcduGbS
   0qtNeLPcTqMO8oRHGO4XDn2eYWZb4LyiMl9kkUBqw4Jfg8RKSpeikRtJ8
   3X+i6YmiP16Xy+d+JofLP8L6eBzGUTXm+hwGX8GJNCn+jx8x8P0NUO1Jm
   d998CY4j93NpWfcbNcABCA+lZsVnLO9pF9/cELKlkCAHfElWk4j2X5qZD
   K0aY1eYOM9o2GEAByvxnPcO/m1vHU0AROkxyS24pbJDgHyGK1YdRZQOmY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9046786"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9046786"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 01:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090526373"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1090526373"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2023 01:33:50 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Date: Thu, 26 Oct 2023 14:03:35 +0530
Message-Id: <20231026083335.12551-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Now that we have a standard ACPI helper, we can use acpi_dev_uid_match()
for matching _UID as per the original logic before commit 2a036e489eb1
("ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()"),
instead of treating it as an integer.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes since v1:
- Update commit message

 drivers/acpi/acpi_lpss.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 875de44961bf..6aaa6b066510 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,10 +167,8 @@ static struct pwm_lookup byt_pwm_lookup[] = {
 
 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, "1"))
 		return;
 
 	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
@@ -218,10 +216,8 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, "1"))
 		return;
 
 	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));

base-commit: f9c7f9d537da013471e5c7913a33b6489bdeb3cf
-- 
2.17.1


