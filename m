Return-Path: <linux-acpi+bounces-16616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99531B52119
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F915E07FB
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22472D9EC5;
	Wed, 10 Sep 2025 19:31:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610311DDDD;
	Wed, 10 Sep 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532704; cv=none; b=oQsBKmbsv004ngKjnTr0mjIxmiwOLOO/I3za2tbqXm0vhSaNiARCpduOR55pYBagAKY/fkZJYPprHAnd5pDRQA+4Yqh2GXWVEl2PzyXddjx1vAegT4AnXOiaV4wh9Eeg/2i/9AjHyoPB9liYoU884sx6LxN1FYrJEPKZJLEsj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532704; c=relaxed/simple;
	bh=6nFK+xWRE9P7vEfcABcJDKH+rN4hj44XEnw9aRXo140=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpQEFWq0mH92unQOJ3UM+DC0jRLcqsjp3X+7Lz4P1LWpyeKdwhnNpeX80YBGA6PcYdV0zd4iqvHo1nVQGbCEbYFXofOy3/APv8HrtwpmfLxwZZk+u/g+oT3bYxHvaFzUZnK1ulFj9FmkyUA7VrW6ogBIcHz9Bzr7lIz7+lDZEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74A1D328E;
	Wed, 10 Sep 2025 12:31:34 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113163F694;
	Wed, 10 Sep 2025 12:31:36 -0700 (PDT)
Message-ID: <db4cdf45-4ba6-4b2e-a9a2-25c9bde81b71@arm.com>
Date: Wed, 10 Sep 2025 20:31:36 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] arm_mpam: Add MPAM MSC register layout definitions
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
 <20250822153048.2287-14-james.morse@arm.com>
 <OSZPR01MB879842246E3C0640BF60276D8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB879842246E3C0640BF60276D8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 09/09/2025 12:36, Shaopeng Tan (Fujitsu) wrote:
>> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
>> (MSCs) with an identity/configuration page.
>>
>> Add the definitions for these registers as offset within the page(s).

>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index d49bb884b433..6e0982a1a9ac 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -150,4 +150,270 @@ extern struct list_head mpam_classes;  int

>> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU
>> 	0x42
>> +#define MSMON_CFG_CSU_CTL_TYPE_CSU			0
> 
> +#define MSMON_CFG_CSU_CTL_TYPE_CSU			0x43?

Yes, that looks like the line got truncated.
This would have caused the counter type to be mismatched and reprogrammed each time.
Thanks for spotting it!

James

