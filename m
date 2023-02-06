Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02168C903
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBFVvg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjBFVv2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:51:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4CF2ED42;
        Mon,  6 Feb 2023 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675720284; x=1707256284;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=znOi/sB+ImZQq+C5bkax/StKRlrP+lISTEakVYB+f4g=;
  b=SCvJso8DlQDztomB7iPqNYitj9MKJdSorsL2wfZSwf/YRYO3m1MHenAJ
   sZvBqKYy2G6r3awA4+shgk1jPdHUvkFv1HAH74kSJfoINzGuakgLuDxq3
   B28J3tgqyAy3TJMdyMKHZq1OiyGJycHCz/lU/pSI6Ose49G/Cvnemu2pL
   gMbmD7AhDM6eFHZF27N0UNHzFPhFo6thN96Dr7mItpOEJJUzJ3V5ODSFv
   uqblWYCG3Lc9cxIrUZ90gYr7s73ILoJIgnX0KtaRF/RWeap/GY9VfctgZ
   3VpOuLBUTV/eDio+8CBWdpV5lQ7PMAQbIGH47qMas+iI+hvDYy8G+nrCf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317338988"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="317338988"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616577252"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616577252"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 13:51:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 13:51:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 13:51:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 13:51:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOuDu6GxbnAYZh+qcDHs/dAR0Xpsk3KDplHUCE1jWLugCQh2v53bycdI3AUhZfULuNp8XRL4EfWXL3q2rJo62xULx6WSs3+KNZ3+vkkR7ZCwGY4/UMf5mcjnR7camN2ODO8mOqW1ejAkryIb+Txvkmfh5KOqBYQfp0NCybNMQya5G6p2yDHvrTuRCyCq5OjMwdm2XZE2M7cvDlVqPVW35aISpLRtqSQejKwHBEgSDedda0A1223m3rY2GCPF+YydNwjFbfsUbdAEV/dKkzlPi/uVCPCJ8FgijqwCdkkdgbXAf55fQT0IJP1l04VrN0F4HuG2d469xv5wq2ex+xOYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9vVDvldTBzPQx7sBr5UwOU7Un+TJzhE5kom21QwUg0=;
 b=WrT+NckVq51U62Jva/B+6Iuk+kXxQw7otzAHV4nQqIxbi8+5rWs5i+GbmyOMqKj422bvCCrS4JNHdnFoSJQ4ANffbZkHfvJ9e9MlSAU3syMC/mZKc9AkNd9H/bFuaoPv0PQf1LBwNUOsfGsJXp23IMskeVhzOvx3dzc0kUvZUZBvKtYfdUv8E2Rs8+kbfBRMqyCeke4TMx0djDnGXeRQucPVcYveTupgMr3KvX9Uibv4o9aFXL+nTmgexjLY7Ls71h9RZlXTnPUIuWyTWwjjr+LgBHOhPsiD72dIYlUzLdRsAKWAD9qFqmAPr7mtHfPTG0siV09lpaSjJuOIpytgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 21:51:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 21:51:20 +0000
Date:   Mon, 6 Feb 2023 13:51:18 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Message-ID: <63e1765622185_e3dae2941f@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
 <Y+EuYzk2Ro7WBEhz@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+EuYzk2Ro7WBEhz@memverge.com>
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4251d29c-3436-437a-21f3-08db088c47fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bM4SO0n1ne1qfhHrVUn/TspJKkTugTNCpa2+T/dVscFLSXwEM2sywsI7AJwY+QgzrGJcU5oXr0NpBSLSYKSV7NhpukYR0ffy2ZxqluRFoaK/aGeXFtEnJndLvIOrZm10KOaAkoaoILn3fRIhBeBFGMkoGNPqIHX3uPNTxSQ8LXmaXz0zusPGz2QJV3+scXKftV74P7PnJabVEzwyEmAO39p/bVUkDqlovA4IQIq1Asir34domTL19RREqOqlO5z6jWDnUrHJpVixoY+GiNq+quQPZvu9/Og67UJHPF+FbRjZEsjfKbsNZKWfkoTG0EDCM5cvv2e56GjeJwcQ25ZL1CqHwxNNQ4hND3kiiRBPgU6BzvRjOzf+9lcHtwcA4LGH8L3V22V66/e0OCb61PHm4xQYVBLxW/l2N4+lFzqlqMfdiV8vRA4VbOLZ4qL6KDyV3KWkm6kIjDUut6vVBWdobyzThvsHhCHdx5a2IaagYi6LwicGrXF7xBMP18+4bf+IPHCyq8J28OBDlANPuRHxz2Qnuotzy4IQ6L1fwWSzaj5o4RVZFKO9F1z/v7viL+cSTw2sd1VsvzmzpUHqGTA0Hj9enzAf5xSYlo/0z0/nZqp9Yg0JWJ1r2oXocr9IMaRSIyBS0IdaaW1XMk74+nIgGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199018)(66946007)(66476007)(8936002)(41300700001)(86362001)(5660300002)(316002)(66556008)(4326008)(110136005)(8676002)(2906002)(83380400001)(82960400001)(38100700002)(6506007)(9686003)(186003)(6512007)(6486002)(478600001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmXc4drGQGZBptxVfPb6N1/gVAHhthMZ6LOea3IkeUm3jll9RqsJYXbJn9tZ?=
 =?us-ascii?Q?vQZ9/fNBOKZpKiCfWebwipBrYd5vuhuJXJjTt541qVE4QzNejbNlnwuRB35z?=
 =?us-ascii?Q?Ut4ufZ+MnzkFFiIx9MQf2TqUUMvcysx3bU2OBfU451c4COJCyNRYNwEir3P+?=
 =?us-ascii?Q?bJ2xRx+fUaB0Yjkhh1hwxvbCdk7NK7iBzud7XZYkb1/oTFVSB3Jt+dtm0AwD?=
 =?us-ascii?Q?SUAbzDtqPDNfMfiI+HrpRonMGtDZFaMQLsIzOgbcAEcdAXWWPLxPbD+fSxzN?=
 =?us-ascii?Q?nGAv9Cfg3cFanPb29j7nQDohuxzH+vTpXjB5oWOUH6EZerfAHLrKm2iMxBlX?=
 =?us-ascii?Q?rXZVdf1BZa0/upHhgoelNmEAOxErRm5EPsVk8i7Ik/7AIrOjV5iTNQgFS6ya?=
 =?us-ascii?Q?XC8QNVH4Z8hwhaddCwqp9r4H8ZcTrVwIS2SU+RnVRnR+WQTh6izo7X7m0vCQ?=
 =?us-ascii?Q?aoR9f5FoeuhCG8dkGLi2Lk6NA5boGmg0nGrri2UAU09Us5xsspwneBudwBAR?=
 =?us-ascii?Q?vwo4X45LOUxwWr5JbV8yiwK4OaHsNVb/XVM5DyyOvxQ7lL4/415W/7IyIyYV?=
 =?us-ascii?Q?fu/7g/hp83KK+I24ev0BIJLDkVGM3YQ2rp2EnZ0CuJ5SxrF21s1oFmtegOKK?=
 =?us-ascii?Q?BXITSgF3GEXrsKPZSe8xxHfve+t9HgN36KUjq0RpS7SCgPdw0Xg0pG0ehN2a?=
 =?us-ascii?Q?H7IuQp+23+jAx4X6QUG4+RUS46qUbYVDxRy3VE/LpkujDXJ9BHVKjv4wKJ+U?=
 =?us-ascii?Q?1+N1g0XwUFhUh0k1u2o5Eo6K4G7PNVp6MXeHxC0H3zOew2juwoYWtqEU1i5e?=
 =?us-ascii?Q?tGoNwMAICsgSDCZctKr6nZuOiufP+DvRbW2Jpxl7ld8Hkl8c9Z/mVK6KnQ52?=
 =?us-ascii?Q?/fk2+h2XJqQ7yt93hzfLM1rnPB/sTRuSqz763M9II2D3UBj+J21PDZJS+lHr?=
 =?us-ascii?Q?Xvu5H0K/cONUc/wOc8ZOY58f0amPGSG8g8gjshUynbyMAA+GPyFq8Wo9/yNh?=
 =?us-ascii?Q?UuyU7KTwFPlJ+dp3d5hHfnSJtnVgsid9/kzX1CL75SOXX/5NOpxu566Sq0r9?=
 =?us-ascii?Q?RGnDnswKdwt2c9BJM3rMQZHBTlKwpdfUjjXe6vMgWdwHMKKbkIZ9t6y0fVY0?=
 =?us-ascii?Q?spyUuHRF0EzOudMVAgZpf6PTF+uv84JME6B5AVSVybR0wMko+1z3oVYGZvjD?=
 =?us-ascii?Q?IYgC5cFJ8pH0HBn7JuornZag1J6SxTSFXAOdE5JrcOK/e6LpBxPVNfaWOaG1?=
 =?us-ascii?Q?vPqU15jLToGHr2KqF6r9Wlyhgg4pZQ5bh+5erEPlRmppoIna/2ixU3STeRem?=
 =?us-ascii?Q?A3g4pl2wAxWeg/w0O6yr6Rj+HXKyrHlwv1rIT5GFqBx5Q5Jf8OQtv2LhFPa9?=
 =?us-ascii?Q?SBcng8h3NcCqPzxyW4iOOGkMRolQzQKRdr3vVMtKUVQty5upPZXJMr4n78L6?=
 =?us-ascii?Q?0oO/7gVHhk2Na+AYfjDl9mb93Hlc3qk02YywSG+EgeIA1iV2zIDzFOvsOkoI?=
 =?us-ascii?Q?f29QgS4jZLHQNiC0AD5IddJPC6i2BoPoIJb3AXPr3iu3o18DNIctYQrkcNtJ?=
 =?us-ascii?Q?dEr/kBWxFybk4ZLB5VFBPM9OtvywhOw6UVcXJos8TCWJieBurO198wYQj1P/?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4251d29c-3436-437a-21f3-08db088c47fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 21:51:20.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVOtKrvzCz14tSfUYB0/6C9SdurNDEwqGh/pb/VHSqGKsCMJnPqhRKDKT8r3OqL3YcYnO7iDXcuymuTex2kjbkd3Z50CMM2CzSdjBAE995U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
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

Gregory Price wrote:
> On Sun, Feb 05, 2023 at 05:02:51PM -0800, Dan Williams wrote:
> > In preparation for a new region mode, do not, for example, allow
> > 'ram' decoders to be assigned to 'pmem' regions and vice versa.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index c9e7f05caa0f..53d6dbe4de6d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1217,6 +1217,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  	struct cxl_dport *dport;
> >  	int i, rc = -ENXIO;
> >  
> > +	if (cxled->mode != cxlr->mode) {
> > +		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> > +			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (cxled->mode == CXL_DECODER_DEAD) {
> >  		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
> >  		return -ENODEV;
> > 
> 
> 
> Maybe a stupid question.  It will be entirely possible to "convert" pmem
> to "ram" (i.e. just online it as system memory).

That's a good question, there are two mechanisms for this:

1/ Use ndctl to assign the resulting pmem namespace to devdax mode and
   then use dax_kmem to online that persistent memory.

2/ If the CXL device supports partitioning ram vs pmem capacity: tear down
   the pmem region ('cxl destroy-region ...'), repartition the pmem ('cxl
   set-partition -t ram ...'), create a new ram region ('cxl create-region
   ...').

> Are type-3 devices with pmem expected to carry 2 decoders (one ram, 1
> pmem), such that you can create a ram region from pmem, or is it expected
> that the pmem decoder will be used for pmem, even if it gets onlined
> as volatile?

Not sure there are any formal expectations when it comes to number of
decoders.

> Just asking because depending on how that flushes out, you might
> expected a "ram region" to get assigned to a "pmem decoder", unless
> you're expecting all pmem-carrying-devices to create 2 decoders per pmem
> region depending on how the end user intends to use it.

Per 2/ above even with a 1-decoder-device there is a spec-defined
mechanism to assign all of the device's capacity to ram.
