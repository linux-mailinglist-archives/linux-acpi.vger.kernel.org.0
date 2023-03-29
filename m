Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2E6CCF7A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 03:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC2B1Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 21:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjC2B1X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 21:27:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294226AD;
        Tue, 28 Mar 2023 18:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680053239; x=1711589239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LW50/v7VbQmn2waXY9YUX2XxebnyjfWAYyCviZhJ3e8=;
  b=GwgAQL8Iz9WZP3GRWcOjiwf/y43kpkJ++Qa+qvWFKkdNdOGOI5vzVeL3
   pP9FaJluDruLgOlKYeRcp50HSRhQKHw0aDy/Fd08P56vtwRjelNifFfat
   h4+6iTw7SCGfFbPwsafq94HnDwaqH45aVh1cQrpG5P8wXjIOEr4YPgbeg
   NSTigGfKlnlHgJ0kCV6ASiausB0+jgfy9fwHfMg1CJRD+PWMaxvKLHm/e
   40Eie0u91/PI2xj/W4+N7p5PZcTyTDYZ9+iShvrnhuJislZ6CQuBSA7FX
   kZJqtxpWReKgshQa8pLjUC59hQdo/lvjA2fzpfoK2RR4EUVOMwKPnNi+B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403362516"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="403362516"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 18:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773360171"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="773360171"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 18:27:18 -0700
Date:   Tue, 28 Mar 2023 18:27:16 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, rafael@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v2 20/21] cxl: Export sysfs attributes for memory device
 QTG ID
Message-ID: <ZCOT9DS9/PhVGS4R@aschofie-mobl2>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
 <167995356611.2857312.4634198260468536572.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167995356611.2857312.4634198260468536572.stgit@djiang5-mobl3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 27, 2023 at 02:46:06PM -0700, Dave Jiang wrote:
> Export qtg_id sysfs attributes for the CXL memory device. The QTG ID
> should show up as /sys/bus/cxl/devices/memX/qtg_id. The QTG ID is
> retrieved via _DSM after supplying the caluclated bandwidth and latency

calculated

> for the entire CXL path from device to the CPU. This ID is used to match
> up to the root decoder QTG ID to determine which CFMWS the memory range
> of a hotplugged CXL mem device should be assigned under.
> 
> While there may be multiple DSMAS exported by the device CDAT, the driver
> will only expose the first QTG ID in sysfs for now. In the future when
> multiple QTG IDs are necessary, they can be exposed. [1]
> 
> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
>  drivers/cxl/core/memdev.c               |   15 +++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 471ac9a37078..a018f0a21aca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,17 @@ Description:
>  		affinity for this device.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/qtg_id
> +Date:		March, 2024
> +KernelVersion:	v6.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Show the first QoS Throttling Group ID for the device.
> +		The ID is used to match against the CFMWS (root decoder)
> +		QTG ID so that the memory range under a hot-plugged device
> +		is assigned under the appropriate CFMWS.

Some of the language in the cover letter seemed more descriptive, but
I guess it's a bit squishy to me. (ie. 'some guidance' and 'appropriate')

Would a spec link be useful here?

Alison

> +
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d2605fc39240..974eff833edd 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,27 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t qtg_id_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct qos_prop_entry *qos;
> +
> +	if (list_empty(&cxlmd->qos_list))
> +		return 0;
> +
> +	qos = list_first_entry(&cxlmd->qos_list, struct qos_prop_entry, list);
> +	return sysfs_emit(buf, "%u\n", qos->qtg_id);
> +}
> +static DEVICE_ATTR_RO(qtg_id);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_qtg_id.attr,
>  	NULL,
>  };
>  
> 
> 
