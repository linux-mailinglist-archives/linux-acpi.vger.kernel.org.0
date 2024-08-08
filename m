Return-Path: <linux-acpi+bounces-7442-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D094B9E6
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0548B212C5
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2861189903;
	Thu,  8 Aug 2024 09:43:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C24086A
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110227; cv=none; b=b1ZBc65SEnmYCa653zDjTWy/pHQN2j1Mz61eK3UUCTScQtjjx+jOQXzamcgx70mWXuY2f9AOJPAmOnGduzx4gZix90X538ZLygG8Pkz9JRSjTyvsR8LEylFOIzwkh/TyUZqBH9DkZw/eQsNw4xI3wcNVjepQC+Oawqr+PJJlKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110227; c=relaxed/simple;
	bh=X5FOFXdgO/fKoH1kH5xcKZVjzFbLe98S6bAn6IENd9s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TO3nOOOc0xeiuElOtB49fUNmrdyIi9+vYWDwv8iymIh0wFcsv3sCaMm2+UbFQxylTUz5nxlQQUdibnem4/8KBSUSi0rzXDucxsI25ffwbrA2e+PSh3e2sNcdpi9VnR6RjsQPqZMuurBsEkTewADxLE8o95XA8ckn3I4m0r7YEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wfhrr1f2KzDqb9;
	Thu,  8 Aug 2024 17:41:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 88A4A1401E0;
	Thu,  8 Aug 2024 17:43:42 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 17:43:42 +0800
Subject: Re: [PATCH v3] ACPI: introduce acpi_arch_init
To: <shankerwangmiao@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Sudeep Holla
	<sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240808-intro-acpi-arch-init-v3-1-ba510859baff@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <64bd9991-61a9-5cb5-60fe-941cb4171290@huawei.com>
Date: Thu, 8 Aug 2024 17:43:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240808-intro-acpi-arch-init-v3-1-ba510859baff@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/8 17:00, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> To avoid arch-specific code in general ACPI initialization flow,
> we introduce a weak symbol acpi_arch_init. Currently, arm64 can
> utillize this to insert its specific flow. In the future,
> other architectures can also have chance to define their own
> arch-specific acpi initialization process if necessary.
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Changes from v1
> - Change acpi_arch_init from a static inline stub to a weak function
>    according to Haijun Guo's advice
> ---
> Changes from v2:
> - Add __init attribute to the weak acpi_arch_init stub
> - Link to v2: https://lore.kernel.org/r/20240807-intro-acpi-arch-init-v2-1-9231e23a7721@gmail.com

Thanks for the quick update,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

