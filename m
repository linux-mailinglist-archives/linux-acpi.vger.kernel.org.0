Return-Path: <linux-acpi+bounces-7653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6AA9569F1
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4903A285C58
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 11:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D481684A7;
	Mon, 19 Aug 2024 11:53:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9311166F39;
	Mon, 19 Aug 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068418; cv=none; b=KIq6jFpC8wiw3vyOxt9KkI87ZDFighAJsMwp0xYNSR5QEp8QsDOEEJ3Tnu3NbaPYd41yiHw65YuyuQkeDVmfiYc7+RR5IbdsoPdGYz2LN9+lV++tXWi02el1oLF8niybYGxpA4mCt/xlO/9UWwBuGHZbG5JDE8PFTzM+ALpMdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068418; c=relaxed/simple;
	bh=sSQjIDBbInLeow6RI6kJVAsEyMy5VNe2nInpgrdhoDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I+B+n66tsRkhFQrYiS3+7xe29ELOcoYF6cR6oFwzZpqcJi+6MECkdU4xQIOgx2cSuYUSredTrHtW5nOD/i998jww9YbjclF3A59iKSkOhA6iFe3wyFk/X9lNmgr/QrvByZ7qDEU4PZbDlaabnuHGfSI52P12WHAJ8UOCgPte6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnWD63mCvzpTPc;
	Mon, 19 Aug 2024 19:52:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E50C318009B;
	Mon, 19 Aug 2024 19:53:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:53:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <ira.weiny@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <u.kleine-koenig@pengutronix.de>,
	<xueshuai@linux.alibaba.com>, <shiju.jose@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 7/8] acpi/ghes: Make cxl_cper_fifo and cxl_cper_work static
Date: Mon, 19 Aug 2024 20:00:55 +0800
Message-ID: <20240819120055.3884953-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/acpi/apei/ghes.c:681:1: warning:
	symbol 'cxl_cper_fifo' was not declared. Should it be static?

drivers/acpi/apei/ghes.c:685:20: warning:
	symbol 'cxl_cper_work' was not declared. Should it be static?

These symbols are not used outside ghes.c, so marks them static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/acpi/apei/ghes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..df31b3acaf0c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -678,11 +678,11 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
-DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
+static DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_work changes */
 static DEFINE_SPINLOCK(cxl_cper_work_lock);
-struct work_struct *cxl_cper_work;
+static struct work_struct *cxl_cper_work;
 
 static void cxl_cper_post_event(enum cxl_event_type event_type,
 				struct cxl_cper_event_rec *rec)
-- 
2.34.1


