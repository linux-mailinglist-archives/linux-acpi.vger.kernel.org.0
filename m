Return-Path: <linux-acpi+bounces-16373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E511B44453
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 19:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD427A9FF6
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680830FC25;
	Thu,  4 Sep 2025 17:28:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D630CDBE;
	Thu,  4 Sep 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006917; cv=none; b=mosZ3ssz5uyu4+T2BejiVccI5Jfw+2sknQ1AYcs535Elx+UHxRgoHmER/DB5NTX4wxO5hrepDiO9KmfijY4HF4+FVKA4ae9WV9QLQ0+wRKy2D3/64RHrXrTPeHJ+dxpce3feHYq2hRQqYbQ5DsqothO2HsJYFhVMg/qZ/X9PSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006917; c=relaxed/simple;
	bh=Z7YC0f/6mF0zUtmtDn2Q17ZKP1H+legn4v36pcS41uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWQWWji8LDUqkm/pZ5++L0ja+oWMmn4gQxjB8j941KHbSPVWOQ/YAZGNuC2NLWD8mUGFpSopVgajdn+i3Y8VBYp0ms0Yx0PNnDylw9d3zFzvaFHCZDCblh0YCUqn7ujjyypL0Ck2G6s5kfSwumPutsfOlRxOEMDTFx8yOMt2tF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B514D2E98;
	Thu,  4 Sep 2025 10:28:26 -0700 (PDT)
Received: from [10.1.196.42] (eglon.cambridge.arm.com [10.1.196.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773093F6A8;
	Thu,  4 Sep 2025 10:28:29 -0700 (PDT)
Message-ID: <dfddc34d-bfe7-48e3-a454-c3be7e093e1e@arm.com>
Date: Thu, 4 Sep 2025 18:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
To: Markus Elfring <Markus.Elfring@web.de>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Baisheng Gao <baisheng.gao@unisoc.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, bobo.shaobowang@huawei.com,
 Carl Worth <carl@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, David Hildenbrand <david@redhat.com>,
 Drew Fustini <dfustini@baylibre.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 Fenghua Yu <fenghuay@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Koba Ko <kobak@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Len Brown <lenb@kernel.org>,
 Linu Cherian <lcherian@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Newman <peternewman@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rex Nie <rex.nie@jaguarmicro.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shameer Kolothum <shameerkolothum@gmail.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
 Xin Hao <xhao@linux.alibaba.com>
References: <20250822153048.2287-9-james.morse@arm.com>
 <60b72fd4-0a63-44ff-9850-1848d3fe9559@web.de>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <60b72fd4-0a63-44ff-9850-1848d3fe9559@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Markus,

On 23/08/2025 11:55, Markus Elfring wrote:
> …
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -0,0 +1,331 @@
> …
>> +static int __init acpi_mpam_parse(void)
>> +{
>> +        struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_MPAM, 0);
>> +	char *table_end, *table_offset = (char *)(table + 1);
> …
> 
> Please replace eight space characters by a tab character here.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.17-rc2#n18
> 
> Are further source code places similarly improvable?

Yes - I just copied this rune from the email from Jonathan that suggested it.
'Fixed',


Thanks,

James

