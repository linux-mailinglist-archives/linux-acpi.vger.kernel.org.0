Return-Path: <linux-acpi+bounces-15229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68DB09993
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jul 2025 04:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252ED4A1D6C
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jul 2025 02:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E8282F1;
	Fri, 18 Jul 2025 02:03:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268DBA27;
	Fri, 18 Jul 2025 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804226; cv=none; b=AKuwkdHpC0jajBB/rD9I84OVx10Wk9rCToYVEGXT65N6XosbB7czFMQ6Ivu5o7YZiIJM2KJ4+p0XATMJ6JDnpnhzroekdoBRhpx9xlMS15x2UxzwKTKnt23tjXoGdU6Zy3ToyEQlOQ88sPFQGC0D1/s3oRXrR+mpfRNzIk+gRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804226; c=relaxed/simple;
	bh=BmKnnJRbIQkqJJ5Kx45jIKsoMmB6S9pt2bchQhRVHNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiLdqRHA125vbG9tVKRGS2LztX5dE9jAikOPfndxxl4zRpmT+XOz2XpROWQBY+QxmMRZ4G7DPMbplKyKZ4njLsAc1/Ftkc5vJZazW2Zd6cagdqGyBpFaZYXUChcNy62brChdNW5CJFwj4Z6Z7lK5nuTpFlnJBV+iVOGjpYW+fGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6907ed76637b11f0b29709d653e92f7d-20250718
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e5d48ba0-025e-4c6c-8c43-47f6c8fffe1f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:c9b547adcdada4cf4fc791b41f9c8bb1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6907ed76637b11f0b29709d653e92f7d-20250718
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 253580924; Fri, 18 Jul 2025 10:03:34 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 1441816004286;
	Fri, 18 Jul 2025 10:03:34 +0800 (CST)
X-ns-mid: postfix-6879AB75-915581443
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 7858416004283;
	Fri, 18 Jul 2025 02:03:33 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>
Subject: [PATCH] ACPI: Fix initial QoS constraint application order in PPC initialization
Date: Fri, 18 Jul 2025 10:03:12 +0800
Message-ID: <20250718020312.856168-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The original initialization sequence was:

cpufreq_policy_online()
    acpi_cpufreq_cpu_init()
        acpi_processor_get_platform_limit()
            freq_qos_update_request(&perflib_req)
    blocking_notifier_call_chain(...)
        acpi_processor_ppc_init()
            freq_qos_add_request(&perflib_req)

This caused a race condition where the QoS request was added after the
initial platform limit update. The new sequence explicitly ensures:

cpufreq_policy_online()
    acpi_cpufreq_cpu_init()
        acpi_processor_get_platform_limit()
            freq_qos_update_request(&perflib_req)
    blocking_notifier_call_chain(...)
        acpi_processor_ppc_init()
            freq_qos_add_request(&perflib_req)
+           acpi_processor_get_platform_limit()
+               freq_qos_update_request(&perflib_req)

The critical change adds an immediate platform limit update after the
QoS request is registered. This guarantees that the initial P-state
constraint is applied before any subsequent updates, resolving the window
where constraints could be applied out-of-order.

Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cp=
ufreq notifier")
Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
---
 drivers/acpi/processor_perflib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
index 64b8d1e19594..3e7fe95c21d1 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -173,6 +173,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy *p=
olicy)
 {
 	unsigned int cpu;
=20
+	if (ignore_ppc =3D=3D 1)
+		return;
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr =3D per_cpu(processors, cpu);
 		int ret;
@@ -193,6 +196,11 @@ void acpi_processor_ppc_init(struct cpufreq_policy *=
policy)
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
+
+		ret =3D acpi_processor_get_platform_limit(pr);
+		if (ret)
+			pr_err("Failed to update freq constraint for CPU%d (%d)\n",
+			       cpu, ret);
 	}
 }
=20
--=20
2.47.1


