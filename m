Return-Path: <linux-acpi+bounces-12229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA070A60A95
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 08:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEAB189FD8F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73304198A38;
	Fri, 14 Mar 2025 07:56:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A615CD4A;
	Fri, 14 Mar 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939003; cv=none; b=RgV+O9JQkwgr+/2h/X2RvPXdR3sz1q0gRAvMeVHMBrVadKAW7LOODm9KOswjTtMAnyyfwJ4bFuwZvUcCX8uFinP0TxVT/bhOWMwkca9un7K4DENYdqE7vXh2KCnM7baxIFWbeGpYo5wzRTSdEmGkdtMxKsN2nM389ZHwxQ7PG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939003; c=relaxed/simple;
	bh=mAJqODhdppim4+7U2eMnPfMR4EnUZuNUqM2FaRAkv2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad4EhbVaJW8VVpO1K6c5Qqle6dZv4bbqDuHAp5Mp5/Oe3xJwRLIUft/rdSuw0RyKfrWm7zmp7mEe6p+6Bz2LgkLWkJ3CgD/G986dsGKNMjxe+sLIMtRAjC+lvKOQZJp8ULqzML7FNPQ3XGiffhuqN4JL9nH0Mg4B+FGQs+59IVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHza0W4dNnyancCQ--.5043S2;
	Fri, 14 Mar 2025 15:56:06 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDn6IQB4dNnnI5IAA--.13879S2;
	Fri, 14 Mar 2025 15:55:57 +0800 (CST)
Date: Fri, 14 Mar 2025 15:55:44 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Alison Schofield <alison.schofield@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	rppt@kernel.org, haibo1.xu@intel.com, chenbaozi@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9PhAKEFj5ugVuow@phytium.com.cn>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
 <Z9MHvp6GA_iGwfg0@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9MHvp6GA_iGwfg0@aschofie-mobl2.lan>
X-CM-TRANSID:AQAAfwDn6IQB4dNnnI5IAA--.13879S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWfR6CAHHgAas1
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWfZrW5GrW8tr4kCr15Jwb_yoW7CrW5pF
	WxKFWrtFWxtFWxCan2vr15JFyS9w10yFWUGry7Wr9xZrsrWryfZF4xJayYvFyDA348Cr4S
	qF4vy3W5ua40vFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Thu, Mar 13, 2025 at 09:28:46AM -0700, Alison Schofield wrote:
> On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> > The absence of SRAT would cause the fake_pxm to be -1 and increment
> > to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
> > ranges that are defined in the CFMWS and not already defined in the
> > SRAT, the new node (node0) for the CXL memory would be invalid, as
> > node0 is already in "used".
> > 
> > This utilizes disable_srat() & srat_disabled() to fail CXL init.
> 
> Seems like this fixup has drifted from adjusting the fake_pxm to 
> shutting down CXL parsing. More below -
> 
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> > 
> > Changes in v2:
> > - Add disable_srat() when fake_pxm is invalid
> > - Add srat_disabled() check in cxl_acpi_probe() and acpi_parse_cfmws()
> > 
> > 
> >  drivers/acpi/numa/srat.c | 10 ++++++++++
> >  drivers/cxl/acpi.c       |  4 ++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 00ac0d7bb8c9..2dac25c9258a 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  	start = cfmws->base_hpa;
> >  	end = cfmws->base_hpa + cfmws->window_size;
> >  
> > +	if (srat_disabled()) {
> > +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> > +		return -EINVAL;
> > +	}
> > +
> 
> This goes too far by shutting down cfmws parsing for lack of SRAT.
>

Actually, I thought there need another patch to fix the follow problem
that the fake node bring when no SRAT.

Detailed description below.

> >  	/*
> >  	 * The SRAT may have already described NUMA details for all,
> >  	 * or a portion of, this CFMWS HPA range. Extend the memblks
> > @@ -646,6 +651,11 @@ int __init acpi_numa_init(void)
> >  		if (node_to_pxm_map[i] > fake_pxm)
> >  			fake_pxm = node_to_pxm_map[i];
> >  	}
> > +
> > +	/* Make sure CFMWs fake nodes start at node[1] */
> > +	if (fake_pxm < 0)
> > +		disable_srat();
> > +
> 
> How does the code above make sure fake node starts at node[1]?
> Would an explicit adjustment like this work?

Thanks for your correction :) Yes, the way I used here is too implicit.

> 
> -       last_real_pxm = fake_pxm;
> -       fake_pxm++;
> +       fake_pxm = max(fake_pxm, 1);
> +       last_real_pxm = fake_pxm--;

I tried the adjustment below: 

	fake_pxm = max(fake_pxm, 0); // 0 because it will increment to 1  
	last_real_pxm = fake_pxm++;

This works but it might only control the parameter sent to acpi_parse_cfmws(). 
According to acpi_map_pxm_to_node(), altough the input fake_pxm is 1 when no
SRAT, the returned node would still be 0 and the following nodes are aslo
incorrect.

Hence, I tried add a new line below:

	fake_pxm = max(fake_pxm, 0);
	last_real_pxm = fake_pxm++;
        node_set(0, nodes_found_map);

As no matter what situation, node[0] would be found and set. With this
setting, acpi_map_pxm_to_node() could return the expected node value
even if no SRAT. :( 

Unfortunately, when we use "cxl create-region" to enable our cxl memory,
it would still be assigned to node[0], because the "numa_add_memblk()"
can only add numa_memblk to numa_meminfo list. 

If our SRAT is OK, the numa_memblks_init() would then utilize
numa_move_tail_memblk() to move the numa_memblk from numa_meminfo to
numa_reserved_meminfo in CFMWs fake node situation. If SRAT is missing
or bad, the numa_memblks_init() would fail since init_func() would fail. 
And it causes that no numa_memblk in numa_reserved_meminfo list and the
following dax&memory_hotplug drivers could not online the expected fake
node. 

Based on the above problem, I have a new patch idea that introduce a new
function in mm/numa_memblks.c: numa_add_reserved_memblk(). It could add
one numa_memblk to nuam_reserved_meminfo directly. Maybe we could call
it in acpi_parse_cfmws() if srat is missing.

In mm/numa_memblks.c:

	int __init numa_add_reserved_memblk(int nid, u64 start, u64 end)
	{		
		return numa_add_memblk_to(nid, start, end, &numa_reserved_meminfo);
	}

In drivers/acpi/numa/srat.c:

	if (srat_disabled()) {
		if (numa_add_reserved_memblk(node, start, end) < 0) {
			pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
			node, start, end);
		}
	}

:( But..., the dax_kmem driver will fail because something wrong in
memory_group_register_static(). The good result is our cxl memory would
not be assigned to node[0] anymore!

BTW, as papering these things looks like not easily, I chose to aggressively
fail the acpi_parse_cfmws() in srat.c since it mainly works for building
cxl fake nodes and also fail the CXL init in cxl_acpi_probe per Jonathan.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-03/msg03668.html

Hopes more comments to guide me! I'm a really rookie in kernel community :P

> >  	last_real_pxm = fake_pxm;
> >  	fake_pxm++;
> >  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index cb14829bb9be..e75a8ead99f6 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -829,6 +829,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		return rc;
> >  
> > +	/* CXL must be in a NUMA system */
> > +	if (srat_disabled())
> > +		return -EINVAL;
> > +
> >  	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
> >  	if (!cxl_res)
> >  		return -ENOMEM;
> > -- 
> > 2.34.1
> > 


