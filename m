Return-Path: <linux-acpi+bounces-16614-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DBB52112
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F5B1C86A99
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CC2D641A;
	Wed, 10 Sep 2025 19:31:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611226B779;
	Wed, 10 Sep 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532689; cv=none; b=airc6k4SKW6cOujfzuc2I412Uc8ZgerIUE7y/SXeBj0tbeMXjjIWl4YQ/uW3ik42Gy6MeaeIUnnZ7U551+3uksCL/2/gip6Gd57iWn6eiAjY9ToMtBa0HnMhDgVd0SoLfpowU5QdV9rlq4eUcVtLeXhTHOK2QDWuM0bZ40sKj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532689; c=relaxed/simple;
	bh=AjDTuM81hQifR+N10EEA9fVLxHXK8+EdmpykbapLIns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUq5qN3zX5VUwIFMmGOg6ZIU+UDkn8U4Ltrw9jhXKtj5/bHjyanvSb+r4JuqbFozoX1Ic0mbDfBw9pwhbnutVhk6PgyRqzxE2yGEw/3rCfPIK2nkEG1CUD0WWvBODs43Ya6fjhSuyJ+jKRx6yQm4oOtOqlI4mkJKl9WhduKxAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A40816F2;
	Wed, 10 Sep 2025 12:31:18 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBA5F3F694;
	Wed, 10 Sep 2025 12:31:20 -0700 (PDT)
Message-ID: <9f00c748-c3cd-4f31-aefd-b27a4af343be@arm.com>
Date: Wed, 10 Sep 2025 20:31:18 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
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
 <20250822153048.2287-45-james.morse@arm.com>
 <OSZPR01MB87984A649F19363669F1D6688B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB87984A649F19363669F1D6688B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 09/09/2025 08:03, Shaopeng Tan (Fujitsu) wrote:
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may only be
>> accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until the
>> system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> new file mode 100644 index 000000000000..a0d9a699a6e7
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -0,0 +1,336 @@

>> +static int mpam_dt_parse_resources(struct mpam_msc *msc, void *ignored)
>> +{
>> +	int err, num_ris = 0;
>> +	const u32 *ris_idx_p;
>> +	struct device_node *iter, *np;
>> +
>> +	np = msc->pdev->dev.of_node;
>> +	for_each_child_of_node(np, iter) {
>> +		ris_idx_p = of_get_property(iter, "reg", NULL);
>> +		if (ris_idx_p) {
>> +			num_ris++;
>> +			err = mpam_dt_parse_resource(msc, iter, *ris_idx_p);
>> +			if (err) {
>> +				of_node_put(iter);
>> +				return err;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (!num_ris)
>> +		mpam_dt_parse_resource(msc, np, 0);

> err = mpam_dt_parse_resource(msc, np, 0);

Oops! Thanks for catching that,


James

