Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88468C6E2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBFTfk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFTfj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:35:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A012F0F;
        Mon,  6 Feb 2023 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675712138; x=1707248138;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oqjZ/kwC/0nJt2A/HRxQiNEDfeE9+7/yFmx6DKXuOWE=;
  b=ahTfUxrxtzK6lFtw77idDZ9ZvkYPh5H2eXzt6P2Qb/GkGeeOw2Xs0HRq
   IUC0rq+UcpTi5SpLJZPmEHaR5B59BIr2ty3XoZOvx1YC/LzBCEKXw7iEu
   aJLWBeVtHZGbG0jbN8JRSgqAxCzrKp+HuhRwMN/4gNYRcjO7mPWbu0Rob
   XHeOdO4SWXEw9KxPl1SSCVhSar2wgH0WjccnflfU+zmx+CQY67p6jIQI3
   la2GMzKxo+nfq0us9gISYOGWuvMsmQ4a7nBeEbyLSVxdzV9CvYRLUB28W
   /3ueEptmmvjcPFFNDKZ/1hJqqofARYdCVMzugrECYTSFXCzUTKiJRnAq8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308942414"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308942414"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="730114636"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="730114636"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2023 11:35:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:35:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:35:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:35:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:35:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSErHx5nQ1hmvLWFxMtum7CcJL4EsjE8qgACJM4R9KruzWoOPWh/KqgAF6yPTbWJYuV5kMT81pGLBFLPFvc3K5LcYlt7JPus84m8fjZgAO4RCPiogBbbuNKKZdnzbtQbO3y+U3wrD8pTKQgB3qJLx/qt66Aa43IxZGn5qZcHdKYFOCNM9qEzK62zx9qs6xvOsbktIouukiT2C8WKzqXdu1Lpf6Kp71QOviGiY4Xl/bay3CV/rrMRTLaEL7bV9fzPXHIBPaE3cNh7IcUyp7rImYBLFkDFl1LQCo/YsOIEByN4nISpRBOKyviqOATH3m+BZOQmzt3yk73JF2slbNTJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3EsSf5fANPO1MDZQl829STvjFtP9G9yVA7eQNGQNas=;
 b=OJFazLgMG6mbAIuXVRjcHLdeoL5n1cT9zO6YNe+QWhSby8a5iTQnDO8wvL9pIsOz0L/7d3n7WPD7vECn3ORo6q9WUZ91m+6tt/jJBUu9M9s3xyilAwXFPocla4GQZekTNAKSBe0sc6aH/vxoSprf7PnHvs0PTH6PJz6BanA04NJHUvLXZ5MBedSMxCynj2V7IiZaHVazBk07WnDPEE2s43lHyL16jq34gLRzet1vOseQV+ksSDNMFHRKx5NoN9yw9Agu03zcsVZNAh0GNh3ZYB000a8z2p+qXj9qakZKKF4QA5d8Lh+Y9rW6pgOvwMlz2ecs+EGjTzk7KIsjbg1okA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 19:35:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 19:35:33 +0000
Date:   Mon, 6 Feb 2023 11:35:31 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 03/18] cxl/region: Support empty uuids for non-pmem
 regions
Message-ID: <63e1568362e28_e3dae2949@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564536587.847146.12703125206459604597.stgit@dwillia2-xfh.jf.intel.com>
 <63e1537b2202_fa3292942c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63e1537b2202_fa3292942c@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5d2465-353f-44c9-881f-08db08795040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDD/Bx6/zHbwjMCKooWBVMtzjO+UCkUIFLibMA/H4w/4S1y1XNoMHqbeVlZxSDPpbAHsQ9DbtC/10Lr1Be5Dv5C6Gb4jwK/OXd9TB9ioU+rNeSa36xwyIdWyCOn5uSGSY3Te2aer1vK9yO4BffkGAijB8YO71K/jKVa/QL1+n0hw0DX+i9IVz4hnY9rpYbDY7SgQKzuD5PPRRCBC3s/AoZcW5sz07N9klSaUI8bNRYLOlDVnPgwJ9L3HzCyDZilStVgCgGrzt1WhuOuzveyaSkPV8EEHK3SQ3Im4CvrcT2OYPLNJJ3OjGfhUhT/wo+rrfwb/Ke1RKyX9YdK8kKYU7dOaiQ99CftfbSQu6JM7tTYuuiEH0a7w8oEQ1wN0BTvm0/pzN6Cvza7NPjgVZlzZtYu047U75ox6TfjmIeuwVI5CL1zG94pm+sDXaKfKyfRWSLVcI/dnNLsygUQm5LQrckaP/cYUTyJR2c4Mp9V5Gh+NtqZTe7X7jPc14U8Fx2DC5AJXDia031TVjmdZDAot2sHV0NK8v4lUa5kJ4wJr5qHSVOMh5PZEyh1TPLKkO0eMjVD+ozsvOzA4NHGY7jnSvkeBuuYQqNgzcAM+/Z+kvL6wP1H0Y4NxbZdrOP5l9G9Jx4U0ptUPMYKALM1AVVC8o3lG6FyTDh0NaS75eSefW3cyWng4mqe5MgVulUHcBZH5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(5660300002)(8936002)(41300700001)(83380400001)(2906002)(66476007)(110136005)(316002)(66946007)(66556008)(26005)(9686003)(6512007)(186003)(8676002)(4326008)(82960400001)(38100700002)(86362001)(966005)(478600001)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KqLZc2p4E1s+n71rJ4gT4ayLsh6w4+L/kFCzctXUk4ZJ09C1PKRSgQiiMEV?=
 =?us-ascii?Q?DBrI7vYhcRS7FgxqO+3nIqdkMMDIOMl1gmrNMebDRhYJ+Ijb/fJIn9cDSYRV?=
 =?us-ascii?Q?4otdCjy6wDeqIqH/NmgloIhGW692+1JkpqnUlOgaFVF7Bat2B+pZ6kYD0I3v?=
 =?us-ascii?Q?mZqxOxxrSE6RP23AvVSadMqOf/r1lM1PQsiJwJE3PZnlrnKZHgXUFfr+CzjO?=
 =?us-ascii?Q?qqfO6K7Zf0pIQkaf3su6+PFKZe2PtGs7Ls5eVQG1TTdedMJGPYLxRTayfMjR?=
 =?us-ascii?Q?wxIeTPwOUN+rY8jD+5CgTHmqxmwKsZShsfQBpxEPHb9+9VXvZwh6OykN5Fkj?=
 =?us-ascii?Q?AiJ+DKm5EBGc1QMxR+8INzV7k8cJ4rs38ziqRyRKju8b3aP7xbm+xV8kBHUW?=
 =?us-ascii?Q?sym7SLA2Du5xPNDDu566dQau8pEAqeU44J+Lnbf6ADLW4hw5TfnZ4YCD9Qct?=
 =?us-ascii?Q?wYt42N/BGnYMS6PBOV/L+6lUQuKxJzzwYdue2ZjGEZzvlTXEdOuksb2N+PPY?=
 =?us-ascii?Q?LU2AsD+qgsIO0fdi3cmg4+mSEHCybQt1CTeWz7q34b+13ldr/UePdJSV4WTA?=
 =?us-ascii?Q?Yin1UIgSSNKBbq84Fi1cePE8vwPi0fJ97T4zFlcDhrYAJYzT1lQW7dw/d32P?=
 =?us-ascii?Q?R9ajI9pYRvDK4+tLLQUF1b2Ro2dnfqPLWLH6en9GXLXjUg8Q1z81M1v8bPz3?=
 =?us-ascii?Q?s0gOPOBWYgOMuvkRTcHLkYBj0S1+MWlwCQG44Pcr2sQ7EvNv/RqIxvCoJ0jc?=
 =?us-ascii?Q?A40LcBFdqXHhoqncy9V4QU7eDb6J51J7PKyDSfnc9BD3NG608FtWzYv3nuFH?=
 =?us-ascii?Q?VwiuBzlBNiclnmin6w28LyT7TIeSIX6VY5KwXYrWqNmNfyuiLiRNqrwnCIJ0?=
 =?us-ascii?Q?88E3vGFSNcN7Je08pDn+OcfmuDU2er+OxMvBuPgUw/wj59T0YOSe8Xlmgy69?=
 =?us-ascii?Q?bcyD6GYTexH+vjnzMrZca4YNAOzz7Is32l31umrF3IWM0RqeLRzsXgJoj6Gi?=
 =?us-ascii?Q?hCLU/MwmFjplyXUQ9SDyIgLP0VOu5qUa9phE04sBUR9Gkq0CeoBiF3fOi0EO?=
 =?us-ascii?Q?zgRenkV0NtxZxN99E4FB2Ti5cuQS0T9vw0PcKsn+Zwoy7MlkRPbl3NFOsNWN?=
 =?us-ascii?Q?6nn620O/W9nqHBFfe0WCDpPulH70UKC/Gck05jOb631bY765OtovTWcBMkMr?=
 =?us-ascii?Q?VNHiMYmMPaa45DYQjyyHHkSJPmpHYcY5RIWKNbJByg6CWOrtwzVWMss8uWc9?=
 =?us-ascii?Q?ChVnVvVhTStd57mxiThf1d8IXMnmGbz16f4bmk8u8XapGvXSvvhmkWpU/XSM?=
 =?us-ascii?Q?BpC5NWHlyAkaYPnWZgs4nefxk7Kjq1tfAl8xcbrwYREI8WUsU1wcj9uW2cxF?=
 =?us-ascii?Q?1hRKHpAdLUNtQhVlA+v5Dz/2ivzIlEBRnw/OyB37gzdO8cjwCp8WNtriCQxH?=
 =?us-ascii?Q?6MZcl/xzIECMiTc9nsGkbOm/NXMQLmIdaDwGa0FCghs5iNlyimY7RIs1mjZR?=
 =?us-ascii?Q?iEeN877GkgdGn7N6Pk/snqCLI3HguftDjjgJGq9wVV4ExssTxzGD1nrvWqYo?=
 =?us-ascii?Q?qmbhwPljY8n8ezoV7k86gnFMzEc7C+gY+7YxoBZjeaBhtqn65zHt1yWhxMv2?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5d2465-353f-44c9-881f-08db08795040
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:35:33.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEWVtNrqhynE00YN5okSr63bFZE78F5CX9ZnsWpps7iZ1VLRaZuhLHpXFuEG1CuTySAhmF6Xr+Z8mq5v1/uqVHA1LNo23EgeUsjlmDPwQBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ira Weiny wrote:
> Dan Williams wrote:
> > Shipping versions of the cxl-cli utility expect all regions to have a
> > 'uuid' attribute. In preparation for 'ram' regions, update the 'uuid'
> > attribute to return an empty string which satisfies the current
> > expectations of 'cxl list -R'. Otherwise, 'cxl list -R' fails in the
> > presence of regions with the 'uuid' attribute missing.
> 
> Would this be more appropriate as a change to cxl-cli?

The point is already shipped cxl-cli can not be changed. So if the
kernel carries this workaround it will carry it forever even if
userspace updates.

Here is an illustration of the different update cadences of
distributions that ship ndctl / cxl-cli:

https://repology.org/project/ndctl/versions

> 
> > Force the
> > attribute to be read-only as there is no facility or expectation for a
> > 'ram' region to recall its uuid from one boot to the next.
> 
> This seems reasonable.
> 
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |    3 ++-
> >  drivers/cxl/core/region.c               |    7 +++++--
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 058b0c45001f..4c4e1cbb1169 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -317,7 +317,8 @@ Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) Write a unique identifier for the region. This field must
> >  		be set for persistent regions and it must not conflict with the
> > -		UUID of another region.
> > +		UUID of another region. For volatile ram regions this
> > +		attribute is a read-only empty string.
> >  
> >  
> >  What:		/sys/bus/cxl/devices/regionZ/interleave_granularity
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 17d2d0c12725..c9e7f05caa0f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -45,7 +45,10 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> >  	rc = down_read_interruptible(&cxl_region_rwsem);
> >  	if (rc)
> >  		return rc;
> > -	rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> 
> I guess it all depends on what p->uuid is...  Shouldn't this be all 0's
> for a ram region?  Does sysfs_emit() choke on that?

...but the uuid isn't all zeros for ram-regions, it does not exist so an
empty string is more appropriate.
