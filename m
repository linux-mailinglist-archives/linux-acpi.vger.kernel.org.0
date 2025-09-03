Return-Path: <linux-acpi+bounces-16315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08BB420D9
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 15:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522E81BC0F5A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794D301026;
	Wed,  3 Sep 2025 13:18:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09072E8B8A;
	Wed,  3 Sep 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905495; cv=none; b=WFEbm37pllJIIz/su1MIKffV7JhSRgNMf//Evhc+mvyvFy+6YDoFVRzpy2X9wNACvuvWf8bVmA/TyzXmLSuHLW0SQuA87NyWSUOAQJTHbUqSyJHRQckcHBEk+OKqG3TvnYFv4tH49hCDojls6fq4Dc878T/pMj1cQJgwCZ7T6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905495; c=relaxed/simple;
	bh=MaEpS/kQ0iq8I+mSuZFPEXaBH8HV11drax5+pE3OzRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMuNjBa8DjXSg2L0e1lRxi4XWJU43pSd12+6xPR1k9RULYALghZ3iXCinLD33R9YCsLPbyQYmCiB0fUscP73eXFrpezwDze8B3fcZhu2fX3yJJ4k/Ri448UV2kh2RJiQ+fXZJ66zkSWvz4dHPBNYq61tXEUwUAwadXMiw71Qjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6b6c578888c811f0b29709d653e92f7d-20250903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cc21363a-8291-4a3e-bd39-a186506d2f70,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:63c205d422a11131bd200bea55a50c60,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6b6c578888c811f0b29709d653e92f7d-20250903
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 487574624; Wed, 03 Sep 2025 21:18:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1A8C2E008FA2;
	Wed,  3 Sep 2025 21:18:02 +0800 (CST)
X-ns-mid: postfix-68B84009-9033994
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 57859E008FA4;
	Wed,  3 Sep 2025 21:17:58 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
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
Subject: [PATCH v4 02/10] ACPI: processor: thermal: Use scope-based cleanup helper
Date: Wed,  3 Sep 2025 21:17:25 +0800
Message-Id: <20250903131733.57637-3-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
References: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
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
---
 drivers/acpi/processor_thermal.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_th=
ermal.c
index 1219adb11ab9..5043f17d27b7 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -62,19 +62,14 @@ static int phys_package_first_cpu(int cpu)
 	return 0;
 }
=20
-static int cpu_has_cpufreq(unsigned int cpu)
+static bool cpu_has_cpufreq(unsigned int cpu)
 {
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq_cp=
u_get(cpu);
=20
 	if (!acpi_processor_cpufreq_init)
 		return 0;
=20
-	policy =3D cpufreq_cpu_get(cpu);
-	if (policy) {
-		cpufreq_cpu_put(policy);
-		return 1;
-	}
-	return 0;
+	return !!policy;
 }
=20
 static int cpufreq_get_max_state(unsigned int cpu)
@@ -93,9 +88,23 @@ static int cpufreq_get_cur_state(unsigned int cpu)
 	return reduction_step(cpu);
 }
=20
+static long long cpufreq_get_max_freq(unsigned int cpu)
+{
+	long long max_freq;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
+		cpufreq_cpu_get(cpu);
+
+	if (!policy)
+		return -EINVAL;
+
+	max_freq =3D (policy->cpuinfo.max_freq *
+		(100 - reduction_step(cpu) * cpufreq_thermal_reduction_pctg)) / 100;
+
+	return max_freq;
+}
+
 static int cpufreq_set_cur_state(unsigned int cpu, int state)
 {
-	struct cpufreq_policy *policy;
 	struct acpi_processor *pr;
 	unsigned long max_freq;
 	int i, ret;
@@ -120,14 +129,10 @@ static int cpufreq_set_cur_state(unsigned int cpu, =
int state)
 		if (unlikely(!freq_qos_request_active(&pr->thermal_req)))
 			continue;
=20
-		policy =3D cpufreq_cpu_get(i);
-		if (!policy)
-			return -EINVAL;
-
-		max_freq =3D (policy->cpuinfo.max_freq *
-			    (100 - reduction_step(i) * cpufreq_thermal_reduction_pctg)) / 100=
;
+		max_freq =3D cpufreq_get_max_freq(cpu);
=20
-		cpufreq_cpu_put(policy);
+		if (max_freq =3D=3D -EINVAL)
+			return -EINVAL;
=20
 		ret =3D freq_qos_update_request(&pr->thermal_req, max_freq);
 		if (ret < 0) {
--=20
2.25.1


