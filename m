Return-Path: <linux-acpi+bounces-18960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24AC65680
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6D8D4F11E7
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18433A006;
	Mon, 17 Nov 2025 17:03:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C93093BF;
	Mon, 17 Nov 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398989; cv=none; b=oPG/FyJ3vKQyPe2LldHdUpP+pma4r8CmWOa1ppBi/JUgtWSJjMdWQ0sMw+2KF5+kMXkARtZ+bDTVUQ2RPyrUMETwTFEm8kO+wC+mg0kit89/NnElj00O3qNb77dp8x9FXzLzPyD/STYrp66MaTyreNQ1EN1h+N4BTaVFzZjlCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398989; c=relaxed/simple;
	bh=VcMk8L4hR4gwGrRved/fVkCXGXVH7xiCvPMB9zi/CL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub6SpzJUxRwbje+50jCC8FaaHuVCfkRvMHmU4QUVEtWl6w4fI9fvAaK1WWl9Eej/7cfJYjcQbxErY/26SKkGdBuPo4y6j6/NCqtQYNGBV9h7ZET1OIhnCQS+q01lWb15mHZzOxPjRGFh66GB4J98rrzF0hQx8LwITKT1/pd9Gwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39431007;
	Mon, 17 Nov 2025 09:02:59 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AF1B3F66E;
	Mon, 17 Nov 2025 09:03:02 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH v5 29/34] arm_mpam: Probe for long/lwd mbwu counters
Date: Mon, 17 Nov 2025 17:00:08 +0000
Message-ID: <20251117170014.4113754-30-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rohit Mathew <rohit.mathew@arm.com>

mpam v0.1 and versions above v1.0 support optional long counter for
memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register has fields
indicating support for long counters.

Probe these feature bits.

The mpam_feat_msmon_mbwu feature is used to indicate that bandwidth
monitors are supported, instead of muddling this with which size of
bandwidth monitors, add an explicit 31 bit counter feature.

Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
[ morse: Added 31bit counter feature to simplify later logic ]
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Only set the exact counter length that is supported
---
 drivers/resctrl/mpam_devices.c  | 35 ++++++++++++++++++++++-----------
 drivers/resctrl/mpam_internal.h |  3 +++
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 1adc55d258ab..c371a22147b7 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -783,25 +783,36 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 				dev_err_once(dev, "Counters are not usable because not-ready timeout was not provided by firmware.");
 		}
 		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
-			bool hw_managed;
+			bool has_long, hw_managed;
 			u32 mbwumon_idr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
 
 			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
-			if (props->num_mbwu_mon)
+			if (props->num_mbwu_mon) {
 				mpam_set_feature(mpam_feat_msmon_mbwu, props);
 
-			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
-				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
+				if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
+					mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
 
-			/* Is NRDY hardware managed? */
-			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
-			if (hw_managed)
-				mpam_set_feature(mpam_feat_msmon_mbwu_hw_nrdy, props);
+				has_long = FIELD_GET(MPAMF_MBWUMON_IDR_HAS_LONG, mbwumon_idr);
+				if (has_long) {
+					if (FIELD_GET(MPAMF_MBWUMON_IDR_LWD, mbwumon_idr))
+						mpam_set_feature(mpam_feat_msmon_mbwu_63counter, props);
+					else
+						mpam_set_feature(mpam_feat_msmon_mbwu_44counter, props);
+				} else {
+					mpam_set_feature(mpam_feat_msmon_mbwu_31counter, props);
+				}
 
-			/*
-			 * Don't warn about any missing firmware property for
-			 * MBWU NRDY - it doesn't make any sense!
-			 */
+				/* Is NRDY hardware managed? */
+				hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
+				if (hw_managed)
+					mpam_set_feature(mpam_feat_msmon_mbwu_hw_nrdy, props);
+
+				/*
+				 * Don't warn about any missing firmware property for
+				 * MBWU NRDY - it doesn't make any sense!
+				 */
+			}
 		}
 	}
 
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 41f30b1a0d97..d3eb92b79b98 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -162,6 +162,9 @@ enum mpam_device_features {
 	mpam_feat_msmon_csu_xcl,
 	mpam_feat_msmon_csu_hw_nrdy,
 	mpam_feat_msmon_mbwu,
+	mpam_feat_msmon_mbwu_31counter,
+	mpam_feat_msmon_mbwu_44counter,
+	mpam_feat_msmon_mbwu_63counter,
 	mpam_feat_msmon_mbwu_capture,
 	mpam_feat_msmon_mbwu_rwbw,
 	mpam_feat_msmon_mbwu_hw_nrdy,
-- 
2.43.0


