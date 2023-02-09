Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366D969123F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 21:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBIUxC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 15:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBIUxB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 15:53:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F368AD5;
        Thu,  9 Feb 2023 12:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675975978; x=1707511978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sn277+psjfFN64UPMMk0XQa4SJkm+59DxmOrkqFb2R0=;
  b=bfM3xy/WHbtkJz6+GcGPQZ8oMa88zgYPv90qPUX1S+YPKLG20qpEvXlF
   NOjwMfAAC+EIDZywT7rpCeICE0FNCvhF77FTFjglazJk5kO0+oYPkYpqK
   80ulhk29gdhI7qXxq6kOSj5Dom9FB/0Z673uyw4qjg+0HOxe87pqBvZ76
   /TxjJ00IVWGpr+TeYc6u4SjczcmgXy1Uh/eJ62U3gj5W2DPi/bsNbO7P5
   5Iy18h66OPjRmGXWpyPCzWT79EsX9sIXOruK1pHb9VBsDD8kI5efANurx
   AIMQQKyDhgkRUhqNpLZCdOMyhj1H7qikXC/sBlIca8mzLDI6QwQZEnyNs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="330256935"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="330256935"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 12:52:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700225392"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="700225392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2023 12:52:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 12:52:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 12:52:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 12:52:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8k3vWfqIL3j/W9ZPVf9llXaco7Yp7DbP+0jXVyKFVJAjiGaHTNf/YfyZ5/W/mzjadsAUAaNJtsvpwaQ4l9jKP51nQsRBTcsJ4wYLJ+PYQhco9DYSfWwj6xxAlYdo+jQHiC66M2uIZq+WrxhQUxtrBnawuwof9gT1A5ZUetdSZnGVcESXfpxWZYwN5cKfoXFdESKnkWt2L0FY/hKzVFVf4pQYSqu83VY/6ro9pH8wbC0O0IFE+UX50I9ym0D/tFGqhicWGILvDAxAWeNm3pYGcP+JoG6e6+ZCGN9O8XH3R/o9LLOHRr3xZqJbcc2FhiIPirUQJJdfdORQBHizuA7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejl2yRCDUmQNwZcXGgLSgzA/k9RDCYztWTDyqOntfhw=;
 b=cwbXgBqI8wpWW68gvhVtYq7/0sJ+teF6DOotdJZ3Qo8X9UEe6R8/WJp/fTU9ejUM6oBFzOJsilQlj+7gde07jKbuPVdEnBb8jF9Id08dAPBktAFOeip9/Aou3unN+BmQmFkz4IJ4oZSujU4ZOdcf5aWT7omGFHZ+YGV9rGfvmZk1pdseaCxBXpIhfvo0UKw7KgwBU4ukhqTwGhyc8e4jbflLGbhRLFB3T4KJEqHX3idUSDzWo5OZaaLVNFv8BVG6CuZ1AGl0z3vif9q7Ls9l6bJucS7xND1EfG5DAQFZxxp3rur+y7auP6K7QEG4jLamUQPgVCymIFf+Y1HqHXCFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 20:52:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 20:52:54 +0000
Date:   Thu, 9 Feb 2023 12:52:52 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
Message-ID: <63e55d2434979_36c72947e@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
 <20230208123031.00006990@Huawei.com>
 <63e475f2a5fd_36c729455@dwillia2-xfh.jf.intel.com.notmuch>
 <20230209110704.000072c6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230209110704.000072c6@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cde8ee-92d9-4ac5-31a8-08db0adf9db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOEL1GJx4OAhKrrvpAlxqDokScKsV+7Woi/+tBv9BLLl+GGg3RBtRNtxyHFw5m0OqrOgifVJQdYej2TGf8+fB5FkoVemwQuWuUTv/ebsn1lmBchvEERcteU7Ij1z3PcloxTkN0+onLZHFoXHMBDL1coxRxb3z9Szl7NNGFslqFfePFFG4ibbp9AzgLenK5Ikv/NLCm2MTXrze7DR8TZjPVvC0lIzclgxatjug6APmj72snRPMWMX9CnskNf2b8HIqztVb9+Zt7RkH1s0m6UshUg4nXb4lbVwlqmVgr6lXS1GBx4/BVtJJfNddUhmnWT95ZCNKOB+YNbAvHTBjyzuC/2GymJ4DpSsjZ7VTXzNG7cxO9EAjOEH4MEjpVEovVD+FAsK+3RCyGY/nFyvvBIuzHW/C8hHhEWkMplu4/j/IZ3VL3Z4mgjNB2FVXfDd99tFHl2kGMmf/AQxFZV5pdUlR3KVlmDWSgfsyXLBN+GfVd9vQ2lpqqixiTU/2cE/vO1YlQE56sYPpYOS5M31C2zO0fX9ix2XP8c9mo/QItdGOGeEinNk6Iv25yoFJ/qWGW76x0L5dxkUsZIDr8O8wB1IoxJeAk1soVpVXzOH70CbE5C+SYTkVgxUMzG09XyjjPVueBlZQUPYW7Wlo0Z0P0kAig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(6512007)(9686003)(186003)(6506007)(2906002)(26005)(5660300002)(478600001)(6486002)(82960400001)(8936002)(41300700001)(66899018)(8676002)(66946007)(4326008)(66476007)(83380400001)(66556008)(86362001)(110136005)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JEm2KlXWulsXUrkHZw8pK90hSqZMtfNNSL7oFKEdoTHPhQFnC88rGZQASkW?=
 =?us-ascii?Q?4vwYr2LxiEOCF091ggEuzCEoDbMo4/aH3g2ehy4ZDgp+hwxzPRkT4BOwJZeo?=
 =?us-ascii?Q?tkg5Z5BP9oO6031uDMpHbHkWSNdf+z9PhRfvcPGvX6JBqemIQrXda0bHmTk9?=
 =?us-ascii?Q?p17L17vrYabGNTdNKYOadu+uwWB8sZFSspiVuffLXiYkoZ1lMFblQBkAY/m0?=
 =?us-ascii?Q?8APay3JqWEsxR+J/aFK+MOJc7dCTZRA1weVqPmkX+tlTmjjhDDr6IMTv5/ht?=
 =?us-ascii?Q?J4hBe7MfSTObBSKpaqDTlJgXJxwXZOtfyTchm9KxnNKf8ywUdR5koxQVr+Lw?=
 =?us-ascii?Q?7U0pmmBfAbaeabeucCOh+8oMu/SVxr57ZxMJWLJhFQ2ltqXlRTdY2qRn2yat?=
 =?us-ascii?Q?bbRce5WNziZzvKJnkf3eN1uFV0i6Rkgghh8cojVyKqyN9VfjngqdyxC7E7Fj?=
 =?us-ascii?Q?sG4tTWA3LaxFm/5I1oGxcC9YkJsgKolagSLP/sXZndPaJkRhpB6ahtfWjIUg?=
 =?us-ascii?Q?2iDPyj8DHQHxPxEw6C4hMf0L6sR63ZMUQT2EDxoRvauf8xT3fvTeK/sdGxCy?=
 =?us-ascii?Q?h01VHnx88yoiDyaG4CzEjBQNtXHhsTJd5iVF9EHISqp7Ew8ZzOzvRyGAF7PF?=
 =?us-ascii?Q?PAvPZCHH5YS5PIupwyY2kCyODHa/oHCOqrz+5NUcgME/1BLB2D6+JivD2FW/?=
 =?us-ascii?Q?AwNgtO6wPcZNnWyQ98QzTh1XdGMVFVl3MEL/ThFRq6ksnqKTMl/Jzl5N/R5C?=
 =?us-ascii?Q?NXSrohR669WuQn56M4GDsS4iKJYmhhf+SKB5Nuebi0ANV/b0vm0nXRNjMnCv?=
 =?us-ascii?Q?kkJOjO+DtkBvH1p4J28+vbZpAdQHxGlEYDRInWe7gt8I8dFF4PyOT3bBLsNe?=
 =?us-ascii?Q?nUQNHCd9jfaRS78V+JY8ePwpaHVVHclfWeIsDVSMc8kwp+IB91srmHs5CYGU?=
 =?us-ascii?Q?PwFLfVpnfMjOdmxu++I6rEuUUMkD9QZtXlJC2zhmyV8FnmkplVZcPU+jjWk1?=
 =?us-ascii?Q?I9+KF8388GQuoCiykXnRAq8m+qf2Xn0293k9NXigCrqg1TBUB+AR0Nu770u3?=
 =?us-ascii?Q?gMbG0/IiE7Ua4R3y4S0XhiD7UwYVp5KHnMtZ3ehLN2I5hYYexwNBror9THsu?=
 =?us-ascii?Q?3g8feDT0jvcE3sulssOioPrDGEa/5pkYjwgZDmGEp42/jQ76oXdoUVH6aNFL?=
 =?us-ascii?Q?+o0E2PXyGVbb2K9AAinraTizXogeaskkNPtoO8LB+ddmGWrRQ9wPrJjyBFew?=
 =?us-ascii?Q?TIbtqbdM1qBD1ZMVvFwyLH/ikEaiVQBSxDsKjLfrQ716w4+QgV2pOuVK6X+9?=
 =?us-ascii?Q?QUtxfN+PXCjy/qqR4HltVmCLRDsU2hyFsAVRms5cEtZLNdtXFvF0AmLPrRMM?=
 =?us-ascii?Q?CTY3UsYIlCEoCkoz+IteZzgSP64CHtS+5p189aC6AzWYZqnnDPU109STXybP?=
 =?us-ascii?Q?USyKPF8AAiaXL0kACRLdERNXkHisTbxSQquII829tNSgcByWR0FFHAMCvAL+?=
 =?us-ascii?Q?5Ie/VKbAr8X8VL7sFvEDZTXmnwLg36ap8sH8Fif/22ggleL96SY0P/8PpNPW?=
 =?us-ascii?Q?R/bW2wc+JIHLxTeRs4YG7T9Q0kyurneYQj+qF449j1O/qb37+/P+XPAYt9EZ?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cde8ee-92d9-4ac5-31a8-08db0adf9db5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:52:54.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVr16RLwcuCwORAiGQAvx5n0fewbeSVDJBpITOhqLjjWXUDUF0MvjKnoQ1zVfEvM/YEFSKNlHsQxkQbjQUkXJe+BB+9gcXtwEU5hmdDjfQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 8 Feb 2023 20:26:26 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > [..]
> > > > @@ -1284,13 +1327,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > > >  		return -ENXIO;
> > > >  	}
> > > >  
> > > > -	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> > > > -		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> > > > -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > > > -			dev_name(&cxlrd->cxlsd.cxld.dev));
> > > > -		return -ENXIO;
> > > > -	}
> > > > -  
> > > 
> > > In an ideal world, this would have been nice as two patches.
> > > One that reorders the various checks so that they are in the order
> > > after you have factored things out (easy to review for correctness)
> > > then one that factored it out.  
> > 
> > I played with this a bit and the only way I could see to make the diff
> > come out significantly nicer would be to use a forward declaration to
> > move the new helpers below cxl_region_attach().
> 
> Don't bother then!  Unless you've already done it.

No worries, abandoned.

> In the ideal world diff would magically present everything in the most
> human readable form :)  What are all these AI folk working on that we
> don't already have this!

+1 to this.
