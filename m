Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AB700CB3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbjELQO2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbjELQO1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:14:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DED76BF;
        Fri, 12 May 2023 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683908065; x=1715444065;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TuSqUvVVscwEirbj/utbCIKOFI+nfkO749VgZTRuHyQ=;
  b=d4sIBxKsAcLiYKGsmBXygS2S17EQz3WIMFdldPSe2a8w4nivLDfaD+GK
   hwK3k/AFiFctOK3H8hJzBGuUiKqEBGtBiiD8pghNVHNNmYSHybGDNOx/M
   XO5aqalhSbjqW+7wxGm7HNo0xOQTmWopNbJaZnLKK3zh9B2gyncIzd40g
   GT9Uzb2yN3RQLabGsyTJjnVutXicuNdEVniAd2FTY75KGrPOolq09I7CT
   iSEavOgcpOQe7U0L2ETM8krP/LGb7IEDROvHato6tJ46bPYbi2DxieM1G
   iQOMjAeCQ9oqMT5QOSF13y6LeVD8a+nudca8KqFEkNerax3q7NGhpR0q1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="348316166"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="348316166"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 09:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="874441619"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="874441619"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2023 09:14:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 09:14:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 09:14:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 09:14:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULwxr2ORV5MRcQqgyTgCEQcrHlBdK1gYFWw3F8sOHVYgTRWTanPeMgOBlh3lLpxOtRYfPYHfQ3kdmTowNy4qwdf3mFOCmUpzcTci5HFbIzy8s7CYQWDdJ6GtM/YzP0oAqSE6mY2yNMUszH1yT8IsXmum8sMdU/ZKnBENki1pvkiwuzfAgWS2LolLh+H/QpvQ2XSeM0SL+uwxGYsRBoTwWlZrChUOAEphhpBPjPdk3N7o0yJvUfVNDySq3r+FVSbQzsSVwbOjP6s3Y/4FpnTaQk7lGGmE9s1KzRCx7HDRsLJqOQae4lUGZPzjjZmxdzeye9UOmJxiA2gKpxXiSB4sMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jnKdsVarlcSsB2dqZcehL/6dzlrIyaLFQ9HoJvl+0U=;
 b=cBodLgIjJ2u7zd0KQULuM6zJ7PGsFXq+CT3PyY/qjJT/8vvfX3fU48ubJk7x0kI7S8m49dvjlZXp3+GdYeT7x50yJO7G0b803P5QidHMpn6s/5keuNTLeaOtURK37uhWjNQXnyxH9MSL9bmdC+YXOCu+fTazIvlvCQSrE4SHsgBA5SqdqDre8x2c+/wo0Fd6fAYGbCY8lB06K6HWBMxd2fxKciwpDLIK5BeqD1sFryC3AWyOYt9IDm5XG/mW6PDuFKDYKZ4HqydSkY7hAjmWheUpKfv/A1OEUMbSXCVT727LlqweqJyLa/rraz+E3QoNFiHYumbKM6BEAOloo573MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4794.namprd11.prod.outlook.com (2603:10b6:806:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Fri, 12 May
 2023 16:14:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 16:14:17 +0000
Date:   Fri, 12 May 2023 09:14:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 1/4] acpi: tables: Add CDAT table parsing support
Message-ID: <645e65d7dbf3_1e6f29476@dwillia2-xfh.jf.intel.com.notmuch>
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
 <168330797672.2042604.12339416734589446371.stgit@djiang5-mobl3>
 <20230512125831.00000eb0@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230512125831.00000eb0@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f618986-7d13-4cad-08e1-08db5303ef7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FhUgYnRHYZEUcsNFMl8KnSYBsmfWwQD7SC+LuHWxXcCXgBBkyO8q/jsyMHrMc85lrVGoxU4p3yGNLixPCY3+FyZV6Vf43sKqt4bEfU1Vdb+WzLj7fqnfjeRuzylcIwp0/i+hxOvQ41tJVfUWfb/G0WXOOHMOgtaidK68nVfANUG+YEVBywFfMFytqAhyQ28sUi5+GUd96WAttvRuGZ1XmqKrftGDsPnxhqh31eiu5MayNJrB5HRL3x7mDEH5T8i81u4Cd2aHZVrBdiloE6usQJlj9scNLF5O3jgPaiQDWqSs8F/EMtYKHiRveAi2Mt0J0IAPfoXMQKlWAUDDAnUf+8diL7cMw1goEN6MEGX6aC+Uy1FKr9PwSmRzMVciTYdpF+vFk90RJLGRQfI1NhH1GNDiejE7rJmnfLL8Zzre7Q3tJePFNIPe1ybxyN5LuAdB5evqn/R5kV3mBrtrSjtCSoOyf3KGoK09merYz+yYws6ykL7Oxe3Z+ZjnLBidiFdubvnG5nGE3KKC6kIQGJgZ2xy+71SAqDySZjQE1Tt+wI15lCRWZ1Sylsq1Ri+2trg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(86362001)(6486002)(66476007)(110136005)(478600001)(6636002)(316002)(66556008)(4326008)(66946007)(41300700001)(8676002)(8936002)(5660300002)(2906002)(82960400001)(38100700002)(26005)(6506007)(186003)(6512007)(83380400001)(9686003)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6/GzTHeoIMjhF+x8+ZDfJCHONpNoTUB/SRXvetDisKZIcKTbS2idgkNmdoe?=
 =?us-ascii?Q?o4xrgRSNlVG4YJMGIWNLpKENSM6bx2MYroEKrUjk0yNIUbRKzOTRwO2safFD?=
 =?us-ascii?Q?ZXGoIR6X0ojgNAMybtMzWmwtNjmtNNwwISL8/jYplaspwhkKqXfYjJopjpy8?=
 =?us-ascii?Q?Sss82IWVIpkEqwHpaUALRVoEueA4hz9bUxQEl54GHRBdKq+5cS2sCfhTtVZx?=
 =?us-ascii?Q?vhfzp3raOkVbesCgFm1yx7nG6BNy/MibQ+TjaSlElbBBJ4MZRIjh5h5FQstS?=
 =?us-ascii?Q?QqhVgQwEG0AH5yXLH4ED8GJjAtfhhRq+jVJvuGEb4JypKwXtJzn1ZQikAPMx?=
 =?us-ascii?Q?6wvx1pKg63UhA3q5Mi35c3XJZa1t/wW8PHdxTArjuE3cPwS4oM7Ip3MxLZxU?=
 =?us-ascii?Q?rFeY9gtjLLUX4k1K7RqJKXz9CQPPplf35xgTUEYvwne/yGxeRYP+nvy2VOIn?=
 =?us-ascii?Q?SGDZuA+ibqfvZMbQopRgTqghpKzTfQ+Ufe/erz80hEfyh4TpW7kwI0fLHDhw?=
 =?us-ascii?Q?+ZJ/xxqmDkKbT3bodSIsXzWGQoiSyLbDrgLwCKx3xLXP4bYnet8sbVxLWbpb?=
 =?us-ascii?Q?iypnBeGFSovhOMLgg3w+xUJns2CitNw+dguiFkZKH4IDrEaeFs3ePza+p0Jf?=
 =?us-ascii?Q?z2QveZ0mLzALGT3AUeQ8+OBbYBOcbohVt/6wjmkOKpeNnnaudDkP68RxKT23?=
 =?us-ascii?Q?qTlJ8Pn9OH6Z5TX27ivVdoWoWWj49Qkee9zNbthJAYTxy7jFJbKsF3PGN0oC?=
 =?us-ascii?Q?F6N/B9I1G0eG0IDV1IIi9jZoV1c3nigsHt/f3Vlu9Y9tsdEv1BsloGw8NKKv?=
 =?us-ascii?Q?cwSSy1+z8b0QPrj23JYzuMqN/VlRPr9xNAOZHtO1dMFi8rC9vq+AmBkSO91j?=
 =?us-ascii?Q?juDSh9D3BlBx3z6EhCRCeJPZMgmJIlrSG4GsnnIBpBFF2Rse+t37i9B8Tjxv?=
 =?us-ascii?Q?PLYs1Htmyv98WPZ9tgWWhsAX+FyISqJt+aW0mI0Dz3Jnzpi7v3S9RWgQuh9i?=
 =?us-ascii?Q?uejmIyV3spDfcD64sNTMHqN29Avn/Kieb6+iYE/qk8LqmMtxknfDo7r/4qV+?=
 =?us-ascii?Q?Nb+MGX7zUJm387j07O6EPX8iK5ng3Z+XEc66hdjP6JeSuLozY4poDq9RBDIQ?=
 =?us-ascii?Q?nladXXZt/jdOBb86Wl3HTIwgFeBr0fNMte+m3tHtx8Rw0qIwlQTNUt7ZJWl2?=
 =?us-ascii?Q?sPKdPM+rWY8I1rh3zXFFH6a8lZmqWnstEi+1q9P38ZFAW475TtfnZ+SEVk/p?=
 =?us-ascii?Q?uz9GSvWmtjPJKGF95BVcoJTEao6PlWExzhP5nvc0xmoujKwjPEk/Oq9EL2Qz?=
 =?us-ascii?Q?FbQqP3UZmOkcVjmjAaIjcWrjHEwpmjaa1CEQa+hNe4jnD2LNXRKI9WQdlkgY?=
 =?us-ascii?Q?lEzBjZ/TJpQIB6bvDsUZRbTCqK3QRBdrVIIgutY+JVc2bpTRnUxwWhri5KKr?=
 =?us-ascii?Q?AyUzgIMyMxoZUAPNow7YsBZAr57ODF4An8JGUB5K2uOXRH2YheswnCrX8d/h?=
 =?us-ascii?Q?t9k4OqCFiimZ0YHYySUIX1a6+rVFxRw+FNI2NCXd5h/QVE+xQ5/uBddhpbk8?=
 =?us-ascii?Q?LKKoqpQFYNZkHP8gxO0HerbEfHy+NrlLnRVwRnkbp4oKCKz2ePJayyuAnnJO?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f618986-7d13-4cad-08e1-08db5303ef7f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:14:17.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3AinKDj8tMFfrPYQ9j2uLT/I0aMpwK+fbknYd9M2YIuXe7KjMoaPiNjnW6cwxIxpvEemgknYyf28gq6+5yYwmZoFOEgk6xawBwPRso4Pf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4794
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 05 May 2023 10:32:56 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > The CDAT table is very similar to ACPI tables when it comes to sub-table
> > and entry structures. The helper functions can be also used to parse the
> > CDAT table. Add support to the helper functions to deal with an external
> > CDAT table, and also handle the endieness since CDAT can be processed by a
> > BE host. Export a function acpi_table_parse_cdat() for CXL driver to parse
> > a CDAT table.
> > 
> > In order to minimize ACPI code changes, __force is being utilized to deal
> > with the case of a big endien (BE) host parsing a CDAT. All CDAT data
> > structure variables are being force casted to __leX as appropriate.
> 
> Hi Dave,
> 
> This falls into the annoyance that CDAT doesn't have a standard table header.
> Whilst I understand that was done deliberately it means some odd things happen
> in this code.
> 
> Just how bad is the duplication if we don't do this at all, but instead roll
> a version for CDAT that doesn't force things through pointers of the wrong types?

Yes, this was the question before sending this out. The savings is on
the order of ~100 lines which is not amazing, but was enough for me to
say lets keep going with this idea.

The other observation is that the ACPICA project is doing something
similar for offering disassembly of CDAT buffers within the existing
ACPICA tooling vs building independent infrastructure. So that was
another weight on the scale with proceeding with the code reuse for me.

The only thing I don't like about the result is still seeing acpi_/ACPI_
prefixes. I think these entry points and symbol names should be
cdat_/CDAT_ where possible, more below.

...and as I read to the end of the feedback on this one it seems you
have the same reaction.

> 
> Otherwise, maybe we need some unions so that the type mashups don't happen.
> 
> > 
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/acpi/tables.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
> >  include/acpi/actbl1.h |    3 +++
> >  include/linux/acpi.h  |    4 ++++
> >  3 files changed, 52 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index 7b4680da57d7..08486f6df442 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -42,6 +42,7 @@ enum acpi_subtable_type {
> >  	ACPI_SUBTABLE_HMAT,
> >  	ACPI_SUBTABLE_PRMT,
> >  	ACPI_SUBTABLE_CEDT,
> > +	ACPI_SUBTABLE_CDAT,

To your point about ACPI_SIG_CDAT I also think this should be named
differently, like CDAT_SUBTABLE, just to make it clear that this is a
special case and not another ACPI table.

> >  };
> >  
> >  struct acpi_subtable_entry {
> > @@ -239,6 +240,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
> >  		return 0;
> >  	case ACPI_SUBTABLE_CEDT:
> >  		return entry->hdr->cedt.type;
> > +	case ACPI_SUBTABLE_CDAT:
> > +		return entry->hdr->cdat.type;
> >  	}
> >  	return 0;
> >  }
> > @@ -255,6 +258,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
> >  		return entry->hdr->prmt.length;
> >  	case ACPI_SUBTABLE_CEDT:
> >  		return entry->hdr->cedt.length;
> > +	case ACPI_SUBTABLE_CDAT:
> > +		return le16_to_cpu((__force __le16)entry->hdr->cdat.length);
> >  	}
> >  	return 0;
> >  }
> > @@ -271,6 +276,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
> >  		return sizeof(entry->hdr->prmt);
> >  	case ACPI_SUBTABLE_CEDT:
> >  		return sizeof(entry->hdr->cedt);
> > +	case ACPI_SUBTABLE_CDAT:
> > +		return sizeof(entry->hdr->cdat);
> >  	}
> >  	return 0;
> >  }
> > @@ -284,9 +291,22 @@ acpi_get_subtable_type(char *id)
> >  		return ACPI_SUBTABLE_PRMT;
> >  	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
> >  		return ACPI_SUBTABLE_CEDT;
> > +	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
> > +		return ACPI_SUBTABLE_CDAT;
> 
> I'm not super keen on inventing a SIG when the CDAT 'table'
> doesn't actually have one.

Agree, I think CDAT_SIG makes it clearer that CDAT is not in the
traditional ACPI namespace.

> 
> >  	return ACPI_SUBTABLE_COMMON;
> >  }
> >  
> > +static unsigned long __init_or_acpilib
> > +acpi_table_get_length(enum acpi_subtable_type type,
> > +		      struct acpi_table_header *hdr)
> 
> I don't like parsing in an acpi_table_header type here when it may not be one.
> I think this length decision needs to be pushed up a level to where we can see
> if we have a CDAT table or not.
> 
> 
> > +{
> > +	if (type == ACPI_SUBTABLE_CDAT)
> > +		return le32_to_cpu(
> > +			(__force __le32)((struct acpi_table_cdat *)hdr)->length);
> 
> Perhaps a local variable in here somewhere would make it more readable.
> 	__le32 length = (__force__le32)((struct acpi_table_cdat *)hdr)->length;
> 
> 	return le32_to_cpu(length)?
> 
> 
> > +
> > +	return hdr->length;
> > +}
> > +
> >  static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
> >  {
> >  	return proc->handler || proc->handler_arg;
> > @@ -332,16 +352,19 @@ static int __init_or_acpilib acpi_parse_entries_array(
> >  	int proc_num, unsigned int max_entries)
> >  {
> >  	struct acpi_subtable_entry entry;
> > +	enum acpi_subtable_type type;
> >  	unsigned long table_end, subtable_len, entry_len;
> >  	int count = 0;
> >  	int errs = 0;
> >  	int i;
> >  
> > -	table_end = (unsigned long)table_header + table_header->length;
> > +	type = acpi_get_subtable_type(id);
> > +	table_end = (unsigned long)table_header +
> > +		    acpi_table_get_length(type, table_header);
> As above, I don't like carrying CDAT which doesn't have an acpi_table_header
> section around as that type of pointer.
> 
> >  
> >  	/* Parse all entries looking for a match. */
> >  
> > -	entry.type = acpi_get_subtable_type(id);
> > +	entry.type = type;
> >  	entry.hdr = (union acpi_subtable_headers *)
> >  	    ((unsigned long)table_header + table_size);
> >  	subtable_len = acpi_get_subtable_header_length(&entry);
> > @@ -464,6 +487,26 @@ int __init acpi_table_parse_madt(enum acpi_madt_type id,
> >  					    handler, max_entries);
> >  }
> >  
> > +int acpi_table_parse_cdat(enum acpi_cdat_type type,
> > +			  acpi_tbl_entry_handler_arg handler_arg, void *arg,
> > +			  struct acpi_table_cdat *table_header)
> > +{
> > +	struct acpi_subtable_proc proc = {
> > +		.id		= type,
> > +		.handler_arg	= handler_arg,
> > +		.arg		= arg,
> > +	};
> > +
> > +	if (!table_header)
> > +		return -EINVAL;
> > +
> > +	return acpi_parse_entries_array(ACPI_SIG_CDAT,
> > +			sizeof(struct acpi_table_cdat),
> > +			(struct acpi_table_header *)table_header,
> > +			&proc, 1, 0);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(acpi_table_parse_cdat, CXL);
> > +
> >  /**
> >   * acpi_table_parse - find table with @id, run @handler on it
> >   * @id: table id to find
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index 81b9e794424d..3119be093cfe 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -66,6 +66,9 @@
> >  #define ACPI_SIG_IEIT           "IEIT"
> >  #endif
> >  
> > +/* External to ACPI */
> > +#define ACPI_SIG_CDAT		"CDAT" /* Coherent Device Attribute Table */
> 
> Worse that that, fictional signature :)
> It's the nameof the 'table', but it's not a signature as it's never
> used as they are in ACPI and doesn't appear anywhere in the table.
> 
> > +
> >  /*
> >   * All tables must be byte-packed to match the ACPI specification, since
> >   * the tables are provided by the system BIOS.
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index efff750f326d..4c3dfe7587e9 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -135,6 +135,7 @@ union acpi_subtable_headers {
> >  	struct acpi_hmat_structure hmat;
> >  	struct acpi_prmt_module_header prmt;
> >  	struct acpi_cedt_header cedt;
> > +	struct acpi_cdat_header cdat;
> >  };
> >  
> >  typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
> > @@ -266,6 +267,9 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
> >  
> >  int acpi_parse_mcfg (struct acpi_table_header *header);
> >  void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
> > +int acpi_table_parse_cdat(enum acpi_cdat_type type,
> > +			  acpi_tbl_entry_handler_arg handler, void *arg,
> > +			  struct acpi_table_cdat *table_header);
> How did we end up with an 'acpi_' table that isn't in ACPI?
> (I'm not looking as I fear I might be responsible :)
> Should perhaps consider renaming all the CDAT entries so it doesn't looks like they
> are.
> 
> >  
> >  /* the following numa functions are architecture-dependent */
> >  void acpi_numa_slit_init (struct acpi_table_slit *slit);
> > 
> > 
> > 
> 


