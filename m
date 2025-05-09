Return-Path: <linux-acpi+bounces-13655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCFAB0726
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 02:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E9B7BB951
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957671B7F4;
	Fri,  9 May 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GeHURCqy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4E1802B;
	Fri,  9 May 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751351; cv=none; b=p+l9MzZySmWH6Vun/nkR6H2sB32CE2b1tBB3hEXSkjCVmJpAX9LQb1PunSGXXlCg9ZvFsuaFccKwboe1rUULfWFFfw/UEmz5isnUPf/3Pf46ywOukBZ0mID2JAVrp5LNFQiuRSm8IbENF6L09K/dVpuPWqdyEosmZqI8kQH19F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751351; c=relaxed/simple;
	bh=PRRpLihiyKbV/Sfm7nAyauKWja5MC4KYGOEp5dMFOPU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BGx/fRVMknVc7i2WIPZzMK7XjWm20VwL9k38SSbDi14qIOXHbohDJIVHXRO5raiK0PRUj+n2P/BNMM8Y2mlxiHsb/w3e0UQ22gOqeNLMLfWGHfqHI+NY7a1+d3/HmkUCGmyradMCF1gAlfNsNIMEPqwYZMkoCLQEsEVd6UVC8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GeHURCqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715CEC4CEED;
	Fri,  9 May 2025 00:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746751351;
	bh=PRRpLihiyKbV/Sfm7nAyauKWja5MC4KYGOEp5dMFOPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GeHURCqy78rgaPH336N7O9DR2zC7Dw3upYbA5PXTkE3c9yrNHxYhi+rlndDY1nj01
	 Cs/isfb6y6BJask44SKtR4DoFzv1HGXitOByXCwXPBESsszgnZ2pSxTUoqw5WdJIJx
	 yDmSt6Fy7MdG77SX11Re/PiIMGvbjh/GlTUS2YtY=
Date: Thu, 8 May 2025 17:42:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, rppt@kernel.org,
 rafael@kernel.org, lenb@kernel.org, alison.schofield@intel.com,
 rrichter@amd.com, bfaccini@nvidia.com, haibo1.xu@intel.com,
 david@redhat.com, chenhuacai@kernel.org, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, chenbaozi@phytium.com.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: introduce
 numa_add_reserved_memblk
Message-Id: <20250508174229.c310803222405c1b7d60e104@linux-foundation.org>
In-Reply-To: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>
References: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 10:27:19 +0800 Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> with the expectation that numa_cleanup_meminfo moves them to
> numa_reserved_meminfo. There is no need for that indirection when it is
> known in advance that these unpopulated ranges are meant for
> numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> 
> Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> ranges directly.
> 
> ...
>
>  drivers/acpi/numa/srat.c     |  2 +-
>  include/linux/numa_memblks.h |  1 +
>  mm/numa_memblks.c            | 22 ++++++++++++++++++++++

I'm not sure which tree this best belongs to so I'll add it to mm-git. 
If it later pops up in another tree, I'll drop it again.

