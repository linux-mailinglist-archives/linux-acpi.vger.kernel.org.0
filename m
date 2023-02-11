Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC9692C60
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Feb 2023 02:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBKBDV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 20:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKBDU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 20:03:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BB75F52;
        Fri, 10 Feb 2023 17:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676077399; x=1707613399;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6gpOsIZ8MUGeiVRXXTaxmNPVnTOdpGuUiTCM0F6X5Jg=;
  b=D7xayXhRQl49W13F65aXUyQpuqS3QU4t63Nnk/2du8O/zli9mvJ4RI7M
   x4JvtF829hFNlZPK65ra0TxCLUyzpUgnLiVL17FMt5Q47rpPV3hM17CU6
   /toSvrCNMiLppYzh0tDVUs27sN9zPSFMy/kKImWyi7WDXlLTSCfI4oUpF
   4kxUMr+edGkCE3qj4kHdthBEqVT6fBib7P9zKFVg1TtMEhC5TnAuycDeJ
   4toaC/42qo/mUcXINPCcWOaPeyolJwiyrzCSOquCrkaov/64ppZp6i0ay
   fILvydcw6yR/9vZ17IDiqAlf2366Ys1PRczqD5awLDXaZ2w+OD3Qg92w2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392969688"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392969688"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 17:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="668238205"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="668238205"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 17:03:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 17:03:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 17:03:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 17:03:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 17:03:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOaoknl7fXNUqOmBwyRCHeVJDQr6gfjk4CNP+6dSH9QFhjDkvmH2sWH68WT08bkdOoYWOE6odPP+JQYF/t5X5LbeqthugYXoNI+KYdEWAtLsAJ9PW6sN7c5Rgd4JNdQ23OPHqHg40GSKr6er6Bi2prhdho37ZDahZ6tzgtIs6FX3o5U8UMf1rQbwBVddFsC24dJ5iRLAEqCoH64y/zl4j2MehCWvrYRcUiCKR/YuFXroVv5NULq6cQWc3DzEOiqBgqexjz9cZYykQHUFGEDGSTBSTX5JEK/iFNdvWlhNZyeOjb6RsFjsEzMUoBFco8HmK9F9G1+moyRYXWRLZ52myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMA8MgXNlYnt3xS2yLciMOFcMPl95aJSsscFChYNgGI=;
 b=JH54qeUZGKYcl7ZhH/3BwFh0HWGQxmD4VNfJSjk1CrWauYzUUxjR0Qkc8tpSrD5GVTC/nDHkOYtK+P6zzjAt0yvargT+t7jbqC+ykxuvDgBpXfTyzwAISMf0tyLDD9W33ZEay86fc950SayeFVsbD6C9oDTN0DNb2LlQ/e3+Mn4IATv/V79qi7HDOpHZSq01tOq+hciE5KCH35ftKBrXc8uubuWTAcuOPglY47og0VvYzYcBwC7/Z4zgWPH1kfR5Ni7j3A8HVzt5x9srKBd2XlhGbkYCgNXhegdWdvuRiK4A+BeI985w9tkujYkc11kveRGeXljnKiKt6ZQ81rFQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 01:03:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 01:03:15 +0000
Date:   Fri, 10 Feb 2023 17:03:13 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Message-ID: <63e6e95152384_1e534829443@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
 <4f10837c5dcc405eac2441aa78a5f2f388fb601a.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f10837c5dcc405eac2441aa78a5f2f388fb601a.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 18034563-d142-471a-bd68-08db0bcbc163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/dhufrU5Awd3ICfgbFfPZ0LFxkIG87LjHHnBVYPgaQAh8CA8ozDYLxBV2qytmOWcosgQCBWWFOctu78Q6OXfn1OFYDVL5UoBj71WC53NkyCjG0tIb3SMclQqpG9jfZ1+4Y9chUYw/3QXe31yhc3hPwlz8cSTYfXiN/6kv75yP9GqvjcTHMqcGv/KQKtXUIQK5mfpcVLOppH+Q609jggzvwbrGbhuuEAxmsFtZSO2bfgt5aEHJdlOYm56TUbJ7jPHUPv226F62qrI8nCLXYNdCV5rSYh5pvM+db9Of9UTqSCQQbENaiLv0HMsmK/6eGdchBAvAZL1lZQ+pg7JEgzKbNn6XDOb632OzJdlCUlr9Uab48hDnXHan/IZ5bg9ZKt1ehT6B3WAP1YJNH9GFok7M+UcvpKy/cyPKKRARmnrYXxyN/SHKfTX4qDE98f07UqgTNGvgA+rlMv+c4686WmZbfAnu8E7aBG694MLVal9PzAviCS7xbt027V9k3gkXspG0QAXNPv0xc4o3hCKZBEwu3tv7dKj/1xloraMn2XmBxv0A0hjjHACsLHEzG33jA9teUL+UTV+v8aHYYxNqQqFsh61nGr/PXIjs4R7mjlkIx9rFqpX0IcQOKy1ldABrILktf5gIGkYv0TwIGUbqP9g2ImuGIk0xtTub+M53mVDG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199018)(86362001)(66556008)(4326008)(66476007)(66946007)(8676002)(41300700001)(5660300002)(8936002)(2906002)(82960400001)(38100700002)(6506007)(6512007)(316002)(186003)(26005)(110136005)(966005)(54906003)(478600001)(6486002)(9686003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+OASBuUrkb0eLHCgEBO3jmpVmyZOM+6ipgyS7nP0vPyewr5nAEN6Jm6Kxp?=
 =?iso-8859-1?Q?ASuNhhRKLyMWQ49kPt1pJfFsn1wgBHEy5iiZlfHpJvGonYVlW9htZL7i0w?=
 =?iso-8859-1?Q?sR8VoVkc+yZLgjyEVh8Wl59SZkzdcTC9wso5e8RGPPEW66HrhB7a3Ofknn?=
 =?iso-8859-1?Q?a+1el8NdChQT3y4Y4JZy/Vy/qiQttP4Sslzlmv6stvjPOaFJ1HPc1ygOp9?=
 =?iso-8859-1?Q?dZqnjymuhir1jQFE4jiIecHKt1Gq4B0eeeZDWKm3bDe2m7pt7eUeKKSK6B?=
 =?iso-8859-1?Q?xk3PcHigMOxmPBpEWuldtVu7J4s0Cs3FYW8Y8LklnZapOnOLVEPdgSsz30?=
 =?iso-8859-1?Q?Rrctgk0bs3sLBq8kptXwSsqOfWDX0D6J0wfo01fkoolHjw9qSOx/avdrQz?=
 =?iso-8859-1?Q?Qgu3eHbH6QIck6/Z/CEs0D09aOnT2x2sDzuOEqAIDoceACpRteeipLTEwF?=
 =?iso-8859-1?Q?bKfAHa1jEfhVfNh9VKrjL5jX2Kk7QF0x/GXpxhxVWmdhowEPlxOzClvapM?=
 =?iso-8859-1?Q?5E0O+LAPknlDZZt1RO5uCjkAQOFVozWvHHBaePbxy8VTfrVu3x8y9RWRvz?=
 =?iso-8859-1?Q?qJ5t1J7QWZfF+RR2k4FA40i69smH3ynToO13aU42Tj/7ZvRH4Gb8NQEdiq?=
 =?iso-8859-1?Q?ToB02dT1I+NqTA2mN8G1NviGmzTTk54l993cnb8X4APZ3FYjMPQIsHPtoV?=
 =?iso-8859-1?Q?jagCp4+s32qjYU/g/ei5Ev8s6Dmy65RmuQXGEQeZk7TNz9ZSxbiVDojq1r?=
 =?iso-8859-1?Q?2m5hqYlTqeGBLyDiSZqzP3IN3rYw+5lISegg65K+5R/s+BS5pwwAafur0M?=
 =?iso-8859-1?Q?0Y/0ShBVj3NrXWkNH9v1qFg/pE+V3QK2i7zn6ltWumpIafT2ccp+h+Klje?=
 =?iso-8859-1?Q?d4OeByR7YOScMfdOzC0MmVOOZKmugPs61kdpCISGy1LKRQh3q1Sq2twFsC?=
 =?iso-8859-1?Q?DDR9OzTzSSBLFBjla5GNpckhHYEk9PqPNqPL+KL/8MVp5p3RUCQFpHY21w?=
 =?iso-8859-1?Q?Pt+faC9oWeSqlB6IW4Es2vy1+ll87m7T7LH6uOzZVC1aCyMuHOWC1+kq6a?=
 =?iso-8859-1?Q?Mh4n1ibnyuac/u3rI1/VL6kxJSmjzLwPCGC7fysJxHmAw+rMqhGnvuyMO1?=
 =?iso-8859-1?Q?2HwJklczpxatzusoGNh1B0fKRiZvKIcr37qsxLp2ol0QfoCqU5UPWiVRap?=
 =?iso-8859-1?Q?9md6Wly+qgLeZ6t/cMlb98iCl09GUVa/zOspQhQANrAOMSxV203r/guGeH?=
 =?iso-8859-1?Q?gplJNZ0FDvWKncV/1o5hVRUACtTuz8yM8SMQmbCQV3EOnZvN1PW7rtlYCr?=
 =?iso-8859-1?Q?m1lMgHxV2w456BYB6mMlST5RTKfKeOT18mbhfXlAHTCWitBb/IThDAMrIH?=
 =?iso-8859-1?Q?YJgmPKPOEuV03+P6oOIrP31pjGPfGnS+nfsoPfvyqEBbCcEwoij4NC2Yxy?=
 =?iso-8859-1?Q?XG7r52h7+pKojZebycssXSQjHnOT52KdBvpmHGEDGxwH0sUnXJSwTlTC7h?=
 =?iso-8859-1?Q?CQEaskybRAEWeijCwvxaV1evlUkKnWAtyIW71lvHRGCD5B/3M81AVcklSQ?=
 =?iso-8859-1?Q?KsaYEkbK8WqY9/AuDmGDg/o47zr++SDav16GkpJDFhavxHXcY9xPO+kFXU?=
 =?iso-8859-1?Q?m5VFeyAKhU1tbo2pVEE3m/WGjJO9pELCkrjmNmSG2C5cLOWCEagxopXw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18034563-d142-471a-bd68-08db0bcbc163
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 01:03:15.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U1H8ALrgsO4z2l1c2gSYx27RzfxlXvaXm/8S/B3eECfxxe6TfctT+zwEs2u1BzU0vt3MamRWnu5yUQ+6AVh0uceXzUTPHtXgzABLMe7Rao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Verma, Vishal L wrote:
> On Fri, 2023-02-10 at 01:06 -0800, Dan Williams wrote:
> > Region autodiscovery is an asynchronous state machine advanced by
> > cxl_port_probe(). After the decoders on an endpoint port are enumerated
> > they are scanned for actively enabled instances. Each active decoder is
> > flagged for auto-assembly CXL_DECODER_F_AUTO and attached to a region.
> > If a region does not already exist for the address range setting of the
> > decoder one is created. That creation process may race with other
> > decoders of the same region being discovered since cxl_port_probe() is
> > asynchronous. A new 'struct cxl_root_decoder' lock, @range_lock, is
> > introduced to mitigate that race.
> > 
> > Once all decoders have arrived, "p->nr_targets == p->interleave_ways",
> > they are sorted by their relative decode position. The sort algorithm
> > involves finding the point in the cxl_port topology where one leg of the
> > decode leads to deviceA and the other deviceB. At that point in the
> > topology the target order in the 'struct cxl_switch_decoder' indicates
> > the relative position of those endpoint decoders in the region.
> > 
> > > From that point the region goes through the same setup and validation
> > steps as user-created regions, but instead of programming the decoders
> > it validates that driver would have written the same values to the
> > decoders as were already present.
> > 
> > Tested-by: Fan Ni <fan.ni@samsung.com>
> > Link: https://lore.kernel.org/r/167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c    |   11 +
> >  drivers/cxl/core/port.c   |    2 
> >  drivers/cxl/core/region.c |  497 ++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h         |   29 +++
> >  drivers/cxl/port.c        |   48 ++++
> >  5 files changed, 576 insertions(+), 11 deletions(-)
> > 
> > 
> One question below, but otherwise looks good,
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> <..>
> 
> >  
> > +static int cxl_region_attach_auto(struct cxl_region *cxlr,
> > +                                 struct cxl_endpoint_decoder *cxled, int pos)
> > +{
> > +       struct cxl_region_params *p = &cxlr->params;
> > +
> > +       if (cxled->state != CXL_DECODER_STATE_AUTO) {
> > +               dev_err(&cxlr->dev,
> > +                       "%s: unable to add decoder to autodetected region\n",
> > +                       dev_name(&cxled->cxld.dev));
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (pos >= 0) {
> > +               dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
> > +                       dev_name(&cxled->cxld.dev), pos);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (p->nr_targets >= p->interleave_ways) {
> > +               dev_err(&cxlr->dev, "%s: no more target slots available\n",
> > +                       dev_name(&cxled->cxld.dev));
> > +               return -ENXIO;
> > +       }
> > +
> > +       /*
> > +        * Temporarily record the endpoint decoder into the target array. Yes,
> > +        * this means that userspace can view devices in the wrong position
> > +        * before the region activates, and must be careful to understand when
> > +        * it might be racing region autodiscovery.
> > +        */
> 
> Would it be worthwhile adding an attribute around this - either to
> distinguish an auto-assembled region from a user-created one, or
> perhaps better - something to mark the assembly complete? cxl-list
> doesn't have to display this attribute as is, but maybe it can make a
> decision to mark it as idle while assembly is pending, or maybe even
> refuse to add_cxl_region() for it entirely?
> 
> This can be a follow-on too.

"Assembly complete" is determined by "commit" going active. What about
all of the "targetX" attributes printing the decoder-name out with a prefix
like:

    "auto:decoderX.Y"

...that way userspace can both see what candidate decoders the kernel is
considering, and the fact that assembly is still in progress (or
stalled).

The concern thought is breaking legacy that only ever expects to read
decoder names there... guess it depends on how bad the failure mode is.

Instead, maybe a new attribute like "origin" that returns "manual" vs
"auto"?
