Return-Path: <linux-acpi+bounces-19945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7AECF204E
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 06:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E344300A355
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 05:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE9285C91;
	Mon,  5 Jan 2026 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gCN7EQHp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6663A1E63;
	Mon,  5 Jan 2026 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767591735; cv=none; b=evTrkM+UKNgRl8UdwHDxs69pO8l16Rw74FCyWbiCeV/ULX/yHZK/9wYowinpVNxRzaL2lF48Lw7QGZVS4IOcZ+FXPowQe8kxdFINhDvKclsZeOhWEK+3Sug2aTXVwy0NdrMlCRpqXTQB81MP3G0xmuSh0mqc/Lnls8EmTwTJMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767591735; c=relaxed/simple;
	bh=dhp/PYmsVGK1ITR/JPuNc4sB53kOqqp8YVY0zYcK2fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDDNEGtzPoO7QQWFVPbjWKHOMvsa3lZScEwFkEYXk+dZrN9dx0J2QSCHJFKfCkr+wAwkjYzB3JUCwDuMMtEft1kulaOwjof6rKRfgk+L6ATkc3u7DOPdihjaYnDk0gV4vRpi7h7zj/6fkNXPkQaGdGmAvxw1h1Az+PUVevHXc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gCN7EQHp; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767591724; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=poXSEbS7FBHj/hFz2kd+v8Ed0gyoH9GlLUEf+mqO4uk=;
	b=gCN7EQHpNBY2wgah/X3E7RGIgAk0bn99e6A72U/nLBUkPLNmCuK49nNRsHFQ+Oc34kYCWY9WM5iXpMw84w4Ixt/nHw3eylyBt+pt+cZ/jn3P+RsZbwsBi7qRHCwGWS2IS/yavxI5D8/QFqVBpvU1iyir2FxSdad0BaP6BxxjzCU=
Received: from 30.246.162.61(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WwJSRNj_1767591721 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 05 Jan 2026 13:42:03 +0800
Message-ID: <e0ba4b97-7294-443c-a958-6436623d2e96@linux.alibaba.com>
Date: Mon, 5 Jan 2026 13:41:57 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ACPI: APEI: GHES: Extract helper functions for
 error status handling
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: tony.luck@intel.com, guohanjun@huawei.com, mchehab@kernel.org,
 yazen.ghannam@amd.com, dave.jiang@intel.com,
 Smita.KoralahalliChannabasappa@amd.com, leitao@debian.org,
 pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com,
 benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
 james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, zhuo.song@linux.alibaba.com
References: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
 <20260104120405.51555-3-xueshuai@linux.alibaba.com>
 <CAErzpmvQqv6S-XkTf46bzTRQuv3h1LGXFixX-D_bCho-bD+upg@mail.gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAErzpmvQqv6S-XkTf46bzTRQuv3h1LGXFixX-D_bCho-bD+upg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/5/26 1:12 PM, Donglin Peng wrote:
> On Sun, Jan 4, 2026 at 8:05 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>> Refactors the GHES driver by extracting common functionality into
>> reusable helper functions:
>>
>> 1. ghes_has_active_errors() - Checks if any error sources in a given list
>>     have active errors
>> 2. ghes_map_error_status() - Maps error status address to virtual address
>> 3. ghes_unmap_error_status() - Unmaps error status virtual address
>>
>> These helpers eliminate code duplication in the NMI path and prepare for
>> similar usage in the SEA path in a subsequent patch.
>>
>> No functional change intended.
>>
>> Tested-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 93 +++++++++++++++++++++++++++++++---------
>>   1 file changed, 72 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 0e97d50b0240..7600063fe263 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1406,6 +1406,75 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
>>          return ret;
>>   }
>>
>> +/**
>> + * ghes_has_active_errors - Check if there are active errors in error sources
>> + * @ghes_list: List of GHES entries to check for active errors
>> + *
>> + * This function iterates through all GHES entries in the given list and
>> + * checks if any of them has active error status by reading the error
>> + * status register.
>> + *
>> + * Return: true if at least one source has active error, false otherwise.
>> + */
>> +static bool __maybe_unused ghes_has_active_errors(struct list_head *ghes_list)
>> +{
>> +       bool active_error = false;
>> +       struct ghes *ghes;
>> +
>> +       rcu_read_lock();
> 
> Nit: Use `guard(rcu)()` instead of explicit
> `rcu_read_lock()`/`rcu_read_unlock()`.
> 
> Thanks,
> Donglin
> 

Hi, Donglin,

Good point. Will fix in next version.

Thanks.
Shuai

