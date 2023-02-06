Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11568C6C6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBFT1Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjBFT1N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:27:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF52DE7D;
        Mon,  6 Feb 2023 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711611; x=1707247611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FbXTmFTwP5XZzIcObM3nS3hAVG1c7lElP+Y1jaYuINE=;
  b=GQb1/02Nrwzo32GzyjXGBKIqqhG47zLFo33d6G+NYIHfwNe0PldlWEl2
   qS9gK51f39HVInfDigcrbqryG8rqUaT4WEqLM2MTD8VO5qdv5E9434oU9
   zW7PzllrraeP6ob//9j8XmebnF6mzyOGoYlLEjOtYoJRIRxfRk4ZNUEEF
   bga17O7bn9ZdfBaaufwYHbr/xtJ6sFXlyodGKX500vH0yPpDqxPyhuoCP
   koD93f4FzIXnNi6bMb7M6pTdThbC0t4We9hELOa3K5IT51QWLY5cimw/e
   0auEhpCZJdcfSIC2Xc2Cv5ic+Fw8ANvcZku4m8B0iNHqfwRIpjXpran60
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="356658143"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356658143"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616541107"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616541107"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 11:26:50 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:26:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:26:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:26:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXDYhIU+tZ95mEmysD0a46zOy2YK5iMJvbfJxACArIXKq0455mIxdldnsAi9/iI9syXrNcMtXLJJN1o76jqCueOOIPyQ+m5vlOFNLa9gFqHVPzTe3Tr2ABaa+O3hL/YlMh7KyP9f9sGdp6X5Ixr6Y+XeGK8jwkyo4B6Z7gXaq0iDOQCaEMRhY+vP4QhaHcmdQpQoLWck7rmeb3Y/YGmbIefndDXt5UxMVeBw5VqV6SzEEj1UyvQt9AjEFLTu9HjQnmf6htHY5UJmbdPCesx4sb5UhArD2PFUXO2jw8Xnu06TDV3GdxwZOhqV5BgaJ/K9k6eBWKy6hSVgTxEwFlNJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8QRVMUThrXZA1/DrMfUluzGNty+9xtvq7HUew6ba9M=;
 b=oDgftlacssxc77apOx6DiCy31BK3b7djev5kEhF8sX/FljUwAJljxaQuhqjE08k6xv6DUVOJ9g/rnN9sLFLTsdHtE7L+xD3vNpoj+k285rSvl+fKLUHKgivnd370x/z1DaU+g7KOPo4aIh6hH/WgWcX8ZHJcX9xQgYZMpRW+/xO0++tSIPiy7osQP6YXF61rgY+twUu1a38f5U86yqeLRVWBMRm73DV1euraVvVDAe6mCqgrngZvk/RbVbS6X0J3fT/RKKOJe8voRrruwppBpMOgUSpMhfYF06U3qRtpMyhqGZTt8WzLcV+11zvQgP+bz+5clxlrCAs1l2lmHKiSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5392.namprd11.prod.outlook.com (2603:10b6:5:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 19:26:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:26:46 +0000
Date:   Mon, 6 Feb 2023 11:26:42 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/18] cxl/region: Refactor attach_target() for
 autodiscovery
Message-ID: <63e15472e8ff4_fd49e294c3@iweiny-mobl.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167564538227.847146.16305045998592488364.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f248a7-4df1-4b6a-7861-08db08781607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6Xj2HY9rVqvA90VZGpz20RqcLgf2L/xsfyE5H1lG9QGsw73gydpYhVfq1qpix+jM35C6InO18lnbQpmT7qMjD/OBusG+zr75GF6likFT4b264NSV3r+Av8WLHvnlTW1c0nMSxNQQhCmxJGXuBC6icpXNh8mZYCJGWNNkGSDRmGKR9AgPuvIvQ0jAtRuwq8oUVfhTV41265tZD/1GVJ64qmSW7HQgHzZDaXP2EGyHbHISHXwJtPiRBi922GCqIveCBHInkzy1nm+t1Do3Heq0MT5/9LfVOrL89LPIP3eY1i3LNmphQSjsh3MSbfUuNI4C23oMoeEEtE6Vx1WtocqEBsOpXmKv0WnIpFtWd2i6MfmVB3lZRMDAvRGhcbFvUPiK+/u+IoDXeeJ5bPaSTXs/8+tJ62n7XBq6mYO4J0maw+sK/4Ew0JgIUuQB/PGnVqWmxA708JWpzuGJzYzomH6THqrUFD59jO2CWxv98ET0KIkX54ndDMrJxX217l9slkuDN+38XbcmM3CtTkSvW7VU0NcNIoN3O4LDwJ2XXYV0aafe/CyKaMFiJRoGH84lReEWi2XTjReveNQDTp51MbiCT88+jVQGo1wYweXq+jzInzw0lltgpBBbQyb/V/ZZKoytOXHx1e4l4AIn4botjzKuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199018)(5660300002)(2906002)(44832011)(41300700001)(86362001)(8936002)(9686003)(316002)(186003)(38100700002)(6512007)(66556008)(66476007)(66946007)(478600001)(8676002)(82960400001)(4326008)(6666004)(26005)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvGRSELqs4EwMtw3HUIUitABsANwjE4TG4OxCu6Y9GT2ht5ypFKFCetQdnRg?=
 =?us-ascii?Q?9Vd/jJU3nJf2JwyPXQpxYWDlop8+DvQ4YcS4w9IqOTtHid1ZNv7hkAqLDdXb?=
 =?us-ascii?Q?wYdMn1klaObUXwriS29eZNR69d1TiLfvMcvsAGd2HUqbvlzvVPjhw26mkY/M?=
 =?us-ascii?Q?OD7OmbHaFNmEnDJ1fz9vZqIL3AdHtMoIs5a6S9DYUwFp2oRxHyZ3PuSHvSKq?=
 =?us-ascii?Q?4Xf3EHEVV2i+Msk7OaWbdmQfoFN9jvRFg5QfPJ1tRJ7yp7YyeQOXOtiw0dSp?=
 =?us-ascii?Q?3QVPoWvWAVde3XdUODYequp8E5bNT7wEiEiyPmlhFF9MfUXVkqDxXkMS/Zte?=
 =?us-ascii?Q?Q05obNmqfzeWgIbke8fTZZ27bQEnslrd/5YCDTNY2VX2Iwg3hnRmCp9twftD?=
 =?us-ascii?Q?iesj2EpHFfn7EjEqd3cB1i/kQmH7RYBZfR6Vs07YSehZxAum4JmOUH4lgzts?=
 =?us-ascii?Q?QCLclPqi0E90QeUK0Ntchv9F6S9DymaBQHugxinZ5mN89C1i9Uia65EQJCLT?=
 =?us-ascii?Q?v3TGvq7+hgSOrO9oOoTrgldx0D+aoojgBwBQ7o2hYdEDKgkEacJ19FXLUU0c?=
 =?us-ascii?Q?j2ZfR6Gef3Hrzm0FPLSJRV1rGCmCf5sK6iFYostNm7G4A/WHSTOPwo8OGoIE?=
 =?us-ascii?Q?RaFW6ddbKRfhU0S1I21gkyhZBhJyAgbX5alZmKgPVbKCxdy2sO8cpkl6KYZ7?=
 =?us-ascii?Q?qq+9jTMsmrohpK/iPCsAjMFwaFOz4NBZMk4GeforV3I1eUTf29A4nuPuOnnA?=
 =?us-ascii?Q?cVfCcJqLXURVtMe/0+eXLSLyZjStJrxCbim7twWfP/vY/NxSbwKzTT1gE6W6?=
 =?us-ascii?Q?cAFLC+zBY+MgZNVYr/noqlKTTbqhPia11xcOz/A5LcpgxNUUENfpReX+Xk07?=
 =?us-ascii?Q?l94ULjlbGd2gYITXcxwsSJ3zzQRdcXTxhOU6b44lXaklh5djT1Er7EVFkD6l?=
 =?us-ascii?Q?mCkyfzVkF9+Oce9hQAIk1VFZOcYhhp1YhEflfingMS5WESA01o/OyLDGgv/f?=
 =?us-ascii?Q?yPmtD5IH/uXTo4KsOPaXEDE+7cIqvM+1KFkksoVMnhxBfkwy3swvWHWC5qdL?=
 =?us-ascii?Q?RSGAtm8YrEbLOxFnjr5Gyfe6h4RBqnIQ99UeNYRL/DrU3REoidryO/cavAC/?=
 =?us-ascii?Q?2Lv6kf6gojyg5ycIYTnl12JQvrfPt6cUK/fDIwL8q3ROgrqG7Qw3Eemcir3P?=
 =?us-ascii?Q?rWeFLo95Z+Ngag0M7QGg51ZPYP+UIxf22WvKJa7JbeX+a7ubhEbJdpd/kdTm?=
 =?us-ascii?Q?HL04LTAoma6JV1BZvrYGoA8fwZdZtvMuYnTrL4fU94IYGGPH5cpniXZnLGqu?=
 =?us-ascii?Q?sTzeZdy2afazZUSS5C7y0fKY30NGy9h8fHHW8b25aMsyI76/z/wnZZauL3Ob?=
 =?us-ascii?Q?5cVIM6S0jRD5nObfUjJreB5QYza331nZJNUYLtTbohXrNqZyUuDMnYkIKpQ1?=
 =?us-ascii?Q?EeEXOIuG1HpW/Xhde26rnvOiIkUyOA96f177oGhse+i+WyvtTS8ohXTMPtxn?=
 =?us-ascii?Q?Zo2j82SkMSQoLsjRTOxvM4RGkyZQv+7hDA+NaZyv6neLclpjCJOYdUy4Zqrb?=
 =?us-ascii?Q?m2DEmaodRCnHti9VkGq28JyMhsjoVsUq5ca7SqbT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f248a7-4df1-4b6a-7861-08db08781607
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:46.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2xjuAQzcud8o5PIBU5QhQwG2tHkR69SBkiItrJNqOOCmmjT0jeXfPp7hBxxPK6/l/jD45SoOLF4M99GqLsVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5392
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

Dan Williams wrote:
> Region autodiscovery is the process of kernel creating 'struct
> cxl_region' object to represent active CXL memory ranges it finds
> already active in hardware when the driver loads. Typically this happens
> when platform firmware establishes CXL memory regions and then publishes
> them in the memory map. However, this can also happen in the case of
> kexec-reboot after the kernel has created regions.
> 
> In the autodiscovery case the region creation process starts with a
> known endpoint decoder. Refactor attach_target() into a helper that is
> suitable to be called from either sysfs, for runtime region creation, or
> from cxl_port_probe() after it has enumerated all endpoint decoders.
> 
> The cxl_port_probe() context is an async device-core probing context, so
> it is not appropriate to allow SIGTERM to interrupt the assembly
> process. Refactor attach_target() to take @cxled and @state as arguments
> where @state indicates whether waiting from the region rwsem is
> interruptible or not.
> 
> No behavior change is intended.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
