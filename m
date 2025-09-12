Return-Path: <linux-acpi+bounces-16732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6648B54FDD
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518F34631D1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A1430F523;
	Fri, 12 Sep 2025 13:41:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BE30E0D1;
	Fri, 12 Sep 2025 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684515; cv=none; b=esthYOeE9364TzVMcqHADVdz0/f+onLL/VvMKVmZHpvN6zmHTkcDQeKCdb9SgSBxPtSTeyhYBrhQdQeZH1RPXlxrLAwbQ3ANaqdYkgaokURrfy3aVfapJMdNSYdpAVH725JL4Ko3I1GhqrGNARfrjTTc5jmzCp3yc5aHqfp9XNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684515; c=relaxed/simple;
	bh=Ocmw6Ujc46HuI0Xl6UtjgJYAp/3YH6otYCdcydvbHqk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O247bbbemjBBs+6bJya7eI3Jd3BtuIzs1aoIZAuawonQjpMhZeReH06CYRdMCCD6vmzzit0oBFsxJRD5anihqhzAT1b/6LFJLB/HGoxjsj468hvJrpVijkXAyOwN6WmmEnsxpfzgWPFHa9RkVQzPJTMDeuM5j4ILxDD+1RKN3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNbCh5njzz6GDH2;
	Fri, 12 Sep 2025 21:40:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E4541401F4;
	Fri, 12 Sep 2025 21:41:51 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:41:49 +0200
Date: Fri, 12 Sep 2025 14:41:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 29/29] arm_mpam: Add kunit tests for props_mismatch()
Message-ID: <20250912144148.00003204@huawei.com>
In-Reply-To: <20250910204309.20751-30-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-30-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:43:09 +0000
James Morse <james.morse@arm.com> wrote:

> When features are mismatched between MSC the way features are combined
> to the class determines whether resctrl can support this SoC.
> 
> Add some tests to illustrate the sort of thing that is expected to
> work, and those that must be removed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
Nice in general though I didn't go through the test expected results etc.
A few comments inline.

Thanks and looking forward to seeing this go in.

Jonathan

> ---
> Changes since v1:
>  * Waggled some words in comments.
>  * Moved a bunch of variables to be global - shuts up a compiler warning.
> ---
>  drivers/resctrl/mpam_internal.h     |   8 +-
>  drivers/resctrl/test_mpam_devices.c | 321 ++++++++++++++++++++++++++++
>  2 files changed, 328 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 7cbcafe8294a..6119e4573187 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -20,6 +20,12 @@
>  
>  DECLARE_STATIC_KEY_FALSE(mpam_enabled);
>  
> +#ifdef CONFIG_MPAM_KUNIT_TEST
> +#define PACKED_FOR_KUNIT __packed
> +#else
> +#define PACKED_FOR_KUNIT
> +#endif
> +
>  static inline bool mpam_is_enabled(void)
>  {
>  	return static_branch_likely(&mpam_enabled);
> @@ -189,7 +195,7 @@ struct mpam_props {
>  	u16			dspri_wd;
>  	u16			num_csu_mon;
>  	u16			num_mbwu_mon;
> -};
> +} PACKED_FOR_KUNIT;

Add a comment on 'why'.

>  
>  #define mpam_has_feature(_feat, x)	((1 << (_feat)) & (x)->features)
>  
> diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
> index 3e7058f7601c..4eca8590c691 100644
> --- a/drivers/resctrl/test_mpam_devices.c
> +++ b/drivers/resctrl/test_mpam_devices.c
> @@ -4,6 +4,325 @@
>  
>  #include <kunit/test.h>
>  
> +/*
> + * This test catches fields that aren't being sanitised - but can't tell you
> + * which one...
> + */
> +static void test__props_mismatch(struct kunit *test)
> +{
> +	struct mpam_props parent = { 0 };
> +	struct mpam_props child;
> +
> +	memset(&child, 0xff, sizeof(child));
> +	__props_mismatch(&parent, &child, false);
> +
> +	memset(&child, 0, sizeof(child));
> +	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
> +
> +	memset(&child, 0xff, sizeof(child));
> +	__props_mismatch(&parent, &child, true);
> +
> +	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
> +}
> +
> +static struct list_head fake_classes_list;
> +static struct mpam_class fake_class = { 0 };
> +static struct mpam_component fake_comp1 = { 0 };
> +static struct mpam_component fake_comp2 = { 0 };
> +static struct mpam_vmsc fake_vmsc1 = { 0 };
> +static struct mpam_vmsc fake_vmsc2 = { 0 };
> +static struct mpam_msc fake_msc1 = { 0 };
> +static struct mpam_msc fake_msc2 = { 0 };
> +static struct mpam_msc_ris fake_ris1 = { 0 };
> +static struct mpam_msc_ris fake_ris2 = { 0 };
> +static struct platform_device fake_pdev = { 0 };
> +
> +static void test_mpam_enable_merge_features(struct kunit *test)
> +{
> +#define RESET_FAKE_HIEARCHY()	do {				\
> +	INIT_LIST_HEAD(&fake_classes_list);			\
> +								\
> +	memset(&fake_class, 0, sizeof(fake_class));		\

Maybe just use a function?  Seems to be changing stuff that is
global mostly anyway so seems like it won't need large numbers
of parameters or anything like that.

> +	fake_class.level = 3;					\
> +	fake_class.type = MPAM_CLASS_CACHE;			\
> +	INIT_LIST_HEAD_RCU(&fake_class.components);		\
> +	INIT_LIST_HEAD(&fake_class.classes_list);		\
> +								\
> +	memset(&fake_comp1, 0, sizeof(fake_comp1));		\
> +	memset(&fake_comp2, 0, sizeof(fake_comp2));		\
> +	fake_comp1.comp_id = 1;					\
> +	fake_comp2.comp_id = 2;					\
> +	INIT_LIST_HEAD(&fake_comp1.vmsc);			\
> +	INIT_LIST_HEAD(&fake_comp1.class_list);			\
> +	INIT_LIST_HEAD(&fake_comp2.vmsc);			\
> +	INIT_LIST_HEAD(&fake_comp2.class_list);			\
> +								\
> +	memset(&fake_vmsc1, 0, sizeof(fake_vmsc1));		\
> +	memset(&fake_vmsc2, 0, sizeof(fake_vmsc2));		\
> +	INIT_LIST_HEAD(&fake_vmsc1.ris);			\
> +	INIT_LIST_HEAD(&fake_vmsc1.comp_list);			\
> +	fake_vmsc1.msc = &fake_msc1;				\
> +	INIT_LIST_HEAD(&fake_vmsc2.ris);			\
> +	INIT_LIST_HEAD(&fake_vmsc2.comp_list);			\
> +	fake_vmsc2.msc = &fake_msc2;				\
> +								\
> +	memset(&fake_ris1, 0, sizeof(fake_ris1));		\
> +	memset(&fake_ris2, 0, sizeof(fake_ris2));		\
> +	fake_ris1.ris_idx = 1;					\
> +	INIT_LIST_HEAD(&fake_ris1.msc_list);			\
> +	fake_ris2.ris_idx = 2;					\
> +	INIT_LIST_HEAD(&fake_ris2.msc_list);			\
> +								\
> +	fake_msc1.pdev = &fake_pdev;				\
> +	fake_msc2.pdev = &fake_pdev;				\
> +								\
> +	list_add(&fake_class.classes_list, &fake_classes_list);	\
> +} while (0)
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	mutex_lock(&mpam_list_lock);
> +
> +	/* One Class+Comp, two RIS in one vMSC with common features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = NULL;
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = NULL;
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc1.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 4;
> +	fake_ris2.props.cpbm_wd = 4;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
> +
> +	RESET_FAKE_HIEARCHY();



