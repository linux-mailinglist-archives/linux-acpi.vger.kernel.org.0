Return-Path: <linux-acpi+bounces-332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E47B5533
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C95C5283181
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B193C1A704
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 14:32:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8F199DA
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 13:55:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BADC;
	Mon,  2 Oct 2023 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254904; x=1727790904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7CvkNllIdMRaFkXGmuu4g9r5sHV6wrnsOajfayAqkbY=;
  b=dgpMPu3MAP3uQgS683ZLarOg4ngCglE+pUg1e6JHNk6AHywKYOFnEcbc
   bx9wkSMxzkDDG1PhfVkoyhcYEQySScyxcQde524W2pV0HKVIDGfu06Sw/
   KI3OFx4nyQQdgKdVtjjU+9rhsRhbVm/Y4MYSdNuJ5dxYUwTOoVuugwdGN
   aWQSyAZIlLcT/gbrlj36XaWNZ0KDHTzHkg3dLcSNyglhNy98E7HcG9hZa
   ZRK+bm1wJIOOL46Ca79MMHp0NTj061YWEM64GPSbDtvfNOrZeylqdCxfc
   3hn8sd/gG/etl+/P8zv5siY8uf2cwTdEI7O1v/t54N3VZ1iqwVLfwlr4w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362911942"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362911942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="785782513"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="785782513"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Oct 2023 06:55:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9CE6A14AF; Mon,  2 Oct 2023 16:54:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>,
	nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: NFIT: Switch to use acpi_evaluate_dsm_typed()
Date: Mon,  2 Oct 2023 16:54:58 +0300
Message-Id: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/nfit/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f96bf32cd368..280da408c02c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1737,9 +1737,8 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 	if ((nfit_mem->dsm_mask & (1 << func)) == 0)
 		return;
 
-	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
-	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
-			|| out_obj->buffer.length < sizeof(smart)) {
+	out_obj = acpi_evaluate_dsm_typed(handle, guid, revid, func, &in_obj, ACPI_TYPE_BUFFER);
+	if (!out_obj || out_obj->buffer.length < sizeof(smart)) {
 		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
 				dev_name(dev));
 		ACPI_FREE(out_obj);
-- 
2.40.0.1.gaa8946217a0b


