Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B102D100199
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRJpk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 04:45:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbfKRJpk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 04:45:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI9g9xg007676;
        Mon, 18 Nov 2019 04:45:18 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2waym9e0pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 04:45:18 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAI9jBEL001662;
        Mon, 18 Nov 2019 09:45:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 2wa8r614wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 09:45:17 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAI9jGtq52756830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 09:45:16 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 925AF6A047;
        Mon, 18 Nov 2019 09:45:16 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35AB36A04D;
        Mon, 18 Nov 2019 09:45:13 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.246])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 09:45:12 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 13/18] libnvdimm: Export the target_node attribute for regions and namespaces
In-Reply-To: <157401274500.43284.2369509941678577768.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401274500.43284.2369509941678577768.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 18 Nov 2019 15:15:10 +0530
Message-ID: <87zhgth61l.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180087
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Aneesh points out that some platforms may have "local" attached
> persistent memory and "remote" persistent memory that map to the same
> "online" node, or persistent memory devices with different performance
> properties. In this case 'numa_node' is identical for the two instances,
> but 'target_node' is differentiated so platform firmware can communicate
> distinct performance properties per range. Expose 'target_node' by
> default to allow for disambiguation of devices that share the same
> numa_map_to_online_node() result.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/bus.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 1d330d46d036..f76d709426f7 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -685,17 +685,46 @@ static ssize_t numa_node_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static int nvdimm_dev_to_target_node(struct device *dev)
> +{
> +	struct device *parent = dev->parent;
> +	struct nd_region *nd_region = NULL;
> +
> +	if (is_nd_region(dev))
> +		nd_region = to_nd_region(dev);
> +	else if (parent && is_nd_region(parent))
> +		nd_region = to_nd_region(parent);
> +
> +	if (!nd_region)
> +		return NUMA_NO_NODE;
> +	return nd_region->target_node;
> +}
> +
> +static ssize_t target_node_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", nvdimm_dev_to_target_node(dev));
> +}
> +static DEVICE_ATTR_RO(target_node);
> +
>  static struct attribute *nd_numa_attributes[] = {
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_target_node.attr,
>  	NULL,
>  };
>  
>  static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
>  		int n)
>  {
> +	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +
>  	if (!IS_ENABLED(CONFIG_NUMA))
>  		return 0;
>  
> +	if (a == &dev_attr_target_node.attr &&
> +			nvdimm_dev_to_target_node(dev) == NUMA_NO_NODE)
> +		return 0;
> +
>  	return a->mode;
>  }
>  
