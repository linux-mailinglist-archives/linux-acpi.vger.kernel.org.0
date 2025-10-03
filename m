Return-Path: <linux-acpi+bounces-17526-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4969BB5ADA
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F48C19E76DC
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 00:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD62B2D7;
	Fri,  3 Oct 2025 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcORrS37"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1681DA55
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759451542; cv=none; b=IHxUxjd2Eubz6jd3Zf6Su4pqxd7YPEx/7fH0CZwqN9ve8j1RxGqmgrE51chr0oKNAn284PU75vJGyrJDUgwRQ9TCjzjj2aCyGfMh9ALGFr5I7JKO0aaz1vFiwpbHuutvU8Jx4gFRrNaZFnHebAog2IMeuOPDuK1jALZ2YDdBgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759451542; c=relaxed/simple;
	bh=ETlEf66hdPCHHJn1GuWHBeROSwycNJMpRgfr1/FpZG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+30jY4vAaclOmCbeFB8g+tU4rsByYzrx90jD0DFU++yiS+/H8DLXE/byURJ/STsvdl4ereKAHvbe8YBk/AUFJuxNCT2BkcBid7xkS0YLrQSwQFtmaZtnAE8SNQUS5eoFzCXVeDHMoAfizDdm0WYnfb54GhcX7A0mzDpzpagMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcORrS37; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759451539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xaf5RNoemnbQ5bhVRXfDXLq6XKqiACwC+kjxc5U7K8E=;
	b=dcORrS37leWVm4KdpJNUOSvAc4CYYTK3jpbJjqb5xAt4wtttB+ZEjt4PUbwRl6w9jFWqgF
	AG/GoC6OqpioSg+v7OgFwageCiUd4qxkM82cdSc64kIHfigBepNACLamvdOm7xQONHV7sx
	TmkJdof4u0UAJwF8XinDsOYp9spWaXw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Yav92R6YNUG5khrinVijjQ-1; Thu, 02 Oct 2025 20:32:18 -0400
X-MC-Unique: Yav92R6YNUG5khrinVijjQ-1
X-Mimecast-MFC-AGG-ID: Yav92R6YNUG5khrinVijjQ_1759451538
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78117fbda6eso1590464b3a.3
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 17:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759451537; x=1760056337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xaf5RNoemnbQ5bhVRXfDXLq6XKqiACwC+kjxc5U7K8E=;
        b=JmMyfOw1s5sK26rLUfPEXugJ9OY5+Vv6Vyod8DeJuK3AbIF8hp6/1163QhcshqiYM4
         yUaJ/J24loqmTkfz/E6zZw323E3SWtMgqZRti2PyoO5x8xgPYP8gscBKI6ybp5x8cj9v
         yJgWOBZWB2Go5l3Vb+K2UutDHtHHDDKvhetzes58PXxcdJUmhE1rpyo21oqNdvLquffO
         XSv31jgxVPhH22C84Tn1sh9q1fh6F2z68LQvxpPRHdy5kpzx17daG3RbLkCaazhjv7Yk
         w6sy3OrlCBJgUxqSea+CpXegFDS+PUBubHf/zVqTacd/8M6PcyeLVXBwqYUMxgTfc7Lg
         o9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqwVvCJOAKtjwcxw1Pml0e6Q0XaPRGK85WMsQybHM27W8apzJuUS+ADYJcoUkCeUcvoartnpyw71v0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1SNgS0g13ROWfwKt0y5O1jMmQCm6ix2AZWMwFr3Mzs3Rk0y1T
	S/Ki0+k3ffPP0pv/cDrtOG87Ulia9HRDab4Wh9c9tg7EGFLoA5DOR1EqXH72f5xM/stNDFUnXvi
	cVISQjRGubY55kgVNjxvy4ILiRLU+KazZgVboHUD2pyEGAqW+LIB3aMmmIR73JZc=
X-Gm-Gg: ASbGncsxxnmUhAeQWL0XNcBiiqxq+AjNM4dfauLLMmTBSPHbe2nagFMiPbYBfloxCQj
	+aIy5ES64ioG5o37bFMHUEBGSwSBdtt9yItv6vYDez4INnmkdEhJCgqe9GA3JzgEK0/j2MCWi9w
	AzGPdpqYwo3xhoeHMC/1FCSnzStPk3340MzAvkcWz+PYBQSd5twV9mHD5mpLJ6hR6OZCVgCDvnZ
	c8iz0FUr9AXXqQIsPmrvMvAf9/o/QO+9cX0mDiYPkMILRahSXLVosUKbWSN6TXrWJfDc7wP/RaV
	bkItFOr3ZzBMIekUM48osUoyd3uUWWQgl5nSbhTjdsurPVJPY59Vo5VEsIg4WaLPXPvJNbDP+rP
	TSqIL2cctpw==
X-Received: by 2002:a05:6a00:39a3:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-78c98d2e6aemr1700835b3a.1.1759451537521;
        Thu, 02 Oct 2025 17:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWEEgYNq3YMaGCew9+gs61ruTR+Mw3AELcBoDCygoa6FdJ8RVNCdO/U7t0LGX7nViXA3ZUSQ==
X-Received: by 2002:a05:6a00:39a3:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-78c98d2e6aemr1700792b3a.1.1759451537135;
        Thu, 02 Oct 2025 17:32:17 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074654sm3236692b3a.75.2025.10.02.17.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:32:16 -0700 (PDT)
Message-ID: <ef45ce3a-7a78-45c8-8196-75923af7c6ab@redhat.com>
Date: Fri, 3 Oct 2025 10:32:04 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/29] arm64: kconfig: Add Kconfig entry for MPAM
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
 <20250910204309.20751-6-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> The bulk of the MPAM driver lives outside the arch code because it
> largely manages MMIO devices that generate interrupts. The driver
> needs a Kconfig symbol to enable it. As MPAM is only found on arm64
> platforms, the arm64 tree is the most natural home for the Kconfig
> option.
> 
> This Kconfig option will later be used by the arch code to enable
> or disable the MPAM context-switch code, and to register properties
> of CPUs with the MPAM driver.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> CC: Dave Martin <dave.martin@arm.com>
> ---
> Changes since v1:
>   * Help text rewritten by Dave.
> ---
>   arch/arm64/Kconfig | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>




