Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2F696A1E
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Feb 2023 17:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBNQpA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Feb 2023 11:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBNQom (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2023 11:44:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C92CFD3;
        Tue, 14 Feb 2023 08:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676393043; x=1707929043;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3tvw/QI2D6ZTdCszmgUUILhpm8UFQ9Woe8Lafhd7yBQ=;
  b=MvCzmgE2/uX/DVBds5boDUTOlWJDbBpzG/fdW/ZUDFHhQCSJbHJdgRhH
   sQV6HSTZwBmZjCMJkW/xKPK9pgKqSsFqMEVb7pnmNNEIEGQxGAGRgvEGp
   ntp63TNV2aMcwWnK1M+jMuZkwygCUBk2SJWZ015a7UsjAbWAt+oP47yzA
   qnZ4KaR0i0dG0aDSz2vMlTzdXIYVWr4FEX1JJOf7eYvhRbulV2JXMo8wD
   ShYrbDF+G+PUNu6a8wT9Qnr+1dYaPgmJR9kA6dI9Vqca680TQVYd36Uxt
   +JN18Tjr6AAXsumYU2M2juep30mNpHEIB1UFiani468c4V9L9uwqmIoQx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417422827"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="417422827"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778408876"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="778408876"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2023 08:43:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:43:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:43:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 08:43:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fur7xvapgA4W16qGJxEWCt6xzyePX5KOnseLFYnDewNCsu8vJx8Hc3x28cT78oG6ZPsggYkfe4izPQ7qcYWwwRJj4CkwkOEMzF2tRLKsJsCjqX9YrXtjsE3IcX1xIgztIaVowh2W8+U5YLiXRIIpWiuWBP9iKdk3lsj+Itr4wK/uMYVsvIWQodTdp3UWQG1WZ4CWNHLp/2Qerd+56gYVMVMWEsUOZzLeT5gCn7bLM/4TJKOQJxZG+bvTMxiiFN4kS7IvjSkx28URCuvw+SYVwu/jcJUwuMFjh5DJ9qMk4Xs9Fs+BkoBP5sSWbmS4M6GO+E7nA5EpMAQjslBIof8sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf19+GqZdyBUa2M+KLC4NWRWvx6V4y69gY0Htj+LPHc=;
 b=P52SvY054qIJ5mBKAzv/Iy1MRSQ/Sb4hZ+414oOX9pJKPHnkwoTk1xMu13q83QSIxGYczzd/XWAWuGfJK5PkMFD/7CgMw4p+SCap5xyIKOnTRbOPl/reaOfxY/pyN2ZXi9af0kOE1sCHCZA4mIBPq8nsm0HhjXyPHbmWR32u5z6Yws3UH+6lH4csG9/jssAL6Hrf/lTnPRN+YgbvoK8J+bJHc5J7eajlErmtgnyt3W2V+S1cACiLe4g0c4+vtjNHW8eK+cZqO60wdP+CHC/AEFMAAwzLqddXrDlyvfkXQ/b1MirSufvl039TNl6ByeRyUaVIECBvQfjKEhI7pJKa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 16:43:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 16:43:42 +0000
Date:   Tue, 14 Feb 2023 08:43:39 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Message-ID: <63ebba3b6fe55_32d6129475@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
 <20230210180958.00002e5a@Huawei.com>
 <63e6b89581c3c_1db5d029467@dwillia2-xfh.jf.intel.com.notmuch>
 <20230214132336.00005915@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230214132336.00005915@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d762e7-b391-4296-a7e0-08db0eaaa173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8SMG+RnG8uqudp0yYcCoyJfagdxuRbmQiY1sIJ2ZDU8TATT6L4p8S0nzuJw3J+dSgWdI9XbWUeHCMldkTAXhVjHBPEHTVsUWCSvF/ePdkVwABUudB/uI5JQxEca5Z4mrFbwL2+9qqUueBOup7gvVedDvilWQLCVdBb3AP+Ao6UFiCLilNclU2TCchU6LX+Zi6ZgggNecbeXGfKk0gwzh25ZUXaqnizJUAXmoRZWHPUZJdyvIs4aWP169t4XNFTUyPnqo6YvLs+ATyGJOMyuT7eGwDxHftXumGS/tl1QepRKo3+MzRA0HWbpx+R2R1DgHO234bBA5CYul+VOUzDbD93++hcdpoefzAh2oRyEhXqmbO44Q+DxbhuQbEbpjqsLImXuUbvytu23WZ8y2tlAN1DtZrgUkvlkILlEZxx0UoOe68s7f3MidopgljzQmlJUfWTggHvRGckotHVrtS/3w2PzgbUVPtCud6ozpGBfXM1wuNmiJqkILHNtQm5/cacNxGKcO07cKoIx1Ls8Uepa8p07yUj1sIw1mvKtuMCiOZHmImPcw3C64fuLTWeQ546wr1WMDfHwFCXJNwGegIxM7oCOgTP5qBbJpcuwHNTkp0YESo24yY+VriTw5dDM2q3eKUdAgdv2M6Fpl9K0YHjsuroaujYPJR8nFCi4bBf2lEywQVcaXOFK0RZL7u5AXbkJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(6666004)(6486002)(478600001)(5660300002)(26005)(186003)(6512007)(9686003)(8936002)(2906002)(316002)(6506007)(41300700001)(4744005)(86362001)(82960400001)(110136005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ucz4E+xqg1qrgXRaOwjHIed6n9QHuOftTkcXpidGbkC68sBTN4eppasOXQQk?=
 =?us-ascii?Q?zqe1PTFP7FhPtUkQ3QDwcFcKT3aFtlaBkCpESixCHGrDK8/jVLqQU+YQAFj+?=
 =?us-ascii?Q?CguZQKxyCZUXBnqcQ2OgIHBEU7UFtZFo1mx+IUV47e8S5Afnpizgk40Q23Og?=
 =?us-ascii?Q?5IrJw6c8CszFvwD8dF/YSes1cpQyxDN5aBJDe2yQ7XzSKmi+zOSpEfq+rDCE?=
 =?us-ascii?Q?BumRjtX5Dg/V4pjQAft/2+YGEKTFonGRwK9gJv2E8tqW6yvbOVlWbPTVOhjz?=
 =?us-ascii?Q?aq0UJuhkq7vcOg71KTRU3tfsj4jQmaMwP4eSx4wSfVY5/fWUb3W2S3XuDVb4?=
 =?us-ascii?Q?6PIVrIKhkw4aG2qqII3STSz4IoebB3Q9ZRhgIIi/QRoKUyJEuwuwCthCri6e?=
 =?us-ascii?Q?dgyQNeLXaHXI71kOAyJyl5QcYZrDo5FMJqL56bUBhVEbYUOgvGKxKMi5gxaW?=
 =?us-ascii?Q?GkRtewi8wmCmFdOGRhY6honRSfrgjYIBsuJzdmIEwflhKEfhKH5uqeMRhcsH?=
 =?us-ascii?Q?nASJhcK//B7m0Hwy09xlqwk0iN9C7wFcaBSkFtQeM32xteUpaUvscH35qLJR?=
 =?us-ascii?Q?cPaE+MjhluytGvDCG4Thzwu3/Esnu3qSHZuEKskjnSzoQuuHcmOlujfgxjy1?=
 =?us-ascii?Q?AT8Cxf6Jkmq56q+9TOuFTW+ciJDGpeKIcUKHmS1epZo8Bw8FNLpMwSgCE57F?=
 =?us-ascii?Q?CYs3xv5WeHHOYus28OJRFv/tO3iI9n1Khv7nIqMZpPkwNyEHJJ0iVq9MQ2aw?=
 =?us-ascii?Q?5OHGVFM059bRpLF1pDimdnHCRpr/eM2FnpTyvndlpWbBOH/279/zmkRjG2MH?=
 =?us-ascii?Q?VrQM3i+up+pR66i5KS2aXU02W+nMfjXxSdt14g5neZET6b8KK9jnUNshIOJo?=
 =?us-ascii?Q?ltIIp0SAKWsBwHtXVxhSlPYXIlk9rikvWjK8tJZIpPrFUrfWUCOTENhtSFGF?=
 =?us-ascii?Q?lYngQvpeuCG9yU9dkCS5QO6uhgT0af/E9yqxXnnP7YaqLj11bJ+XCOd39hef?=
 =?us-ascii?Q?94ck5KnxTo1uNxwmpVP4Xy+Z9uJCQPGamGNLuP1P3l8M73s/Q16g7zUilIf7?=
 =?us-ascii?Q?n/A6DhvoowHTJfX9UmGTRjv0yHzpx3mfw1h9PNFAzOcrj0VIkJkf5GRP5dmv?=
 =?us-ascii?Q?+fXp6HMn1hQpI64oWNHJl//FMliJuN2X0+rxJphEzLVpIgRw21PYSm6U7/Fn?=
 =?us-ascii?Q?DpxkthKDVSwkuYsZSiNVLQCmJ4S4bFpcWgdvAe3eUdmwlEy5t96RqyntRlD4?=
 =?us-ascii?Q?Bb/mqdy2E1OYKuTj/awxk8d0sDjRw78/PSt1ABCDGqq6+DTbednGDhIiI071?=
 =?us-ascii?Q?FcsW5rZS3OuXrczfrcZ6DbWZTlBv9pfW5kFtNXLSNgOsewBeF8efcFPWLtMX?=
 =?us-ascii?Q?+tiintyJyLQLnIWV+WBGA+DK7cf3oJMvICPqMzS3aSQxSemhd3gpZk2or/9C?=
 =?us-ascii?Q?9uV3iE5mfAEJ+xscNuLKIxMPY3mitMJJWPATpA3VaLLcuwuAt9G9cVAgiJWY?=
 =?us-ascii?Q?J239+STmzFlUcPceNrCK6LED9HMg10gbkYYo+v90nm8Of7gPmjh3DRBOonGr?=
 =?us-ascii?Q?lrrIaviXDiIIYBLdtMYiMQ/+7DsrlRyQBHsufU59+UKOJGeK9sAG+rRaUMr6?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d762e7-b391-4296-a7e0-08db0eaaa173
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:43:42.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TowZSjUtMxzXdRV4qkGQgrZw5T7UZWGyIzLVURYDoR7VARFPV4aPxVZVcfTRqmz7WVrs0QEdnImb8ONDyiHaCvmqrucDP1nLTCapp3GX8Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
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
> 
> > > 
> > > 		/*
> > > 		 * If device_attach() fails the range may still be active via
> > > 		 * the platform-firmware memory map, otherwise the driver for
> > > 		 * regions is local to this file, so driver matching can't fail
> > > +                * and hence device_attach() cannot return 1.
> > > 
> > > //very much not obvious otherwise to anyone who isn't far too familiar with device_attach()  
> > 
> > Hence the comment? Not sure what else can be said here about why
> > device_attach() < 0 is a sufficient check.
> 
> I'd just add the bit I added above that calls out the condition you are
> describing is indicated by a return of 1.

Got it.
