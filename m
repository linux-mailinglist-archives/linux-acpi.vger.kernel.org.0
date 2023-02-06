Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BE68C5A4
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 19:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBFSVx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 13:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBFSVw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 13:21:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438D72D61;
        Mon,  6 Feb 2023 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675707711; x=1707243711;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ueWCIPRNQ8E4Kw8+JHWF3lA7iJiIkFYkSDnWVLXDmBc=;
  b=Q0oednPXoghQR+ycF28fVvFstflWYN18x1g6L/WUeuIzjls+J7MqM7L8
   Oj/GCx3Q7m/GVH4ePpAgpQh7cZtUyLZggpN1AqV4Nz1uJqj0DcjR661a/
   NZTkkprQbSwRdqogp9DZC3eooUvTzjNmRBqZHQXIX6gwNU5sOSdTsF/L1
   +HPyu5lpSpSMIhKDHHi6gobYS7nHtZq4aaZIrHlQExpzglhHnUbrKNmgZ
   RrCSyb3A1SHY7WXRxefcue2YLe+NUfJ5bLv3I0jK2KUGReoh82Z2RPMjb
   wqpw1vMxaSj/UAYO78lYtL8zN8TgK6eD3qDw9q/c6/Oe5FWTj4lyQpm9h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317290070"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="317290070"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644128717"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644128717"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 10:19:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:19:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:19:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 10:19:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 10:19:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEYvK1aANRN/+jNJmjMqDJ15oJcusSjfPwRXBf3EYqccp1UW0cRc7gF/LyLQD7BKmQd2J7kXwtNzzsy5OkeZDk2xWUGesZ2WwTnz3EBXjh1drClTQ1Ii60sqOSXqBff18k74iRFckQx2stSr0ziXMLj8BYiFD6cDSVTWQ6KdTvdZLWQcvTAAHVknokZrZXjv1A3L+K32SUJyqQjO5YteYliqRjJoL23vIMbsLQ4aflf6wFEcvreVPvUFKEVAZpUTqetgVx9SQe9hdKcu3oGsUdVoKuQQjqH8vqKfe2Ry5oDF4dxVuR1qGvaaePVCgp89DA4xpMArWvFKcuHl53YBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGnQTmqpgLALJ+YIMLxLyfxPYplfGjWbP4cqPP8/8jA=;
 b=kugqh5yKCgEs2MlDBEySPNlcyXfz/xuk8LD5dM/xWvX7Lg2RF+/IXjiU7Elhls5S7J9rNDkZgWIIvt0trq4ALYPWIGndBnlp5OAM6WtrnW2z4F2udUiflfM0UdOm2C77ias/udTPvdyQabaKk8QZBLuSdiwt/+llkucR7ekQpkABdIRwXaoCZRA7QnNbeJM9r8gyq8WHuPE8rD86g+1ArfNJjUZDMpX25JdY5MJ7qRMDtIdHqKC9Wg66bJvk6LJ4quVpSGmEypefOr6v3Ei8ZJ8Trar81/uSsZPeYLlDUhAXni/NMcQlJU6hv/3t0yMxHKR8hZymASWOHfPjEQN/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7780.namprd11.prod.outlook.com (2603:10b6:930:78::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 18:19:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 18:19:50 +0000
Date:   Mon, 6 Feb 2023 10:19:48 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 05/18] cxl/region: Add volatile region creation support
Message-ID: <63e144c427f0f_e3dae294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
 <20230206161804.00005c47@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206161804.00005c47@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cebd63-7ac8-4daf-9d96-08db086ebc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crCISpiJIz6TxOE5LgTBqXBmCzWv3LE9VhGGdm2G5WS8T2AX/DfMa6x1b9yx/WjMA19+Ukp/f3XpgZc/BCFW+ZyMy1W4amZV6zoMvJYJTZksvGecrJIyWRMRrH38/iTXz0hLdUHYReDxbBldoQ9xOmXeTVYLlxummCLup1UYRWionRxgoVF6mltFMNiRBwUBgyR8vv1Yc04g6yW39H/hod8GiKtv+elhnDZNHV9TmSuRXFH1XiwOx8Fdbu4PGt7hG8/i8nTPPy9T6f4yUeykm35h3bARET3U6WUkTFogX3s6LjSalGAssBJfkRgiSJyJw5JOGz9ZlDCMLvKFYv5jz84VuRf5WUKTYq3A6KRvw/DxBfjWM2ZQtUV+PV9M3CathMuX6Z9IuO/9fEKdtNvOnFZLYoX1PpTt78Zy14xy3sbeAyMjftWZHVjy+5+uEDcGY9MAQeOhnIQiULA+lvU2aQs0By8dcar8+Bm9ZHkC+CavadT7GIw1z/pEBjWFHOvDORE0IFtvtYw1DKJavckk6h1Xf9NMLLfTAwKd+ThLiDTV4K5dKQB9ZjOVM6bbEJPvLYKU3dMf0DL626Gd2jb+JyA8Mz0UncUPs+nM1LeB/4aBtf00rxMcezLwvFINo45weNWfm9ROqd1qujQdsdA2hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(41300700001)(6512007)(38100700002)(86362001)(26005)(9686003)(82960400001)(186003)(8676002)(6506007)(478600001)(6486002)(110136005)(316002)(66946007)(8936002)(4326008)(5660300002)(2906002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WxOsSj7XDHbCgpEMuf4XdJHpqqLtOhs8C1COIiWwdNw6wZVKucSDO2XeSEA0?=
 =?us-ascii?Q?l0wlpWGNbrE39+JNDawwilyURm9Fu3PZOjUPAjokmVZi+KmAC4PSSVVGi+5H?=
 =?us-ascii?Q?PBXHQQSfx9yDW+dgcLEcoEyiO+pKNg92WIFsLvKhwRJhBWqYb/cxyl1qg0q8?=
 =?us-ascii?Q?hqvSxb+MkCgI6hbFc/YdaOWk+zqvyU/ogxG8jTGGOjsOjpa3ZosLx1rMNeSA?=
 =?us-ascii?Q?lPDJDCaX6VtM7k1bLiAKkUWKtjgaBnDZOOpBXX/lgRC5mHMStPRi+ShOTJC0?=
 =?us-ascii?Q?Sj2bUI+o9XNif64bAd/MnU/OudC/TgmErgc5YnvWzN17ECnZ9RIGof1j5+Rw?=
 =?us-ascii?Q?sBBzN5mXtG2gGl0EhO/PTsXMV19sa6eM8ZHp9/SoUFvZtSMhJFH9rBwho59z?=
 =?us-ascii?Q?Vvr5UhpD/GCJuOgLIGGwtC6ki22Tt5L11GiHei1CLU23sBDlXd3LQwtx9wnI?=
 =?us-ascii?Q?lHc0KJo5PmZUmhQbkSEaGgv5XxJnzz5OUAsJ+z8hiDv50hz1DHsrPO7DcN4a?=
 =?us-ascii?Q?lu/JCl/Z0Jc9yfe6RtEdJIoE+wqRrC5Iq8KhmnQcgMn6O2u7d0lixoN6lEJV?=
 =?us-ascii?Q?a7Gdl9skkozZiiJMgMHNPWul5avv5+sDdMnUuRy5kRZb3fi9dAFhXRRddrAW?=
 =?us-ascii?Q?XcdFUTv0spTkTRcb/c6COhhx5yy2A45b88o3y/Lsy6c/UfYvmKL1vJWtlOyr?=
 =?us-ascii?Q?KXTjkvfz2g0YQoU0jNoHckzw4wREeCE8o/CXKGqipWEg/eNoeBUyy8B57KZE?=
 =?us-ascii?Q?pXz56OcrTDhltnfUJfDAkCdoc7gUEIPXnSxKFkTfFBIYtRz6unQiGb0+9Cgi?=
 =?us-ascii?Q?G9nCgNnqY//0jvBTqCYo/+JJxCOByx7QcgDjQ5fuVFYCfrtij8K5QMw1M7DZ?=
 =?us-ascii?Q?jG67S/ZTU3DvdQJXD6DJVsw00qVp/HXNT1CF1n3DRZTt/nOiwfdC5yS1MRT8?=
 =?us-ascii?Q?csk2mcW/aF2p3EYFXWvV0lZHREkLVPu0uFfyf/OdV2QaZgahNQCVmvYfLeM2?=
 =?us-ascii?Q?x/Utw6nbQSucC/MWSMMBpbpdofDOXobEjx/nwmHogeZ5RGSNS6rIBg6g7eIw?=
 =?us-ascii?Q?nL1CUFDOUuG7DqmgcB58Lc3o4E9814OctmYXiywJEobTuo9Jb+Ha1qKbx6/P?=
 =?us-ascii?Q?+CcYUxOZHhqie1OGiAF/2ZCM3R5JspmOeY2YTimpBe6PxqnSRRJXn5xerM8w?=
 =?us-ascii?Q?ORhVVmJhTiZ5BBC/m72HC/+kwyW8f+wdqy6JMJCuhWnyU2yGaHeLgZkrso/Z?=
 =?us-ascii?Q?fsFD5xYGNnfPxTJoUjTOO7miEdZDzFgSNhV6FdiLwglEgXvEo2IYQcF7VzdQ?=
 =?us-ascii?Q?V93OoAHcbHiC49/RQKRBiG2tGbS3ED5V2Fgjk2UaTrmDPTwzWOP8Q6reC3XA?=
 =?us-ascii?Q?E1foSJ2nzv26o3Z9fUQo0gbRw4NacJXdmmaN2dKd23tkjaoo04uUox0nUOaQ?=
 =?us-ascii?Q?i3Zl5ZqBfsHeBoXd7yG4dNJY0jZELDGG/RimthoHK2WC0xfXXewnUDQR6Yxw?=
 =?us-ascii?Q?NxLrfM4PawgrwbGF8uLct8Qru595SOCAxIpHGqlzkDMoDziGNS+TNl6WHPYf?=
 =?us-ascii?Q?k0izgy2e0mV4mrCJRs4vHaedEF22LcQN2CAkGjEc1BDOxzJwQYqC7TZ2ecfr?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cebd63-7ac8-4daf-9d96-08db086ebc5e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 18:19:50.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQQiSa9ZUYQDjrCZLpSH5ZgiWEm0s0taT3eH5BO46hKAbNIr6T4VhJ9vkr6k7sncsydVjOzjiSbgfTCaVsXxsT8qrabn5Gv9eSiPgJrj95Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7780
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 05 Feb 2023 17:02:56 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Expand the region creation infrastructure to enable 'ram'
> > (volatile-memory) regions. The internals of create_pmem_region_store()
> > and create_pmem_region_show() are factored out into helpers
> > __create_region() and __create_region_show() for the 'ram' case to
> > reuse.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Entirely trivial comments inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> > @@ -1727,29 +1762,37 @@ static ssize_t create_pmem_region_store(struct device *dev,
> >  {
> >  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> >  	struct cxl_region *cxlr;
> > -	int id, rc;
> > +	int rc, id;
> >  
> >  	rc = sscanf(buf, "region%d\n", &id);
> >  	if (rc != 1)
> >  		return -EINVAL;
> >  
> > -	rc = memregion_alloc(GFP_KERNEL);
> > -	if (rc < 0)
> > -		return rc;
> > +	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
> > +	if (IS_ERR(cxlr))
> > +		return PTR_ERR(cxlr);
> 
> I'd have a blank line here - see below.
> 
[..]
> >  	if (IS_ERR(cxlr))
> >  		return PTR_ERR(cxlr);
> > -
> 
> Just so you know I read to the end!
> 
> Spurious unrelated white space change :)

...and I can't even blame that on clang-format! Will fix.
