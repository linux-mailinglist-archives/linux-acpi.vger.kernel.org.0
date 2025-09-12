Return-Path: <linux-acpi+bounces-16713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39199B54B42
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F3517140B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562CC3009FC;
	Fri, 12 Sep 2025 11:42:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4814441C62;
	Fri, 12 Sep 2025 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677347; cv=none; b=Y/Hqk13XmhDMQ4UP/nIQ8ez6nywySYGxGKArysbChPboftM6Iw7vGVX9hRA7owFXu8oSzclg37Yk4i9CAs8fxdotU1CKCZ/ssjZWP4GlyTSx/MxHK/jVYCP5bVKibj27WVS7gXxwPFA1YO0zXTZ3NlEaU1AUG/5ySaki696vENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677347; c=relaxed/simple;
	bh=Nce4M5Uob+uKbWUiwuuOIZjfNSwB8qg0u6HvK4qFifM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odrBX4JOW2JmBHtbMbbinmGkd3Q8g0ypiVu4xk1rHcqnqYibxDAOFgko3BNPYXQ0XOr7eFlda3twZQ0O6dJmCqZZK+Y33I4CdmJI9TD1FeMVYD6zLwQwXAdT/xwfFSjn8gedVr/szgATz/vGjkZ+OdQlH+pe3YaaJGfLL4CCC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41EA516A3;
	Fri, 12 Sep 2025 04:42:16 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 133E53F63F;
	Fri, 12 Sep 2025 04:42:19 -0700 (PDT)
Message-ID: <9fa1b584-130b-45b0-9dba-8e046e643bf0@arm.com>
Date: Fri, 12 Sep 2025 12:42:18 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/29] arm_mpam: Extend reset logic to allow devices to
 be reset any time
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
 <20250910204309.20751-18-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-18-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
> cpuhp callbacks aren't the only time the MSC configuration may need to
> be reset. Resctrl has an API call to reset a class.
> If an MPAM error interrupt arrives it indicates the driver has
> misprogrammed an MSC. The safest thing to do is reset all the MSCs
> and disable MPAM.
> 
> Add a helper to reset RIS via their class. Call this from mpam_disable(),
> which can be scheduled from the error interrupt handler.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * more complete use of _srcu helpers.
>  * Use guard macro for srcu.
>  * Dropped a might_sleep() - something else will bark.
> ---
>  drivers/resctrl/mpam_devices.c | 56 ++++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index e7faf453b5d7..a9d3c4b09976 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -842,8 +842,6 @@ static int mpam_reset_ris(void *arg)
>  	u16 partid, partid_max;
>  	struct mpam_msc_ris *ris = arg;
>  
> -	mpam_assert_srcu_read_lock_held();
> -

Remove where it is introduced. There is already one in
mpam_reset_ris_partid() at that time.

>  	if (ris->in_reset_state)
>  		return 0;

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


