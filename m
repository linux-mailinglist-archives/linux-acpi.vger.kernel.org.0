Return-Path: <linux-acpi+bounces-17426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B876DBAA365
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD37174D52
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093D221F39;
	Mon, 29 Sep 2025 17:44:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061E221294;
	Mon, 29 Sep 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167895; cv=none; b=tNYHMRPFtYL/QZ8NL0Ij9uaBdIlKO/X50Qcvz/o/wtP7WPWHF7UNFypDSVV/eCGFyF5ssjPQVPEzs0Y08UeV1sZWte77EEX149S10UgmZ0OHm9LVaHpk+5Yyhv/WkVGG9wTec2krsoKYpQRo65BUvPNocWztCfuvKo767UNZ2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167895; c=relaxed/simple;
	bh=TuNTyOEkqxmexbhkuqqqh05QNas5QxF44cxuG5FL6wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubuHoWFsiPQKa/pCW49zSTaM/t/1A6P8qLCiPtRdpuvy7ei9WSVto70dLXJNtXO4hQhG6f6dCJzSc56eZQr2Ry57Q2cjuhivpxz7U1jNzIez8hEQbSAttx+7kFuMgg3obsjiPrwvv81lJesnBngtN3vOcAJe+BYnfXTCkw29Fsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53E271BCB;
	Mon, 29 Sep 2025 10:44:45 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C6903F59E;
	Mon, 29 Sep 2025 10:44:48 -0700 (PDT)
Message-ID: <d7447533-1261-4d9c-b8c9-0f0eded042e0@arm.com>
Date: Mon, 29 Sep 2025 18:44:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/29] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-13-james.morse@arm.com>
 <20250911162440.0000600b@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250911162440.0000600b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 11/09/2025 16:24, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 20:42:52 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
>> interrupt, and when taking an IPI to access these registers on platforms
>> where MSC are not accesible from every CPU. This makes an irqsave
>> spinlock the obvious lock to protect these registers. On systems with SCMI
>> mailboxes it must be able to sleep, meaning a mutex must be used. The
>> SCMI platforms can't support an overflow interrupt.
>>
>> Clearly these two can't exist for one MSC at the same time.
>>
>> Add helpers for the MON_SEL locking. The outer lock must be taken in a
>> pre-emptible context before the inner lock can be taken. On systems with
>> SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
>> will fail to be 'taken' if the caller is unable to sleep. This will allow
>> callers to fail without having to explicitly check the interface type of
>> each MSC.

> Comments talk about outer locks, but not actually seeing that in the current code.

Ugh - I squashed them all together because without the DT support the DT:SCMI support
ceases to be relevant, the ACPI PCC support isn't here yet, and Dave complained this
was complex. I forgot to rewrite the commit message!

The last paragraph is rewritten as:
------------%<------------
Add helpers for the MON_SEL locking. For now, use a irqsave spinlock and
only support 'real' MMIO platforms.

In the future this lock will be split in two allowing SCMI/PCC platforms
to take a mutex. Because there are contexts where the SCMI/PCC platforms
can't make an access, mpam_mon_sel_lock() needs to be able to fail. Do
this now, so that all the error handling on these paths is present. This
allows the relevant paths to fail if they are needed on a platform where
this isn't possible, instead of having to make explicit checks of the
interface type.
------------%<------------

It took invasive changes to make the control path safe for these firmware backed
platforms. I really don't want to 'simplify' it pretending they don't exist, to
then spend the following month retrofitting this.
I expect the firmware backed platforms to expose one or two global MSC, so they
should never hit a case where a mon_sel register access was sent via IPI.



Thanks,

James

