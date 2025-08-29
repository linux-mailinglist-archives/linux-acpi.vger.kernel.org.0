Return-Path: <linux-acpi+bounces-16183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2175B3BCE4
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA657AF5E0
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B570314A91;
	Fri, 29 Aug 2025 13:54:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA211EE7DD;
	Fri, 29 Aug 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475683; cv=none; b=S1aAe4qlfsPd3qX+ncwfkdW6llIEBKNRww+futmT1p765pQG/IiWSRCR52XAPWL6ybSIqAQkb9TRRM6ioxI5oIXoZLF5LTOkFg1cLzSpop/HNX/hTwFyKafRrpS3cdkOgJ9f1zOUACncwxXs8pryYHh1Wy+bW16NPL0uAu7iN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475683; c=relaxed/simple;
	bh=NBUtrBWPuoyovO/vdm2NT9qoO/gpzJQS9wKV3akzTBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6uzEHyrdgaq06o4T0fYLKWXPyzf0KXPoisymkMu3MS6dCGzMJvbz19PdoImGUV2SqDiY1rvJbTWYAK+Rkab1EdolW9WuNv9lUx0ZXupYHcn1Okt5Y0KHe4iONIniQvUPlxqTnPLXzIlb2BkaxFXI/pknSs+2hj83wxoBNpEhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7460D1655;
	Fri, 29 Aug 2025 06:54:32 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15CD3F694;
	Fri, 29 Aug 2025 06:54:34 -0700 (PDT)
Message-ID: <b8af1782-0fb8-4e6e-8895-b229a1c67ebe@arm.com>
Date: Fri, 29 Aug 2025 14:54:33 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] arm_mpam: Merge supported features during
 mpam_enable() into mpam_class
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
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
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-19-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:29, James Morse wrote:
> To make a decision about whether to expose an mpam class as
> a resctrl resource we need to know its overall supported
> features and properties.
> 
> Once we've probed all the resources, we can walk the tree
> and produce overall values by merging the bitmaps. This
> eliminates features that are only supported by some MSC
> that make up a component or class.
> 
> If bitmap properties are mismatched within a component we
> cannot support the mismatched feature.
> 
> Care has to be taken as vMSC may hold mismatched RIS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 215 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |   8 ++
>  2 files changed, 223 insertions(+)

Intricate but, as far as I can tell, all correct.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


