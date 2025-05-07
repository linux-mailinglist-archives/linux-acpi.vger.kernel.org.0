Return-Path: <linux-acpi+bounces-13518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA19AAD2F5
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 03:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191994E1F84
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFEC156228;
	Wed,  7 May 2025 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uvDxH9sr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE41494DB;
	Wed,  7 May 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582947; cv=none; b=ZQfhxnrd1QB4cGkvRbORAX/Lw4tPWC3EVV8UlhncjxBT/5qJdlx4oNlW/Yqjhy7IXkuSFyeM1xK/H+hGYkIhzqhjGQwsGKzM32x1hdNWtEaEkhnc7H2dtrYpjwFQ/JYgTxC26GIeoeLdXUMHEBxJwEKEpRXzncam4lis+ALPpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582947; c=relaxed/simple;
	bh=2+lbSUn+6EptwsYwH2exuhL/iZeeYCz00kRKMGS1vuY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=alKPEbSCancdh2dqhgnn2xKFbtc1fGuNstsQ+6T2NAC1QJHVO6q0VuXLn/PC/1XeyZWnfE0qjsoizBgYwUp27SKbVvjl8MqJRlGsyuaH/KAyMW/c5YEx+RQp15ffX8kiUdk9otq+CAKavBlHd0a53DJY/qZIalRXQyx2MrGh34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uvDxH9sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB58C4CEE4;
	Wed,  7 May 2025 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746582945;
	bh=2+lbSUn+6EptwsYwH2exuhL/iZeeYCz00kRKMGS1vuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uvDxH9sr+HD0nbtIYkteIYrfNShEftDgUCzEe+rMCtAPa/oxs5AnZUD9NL0rMTpik
	 gM8qBwIz/FSjH3Vfgqskh88O33BCynGu9CloCCLf9CH+E4VCbKPR1WKahR0io4VT6R
	 qv8aX7VMXupOioWlrxpnPJB+vGGFs7RhcUO9QtgY=
Date: Tue, 6 May 2025 18:55:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, rppt@kernel.org,
 rafael@kernel.org, lenb@kernel.org, alison.schofield@intel.com,
 rrichter@amd.com, bfaccini@nvidia.com, haibo1.xu@intel.com,
 david@redhat.com, chenhuacai@kernel.org, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, chenbaozi@phytium.com.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-Id: <20250506185544.474d025e43ebadadaedb982a@linux-foundation.org>
In-Reply-To: <20250506062245.3816791-1-wangyuquan1236@phytium.com.cn>
References: <20250506062245.3816791-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 May 2025 14:22:45 +0800 Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> with the expectation that numa_cleanup_meminfo moves them to
> numa_reserved_meminfo. There is no need for that indirection when it is
> known in advance that these unpopulated ranges are meant for
> numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> 
> Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> ranges directly.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
> 
> Changes in v2 (Thanks to Dan & Alison):
> - Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
> - Add comments to describe the usage of numa_add_reserved_memblk()
> - Updating the commit message to clarify the purpose of the patch
> 
> By the way, "LoongArch: Introduce the numa_memblks conversion" is in linux-next.

So is this patch dependent upon "LoongArch: Introduce the numa_memblks
conversion"?

