Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB682692B60
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 00:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBJXhJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 18:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBJXgt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 18:36:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC85840CC;
        Fri, 10 Feb 2023 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676072160; x=1707608160;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wnaszuPI4ENX6eV7n2PLFQK40JM+W5Noj8GOoSVQCjk=;
  b=dWdVHWoaL48ZNKmzzB4tKVw5nqe9lmhi8OcNLS2NS4V48zdUGpExMzSf
   T4pMbR+B7zLRHWEyab8U694a6zP37t8+aAydwuTHO5kQTuF6l49M166oY
   p/rDeU+qdTIapqic9zdnPji6yUGTTWWC1thxEosK7wn4k6ByINcEOUNEK
   xeIxQHLY8voU4tF9Vv+3dhSEd21XxqH8L07s6dYoORQLkY8/jtR4JBIwT
   DXYk+sGqUwBNHWr5T56hXukO8Gs5x3px3YnbG3YPvxM+CYVNSPwO9e7wd
   cW2mYlaBJWnZc1l45YXloqePDucm9Dq9SIKjDVGAyWDjwU4D4TncimYFe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="395165333"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="395165333"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="618049765"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="618049765"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2023 15:34:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:34:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:34:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:34:49 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:34:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXAdpWxy509CD2P2fZbB+qDkGymuB0V2utCoSM4fr9kCAY6vbDy1fQJTE4wMW1omI6RpaiickMi91WqtZNJdyIECk37KzYP4EagU3Bu5RfQ336Eg6wVHqlwifcSVBQjEnX26iKEc/pdaAaNdwPjumTzRRcX4OQ10mUM66NybMGRtsWgLr9DzBC+n8pX1o9bcJoUY3LmAsNphdbFl+8ACsS0BmhfIzt2qUB6wMxnXNPJMtDxuw/fOsP8ND5yAfMYKHvEd75jRI6FvVNQEO0ojHAVycte3g9HN6VrumjN+42SDllWpKeRg+GZG+kMBm7jO4cq0hGvlF1t0u8H/Qm4NMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEhCgic0uzvVqDmNp0g1Og9BKbkwBz4OjbLERh5mB/E=;
 b=VoQd8XevjNcepoDm9vBdGEtd9dOy45DctLR46/UPudEH2mGcCSPtSRwb7k40U42C/2TrqX0FtZXow9N7rzAeVM+QFbZeCT+TJuc0LEHI6JhRFdWcq3sXcHD9XaKOFpTZlBnmRk9Ul/pyXhN2x1GINREuIezVdAaBS0B7dHw6/Z1dXOmg5LbGrQkSgvU8eCNh2uhoH6xFleElLwgqta9o4jjWBIx7Pfd6Yq+bHzhcy6TSrEuGsT41CgK5Oq+GzeddEERRodB3p5rqvpSMA5AW/ivVYdw/uLoWGMAmcCtETg8kjT0ubxiaXv2nWy4nrBEMxVTecwvKijrUEzkibebyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6434.namprd11.prod.outlook.com (2603:10b6:208:3ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 23:34:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 23:34:35 +0000
Date:   Fri, 10 Feb 2023 15:34:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Fan Ni <fan.ni@samsung.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 04/20] cxl/region: Support empty uuids for non-pmem
 regions
Message-ID: <63e6d486dae75_1440152949e@iweiny-mobl.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167601994558.1924368.12612811533724694444.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167601994558.1924368.12612811533724694444.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: c717942b-da56-49c5-5f82-08db0bbf5e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iZjisD7z5iokWMPJ4XMyL7s0heNsTq8l830Schs8nzTDjNxTRjKgI3wp8yrtOXgwvSCawGGj+exTAY89ZYS7NS74MjSe4MjicKZ2g47Ybn75fkGUy17vwXyfI09ZpP07nf41hP7vsxAUU4hugAWG19RPXk512h9nOtJhSdRMtJdKea7NOKQM5swC5ZgicncboPwT8J8R09Iy6rbFPDOlrr3+UCgxpwPAcSDcueK43aR1/cwZ+BudqEfwxe67ryRWGfBo7WaXyjW8S1V4gz3n9iLZ7SlV2U/JMxXJ8+yj0GgjUsHo3T/5djJzHSXbZHrWzxXMANTeaYfGct2R+XWSEZKEpirTbeOPhnPll3wwDdbyh36ughZ1Nx4lKgSmTPQsyuXVrJlG8UrrGDMKq5g3oSerlvY/dQffiU74HfV+m4e44FCohyelSyu6QwcdvQUEhZwKj4kVaBZGkcdMJTdRvfWO+sKFFBN4A4Bz3Ts3+xH2q7JXBn2QooIO9tPAM4zokf88RAVSs61N8qa1q/NlQXgaXuGJBTu/S/eEkZ7UMNGCADJ9zH1N00/cZxcogblcfjzRkYr4VPq3EJ1+J4XCEZejGa9ocrjkpKjQiOnbPWny/Pzy/ZSDk77NTh453KxP7dTaJlB7bKL66MzBNQXeF0S04wTwkMOWGKj3kEqi40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(6486002)(966005)(86362001)(478600001)(6666004)(9686003)(4326008)(66946007)(6512007)(83380400001)(44832011)(186003)(6506007)(26005)(66556008)(54906003)(316002)(82960400001)(41300700001)(66476007)(8676002)(2906002)(5660300002)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sHwpviR/XTufoT86EUY/qeCvo82VT8FnWGIV5Z+prPf034hI08hQetLJLhq?=
 =?us-ascii?Q?BMQyeLfLPhy1icnQVhkWSxPtM50tHGwvok8S+hiQCSVA9eQSSmmsOpk6UVY9?=
 =?us-ascii?Q?aIuhq9NXt1f00+hY6+jrecuJqEB3pB4q0EEp0zOarVf629WkEJuNpO9uBqWT?=
 =?us-ascii?Q?kXpcvESCBfM3opVIrJF0mce189xwkrU5yx1NsqUvHD5T6rHN3zJE/3Bhc9K7?=
 =?us-ascii?Q?MfV/kbZ3jDReCxDpShD8XNGgBXFCh0xIVGy3fU6hZC0gigFGdRr/k7ifVwc6?=
 =?us-ascii?Q?g5KRNHgfdL85O57Eyngr0H75q2piihysCTsc4i33rMf4L346e+dj9wx2fGmS?=
 =?us-ascii?Q?Vwd/NtIRIJuAlU177i1ujTsJ0zc55wmERknzwy3lNeIIQzxeDtyZ6aaYD/L4?=
 =?us-ascii?Q?zv8IxoHHF6KK73cMy68FqiX6CMsydRlo8yPJKHDjJiagJy3hrLz5vNNZpapa?=
 =?us-ascii?Q?BvTFhN2prdsUbhevqKq9SJ+d1zKT/wzvc7T2+HxXpmV1EHvHukmy6eRdhcy7?=
 =?us-ascii?Q?5OdPH7Rf5Vd75JXRifcpzH9niueZpAxB/sHK5VFww4KdPEv+0sokRuIZIO2e?=
 =?us-ascii?Q?AYORAgDGJkWQCx/SwFGdHLMyYN30pEPQBFqmRlTbbrcz5lELEkzO0nPfHHx7?=
 =?us-ascii?Q?KtoBTAO7OCbhsoojkLQDjs+H7PtK27JaVFm4YzhXlMz3aWS4AvfyXVmTlE5t?=
 =?us-ascii?Q?My8XXLCPu5AIQEl5WJXf3e/gEFQRhhhKU4Y5lN7HdhIYKaIFwEaTP7dQLiGf?=
 =?us-ascii?Q?2icY7WwtMjmYf1Ten9tJ4KfhciGoNcITb9mwTFR2jfCqvNFRkTNIjpYuGf61?=
 =?us-ascii?Q?z6Vk4S4k4w+DY32ScYJjoyWmKrVoxfMeOfPrlvsKUMtPc+/RITGm1ckEC5sU?=
 =?us-ascii?Q?eawgy6ak/f6XDwrMf3hzDsWJg8imc05Sy3MTMPPYvaKATg4iL82AHvFoSHo7?=
 =?us-ascii?Q?EhrJdZnOAf1xHBjvq/0ERgDJhaoLphen/7Atc5a6bD/x6jXSkik0nU6Z6VUT?=
 =?us-ascii?Q?16w69DaWaPcqJaW5yMwiVXG5oc/zKp9peoCxTpMKxSGGzv9FTCormc2jJGUu?=
 =?us-ascii?Q?uH1kOucoJ+4xVUQRjj0AXwjl0lRtjyZLK8xAp4AsltqLWy47WzjvPC3n3PiC?=
 =?us-ascii?Q?A1B4LHHixe0Um4uYRHas2NQuT/0T6hSjn7eBwchJ542P5FJhKM4/8eNKr/D4?=
 =?us-ascii?Q?c2BTkCnrqVzMrim3FObpnYydXaxihtLzZgdAw1xXTG7kh+ebUcVw7LFAy7Us?=
 =?us-ascii?Q?vE7jZDUghG8KL1Erp/XNdECZqVBuJ8YSOsNBx7+Vdq8j0UfxlXC6/g5xzR5R?=
 =?us-ascii?Q?Ed9SHhOglO8MNUBSA4iijV3cQLGhCBl1xAzEvR9ltG7wdfoJZZJDj6DICfod?=
 =?us-ascii?Q?PGzCd4tE+VQ4XCP1edxyt3eym5HjE/UcyDzS5VwXzJveOEQcK7+740bDre8a?=
 =?us-ascii?Q?Wvv2z1Z3gzXaPz3QsUbuZdLj9cHOqWBfGI815ROzXQurIeY2W4sJqUsqJ4dL?=
 =?us-ascii?Q?s9MqEJMNZQIjWxzx0o3Hv66riOn3lbSQoon3LfDECJwCCH4pY/imZye/coFY?=
 =?us-ascii?Q?wr8FOtMbEnDKzVFxGd1EpGh2gbincEzKBI8OhWKP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c717942b-da56-49c5-5f82-08db0bbf5e31
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:34:35.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjDgsM2xWzrfmwXC3/eF7D2BlaR9acO1gKP1zP1W4dcRFlqCDoClKn91W0uwgmLCe9ZH2CvLtp+aUztmN0uD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6434
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> Shipping versions of the cxl-cli utility expect all regions to have a
> 'uuid' attribute. In preparation for 'ram' regions, update the 'uuid'
> attribute to return an empty string which satisfies the current
> expectations of 'cxl list -R'. Otherwise, 'cxl list -R' fails in the
> presence of regions with the 'uuid' attribute missing. Force the
> attribute to be read-only as there is no facility or expectation for a
> 'ram' region to recall its uuid from one boot to the next.
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    3 ++-
>  drivers/cxl/core/region.c               |   11 +++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 058b0c45001f..4c4e1cbb1169 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -317,7 +317,8 @@ Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a unique identifier for the region. This field must
>  		be set for persistent regions and it must not conflict with the
> -		UUID of another region.
> +		UUID of another region. For volatile ram regions this
> +		attribute is a read-only empty string.
>  
>  
>  What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 17d2d0c12725..0fc80478ff6b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -45,7 +45,10 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> +	if (cxlr->mode != CXL_DECODER_PMEM)
> +		rc = sysfs_emit(buf, "\n");
> +	else
> +		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
>  	up_read(&cxl_region_rwsem);
>  
>  	return rc;
> @@ -300,8 +303,12 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  
> +	/*
> +	 * Support tooling that expects to find a 'uuid' attribute for all
> +	 * regions regardless of mode.
> +	 */
>  	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> -		return 0;
> +		return 0444;
>  	return a->mode;
>  }
>  
> 
> 


