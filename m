Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA5692468
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjBJR25 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 12:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjBJR24 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 12:28:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB01C7358F;
        Fri, 10 Feb 2023 09:28:54 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD0w72WBwz67Qtq;
        Sat, 11 Feb 2023 01:24:23 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 17:28:51 +0000
Date:   Fri, 10 Feb 2023 17:28:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 01/20] cxl/memdev: Fix endpoint port removal
Message-ID: <20230210172850.00001d5b@Huawei.com>
In-Reply-To: <167601992789.1924368.8083994227892600608.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167601992789.1924368.8083994227892600608.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.211]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 10 Feb 2023 01:05:27 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Testing of ram region support [1], stimulates a long standing bug in
> cxl_detach_ep() where some cxl_ep_remove() cleanup is skipped due to
> inability to walk ports after dports have been unregistered. That
> results in a failure to re-register a memdev after the port is
> re-enabled leading to a crash like the following:
> 
>     cxl_port_setup_targets: cxl region4: cxl_host_bridge.0:port4 iw: 1 ig: 256
>     general protection fault, ...
>     [..]
>     RIP: 0010:cxl_region_setup_targets+0x897/0x9e0 [cxl_core]
>     dev_name at include/linux/device.h:700
>     (inlined by) cxl_port_setup_targets at drivers/cxl/core/region.c:1155
>     (inlined by) cxl_region_setup_targets at drivers/cxl/core/region.c:1249
>     [..]
>     Call Trace:
>      <TASK>
>      attach_target+0x39a/0x760 [cxl_core]
>      ? __mutex_unlock_slowpath+0x3a/0x290
>      cxl_add_to_region+0xb8/0x340 [cxl_core]
>      ? lockdep_hardirqs_on+0x7d/0x100
>      discover_region+0x4b/0x80 [cxl_port]
>      ? __pfx_discover_region+0x10/0x10 [cxl_port]
>      device_for_each_child+0x58/0x90
>      cxl_port_probe+0x10e/0x130 [cxl_port]
>      cxl_bus_probe+0x17/0x50 [cxl_core]
> 
> Change the port ancestry walk to be by depth rather than by dport. This
> ensures that even if a port has unregistered its dports a deferred
> memdev cleanup will still be able to cleanup the memdev's interest in
> that port.
> 
> The parent_port->dev.driver check is only needed for determining if the
> bottom up removal beat the top-down removal, but cxl_ep_remove() can
> always proceed.

Why can cxl_ep_remove() always proceed?  What stops it racing?
Is it that we are holding a reference to the port at the time of the
call so the release callback can't be called until we drop that?
Anyhow, good to have a little more detail on the 'why' in the patch
description (particularly for those reading this when half asleep like me ;)

> 
> Fixes: 2703c16c75ae ("cxl/core/port: Add switch port enumeration")
> Link: http://lore.kernel.org/r/167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c |    1 +
>  drivers/cxl/core/port.c   |   58 +++++++++++++++++++++++++--------------------
>  drivers/cxl/cxlmem.h      |    2 ++
>  3 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a74a93310d26..3a8bc2b06047 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -246,6 +246,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	if (rc < 0)
>  		goto err;
>  	cxlmd->id = rc;
> +	cxlmd->depth = -1;
>  
>  	dev = &cxlmd->dev;
>  	device_initialize(dev);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 410c036c09fa..317bcf4dbd9d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1207,6 +1207,7 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>  
>  	get_device(&endpoint->dev);
>  	dev_set_drvdata(dev, endpoint);
> +	cxlmd->depth = endpoint->depth;
>  	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, CXL);
> @@ -1241,50 +1242,55 @@ static void reap_dports(struct cxl_port *port)
>  	}
>  }
>  
> +struct detach_ctx {
> +	struct cxl_memdev *cxlmd;
> +	int depth;
> +};

>  static void cxl_detach_ep(void *data)
>  {
>  	struct cxl_memdev *cxlmd = data;
> -	struct device *iter;
>  
> -	for (iter = &cxlmd->dev; iter; iter = grandparent(iter)) {
> -		struct device *dport_dev = grandparent(iter);
> +	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>  		struct cxl_port *port, *parent_port;
> +		struct detach_ctx ctx = {
> +			.cxlmd = cxlmd,
> +			.depth = i,
> +		};
> +		struct device *dev;
>  		struct cxl_ep *ep;
>  		bool died = false;
>  
> -		if (!dport_dev)
> -			break;
> -
> -		port = find_cxl_port(dport_dev, NULL);
> -		if (!port)
> -			continue;
> -
> -		if (is_cxl_root(port)) {
> -			put_device(&port->dev);
> +		dev = bus_find_device(&cxl_bus_type, NULL, &ctx,
> +				      port_has_memdev);
> +		if (!dev)
>  			continue;
> -		}
> +		port = to_cxl_port(dev);
>  
>  		parent_port = to_cxl_port(port->dev.parent);
>  		device_lock(&parent_port->dev);
> -		if (!parent_port->dev.driver) {
> -			/*
> -			 * The bottom-up race to delete the port lost to a
> -			 * top-down port disable, give up here, because the
> -			 * parent_port ->remove() will have cleaned up all
> -			 * descendants.
> -			 */
> -			device_unlock(&parent_port->dev);
> -			put_device(&port->dev);
> -			continue;
> -		}
> -
>  		device_lock(&port->dev);
>  		ep = cxl_ep_load(port, cxlmd);
>  		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
>  			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
>  		cxl_ep_remove(port, ep);
>  		if (ep && !port->dead && xa_empty(&port->endpoints) &&
> -		    !is_cxl_root(parent_port)) {
> +		    !is_cxl_root(parent_port) && parent_port->dev.driver) {
>  			/*
>  			 * This was the last ep attached to a dynamically
>  			 * enumerated port. Block new cxl_add_ep() and garbage


