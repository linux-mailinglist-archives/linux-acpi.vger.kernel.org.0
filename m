Return-Path: <linux-acpi+bounces-16753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD5B5545D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 18:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C195A3F7C
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721931A57C;
	Fri, 12 Sep 2025 16:02:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA3624BCF5;
	Fri, 12 Sep 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692924; cv=none; b=p/RCKN2IrE/IGH6el974NphKhoQhWa2gI7c768EhgnnoN7w7zchafn4ZZYqWCKlVvAXqKRGJT3V6CukAP3hYAhzhVrcVt3qtSKecchOMyjPHGwvqaWFl26hT6geuat7daJBo+PGqdp/I177MRQRcbB5BV1knCKwGIOebSTkMQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692924; c=relaxed/simple;
	bh=Z2IP7ven87DpeGSpQzq3ec7cEllqPfB1tj/RViXsTzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDWZFSIk2NiFs0eFiunVa1YXHUPufy2oymKmV4ewX0G/2HE4KNzvqYi+oLqwngfct98//aunrPlbB/xX2nQ7h1KgHeDIe9/qnKsjK3VoWnc//7rzWiYqmUccyB1d31iUqTaopx6NVGVovoCGmwd3GDJEGgDllr4svlr6unQOfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 801991515;
	Fri, 12 Sep 2025 09:01:53 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD4933F66E;
	Fri, 12 Sep 2025 09:01:56 -0700 (PDT)
Message-ID: <2ed1be84-5097-488d-b8ce-7abebf5b9a7e@arm.com>
Date: Fri, 12 Sep 2025 17:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/29] arm_mpam: Add kunit tests for props_mismatch()
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-30-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-30-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:43, James Morse wrote:
> When features are mismatched between MSC the way features are combined
> to the class determines whether resctrl can support this SoC.
> 
> Add some tests to illustrate the sort of thing that is expected to
> work, and those that must be removed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Waggled some words in comments.
>  * Moved a bunch of variables to be global - shuts up a compiler warning.
> ---
>  drivers/resctrl/mpam_internal.h     |   8 +-
>  drivers/resctrl/test_mpam_devices.c | 321 ++++++++++++++++++++++++++++
>  2 files changed, 328 insertions(+), 1 deletion(-)
> 

Looks good to me, I checked the tests for v1. I agree with Jonathan that
you could make RESET_FAKE_HIEARCHY() a function now that you've changed
to use globals.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


