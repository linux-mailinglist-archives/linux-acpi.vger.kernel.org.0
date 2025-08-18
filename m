Return-Path: <linux-acpi+bounces-15805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD8B2AD8C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 17:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0CA1894DE3
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89679326D62;
	Mon, 18 Aug 2025 15:58:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B3322DC7;
	Mon, 18 Aug 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532703; cv=none; b=TLeNwBR8xOPxh6gCsMtfo9yk+iMTclqyP04SnwUloveDD5CNF+o5Ak0QzrnbrN3f/dLwEfOdlM29mz2s5CH4RvUkQ3nfvygFyP1XsB/Vwq9waBvAmXznMhdegpRO+ym49jAdobedZPapb+IQMfVP2/kkZsCUkcl3VSF+pKSPBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532703; c=relaxed/simple;
	bh=gBgvK3cn0huJsQKSbW38IqRZtFyWLdP/JwK2uEp2NWA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z6kFgiLfLFmSxES8X9fB+SzBHvd0ECBYPhh6UDfDXyd3f8si31mBw6akjBKyz+2dACTCDMu1FfVw1Eq9nP+c14NTxiz4r0moCrP7lCvnLI4vruL/fqVQgVgwLH8CztSL8jZMphVRacFolXwwJsiQQP7i4Ugc2ZERg2rIFxPocT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c5HR12QZJzqVXQ;
	Mon, 18 Aug 2025 23:57:17 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 9215D180B66;
	Mon, 18 Aug 2025 23:58:16 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 23:58:15 +0800
Subject: Re: [PATCH] ACPI: APEI: EINJ: Check if user asked for EINJV2
 injection
To: Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, Zaid Alali <zaidal@os.amperecomputing.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<patches@lists.linux.dev>, "Lai, Yi1" <yi1.lai@intel.com>
References: <20250814161706.4489-1-tony.luck@intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <230e2659-7838-2165-4490-3b3f89cb7838@huawei.com>
Date: Mon, 18 Aug 2025 23:58:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814161706.4489-1-tony.luck@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/15 0:17, Tony Luck wrote:
> On an EINJV2 capable system, users may still use the old injection
> interface but einj_get_parameter_address() takes the EINJV2 path to map
> the parameter structure. This results in the address the user supplied
> being stored to the wrong location and the BIOS injecting based on an
> uninitialized field (0x0 in the reported case).
> 
> Check the version of the request when mapping the EINJ parameter
> structure in BIOS reserved memory.
> 
> Fixes: 691a0f0a557b ("ACPI: APEI: EINJ: Discover EINJv2 parameters")
> Reported-by: Lai, Yi1 <yi1.lai@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   drivers/acpi/apei/einj-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index bf8dc92a373a..99f1b841fba9 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -315,7 +315,7 @@ static void __iomem *einj_get_parameter_address(void)
>   			memcpy_fromio(&v5param, p, v5param_size);
>   			acpi5 = 1;
>   			check_vendor_extension(pa_v5, &v5param);
> -			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +			if (is_v2 && available_error_type & ACPI65_EINJV2_SUPP) {
>   				len = v5param.einjv2_struct.length;
>   				offset = offsetof(struct einjv2_extension_struct, component_arr);
>   				max_nr_components = (len - offset) /

Reviewed-by: Hanjun Guo <gouhanjun@huawei.com>

Thanks
Hanjun

