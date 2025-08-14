Return-Path: <linux-acpi+bounces-15669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D84B25DAF
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 09:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A85B633E3
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89226A1D0;
	Thu, 14 Aug 2025 07:32:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF826AA88;
	Thu, 14 Aug 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156720; cv=none; b=juXMDO192KdJP6LSnOz5rgoov7yxga55eGZnLJXvgviYwr+DhmmJdQa4bVL2cl5o3Uq4rmpCDapFD8Rd1u3mmRQz7koyMoKVpAoQ6ezRm4edwdNHh/msQO7YOVmXMVGSmo64HHwQi2wYXVQNQzfH1kcP9yA5NUxzUXO0UpVcrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156720; c=relaxed/simple;
	bh=Ek71y/Vysl6TXj+/+lo0qw6uZeFpzglWXMM5szs8uNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLWaG5H5uMx6sf3F69YspNj0hcickZeYVZ4pLA4Y7goCNOGH5xN2fcKUtZLdok4qSSvZf2cgIeh0XQmPHUrbQzJbtJ1DxJPK5C2w9IsEJv3fCX7BhUKbF8bUgr5JYK22iGGSC3hI7mo03K3YamUweZ290mHvweEQ837VI3g43XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: be08fdf478e011f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a1cca3fd-f7f4-4ebc-a19b-8c0e60923681,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:a1cca3fd-f7f4-4ebc-a19b-8c0e60923681,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:bea4d67dd8856528292b6e946ba2286f,BulkI
	D:250814153152UFZ3QEB5,BulkQuantity:0,Recheck:0,SF:17|19|23|38|43|66|74|78
	|81|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: be08fdf478e011f0b29709d653e92f7d-20250814
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.165.11)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1345372979; Thu, 14 Aug 2025 15:31:50 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lenb@kernel.org,
	robert.moore@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Shaobo Huang <huangshaobo2075@phytium.com.cn>,
	Yinfeng Wang <wangyinfeng@phytium.com.cn>,
	Xu Wang <wangxu@phytium.com.cn>
Subject: [PATCH v2 1/2] cpuidle: Add interface to get cpuidle_driver by CPU ID
Date: Thu, 14 Aug 2025 15:31:44 +0800
Message-Id: <20250814073144.1022355-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250814072934.1016694-1-tianyaxiong@kylinos.cn>
References: <20250814072934.1016694-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers need to obtain the cpuidle_driver via CPU ID before the
cpuidle_device is registered. Therefore, this interface is added.

Tested-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Signed-off-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
Signed-off-by: Yinfeng Wang <wangyinfeng@phytium.com.cn>
Signed-off-by: Xu Wang<wangxu@phytium.com.cn>
---
 drivers/cpuidle/driver.c | 16 ++++++++++++++++
 include/linux/cpuidle.h  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 9bbfa594c442..8647f8165863 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -353,6 +353,22 @@ struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
 }
 EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
 
+/**
+ * cpuidle_get_cpu_driver_by_cpu - return the driver registered for a CPU.
+ * @cpu_num: a valid cpu num
+ *
+ * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
+ * for the CPU associated with @cpu.
+ */
+struct cpuidle_driver *cpuidle_get_cpu_driver_by_cpu(int cpu_num)
+{
+	if (cpu_num < 0 || cpu_num >= nr_cpu_ids)
+		return NULL;
+
+	return __cpuidle_get_cpu_driver(cpu_num);
+}
+EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver_by_cpu);
+
 /**
  * cpuidle_driver_state_disabled - Disable or enable an idle state
  * @drv: cpuidle driver owning the state
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a9ee4fe55dcf..aebbaae6a501 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -200,6 +200,7 @@ extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
+extern struct cpuidle_driver *cpuidle_get_cpu_driver_by_cpu(int cpu_num);
 static inline struct cpuidle_device *cpuidle_get_device(void)
 {return __this_cpu_read(cpuidle_devices); }
 #else
@@ -240,6 +241,9 @@ static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
+
+static inline struct cpuidle_driver *cpuidle_get_cpu_driver_by_cpu(
+	int cpu_num) {return NULL; };
 static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 #endif
 
-- 
2.25.1


