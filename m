Return-Path: <linux-acpi+bounces-9779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A539D9B29
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Nov 2024 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4B32834B1
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Nov 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9F1D8DE8;
	Tue, 26 Nov 2024 16:16:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0761CEE97;
	Tue, 26 Nov 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637792; cv=none; b=GQ0+x64D/rB2Z+uGuNquM5HbTb0ds2FzWVcoFMLMMbmThvnQakaoqxXJmAszsTHzl6cB804O90iyjOmPhFXxjwbEYUuOnp6DCONuk+OtJTYDawK3/stdrJ3FgqkIIKqvAS5i1iDsed469tbQYtVgG+cgfLvfF9J7XakQlRruTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637792; c=relaxed/simple;
	bh=paL6g4pC2MVm4F+/2PNasT3FTs3a3sMdADtZXvVHfU4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xmv+p83QGPax6Mu4CPxicLAWlTI5Q2Z2iBgHEaDVdaC7e4mR/2EUHNGzkQ7fWJS1cCP5/CEv1nc2W8u4x97H1cG99TaMH+COdTGzXw1czST15cOVe+tAwN4Xd/9OVIk49jmV19M30Yc3ledKb7R4l0KRhYQ7ef8eBQsB0VtKrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XySLP6V3dz6K5kc;
	Wed, 27 Nov 2024 00:13:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E5D4140A9C;
	Wed, 27 Nov 2024 00:16:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 17:16:23 +0100
Date: Tue, 26 Nov 2024 16:16:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 1/5] acpi: numa: Add support to enumerate and
 store extended linear address mode
Message-ID: <20241126161622.00005ee8@huawei.com>
In-Reply-To: <20241112221335.432583-2-dave.jiang@intel.com>
References: <20241112221335.432583-1-dave.jiang@intel.com>
	<20241112221335.432583-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 15:12:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Store the address mode as part of the cache attriutes. Export the mode
> attribute to sysfs as all other cache attributes.
> 
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
One trivial suggestion that I don't care that much about.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> - Fix spelling errors (Jonathan)
> - Change UNKNOWN to RESERVED (Jonathan)
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 6 ++++++
>  drivers/acpi/numa/hmat.c                    | 3 +++
>  drivers/base/node.c                         | 2 ++
>  include/linux/node.h                        | 7 +++++++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 402af4b2b905..725ef0e1e01f 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -177,6 +177,12 @@ Description:
>  		The cache write policy: 0 for write-back, 1 for write-through,
>  		other or unknown.
>  
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/mode

Mode feels perhaps a bit to vague.  Maybe address_mode?

> +Date:		September 2024
> +Contact:	Dave Jiang <dave.jiang@intel.com>
> +Description:
> +		The address mode: 0 for reserved, 1 for extended-linear.
> +
>  What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
>  Date:		November 2021
>  Contact:	Jarkko Sakkinen <jarkko@kernel.org>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1a902a02390f..39524f36be5b 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -506,6 +506,9 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
>  	case ACPI_HMAT_CA_DIRECT_MAPPED:
>  		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> +		/* Extended Linear mode is only valid if cache is direct mapped */
> +		if (cache->address_mode == ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR)
> +			tcache->cache_attrs.mode = NODE_CACHE_MODE_EXTENDED_LINEAR;
>  		break;
>  	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
>  		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;


