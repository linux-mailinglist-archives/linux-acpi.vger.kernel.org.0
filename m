Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9968C90A
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 22:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBFV5O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 16:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBFV5N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 16:57:13 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E32DE78;
        Mon,  6 Feb 2023 13:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675720632; x=1707256632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t8Yprz6kPmhswt7n0fxRQIUVaCBRSmkxFJy/QdPREPI=;
  b=GcOCgWeOZVr3IjaS18LI7z1ICGNhnL+tzhdsrRQa6lFJwbwPuM3TwR9E
   0PaQ6Hhq9CMzdBjvczpv9+QofWdOM7Tw/wrm12DjF/2DMVAU4rLORL8rk
   E0pitLSDMjCuUVdYKSq0wmrTyWUA5wsYyd+BDl27D+P81XTsYh52XlmRj
   q4+KndS98ti5PwGgTknzlj4qbdVTm6CvMcT5Y6Fmyy1y5dwav+bYWGK7e
   QPsLuw9MV/tXSx0dOMmHorcEUUOLPY5iL0aaHyC9xsCvfUgTNPH2L1xF6
   GhsRRo9+nkJBOvEqfNqknVNuIyqo4vMXnpLQfXJyobgihngquTfVCwAeW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391723283"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391723283"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:57:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="809277539"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="809277539"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 06 Feb 2023 13:57:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 13:57:10 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 13:57:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 13:57:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 13:57:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF2sZSs4qPKYKmm5Ef7UzvGkY1XHffIuDxz986jGqUl5pZ60TqM/s5JBcTeJYpW8H32ZP6NzSN3CpcCTazyrb3jyiiBa7/4S+Unh6JxMGpZTUMTgFjOYDJzVjoVNofo/zGFtS4H7CshNFS+/x7C2N37DkTMxuEcqLhJnmLT1E72QVItfkkV9UjDtgMqqRQf03c65b3nby3lO3QhoBWQrgxdgNdUWw460UojCmqpYgfZuSNdqiFKdMcnpCPO0Zc1ho2NtRWj7z4ATYqOj2YChYETLT9PbRREG46CINBnNJSZL/LnPJgfVGxu9yFobPinpZgTeh5lZT4X6sd4LY2/mGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et3GwI9iwLEdDNoxSU8hgGBMVVWGiG7G/8+21Xiymww=;
 b=YhAdy9Z+03bXlWyArOLc8hTNZMBUxZC01d17FnT4fxzmK0hQB3f7ygt8LtH21I/yAe09yAFeVErhvomXuFC5hNmXnBEWu4K27Ckf1AxNzrttI33Szi7mfBFdnxPMTLgx/z6nagLihml7WvCrg0MD2E1qmWnqN2V0dypPh6TGUp21aepXgo1p6oSsegpj4e6gJ7hmwJfMJzg5I9Uo2Y/KQXrRALaSfOmajMyq8wFL/TlIWrudOLXHmI9zeAXbVvNqwRMfZDXL4taDecmyTvLRhIl+hho/lLNR7VBA+J2UzObXMLkydQe+s3zUSj7mGPRnFLG2UJSmWf1kF9fct6evDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6812.namprd11.prod.outlook.com (2603:10b6:303:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 21:57:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 21:57:07 +0000
Date:   Mon, 6 Feb 2023 13:57:05 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 05/18] cxl/region: Add volatile region creation support
Message-ID: <63e177b14a0ed_e3dae294da@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com>
 <Y+ExAllpl9OIyvl7@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+ExAllpl9OIyvl7@memverge.com>
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2e2a9f-50cc-4a84-de83-08db088d16f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnPCZ6bUETedhXjn93Zay1h1DTgLfAywK/54OhWQHA1AyJn99E2k/fNWsftke0GN8S1YtpSUeauUKYgfouecp/BX1Zoid8MZcBJi5jqJMz9xJ0mXXrudZr1YztWFIxL0yl9Zbg2YJ+66ZDMiN2rT1yyq4GgnW2fyZg0Ijn3Pda487F35QBkMz49Wto2qR3r/oPG8NL7WgA0DUfVxPMU1vkUztn8Ut59reGd2wnVXvJFjyc0VW5eASdmpNd3J+2bXhBmKwIh6o8+7/ntLWfWE0CSkqMh5ZNIGa+5IWPT3LLALITykDnQmXzw22mWlSxvUk3yCKVKh40P8FaloRS38d5LSI9o4m6l6APGDCWPUtv8uutYhW/3IxwvOWxVsXpNMhr1cG8TINUmIrsRXcaoncA2MP5Da+uapIRlyqjFsFPtwpVgMbOJ8VdlTSjOUjsk6Efy3OUDvrJBxVdH9Sta72FX3DRF07z7zKi5Lei2LViroD3PT6eJXlFQeLBUdGzaOS1109Us5yUQY4r3mgzLR58gaigxZuiHv56yEHHnf8n2o+cuQGl5WQqXJk1urUrvqS2GKpI/R024G5vuEJFrBzKr1lRTVmrYHctSLR4/pMOLfgqWTPvrY0TtB2t/0oxh9N1ulR4xrr1Xiv6cDInN4fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199018)(4326008)(38100700002)(66946007)(6512007)(66556008)(66476007)(316002)(110136005)(9686003)(186003)(8676002)(82960400001)(478600001)(6486002)(6506007)(26005)(5660300002)(86362001)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UD4ofzESUEnJUCSICt4EXqHhscw/2LNhDjel7xBjL9UhUFsJxbK5HLw2PQY?=
 =?us-ascii?Q?HEP63OsvkhEuE0Eo9lSbHozYMTSrfDeYFIz3al5hfBaN7HYklGA0q1J22FTQ?=
 =?us-ascii?Q?/m5GEbJ+sxIyaXjKVLQQbj3OmRbp1J1auZfNM4wlVjcCkSOIJdskgHoZlSXz?=
 =?us-ascii?Q?izuQX+kwSO9KBgiMtZaLTYygfCpD9L8XXcILzRiKD9cfbu6eqT1vXD6fUg5o?=
 =?us-ascii?Q?WoS4yRE/eLCnnI0TMv+PFIqxaykEDUc7YyDA4EXG6h8P6/jpu+d8+h6WR+/7?=
 =?us-ascii?Q?wVZFEEc4M3vmx73BKDdwKu8nrhaJYJXKqveQwgfidICI4q1TqmER16b6ZH9Y?=
 =?us-ascii?Q?ldGHEV0lQEnGqYMfbRentizNx36yH7atus2dGRczK6+KEwRkHr4u4pObcR/q?=
 =?us-ascii?Q?AK3LCss7NefsJmq/7KX/t/ilAPyzTCqU8+973GMLQVetbJao9m+/wl2TmnSQ?=
 =?us-ascii?Q?IJaMk8m8GFjF8iyyBTu978h1kkgoCKzncD0wHr6gVV5V86F/pT8yBzQGfW4n?=
 =?us-ascii?Q?03J8vA0XnQW8atxKSeQ0RdAN/kCg9UMFOCZAxZEeG5aMhCZdDfqfL4TftK3c?=
 =?us-ascii?Q?EJqtg00/5SHAbguiI3r0rOFs7GKnSgMMPrG/e0PdddidaeCHLYPoUhSsTAz4?=
 =?us-ascii?Q?mUWBQivfdngUac+1/rMAdXujQK1Zmzz7xX08MaYAvze0ajXDkgYL0uYDF4cX?=
 =?us-ascii?Q?M5nNbm3URXRIEWZa50KyYYanPH0t6gAmvocO9XXVlLud8dnAbP1Yz5ncE9Hl?=
 =?us-ascii?Q?4/7iYh+OdQL5M4MNkVjeStSbO+KAMfVfHozoGBsJo5ifz+SCWz36dU2kINhX?=
 =?us-ascii?Q?hb5o8BYZxW30zAtlgbl70M/4en+bGmu9oIBJRc+z4UOcDt/clxho2XTDsFne?=
 =?us-ascii?Q?/C1Tr3QU9igeZ9aFXR3mv9FNZMIKt3Zm8JwVFGH6g7ByR0iLWuFm4vSBZVEp?=
 =?us-ascii?Q?SOB0JGiRL/YTCzXwzmvHpmQ16CI5rfHuUGdefiHnYEzE9RExJ6LY1BXVjfh4?=
 =?us-ascii?Q?dZYVtGed1vCifjzqyymt/X6j9zvweNoAFcSEhTWn2bPSGjRKCRNFsjGiuV5D?=
 =?us-ascii?Q?JpiyrYvjyjZ9zl3464WFQTbPGwPYddBwbwaLlSWpqFEnJvTlxws+kg8PCWtI?=
 =?us-ascii?Q?dNI20x7slVEV0p+zXrnnNaQsiO3Bn+uMWpFKb+iDu4Dm9Su3a9PworJam3aj?=
 =?us-ascii?Q?OnkDPIXbyeC3/9FQoPrRiWY0WDKtzSmnT1g6YzP5FAxiSSJnfwWA/KOiAhA7?=
 =?us-ascii?Q?8J1gnyhb9UFRA50qpCubEFI229cCMuarnX+LCjGQ9hu8JUTiDrjzdmkoox4K?=
 =?us-ascii?Q?EumJb2bLT3JpQe93S8cSM94bzqB64++y1e3JjPb0KtfVLVUxc4mw1k2/TFPy?=
 =?us-ascii?Q?jBpHMHqqWXBX1fgMKQ8G39GvH7LZoaGYXfmKx40TJlhW38z8Kpk++SmV6IYf?=
 =?us-ascii?Q?OwrlYgaJ0naTCWl0Kw86cIBrGLPm0CM+5oaxgQUY6QvxjNQHrmL7Nd/qsBgw?=
 =?us-ascii?Q?iz3Q9zth3z0XzIVy9NXydOPG6QmxoPWpI853to9riyBsZvSmvGGe0eAzF2VO?=
 =?us-ascii?Q?YhPbTm/7DI2v8MOQta3txbU9Yj33GgPt7rn13rbE+iWg9AafQPK989H0EvVZ?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2e2a9f-50cc-4a84-de83-08db088d16f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 21:57:07.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRXZJd/IOkzJB/kM+F55a3nRx9RgZLHV0lfJtrg7ADOXyzJB6sByRw/4VBxtKzh5vrAGNnZlfGigDq91Xd3XJ6jKW612tbw9liVe/QI96f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6812
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Gregory Price wrote:
> On Sun, Feb 05, 2023 at 05:02:56PM -0800, Dan Williams wrote:
> > Expand the region creation infrastructure to enable 'ram'
> > (volatile-memory) regions. The internals of create_pmem_region_store()
> > and create_pmem_region_show() are factored out into helpers
> > __create_region() and __create_region_show() for the 'ram' case to
> > reuse.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  
[..]
> > @@ -305,6 +306,13 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
> >  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> >  }
> >  
> > +static bool can_create_ram(struct cxl_root_decoder *cxlrd)
> > +{
> > +	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> > +
> > +	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> > +}
> > +
> 
> does this collide with either CXL_DECODE_F_ENABLE or CXL_DECODER_F_AUTO?
> 
> I think obviously if it's already enabled creating new regions in a
> decoder doesn't make sense, but if F_AUTO is set, does that imply
> the region settings cannot be changed?

That just cares if the root decoder supports TYPE3 and RAM independent
of ENABLE or AUTO. Root decoders are always enabled. The AUTO flag,
which is not applicable to root decoders, is just there to hold off
userspace racing the attachment of endpoint decoders to a region until
the autodiscovery process has completed. Once that completes and the
region has been enabled then it can be destroyed to clear AUTO.
