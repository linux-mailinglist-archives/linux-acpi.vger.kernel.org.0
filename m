Return-Path: <linux-acpi+bounces-18654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C2C3FF34
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 13:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E894189AE13
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295702F531F;
	Fri,  7 Nov 2025 12:38:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004831D72D;
	Fri,  7 Nov 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519082; cv=none; b=fQdhjzOUjy3scY84yyAE4DDtsB7+pY+Ye6TwpOx3yG231yFPaSpebSuOpHv5iWtYmZYHjlZdIxwUIBia2W+gmcsY86yTJOQhd1WX1Rdq+o10DOzc/fV7369KLQTN7MaWQj0OwK9knc0RK2tcblP/kVXQ19ogd2EbCosfhR7TVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519082; c=relaxed/simple;
	bh=Pj+JPbxr/eLJokxcYxBg38CmijHeF3gET9C9ICevQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTx0McaF/5/ljQ0MaE1EjwurPgG0ZxUX9w2Y/MqVFshMJVfPJESyO2aXf+U4ghKsotdWEaUA/CEDE0eM2GvwqbAQAUZU6BKv9RrCx2n8DZvMyMnB2Mj5ZrncGp1h9EDunQj36O88Zz8C1JxWgJSpTvO3+ZiJbtHyDRZBRlwUS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB3B1515;
	Fri,  7 Nov 2025 04:37:52 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C0413F66E;
	Fri,  7 Nov 2025 04:37:54 -0800 (PST)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH 29/33] arm_mpam: Probe for long/lwd mbwu counters
Date: Fri,  7 Nov 2025 12:34:46 +0000
Message-ID: <20251107123450.664001-30-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
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
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Only set the exact counter length that is supported
---
 drivers/resctrl/mpam_devices.c  | 34 +++++++++++++++++++++------------
 drivers/resctrl/mpam_internal.h |  3 +++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index eea082dfcddc..e93f2e919a85 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -783,25 +783,35 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
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
+				} else
+					mpam_set_feature(mpam_feat_msmon_mbwu_31counter, props);
 
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
index 7c99d4f3dc9c..f3bf26b7fdaf 100644
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


