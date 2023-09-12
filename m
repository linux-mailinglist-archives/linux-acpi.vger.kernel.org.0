Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2879D65F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjILQeE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjILQeD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 12:34:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F510EF;
        Tue, 12 Sep 2023 09:33:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlTfZ5lymz6H6rP;
        Wed, 13 Sep 2023 00:33:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 17:33:56 +0100
Date:   Tue, 12 Sep 2023 17:33:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Cheatham <benjamin.cheatham@amd.com>
CC:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bhelgaas@google.com>, <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Message-ID: <20230912173355.000058f6@Huawei.com>
In-Reply-To: <d96177aa-52ca-2015-7cb1-8d0a237b43fc@amd.com>
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
        <20230907191956.674833-2-Benjamin.Cheatham@amd.com>
        <20230912151112.00007fe2@Huawei.com>
        <d96177aa-52ca-2015-7cb1-8d0a237b43fc@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 12 Sep 2023 09:49:00 -0500
Ben Cheatham <benjamin.cheatham@amd.com> wrote:

> Hi Jonathan, thanks for the review. Responses inline.
> 
> On 9/12/23 9:11 AM, Jonathan Cameron wrote:
> > On Thu, 7 Sep 2023 14:19:54 -0500
> > Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> >   
> >> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
> >> device) for CXL RCH root ports. The file will print the RCRB base
> >> MMIO address of the root port when read and will be used by
> >> users looking to inject CXL EINJ error types for RCH hosts.
> >>
> >> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>  
> > 
> > Can we use is_visble to control presence of the attribute rather than
> > race condition special that is dynamic addition of a sysfs file.
> >   
> 
> Yeah, I'll go ahead and change it. Not sure why I did it that way to be
> honest.
> 
> > You are adding the file to the linked device which is a bit odd.
> > Why there rather than in the portX?
> >   
> 
> I agree it's a bit odd. I went with adding the file to the linked device
> because the ACPI spec specifies using downstream ports for EINJ. The
> alternative was to have a file for each dport under portX (i.e. dportY_rcrb_addr)
> which seemed messier to me. Now that I think about it though, I could just
> have a single file under portX that you write the dport name/number to and
> it returns the rcrb address. Let me know if you think that would be better.

Ah. I was being half asleep.  I'd missed the point that a portX can have multiple
dportY (which is obvious given the naming :) 

What makes here probably one for Dan or Bjorn to comment on..

Jonathan

> 
> > I'd also normally expect the docs to call out the non-link path for that
> > device which is somewhere in the PCI topology I think.
> >   
> 
> Yeah that makes sense, I'll go ahead and change that.
> 
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++++
> >>  drivers/cxl/acpi.c                      |  2 ++
> >>  drivers/cxl/core/port.c                 | 33 +++++++++++++++++++++++++
> >>  drivers/cxl/cxl.h                       |  2 ++
> >>  4 files changed, 45 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> >> index 087f762ebfd5..a7d169235543 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> >> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> >> @@ -177,6 +177,14 @@ Description:
> >>  		integer reflects the hardware port unique-id used in the
> >>  		hardware decoder target list.
> >>  
> >> +What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> >> +Date:		August, 2023
> >> +KernelVersion:	v6.6
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) The 'cxl_rcrb_addr' device file gives the MMIO base address
> >> +		of the RCRB of the corresponding CXL 1.1 downstream port. Only
> >> +		present for CXL 1.1 dports.
> >>  
> >>  What:		/sys/bus/cxl/devices/decoderX.Y
> >>  Date:		June, 2021
> >> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> >> index d1c559879dcc..3e2ca946bf47 100644
> >> --- a/drivers/cxl/acpi.c
> >> +++ b/drivers/cxl/acpi.c
> >> @@ -676,6 +676,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >>  	if (IS_ERR(root_port))
> >>  		return PTR_ERR(root_port);
> >>  
> >> +	set_cxl_root(root_port);
> >> +
> >>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
> >>  			      add_host_bridge_dport);
> >>  	if (rc < 0)
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index 724be8448eb4..001ab8742e21 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -875,6 +875,14 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
> >>  
> >> +static struct cxl_port *cxl_root;
> >> +
> >> +void set_cxl_root(struct cxl_port *root_port)
> >> +{
> >> +	cxl_root = root_port;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(set_cxl_root, CXL);
> >> +
> >>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> >>  {
> >>  	struct cxl_dport *dport;
> >> @@ -930,11 +938,30 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
> >>  		device_unlock(&port->dev);
> >>  }
> >>  
> >> +static ssize_t cxl_rcrb_addr_show(struct device *dev,
> >> +				  struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct cxl_dport *dport;
> >> +
> >> +	if (!cxl_root)
> >> +		return -ENODEV;
> >> +
> >> +	dport = cxl_find_dport_by_dev(cxl_root, dev);
> >> +	if (!dport)
> >> +		return -ENODEV;
> >> +
> >> +	return sysfs_emit(buf, "0x%llx\n", (u64) dport->rcrb.base);
> >> +}
> >> +DEVICE_ATTR_RO(cxl_rcrb_addr);
> >> +
> >>  static void cxl_dport_remove(void *data)
> >>  {
> >>  	struct cxl_dport *dport = data;
> >>  	struct cxl_port *port = dport->port;
> >>  
> >> +	if (dport->rch)
> >> +		device_remove_file(dport->dport_dev, &dev_attr_cxl_rcrb_addr);
> >> +
> >>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> >>  	put_device(dport->dport_dev);
> >>  }
> >> @@ -1021,6 +1048,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> >>  	if (rc)
> >>  		return ERR_PTR(rc);
> >>  
> >> +	if (dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE) {
> >> +		rc = device_create_file(dport_dev, &dev_attr_cxl_rcrb_addr);
> >> +		if (rc)
> >> +			return ERR_PTR(rc);
> >> +	}
> >> +
> >>  	return dport;
> >>  }
> >>  
> >> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >> index 76d92561af29..4d5bce4bae7e 100644
> >> --- a/drivers/cxl/cxl.h
> >> +++ b/drivers/cxl/cxl.h
> >> @@ -690,6 +690,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
> >>  				   resource_size_t component_reg_phys,
> >>  				   struct cxl_dport *parent_dport);
> >>  struct cxl_port *find_cxl_root(struct cxl_port *port);
> >> +void set_cxl_root(struct cxl_port *root_port);
> >> +
> >>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
> >>  void cxl_bus_rescan(void);
> >>  void cxl_bus_drain(void);  
> >   

