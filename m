Return-Path: <linux-acpi+bounces-16314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C8B420CD
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E143687559
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2F2FDC5F;
	Wed,  3 Sep 2025 13:18:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2715B0EC;
	Wed,  3 Sep 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905492; cv=none; b=N//YMjcRhN0KsDRZBzPCP2KdiZwl1hi8X1NG/jX7uJPtidpQq2skwfVUmVLHFkTKOxEjCsF71pqqlEtJ6kZOqN00vuBUo2eX3dEDcKejJI9nRUkR5j/xwgUn0yCFaPvlByXqFD34LbIonbssk57fJMWWK38JhZ6ELILeks+v+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905492; c=relaxed/simple;
	bh=aUpHyIkA6IRKScoX6aepW5QYg+CYo5eKLwuIId41vTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jY8O7yHzLvChAvPOcRzQXsA6LGPDyehzlzYhI2ajkMY212QNG/YIxFUnqpEqSLtM7j0xqKj77OW0X6dLTzhwJX+BsRtb4o8AVHjkB6gOH46pebqoqYOM4O0fXMVqGyEq+BuE3OL1i/FZ+qR2r3f0Yq/hyPDL2IyxFRTueTU/pSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6680d70888c811f0b29709d653e92f7d-20250903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d056df0d-9490-46b5-b02b-45f4d6409240,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b3d8cc48d38f17ba8c0258a26b8c30c8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6680d70888c811f0b29709d653e92f7d-20250903
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 431355095; Wed, 03 Sep 2025 21:17:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id DD192E008FA4;
	Wed,  3 Sep 2025 21:17:53 +0800 (CST)
X-ns-mid: postfix-68B84000-2111002
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 86984E008FA2;
	Wed,  3 Sep 2025 21:17:43 +0800 (CST)
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
Subject: [PATCH v4 00/10] cpufreq: use __free() for all cpufreq_cpu_get() references
Date: Wed,  3 Sep 2025 21:17:23 +0800
Message-Id: <20250903131733.57637-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset converts all remaining cpufreq users to rely on the
__free(put_cpufreq_policy) annotation for policy references, instead of
calling cpufreq_cpu_put() manually.

Motivation:
- Reduce the chance of reference counting mistakes
- Make the code more consistent with the latest kernel style
- behavior remains the same, but reference counting is now safer=20
  and easier to maintain.

The changes are split into 12 patches as they touch different subsystems
and are maintained by different people. There is no functional change.

V4:
 - Fix compile error in topology.c
 - drop 2 patches
 - Move code into a function in processor_thermal.c
 - Move code into a function in intel_pstate.c
 - Move policy declare in dtpm_cpu.c
 - Fix compile error in imx_thermal.c
 - Fix compile error in ti-thermal-common.c
 - Fix compile error in energy_model.c

V3:
 - drop patch 'KVM: x86: Use __free(put_cpufreq_policy) for policy refere=
nce'
 - removed 5 patches which has been applied
 - Consolidate CPUFreq policy assignments and allocations into one line,
   suggested by Ben Horgan
 - Change cpu_has_cpufreq() return type to bool, following Rafael's sugge=
stion
 - Change the title to 'Use scope-based cleanup helper'

V2:
 - Fix compile error in powernv-cpufreq.c
 - Split patch to separate logical changes

Zihuan Zhang (10):
  arm64: topology: Use scope-based cleanup helper
  ACPI: processor: thermal: Use scope-based cleanup helper
  cpufreq: intel_pstate: Use scope-based cleanup helper
  cpufreq: powernv: Use scope-based cleanup helper
  PM / devfreq: Use scope-based cleanup helper
  drm/i915: Use scope-based cleanup helper
  powercap: dtpm_cpu: Use scope-based cleanup helper
  thermal: imx: Use scope-based cleanup helper
  thermal/drivers/ti-soc-thermal: Use scope-based cleanup helper
  PM: EM: Use scope-based cleanup helper

 arch/arm64/kernel/topology.c                  |  9 ++---
 drivers/acpi/processor_thermal.c              | 37 +++++++++++--------
 drivers/cpufreq/intel_pstate.c                | 19 ++++++----
 drivers/cpufreq/powernv-cpufreq.c             | 11 +++---
 drivers/devfreq/governor_passive.c            | 25 +++++-------
 drivers/gpu/drm/i915/gt/intel_llc.c           |  4 +-
 drivers/powercap/dtpm_cpu.c                   | 30 ++++++---------
 drivers/thermal/imx_thermal.c                 | 14 +++----
 .../ti-soc-thermal/ti-thermal-common.c        | 13 ++-----
 kernel/power/energy_model.c                   |  7 +---
 10 files changed, 73 insertions(+), 96 deletions(-)

--=20
2.25.1


