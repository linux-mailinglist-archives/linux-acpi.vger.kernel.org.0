Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B831001A0
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 10:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKRJqt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 04:46:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbfKRJqt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 04:46:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI9gM0s017313;
        Mon, 18 Nov 2019 04:46:36 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2waeh8534u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 04:46:36 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAI9gUgx018488;
        Mon, 18 Nov 2019 04:46:36 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2waeh85342-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 04:46:36 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAI9jARS026504;
        Mon, 18 Nov 2019 09:46:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 2wa8r6h6xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 09:46:34 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAI9kY4l46727560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 09:46:34 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 014D8136053;
        Mon, 18 Nov 2019 09:46:34 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88E5A13604F;
        Mon, 18 Nov 2019 09:46:29 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.246])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 09:46:28 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 04/18] libnvdimm: Move nd_numa_attribute_group to device_type
In-Reply-To: <157401269537.43284.14411189404186877352.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401269537.43284.14411189404186877352.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 18 Nov 2019 15:16:27 +0530
Message-ID: <87r225h5zg.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180087
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> A 'struct device_type' instance can carry default attributes for the
> device. Use this facility to remove the export of
> nd_numa_attribute_group and put the responsibility on the core rather
> than leaf implementations to define this attribute.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/r/157309901655.1582359.18126990555058555754.stgit@dwillia2-desk3.amr.corp.intel.com
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c |    1 -
>  drivers/acpi/nfit/core.c                  |    1 -
>  drivers/nvdimm/bus.c                      |    3 +--
>  drivers/nvdimm/nd.h                       |    1 +
>  drivers/nvdimm/region_devs.c              |    1 +
>  include/linux/libnvdimm.h                 |    1 -
>  6 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 04726f8fd189..6ffda03a6349 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -287,7 +287,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  static const struct attribute_group *region_attr_groups[] = {
>  	&nd_region_attribute_group,
>  	&nd_mapping_attribute_group,
> -	&nd_numa_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index dec7c2b08672..b3213faf37b5 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2198,7 +2198,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
>  static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
>  	&nd_region_attribute_group,
>  	&nd_mapping_attribute_group,
> -	&nd_numa_attribute_group,
>  	&acpi_nfit_region_attribute_group,
>  	NULL,
>  };
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index eb422527dd57..28e1b265aa63 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -697,11 +697,10 @@ static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
>  /*
>   * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
>   */
> -struct attribute_group nd_numa_attribute_group = {
> +const struct attribute_group nd_numa_attribute_group = {
>  	.attrs = nd_numa_attributes,
>  	.is_visible = nd_numa_attr_visible,
>  };
> -EXPORT_SYMBOL_GPL(nd_numa_attribute_group);
>  
>  int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
>  {
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 21e018bfa188..ec3d5f619957 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -240,6 +240,7 @@ void nvdimm_exit(void);
>  void nd_region_exit(void);
>  struct nvdimm;
>  extern const struct attribute_group nd_device_attribute_group;
> +extern const struct attribute_group nd_numa_attribute_group;
>  struct nvdimm_drvdata *to_ndd(struct nd_mapping *nd_mapping);
>  int nvdimm_check_config_data(struct device *dev);
>  int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd);
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 710b5111eaa8..e4281f806adc 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -765,6 +765,7 @@ EXPORT_SYMBOL_GPL(nd_region_attribute_group);
>  
>  static const struct attribute_group *nd_region_attribute_groups[] = {
>  	&nd_device_attribute_group,
> +	&nd_numa_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index d7dbf42498af..e9a4e25fc708 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -67,7 +67,6 @@ enum {
>  
>  extern struct attribute_group nvdimm_bus_attribute_group;
>  extern struct attribute_group nvdimm_attribute_group;
> -extern struct attribute_group nd_numa_attribute_group;
>  extern struct attribute_group nd_region_attribute_group;
>  extern struct attribute_group nd_mapping_attribute_group;
>  
