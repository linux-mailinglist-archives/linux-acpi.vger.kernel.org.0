Return-Path: <linux-acpi+bounces-17728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF13BCE013
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EBC1A65EC1
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415592FC877;
	Fri, 10 Oct 2025 16:55:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0FC2FC866;
	Fri, 10 Oct 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115331; cv=none; b=Ukg5z5bYExX5wjT8n80meyRhoOzJPY9TUpphgr0Oz0fnWH8jZZUzemH3uewcajeuu1955HBeD40NwJ6fCQWGSXw5hr1Wmdzmr6KJyYQzrJIAa4AqMmRy5e3XbKT6TjBz3DAhjD38zQuRMECWdZLMlyUT1qxbsU1uoXpZjQUthIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115331; c=relaxed/simple;
	bh=Sz8RabVnrjFNVx868GiQTmH/sjg8X8gn79S1Yrj3Svo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jX9MsDcJXsoz3+peGyFVJzYGe86O/x2M6h1pVbyHVAmZbBPjwuFwHnqK4VV+ty9gBW7z/Po3GY23LvsP9tJDMo5p01Rn7ZNj6KmanK194dBh2I0SmyQVTB/mKSrRC1ZmzD29cRJsNnLAJ7rn4oGzScWuQGFZNUXnvRopWULRzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A279153B;
	Fri, 10 Oct 2025 09:55:21 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A66AB3F66E;
	Fri, 10 Oct 2025 09:55:23 -0700 (PDT)
Message-ID: <6cdb1661-67c5-445e-bfe0-b4a8f3493676@arm.com>
Date: Fri, 10 Oct 2025 17:55:21 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] ACPI / PPTT: Add a helper to fill a cpumask from
 a processor container
To: Gavin Shan <gshan@redhat.com>, linux-kernel@vger.kernel.org,
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
 <20250910204309.20751-2-james.morse@arm.com>
 <3a2f6807-9a49-4976-a4d7-7577756c3c26@redhat.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <3a2f6807-9a49-4976-a4d7-7577756c3c26@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gavin,

On 03/10/2025 01:15, Gavin Shan wrote:
> On 9/11/25 6:42 AM, James Morse wrote:
>> The ACPI MPAM table uses the UID of a processor container specified in
>> the PPTT to indicate the subset of CPUs and cache topology that can
>> access each MPAM System Component (MSC).
>>
>> This information is not directly useful to the kernel. The equivalent
>> cpumask is needed instead.
>>
>> Add a helper to find the processor container by its id, then walk
>> the possible CPUs to fill a cpumask with the CPUs that have this
>> processor container as a parent.

> With the description for the return value of acpi_pptt_get_cpus_from_container()
> is dropped since that function doesn't have a return value, as mentioned by
> Stanimir Varbanov.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>


Thanks!

James

