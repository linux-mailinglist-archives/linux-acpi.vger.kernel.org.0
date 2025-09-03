Return-Path: <linux-acpi+bounces-16318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64AB4211D
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16965819EC
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED03043C8;
	Wed,  3 Sep 2025 13:18:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D434303C87;
	Wed,  3 Sep 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905503; cv=none; b=H+kMNeg/VwLSf5+7pAlDxeGdKXFnqtqOiyBRlWhUdiq2SUs102UT/Bbj6cCjJeAwauHcOyfKKwqnYhI8ejBC5nFUnfFg8uWLzTN5plmbu7Bw4r9bi/Znu9fX/0N/YUYAgkZBIYkOcsbW6tt81YDAAxhuaWJOtpvnPOP0de4uHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905503; c=relaxed/simple;
	bh=6PsNSJA12rQtQ1XvZDJQx6WZz6bBmX6iNEjUN6S7Ojw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfxeKixD2oy1X9frdjijw1budDaK6pwgRhGjONnO2wlVnUtwO7l8gEOCRJf24aCFPaKlTaKoWvSg4B0PCK8UvZvjAQE13H8BqOVHu7yqHmpL9srJ7Jyfb4zKB/glMcYr91pe3m91RPVzh9NNu+fmYhA2nH6WQMb8S4NuQQdKZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7225f52a88c811f0b29709d653e92f7d-20250903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:03d6cce6-2064-47c3-bebb-0dae30991a82,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ff7be0c6729f0e3faf64acb4b4023c94,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7225f52a88c811f0b29709d653e92f7d-20250903
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1862006784; Wed, 03 Sep 2025 21:18:13 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 791F1E008FA2;
	Wed,  3 Sep 2025 21:18:13 +0800 (CST)
X-ns-mid: postfix-68B84015-3074077
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id AF321E008FA3;
	Wed,  3 Sep 2025 21:18:09 +0800 (CST)
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
Subject: [PATCH v4 05/10] PM / devfreq: Use scope-based cleanup helper
Date: Wed,  3 Sep 2025 21:17:28 +0800
Message-Id: <20250903131733.57637-6-zhangzihuan@kylinos.cn>
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
 drivers/devfreq/governor_passive.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governo=
r_passive.c
index 953cf9a1e9f7..a035cf44bdb8 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -80,24 +80,23 @@ static int get_target_freq_with_cpufreq(struct devfre=
q *devfreq,
 	struct devfreq_passive_data *p_data =3D
 				(struct devfreq_passive_data *)devfreq->data;
 	struct devfreq_cpu_data *parent_cpu_data;
-	struct cpufreq_policy *policy;
 	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
 	unsigned long dev_min, dev_max;
 	unsigned long freq =3D 0;
 	int ret =3D 0;
=20
 	for_each_online_cpu(cpu) {
-		policy =3D cpufreq_cpu_get(cpu);
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
+			cpufreq_cpu_get(cpu);
+
 		if (!policy) {
 			ret =3D -EINVAL;
 			continue;
 		}
=20
 		parent_cpu_data =3D get_parent_cpu_data(p_data, policy);
-		if (!parent_cpu_data) {
-			cpufreq_cpu_put(policy);
+		if (!parent_cpu_data)
 			continue;
-		}
=20
 		/* Get target freq via required opps */
 		cpu_cur =3D parent_cpu_data->cur_freq * HZ_PER_KHZ;
@@ -106,7 +105,6 @@ static int get_target_freq_with_cpufreq(struct devfre=
q *devfreq,
 					devfreq->opp_table, &cpu_cur);
 		if (freq) {
 			*target_freq =3D max(freq, *target_freq);
-			cpufreq_cpu_put(policy);
 			continue;
 		}
=20
@@ -121,7 +119,6 @@ static int get_target_freq_with_cpufreq(struct devfre=
q *devfreq,
 		freq =3D dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
=20
 		*target_freq =3D max(freq, *target_freq);
-		cpufreq_cpu_put(policy);
 	}
=20
 	return ret;
@@ -256,7 +253,6 @@ static int cpufreq_passive_register_notifier(struct d=
evfreq *devfreq)
 	struct device *dev =3D devfreq->dev.parent;
 	struct opp_table *opp_table =3D NULL;
 	struct devfreq_cpu_data *parent_cpu_data;
-	struct cpufreq_policy *policy;
 	struct device *cpu_dev;
 	unsigned int cpu;
 	int ret;
@@ -273,23 +269,23 @@ static int cpufreq_passive_register_notifier(struct=
 devfreq *devfreq)
 	}
=20
 	for_each_possible_cpu(cpu) {
-		policy =3D cpufreq_cpu_get(cpu);
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D
+			cpufreq_cpu_get(cpu);
+
 		if (!policy) {
 			ret =3D -EPROBE_DEFER;
 			goto err;
 		}
=20
 		parent_cpu_data =3D get_parent_cpu_data(p_data, policy);
-		if (parent_cpu_data) {
-			cpufreq_cpu_put(policy);
+		if (parent_cpu_data)
 			continue;
-		}
=20
 		parent_cpu_data =3D kzalloc(sizeof(*parent_cpu_data),
 						GFP_KERNEL);
 		if (!parent_cpu_data) {
 			ret =3D -ENOMEM;
-			goto err_put_policy;
+			goto err;
 		}
=20
 		cpu_dev =3D get_cpu_device(cpu);
@@ -314,7 +310,6 @@ static int cpufreq_passive_register_notifier(struct d=
evfreq *devfreq)
 		parent_cpu_data->max_freq =3D policy->cpuinfo.max_freq;
=20
 		list_add_tail(&parent_cpu_data->node, &p_data->cpu_data_list);
-		cpufreq_cpu_put(policy);
 	}
=20
 	mutex_lock(&devfreq->lock);
@@ -327,8 +322,6 @@ static int cpufreq_passive_register_notifier(struct d=
evfreq *devfreq)
=20
 err_free_cpu_data:
 	kfree(parent_cpu_data);
-err_put_policy:
-	cpufreq_cpu_put(policy);
 err:
=20
 	return ret;
--=20
2.25.1


