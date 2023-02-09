Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546668FEBE
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 05:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBIEaB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 23:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBIE3z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 23:29:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCB12F3F;
        Wed,  8 Feb 2023 20:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916969; x=1707452969;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AGQIzDj7ev1r3blwHQAf1Pha4B3SkS5JXLEAif6SprA=;
  b=XiZubnXBVVFNrgTxrQjbHsw1ydgLnCKKx54D/9G4o/w03fYmRmTbFRsc
   d0VVEP5Dr+rw/aoQi5HoCU5/Ze25o0Y/gII4OI9NTYRoOXPePB/BeeDUH
   HKexMFKva1cC8PASGCJmOoDDMRKBzss09C220dyBKtmPxSODQbmdnVeNh
   ZkbfzWsVt0gAU4L33lEKYjc4zJ+PJVqSFZmrE4w5Y/VV2b/DmTU6z7lJ4
   4wyp2ckh85wwWZ9cIDJwRiN/9HX0oCndM6vm2Gg5jFnc6rosHoav/UgPu
   PP4TSJqou+0PthKHTTezfnZegeiJH7I7PFEhdQcuog1IiF8u9yzlUD9Z9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="328656594"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="328656594"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756276985"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="756276985"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Feb 2023 20:26:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:26:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 20:26:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 20:26:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRKjWRlVAPDGzfn/lq2LnahGcbqXA8yy+xf7RdVtevvhnVOHEAfO19g3oaF8+WmGPbZ4c9xga6nLIoNl/0w0cDsGUt/JBnoFrhKorWdyZ3ZCmEdfqhYorS/PUDNiBdm2wgaiCNu2vv00ao8S7c2OlBa7A1V2AxYPgrnInn+PuKOLCj3aRXVgaEraFLpdz5q854pL8l5Np5czgjxRH7XA+Uh0S73bqNniePKB4xdyZthHQIjPnRWiOoacEYz5fIFOlGqzRdMKHXl5TFxF30jLpVsu66Wkrf/D88BPN9CZY9kpIxsy46SjNzC1q0EX6jm5J61EvEGjTFTEv3uBXDj/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpDjZ7hhTC66KbjmKny8djo2nnTXXRb+Tef7Wp90wZM=;
 b=DnrF883SaK2+HlZIROb3cIXOYAnqOPUbaVfKHzA13w25RUKGHXOHQaBm/C9RBRM8D/n+gTVTOKCPN/hHBMt8v99jGVaJHKnQLJNZVwYwFX7Ev/qBAYxjuRRWFX+Uy068TF5tx22gepp7Th/sW5DAWpZFwc+WSpe0jAO43yFDx6DplPTkE8JdmtdX3IN5y2bnAJ2QGsVAo+kNGAgXCuIEw9wP6BGN6QxVWJSOflmrsDDS5cTIos971Z5Vbw0MiOYoHSfL4mhFfiniZ8/qqKGugK5Hu8wUmeycWlghTH5L/bBS1cj5Wm38GPUPJnBTw6wEpSX9Y9fiVSckKmUzTGm+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 04:26:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 04:26:33 +0000
Date:   Wed, 8 Feb 2023 20:26:26 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
Message-ID: <63e475f2a5fd_36c729455@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
 <20230208123031.00006990@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208123031.00006990@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5836cb-9872-4070-8c91-08db0a55d308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVDEGoKyv8kuGIjmpVw46xf/vaKxb2FUicoRX1auId4VRcLnKr0pQgSSyxZw6BfxvJdD8NlyhXdevADN2vow2MV8ZtFAyPvW6aZ65m53GY+CjaIkbtUZxO2jf8pEh/NjwG5RhGY9/QimzbQ3TTnOK1fulAfvjTzN0xT6O6i9cIZu4+u/3FTQe55c/3qn+TKQAx6orCRYAKpEDd1TR6COxnc7dyfnVgA7wKrNDer3IXvtIqn8WlalhncpYccdj4Wi+eF4m6ajW5enTj1BOpMJmM3tRizy0ly6fhKgMvRD1JeCoGXCZFEKMDzcHlpten51IZX6zof8OXSHQyGRHVEVXvIqS5QXbUV0xLsn3zX0jFNsYM9JHHh1TcdLQZi7WkBvttdpOqnsYlVmgcBu+tHXm693dPR1ABfk7qjfMIw8gVRyuPa/pxCePbCpHQAkdQyaa1KNsi11qC8Y4b7BnFygBerQm652nOoFDsHwOMGGCi7rGEs9G8kbijFfxYyCGVbHLXhjGfuse9Fa0ryNjQgUvZE6N1zj0+qBJi/fhC4SDNDAbmFfb8YTER9g0gPgbOkLZJUjtTFQuPi/kFlA276fh4BFkkDWLXujBk7t+Fw6hTu8kEikH4Pdov6pnrf7jbislVKdGCYpXEY1qQBMpJNr7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(66899018)(316002)(66476007)(110136005)(8936002)(66946007)(8676002)(186003)(66556008)(41300700001)(4326008)(5660300002)(86362001)(82960400001)(38100700002)(9686003)(6512007)(26005)(6506007)(6666004)(4744005)(2906002)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTf80bzHK54Os3kkDkLbT6LxZUeFPtQLnx5An+Tif3wNzhB5I+c6yAubpY19?=
 =?us-ascii?Q?JUDHd12p8xB0r4ELjracQ1AYwm7yi8tLQEW45kCD8XRGmZAJLWHI0wFxR2KO?=
 =?us-ascii?Q?7g7Wq6Xa3k601P/3AMuAuuniLNPzc5b3RXaIZrCc8seanZbzXb5qYJj67bzz?=
 =?us-ascii?Q?G+oVW/YqNH7V3XgZIvcPC7zHKLmNC70aj7f8ilg5ohaqe8i/oN93GhaRtC65?=
 =?us-ascii?Q?AiPXfxjofYpysOcMphGkvwOYB6XXKDyyVMEktc0poMU1pFiYabU2dLrOOjFm?=
 =?us-ascii?Q?IwE+oHnx8OdtHS67oqxuzDPkFqWRkHPVbLDCjnQoeaNRPddW5g+PnQQYTfUL?=
 =?us-ascii?Q?4IAtG/YJfmm7/SbdxImgYfFGxiINYBfHPZksAQro+4oE/fKh6O9rbjEm6q9H?=
 =?us-ascii?Q?+vVhHxphkJoBWxO9sunnlsHVosphgik41AmXJFO0CinDSOl8rezv/WM8q9/z?=
 =?us-ascii?Q?YJ5XvVRXgQsNgGhx9pjqGAarXy4j4P1C5vpqPatLbyjHiyGPMgN4xoGOmOKH?=
 =?us-ascii?Q?TPXs+LEEMsCIjB9qzOgrGysQJiMgWM7uv2mwkmggp3KnU1ZlDYgLTacrDr0m?=
 =?us-ascii?Q?mtKGPlmQ7ZeAD4ekZPDSfcj6M2x4x+cDO7zWMTPLYC0/18N4lBdVqIfBwJhL?=
 =?us-ascii?Q?+RwNzETSZvt5Jx1jJ99/2z8pQjiTG0K5nLWWzT0rKT/w9mhUuNfiZTsL411+?=
 =?us-ascii?Q?DuS+uWC8vcJqxNbyGWhX3OdSyKS/dlJPT4xVsPVKySU2vuktYRrw3iJzcpsM?=
 =?us-ascii?Q?ioDva1S/MCh6VQieRIf+rvcuNeARwnKGa36TO9SppMNaw3L8vSzGSTWOXRSi?=
 =?us-ascii?Q?EEntyKGjVEmkXqkTL4L2pFkRkVHRsxLX/jxBt3fpIvWw4Olx4AmF0pikaKcd?=
 =?us-ascii?Q?ajNn9WmFZZs3yuUJOTiobkplWpstuCMFfQtOcL3aSGBSR0TZ5iorQSIzbxz5?=
 =?us-ascii?Q?acyXfO+/Qzz2jlWBwGy3wJrTB8NHFWey8anhAIbf79adZ+T1iICf6cJ2UduU?=
 =?us-ascii?Q?kLs6EC5ajrm55Aq5s092EMulhJv7QOBGbrzRKlv0kXHZgCI11VB/8cHNX8Fl?=
 =?us-ascii?Q?+akPEBM65+bzI6XD6LH9ucha5ov4pEUekLjUVKjjk0bPVsa4wAx4VBu5qul+?=
 =?us-ascii?Q?QoHtghewaDZ6vwTpfamO+DAREqMhqya+4KL5CrUiIp1PNLS5XqX0IT26GAI5?=
 =?us-ascii?Q?VqBZZ65OztQoVxdkVcBYjuD/SKfYBnRMMgUnX78ZGYGrv5LAYstnBN72xNjA?=
 =?us-ascii?Q?vP18Z9I2TTbmW6ywHWPM5aSHlmVdSPmUaPk4Jo2Klb2LZuyRtkomRG4nnEZV?=
 =?us-ascii?Q?PsVCxu6qwrb71PyNH6pOnCKZjGDezcW0mTnNF7Zoe6lf8IBAokk/eh8W+RNr?=
 =?us-ascii?Q?ojxZE/XdMPDUt2QW/wEmV4D2OgtwXMPVSgEdhU7HLHfWtmIzAJiEiaBmMjI3?=
 =?us-ascii?Q?OplZ8EL926FFeRJ8SLouJzX7OJHHMV5Y1wwWvC1OD57cHK7JzJbvDrhfqeCQ?=
 =?us-ascii?Q?1fbqqJYVjpLskhlQAU6RlxlTVp5Tt+nPhryu5faYmBokfp91SjaCcVNQBUYf?=
 =?us-ascii?Q?pgJ6Y66xcVyBEnnSYoHgDOYtEHc/br/6t8W/rk0dfN0+einXqJrwXhF9SC8r?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5836cb-9872-4070-8c91-08db0a55d308
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 04:26:33.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdO7mdzU9G3KRnX9grWX4wVF2JxKfZJmHl5KyLVRtuyWlvN7glQ0ltsrWqcbqqOeTf/bUnrOjCmD98PAFSYRJWsGuJnspXUHnSZUjEUMzis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6153
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
[..]
> > @@ -1284,13 +1327,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> > -		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> > -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > -			dev_name(&cxlrd->cxlsd.cxld.dev));
> > -		return -ENXIO;
> > -	}
> > -
> 
> In an ideal world, this would have been nice as two patches.
> One that reorders the various checks so that they are in the order
> after you have factored things out (easy to review for correctness)
> then one that factored it out.

I played with this a bit and the only way I could see to make the diff
come out significantly nicer would be to use a forward declaration to
move the new helpers below cxl_region_attach().
