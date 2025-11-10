Return-Path: <linux-acpi+bounces-18737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8EDC47DFA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C07B84EDB2A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE2E276041;
	Mon, 10 Nov 2025 16:07:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33127586C;
	Mon, 10 Nov 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790832; cv=none; b=Bx8VxYItdbbIvqPUlx/rwjYrq+4DnE/vuYMV6B6gjfZnF9MHxCCFEXAhq76YKLmk353V+xbC4PDY+PPtfvvNX1YcAn+DRaOcSuhQ1geIjXgUNC+i//BmrZ4prqsURdVRD8bT4iaggvX0sbwdViJRCBcVq9WnZpJN2y/f8O76Z/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790832; c=relaxed/simple;
	bh=27EsfNgxEBEVFQ27RkKtff0JAT6UJpl26AOBpOldN38=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ykkp7Hm52M8/wDKo5hqyWht0Skh5ueB2rTjt4XOV4Z9fY0kp0NeoYYqtIMYPYzIkQVNxsQk7QyUXpTBv9KAYsO3RxlXbfgwgiGo+JP0HQHbqmqo2/Efv/05orI/hRXSscIpuEQVG5XxOup6PV5Dj7rc66M9Yw0PU29N8JUU6MP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4vg25B99zJ46dN;
	Tue, 11 Nov 2025 00:06:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3350D14033C;
	Tue, 11 Nov 2025 00:07:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 16:07:06 +0000
Date: Mon, 10 Nov 2025 16:07:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
Subject: Re: [PATCH 07/33] platform: Define platform_device_put cleanup
 handler
Message-ID: <20251110160705.00007387@huawei.com>
In-Reply-To: <20251107123450.664001-8-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-8-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 7 Nov 2025 12:34:24 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

> Define a cleanup helper for use with __free to destroy platform devices
> automatically when the pointer goes out of scope. This is only intended to
> be used in error cases and so should be used with return_ptr() or
> no_free_ptr() directly to avoid the automatic destruction on success.
> 
> A first use of this is introduced in a subsequent commit.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

I'm fine with this but probably needs a tag from Greg KH.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  include/linux/platform_device.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 074754c23d33..23a30ada2d4c 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
>  extern int platform_device_add(struct platform_device *pdev);
>  extern void platform_device_del(struct platform_device *pdev);
>  extern void platform_device_put(struct platform_device *pdev);
> +DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))
>  
>  struct platform_driver {
>  	int (*probe)(struct platform_device *);


