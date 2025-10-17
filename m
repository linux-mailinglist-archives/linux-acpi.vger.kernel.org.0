Return-Path: <linux-acpi+bounces-17922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1AEBEB50E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A06E58455B
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B333C517;
	Fri, 17 Oct 2025 18:59:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477FA337BBF;
	Fri, 17 Oct 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727562; cv=none; b=tpmAk6oHqxrnNo39RiaRgvZcGHgSEZLdxCL6bIRk1ci4INu/4c9b9QJYjlhNft+2ceS+jsUPxNwa5WMSEa0g8CarAuQ/QE5WEORLJl1oSA5RJY/+eehXTwFFXCq13ODi8t0EI7W9lkuHecV9qTHqfCQ8zHbWPj6Ms2Ar0UmAf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727562; c=relaxed/simple;
	bh=+/EQV6Jmf6Epvazt8JsWQV+UXM/n7rpxjhtimdcLE80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dUsgPqYZNHv25HZ+kY1c/6GLctIKERPZK+yIDP+53NUyFSzdXD/ItNETwX9CyYEylloc1ql5PXt4BaCFNG8+F3YU0kn/dIZSrZ6a4iGJ3aGRm1z9DZKLd8uhkRTylg0i82LZTdrYow32Oiv5hCi2rwTq4xpvzEUE8iBicp/R6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 026A81C2B;
	Fri, 17 Oct 2025 11:59:12 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB7A43F66E;
	Fri, 17 Oct 2025 11:59:14 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v3 25/29] arm_mpam: Probe for long/lwd mbwu counters
Date: Fri, 17 Oct 2025 18:56:41 +0000
Message-Id: <20251017185645.26604-26-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251017185645.26604-1-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
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
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v2:
 * Added 31 bit counter type feature.
 * Altered commit message.
---
 drivers/resctrl/mpam_devices.c  | 13 +++++++++++--
 drivers/resctrl/mpam_internal.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index deb1dcc6f6b1..f4d07234ce10 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -777,16 +777,25 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
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
+				mpam_set_feature(mpam_feat_msmon_mbwu_31counter, props);
+			}
 
 			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
 				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
 
+			has_long = FIELD_GET(MPAMF_MBWUMON_IDR_HAS_LONG, mbwumon_idr);
+			if (props->num_mbwu_mon && has_long) {
+				mpam_set_feature(mpam_feat_msmon_mbwu_44counter, props);
+				if (FIELD_GET(MPAMF_MBWUMON_IDR_LWD, mbwumon_idr))
+					mpam_set_feature(mpam_feat_msmon_mbwu_63counter, props);
+			}
+
 			/* Is NRDY hardware managed? */
 			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
 			if (hw_managed)
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 28c475d18d86..ff38b4bbfc2b 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -158,6 +158,9 @@ enum mpam_device_features {
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
2.39.5


