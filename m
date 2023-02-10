Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65594692B99
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 00:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBJXqk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 18:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjBJXqg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 18:46:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734C42DF1;
        Fri, 10 Feb 2023 15:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676072790; x=1707608790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GkT4UL+Ywni35EQihPKltiRWSEJJpeJnGnxDgGqEt3w=;
  b=N3fvt0x56uLUS380FnEE2XNdiADYa79NrfzZKKjXUG0yoqaSZTdsJpvl
   fplMAq8+qorKDY+rNd9V2rhWLO11U6FFE8ldvRDOPQ2fEL16eUPLbI+BZ
   bLVohy/EaJKHtEBoEH9VIlTds3yf9v6zLpbwiupnRa3v6xwWqHaIyaDVf
   Bj3xOURQWFaEP+d9SwAzqfYUvFPGguNpC0tf4ehyo75LZnzwUfZfUzegi
   itC5LKLPZfmb3niG50mF//jArxG++QqBdNqFSuKLEl9a441CkiNQY2RBS
   0fCLnQJhqoFdMFxuBYGIc6Shx7Ne1hgKn17PwUSFgfUML3smTzNeCsm/N
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310188219"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310188219"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="698579739"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="698579739"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 10 Feb 2023 15:46:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:46:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:46:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:46:28 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:46:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1sGz3r8PTnNxRuB0tuQEXLFy15U3nlnEJVu90j2ecHukDxEWRWabKq8AAGVlJnEdxtflGINATtiSARbUtfWbNZScEtFwlUH3Sdawx89aoI9CMsGDfpTQRNwyb0ij2xIMtN8I+dcyzhmvcU5Z7bivNvmTRYTu1M/h7j7cE3K3x5goIVJ8V9OuKwDZnkFOXbiOXWUL5/92EBNCqM4cebVrWb7Kb8zOf8pDc5tgXuMNkhvpjTmhjot2t7Ggt8+i1KXToS79B0rJfZ31RfaUJtbDlr44hghsUt/yYNxU3lz+Lc6s3thOgtR4hgYJGrDYgZf5IA4uP12Tf0UNR781j0A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2ZubGgSCOAcYJbNHkJIdWbn7mj22W8EfZFXLTbgMoQ=;
 b=HDLym2hBrOzRpGmfMbboLvN8+kOs8adkUjmHKNFfIv0AKet3qmsbDaYeqUgy/l94m/RUIzbJVRRhYcUrZTo6CFHguxMHZV46sjbaWZlg7/F1uHXwRdZJEsAQIZQd4J1ngX23XPRTLpTWzbJZhmbLajfW4vY3GvmXc/O3WoCe7lgtRqC21UMNg+Qphx28U1p6WYu7Hz19o098dIoQ1MH/G9X5T2dHqNfQ0SVzKADsiAKge2sktUXNmf5CTrrBlAcef5lCZ0uVqj/XdqS5LXwHUC5fQX9erSMLCe9qJ7jYAnelE2f+jJoeI7s/SOh14jJwTNJj80Z0O0T74QLYS3o6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Fri, 10 Feb
 2023 23:46:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 23:46:19 +0000
Date:   Fri, 10 Feb 2023 15:46:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 08/20] cxl/region: Cleanup target list on attach error
Message-ID: <63e6d7481ed70_1440152941b@iweiny-mobl.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167601996980.1924368.390423634911157277.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167601996980.1924368.390423634911157277.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cbad4c-050a-4700-46c2-08db0bc10207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzJ9dnuelWsbSI1OlsitFrDECN+gKSx4FddAmDk3u5NPaAo/MGdZt0XrJMDVKssxIXSS46Vdj+eZyKeyfvqD6VZl41V1suWiKw8V3YxX74yBucqA+eIvD4q3xzUXYwd75mA80RIVE+CuJ2gX5Z1PdrtipWn9JzwGj+r4bZApKg3ryqDl82IifqtYtqTYTv5/ZhigDWDs+VOW1SfQ2K9t0vNYDPTlmuE9530B8AfManZkjJDX5XB30/z2Yyy/zJKhQqunZHmmrqjp7WkiQux+ifMUy8qtEtemtREer1Blxp+fCYFG0CmAmuRn8K+ylHqfPba/BcP/LJ0MTwmCPsn6sfjjpcdV2GX/Bygyw5HSabnUKcfgZGj38CS0NGFXXpuHAKDRAJqcKA28tp14Z5SXFMxmMGdiimepRP4JkKW+mx+yYAHLuFcHgnLCwfTJPcYW+ImkRqQClpWCktU88gHPJnwzprhfcGygazLyZFHSodn3iG/IG/vvpyiamL/HT0LcYVneluJJeMDL9Caq/+K7guq7AFOPdHa+TN9IsEl6FY1kar8YOT5AIiwzZVLkcx1mLQBo0RJZ03Mp2G515bTp4K7Lfnx3BYlZb4sKD76ezJqFr4uMJNQ4QW45ROLuOhPIJ9IYnbC+pIP55ctM3Ks5g/vC04dfMO87tWRrUuG5c+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(86362001)(316002)(83380400001)(66946007)(66556008)(66476007)(6506007)(6666004)(9686003)(6512007)(186003)(26005)(478600001)(6486002)(966005)(82960400001)(38100700002)(8936002)(4744005)(5660300002)(8676002)(4326008)(41300700001)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzWKmDiUCtof7xe9IpEIvmiKOa+tI+JKOIWGqX+1x/PYHkPSer4H6eWrcJJb?=
 =?us-ascii?Q?8D+OLES8+Fyt9RYnXekcnwTFHsCxNFW0j6Fd8pTfi7OeAfOWWkL80a3NBED4?=
 =?us-ascii?Q?U76pLN5UYjO88a/aoKe8LEfkP24nP9HfB4tfmct5Jggud6QQOQaOCb4R51iB?=
 =?us-ascii?Q?a+X1ClZO4IWx63fO3BxfT24Jxj+8AoZMP5ZbNsEaSqDFUucLkAjElDXDE+I0?=
 =?us-ascii?Q?fuynBYOHe6OTshG3FiSu6QXXIMuay5ufYzgltoCpzPsrwzmpMXVirD/QSj6s?=
 =?us-ascii?Q?ZfXhx1YY9QTJUxQNHIb4qLm4vXQZV+QYxtl6n8mt22sja3zAWr2ycddowDoZ?=
 =?us-ascii?Q?++wId9RHJUDWKxF9YU185TXlbJl1s+d/wVZTfKjCUoyKQAbtoL0zqWIwuaXW?=
 =?us-ascii?Q?y5hwexjlZI+EY1yMyd7ZSrf2No12clucZUdotHXM5dnnB+nbsaoHftgsQQfQ?=
 =?us-ascii?Q?5D62adi02MVZh15/wRpD6ndvs2KijwqQKICZ3ZJH0PqQ624qOLFg8XCIQIaR?=
 =?us-ascii?Q?8c8SDRFRk3WlimFPa/F70TqXaU/gG018xQ+rFCjoCxu3jQuaisusz9iPAg/y?=
 =?us-ascii?Q?01rR6U58355cX3OdFlzmTxG9Rhn/X9ovX6kXdjYX5tMoMOCFeYXpONOUyPji?=
 =?us-ascii?Q?XbAAuhm+51haOJQoj1U4UlHE4GD+EJP3oB8R3555Fnkmp47ElVhCNooXDSc0?=
 =?us-ascii?Q?ZLZKqGUef2jqK2HTjlRO+7h6wBykDIgh0L2ivfJCVLJDXMBYVoFHaTlqbW5Q?=
 =?us-ascii?Q?Pcwy2jyOMtx1y03H+nq2jccmFwtAgJoGrisE5u49jRfHmTcdsvI0o08M2DSB?=
 =?us-ascii?Q?B7xS1G3NfhBw6zZ/6CQmVYOJrM4Slxd7CU14HQ0B3MpZUqUexAqPT2HjyP0M?=
 =?us-ascii?Q?Z1sS9xm482UAMSV6iCUPKP3B9CWscDeWJCY/KuGD4q2fLX45zMRvNS4Y9Nyg?=
 =?us-ascii?Q?Rm/EeVVOUIGy/Z5DvYCqL1aX8t14pyufVKL+UfwAo4mDjxmQzOmd5NhHdVpG?=
 =?us-ascii?Q?ZmC8vCwb7cPDYMCiPPDCNrsU3RLCeHGcFOGBV1sNJo6H4fjYmSU5Typcc4Wr?=
 =?us-ascii?Q?HkcnbOEO7H6mojLdHEPW6/X7fuIexdss94wgUSO4L0vdXM+Xx1rSyMR8ORFO?=
 =?us-ascii?Q?5hLU2eetnKJx6C9SU51BuS9wqHb6SNnfcQp93IM8RFi2ErqkHrpVfQnBKWSD?=
 =?us-ascii?Q?4FVEg7yHBwrjfl8FkA9mpqfSLz76Jq8zAMJWeIToJmHTMb+D7/rIpJmTShj/?=
 =?us-ascii?Q?VWs15hsuZaPWusJ1aSs37rOLpEzMsauIRObXrivBvl6umdzWPsfctLr6RSzp?=
 =?us-ascii?Q?9pnijrwXkmJtkhsxseXYxRAHf0waMxdA8eUinnuFnwaiNzMTjR8loT8pZiX5?=
 =?us-ascii?Q?QRnHQH3PgOLQM+HU2ryE8G9IXMmoJ+nx29SpJ4Ta+8jVOKPQaEZOnKDGPJcP?=
 =?us-ascii?Q?eItlUNhywU41wbomUfxICDfT6NppPuuDs4g0Yz/fp8hET4fAGMRi0PIvj95Q?=
 =?us-ascii?Q?PCMFgv6rP27tNzk4+5p+v1bSRIWzrejZK5sBkjub1+xxh0Wkr9oIMJSk6FWs?=
 =?us-ascii?Q?3GOqqWEt21HD59uFxxeIBQduImh4QCmaXToCAnx+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cbad4c-050a-4700-46c2-08db0bc10207
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:46:19.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq0z1A7G+kSfHnMG2bXjCGCznJJNMS1D2TCNBy5nRulvXk399sGO+WGAs99Qo9buFdof8ok6e8l5k+ENyTPYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams wrote:
> Jonathan noticed that the target list setup is not unwound completely
> upon error. Undo all the setup in the 'err_decrement:' exit path.
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Link: http://lore.kernel.org/r/20230208123031.00006990@Huawei.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 040bbd39c81d..ae7d3adcd41a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1347,6 +1347,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  
>  err_decrement:
>  	p->nr_targets--;
> +	cxled->pos = -1;
> +	p->targets[pos] = NULL;
>  err:
>  	for (iter = ep_port; !is_cxl_root(iter);
>  	     iter = to_cxl_port(iter->dev.parent))
> 
> 


