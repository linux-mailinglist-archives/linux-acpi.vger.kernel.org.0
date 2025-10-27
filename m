Return-Path: <linux-acpi+bounces-18248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE2C0F602
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 17:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A9484FB094
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B675317704;
	Mon, 27 Oct 2025 16:33:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C0316918;
	Mon, 27 Oct 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582804; cv=none; b=tVXYCTf7zrhwxQn/wdycNycYO25IZbkeRzfVtCB8QQgL9AtjrRVWcLlHloWDWkt8Ey2X0hgUvN8zCw5+KoALJqhFHTDn1gcMiWrGqOM/viu2jS3IZYhmHRvLJQ4QM6dTz70G2m5Mq4YQbn1HRuSEAszwp8vOvLZDCaYYUgc3xBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582804; c=relaxed/simple;
	bh=XDOjvRcPSnqlNPNSFNOMfSTBKGcACSV8dNB+v6CXk3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb19AZdY5ruEaVZf3Xa3sU5OVGi3wbG3ypxbS22Ji3QdFF2irjB7xoa5Rj6OpBB+keN5ZCteseDhj05qs42V0OPrzaCNyIP+hqKzKia1ahSIh7pRI3iT9dp9SomlwM3lNUQIF66ZUw8r+2U0Le1ntSPR2G9GemsExInhdpsnGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2ABD169E;
	Mon, 27 Oct 2025 09:33:13 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B4C73F63F;
	Mon, 27 Oct 2025 09:33:16 -0700 (PDT)
Message-ID: <6380b1a2-45ea-4a7f-a1db-81d92442fca8@arm.com>
Date: Mon, 27 Oct 2025 16:33:14 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 James Morse <james.morse@arm.com>
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-10-james.morse@arm.com>
 <20251024183228.00005a64@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251024183228.00005a64@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James, Jonathan,

On 10/24/25 18:32, Jonathan Cameron wrote:
> On Fri, 17 Oct 2025 18:56:25 +0000
> James Morse <james.morse@arm.com> wrote:
> 
>> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
>> (MSCs) with an identity/configuration page.
>>
>> Add the definitions for these registers as offset within the page(s).
>>
>> Link: https://developer.arm.com/documentation/ihi0099/latest/
> 
> I can't figure out how to get a stable link when there is only
> one version.  If possible would be good to use one.
> 
> I guess it probably doesn't matter unless someone renames things as
> you only have as subset of the fields currently there for some registers.
> 
https://developer.arm.com/documentation/ihi0099/aa/

This link has the version, A.a, at the end so should be stable. I found
this by visiting an unknown version,
https://developer.arm.com/documentation/ihi0099/unknown/, and seeing
where it redirects.

Thanks,

Ben

