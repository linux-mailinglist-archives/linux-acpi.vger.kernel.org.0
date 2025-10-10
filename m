Return-Path: <linux-acpi+bounces-17733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C8BCE061
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3030A4FFC62
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE802FD1D0;
	Fri, 10 Oct 2025 16:56:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F132FD1CF;
	Fri, 10 Oct 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115371; cv=none; b=qWt1WyYHIsW1/jbk/0IvcRXAHzbJ2MfBF/UNBxGOFQAw7jbf9qA5CuVv7I+Ws4gv2aScUCclYPwFQ2RLexsoB1WMlOd625XR3SKGoVlOXkYAn9DTaoXX2aB4H9vqlTBhtYPC2ieOEGLkzeccdSuM70wzwowY3nHpR3d6A7SM6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115371; c=relaxed/simple;
	bh=RofIudv5YXMEEthWbgRH6JEHQjcGmNomXmHjIUiRjlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uellwuDjY9gf0rLbZGTMvyYJMSDrzhIrM8961fP5WBygCVBnQLp39Esm+uCK2YDuVGj2HsIAhzRtLG0ylvqSH4sHbd7mpyV4P2EHTVMLNXuoniY7u+7xHaC3AFd5stP/2ViCOxf3fQoHGGfkB2i4gnu+CZY3jB1/k8Tpmxk6Gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 373D0153B;
	Fri, 10 Oct 2025 09:56:01 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10FE13F66E;
	Fri, 10 Oct 2025 09:56:02 -0700 (PDT)
Message-ID: <ae1f55e4-d7b0-48cb-9cf9-da272cc934ac@arm.com>
Date: Fri, 10 Oct 2025 17:55:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/29] arm64: kconfig: Add Kconfig entry for MPAM
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
 <20250910204309.20751-6-james.morse@arm.com>
 <ef45ce3a-7a78-45c8-8196-75923af7c6ab@redhat.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <ef45ce3a-7a78-45c8-8196-75923af7c6ab@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gavin,

On 03/10/2025 01:32, Gavin Shan wrote:
> On 9/11/25 6:42 AM, James Morse wrote:
>> The bulk of the MPAM driver lives outside the arch code because it
>> largely manages MMIO devices that generate interrupts. The driver
>> needs a Kconfig symbol to enable it. As MPAM is only found on arm64
>> platforms, the arm64 tree is the most natural home for the Kconfig
>> option.
>>
>> This Kconfig option will later be used by the arch code to enable
>> or disable the MPAM context-switch code, and to register properties
>> of CPUs with the MPAM driver.

> Reviewed-by: Gavin Shan <gshan@redhat.com>

Thanks!

James

