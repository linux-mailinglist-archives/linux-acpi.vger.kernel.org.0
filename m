Return-Path: <linux-acpi+bounces-16615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A29B52114
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF258529A
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE62D7DF2;
	Wed, 10 Sep 2025 19:31:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C4255F31;
	Wed, 10 Sep 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532696; cv=none; b=ejT5g8mM44p5tbHZZxkac9HGody/AU7X0N1xHl6IkGS5P3fNRPC5HPsHN/HIvR8Prz1E7Uih/yaWQ5kgt5JiAx268eZ0EKzqska9ZDsGxp6oTq7TcPOzjReMIAE3hP4aAgt0afHHfyWi4hUTEIchyOhXAqPOZXWRJsEQg0TiSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532696; c=relaxed/simple;
	bh=t9+KzpP17zR6XzK8fB7liPW7aOhA650yUwTnlo9f+Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7kc6RK+DB11hH3QdE7d3l1TSUYjvVHArhAPTRZN79H43VDURJLXlyxO29StD2+eCP2PPE0VqQvWsiI5s8VhNYa9N+oFIlpxBlvUaoFP0YkvR4Ka/o3xHV+h0q774J/Tq5+X8DLYcLkQNOj9yVtn5NzcHjHZSM/93QFg93auB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 310FD3165;
	Wed, 10 Sep 2025 12:31:26 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C6363F694;
	Wed, 10 Sep 2025 12:31:28 -0700 (PDT)
Message-ID: <25e99137-54ee-434d-8777-a771798e9da1@arm.com>
Date: Wed, 10 Sep 2025 20:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] arm_mpam: Add support for memory controller MSC on
 DT platforms
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
 "baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-46-james.morse@arm.com>
 <OSZPR01MB8798A7AA3C2D11E2D38381BA8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB8798A7AA3C2D11E2D38381BA8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 09/09/2025 08:11, Shaopeng Tan (Fujitsu) wrote:
>> From: Shanker Donthineni <sdonthineni@nvidia.com>
>>
>> The device-tree binding has two examples for MSC associated with memory
>> controllers. Add the support to discover the component_id from the device-tree
>> and create 'memory' RIS.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index a0d9a699a6e7..71a1fb1a9c75 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -62,41 +62,63 @@ static int mpam_dt_parse_resource(struct mpam_msc
>> *msc, struct device_node *np,
>>  				  u32 ris_idx)
>>  {
>>  	int err = 0;
>> -	u32 level = 0;
>> -	unsigned long cache_id;
>> -	struct device_node *cache;
>> +	u32 class_id = 0, component_id = 0;
>> +	struct device_node *cache = NULL, *memory = NULL;
>> +	enum mpam_class_types type = MPAM_CLASS_UNKNOWN;
>>
>>  	do {
>> +		/* What kind of MSC is this? */
>>  		if (of_device_is_compatible(np, "arm,mpam-cache")) {
>>  			cache = of_parse_phandle(np, "arm,mpam-device",
>> 0);
>>  			if (!cache) {
>>  				pr_err("Failed to read phandle\n");
>>  				break;
>>  			}
>> +			type = MPAM_CLASS_CACHE;
>>  		} else if (of_device_is_compatible(np->parent, "cache")) {
>>  			cache = of_node_get(np->parent);
>> +			type = MPAM_CLASS_CACHE;
>> +		} else if (of_device_is_compatible(np, "arm,mpam-memory"))
>> {
>> +			memory = of_parse_phandle(np, "arm,mpam-device",
>> 0);
>> +			if (!memory) {
>> +				pr_err("Failed to read phandle\n");
>> +				break;
>> +			}
>> +			type = MPAM_CLASS_MEMORY;
>> +		} else if (of_device_is_compatible(np,
>> "arm,mpam-memory-controller-msc")) {
>> +			memory = of_node_get(np->parent);
>> +			type = MPAM_CLASS_MEMORY;
>>  		} else {
>> -			/* For now, only caches are supported */
>> -			cache = NULL;
>> +			/*
>> +			 * For now, only caches and memory controllers are
>> +			 * supported.
>> +			 */
>>  			break;
>>  		}

> There is no need "{}" here.

Sure, but its more than one line, and all the previous parts of this else-if tree have
them. Keeping this here make it much easier to read.


Thanks,

James

