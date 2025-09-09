Return-Path: <linux-acpi+bounces-16547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EBB5039C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 19:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F9B7A4C3B
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D18362093;
	Tue,  9 Sep 2025 16:57:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC0362087;
	Tue,  9 Sep 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437062; cv=none; b=TmkBorBOOCrDiyyiKrL6hcE00cjlDakkkso57a6xzNFGEcXj/Ztjwmrj5YS+MSxKdVMMoeVCFNM38o1R6nf/+ABWtXA+0HBw5yqv/8gyX1vwlxqg8/kETxZIA2guol1beFiI2ODMuph7mgxYR3om9sgeSM9cn6ORGV/wUy+jcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437062; c=relaxed/simple;
	bh=4dSZ165qmpGFOYD4MEJwykS+T7jpCQJECJirqZzh1lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7t3flQB8qZW71WvUS0DRJxpx9sUxgyInrLLwL+ljO+Ts71z4Yf1o9a7b3KJGccEPZALlUyruSC/FRj+RqIV2i/Ehe7hZDbe+l2BlPcX3BjSyKmttRvQm0GDo3Fc4I1xtpY1T57X6uCm5EMsigiv+DpZoqsUGZkGfiS0qsJMriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB5762008;
	Tue,  9 Sep 2025 09:57:31 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76363F694;
	Tue,  9 Sep 2025 09:57:33 -0700 (PDT)
Message-ID: <fe25e8e0-4b3a-4427-8356-9235252db226@arm.com>
Date: Tue, 9 Sep 2025 17:57:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] arm_mpam: Merge supported features during
 mpam_enable() into mpam_class
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-19-james.morse@arm.com>
 <b8af1782-0fb8-4e6e-8895-b229a1c67ebe@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <b8af1782-0fb8-4e6e-8895-b229a1c67ebe@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

On 29/08/2025 14:54, Ben Horgan wrote:
> On 8/22/25 16:29, James Morse wrote:
>> To make a decision about whether to expose an mpam class as
>> a resctrl resource we need to know its overall supported
>> features and properties.
>>
>> Once we've probed all the resources, we can walk the tree
>> and produce overall values by merging the bitmaps. This
>> eliminates features that are only supported by some MSC
>> that make up a component or class.
>>
>> If bitmap properties are mismatched within a component we
>> cannot support the mismatched feature.
>>
>> Care has to be taken as vMSC may hold mismatched RIS.

> Intricate but, as far as I can tell, all correct.
Yeah - its cpufeature.c all over again.


> Reviewed-by: Ben Horgan <ben.horgan@arm.com>


Thanks!

James

