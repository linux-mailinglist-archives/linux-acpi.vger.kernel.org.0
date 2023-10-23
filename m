Return-Path: <linux-acpi+bounces-835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E17D2A73
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 08:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F42280C81
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56366FA7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXpVVhVn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC8566E
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 05:36:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A36D66;
	Sun, 22 Oct 2023 22:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698039387; x=1729575387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4ahXNqa6c7vy2x9ujTqdFUKWTVtZ7enEGrd79rmm95E=;
  b=JXpVVhVn+sefPxYFftPtNWPtpCaeJrBxGwwdmXdS0vAwaG0KYxxcQiNs
   J3Vzg9k9QxnEL4KbnANhiiRwiS5XMoB8eFLUPWCszWlFua3IVBM672i+N
   u0tV58lwTgeF+u/5p7251+ZnisYi11w98es8IJ5ASWtNY17sEN8enAsmm
   PpkXKoIc9UKdfYhp0gox0XBncoA6ll7p+pxlPVeuCJcvzpLvstTk8Hhfj
   V6Fu+RJrnuy9yz/VnyCoBOjVdkuVqTJM/qGAwzTgaVhC65/p+w861DNhl
   OsESbfKVK+gprlnY52Xdn3y/LrqNlAOMzqp/AOGy4i2TAfwfCeJMUgDRX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417905428"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417905428"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 22:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734556690"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734556690"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2023 22:36:14 -0700
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
Subject: [PATCH v2 4/6] ACPI: x86: use acpi_dev_uid_match() for matching _UID
Date: Mon, 23 Oct 2023 11:05:28 +0530
Message-Id: <20231023053530.5525-5-raag.jadav@intel.com>
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


