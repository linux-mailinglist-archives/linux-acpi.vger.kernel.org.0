Return-Path: <linux-acpi+bounces-16188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DACB3BEFE
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFC9563329
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CA322A25;
	Fri, 29 Aug 2025 15:15:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A713C8EA;
	Fri, 29 Aug 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480537; cv=none; b=kNWvj9ewXx7Sz81Fg/vFr20J93TqmhoLPgKbUflCQQKaFFJtpNaRmr/Ii9Kua9EbOT3OJEQF0hCoypzy0JHZcI59CP8vBxxTsbKmIaXlSGTSYDW2eyX3tmBlZIJtQuyvs/mGYve9RTjxbcfXiisv1S8VCQT3vUuNJt0Vsk7Mgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480537; c=relaxed/simple;
	bh=RBMTZHKptvch3m8YqeUfxwDzOYjcvLk/FtWe8AqKNOM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/WSB7ICFtnvOeKhN8WTjOIXiKg/r3UoHzvbrCliE1yiBLKSyRhQ47mJR0l7M3PoRis4D28X0Wu/EB3ZmPEsjaakYY5uexWhTQVUVMw7eV644tKXgUaBJatImWZ8IR46pSDeX3U581y2cVnpdYo7WaC2XxLSNKup83sgh6cPOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD1x26RZZz6GDtm;
	Fri, 29 Aug 2025 23:13:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 82DC514011A;
	Fri, 29 Aug 2025 23:15:31 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 17:15:30 +0200
Date: Fri, 29 Aug 2025 16:15:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<marc.herbert@linux.intel.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cxl, acpi/hmat: Update CXL access coordinates
 directly instead of through HMAT
Message-ID: <20250829161529.0000220a@huawei.com>
In-Reply-To: <20250820194704.4130565-4-dave.jiang@intel.com>
References: <20250820194704.4130565-1-dave.jiang@intel.com>
	<20250820194704.4130565-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 20 Aug 2025 12:47:03 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current implementation of CXL memory hotplug notifier gets called
> before the HMAT memory hotplug notifier. The CXL driver calculates the
> access coordinates (bandwidth and latency values) for the CXL end to
> end path (i.e. CPU to endpoint). When the CXL region is onlined, the CXL
> memory hotplug notifier writes the access coordinates to the HMAT target
> structs. Then the HMAT memory hotplug notifier is called and it creates
> the access coordinates for the node sysfs attributes.
> 
> During testing on an Intel platform, it was found that although the
> newly calculated coordinates were pushed to sysfs, the sysfs attributes for
> the access coordinates showed up with the wrong initiator. The system has
> 4 nodes (0, 1, 2, 3) where node 0 and 1 are CPU nodes and node 2 and 3 are
> CXL nodes. The expectation is that node 2 would show up as a target to node
> 0:
> /sys/devices/system/node/node2/access0/initiators/node0
> 
> However it was observed that node 2 showed up as a target under node 1:
> /sys/devices/system/node/node2/access0/initiators/node1
> 
> The original intent of the 'ext_updated' flag in HMAT handling code was to
> stop HMAT memory hotplug callback from clobbering the access coordinates
> after CXL has injected its calculated coordinates and replaced the generic
> target access coordinates provided by the HMAT table in the HMAT target
> structs. However the flag is hacky at best and blocks the updates from
> other CXL regions that are onlined in the same node later on. Remove the
> 'ext_updated' flag usage and just update the access coordinates for the
> nodes directly without touching HMAT target data.
> 
> The hotplug memory callback ordering is changed. Instead of changing CXL,
> move HMAT back so there's room for the levels rather than have CXL share
> the same level as SLAB_CALLBACK_PRI. The change will resulting in the CXL
> callback to be executed after the HMAT callback.
> 
> With the change, the CXL hotplug memory notifier runs after the HMAT
> callback. The HMAT callback will create the node sysfs attributes for
> access coordinates. The CXL callback will write the access coordinates to
> the now created node sysfs attributes directly and will not pollute the
> HMAT target values.
> 
> Fixes: 067353a46d8c ("cxl/region: Add memory hotplug notifier for cxl region")
> Cc: stable@vger.kernel.org
> Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Add description to what was observed for the issue. (Dan)
> - Use the correct Fixes tag. (Dan)
> - Add Cc to stable. (Dan)
> - Add support to only update on first region appearance. (Jonathan)

The implementation of this seems like overkill. See later, but in short
should be able to use a nodemask_t

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 71cc42d05248..371873fc43eb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -9,6 +9,7 @@
>  #include <linux/uuid.h>
>  #include <linux/sort.h>
>  #include <linux/idr.h>
> +#include <linux/xarray.h>
>  #include <linux/memory-tiers.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -30,6 +31,9 @@
>   * 3. Decoder targets
>   */
>  
> +/* xarray that stores the reference count per node for regions */

Reference count seems an over the top description.
I think it's just a flag that says if this happened already or not.
The term reference count would kind of suggest it would count regions
present.

So perhaps a comment along the lines of

/* xarray that stores if a region has previously been seen in a node */
and rename to node_region_seen_xa.

However, can we just use a bitmap sized to MAX_NUMNODES which is 
a nodemask_t which gives us the helpers nodemask.h



> +static DEFINE_XARRAY(node_regions_xa);
> +
>  static struct cxl_region *to_cxl_region(struct device *dev);
>  
>  #define __ACCESS_ATTR_RO(_level, _name) {				\
> @@ -2442,14 +2446,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			rc = 0;
> -			if (cxl_need_node_perf_attrs_update(nid))
> -				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> -			else
> -				rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
> -
> -			if (rc == 0)
> -				cset++;
> +			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> +			cset++;
>  		}
>  	}
>  
> @@ -2475,6 +2473,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	struct node_notify *nn = arg;
>  	int nid = nn->nid;
>  	int region_nid;
> +	int rc;
>  
>  	if (action != NODE_ADDED_FIRST_MEMORY)
>  		return NOTIFY_DONE;
> @@ -2487,6 +2486,11 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	if (nid != region_nid)
>  		return NOTIFY_DONE;
>  
> +	/* No action needed if there's existing entry */
> +	rc = xa_insert(&node_regions_xa, nid, NULL, GFP_KERNEL);

So this is using the NULL entry quirk of xa_insert() where
a reserved entry is put in place so next time we match. 

> +	if (rc < 0)
> +		return NOTIFY_DONE;
> +
>  	if (!cxl_region_update_coordinates(cxlr, nid))
>  		return NOTIFY_DONE;
>  
> @@ -3638,6 +3642,7 @@ int cxl_region_init(void)
>  
>  void cxl_region_exit(void)
>  {
> +	xa_destroy(&node_regions_xa);
>  	cxl_driver_unregister(&cxl_region_driver);
>  }



