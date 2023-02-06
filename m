Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3F68C57E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 19:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBFSO0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 13:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFSOZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 13:14:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6261DB84;
        Mon,  6 Feb 2023 10:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675707264; x=1707243264;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O1Ks2k6t3s63j1713uiv1afVYnS1LrP4hw73wocqJUc=;
  b=kl3zwTyNCx6ECP1a+N/VRHmsa0YS/zaqDiUShwJ/VaEs4R2teQQ9SdR9
   MBuM8xX+G0O5F8GSecUnZ7jnbIrOzY2Se76sL/hewbF7LxMjMwcSnbAay
   J/dAZD6cQp2dToXSwpmM4L5DKGP2JpYtKoV48VW88mnvG16XT0ilxiO6+
   l5b8Xr6LjY7Cof8/a0l+oW22eOcS0q5j++9TcmBkMo8GX4RULFLmp+f4x
   DWzil017VJNafs4BCc5zplnNirpXvq9zkly6w7MHy1Jq5csutz2yKR4+n
   ixiRbq97a1raxkXZnz+IcSJsJryokhC77oLwDR7OSdzFKKuI7T0rGfhXM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="326961981"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="326961981"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 10:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="809214628"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="809214628"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 06 Feb 2023 10:14:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:14:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:14:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 10:14:22 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 10:14:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJpyg9If6/3Vt5G9Ex4j0d1BqwJHP3Nv+XEpePQh9I+WBEeAtI8WLFwDMOaQoGBQ0LaiGi4WCSboJggxzNxbXGaW2ka7dAEob2n3SDw7+RUlgPT78bJKnRc0F9XPRUxz+k/vNVn0FfNb5k/h9S4rTHiCU3Uszrsby+yB8wtNYWK45h6ADXhl9fdpkv9PgAbFBXIqJPqfcH8xtTUd00e2pNrcUfI/y5wcTudFtYgfYN1fRmD9fXlq9hV2Yxx2Ahiwaq1h+seNZA9j2z9fKlhpzct2c7rVDKSSgeBjMDVECsFcbImZTRFAfaErVbkigmDOFgXf4PIKnhHpeoZV6A+XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fABKwkfzr2HbcuCozw3unjzvGAdD3HqRJrRRLqnSN/U=;
 b=Pqy/BUCdKpIAph/H/yqUbKOfZeDtYaW194uMJRm3LV+DC2KlebSvbT+R26JZZbCiIvT8Na11sH/tRCTUCiylc4b54h3O1WS7g9qzIRKDSu/ak4C00Dv7JNT2U/H9/2r5/5+TEv6DuRwq5b5UOcGAWjYSPhOG0oUxuYq08Y8afk0OcKmhI7LfG3gazknJ7DiXMySx6Ggx623Tf/arFzMwXmJHW8hp0aaTE/zp2gWRNuSS2cLtODOMFn70IvJMrGOPuCcUKwZ80dYRCM1DH1hfsr8qC4kkxoPazPo3LbLp2fIuwE8tncNrGmntk4uQl8gHZ/16vMdRZ0pawaBLO3imrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 18:14:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 18:14:21 +0000
Date:   Mon, 6 Feb 2023 10:14:18 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 04/18] cxl/region: Validate region mode vs decoder mode
Message-ID: <63e1437a8e6bb_ea22229452@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537131.847146.9020072654741860107.stgit@dwillia2-xfh.jf.intel.com>
 <20230206160221.000045ea@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206160221.000045ea@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0203a6-4423-4e9b-30f7-08db086df7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76MxHsJhiMFLRSA3aTH49QHhodaUAnhrnTfDV0o+g4dT/wZrHniLEr866yXmJsCoS141WjdSzKW49Y1147NWqSQjXM0y7l2vR1VXeRCFYknChIH7829rhWcCD85oUjKqMtENryZmslU7y7ufppcckCPMC3fmAn2YS/D+SPYaVCZcXfLsix0hAZLac45JJl9DylIlWNUUCDQqnbEPaIZmQSrTC8Yj8NBNJR4txl5mqnber1DlZiYkeUwlFSrXXFLjTUsXiD1d5TkuocBhxcbix3YoGhoj91+8ksseAoNaLya8zbkSN+cbOQQfDqA2za2nbO8btNStXzwhu/sKRYg/OJMEtRxaHmzSCrxILMUSl8+nqDDPi1NJAqoI7T7SPh+CCYQmE2bu+taAf5YuDLMI5LyR132ukdAZ13d4uqtDACR96B7Af8VWTkjcoZLa9alHDhPwS4b2JK2Kz9dWNVesgolLt+m4nmH8NTbWB1MpJXUGBL2/ShpbOg/Wmfjxdie5qAE3wm7hCXaFmOQ3i7p+6FVfrSWGjX0QCkRDynxsRYBJYgf7X1RJJtpPgDgqsKyGv2UTf7f9qCkxIck4STz5IFwY+g/JZ4rX/l/uxHe/dfZTlhXvRQnaJKJFwkb1o6pRll+kO5j4caHh0t3DNBZDkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(478600001)(316002)(110136005)(6506007)(6512007)(26005)(6666004)(9686003)(186003)(6486002)(5660300002)(86362001)(82960400001)(38100700002)(83380400001)(66946007)(4326008)(8676002)(2906002)(8936002)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nmqEv21mt9sPP581hVAM7vgYPrqo84mtUDjUK05jXbCTtedOi0tw7GdnrAp+?=
 =?us-ascii?Q?JURjPmpFE0m1KD8vsSDoGO44k7YPsNSkwZuQcQPTmZjoe/eMYy9c37PlfB7A?=
 =?us-ascii?Q?XGy2gHUdEVBRl+Zdj//JTRLKDayh0P140KUMxl+hiOt4gtZSp5ouMc1duUeO?=
 =?us-ascii?Q?tD2gLbOBKbLcpGTpUwQjpt0WHJ2mo7S9AZm0rFfFPlCueAwgy/AaiBHGW9Tg?=
 =?us-ascii?Q?eDK/sOl2oOJftAJF/1oXiRXAEi9QDOCVV6vDXJ2N/nL/GeIgIUTQXpiwTXzo?=
 =?us-ascii?Q?gO8NobnM6MejDh8mctPtPbr1dH/l7AeXsaT6qBhykBbOohCD0lcudxmKUdNo?=
 =?us-ascii?Q?dl2T7icTPnHYSMUCRlNKWeqdCIYvKVXOyJm0ltNukc/FnOH3h0iCBmyKkYPZ?=
 =?us-ascii?Q?C+We4XD+e00aq6xOcqAYHtnvf1j4fm6d3J0wDzttNzzV/yi8R80dNVIKfgwO?=
 =?us-ascii?Q?B0mCy2SKXjzrHzdoL28ipp4ghDgl0qQMsPpoOFXjWPDI6EevLlLEuMBZTUCY?=
 =?us-ascii?Q?aZ8bDbuYz6Phh++MtY6scKZI/pGfj+XNGI2FQfUDztKW6hDlNFLyZphwuTG4?=
 =?us-ascii?Q?Bdb7CgjMqKo+i4MPtgcGY5MHhe5meFoUltTGBuLygVWh8GtL3y6Nl+0QsMC0?=
 =?us-ascii?Q?oRklw+P6F235kZm4Ao5CIFXJ/3k+SS1V2XoDlT5NrE0VoHYmHcfuE2IJITMn?=
 =?us-ascii?Q?HsbS/pBPgGWWXFxDp6ks2Gam5iVFtifOhbLLYGa6yHXH7Gs7FOjFtc6eekE5?=
 =?us-ascii?Q?mEpDmRS8owuH6OOrYl8VnLoPweRNYJszknpHI8ov8n6993NM9va2gfgp4BBz?=
 =?us-ascii?Q?V86wF4gCfNKPI0TypD7tY/yx9BtvK5nPzqE+4kL+dHRGnEvpWbH/pzW54ugG?=
 =?us-ascii?Q?uI0MkUC3sdTi02SrdBxRNfTL8Eyj09MQkKm/yPVL1s+taVokwNFGtZ6/5/v/?=
 =?us-ascii?Q?Bcmw4tcrPGnCMOMEBMEhQEaXAyL4iK0hA9XrmmvM8OPrGAQKFs0YMgLi0DsO?=
 =?us-ascii?Q?ZeZW/9YdhWejg0vAGPtlUGbTXicVAnVnWff8JzifHHMdgbWzy1e1PRB/fLzm?=
 =?us-ascii?Q?hPUhnkbyzt6bxJEAdvAkIBejNDim6ExpN3/MVDBDV2qDxp9Ajl1N0z+vrDj1?=
 =?us-ascii?Q?GJkNzsrnc4XSfNbIewD/AZ403LIwysnVUue2LPSniqmm+FVwDnO7BkHBIlvN?=
 =?us-ascii?Q?O+iPvOZRWOZYLfazhMJAt/AfjI8X30Q1QJgCfruCdzF11VRK40OuWJkratN5?=
 =?us-ascii?Q?ZUM7owatXMxPsJvFhDXskAgNAXprHh0welt2azyKufU8HOKQT5mCwQre2Y80?=
 =?us-ascii?Q?dDz4gKmvNfUE9kprBJvzWRfAZFhppaNgrP+p7ED8Ck0Kw2yRIeZoc+j2ukEb?=
 =?us-ascii?Q?DFwolOackqgbA+iCaL+oranc1fUD1xM23u57mXArS4aDxfhTy6wOi5vY7AWf?=
 =?us-ascii?Q?qfOP8yehwqhIwUFYglTwOS3e38Pau7JENcDHl59bPrq1Ak2bsAWHKc5ol9uj?=
 =?us-ascii?Q?joEIE3O3HeqB6wt8rLLklb4ZnYHfhjT3GYnvruGmsPjdocBI7XFxzd97Dnbf?=
 =?us-ascii?Q?fNcVGH1HewzrXIX+APrc1lBcPeES/zmdPa2FBLazLPFw+RT5UWR489sJqQxh?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0203a6-4423-4e9b-30f7-08db086df7d6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 18:14:20.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbo1WgCLKXIzwn5lQIVy7bgwLFm2Vlq2jMxxe3LHcyp0RNlqxSH2B/x/Ya4orFXHbLRL8oHGVMZTn8LxTe8A4WECYJfCRt3N8t3D/2/RT6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
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
> On Sun, 05 Feb 2023 17:02:51 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for a new region mode, do not, for example, allow
> > 'ram' decoders to be assigned to 'pmem' regions and vice versa.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I guess we aren't support mixed endpoint decoders for now (and
> maybe never..) If we did I'd expect this to have to allow
> mixed with either RAM or PMEM.

Mixed is a bug, or I otherwise can not think of a scenario where it is
valid. The kernel prevents it, but platform firmware can make
that mistake. I think if the kernel ever encounters that and works
around it that will come with a loud TAINT_FIRMWARE_WORKAROUND warning.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


