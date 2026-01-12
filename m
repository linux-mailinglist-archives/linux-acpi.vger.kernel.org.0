Return-Path: <linux-acpi+bounces-20187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF6D1235A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 12:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D12A30AC764
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E65352C2A;
	Mon, 12 Jan 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZEbc4DA4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E364A32;
	Mon, 12 Jan 2026 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216337; cv=none; b=ojGrjocrc0A/fio2wRotatshBqyMNPvBqtZTk2zGSWzIO4hxfbezgrA8VxBtqPW7iLqnzmkOkzopbLFqek2Xq3dTV2LpaQcXInJpeR5Cm5dJKKjBr1h0T9u7r+yjWfxyOGnLZYTrG81zUIilZtsLP2/7MvztW7k7VZ5tZdBjVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216337; c=relaxed/simple;
	bh=mT3132+jk0VsesmdB5dybL31vZQxTROCg2Wqgv500A0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HjVp+JvFt3DY6d/ylQ6zrvpnEnsqD/8npxbjvQycRuEjnRDxcwcoJKsne04Px3k0TrHi39A9gqmO51hRO2tPWPUn5esoj9YHvYBhdpDbODfAFRO6I+YIWN5AmR6S5R4esnnThUhpSC+FkPpAF8V9WjXgFyu3nWLbGzzzicI9wnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZEbc4DA4; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aBoWVfIas7SsjTAYT3jL83cWRgVERxaCiS7CcCSeQKc=;
	b=ZEbc4DA4c2luMuvSsNiM7RaJveo/Zb84Bf3Jpv2egABvKKLO+uFiBNXi9zK9We0AcOKhsHVYY
	gPmkvGpWrm2O+qrO9iO+0Erxm27yXLLsI29ySIxKyz4oShW9m4suo+TNuDrhvuZV93VcS+yZogq
	q/TrAYLFn5hU+29fQcH+oDY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dqV4Q6cSRz1K96f;
	Mon, 12 Jan 2026 19:08:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D99940539;
	Mon, 12 Jan 2026 19:12:11 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 19:12:09 +0800
Subject: Re: [PATCH v3 0/3] ACPI: APEI: GHES: Performance improvements for
 error notification handlers
To: Shuai Xue <xueshuai@linux.alibaba.com>, <tony.luck@intel.com>,
	<mchehab@kernel.org>, <dolinux.peng@gmail.com>, <yazen.ghannam@amd.com>,
	<rafael@kernel.org>
CC: <dave.jiang@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<leitao@debian.org>, <pengdonglin@xiaomi.com>,
	<baolin.wang@linux.alibaba.com>, <benjamin.cheatham@amd.com>, <bp@alien8.de>,
	<dan.j.williams@intel.com>, <james.morse@arm.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhuo.song@linux.alibaba.com>
References: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2a212d70-9752-fecb-a388-d854269a0ff9@huawei.com>
Date: Mon, 12 Jan 2026 19:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/1/12 11:22, Shuai Xue wrote:
> changes since v2:
> - Use `guard(rcu)()` instead of explicit `rcu_read_lock()`/`rcu_read_unlock()` per Donglin Peng
> 
> changes since v1:
> - add Tested-by and Reviewed-by tags from Tony
> - change return value from AE_BAD_ADDRESS to -EINVAL ghes_map_error_status per Hanjun
> - remove unnecessary blank lines per Hanjun
> 
> This patch series improves the performance of GHES error notification handlers
> (NMI and SEA) by optimizing how they check for active error conditions.
> 
> Currently, both ghes_notify_nmi() and ghes_notify_sea() perform expensive
> operations on each invocation to determine if there are actual error records
> to process. This includes mapping/unmapping physical addresses and accessing
> hardware registers, which causes significant overhead especially on systems
> with many cores.
> 
> The optimizations introduced in this series:
> 1. Pre-map error status registers during initialization
> 2. Directly check for active errors using mapped virtual addresses
> 3. Extract common functionality into reusable helper functions
> 4. Apply the same optimization to both NMI and SEA handlers
> 
> These changes significantly reduce the overhead of error checking:
> - NMI handler: From ~15,000 TSC cycles to ~900 cycles
> - SEA handler: From 8,138.3 ns to a much faster check
> 
> The initial idea for this optimization came from Tony Luck [1], who identified
> and implemented the approach for the NMI handler. This series extends the
> same concept to the SEA handler and refactors common code into shared helpers.
> 
> Patch 1 (Tony Luck): Improves ghes_notify_nmi() status check by pre-mapping
>                       error status registers and avoiding repeated mappings.
> 
> Patch 2 (Shuai Xue): Extracts common helper functions for error status handling
>                       to eliminate code duplication.
> 
> Patch 3 (Shuai Xue): Applies the same optimization to ghes_notify_sea() to improve
>                       ARMv8 system performance.

Looks good to me, and did a simple compile test on both x86 and arm64
machine,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

