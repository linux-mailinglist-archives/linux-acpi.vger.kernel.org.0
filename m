Return-Path: <linux-acpi+bounces-18215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55950C08E2B
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A6BB34D7C7
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Oct 2025 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842062C21F6;
	Sat, 25 Oct 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="OJbRp5ul"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A823908B;
	Sat, 25 Oct 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761382896; cv=none; b=VlXKn36fogdVgI8jZ3ZZAeRN+UzATz239UghobfTYxAs/yKfjfmRRDmsld2y17DLPDMab4fpJkNZxY6uMQGHQ4IuV1fxX+F8rcKM7HNyqoUaI+ZEHIiY1gheQAtvTFmGx6XRvYrYeJexORkFBwLeXOnGkOcgWB/x0aJbsi1SNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761382896; c=relaxed/simple;
	bh=s3yHYOmdNRzmbUWxmisvMesDkkONnNF3GvA5TN7rEcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G4WFAI01XXCDrUECmRhqEInvWeVb4LzC69ql9bUhD6JOdgREx9DpXAlfCy73WBUUi3aaYpTu+pRiCphvSpAWhOCgaz6Q6iEKaIvdZ/DvhoGlM0i8WQ/i1D/pYjz925VPa0io8zmOeLS2B4gmNvn5+/owlKS5iUDLcHURQ3vzcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=OJbRp5ul; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AO4386yNxVFuR4ViyLt/237opsz9K4kw/MJn/OvQtBc=;
	b=OJbRp5ulXukGYxbxg6Us0kZljfYUxHttOzAsKE8A4C0lq3GWANRknkxTJxJIR95ln9RmWRitF
	LgaYa5Rt5TSMfFGpJWiDschNI0RaNIe61sA/j/DBMzEEvb+1B3TP0xakdl64yW9SG4TTSpO5t3d
	e/M4ZWdkItO8cqdW5+Qv8hc=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cttz62KvxznTVF;
	Sat, 25 Oct 2025 17:00:50 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id C327E140143;
	Sat, 25 Oct 2025 17:01:29 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 17:01:27 +0800
Message-ID: <1c037f72-485a-567b-bf8f-489255330de8@huawei.com>
Date: Sat, 25 Oct 2025 17:01:27 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1] arm64/mpam: Fix MBWU monitor
 overflow handling
Content-Language: en-US
To: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<guohanjun@huawei.com>, <jeremy.linton@arm.com>,
	<jonathan.cameron@huawei.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251022133913.629859-1-zengheng4@huawei.com>
 <8e22c81e-5e78-41e0-a81e-0f9826e5edf0@arm.com>
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <8e22c81e-5e78-41e0-a81e-0f9826e5edf0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Ben,

On 2025/10/23 0:17, Ben Horgan wrote:

>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 0dd048279e02..06f3ec9887d2 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1101,7 +1101,8 @@ static void __ris_msmon_read(void *arg)
>>   	clean_msmon_ctl_val(&cur_ctl);
>>   	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>>   	config_mismatch = cur_flt != flt_val ||
>> -			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>> +			 (cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS) !=
>> +			 (ctl_val | MSMON_CFG_x_CTL_EN);
> 
> This only considers 31 bit counters. I would expect any change here to
> consider all lengths of counter. 
> 

Sorry, regardless of whether the counter is 32-bit or 64-bit, the
config_mismatch logic should be handled the same way here. Am I
wrong?

Best Regards,
Zeng Heng

