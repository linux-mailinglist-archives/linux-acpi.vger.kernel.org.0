Return-Path: <linux-acpi+bounces-952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20167D6BE0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B488281A9F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C1127EE2
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVnH2i6y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE626E19
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:18:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF50137;
	Wed, 25 Oct 2023 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232716; x=1729768716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GGWBLv1O7SHoGXNqpswjaidLqIzwApROs0cSW0Fp2r8=;
  b=XVnH2i6yhtAz/hY4hA0WS3OjmJbRC8Vi1L0e9WESRTIgx0xzGyvQdSdh
   ICZoR7QVgZJ6oduA7tWm0bpO4sTbbpAfBMgkSam53mK0peLfQIWRQGoLs
   iO/p6RBo/+BcI3Mi0NcR460Rm90FzkfA5vROZNb2Y3lUwFRBAt7O7JxGH
   udpKh6LqZS/++FPM9jZ8kpueie9omX0N52aLVeUeFTYWsSkBWdByDq+Hz
   QKsxaG+A604I67LIaXT918sT78A5daxmWE5GrIuH/26N5A9wV1JLFx+XD
   SlHwU92WkvO9x0PBbqlZMe8Hx8lsU+vC0jkY0RHBi19pa5FPc0UJqRroO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154628"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154628"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425103"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425103"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:22 -0700
From: Michal Wilczynski <michal.wilczynski@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 3/6] ACPI: acpi_video: Remove unnecessary driver_data clear
Date: Wed, 25 Oct 2023 14:18:03 +0300
Message-ID: <20231025111806.2416524-4-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit
0d16710146a1 ("ACPI: bus: Set driver_data to NULL every time .add() fails")
introduced clearing driver_data every time probe fails, so it's not
necessary to clear it in the probe() callback.

Remove NULL assignment to driver_data in error path in
acpi_video_bus_add().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index e17474949bbb..0c93b0ef0feb 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2077,7 +2077,6 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	kfree(video->attached_array);
 err_free_video:
 	kfree(video);
-	device->driver_data = NULL;
 
 	return error;
 }
-- 
2.41.0


