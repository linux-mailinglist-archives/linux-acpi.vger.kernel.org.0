Return-Path: <linux-acpi+bounces-6966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A39379A7
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jul 2024 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BC11F2306F
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jul 2024 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195C145356;
	Fri, 19 Jul 2024 15:11:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx314.baidu.com [180.101.52.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC45664;
	Fri, 19 Jul 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401862; cv=none; b=W93vrIEae74ADiSe/JcdIsf8c/u+ruyHJ9VPCkOjWoNJzlQlb3q8AcqKvnWrh+EP+t33C8YgW04gOdj7QQixJOi/q4IsAwnV0+StdhBIMnDv5kbxGaAPWtPgEc82QlAxqIOGAZg2tu24O6g1hJo+r26RYTwLvtLSb4bWLN47uRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401862; c=relaxed/simple;
	bh=M5qWc8l72GsEm76r/wwK7UepiVpanZirGlRECIqDLMQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rE8jgBzpCwty3dO2gQyNA8R0cskUnUzu2xhLmV/xo85ibbx4QeB7jWYIiMhRlFPdxcK0qgUTt8SSS2BKmii7XIJ4nARHNQ+b0SAShfQ9nGlGTf3n+CIWXD562v2YBuw+S5b0w69PfBnKpd8jXtbgNcWbq0D/tcnlHTLUIQKlSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 057007F0004B;
	Fri, 19 Jul 2024 22:53:32 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] ACPI: processor: Silence per-cpu acpi_handle_info about idle states
Date: Fri, 19 Jul 2024 22:53:30 +0800
Message-Id: <20240719145330.9430-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

This made the CPU bootup faster, otherwise Linux spends lots
of time to printing nonsense information for each CPU when
there are lots of CPUs

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/acpi/acpi_processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 9916cc7..a19ace9 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -985,7 +985,7 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 		memcpy(&info->states[++last_index], &cx, sizeof(cx));
 	}
 
-	acpi_handle_info(handle, "Found %d idle states\n", last_index);
+	acpi_handle_debug(handle, "Found %d idle states\n", last_index);
 
 	info->count = last_index;
 
-- 
2.9.4


