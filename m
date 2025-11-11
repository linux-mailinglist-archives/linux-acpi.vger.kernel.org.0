Return-Path: <linux-acpi+bounces-18778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08A0C4F1CA
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49853A9487
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338331A55B;
	Tue, 11 Nov 2025 16:48:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD02D979F;
	Tue, 11 Nov 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879690; cv=none; b=IK1R2EqMeGMzwrn442XJBvrPp0cjrAzSAVazxKzb2gH7EH2ehxFZQEn9Dz5jfP/dm+wfUJxACPDnUa4wCE5Bv6XB+R0rduSw1EYTiFEKr6DRjbJOffSP+08D+E56TKKIqe2HRO4WXMV6r+CNrPde0kqTGjbwe6//+/cLEhj/6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879690; c=relaxed/simple;
	bh=G2bms5tb+3dQg7eVtbpOcHpMDtGN5EDLOO9gbb+Q4Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slx5MBvzX6nGsZD2x3S1eBdXFuSCmz2ghQl74HG29AK39xRvf/i1oyK/D8zXNrpf9YYExW1nNBq2MLSxy5K1QGGwvG5Q6ECVBVI2JHeiFZbFLS+N4Xn+/noJXg1Dcj8cQETq/MgncO8WtZwHb8xHLiQ1ftmCqNHPiAH7OLUNzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC03497;
	Tue, 11 Nov 2025 08:47:59 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBCD33F63F;
	Tue, 11 Nov 2025 08:48:02 -0800 (PST)
Message-ID: <0457614c-0f36-4427-835f-2645f3a67c9b@arm.com>
Date: Tue, 11 Nov 2025 16:48:01 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use
 pptt cache as one structure
To: Jeremy Linton <jeremy.linton@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, gshan@redhat.com,
 guohanjun@huawei.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-4-ben.horgan@arm.com>
 <1a52079f-e12f-430b-b3c5-cb184f73c6c7@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <1a52079f-e12f-430b-b3c5-cb184f73c6c7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jeremy,

On 11/10/25 17:00, Jeremy Linton wrote:
> Hi,
> 
> On 11/7/25 6:34 AM, Ben Horgan wrote:
>> In actbl2.h, struct acpi_pptt_cache describes the fields in the original
>> cache type structure. In PPTT table version 3 a new field was added at
>> the
>> end, cache_id. This is described in struct acpi_pptt_cache_v1. Introduce
>> the new, acpi_pptt_cache_v1_full to contain both these structures. Update
>> the existing code to use this new struct. This simplifies the code,
>> removes
>> a non-standard use of ACPI_ADD_PTR and allows using the length in the
>> header to check if the cache_id is valid.
>>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> Changes since v3:
>> New patch
>> ---
>>   drivers/acpi/pptt.c | 104 ++++++++++++++++++++++++--------------------
>>   1 file changed, 58 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 1027ca3566b1..1ed2099c0d1a 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -21,6 +21,11 @@
>>   #include <linux/cacheinfo.h>
>>   #include <acpi/processor.h>
>>   +struct acpi_pptt_cache_v1_full {
>> +    struct acpi_pptt_cache        f;
>> +    struct acpi_pptt_cache_v1    extra;
>> +} __packed;
> 
> This presumably won't match an acpia change, right? Those structures
> appear to repeat the fields in the newer structure definitions.
> 
> Maybe its best to keep this as close to an acpica change and do a quick
> patch posting for acpica to assure they are onboard with the eventual
> structure (IIRC it was fast a few years ago when I had a similar problem).
> 
> That would avoid a bunch of the churn here of adding the 'f'/'extra'
> dereferene which would then potentailly have to be reverted at some
> point when acpica corrects the original structure.
I've created a pull request on their github:
https://github.com/acpica/acpica/pull/1059. This extends 'struct
acpi_pptt_cache_v1' to include all the fields of the Cache Type
Structure. I think this could be acceptable as there are other commits
in the history which make breaking changes to structures in the headers.
Let's see what they say. I got an immediate reply in Chinese but was
just an out of office.

Thanks,

Ben


