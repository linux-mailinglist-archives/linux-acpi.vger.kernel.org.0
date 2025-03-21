Return-Path: <linux-acpi+bounces-12397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB895A6BA21
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 12:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3036419C3D04
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6536E22256A;
	Fri, 21 Mar 2025 11:51:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02F1F1527;
	Fri, 21 Mar 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557886; cv=none; b=TUtwlUMuNm4vHEx7PNVsmZ+1iOoKH4fs9RSrYO+mK4S3RCPXqGyhVmyvbYSTX+zCL0P776E9eFrlnmM2NnBy+jBM3hLqL60zKTuhY5K+bBVrrN4usObj+c2m9TFlqvsU5GyeEJTGaI3LXKtz0a77pZ6rytu7ZWqQLBDIiq3Nzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557886; c=relaxed/simple;
	bh=cJQdPbTENqwfzCdZ3nU/RfZHDS7Nm9ApYOpbKbTKEK8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lppVfDeIybtEVCe/UiPUhpYfXHsxI66Yi5NexoTBeNbCERQcHAsol5wt66UOpd5vRzOnj4z3xOrQrTMy3JIh5yfe4sxcyu+68i9ObTsdymSC47/AOTGfNuwsmq1KCmnveG0WchAFQhU37FVeSUHzZ/2fFj/qy1C0thkbo7EfCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK10Y0RDFz6M4qh;
	Fri, 21 Mar 2025 19:47:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7392A140517;
	Fri, 21 Mar 2025 19:51:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 12:51:17 +0100
Date: Fri, 21 Mar 2025 11:51:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dan.j.williams@intel.com>, <rppt@kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <bfaccini@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rrichter@amd.com>,
	<haibo1.xu@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenbaozi@phytium.com.cn>
Subject: Re: [RFC PATCH v3 2/2] ACPI: NUMA: debug invalid unused PXM value
 for CFMWs
Message-ID: <20250321115116.00007ae7@huawei.com>
In-Reply-To: <20250321023602.2609614-3-wangyuquan1236@phytium.com.cn>
References: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
	<20250321023602.2609614-3-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 21 Mar 2025 10:36:02 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> The absence of SRAT would cause the fake_pxm to be -1 and increment
> to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
> ranges that are defined in the CFMWS and not already defined in the
> SRAT, the new node (node0) for the CXL memory would be invalid, as
> node0 is already in "used", and all CXL memory might be online on
> node0.
> 
> This utilizes node_set(0, nodes_found_map) to set pxm&node map. With
> this setting, acpi_map_pxm_to_node() could return the expected node
> value even if no SRAT.
> 
> If SRAT is valid, the numa_memblks_init() would then utilize
> numa_move_tail_memblk() to move the numa_memblk from numa_meminfo to
> numa_reserved_meminfo in CFMWs fake node situation.

I would call out that numa_move_tail_memblk() is called in
numa_cleanup_meminfo() which is indeed called by num_memblks_init()

> 
> If SRAT is missing or bad, the numa_memblks_init() would fail since
> init_func() would fail. And it causes that no numa_memblk in
> numa_reserved_meminfo list and the following dax_cxl driver could
> find the expected fake node.
> 
> Use numa_add_reserved_memblk() to replace numa_add_memblk(), since
> the cxl numa_memblk added by numa_add_memblk() would finally be moved
> to numa_reserved_meminfo, and numa_add_reserved_memblk() here could
> add cxl numa_memblk into reserved list directly. Hence, no matter
> SRAT is good or not, cxl numa_memblk could be allocated to reserved
> list.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

This definitely wants input from Mike Rapoport.
Looks fine to me, but there may be some subtle corners I'm missing.


> ---
>  drivers/acpi/numa/srat.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..50bfecfb9c16 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -458,11 +458,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		return -EINVAL;
>  	}
>  
> -	if (numa_add_memblk(node, start, end) < 0) {
> +	if (numa_add_reserved_memblk(node, start, end) < 0) {
>  		/* CXL driver must handle the NUMA_NO_NODE case */
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
>  	}
> +

Unrelated change.  Always give patches a final look through to spot
things like this.  Trivial, but they all add noise to what we are focusing on.

>  	node_set(node, numa_nodes_parsed);
>  
>  	/* Set the next available fake_pxm value */
> @@ -646,8 +647,12 @@ int __init acpi_numa_init(void)
>  		if (node_to_pxm_map[i] > fake_pxm)
>  			fake_pxm = node_to_pxm_map[i];
>  	}
> -	last_real_pxm = fake_pxm;
> -	fake_pxm++;
> +
> +	/* Make sure CFMWs fake node >= 1 */
> +	fake_pxm = max(fake_pxm, 0);
> +	last_real_pxm = fake_pxm++;
> +	node_set(0, nodes_found_map);
> +
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
>  			      &fake_pxm);
>  


