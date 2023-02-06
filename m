Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058A568C6B1
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBFTWo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBFTWo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:22:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FAA2D50;
        Mon,  6 Feb 2023 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711362; x=1707247362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+vD79+JXwxgmc+oQofpUVAR76ttTQIW4yi/+4uEsTnk=;
  b=Y88lU/YY6GP0XcCR9pgA5GHs4Snnldc3e8Q/ZFSZT8mCJlJlzWILjjO5
   lQnuBEc5fbgv/pVqq6+t/+S6WkUGJTTGpHnHbive7sZlOIwcEvUV8TZwm
   8jEU4sCOPcuIN9MrL55l0kgYqMO0ZcePvUBZr9tHE2419eWI+K0bD/+eH
   TqD8ANsfOjEGRupKOsP5cuegSuOfsGKcrU01mVypb8xaRm9h52gZCNwH1
   FdACH9Bh68C7cO7VACDUnszke+k0yXt4gVMjImGi2J83YGf63xV6l3WSA
   IdUmUfTrPkkaoD1w0yCsY4kvpqpZUT/0wr46LOivlWYqUUuCKdWccE1Gs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312949165"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312949165"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616540196"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616540196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 11:22:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:22:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:22:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:22:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:22:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjTaOmFdBNuOa7psWkfUpoUDoYekIsskZf9jgJt52fz2Qlh0xMUjoVFWJ99eLx5bb1LkmjZl2bNb7QZEHXekPjCU2CRBekjrpnG5Gbp/K7ETK7oL5paaWkrgZnaFVaD5aTOsZadPSr4/4kdyEIXcLHKoORLj+2a0G04HAiIKWmE0XaJEW6iNZvtdUIRu5EDTZEk8cyURY8MsGO9EjG8dhVOqiA6ekeJBY6ZJLJrcN/ORyLqgWeW9b/2AQ367QJSLHIc5StWkQytvGQffuPJ5q1I0RepXy26OYOXGR+70FTT3UWE/koetNlnCNXvZQl/1J7KwaVPDKi0fDGrfFw6ZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoUdKvY089v447fReOqxVgscrDRtMcX2KiKA6Zb656o=;
 b=T0NPS8e/Zawv9zsUakMmQgKH/sbWKuP7YBglD/Juhp6q31uSC2ZO/1QYWl68a9Ii7H4BrjuidkHJNLPoBG4eMNbY3qHa8s421ET2ezH+RMYm/vACRPLoJAMt4+BEoaPDjVnw8Vj4o5diEPSxuZ1xvylBy+7Agji4o7NzRBd10sOqc5mvaAg9KCbLdzdbFGZmUqR4Sq2SYXSCeE8Y4URBn2cXOMuLsR3CizZ8Fj/w/DiXzf81RgI2s/lh7y1XzEVm3ZI0euncKFMAR4waJPFaLrT3qau5NN5e/ntEo4L072ASsXggeLwN8pCxQ9o9GLzN3dzleMHfHQG0iMllS9o0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 6 Feb
 2023 19:22:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:22:37 +0000
Date:   Mon, 6 Feb 2023 11:22:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 03/18] cxl/region: Support empty uuids for non-pmem
 regions
Message-ID: <63e1537b2202_fa3292942c@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: DM6PR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:5:80::44) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: a08d85a1-2395-45c4-5cc9-08db087781e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQwX2oC0/MxHaXe7cusRB4QKAg/21AaWIYdwOae88fevWOBSBxqUNVt9eVpD6OxiGpSAKmjQzzuwluzBJh40b5JIXsXfN/lwBHNJu6VZAGXmmXvAgJNLM0iN//uWJsRhTAhRscIhY+TJhpAaWTPeXtrhnSDu4TlbPi+EZ00agVuI5e10kboOClTg2f1XyF1NqSomGkID797IOgJnfyBVo33gKsN/KJpwi22LY0qhSip6wnmagF4kzniVy9RSkQ1aRMpXD7loC7YQXoTKMYeh+qQwya6xDDnk9xC3jBrQu5agyYSZ44EN2QHx0CFAF2oogv4iXDNFBraeDEqz/+deHK35vLFcVx3byOrxcJo+gDMzPC1ipVsxnEcdhcO7jn42PpuyBkQA8qzEsDo0jUsDiWbs8M/SLgYtzOF73qd7vsPJMuKQsTU+9LE03YkWkrmkWGktmydw0XxAh7CvYxFd0mQPQdhL6BkBasVKOhhySnkDfHtLqokWuNfy1fk3BexXkudxVaGLCbgRnDHJ9eP4k8iCFvP6rkt9HdtULj8R83oTu9xn4ueAVLMsC7/Gdqu4Vk52uioyCuLNvj+S/dZYrHH5fhmyj6/GLxmDU622zLtqPsuVadaGf8mm5ACRH/lVSPSdadcNUK/D2weKQ7VqGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199018)(186003)(41300700001)(44832011)(2906002)(4326008)(5660300002)(66946007)(66556008)(8676002)(66476007)(316002)(8936002)(6512007)(26005)(9686003)(6506007)(6486002)(478600001)(82960400001)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0n2px25OCP/Sc6mAV5l4GP/A577ItXWoLekUQ5FmXLhNyKnwzqPeYPJquPkP?=
 =?us-ascii?Q?suM2U0RlEDJ4wAydV8TLnyFl492DbprOKTDgqrw7HGcYo2KzG1yT9yO2PJoX?=
 =?us-ascii?Q?z5NnYZooBRD2E4OEyQTyXHGkbqg25oOJWKE6UTUF+jg04AEOvmUaGxuKbH/M?=
 =?us-ascii?Q?qq2Wz3hWARsRX/PoDzXHco6340k77LkDaAYC6kE0VKRJhwphAHk791+CiWYI?=
 =?us-ascii?Q?huAXgxitkM9m5qkcGsFkku8TyTnKHVnAtruKoEBV3pPr9KrTFRexpUJZu1Dm?=
 =?us-ascii?Q?bfDFpl6fz6MYa4eT9a0udybvpo1uoPncybV3mELJFUGT4nN0RwMUy9x4ukux?=
 =?us-ascii?Q?xCUwyeJQIynbJC5i3Pex7doi0OJEU9UUJOQDR78b7B6sFgaod1UzkAwLfIWn?=
 =?us-ascii?Q?iPiF44Aj7XeyOvnpZSPGOQvkkVzwjsQojmwB2kZLMcyYwspU8rsCDH3hB33J?=
 =?us-ascii?Q?Z9agAkc2mDkvJstkt6CDXS+Kdk+fHX3AALRfZtPrbYt451LSflwkPWc71Wcv?=
 =?us-ascii?Q?qIzQYLj3D2iFXmTb6+Ll0ZLCLIqD640cw3uRc4L9oS8YzMwVUIJuSsTha1En?=
 =?us-ascii?Q?094pmWGHgEZh5hl0sCuVGlHbjtpUDZoyJ3aa080WN0wj26pj+2VsjOXKZ5Pt?=
 =?us-ascii?Q?rQYmLpMj0z5LdG70x/15uvvKH8PIOgABAzMMn7Y/uc2JzzPi8ye4nQx/51BG?=
 =?us-ascii?Q?q8isvcyQEIwqvdG+8Ei8ExdDuKNbAcxLsWfgll73iSJsOGaZN52/lheKuWek?=
 =?us-ascii?Q?FECHUn4wlQa9cH7TZGHDM2bYX4wlA6Ql0PZlNhs7PDjpoPwCABc3TTWQ3AqZ?=
 =?us-ascii?Q?iaSkQGqhMzWgSWg9hCLbUl2dXkCIocm8y9+0UFtHjk/GpqG+EiTJ2XWhmVsZ?=
 =?us-ascii?Q?v7QWVVljNqUI7Zr1D0FcIXkqd6gEg+uB6U/t4xpSziQvy4N+p7Ou+2MY9QJj?=
 =?us-ascii?Q?E5Q+lKC5yEQab6sJHsCGzUjnt+J8q1/Cwu0/4Oud1wwKt3eTH5LChIpFf4fo?=
 =?us-ascii?Q?efflq5er33QAXZec139PzOINAZynmLS2RayD+45RE4vQIv1juSIaDo5KfnEB?=
 =?us-ascii?Q?er6UW3tIwbIqPO8Zsnqgrk5/MoCp+aXenGoAeojVMqu5uZIJ1yMCpW3unBvc?=
 =?us-ascii?Q?jF3VznJWOKmtq41TCQWF+vzPdjcdzNej+OTzGU7QUA99dx3SLbaY3cF1y9hW?=
 =?us-ascii?Q?gTa72+OofYV0zatm/OfONIY//bZG0RmTCxENcX3xn8r6kTboDjzGkBLrdaaT?=
 =?us-ascii?Q?JrPQFRbHPDHdOp+lKsu1jGJU2F9WxrJJ1Vj6oMA+Yc9elbZAZlT7e4kZhPTV?=
 =?us-ascii?Q?uIk7Bx3tIJg0ZOmdqSFN7DVCSYEvOzaf5cHF5Akg7J74aTHNDide6VuKXDFK?=
 =?us-ascii?Q?dUB11Zjf0xcEVc68i3F7IButiwP+g7mGxtPK+xL0BsJ8Aw3M2Z+UCHVXDGae?=
 =?us-ascii?Q?1Qsdad6MpszqmQIilaBptmWL1TXhLzN1y70nIFzkzSQVT84YJd2ZrpIb1tPo?=
 =?us-ascii?Q?WO11myt+02tFc/Ofb8f+eshx8Ye4V1+/iaHvP4I8BAIHh9qwKtR5NHxvY9Ri?=
 =?us-ascii?Q?Lmmibhy7Kt6NeXF5dlsmiHNGknjsElwstcvFsY7D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a08d85a1-2395-45c4-5cc9-08db087781e4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:22:37.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/xlwljxG4OxQ/8qPXtUFO0p8ImYNlWxp5rtS12RguGtVh7rNU7p2V2ekkSB1ZqAvAAKI9aQ4l7iYYNkJQPtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> presence of regions with the 'uuid' attribute missing.

Would this be more appropriate as a change to cxl-cli?

> Force the
> attribute to be read-only as there is no facility or expectation for a
> 'ram' region to recall its uuid from one boot to the next.

This seems reasonable.

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |    3 ++-
>  drivers/cxl/core/region.c               |    7 +++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
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
> index 17d2d0c12725..c9e7f05caa0f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -45,7 +45,10 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	rc = sysfs_emit(buf, "%pUb\n", &p->uuid);

I guess it all depends on what p->uuid is...  Shouldn't this be all 0's
for a ram region?  Does sysfs_emit() choke on that?

Ira
