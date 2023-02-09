Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5C69123C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 21:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjBIUvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 15:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBIUu5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 15:50:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57668ADB;
        Thu,  9 Feb 2023 12:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675975856; x=1707511856;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CXL+xXUsrqOXTtJY9oAJUJQuS+/XsMLvdf84O04xFdY=;
  b=KUoHj5FNP+ts9Syjtob8sL9DCy1/jQKOMO0nOqvKA4fjevQhtm5za/5t
   qRuYM5OKkcVOW5t5EUMAQALVPV7I9k5DusmuHNIQLkaYWs0/hPLrIrsQW
   /K3FdmRDnNkOj0KKPm3gwcR5LD0ex7llBhZ8010QPY175YBIzOb7Rghea
   2vjoNBo9cm5AAZt5lhvSqcqFW5LkgB886rsdleurb3S5CCN2i6b+J/yYO
   ptCNooDhv11JisKpJfnSpxdi8P4SXd2/rBkYt2pu4RztslujKzOUcVweA
   eEkMi0+C7RG/DOM672GifnAJ1CYXB97A6EY0/L6Ib/9dtmAN2a+H+groH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="330256576"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="330256576"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 12:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700225188"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="700225188"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2023 12:50:55 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 12:50:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 12:50:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 12:50:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUMfvbhU0mLfonAcHG6r1t8VqiBFCRomya0kjt0aQzq+cyeW3KnaPJdJqGkzWFa5c0kQ+mZBlsG2vXt5L8eCUH8mX4QyN3Le8+j6d8ghueZ90HD7aT7s5+iq8HQGnBDjxT2DPlPtgneV02867eetjJQOMscjvAE8xlgaIX8ROk/A6SRpJ0AAtghncrnlL4wl9r3R5fu2bCHgFtr3zc4pER8B+L9vY3BAfVyuMBx0c4p8RLqLphuZhQfGwQmJilKvljo4Ji9UZDic4dEI4hy2Prt6L3nZmis6+xUeHTh+76UXoRHDVctESePbbie0jcTlpoO0HPLurwHjPo0Ochm9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSUfa6HlBOUJ2Hk5zui8bxPzHmxZAONgub2e5QjHObk=;
 b=bbZLtptDCnH6d6fgyIQleFfee92YXFePVlMFKTGx1dAOgoT+nPdG/dEY2RWzX4eFajZcC33DeExVeTwvsbykVD0VGz5gNuCPU/Yq0ziO7948e0e5OgrDlPgCPMJ2xcz3iCpYSXQn7a9sOIt6jm8AI16Xchl/w1pIoAFHAPnWGph1AfT9VX+QN/h0tPmwvm4Q8A0gsKeBhmWDQxIkQHMEda93/tuVbvpiY2xiuf5/ZnC5jZ2t3J56ylA6QoVy2N2Db7D/2l4e01rJt38xzpxu36e195R9kKqyftXx4k7Kv3N6XZqrx1XJ1eEK/ojtKAIq+gF5xPaiw+f1Ts2V7hl+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Thu, 9 Feb
 2023 20:50:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 20:50:53 +0000
Date:   Thu, 9 Feb 2023 12:50:50 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 12/18] tools/testing/cxl: Define a fixed volatile
 configuration to parse
Message-ID: <63e55caaced8b_36c7294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564541523.847146.12199636368812381475.stgit@dwillia2-xfh.jf.intel.com>
 <20230208173149.000043a2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208173149.000043a2@Huawei.com>
X-ClientProxiedBy: BYAPR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:a03:100::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aadcb85-cee8-49ae-840a-08db0adf5528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UfSaVPNWH1gxsKC8mFgR6wsOdOONydNwaqqP0w+gz8hoYkxuvxHL4/lgRjgLvWUJ+GVHEwDrH3pwLWeI+HNV6lC29ZvVuEGkW3Y+LHWah0riXpCyzQ3cuuH1QWebPoBL7sUPrBjpcsoLSG39j7NDm4snLnK56OJLc1w79vQn9ugUKsDe8J2AihZkKKf5/QQdYzl877j+Tcl//S3uVn/sz/M1gaDJTnYd9sjhReYqFMyygcigu6DAJkKsrrZiwKItCGqu3X7eW9lbWZIaTBOwZI453wpawW27Lh1i9rPR8JV0QQSV4E07Yy+qzy6lXTg0zMRh/vzkyRjNfCQXqHwSTzL/5kCI8xdszf8PrRps7RB6LRNwv3ORhFLEIrJsPj9yB4XbPQZZBpjsRq4NDC8KzjTcrzISd41T4jPTyOUzqlnoHstGKRheoA7hfRJTdDBKFjrw1XUTz/Gkwzfn1BsM6y7QoEHtjCXvgUXoiRVByV/fd/0Hobq2LX+53luzFGbnBkW7158dXhU7/C3d6RHL003JK1G4FLA4xXnjj5pTiTYTQw8EA3nxT+QvBqFNPai8JsEeKIoNPIfb7+BtsNt5EN4rv8bq3joD22v6DiYsIH1f1+7zS4R0LgEneasAhbvSgj0i+eECxqxXiefv/aafA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199018)(26005)(6512007)(9686003)(186003)(8936002)(316002)(2906002)(38100700002)(110136005)(5660300002)(6506007)(82960400001)(86362001)(83380400001)(478600001)(66476007)(4326008)(6486002)(66946007)(66556008)(41300700001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6byMndNjIXwtlLQ3D8TmuqAH6VW6yw+zJ2USJCT5rPgPBQzoIHnIfqjl5VV?=
 =?us-ascii?Q?3WWaNRRZ+TVGih4uSRKLwz5whFNTjPQgDaz71PX2pCyJ5RbFTjne5vWpkBu0?=
 =?us-ascii?Q?BTJn6kSbsNWs2NulhHhPmJz31eBsmw5158WryauKkGkyGakE8vaovLd6ngOp?=
 =?us-ascii?Q?b6hhOakfZWWVACcDOliIula6zNv74HssFAqJeOhPx8b3hpfNBy/BfExc1ZVF?=
 =?us-ascii?Q?iqCOEOoBNF99wl28JRFm1THyGwzbcEj/dWZowgLXYmq63+4zJ5oVm9kj74Jc?=
 =?us-ascii?Q?exWlqOOuIDvcztHKaU2E1eNRopumhOgHci2iy1ffz9Dtg6cLTPZlFVC1MFeQ?=
 =?us-ascii?Q?AnpHTfjU7PXGw4qDbI2MO4OlrZIVaxa0U8Jv/Z2qdBKwOUowqfdZmFias3zb?=
 =?us-ascii?Q?Pclz1WRhdmjTLongou4DYra5jqOxsN98p2efEHPjt+rGrOz8LDQHjCuCCjc6?=
 =?us-ascii?Q?HmIFky6xT6ZL6DkLyAmv9BulQOhQrzmUgedWR6150vTdtc1P3h4fSNydml4L?=
 =?us-ascii?Q?ZBhXpWaGiY7sTgnHkpzIL/rKwQJkE5Eee5+nooxMJofEHFcEn1pgyiIGfWVo?=
 =?us-ascii?Q?lHV0AKb+Xc50hnnsXB48H4GiIROAlQskkQ/QNecdaC50juIJqzHrQHIUGOli?=
 =?us-ascii?Q?trUv53EjUNhjOOdyZdwzNdBRgo7EAyix2JoBYFSFL+YPLsQBzY3rYr6dqT7G?=
 =?us-ascii?Q?IH3lPxbBkUqgLBfCRPh2nruVhWeaWfBRInjJy8Z3BQV5NUB8W9PEssvqanZd?=
 =?us-ascii?Q?pN5N+HB9Gh4jU9sC8HLLcprgdKMzlryilFUCm/mtqyFVq1st8M0QRvuroBvM?=
 =?us-ascii?Q?3oYeZrxls+1I8s500D5Fe9H1SLnRG33NZ/sDxYpRkmf8vaOdpLxz0xwiiXVQ?=
 =?us-ascii?Q?+S4CXn+wo4/5SkeS0n8B3bI5AHa2LFFzo1NtDTplU/16x3fbileMPLWxhbO0?=
 =?us-ascii?Q?m7ZTaq0GOlrpFLrB0vQf2IQ2mHqa/RxkGCExPS11PNc6fWxs8Hr/CYfuNkP6?=
 =?us-ascii?Q?/s2dPjitvjlRfW57VQedgttjsmH53BDyFYGgzCfNQZVXOZHHkO2DbCbNWVoM?=
 =?us-ascii?Q?mt6ez0siJuNBtZquFJePQPdU8YUlI6ZVRFG/X5qXyzDjXyJxio2qRinT8oWc?=
 =?us-ascii?Q?ddJ6KI5/jcQgOQBC81cQFqZqDqc32QFhrGUMjGVmGH1M1h8p3/MKL2ltiCBu?=
 =?us-ascii?Q?HOFiWjh6RN/Zw0Y5KAkTInsr7GwrP2cbzVM/OcmYec4JEyuKrD3U9uGw9GBF?=
 =?us-ascii?Q?EUI3v/Ma8jxxQ0uEL1D7RBDGinoFz8SpftE03uu2Efh4uVJ0ku5bg0zPkmNb?=
 =?us-ascii?Q?9PDpIjJ4cJyWVJbPKxkLEUVjMzNj+xSquMaICR/05sFtWEYksMhT4i3Ep0cp?=
 =?us-ascii?Q?pCJdc6AqccSlAMFAqqJyR1fe1rHLSZcjrQx4plqjkucWypERnpR2qICLXwl3?=
 =?us-ascii?Q?pxDZ5mP3Y1NeCq6JwnabC62LH9iP7re7JS7S+/9uIrFiBkb2jmz9HiWqxkaI?=
 =?us-ascii?Q?rWm8QrUYFsP7OrAGu6PFiAnS5qYFsvwdOBoldHO8gCPAAZ8ADW5nWsbH2AIg?=
 =?us-ascii?Q?jvKzF8rIwtSovz5NsWLkMeEIewUvcbG+Ru4fHMODKjzj3SUuUkS4mEi49JHT?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aadcb85-cee8-49ae-840a-08db0adf5528
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:50:52.7323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAAeAAEvCcsvONtO/A2vU3YOgfNzGH7NwuaGLVThv6fFQdAA+/8eUgynyhU93fcB8s1cPoJ4dBRm2kkamAD/giDYdolBRKcPUZ0JqIFT3TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
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
> On Sun, 05 Feb 2023 17:03:35 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Take two endpoints attached to the first switch on the first host-bridge
> > in the cxl_test topology and define a pre-initialized region. This is a
> > x2 interleave underneath a x1 CXL Window.
> > 
> > $ modprobe cxl_test
> > $ # cxl list -Ru
> > {
> >   "region":"region3",
> >   "resource":"0xf010000000",
> >   "size":"512.00 MiB (536.87 MB)",
> >   "interleave_ways":2,
> >   "interleave_granularity":4096,
> >   "decode_state":"commit"
> > }
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/core.h      |    3 -
> >  drivers/cxl/core/hdm.c       |    3 +
> >  drivers/cxl/core/port.c      |    4 +
> >  drivers/cxl/cxl.h            |    4 +
> >  drivers/cxl/cxlmem.h         |    3 +
> >  tools/testing/cxl/test/cxl.c |  146 +++++++++++++++++++++++++++++++++++++++---
> >  6 files changed, 148 insertions(+), 15 deletions(-)
> > 
> 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 8130430ffbcf..8d0895cbae93 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -458,6 +458,7 @@ bool is_switch_decoder(struct device *dev)
> >  {
> >  	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
> >  }
> > +EXPORT_SYMBOL_NS_GPL(is_switch_decoder, CXL);
> >  
> >  struct cxl_decoder *to_cxl_decoder(struct device *dev)
> >  {
> > @@ -485,6 +486,7 @@ struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
> >  		return NULL;
> >  	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
> >  }
> > +EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, CXL);
> >  
> >  static void cxl_ep_release(struct cxl_ep *ep)
> >  {
> > @@ -528,7 +530,7 @@ static const struct device_type cxl_port_type = {
> >  
> >  bool is_cxl_port(struct device *dev)
> >  {
> > -	return dev->type == &cxl_port_type;
> > +	return dev && dev->type == &cxl_port_type;
> 
> Adding that protection just for mocking seems a bit nasty.
> Could you push the sanity check out to the caller or am I missing something?
> Perhaps worth calling out the reason we'd call this on a NULL dev with a comment
> or similar.

Oh, that was probably a bug fix for an interim version of cxl_test that
I neglected to come back and clean up. A "while (port)" loop should not
walk off the top of a port->dev.parent chain.

Confirmed that the self-test still passes with this extra check gone.

> >  }
> >  EXPORT_SYMBOL_NS_GPL(is_cxl_port, CXL);
> >  
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 9b3765c5c81a..4c6ee6c96f23 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -452,6 +452,7 @@ struct cxl_region_params {
> >   * struct cxl_region - CXL region
> >   * @dev: This region's device
> >   * @id: This region's id. Id is globally unique across all regions
> > + * @fixed: At least one decoder in this region was locked down at init
> >   * @mode: Endpoint decoder allocation / access mode
> >   * @type: Endpoint decoder target type
> >   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> > @@ -462,6 +463,7 @@ struct cxl_region_params {
> >  struct cxl_region {
> >  	struct device dev;
> >  	int id;
> > +	bool fixed;
> 
> I was wondering why a mocking patch was changing the region state structure...
> It isn't - this isn't used that I can find.

Another interim hack that I failed to cleanup before posting.
