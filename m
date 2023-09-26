Return-Path: <linux-acpi+bounces-125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BE7AECEA
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D00DA2817D4
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB226E38
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835841A5AF
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 10:50:50 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09DE5;
	Tue, 26 Sep 2023 03:50:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvxMJ4TTkz6K6xv;
	Tue, 26 Sep 2023 18:49:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 26 Sep
 2023 11:50:45 +0100
Date: Tue, 26 Sep 2023 11:50:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bhelgaas@google.com>, <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Message-ID: <20230926115044.00006895@Huawei.com>
In-Reply-To: <20230925200127.504256-2-Benjamin.Cheatham@amd.com>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
	<20230925200127.504256-2-Benjamin.Cheatham@amd.com>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 25 Sep 2023 15:01:25 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
> device) for CXL RCH root ports. The file will print the RCRB base
> MMIO address of the root port when read and will be used by
> users looking to inject CXL EINJ error types for RCH hosts.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Hi Ben,

I'm still not totally convinced that injecting the group via the link
onto the PCI device is necessarily a good idea, but if Bjorn is fine with
that I don't mind too much.

There is a question on whether this should also be added to the
sysfs-bus-pci docs given it turns up on a device where people might look there
first.

So with that in mind
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  9 ++++
>  drivers/cxl/acpi.c                      |  2 +
>  drivers/cxl/core/port.c                 | 58 +++++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |  2 +
>  4 files changed, 71 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 087f762ebfd5..85621da69296 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -177,6 +177,15 @@ Description:
>  		integer reflects the hardware port unique-id used in the
>  		hardware decoder target list.
>  
> +What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> +What:		/sys/devices/pciX/cxl_rcrb_addr
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The 'cxl_rcrb_addr' device file gives the MMIO base address
> +		of the RCRB of the corresponding CXL 1.1 downstream port. Only
> +		present for CXL 1.1 dports.
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y
>  Date:		June, 2021
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d1c559879dcc..3e2ca946bf47 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -676,6 +676,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (IS_ERR(root_port))
>  		return PTR_ERR(root_port);
>  
> +	set_cxl_root(root_port);
> +
>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_dport);
>  	if (rc < 0)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 724be8448eb4..c3914e73f67e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -875,6 +875,14 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  
> +static struct cxl_port *cxl_root;
> +
> +void set_cxl_root(struct cxl_port *root_port)
> +{
> +	cxl_root = root_port;
> +}
> +EXPORT_SYMBOL_NS_GPL(set_cxl_root, CXL);
> +
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> @@ -930,11 +938,56 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
>  		device_unlock(&port->dev);
>  }
>  
> +static ssize_t cxl_rcrb_addr_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_dport *dport;
> +
> +	if (!cxl_root)
> +		return -ENODEV;
> +
> +	dport = cxl_find_dport_by_dev(cxl_root, dev);
> +	if (!dport)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "0x%llx\n", (u64) dport->rcrb.base);
> +}
> +DEVICE_ATTR_RO(cxl_rcrb_addr);
> +
> +static umode_t cxl_rcrb_addr_is_visible(struct kobject *kobj,
> +					struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_dport *dport;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ) || !cxl_root)
> +		return 0;
> +
> +	dport = cxl_find_dport_by_dev(cxl_root, dev);
> +	if (!dport || !dport->rch || dport->rcrb.base == CXL_RESOURCE_NONE)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static struct attribute *cxl_rcrb_addr_attrs[] = {
> +	&dev_attr_cxl_rcrb_addr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group cxl_rcrb_addr_group = {
> +	.attrs = cxl_rcrb_addr_attrs,
> +	.is_visible = cxl_rcrb_addr_is_visible,
> +};
> +
>  static void cxl_dport_remove(void *data)
>  {
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> +	if (dport->rch)
> +		sysfs_remove_group(&dport->dport_dev->kobj, &cxl_rcrb_addr_group);
> +
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>  	put_device(dport->dport_dev);
>  }
> @@ -1021,6 +1074,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	rc = sysfs_create_group(&dport_dev->kobj, &cxl_rcrb_addr_group);
> +	if (rc)
> +		dev_dbg(dport_dev, "Couldn't create cxl_rcrb_addr group: %d\n",
> +			rc);
> +
>  	return dport;
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 76d92561af29..4d5bce4bae7e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -690,6 +690,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_dport *parent_dport);
>  struct cxl_port *find_cxl_root(struct cxl_port *port);
> +void set_cxl_root(struct cxl_port *root_port);
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);


