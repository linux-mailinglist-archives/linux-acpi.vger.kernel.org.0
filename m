Return-Path: <linux-acpi+bounces-16407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A82B458BD
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 15:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CFD3B3452
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC334F46F;
	Fri,  5 Sep 2025 13:24:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA482EDD76;
	Fri,  5 Sep 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078681; cv=none; b=lZKT0dVYPyDEucIaIc6pcM5uOUcRa1FvSDSDpswtbalH7JWX7oVT+xxTJY5O3BehZobpd+Ds/0pe/ubagjIbkwN0GWHTvuRkVx9a2O/0qeH7iXOR+I0XYcnRxalOkhgQvu2sJlLb15lYFTZE0AbXj89EhRT43EVrBR6wKdtl3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078681; c=relaxed/simple;
	bh=S4Ko70ZJJHD/wWUnApfc4oXk2ctDto//kNXhxHN/5HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzW+d1jtHp/hGMrO5AVytyPlqc79aruK7VOXBpXKMFSnJH3IEtxqDouo/srxUdc0fOdy09j1eXFlhbdi39fJAfdsJpHikv+6PgFNXQXb/vuJUz7146WYMNaqemM4fc1u0vRikE+lJDnl58o6+LaDZDCPDkRxNDnHFiaj7Ab84bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a92db2a88a5b11f0b29709d653e92f7d-20250905
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:db943cde-bbe0-429d-b0bf-a43728169e5f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:daa3cd9fa204e6c6d28bd15663a324ed,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a92db2a88a5b11f0b29709d653e92f7d-20250905
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1872443980; Fri, 05 Sep 2025 21:24:33 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0113AE008FA3;
	Fri,  5 Sep 2025 21:24:33 +0800 (CST)
X-ns-mid: postfix-68BAE490-8197312
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1F7DBE008FA4;
	Fri,  5 Sep 2025 21:24:29 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>
Cc: Ben Horgan <ben.horgan@arm.com>,
	zhenglifeng <zhenglifeng1@huawei.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Beata Michalska <beata.michalska@arm.com>,
	Fabio Estevam <festevam@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v5 1/6] arm64: topology: Use scope-based cleanup helper
Date: Fri,  5 Sep 2025 21:24:08 +0800
Message-Id: <20250905132413.1376220-2-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250905132413.1376220-1-zhangzihuan@kylinos.cn>
References: <20250905132413.1376220-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
annotation for policy references. This reduces the risk of reference
counting mistakes and aligns the code with the latest kernel style.

No functional change intended.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 arch/arm64/kernel/topology.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5d07ee85bdae..07e2f5b5ade0 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -307,30 +307,27 @@ int arch_freq_get_on_cpu(int cpu)
 		 */
 		if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
 		    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_E=
XP_MS))) {
-			struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
+			struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
+				cpufreq_cpu_get(info->opp_cpu);
 			int ref_cpu;
=20
 			if (!policy)
 				return -EINVAL;
=20
 			if (!cpumask_intersects(policy->related_cpus,
-						housekeeping_cpumask(HK_TYPE_TICK))) {
-				cpufreq_cpu_put(policy);
+						housekeeping_cpumask(HK_TYPE_TICK)))
 				return -EOPNOTSUPP;
-			}
=20
 			for_each_cpu_wrap(ref_cpu, policy->cpus, cpu + 1) {
 				if (ref_cpu =3D=3D start_cpu) {
 					/* Prevent verifying same CPU twice */
 					ref_cpu =3D nr_cpu_ids;
-					break;
+					return -EAGAIN;
 				}
 				if (!idle_cpu(ref_cpu))
 					break;
 			}
=20
-			cpufreq_cpu_put(policy);
-
 			if (ref_cpu >=3D nr_cpu_ids)
 				/* No alternative to pull info from */
 				return -EAGAIN;
--=20
2.25.1


