Return-Path: <linux-acpi+bounces-16241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1509B3DD6E
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625F4441864
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7C30506C;
	Mon,  1 Sep 2025 08:59:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00592FFDF1;
	Mon,  1 Sep 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717140; cv=none; b=rhYCKa8b+MI3K2/ruwEy16HmFGQIqeIpWwROUaQ4BwrZJrWtnlV9YWggu0QTeV606FyPhrpdy0EBCnWBvO3CRp/UdXvJL7+qvy/sX6x67DSkEjjPFLcTYBWqsQWXYTHlbuF99aJhmvbUfPEeShws23GAS2yNm38pC8yoYiqlFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717140; c=relaxed/simple;
	bh=v743MoZEKCT/HOysrU4k4DYsQROpAeffJY8mUvn7Yd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOiEqnaLRtHOAGLhw6Yx53/CCKAsBzz5YP6GvLXwbnVuvNfKRuNvAd52TwZh1Pb9fSrOx4NBZSvjuOWJwtZkdKeGjIXAfGu92D6s11h2ZMdy3e8GNzEI3wXmixG1gpEil2KT58GmZgGNTq8054/VE86HO0ob+OGrdp41CtGGgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e2624004871111f0b29709d653e92f7d-20250901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:084774f6-4f27-4563-9c15-27e02553a790,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:bf6960de0fea4d96f52c7ed05c9793fa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e2624004871111f0b29709d653e92f7d-20250901
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1064011897; Mon, 01 Sep 2025 16:58:53 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B014EE008FA5;
	Mon,  1 Sep 2025 16:58:52 +0800 (CST)
X-ns-mid: postfix-68B5604C-514101748
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 93864E008FA7;
	Mon,  1 Sep 2025 16:58:43 +0800 (CST)
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
Subject: [PATCH v3 11/12] thermal/drivers/ti-soc-thermal: Use scope-based cleanup helper
Date: Mon,  1 Sep 2025 16:57:47 +0800
Message-Id: <20250901085748.36795-12-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250901085748.36795-1-zhangzihuan@kylinos.cn>
References: <20250901085748.36795-1-zhangzihuan@kylinos.cn>
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
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers=
/thermal/ti-soc-thermal/ti-thermal-common.c
index 0cf0826b805a..daea718291a6 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -27,7 +27,6 @@
=20
 /* common data structures */
 struct ti_thermal_data {
-	struct cpufreq_policy *policy;
 	struct thermal_zone_device *ti_thermal;
 	struct thermal_zone_device *pcb_tz;
 	struct thermal_cooling_device *cool_dev;
@@ -218,6 +217,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap=
 *bgp, int id)
 {
 	struct ti_thermal_data *data;
 	struct device_node *np =3D bgp->dev->of_node;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq_cp=
u_get(0);
=20
 	/*
 	 * We are assuming here that if one deploys the zone
@@ -234,8 +234,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap=
 *bgp, int id)
 	if (!data)
 		return -EINVAL;
=20
-	data->policy =3D cpufreq_cpu_get(0);
-	if (!data->policy) {
+	if (!policy) {
 		pr_debug("%s: CPUFreq policy not found\n", __func__);
 		return -EPROBE_DEFER;
 	}
@@ -246,7 +245,6 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap=
 *bgp, int id)
 		int ret =3D PTR_ERR(data->cool_dev);
 		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
 			ret);
-		cpufreq_cpu_put(data->policy);
=20
 		return ret;
 	}
@@ -261,11 +259,8 @@ int ti_thermal_unregister_cpu_cooling(struct ti_band=
gap *bgp, int id)
=20
 	data =3D ti_bandgap_get_sensor_data(bgp, id);
=20
-	if (!IS_ERR_OR_NULL(data)) {
+	if (!IS_ERR_OR_NULL(data))
 		cpufreq_cooling_unregister(data->cool_dev);
-		if (data->policy)
-			cpufreq_cpu_put(data->policy);
-	}
=20
 	return 0;
 }
--=20
2.25.1


