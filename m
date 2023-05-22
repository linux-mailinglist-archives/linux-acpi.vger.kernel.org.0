Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC670CF03
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjEWAYc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 20:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjEVX2A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 19:28:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124711A;
        Mon, 22 May 2023 16:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684797845; x=1716333845;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZTOBA/LHu5InpWEfQ0p1hw0Hpk1n9EmJ6iiP8yFq+hA=;
  b=UfhFTNW4eU4cwOA4HhbdZedgn8eFn/5VEiql5bf+r8TUpI30/mwT8lK0
   mJrl3sY5ibNc4+0m1HzmtDdzL0jRfrg9qpgvbS4SNiXd/ftXAMgnl/K8m
   y6UFslS9IXIw9caIquOyzp0zB4kaOXcSl5gYnosP6JWhpOx3Sk7HU4d3M
   m4iuo40Pp0bGvknG4C68R1g6YMljFtNqYyloVXrK8ouua20seoIU73y7a
   zIC7J9J+poHDY5NiTJrcflUd3Lqcr549gCuG/ogYrkmnI1IU6dUbLHkHy
   0JOBGLWpdD8E5GsJaeVU7p8nvlWTGguoRck49bgiS6t2bHTt+vKHuonPH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350580968"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="350580968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 16:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="768728532"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="768728532"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2023 16:23:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:23:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 16:23:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 16:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEJ945vQyo6isVb8bNrk8EX40v/zxmYrg9DKH3DVhkbm6M3VPMtGjcohk1ycWVIugquNCAoKMOGJaJHQ4MDSrgW4Pk902BKyvueHEPmoyRFQkzrO5smD1OT3SxWAqaXkTpFwHjlUqcUjrmQzYAb/Yi54icySXC+9Ef1DgMeOB8SUUFVgR/QN4oK35dEkQEH5Qj5td6+Fk0poIACybF0ZKGBh/t1CWylpdKZeNI0bwEgqF3VN08S5FgDYGQ11Wwc+zz5FlWyNNPnZ1K7HcYNlcEtJtXLY/nx5PU9YXj5/C/P9s07pMniDSraAleTZ617/sg6tt30K7QmpIUo4WDNKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQDgcpA2ogW3Ptv2lVsU5ILjaGKejmDguy8tj+fLAgQ=;
 b=m9SWDmKYFmpV+nF5wMHzs7oYqzz1E/FApXNc9yFOJygDIEwqjtHljlZU3juK0u6zUyPSk2biqKbeQoqKu/xhOs5g2Shh90LezaH9b+ahB0rCA4GeDg1QrBDBVL/H0z95zbcNlYnk3TvMgH32w3x85C+25+RHFcyDGf6yRLIiUyhxmpPmwDUH6mjxh/LcH8UoehpKAdZI0QnaV3sLWohpqVitiKldQmj//az1Dcua6wZVm7bUI0+2fdxdWbBBQLnwtP//sn211VzdNVpj89cKFpSAGmsSW6hIEIfu0RLFoZk8qCvL7auoECDOtzgjqPR6yOM/b7JX+f32x7aw8W4E1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:23:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:23:54 +0000
Date:   Mon, 22 May 2023 16:23:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 3/4] acpi: fix misnamed define for CDAT DSMAS
Message-ID: <646bf98890561_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
 <168443479457.2966470.18010229834586488037.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168443479457.2966470.18010229834586488037.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 4264f0bd-10e1-49df-b03b-08db5b1b9c1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpM/QgdbxMb2Xl5sRRr1KwW0JRBaKJlfQbnrhvnbwhI4urpjQpvgP19ZoPNkrxOK1aRRkt1DBoFQYRa2GPjJpVg6ZAXY3adlYZBQEs8eXSZWF6OKjLH7SfQEq7eG2kljdXsfoapRkbEm7mKdvu1x5YjcAAvbV+8W/GqoNFVbMwo3tB5Q60Z2aBAkPRss5iz8s+eT7TcTvP0kIRQxXR7vPrCg5Pav1zktiX9WEcM8Oj5T7PPmS36Le6c+hu/MB8is+ccskKIkOJUaHvQKs+321FMYyD7p+4FzFWklSrO7c7+P7k4G+VylVC2pqezpMBdOozYkTaHF+40NNxigX2msPypkNAgb0HtJfLb/lsBDCc4B7BYaJK9OHm7LlmVJKx38kEeyNMsgnyXOvcVPXQMfdevNuD+9uYa0A5HHxe4vj9MVL32D7UhCZ7cgzhOFhhUTs10JFcDNXxFvXtzfMC4GqznNw10KaKttxyk7wptDA52tYNvveYaiRr+Jnu/l7pSHxqridBxeP6ydqFI59ue+DP63Zk5W14tTDDxJOa3lmKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(6506007)(6512007)(26005)(9686003)(966005)(6486002)(41300700001)(54906003)(66556008)(66476007)(66946007)(4326008)(478600001)(316002)(8936002)(8676002)(5660300002)(86362001)(83380400001)(82960400001)(38100700002)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zb1yAXtehGURhBYrKfyF0pC4TXUJrfBoaMJcVpMZRruPwCo9ZXikvo6I2/3w?=
 =?us-ascii?Q?0henqnSkeLtyeMVuoC/v/a9AF7o6OBGlZFT8hYxHu1iSyKhPIcCybLT/sbgy?=
 =?us-ascii?Q?Fqa2LEKA6vXiBMeNVCD6HG1cz4oOZ7LbLYIr5HE+bZBKNrqbm/v9x2JvvvY8?=
 =?us-ascii?Q?G7rdRGv7HkN63bfoxFLil3jJj+F3bGjHQxo9E/RF2sgsrJpBatgyQgCAKUMx?=
 =?us-ascii?Q?MKdpMQClXSpDmaWIx3wabSNDF8nfbfzXLbhNd19vkF7MrDx2wlDD7iN5OkBQ?=
 =?us-ascii?Q?o3XkrOLUvJrwkRz3r0Iy9A/0zb8Xit5kwrMjW45n8uQIB4EN7PUflm7EbuEz?=
 =?us-ascii?Q?X8SDTxxkIqCaqtlj3cBiUU/dxU1ddga7Accp53cP++guEhDJCHYrEwTS94iq?=
 =?us-ascii?Q?YpMncWdEFBaZsL0wJyutDBVan7e/L4usyKJ+UuxJDf+tpZ4+e4fgg5tmqVZ0?=
 =?us-ascii?Q?MlnhXsDiTCc5yQRNyFLU7PqY978llG7nfg0ua+8c0b3vJOESZVuMSD0wmvH6?=
 =?us-ascii?Q?qiAwfcdwI2XTmSxj56ahfZz/pGMFm0GUWH/uqOwFhugT/g/kCcpnyxd4sasJ?=
 =?us-ascii?Q?n+TXe2l+61tDv99OEesaErahV2X2nzazgFbV9bwDDTIazsQcKvYzJcAeG75S?=
 =?us-ascii?Q?mIeCQKu0Mbq8C4gqVNcOQtmlPF8aXeIDUJcXCEae4x5t2/4u2pLMhgsMx3wc?=
 =?us-ascii?Q?ihB3tnbcEdhTzwbvwP5z3X+UL0LCkfKHVyVcZbBsBDX6fd4UOqtGcjMxopWI?=
 =?us-ascii?Q?6Ef0lUjFTYun7q9WdU5RFDO3DFLvuKEcqwGoWm8KYVwwXBnFgFp20zZQ/Ak2?=
 =?us-ascii?Q?m+Yl/ruIbkPryrwhZmvrRnQTi/kvRQ2RR+Fi9b44HHRvCZW3SuS+zZZ0Rxl0?=
 =?us-ascii?Q?L9CNL+mu7T5pRFE9BRkf468gh8S10XPjjgLPKEBUB+bxbR8vk3n8JqvokS5N?=
 =?us-ascii?Q?9Mcujz78mk6q/VELp2Ndo3lVlQ+88OguPYXlPw6SW4UQSpnccGh7Q1+Hq/ih?=
 =?us-ascii?Q?DZQ3YG+BqUk/ei73sVd919JBTc5dM7teUdXl2q1qtweGu7IW21TLd1MjGlUh?=
 =?us-ascii?Q?/nWWGs5Rf325ABLEraEJm7nbeaK8oJCzirxJP03P5aJqk8jEmBWgcjAO3n0z?=
 =?us-ascii?Q?hq9FKBXcXEa3GPzuT7wL9QAuwmzUZK/Nbld8yC+gXpZEgGA9dVogGDM9rbNR?=
 =?us-ascii?Q?jmj7UIyTpEuKFGN01U/6c1buKUS8P05GlNYF6oPHykk16ePyLTj944rnQti7?=
 =?us-ascii?Q?nUqJzhDgqnXHACCcAjRmBMraa0yAxaTCynIP4J1uHO0KSyxGrkqo8IUFlZ67?=
 =?us-ascii?Q?TPoUgLM2BdHWa5QKBfsU+hdSeWbFYa2uVi5PdupMc/sdwGS9/dQYiWrPVtqp?=
 =?us-ascii?Q?lM3DPdl3aZKgTEDhLqyI/yor8CRbe6oXcQl3HWfTOiG/Iryc51mDdOfWUmeI?=
 =?us-ascii?Q?neFZgoGQSxHn8r0oP1i8rxkAlSNqe6C5lrmDh1C8q9JlcVM7IvJPVRAUKnx1?=
 =?us-ascii?Q?uDGryd9n+HcFo9A0N8fSig+83ODsopP8uOWyYices54hlDz5j/X9/3NzJfPt?=
 =?us-ascii?Q?RWPvR3jdAUms91KG6gKJHX5zuL/+haqNSDN4QGvN2aHyqj3ZpcDR+LEa1OSM?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4264f0bd-10e1-49df-b03b-08db5b1b9c1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:23:54.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Smx+3gKD9lGRYgL/Kz/zgKaHd4cUNKbGLOo+lP7WEON95pr9ViUBLul06xiS2MEVB8rs7UKtXWCMbHClRw92yOjKfKm453pajt6OjstLjG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dave Jiang wrote:
> ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
> ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> See https://github.com/acpica/acpica/pull/874
> Merged
> ---
>  include/acpi/actbl1.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 81b9e794424d..15df363b9144 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -356,7 +356,7 @@ struct acpi_cdat_dsmas {
>  
>  /* Flags for subtable above */
>  
> -#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
> +#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)

This needs to come in through an ACPICA update. If that is going to happen
this cycle, great, if not then I would handle it as a merge fixup after
the fact. I.e. just live with the misspelling to keep this patch set
ACPICA unencumbered, unless Rafael has different thoughts.
