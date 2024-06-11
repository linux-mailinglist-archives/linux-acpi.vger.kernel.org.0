Return-Path: <linux-acpi+bounces-6298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CF490391C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797212868DC
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56388176AD4;
	Tue, 11 Jun 2024 10:42:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CF7407C;
	Tue, 11 Jun 2024 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102539; cv=none; b=AI2LiYsz/VWBGNsNe8CdZ8xbCNnFiCCrXD8hJHv37nTJV7MA5liJlOH+S4yrRJBMMjdbkFGtizH8u34YuRa5dIJyfaSyro/ClA1omcnqPvEl9jdiqHx3n3zTjlxvlc4SbL8VzwoHyhxK4/9Yr4aM9sWHF0kFEPEH9+a5Ilv3PHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102539; c=relaxed/simple;
	bh=3Izkffgpe9AwSgB3tbJpYn0cnYZH8KaRa5AJSvxQ0Ag=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MOq2wz5uUAfJ7RwESueFeJOQ02orDzw5TLImLgBe3y+YKxK1X2n8qJCE2o8/0VOtsbf4W3sCZVgrPyeB/UTLuKr1N+pwwwRak4EG8dEGuYy9yez9uCNpoZWbgWJ5SV7OBKRBmJ+gkQ9TZifah+XnThNEgnIcFrk8wgEeIYIidac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vz4rb6tSNz1SBpk;
	Tue, 11 Jun 2024 18:38:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5081818006C;
	Tue, 11 Jun 2024 18:42:12 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Jun 2024 18:42:11 +0800
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
Date: Tue, 11 Jun 2024 18:42:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/6/7 0:50, Andy Shevchenko wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/acpi/arm64/iort.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c0b1c2c19444..e596dff20f1e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -822,7 +822,7 @@ static struct iommu_iort_rmr_data *iort_rmr_alloc(
>   		return NULL;
>   
>   	/* Create a copy of SIDs array to associate with this rmr_data */
> -	sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
> +	sids_copy = kmemdup_array(sids, num_sids, sizeof(*sids), GFP_KERNEL);
>   	if (!sids_copy) {
>   		kfree(rmr_data);
>   		return NULL;

Looks good to me,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

