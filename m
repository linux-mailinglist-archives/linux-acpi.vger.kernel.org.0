Return-Path: <linux-acpi+bounces-866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A215C7D4785
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 08:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9561F225B3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6E12B78
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hurdb5l5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC401FB5
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 06:21:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100F110FE;
	Mon, 23 Oct 2023 23:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128458; x=1729664458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Fp+mcUvbUBGqwzFxRStIIQ/F0gyMOztw8zWtT91yBSs=;
  b=hurdb5l5qTkiEpBXwWbakMlPkEq0sD+F3JSNpq8lJWeqWOMpsc1fJVNN
   5dGADgUMFIDfQcTnDPypXelIpLJpBjeb3ojAcuoqdULZTEOA8wWU9twLe
   /QjjJE6V3wVssA9LWmJFmqpVrLe/iYDBUEwzRoaGHp6oZJLka5wH91aNs
   uaCE+1vihonBhpgTxUbNwnjxGWVFzlloGBu6FXLCWkWFnsXOqrfe1YKyp
   k/FJoTIsQTNAj5V2aEpG6UL5D1IYB8H7u84WMBiUQrZhyt/0SwV4RVQUY
   zpRFLXNrJJEG5t5NpfAdrulmWHb4+6vN/x3+2N7RzMePXBe9rGdftKrzB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806592"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806592"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751891416"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751891416"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2023 23:20:52 -0700
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
Subject: [PATCH v3 4/6] ACPI: x86: use acpi_dev_uid_match() for matching _UID
Date: Tue, 24 Oct 2023 11:50:16 +0530
Message-Id: <20231024062018.23839-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Convert manual _UID references to use the standard ACPI helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/x86/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 63d834dd3811..bc65ebfcdf76 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -184,8 +184,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 			if (acpi_match_device_ids(adev, override_status_ids[i].hid))
 				continue;
 
-			if (!adev->pnp.unique_id ||
-			    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
+			if (!acpi_dev_uid_match(adev, override_status_ids[i].uid))
 				continue;
 		}
 
-- 
2.17.1


