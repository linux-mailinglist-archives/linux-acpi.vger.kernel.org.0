Return-Path: <linux-acpi+bounces-15806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E936B2ADCD
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AE33BAB48
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048A326D45;
	Mon, 18 Aug 2025 16:07:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F115321F2D;
	Mon, 18 Aug 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533220; cv=none; b=egRu4EhGk9/xLYBHLsRNhpDNRfhPKgLH/QxtocK1df8/Pr+rSL8w9ka+Pd6e+dwGjURFObnFIoeiBR7F7+1hG6tYqv2Ny7s/Tg1R3jFojxP8oa1IMmuuh6Z6jY0+Nnx66OD3uq5WC7j6s02t96Old9IOO/39VjBl0Apsi430jJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533220; c=relaxed/simple;
	bh=RKqwqcoBZty2Bnrj1AAUWZ96Q/MRzLop/yigw1HQFvM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BTNwb7YS1v1Zum6iEUS6s5FQUKHmLj+q7WZWSgk49Q9Rf1vU9uJuWTmi7h4lYSOkEqCdYyS7Hmno8c9SaPOi1IvAguaLDI9L9EUZet1TRHDX/MXGyor/zgUUjCJcxAltFz0GIXlG6s940Z/aTb3N6heTZlLeOAm8R1013PwmwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c5HZm5vNCz2gKxB;
	Tue, 19 Aug 2025 00:04:00 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CD94140230;
	Tue, 19 Aug 2025 00:06:51 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 00:06:50 +0800
Subject: Re: [PATCH] ACPI: APEI: EINJ: fix potential NULL dereference in
 __einj_error_inject
To: Charles Han <hanchunchao@inspur.com>, <rafael@kernel.org>,
	<tony.luck@intel.com>, <bp@alien8.de>, <mchehab@kernel.org>,
	<xueshuai@linux.alibaba.com>, <lenb@kernel.org>, <ira.weiny@intel.com>,
	<zaidal@os.amperecomputing.com>, <Jonathan.Cameron@huawei.com>,
	<colin.i.king@gmail.com>, <dan.carpenter@linaro.org>,
	<dan.j.williams@intel.com>, <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250815024207.3038-1-hanchunchao@inspur.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <547301a8-5a66-7958-15be-0bcf01dd8a62@huawei.com>
Date: Tue, 19 Aug 2025 00:06:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250815024207.3038-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/15 10:42, Charles Han wrote:
> The __einj_error_inject() function allocates memory via kmalloc()
> without checking for allocation failure, which could lead to a
> NULL pointer dereference.
> 
> Return -ENOMEM in case allocation fails.
> 
> Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   drivers/acpi/apei/einj-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index bf8dc92a373a..93a3ae1325e5 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -540,6 +540,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>   		struct set_error_type_with_address *v5param;
>   
>   		v5param = kmalloc(v5param_size, GFP_KERNEL);
> +		if (!v5param)
> +			return -ENOMEM;
> +
>   		memcpy_fromio(v5param, einj_param, v5param_size);
>   		v5param->type = type;
>   		if (type & ACPI5_VENDOR_BIT) {

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

