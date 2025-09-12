Return-Path: <linux-acpi+bounces-16754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67BB5546B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3897FAA7C2D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAC530E83D;
	Fri, 12 Sep 2025 16:06:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B138FA3;
	Fri, 12 Sep 2025 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693187; cv=none; b=iUOjBKebCRtJTGRNXndkDuBDhuleiWyjCgr70NwFQ6LzT59j6vKDrw7WvCyX85TqfQJFC7vtm4uV/zoB07XL5cXFLfLExrPbjjQaz8kUwmcYuEY0APOeiCjckGggaw2hnh/idLhB89ESbWbRM0nLH6jMqTp0ksQ1yR8lGZ7takU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693187; c=relaxed/simple;
	bh=KiVbFQLdHz8BS0bRrUCob+/HD9EfIXeRXBadlosIlbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxlNoUN8641o2owIhioQhsPuqQYbCn7ruEifogmmSDan435CDKyghT7uk042Y4ToyyaRFJOk9oujqeQXUtfQL6dXccaIl7o1tZ8ObIy1aNr6wY62mfeAwd7ynONmx6U4x5MWXTlJrIb7ZafnIjbxu3YDUW1IC6cu9mra3H9bed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E28B31515;
	Fri, 12 Sep 2025 09:06:16 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DEF83F66E;
	Fri, 12 Sep 2025 09:06:19 -0700 (PDT)
Message-ID: <848050b3-65d7-4caf-b093-7145eb782a7c@arm.com>
Date: Fri, 12 Sep 2025 17:06:18 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/29] arm_mpam: Add kunit test for bitmap reset
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
 <20250910204309.20751-29-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-29-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:43, James Morse wrote:
> The bitmap reset code has been a source of bugs. Add a unit test.
> 
> This currently has to be built in, as the rest of the driver is
> builtin.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/Kconfig             | 10 +++++
>  drivers/resctrl/mpam_devices.c      |  4 ++
>  drivers/resctrl/test_mpam_devices.c | 68 +++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 drivers/resctrl/test_mpam_devices.c
> 
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index c30532a3a3a4..ef59b3057d5d 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -5,10 +5,20 @@ menuconfig ARM64_MPAM_DRIVER
>  	  MPAM driver for System IP, e,g. caches and memory controllers.
>  
>  if ARM64_MPAM_DRIVER
> +

Nit: add the empty line in an earlier patch

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


