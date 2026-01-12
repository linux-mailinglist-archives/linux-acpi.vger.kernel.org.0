Return-Path: <linux-acpi+bounces-20162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F78D10689
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 04:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3F2304893C
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 03:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09032306B37;
	Mon, 12 Jan 2026 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DP3cAomM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B5AD24;
	Mon, 12 Jan 2026 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186963; cv=none; b=dPXxOgV6BIlV1qXTvunXtqG5+vbHKUAsaoDFKu1L8bffwd9MDo66zHr/Q2AOxs7V1QkwJE7ckwXTk3DiNJhYmoY0oovLROsF7Zbvzb/25K7sidwjwkMuCPyGAYAJJ3upxsz14WIc1Ek/W9nhdJ1BcBzPQsD1l2Ruai47YYv5uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186963; c=relaxed/simple;
	bh=FsbtJdR2NX/sp7ulPWKrTjQwvJP7QgBdJuzJVWk8T1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noO3P7OdfHs2rjIlDKQwHnFlUFb5XReCaSJ1UkgTFdCR6c3LDMLCsTUtuuXxK6Pa87vi5OTroVbpl5r5FARS60FqkE5UZilPvy7+WKNh64QNgKPB3Bsagfbm8EYn440BtWv8tZawBdePe9tLNjooOn6T1yFkPxgIjNrD8xDPQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DP3cAomM; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768186959; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wzDAN0h2i2h3RVGCB/Obcq+8Fos476PcbI4PPvViStg=;
	b=DP3cAomMG6Rs5qB2Uc4qEZoKGvdpyRNqfJ+QFgLGa/KYKTHkxv146nWk24hsvntE04g+fIUrDBTi2MqfRb6/3/3QZSeK1iO+1wSF+Xiw0uvXcIFwUavMdsXxnl2WhyvDeI4qmxoAs3lQH5LUJrTdLKBykrsNpuL/k4BoPSCGwcM=
Received: from 30.246.161.92(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwnqAdu_1768186601 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Jan 2026 10:57:18 +0800
Message-ID: <c164959b-6d51-4a6d-af3f-8c44106f57d3@linux.alibaba.com>
Date: Mon, 12 Jan 2026 10:57:08 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ACPI: APEI: GHES: Extract helper functions for
 error status handling
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>, tony.luck@intel.com,
 guohanjun@huawei.com, mchehab@kernel.org, yazen.ghannam@amd.com,
 dave.jiang@intel.com, Smita.KoralahalliChannabasappa@amd.com,
 leitao@debian.org, pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com,
 benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
 james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhuo.song@linux.alibaba.com
References: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
 <20260104120405.51555-3-xueshuai@linux.alibaba.com>
 <CAErzpmvQqv6S-XkTf46bzTRQuv3h1LGXFixX-D_bCho-bD+upg@mail.gmail.com>
 <e0ba4b97-7294-443c-a958-6436623d2e96@linux.alibaba.com>
 <CAJZ5v0jgfXDf4kxpQ7v8xapZw+S8Qc7gmt3txCKN7zptHs1biA@mail.gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAJZ5v0jgfXDf4kxpQ7v8xapZw+S8Qc7gmt3txCKN7zptHs1biA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/10/26 5:22 AM, Rafael J. Wysocki wrote:
> On Mon, Jan 5, 2026 at 6:42 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>
>>
>> On 1/5/26 1:12 PM, Donglin Peng wrote:
>>> On Sun, Jan 4, 2026 at 8:05 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>>
>>>> Refactors the GHES driver by extracting common functionality into
>>>> reusable helper functions:
>>>>
>>>> 1. ghes_has_active_errors() - Checks if any error sources in a given list
>>>>      have active errors
>>>> 2. ghes_map_error_status() - Maps error status address to virtual address
>>>> 3. ghes_unmap_error_status() - Unmaps error status virtual address
>>>>
>>>> These helpers eliminate code duplication in the NMI path and prepare for
>>>> similar usage in the SEA path in a subsequent patch.
>>>>
>>>> No functional change intended.
>>>>
>>>> Tested-by: Tony Luck <tony.luck@intel.com>
>>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> ---
>>>>    drivers/acpi/apei/ghes.c | 93 +++++++++++++++++++++++++++++++---------
>>>>    1 file changed, 72 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>> index 0e97d50b0240..7600063fe263 100644
>>>> --- a/drivers/acpi/apei/ghes.c
>>>> +++ b/drivers/acpi/apei/ghes.c
>>>> @@ -1406,6 +1406,75 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>>>>           return ret;
>>>>    }
>>>>
>>>> +/**
>>>> + * ghes_has_active_errors - Check if there are active errors in error sources
>>>> + * @ghes_list: List of GHES entries to check for active errors
>>>> + *
>>>> + * This function iterates through all GHES entries in the given list and
>>>> + * checks if any of them has active error status by reading the error
>>>> + * status register.
>>>> + *
>>>> + * Return: true if at least one source has active error, false otherwise.
>>>> + */
>>>> +static bool __maybe_unused ghes_has_active_errors(struct list_head *ghes_list)
>>>> +{
>>>> +       bool active_error = false;
>>>> +       struct ghes *ghes;
>>>> +
>>>> +       rcu_read_lock();
>>>
>>> Nit: Use `guard(rcu)()` instead of explicit
>>> `rcu_read_lock()`/`rcu_read_unlock()`.
>>>
>>> Thanks,
>>> Donglin
>>>
>>
>> Hi, Donglin,
>>
>> Good point. Will fix in next version.
> 
> If you do so, you may also get rid of the active_error local variable.

Got it. Thanks for reminding.
Shuai


