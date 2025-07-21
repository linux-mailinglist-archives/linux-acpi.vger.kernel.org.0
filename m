Return-Path: <linux-acpi+bounces-15249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB9B0BB60
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 05:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305D01897C4F
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 03:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09D1FBEBD;
	Mon, 21 Jul 2025 03:26:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA662B9A9;
	Mon, 21 Jul 2025 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068384; cv=none; b=VG+QzZqO274+lLpz+QowWZvEtYlRQyUZUXyWCBT2yNY+t1ZcgWo6Fz1fGNw25Oai00e+5VfQwyH0djzLl9OqyuNV0fPeBPgoDUsQzGSJ+2zfLAaeuqRq9NeNBz1rOq6gH4Zwq0zLSvOXLRu9PfL/stqJjDec/IEJuIYuKzmkeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068384; c=relaxed/simple;
	bh=W+YfrMOENzIpLr/Qkswe58O644OPQZbKS+3T3IF478k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtWG6wXjRZC7UMwH7CoU4iuFrcyF10gM6Uv9uzsV23M4YjQC6m2ph8QBSxtiq4oeoq4PXo+BFyGb3tV1xh4UBMSAEITvObdIOCDFn1X3pQWqvZxNfNwxNRdQDXPzhqwbEqNUdMx+E7kQa7wKq92MzqttV3rxR+S+9NjcOd9YZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 754b54d865e211f0b29709d653e92f7d-20250721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5e8adfa0-374c-4564-9d9a-4e43569f2290,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:13f64e50f4a71a7c6c8684f9ccdc46e2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 754b54d865e211f0b29709d653e92f7d-20250721
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1603985306; Mon, 21 Jul 2025 11:26:15 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 1956716004280;
	Mon, 21 Jul 2025 11:26:15 +0800 (CST)
X-ns-mid: postfix-687DB355-6808681889
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 3FA8516001A01;
	Mon, 21 Jul 2025 03:26:13 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: rafael@kernel.org
Cc: jiayi_dec@163.com,
	lenb@kernel.org,
	lijiayi@kylinos.cn,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: Fix initial QoS constraint application order in PPC initialization
Date: Mon, 21 Jul 2025 11:26:06 +0800
Message-ID: <20250721032606.3459369-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718020312.856168-1-lijiayi@kylinos.cn>
References: <20250718020312.856168-1-lijiayi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixes an issue where _PPC frequency limits set by the BIOS
failed to take effect due to incorrect call ordering. Previously,
freq_qos_update_request() was being called before freq_qos_add_request(),
causing the constraint updates to be ignored. With this fix, the frequenc=
y
limits are now properly enforced as intended.
The original initialization sequence was:

cpufreq_policy_online()
    acpi_cpufreq_cpu_init()
        acpi_processor_get_platform_limit()
            freq_qos_update_request(&perflib_req)
    blocking_notifier_call_chain(...)
        acpi_processor_ppc_init()
            freq_qos_add_request(&perflib_req)

The new sequence explicitly ensures:

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
v1 -> v2:
- Modify the commit.
- Add pr->performance check in acpi_processor_ppc_init loop.
---
---
 drivers/acpi/processor_perflib.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_pe=
rflib.c
index 64b8d1e19594..56f2b8354d62 100644
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
@@ -180,6 +183,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy *p=
olicy)
 		if (!pr)
 			continue;
=20
+		if (!pr->performance)
+			continue;
+
 		/*
 		 * Reset performance_platform_limit in case there is a stale
 		 * value in it, so as to make it match the "no limit" QoS value
@@ -193,6 +199,11 @@ void acpi_processor_ppc_init(struct cpufreq_policy *=
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


