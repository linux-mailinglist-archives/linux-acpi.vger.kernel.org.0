Return-Path: <linux-acpi+bounces-16649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A3B522F6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A18A80A5D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FC302156;
	Wed, 10 Sep 2025 20:45:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F5301039;
	Wed, 10 Sep 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537159; cv=none; b=Uo2lB+UBdVGvqIAxbLbIt0TW9105wBLdFw6Ql7fVZHNrXtkrQyd2W7qqpqIFV6caq7R7IvKNjF8BtJif/8G3zTLgZTfqAzRgQzYr9M/drzl8n0VEigdHbYwasjXQuxdOPJPTwSb0XGAChwii6xBJj6qBggoGnJ3M1fxMW1N45jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537159; c=relaxed/simple;
	bh=kALWgrLvp18k4apv/tsIK6SQrkoHW8swIzKy66580ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9dpo7qX4x2vbuV3p0z6O6iS9njwZEoWERfbtRF3cFvDsyalkXebcPCThFKm4otq/iY+wI5d0Iv7nYtXKctpmzo6V/e/PquNvX1cGD7BqbIAHem+Ng+x+o3iy285cxSorJaVpc6Bs7bMUzhbn2ZRfDc0VYZRx2ou76MBU/Ep6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46EA21EDB;
	Wed, 10 Sep 2025 13:45:48 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F40C83F63F;
	Wed, 10 Sep 2025 13:45:51 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 29/29] arm_mpam: Add kunit tests for props_mismatch()
Date: Wed, 10 Sep 2025 20:43:09 +0000
Message-Id: <20250910204309.20751-30-james.morse@arm.com>
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

When features are mismatched between MSC the way features are combined
to the class determines whether resctrl can support this SoC.

Add some tests to illustrate the sort of thing that is expected to
work, and those that must be removed.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Waggled some words in comments.
 * Moved a bunch of variables to be global - shuts up a compiler warning.
---
 drivers/resctrl/mpam_internal.h     |   8 +-
 drivers/resctrl/test_mpam_devices.c | 321 ++++++++++++++++++++++++++++
 2 files changed, 328 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 7cbcafe8294a..6119e4573187 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -20,6 +20,12 @@
 
 DECLARE_STATIC_KEY_FALSE(mpam_enabled);
 
+#ifdef CONFIG_MPAM_KUNIT_TEST
+#define PACKED_FOR_KUNIT __packed
+#else
+#define PACKED_FOR_KUNIT
+#endif
+
 static inline bool mpam_is_enabled(void)
 {
 	return static_branch_likely(&mpam_enabled);
@@ -189,7 +195,7 @@ struct mpam_props {
 	u16			dspri_wd;
 	u16			num_csu_mon;
 	u16			num_mbwu_mon;
-};
+} PACKED_FOR_KUNIT;
 
 #define mpam_has_feature(_feat, x)	((1 << (_feat)) & (x)->features)
 
diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
index 3e7058f7601c..4eca8590c691 100644
--- a/drivers/resctrl/test_mpam_devices.c
+++ b/drivers/resctrl/test_mpam_devices.c
@@ -4,6 +4,325 @@
 
 #include <kunit/test.h>
 
+/*
+ * This test catches fields that aren't being sanitised - but can't tell you
+ * which one...
+ */
+static void test__props_mismatch(struct kunit *test)
+{
+	struct mpam_props parent = { 0 };
+	struct mpam_props child;
+
+	memset(&child, 0xff, sizeof(child));
+	__props_mismatch(&parent, &child, false);
+
+	memset(&child, 0, sizeof(child));
+	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
+
+	memset(&child, 0xff, sizeof(child));
+	__props_mismatch(&parent, &child, true);
+
+	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
+}
+
+static struct list_head fake_classes_list;
+static struct mpam_class fake_class = { 0 };
+static struct mpam_component fake_comp1 = { 0 };
+static struct mpam_component fake_comp2 = { 0 };
+static struct mpam_vmsc fake_vmsc1 = { 0 };
+static struct mpam_vmsc fake_vmsc2 = { 0 };
+static struct mpam_msc fake_msc1 = { 0 };
+static struct mpam_msc fake_msc2 = { 0 };
+static struct mpam_msc_ris fake_ris1 = { 0 };
+static struct mpam_msc_ris fake_ris2 = { 0 };
+static struct platform_device fake_pdev = { 0 };
+
+static void test_mpam_enable_merge_features(struct kunit *test)
+{
+#define RESET_FAKE_HIEARCHY()	do {				\
+	INIT_LIST_HEAD(&fake_classes_list);			\
+								\
+	memset(&fake_class, 0, sizeof(fake_class));		\
+	fake_class.level = 3;					\
+	fake_class.type = MPAM_CLASS_CACHE;			\
+	INIT_LIST_HEAD_RCU(&fake_class.components);		\
+	INIT_LIST_HEAD(&fake_class.classes_list);		\
+								\
+	memset(&fake_comp1, 0, sizeof(fake_comp1));		\
+	memset(&fake_comp2, 0, sizeof(fake_comp2));		\
+	fake_comp1.comp_id = 1;					\
+	fake_comp2.comp_id = 2;					\
+	INIT_LIST_HEAD(&fake_comp1.vmsc);			\
+	INIT_LIST_HEAD(&fake_comp1.class_list);			\
+	INIT_LIST_HEAD(&fake_comp2.vmsc);			\
+	INIT_LIST_HEAD(&fake_comp2.class_list);			\
+								\
+	memset(&fake_vmsc1, 0, sizeof(fake_vmsc1));		\
+	memset(&fake_vmsc2, 0, sizeof(fake_vmsc2));		\
+	INIT_LIST_HEAD(&fake_vmsc1.ris);			\
+	INIT_LIST_HEAD(&fake_vmsc1.comp_list);			\
+	fake_vmsc1.msc = &fake_msc1;				\
+	INIT_LIST_HEAD(&fake_vmsc2.ris);			\
+	INIT_LIST_HEAD(&fake_vmsc2.comp_list);			\
+	fake_vmsc2.msc = &fake_msc2;				\
+								\
+	memset(&fake_ris1, 0, sizeof(fake_ris1));		\
+	memset(&fake_ris2, 0, sizeof(fake_ris2));		\
+	fake_ris1.ris_idx = 1;					\
+	INIT_LIST_HEAD(&fake_ris1.msc_list);			\
+	fake_ris2.ris_idx = 2;					\
+	INIT_LIST_HEAD(&fake_ris2.msc_list);			\
+								\
+	fake_msc1.pdev = &fake_pdev;				\
+	fake_msc2.pdev = &fake_pdev;				\
+								\
+	list_add(&fake_class.classes_list, &fake_classes_list);	\
+} while (0)
+
+	RESET_FAKE_HIEARCHY();
+
+	mutex_lock(&mpam_list_lock);
+
+	/* One Class+Comp, two RIS in one vMSC with common features */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = NULL;
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = NULL;
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc1;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc1.ris);
+
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
+	fake_ris1.props.cpbm_wd = 4;
+	fake_ris2.props.cpbm_wd = 4;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
+
+	RESET_FAKE_HIEARCHY();
+
+	/* One Class+Comp, two RIS in one vMSC with non-overlapping features */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = NULL;
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = NULL;
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc1;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc1.ris);
+
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cmax_cmin, &fake_ris2.props);
+	fake_ris1.props.cpbm_wd = 4;
+	fake_ris2.props.cmax_wd = 4;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	/* Multiple RIS within one MSC controlling the same resource can be mismatched */
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_class.props));
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_vmsc1.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
+	KUNIT_EXPECT_EQ(test, fake_vmsc1.props.cmax_wd, 4);
+	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 4);
+
+	RESET_FAKE_HIEARCHY();
+
+	/* One Class+Comp, two MSC with overlapping features */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = NULL;
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = &fake_comp1;
+	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc2;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
+
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
+	fake_ris1.props.cpbm_wd = 4;
+	fake_ris2.props.cpbm_wd = 4;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
+
+	RESET_FAKE_HIEARCHY();
+
+	/* One Class+Comp, two MSC with non-overlapping features */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = NULL;
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = &fake_comp1;
+	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc2;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
+
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cmax_cmin, &fake_ris2.props);
+	fake_ris1.props.cpbm_wd = 4;
+	fake_ris2.props.cmax_wd = 4;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	/*
+	 * Multiple RIS in different MSC can't control the same resource,
+	 * mismatched features can not be supported.
+	 */
+	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
+	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_class.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
+	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 0);
+
+	RESET_FAKE_HIEARCHY();
+
+	/* One Class+Comp, two MSC with incompatible overlapping features */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = NULL;
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = &fake_comp1;
+	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc2;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
+
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
+	mpam_set_feature(mpam_feat_mbw_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_mbw_part, &fake_ris2.props);
+	fake_ris1.props.cpbm_wd = 5;
+	fake_ris2.props.cpbm_wd = 3;
+	fake_ris1.props.mbw_pbm_bits = 5;
+	fake_ris2.props.mbw_pbm_bits = 3;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	/*
+	 * Multiple RIS in different MSC can't control the same resource,
+	 * mismatched features can not be supported.
+	 */
+	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
+	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_mbw_part, &fake_class.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
+	KUNIT_EXPECT_EQ(test, fake_class.props.mbw_pbm_bits, 0);
+
+	RESET_FAKE_HIEARCHY();
+
+	/* One Class+Comp, two MSC with overlapping features that need tweaking */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = NULL;
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = &fake_comp1;
+	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc2;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
+
+	mpam_set_feature(mpam_feat_mbw_min, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_mbw_min, &fake_ris2.props);
+	mpam_set_feature(mpam_feat_cmax_cmax, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cmax_cmax, &fake_ris2.props);
+	fake_ris1.props.bwa_wd = 5;
+	fake_ris2.props.bwa_wd = 3;
+	fake_ris1.props.cmax_wd = 5;
+	fake_ris2.props.cmax_wd = 3;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	/*
+	 * RIS with different control properties need to be sanitised so the
+	 * class has the common set of properties.
+	 */
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_mbw_min, &fake_class.props));
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cmax_cmax, &fake_class.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.bwa_wd, 3);
+	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 3);
+
+	RESET_FAKE_HIEARCHY();
+
+	/* One Class Two Comp with overlapping features */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = &fake_class;
+	list_add(&fake_comp2.class_list, &fake_class.components);
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = &fake_comp2;
+	list_add(&fake_vmsc2.comp_list, &fake_comp2.vmsc);
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc2;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
+
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
+	fake_ris1.props.cpbm_wd = 4;
+	fake_ris2.props.cpbm_wd = 4;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
+
+	RESET_FAKE_HIEARCHY();
+
+	/* One Class Two Comp with non-overlapping features */
+	fake_comp1.class = &fake_class;
+	list_add(&fake_comp1.class_list, &fake_class.components);
+	fake_comp2.class = &fake_class;
+	list_add(&fake_comp2.class_list, &fake_class.components);
+	fake_vmsc1.comp = &fake_comp1;
+	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
+	fake_vmsc2.comp = &fake_comp2;
+	list_add(&fake_vmsc2.comp_list, &fake_comp2.vmsc);
+	fake_ris1.vmsc = &fake_vmsc1;
+	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
+	fake_ris2.vmsc = &fake_vmsc2;
+	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
+
+	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
+	mpam_set_feature(mpam_feat_cmax_cmin, &fake_ris2.props);
+	fake_ris1.props.cpbm_wd = 4;
+	fake_ris2.props.cmax_wd = 4;
+
+	mpam_enable_merge_features(&fake_classes_list);
+
+	/*
+	 * Multiple components can't control the same resource, mismatched features can
+	 * not be supported.
+	 */
+	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
+	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_class.props));
+	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
+	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 0);
+
+	mutex_unlock(&mpam_list_lock);
+
+#undef RESET_FAKE_HIEARCHY
+}
+
 static void test_mpam_reset_msc_bitmap(struct kunit *test)
 {
 	char __iomem *buf = kunit_kzalloc(test, SZ_16K, GFP_KERNEL);
@@ -57,6 +376,8 @@ static void test_mpam_reset_msc_bitmap(struct kunit *test)
 
 static struct kunit_case mpam_devices_test_cases[] = {
 	KUNIT_CASE(test_mpam_reset_msc_bitmap),
+	KUNIT_CASE(test_mpam_enable_merge_features),
+	KUNIT_CASE(test__props_mismatch),
 	{}
 };
 
-- 
2.39.5


