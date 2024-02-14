Return-Path: <linux-acpi+bounces-3480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC1854CC0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 16:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552F0B27690
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829B5CDC7;
	Wed, 14 Feb 2024 15:29:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC3604BA;
	Wed, 14 Feb 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924561; cv=none; b=fXs1C6zmLTaBBzNTsKMQUq0T4CZ5zbv45jz28Ei0IjIE2fVWTtytGkCl1VN+NqxxebQoTp74ROeHVFQw9VMBaMECL9fh287JUtZn276Dk+SlScdo5LSBtEvnUDjbyCVWP7N90GThrfVLjiAiI3yMvFAXWccJ2Q/OHLHwsW/QNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924561; c=relaxed/simple;
	bh=1TsPH1sLQurbavtvAvvhWNyFd/8ypWYtsWQjtzGfGvs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oa37v6AiefbCsyoKHiegQiCqBLAVeIUKrfAny+FdH2Vc4dYSG7QS9mWMns7SUyb0mAnvS+9cYl6iFy1tXO5PPXqKtcnUFeULPtLgAZ+1zKjgz25op2YAiSSIBhgQpQlb0gjgHKfVSSYVhjD4EoxmfIFn8r8GGyHX+o+0hbMnGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZhpl2ygZz67P7J;
	Wed, 14 Feb 2024 23:25:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C23C0140B2A;
	Wed, 14 Feb 2024 23:29:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:29:16 +0000
Date: Wed, 14 Feb 2024 15:29:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 4/4] EINJ, Documentation: Update EINJ kernel doc
Message-ID: <20240214152915.00003791@Huawei.com>
In-Reply-To: <20240208200042.432958-5-Benjamin.Cheatham@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
	<20240208200042.432958-5-Benjamin.Cheatham@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 8 Feb 2024 14:00:42 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Update EINJ kernel document to include how to inject CXL protocol error
> types, build the kernel to include CXL error types, and give an example
> injection.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index d6b61d22f525..f179adf7b61c 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -181,6 +181,25 @@ You should see something like this in dmesg::
>    [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
>    [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
>  
> +CXL error types are supported from ACPI 6.5 onwards. These error types
> +are not available in the legacy interface at /sys/kernel/debug/apei/einj,
> +and are instead at /sys/kernel/debug/cxl/. There is a file under debug/cxl
> +called "einj_type" that is analogous to available_error_type under debug/cxl.
> +There is also a "einj_inject" file in each $dport_dev directory under debug/cxl
> +that will inject a given error into the dport represented by $dport_dev.
> +For example, to inject a CXL.mem protocol correctable error into
> +$dport_dev=pci0000:0c::
> +
> +    # cd /sys/kernel/debug/cxl/
> +    # cat einj_type                 # See which error can be injected
> +	0x00008000  CXL.mem Protocol Correctable
> +	0x00010000  CXL.mem Protocol Uncorrectable non-fatal
> +	0x00020000  CXL.mem Protocol Uncorrectable fatal
> +    # cd 0000:e0:01.1               # Navigate to dport to inject into
> +    # echo 0x8000 > einj_inject     # Inject error
> +
> +To use CXL error types, ``CONFIG_CXL_EINJ`` will need to be enabled.
> +
>  Special notes for injection into SGX enclaves:
>  
>  There may be a separate BIOS setup option to enable SGX injection.


