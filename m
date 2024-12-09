Return-Path: <linux-acpi+bounces-10016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A59E8D85
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 09:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A98188094B
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D312CDAE;
	Mon,  9 Dec 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="c1vsOrD+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA221519E;
	Mon,  9 Dec 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733184; cv=pass; b=F6guPtc4QJ4gvpa2/7H0J8RTDV5+bm/5eaWB+6YaBHHA4+LBpn0nPNcYV9J9rr1wLTd3e6lyckKWkLcHJZwqmy1T0Gf20oWHYFguFEroCSd2QKSdcboF1OKM11srGehpTRyOoYdLOY4Tt9QSYrvY4nr9/M61jXdz/MSDqeiTim4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733184; c=relaxed/simple;
	bh=BWiJKufzv/F7esxI+0lHufeZPNgmfwU233MI1GEovmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGxfwhA69wdl1r7/7G4Pcps+Pm1BNiTjvoBFf6aBUT9KlRfs52N6Nye/TzUhuPDoz0nzCjRu0yofXrMuvNZS0fZzN7kEBbVPzWiLWbH7Hqya2f3YcmLX0+5uVdaGsruXXDBgOS9oHtzrSIZLBNhzj1kOUcxf/ZkG9NSCa/TYbog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=c1vsOrD+; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1733733164; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H/fhrr/k8GWNRA4j4ja9ejP7VoLCIo826F8CbVEZXTC/RslpL7S8neD4RTHceQ6WRePjSq/NFXCqr3ReEGPeBj0hWyxfPDzeFWYsLCHrMuNM+HP+07s0PbK29V/vduqNURKLIWX/U9uUIgDgtPbY8LOKrY8b/YS7YDW7pgwHV58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733733164; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=exzAwh9vuJJZYKGFl8F6lLjMefg+m9szNye3qUBtaAc=; 
	b=VJz7ap91Jv1tZGHhGkL/V9odlBBShxRp1FlYThX/DkzkYH8Qcn9UiViLKlII8TBwRPMOmIb8o6MmNjjsWkRbxkQItWEb5APz2XnS5Hah6mCRL7VKV5V4hYgQxRvD5LVKmRaQIWObJ4OSUGlq5y11/Yghy/HMZ04W7cnCCOQbTVg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733733164;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=exzAwh9vuJJZYKGFl8F6lLjMefg+m9szNye3qUBtaAc=;
	b=c1vsOrD+vgyNQ5MknKxN7uWc/fH6Blq/EGI1v7vUKqPladXPpZOhFHm1J+hvg4F3
	Xtc2e4It4yRhp+mOR6WxZ23up3ywe0a5GWPCtBGAceHBxtMmNMyhZO0RI2STnRtUKr5
	nTiD9BLsA2rwrtAxfVJHLLx/ImGW8YgSLGHycdmA=
Received: by mx.zohomail.com with SMTPS id 1733733160909206.39109231527607;
	Mon, 9 Dec 2024 00:32:40 -0800 (PST)
Message-ID: <abdb787d-81a7-47a7-8ee4-da250aa5355d@zohomail.com>
Date: Mon, 9 Dec 2024 16:32:37 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] acpi/hmat / cxl: Add extended linear cache support
 for CXL
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com
References: <20241204224827.2097263-1-dave.jiang@intel.com>
 <20241204224827.2097263-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20241204224827.2097263-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227a39993a97540f2f7e4ef51c500005204a570abc3fd60156e35d552ac1a2388ce84b2080ad5ecbf:zu08011227162f4444b4f8d1a06fa95fc40000b63ce1a267dc4665fcc2eb3eb1de176d292df0fcc9e8de197f:rf0801122be3d9be6dc1a89891f866334000000d425160fff8b5bb21c9653fe282a635afd757d8628f32eb1d654a72f0:ZohoMail
X-ZohoMailClient: External

On 12/5/2024 6:46 AM, Dave Jiang wrote:
> The current cxl region size only indicates the size of the CXL memory
> region without accounting for the extended linear cache size. Retrieve the
> cache size from HMAT and append that to the cxl region size for the cxl
> region range that matches the SRAT range that has extended linear cache
> enabled.
>
> The SRAT defines the whole memory range that includes the extended linear
> cache and the CXL memory region. The new HMAT ECN/ECR to the Memory Side
> Cache Information Structure defines the size of the extended linear cache
> size and matches to the SRAT Memory Affinity Structure by the memory
> proxmity domain. Add a helper to match the cxl range to the SRAT memory
> range in order to retrieve the cache size.
>
> There are several places that checks the cxl region range against the
> decoder range. Use new helper to check between the two ranges and address
> the new cache size.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> RFC:
> - Minor refactors (Jonathan)
> - Fix grammar (Jonathan)
> ---
>  drivers/acpi/numa/hmat.c  | 39 ++++++++++++++++++++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/acpi.c   | 11 ++++++
>  drivers/cxl/core/core.h   |  3 ++
>  drivers/cxl/core/region.c | 70 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  2 ++
>  include/linux/acpi.h      | 19 +++++++++++
>  tools/testing/cxl/Kbuild  |  1 +
>  8 files changed, 142 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/cxl/core/acpi.c
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 976b3e1a6c2a..1c5b3c37ac29 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -108,6 +108,45 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>  	return NULL;
>  }
>  
> +/**
> + * hmat_get_extended_linear_cache_size - Retrieve the extended linear cache size
> + * @backing_res: resource from the backing media
> + * @nid: node id for the memory region
> + * @cache_size: (Output) size of extended linear cache.
> + *
> + * Return: 0 on success. Errno on failure.
> + *
> + */
> +int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
> +					resource_size_t *cache_size)
> +{
> +	unsigned int pxm = node_to_pxm(nid);
> +	struct memory_target *target;
> +	struct target_cache *tcache;
> +	struct resource *res;
> +
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return -ENOENT;
> +
> +	list_for_each_entry(tcache, &target->caches, node) {
> +		if (tcache->cache_attrs.address_mode ==
> +				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR)
> +			continue;

Should continue only when "tcache->cache_attrs.address_mode" is NOT "NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR"?

[snip]

> +static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> +					    struct resource *res)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int nid = phys_to_target_node(res->start);
> +	resource_size_t size, cache_size;
> +	int rc;
> +
> +	size = resource_size(res);
> +	if (!size)
> +		return -EINVAL;
> +
> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> +	if (rc)
> +		return rc;
> +
> +	if (!cache_size)
> +		return 0;
> +
> +	if (size != cache_size) {
> +		dev_warn(&cxlr->dev, "Extended Linear Cache is not 1:1, unsupported!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * Move the start of the range to where the cache range starts. The
> +	 * implementation assumes that the cache range is in front of the
> +	 * CXL range. This is not dictated by the HMAT spec but is how the
> +	 * current known implementation is configured.
> +	 */
> +	res->start -= cache_size;
> +	p->cache_size = cache_size;
> +
> +	return 0;
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3256,6 +3306,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
> +	rc = cxl_extended_linear_cache_resize(cxlr, res);
> +	if (rc) {
> +		/*
> +		 * Failing to support extended linear cache region resize does not
> +		 * prevent the region from functioning. Only cause cxl list showing
> +		 * incorrect region size.
> +		 */
> +		dev_warn(cxlmd->dev.parent,
> +			 "Failed to support extended linear cache.\n");
> +	}
> +

cxl_extended_linear_cache_resize() will adjust res->start if there is an available cache_size.

Is it possible that below insert_resource() failed because "res->start" is less than "cxlrd->res->start"?

My understanding is that the address range of cxlrd->res comes from CFMWS, I don't find any description in patchset about the address range defined in CFMWS including extended linear cache size. So I guess that a CFMWS will not expose a address range with extended linear cache size?

I'm studying this patchset, please correct me if I'm wrong. Thank you.

>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
[snip]

Ming


