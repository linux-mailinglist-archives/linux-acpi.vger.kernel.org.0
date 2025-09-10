Return-Path: <linux-acpi+bounces-16645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0DB522E6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6D15866F5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F2F343D94;
	Wed, 10 Sep 2025 20:45:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0D2FF650;
	Wed, 10 Sep 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537138; cv=none; b=iqO8XW7PHpB8XcfQc83BNGWsQbpZMImfSkakE618z2ob6Ao29DoNRYiwiF+h4BmFPA7p2hfvK915XAOY6qxsf5xEAQiM/LxWOFIWMhNCUDyMxt0vsR4tnaUR97X4e0bJC/GoIlk46VttrU59w+aAwHxtQK2lPzVb0DBk74TI7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537138; c=relaxed/simple;
	bh=skXi1Vu4Xztmyg4wYEMpxVKamgl0VmMShTVpPPXHP00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/yuOOm0IwovUIVtplAHXZB5GNz/g68bQsot7gH7X3K9jfU2j8nPruWCUAD6TAgvJeNa3REQqW9BXIJ+uKKj0Jnq8A9e8ucZr4H7Eki601Wx0jDm7YvKOGiJqd9mmg2HhoAM2FMY5Fo2A6OrBA/gD/pmaSd9szCh2ZP3X6X+5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21488153B;
	Wed, 10 Sep 2025 13:45:28 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6F4E3F63F;
	Wed, 10 Sep 2025 13:45:31 -0700 (PDT)
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
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v2 25/29] arm_mpam: Probe for long/lwd mbwu counters
Date: Wed, 10 Sep 2025 20:43:05 +0000
Message-Id: <20250910204309.20751-26-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250910204309.20751-1-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rohit Mathew <rohit.mathew@arm.com>

mpam v0.1 and versions above v1.0 support optional long counter for
memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register have fields
indicating support for long counters. As of now, a 44 bit counter
represented by HAS_LONG field (bit 30) and a 63 bit counter represented
by LWD (bit 29) can be optionally integrated. Probe for these counters
and set corresponding feature bits if any of these counters are present.

Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 23 ++++++++++++++++++++++-
 drivers/resctrl/mpam_internal.h |  9 +++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index eeb62ed94520..bae9fa9441dc 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -795,7 +795,7 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 				dev_err_once(dev, "Counters are not usable because not-ready timeout was not provided by firmware.");
 		}
 		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
-			bool hw_managed;
+			bool has_long, hw_managed;
 			u32 mbwumon_idr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
 
 			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
@@ -805,6 +805,27 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumon_idr))
 				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
 
+			/*
+			 * Treat long counter and its extension, lwd as mutually
+			 * exclusive feature bits. Though these are dependent
+			 * fields at the implementation level, there would never
+			 * be a need for mpam_feat_msmon_mbwu_44counter (long
+			 * counter) and mpam_feat_msmon_mbwu_63counter (lwd)
+			 * bits to be set together.
+			 *
+			 * mpam_feat_msmon_mbwu isn't treated as an exclusive
+			 * bit as this feature bit would be used as the "front
+			 * facing feature bit" for any checks related to mbwu
+			 * monitors.
+			 */
+			has_long = FIELD_GET(MPAMF_MBWUMON_IDR_HAS_LONG, mbwumon_idr);
+			if (props->num_mbwu_mon && has_long) {
+				if (FIELD_GET(MPAMF_MBWUMON_IDR_LWD, mbwumon_idr))
+					mpam_set_feature(mpam_feat_msmon_mbwu_63counter, props);
+				else
+					mpam_set_feature(mpam_feat_msmon_mbwu_44counter, props);
+			}
+
 			/* Is NRDY hardware managed? */
 			hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
 			if (hw_managed)
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 725c2aefa8a2..c190826dfbda 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -158,7 +158,16 @@ enum mpam_device_features {
 	mpam_feat_msmon_csu_capture,
 	mpam_feat_msmon_csu_xcl,
 	mpam_feat_msmon_csu_hw_nrdy,
+
+	/*
+	 * Having mpam_feat_msmon_mbwu set doesn't mean the regular 31 bit MBWU
+	 * counter would be used. The exact counter used is decided based on the
+	 * status of mpam_feat_msmon_mbwu_44counter/mpam_feat_msmon_mbwu_63counter
+	 * as well.
+	 */
 	mpam_feat_msmon_mbwu,
+	mpam_feat_msmon_mbwu_44counter,
+	mpam_feat_msmon_mbwu_63counter,
 	mpam_feat_msmon_mbwu_capture,
 	mpam_feat_msmon_mbwu_rwbw,
 	mpam_feat_msmon_mbwu_hw_nrdy,
-- 
2.39.5


