Return-Path: <linux-acpi+bounces-3546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8DA8569D2
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD701F225C4
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9231131731;
	Thu, 15 Feb 2024 16:44:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7D39FFA;
	Thu, 15 Feb 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015485; cv=none; b=D7E7sQYB7bWcXoYBEiwNhBvWJ/JX1MdFsxpsk1gKj/4H91iwTLPqE/4d7BNuNB/pJqD5nGE+1bGDmWKLKHNUiMiMqLs4HYfy6C8dBNkRncxbsvLPK9as61WoXWeJIIt5UPJYDKjVjz8baywuLtkkxuF3dqhXHYypPaUP2HIWD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015485; c=relaxed/simple;
	bh=nHcJ0GS2vv87ujxS7VPUtshCx0Bqby+0wTuCphL53Fw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOxBuQbsiUdEMCUyDqvu3Cej1PgvA0PsWz8f5AFUnDixM9nF2STEU6b5MS2fKGSqo7whGu2t/VUux0JgyvRR5hNC5F4VD3N+fHjWBc+glasfYh3K2U6JtIg3ZaydWjYhjGl5ghvc32TMMB4RRW65jb9A49TetzAGByw2CtJBgsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbLQq4jLZz6J9yd;
	Fri, 16 Feb 2024 00:40:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 773EE140682;
	Fri, 16 Feb 2024 00:44:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:44:38 +0000
Date: Thu, 15 Feb 2024 16:44:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 03/12] ACPI: HMAT: Introduce 2 levels of generic port
 access class
Message-ID: <20240215164437.00005f86@Huawei.com>
In-Reply-To: <20240206222951.1833098-4-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-4-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In order to compute access0 and access1 classes for CXL memory, 2 levels
> of generic port information must be stored. Access0 will indicate the
> generic port access coordinates to the closest initiator and access1
> will indicate the generic port access coordinates to the cloest CPU.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Grumble.  I never liked Memory Proximity Domain Attributes Structure.
Adds little value and for ports I don't think you should consider it
(because it's about GI or Processor to Memory connections and
 Generic Ports aren't allowed in either field).

Other than dropping that short cut, LGTM.

> ---
>  drivers/acpi/numa/hmat.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index e0144cfbf1f3..8dbb0e366059 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -59,7 +59,8 @@ struct target_cache {
>  };
>  
>  enum {
> -	NODE_ACCESS_CLASS_GENPORT_SINK = ACCESS_COORDINATE_MAX,
> +	NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL = ACCESS_COORDINATE_MAX,
> +	NODE_ACCESS_CLASS_GENPORT_SINK_CPU,
>  	NODE_ACCESS_CLASS_MAX,
>  };
>  
> @@ -141,7 +142,7 @@ int acpi_get_genport_coordinates(u32 uid,
>  	if (!target)
>  		return -ENOENT;
>  
> -	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT_SINK];
> +	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL];
>  
>  	return 0;
>  }
> @@ -695,7 +696,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
>  	int i;
>  
>  	/* Don't update for generic port if there's no device handle */
> -	if (access == NODE_ACCESS_CLASS_GENPORT_SINK &&
> +	if ((access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL ||
> +	     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
>  	    !(*(u16 *)target->gen_port_device_handle))
>  		return;
>  
> @@ -707,7 +709,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
>  	 */
>  	if (target->processor_pxm != PXM_INVAL) {
>  		cpu_nid = pxm_to_node(target->processor_pxm);
> -		if (access == ACCESS_COORDINATE_LOCAL ||
> +		if ((access == ACCESS_COORDINATE_LOCAL ||
> +		     access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL) &&
The comment above this says:
	/*
	 * If the Address Range Structure provides a local processor pxm, set
	 * only that one. Otherwise, find the best performance attributes and
	 * collect all initiators that match.
	 */

Assuming that is correct, under what circumstances is it relevant to a
generic port?  I'm hoping no one builds systems with RAM that is local to
a port?

Note that the comment requires some archaeology - the Address Range structure
has been renamed as Memory Proximity Domain Attributes Structure. (see ACPI 6.2)
And the 'local processor PXM was probably originally Processor Proximity Domain.
That has now become "Proximity Domain for the Attached Initiator." It's
used only basically override the HMAT distances and say:
Memory domain X is directly attached to Processor Y
Here we don't have a memory domain (generic port) and so I don't think that
case is relevant.

So leave this block alone.

>  		    node_state(cpu_nid, N_CPU)) {
>  			set_bit(target->processor_pxm, p_nodes);
>  			return;
> @@ -736,7 +739,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
>  		list_for_each_entry(initiator, &initiators, node) {
>  			u32 value;
>  
> -			if (access == ACCESS_COORDINATE_CPU &&
> +			if ((access == ACCESS_COORDINATE_CPU &&
> +			     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&

This one looks to be correct.

>  			    !initiator->has_cpu) {
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  				continue;
> @@ -775,7 +779,9 @@ static void hmat_update_generic_target(struct memory_target *target)
>  	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>  
>  	hmat_update_target_attrs(target, p_nodes,
> -				 NODE_ACCESS_CLASS_GENPORT_SINK);
> +				 NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL);
> +	hmat_update_target_attrs(target, p_nodes,
> +				 NODE_ACCESS_CLASS_GENPORT_SINK_CPU);
>  }
>  
>  static void hmat_register_target_initiators(struct memory_target *target)


