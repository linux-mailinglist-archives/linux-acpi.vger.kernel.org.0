Return-Path: <linux-acpi+bounces-3552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495C856A94
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DDC1C21DC2
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C21B12DD9A;
	Thu, 15 Feb 2024 17:08:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6938131731;
	Thu, 15 Feb 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016930; cv=none; b=hxJHn2puGrLg7zSs1Xw2KEBLl23FdfEtKmquull59EZya5RRwYqGlTw90b7UUye1Fxd2vOqAl8XGZbYnzeVBS5kuCEWHKq5Zxe9u1OVzsN0A/2FowQsijC6k3gSOSXD7xpLzKA1KFXRfS/ZyhpGubG71a5zyomNFzwqsPtdSfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016930; c=relaxed/simple;
	bh=tGnEluyZc9H5mSgXAyfVE0SWdcMfKdilw1RKCJ4wBCw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuIyqM6kIDoQGouNOkiuCE+y7nCfcNI9phR4me1+qYTQ14gJuiDalQT5mSn0RmFTL9lwqOsIUrsXnsV41NLm+ed+ecLNyZTJhGJkBzXVhnSH8eQPBppDnXhG+2mJMcDtHZS1A8WrPxdx4SzwYXkIt3/XJSM6qQeL5CurhAlgnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbLyd1lWdz6J9xh;
	Fri, 16 Feb 2024 01:04:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E970140CF4;
	Fri, 16 Feb 2024 01:08:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 17:08:43 +0000
Date: Thu, 15 Feb 2024 17:08:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 10/12] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <20240215170842.00006e18@Huawei.com>
In-Reply-To: <20240206222951.1833098-11-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-11-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:38 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> region. The bandwidth is the aggregated bandwidth of all devices that
> contribute to the CXL region. The latency is the worst latency of the
> device amongst all the devices that contribute to the CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few comments inline.  Mostly about reducing duplication.

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  60 +++++++++++
>  drivers/cxl/core/region.c               | 134 ++++++++++++++++++++++++
>  2 files changed, 194 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..5f8c26815399 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -552,3 +552,63 @@ Description:
>  		attribute is only visible for devices supporting the
>  		capability. The retrieved errors are logged as kernel
>  		events when cxl_poison event tracing is enabled.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/accessY/read_bandwidth

Up to you, but it's fairly common to have multiple what lines in these
files and you could easily combine at least the read/write descriptions.

> +Date:		Jan, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated read bandwidth of the region. The number is
> +		the accumulated read bandwidth of all CXL memory devices that
> +		contributes to the region in MB/s. It is identical data that
> +		should appear in
> +		/sys/devices/system/node/nodeX/accessY/initiators/read_bandwidth.
> +		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
> +		the number to the closest initiator and access1 provides the
> +		number to the closest CPU.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/accessY/write_bandwidth
> +Date:		Jan, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated write bandwidth of the region. The number is
> +		the accumulated write bandwidth of all CXL memory devices that
> +		contributes to the region in MB/s. It is identical data that
> +		should appear in
> +		/sys/devices/system/node/nodeX/accessY/initiators/write_bandwidth.
> +		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
> +		the number to the closest initiator and access1 provides the
> +		number to the closest CPU.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/accessY/read_latency
> +Date:		Jan, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The read latency of the region. The number is
> +		the worst read latency of all CXL memory devices that
> +		contributes to the region in nanoseconds. It is identical data
> +		that should appear in
> +		/sys/devices/system/node/nodeX/accessY/initiators/read_latency.
> +		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
> +		the number to the closest initiator and access1 provides the
> +		number to the closest CPU.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/accessY/write_latency
> +Date:		Jan, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The write latency of the region. The number is
> +		the worst write latency of all CXL memory devices that
> +		contributes to the region in nanoseconds. It is identical data
> +		that should appear in
> +		/sys/devices/system/node/nodeX/accessY/initiators/write_latency.
> +		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
> +		the number to the closest initiator and access1 provides the
> +		number to the closest CPU.
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0c2337b1fd41..6347dbc746f9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -30,6 +30,138 @@
>  
>  static struct cxl_region *to_cxl_region(struct device *dev);
>  
> +#define __ACCESS0_ATTR_RO(_name) {				\
> +	.attr	= { .name = __stringify(_name), .mode = 0444 },	\
> +	.show	= _name##_access0_show,				\
> +}
> +
> +#define ACCESS0_DEVICE_ATTR_RO(_name) \
> +	struct device_attribute dev_attr_access0_##_name = __ACCESS0_ATTR_RO(_name)
> +
> +#define ACCESS0_ATTR(attrib)					\
> +static ssize_t attrib##_access0_show(struct device *dev,	\
> +			   struct device_attribute *attr,	\
> +			   char *buf)				\
> +{								\
> +	struct cxl_region *cxlr = to_cxl_region(dev);		\
> +								\
> +	if (cxlr->coord[0].attrib == 0)				\
> +		return -ENOENT;					\
> +								\
> +	return sysfs_emit(buf, "%u\n", cxlr->coord[0].attrib);	\
> +}								\
> +static ACCESS0_DEVICE_ATTR_RO(attrib)
> +
> +ACCESS0_ATTR(read_bandwidth);
> +ACCESS0_ATTR(read_latency);
> +ACCESS0_ATTR(write_bandwidth);
> +ACCESS0_ATTR(write_latency);
> +
> +static struct attribute *access0_coordinate_attrs[] = {
> +	&dev_attr_access0_read_bandwidth.attr,
> +	&dev_attr_access0_write_bandwidth.attr,
> +	&dev_attr_access0_read_latency.attr,
> +	&dev_attr_access0_write_latency.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_region_access0_coordinate_visible(struct kobject *kobj,
> +						     struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	if (a == &dev_attr_access0_read_latency.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_LOCAL].read_latency == 0)
> +		return 0;
> +
> +	if (a == &dev_attr_access0_write_latency.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_LOCAL].write_latency == 0)
> +		return 0;
> +
> +	if (a == &dev_attr_access0_read_bandwidth.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_LOCAL].read_bandwidth == 0)
> +		return 0;
> +
> +	if (a == &dev_attr_access0_write_bandwidth.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_LOCAL].write_bandwidth == 0)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +#define __ACCESS1_ATTR_RO(_name) {				\
> +	.attr	= { .name = __stringify(_name), .mode = 0444 },	\
> +	.show	= _name##_access1_show,				\
> +}

Maybe define __ACCESSX_ATTR_RO(_name, _access)
etc to avoid some duplicaton.

> +
> +#define ACCESS1_DEVICE_ATTR_RO(_name) \
> +	struct device_attribute dev_attr_access1_##_name = __ACCESS1_ATTR_RO(_name)
> +
> +#define ACCESS1_ATTR(attrib)					\
> +static ssize_t attrib##_access1_show(struct device *dev,	\
> +			   struct device_attribute *attr,	\
> +			   char *buf)				\
> +{								\
> +	struct cxl_region *cxlr = to_cxl_region(dev);		\
> +								\
> +	if (cxlr->coord[1].attrib == 0)				\
> +		return -ENOENT;					\
> +								\
> +	return sysfs_emit(buf, "%u\n", cxlr->coord[1].attrib);	\
> +}								\
> +static ACCESS1_DEVICE_ATTR_RO(attrib)
> +
> +ACCESS1_ATTR(read_bandwidth);
> +ACCESS1_ATTR(read_latency);
> +ACCESS1_ATTR(write_bandwidth);
> +ACCESS1_ATTR(write_latency);
> +
> +static struct attribute *access1_coordinate_attrs[] = {
> +	&dev_attr_access1_read_bandwidth.attr,
> +	&dev_attr_access1_write_bandwidth.attr,
> +	&dev_attr_access1_read_latency.attr,
> +	&dev_attr_access1_write_latency.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_region_access1_coordinate_visible(struct kobject *kobj,
> +						     struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	if (a == &dev_attr_access1_read_latency.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_CPU].read_latency == 0)
> +		return 0;
> +
> +	if (a == &dev_attr_access1_write_latency.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_CPU].write_latency == 0)
> +		return 0;
> +
> +	if (a == &dev_attr_access1_read_bandwidth.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_CPU].read_bandwidth == 0)
> +		return 0;
> +
> +	if (a == &dev_attr_access1_write_bandwidth.attr &&
> +	    cxlr->coord[ACCESS_COORDINATE_CPU].write_bandwidth == 0)
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group cxl_region_access0_coordinate_group = {
> +	.name = "access0",
> +	.attrs = access0_coordinate_attrs,
> +	.is_visible = cxl_region_access0_coordinate_visible,
> +};
> +
> +static const struct attribute_group cxl_region_access1_coordinate_group = {
> +	.name = "access1",
> +	.attrs = access1_coordinate_attrs,
> +	.is_visible = cxl_region_access1_coordinate_visible,
> +};
> +
>  static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> @@ -2039,6 +2171,8 @@ static const struct attribute_group *region_groups[] = {
>  	&cxl_base_attribute_group,
>  	&cxl_region_group,
>  	&cxl_region_target_group,
> +	&cxl_region_access0_coordinate_group,
> +	&cxl_region_access1_coordinate_group,
>  	NULL,
>  };
>  


