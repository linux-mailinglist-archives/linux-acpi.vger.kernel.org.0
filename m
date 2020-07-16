Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6832F2223BE
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jul 2020 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGPNTL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jul 2020 09:19:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59280 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNTL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2020 09:19:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GDH1C9083092;
        Thu, 16 Jul 2020 13:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=y32JkwBMc1GD3qCMghZZUc18XWu1AkWE4+VnubXpBrE=;
 b=r7OMTk0IwYmUHCAmgEMoDhZKQbPPnE4xl9RWfsxn1GisNL5LB9qOpTORhpNg678hfwo6
 6eAxOEYmvggM62WsAvpI5L30ukaCtoKejxBkv/Tz+jCNkQtNhYfolzZwb3vMs4wHvRBk
 0rLMLXKXfr0brVOTALbj2OCeSli4DqWFz2FoyHGEnSyPI83C6mIQBtWKuM0lBngHeDot
 6oGnVu9IyVS16mYL16u5Mt9Y/MIguWnxjjlTP8K18iag1Yv82LT3VSDB9PJhBhgun8I5
 JQ3xtWoFy267g+4qc6OMswaADFynbrxWtgkYBGSRhyHv2mlY3HPbbBaYZnm/lCFWq6Uj nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3275cmh9te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 13:18:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GDHfjK120980;
        Thu, 16 Jul 2020 13:18:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 327qbbb0r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 13:18:59 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GDIsPM008644;
        Thu, 16 Jul 2020 13:18:54 GMT
Received: from [10.175.173.87] (/10.175.173.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jul 2020 06:18:54 -0700
Subject: Re: [PATCH v2 22/22] device-dax: Introduce 'mapping' devices
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        hch@lst.de
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457128462.754248.10443613927921016089.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <7ecd1b82-06ab-be49-4b92-ac42caab146c@oracle.com>
Date:   Thu, 16 Jul 2020 14:18:49 +0100
MIME-Version: 1.0
In-Reply-To: <159457128462.754248.10443613927921016089.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 mlxlogscore=-1000 malwarescore=0
 mlxscore=100 spamscore=100 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=100
 impostorscore=0 malwarescore=0 mlxlogscore=-1000 clxscore=1011
 mlxscore=100 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160104
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/12/20 5:28 PM, Dan Williams wrote:
> In support of interrogating the physical address layout of a device with
> dis-contiguous ranges, introduce a sysfs directory with 'start', 'end',
> and 'page_offset' attributes. The alternative is trying to parse
> /proc/iomem, and that file will not reflect the extent layout until the
> device is enabled.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/bus.c         |  191 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/dax-private.h |   14 +++
>  2 files changed, 203 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index f342e36c69a1..8b6c4ddc5f42 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -579,6 +579,167 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  }
>  EXPORT_SYMBOL_GPL(alloc_dax_region);
>  
> +static void dax_mapping_release(struct device *dev)
> +{
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +
> +	ida_free(&dev_dax->ida, mapping->id);
> +	kfree(mapping);
> +}
> +
> +static void unregister_dax_mapping(void *data)
> +{
> +	struct device *dev = data;
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +	struct dax_region *dax_region = dev_dax->region;
> +
> +	dev_dbg(dev, "%s\n", __func__);
> +
> +	device_lock_assert(dax_region->dev);
> +
> +	dev_dax->ranges[mapping->range_id].mapping = NULL;
> +	mapping->range_id = -1;
> +
> +	device_del(dev);
> +	put_device(dev);
> +}
> +
> +static struct dev_dax_range *get_dax_range(struct device *dev)
> +{
> +	struct dax_mapping *mapping = to_dax_mapping(dev);
> +	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> +	struct dax_region *dax_region = dev_dax->region;
> +
> +	device_lock(dax_region->dev);
> +	if (mapping->range_id < 1) {
            ^^^^^^^^^^^^^^^^^^^^^ it's 'mapping->range_id < 0'

Otherwise 'mapping0' sysfs entries won't work.
Disabled ranges use id -1.

	Joao
