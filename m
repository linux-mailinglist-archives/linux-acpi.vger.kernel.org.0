Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E468C693
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 20:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBFTQR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 14:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBFTQQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 14:16:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D402F7AE;
        Mon,  6 Feb 2023 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675710942; x=1707246942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bw3k8Z7Hb7QT1fAcReySVjTHPGk2uu4IOOc0KeUxuXU=;
  b=XloIA4sZX0ZvPWM1BYHTrP/S/W1XXslcm+9lTfCua4KTuT1aC/ip2eof
   Dv0n0RYzrD0VrocvOipVkITZ/8KH3vsrd4XTa1W77DVq4ADrp+G5tI69g
   9gFRfN1SRngfYYGg+yeqjeAcLSUVCR/3n8xqNWn/nzr+pWDGkUsNCzjZ2
   oWJXHPWBisak9nBPcj1H9FNenlhSgSsGxK0wYnpfLyz1fl0U8BbKT3UPt
   D+o3zB4TECycNOntdFi3AH3o7igACx9ShvWrmjNvofVcrEA1JOwibBZAL
   PlADQoIoi7rVcWQLAFGfZoqsPKfbBosX223lc0V22Gf3nW4eoq1vdZzRc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308937323"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308937323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:15:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="698951571"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="698951571"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2023 11:15:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:15:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:15:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:15:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUGrJ/omqxUo5c7MCPPWWPyjfgsb5bFRze4O55YaMT5aA4WrABxNRsFJEUH0UW6mGwdf9olbpxLAY6pILoUlwQO6rdaZHVzJIbbfqRSWMNz6d81gYNUIU1AJZXqbGASK4y44ym9wXD2PYP0Nsx4VSqiThIcSfw39De+j5OyC6xZQL3NrgtfRAoaoeNGf86vxHxPNgPl6xwuZXnUaO3VEYlPm9dIJJKDji+8hpVfMNgOMuKai0FVDES+NppQhhtIHaXgrLEz/BxuKyCyN1WyvBjqgfR1KG/0CJCPFAGaej5Iyv9ghSTb0c+Xe2xHhkjfdmYa/Ge/BR+DxySsXMRbM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M7N1p6ek6skC0ivYQLaue3L9PoB4WMdE6JVIGEICQo=;
 b=XtQkA+n2dwNF8ce1oqd/sjWNCEBslHU5KQnViQ3L0pyfSfnkWUMmdauf29aPZTIrpiNMFDq7nxgFlltQj0P0xYXUy7LF54ce7+t0JpHnJdLrWMeYrNm614RIwmujLRRd1cuXutFrL6WbquBS+/up41x7Gd5Fhx+HjblmUxBYhmKTZnc6IAbgFBC3hYIPcd9KdAY7rxVnid1ewPTvWn+IhSthkSGV786UYDBje7yForvoXcUsZ8AxMxZkIflfzXKBU5kq3A8EHvDkwtlr+14XhHooPhZtrI2oFAs09l3Vru9tw63bRjMT5h4sqT/oCUrJuQh8KPrpUQrf/4ieH1h5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5703.namprd11.prod.outlook.com (2603:10b6:8:22::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 19:15:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 19:15:07 +0000
Date:   Mon, 6 Feb 2023 11:15:05 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
Message-ID: <63e151b96a648_e3dae294d1@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
 <63e13c8f5debe_fa3292946e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63e13c8f5debe_fa3292946e@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ef1015-817b-4a85-f65d-08db0876754e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQS29QVOp26q3aqiRNFUyAVdUoddr0xk7hOw7WC0f4FR6OaabL/PG9xxutMGDB117f7nct7bwelL2aNbOl+2W5LcyvXBB+VZfrmOzha81zcscp7bX/2S1dYLHhE+IiA8Ll9cCSRpz2YU6bFtmLe/lgcWwJb0Xzz6wFeobWn4YechLj4AQw66T32GqCoCUmJOBTZpycaTX6SNpeql6ycEBD+T90IIONyghNhUgTiVaFqHXU5O/lrQc515yLBPnzGeyn/9EbgV8Mp7TosxBrVGM6l00QH/OGbj+WgTk+yb4ws1PJqrG+RtB1mpz8ugHoN8snJ2Ih81kgKH6BZG/JKp6JvDuvvAd33IcNNC85ZsMn8NGTaxrS5I8TStz8KDCaJrEjVy4pv1TB7nQ7mdob8VqrwgveSVKMg6Hc38mTkQBb40UXTOcdlOrkqJ9jxpz6y17AoxonHsBGJTId3V/pBZy+q6hyLYdVTqKiexAFs/XmmM0alMztaZHCntcBdyHaWTWktJi/HyWaB2djF79pQpob6Fqs26Bo0qDxvDeYDcdXj4oYjBUSRFWyjIltrqWwYCAXZa+QTiEvC5B7tpPezLq2JOHrpFFPJgJR9qXTN2k8wXpE3tpk/ZXK9dDaf3fU3pngO903TjSFNyJd2NrIPhCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(6506007)(38100700002)(82960400001)(86362001)(2906002)(186003)(26005)(9686003)(6512007)(478600001)(6486002)(5660300002)(8936002)(41300700001)(66556008)(4326008)(66946007)(83380400001)(8676002)(110136005)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFWtEU9sKlJZ+opIEVdqzacokL1noNzGQC/35+2ry1f9HgsL19jS8lLPf7ig?=
 =?us-ascii?Q?8knp4TbtrUpzQ7h8E7xbkpJqQ0fssfpr7wQciwxBpidiU1Vr6MmRVztz+zsC?=
 =?us-ascii?Q?erXx7L43+T8uzvW+BcuPC4bZrU6UinDJIGP4fEXZKjcgSo48UBZHaBjYTRzw?=
 =?us-ascii?Q?d2P6rd4DrsEU5/gp8s+uza8bcrNzcJCyAyq5yAiiqbJ7Q6WNBmIbcATvgLcV?=
 =?us-ascii?Q?Kb3SKVvERfsnY5XnL9C/5C6EHSTIrMHvQUKU1z+oPKcRVQZdIb3cdRDB94BS?=
 =?us-ascii?Q?6qqbnx9SfzdFJfaVjZ/VPMMGmPxoJjD0b2Gd0uGBfnwHZcllEgSX/h4wWfx/?=
 =?us-ascii?Q?3YbdGs1JEZK6H5/fqT5tYJILXWgfgiPb6zOjeFjlAxxXZcspFUZeFJ7oGIeX?=
 =?us-ascii?Q?QPgDWl7gteHysbhZlCVYJnvSJO2RkGw3Do0N39xvRV7neFVqBIAfyRe+ZYFk?=
 =?us-ascii?Q?PLbqWyO3ghX3SpxYyz9CNOseig3S7Lg3aTZs/qJBPtMSyJ6/qgrsdg47cO33?=
 =?us-ascii?Q?4r1iNJ9ESa9LrtXbepND/gqyEQQz7/V9y3KxcZN2MAZlB9l33j56JSt+eOby?=
 =?us-ascii?Q?4aNpx1ZRZt3qZTTUt3E32m2WIxw+mn9/tfp2pHOt+vQ6iEYIuFKnnuy2uRVA?=
 =?us-ascii?Q?w5/qYL1ZLyeBXPUcsVBsgA9cGR0FEUvhnAv+V71dLgHcaVUyNr8NelskoQPP?=
 =?us-ascii?Q?Gc+A+zF2X5YZdRWdjFswe6Swsjnkbv8IWZAMFN8ymwBYwQGd2r4hsEOsfeXN?=
 =?us-ascii?Q?ySHfDLk/p4hqdls/KKpMs07gM57uuDSqP9O9GsPJzUnq+PsrzJq4G71Ly4vH?=
 =?us-ascii?Q?5Gw/OirDvga8taGCa3mB/0zUPh5JEXLn7DM7yvXTNgEQLoPeBWO0TPKlpv5W?=
 =?us-ascii?Q?gkSE1MNoXsd4kuVSeOKdauHVlOVKZt0iHhkyJc9k5u1qaSQQI0LMJsdyL8ph?=
 =?us-ascii?Q?cK92Ntz7lUC3H/ZEHB5YqPVi9oCSBSC5zsXgktuUk5btMEkAlkHYddUjSPbf?=
 =?us-ascii?Q?OsTSaqx4K5wPlO1WQ7ZeA5NVR60ewC8+9U/+WxPMBUe3IIwSLiYLtxBjGB0U?=
 =?us-ascii?Q?Q488OG6eeRY7e9GzgsrY1PI2aJ8c+K700TBSpEguBLP9J7lJI0w2ql3ZeTzc?=
 =?us-ascii?Q?6xZyvLBvMc5qSsa5XGU1t7C7GArmiafqZXfKB26jEakoUj7/DbKznir0mWlA?=
 =?us-ascii?Q?+mZBeGMHO8DCI5Im/8RpEeV3VWptK/EDB/5BdBYpuRyYV8Z+QnPaB+/M5ZYz?=
 =?us-ascii?Q?H3+H5ccAYPM5y2wyIl/xpUDSzcmvINrqX/856ijbEmc9oRzxmYxSKoiGG49/?=
 =?us-ascii?Q?5k0+4+/IQJsUyGDzvJbZP0TQUXmXdE6tit54etGTYHDvWp5ju/zbiMo8DBoQ?=
 =?us-ascii?Q?TZkYbIx1kVQoTcjh2JMObBOg+rBP7Nydp2HpJ0piN7EZGD6TqALbLmfNJsx/?=
 =?us-ascii?Q?DZ3juVNtcPbitnVPFb08wuTvCMXqket7kOMosydHx3Xk26Riq/7MpkzJ0LYk?=
 =?us-ascii?Q?WEn/bKYG0EpShF/t5K3ryL76nl7EdGVhQI5NwqSSey9ZG4to5r1r4QcbaYRC?=
 =?us-ascii?Q?PlVdo5i4pZPH34sYMD+OwTNCBSpXy/1+dJLBNoIjE7gR5yy0OFN1ajWgzH7s?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef1015-817b-4a85-f65d-08db0876754e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:15:07.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVuwT4zX0jczIcHZSm8PKRxeXIwJx0HqUooQKPjQCea5LqgWAg4d6LFsB0JmcoO6nbwew/aSaxmcOg0nXqcgXGtPeGW2fgN1ld3LG0ve26E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ira Weiny wrote:
> Dan Williams wrote:
> > In preparation for region autodiscovery, that needs all devices
> > discovered before their relative position in the region can be
> > determined, consolidate all position dependent validation in a helper.
> > 
> > Recall that in the on-demand region creation flow the end-user picks the
> > position of a given endpoint decoder in a region. In the autodiscovery
> > case the position of an endpoint decoder can only be determined after
> > all other endpoint decoders that claim to decode the region's address
> > range have been enumerated and attached. So, in the autodiscovery case
> > endpoint decoders may be attached before their relative position is
> > known. Once all decoders arrive, then positions can be determined and
> > validated with cxl_region_validate_position() the same as user initiated
> > on-demand creation.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c |  119 +++++++++++++++++++++++++++++----------------
> >  1 file changed, 76 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 97eafdd75675..c82d3b6f3d1f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1207,35 +1207,13 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
> >  	return 0;
> >  }
> >  
> 
> [snip]
> 
> > @@ -1274,6 +1252,71 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		}
> >  	}
> >  
> > +	return 0;
> > +}
> > +
> > +static int cxl_region_attach_position(struct cxl_region *cxlr,
> > +				      struct cxl_root_decoder *cxlrd,
> > +				      struct cxl_endpoint_decoder *cxled,
> > +				      const struct cxl_dport *dport, int pos)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_port *iter;
> > +	int rc;
> > +
> > +	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> > +		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> > +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > +			dev_name(&cxlrd->cxlsd.cxld.dev));
> > +		return -ENXIO;
> > +	}
> 
> I think I know the answer but I'm curious why this check is not part of
> validating the position?  Is it because this is validating the position
> relative to the hostbridge which is not strictly part of the region
> validation?

cxl_region_validate_position() is just doing the basic checks like
preventing assigning 2 decoders to the same position, or assigning a
device twice to the same region.

The checks in cxl_region_attach_position() and cxl_port_attach_region()
are more about whether that device can be in that position relative to
the hardware topology.

I think this split makes more sense in the follow on patch where you see
that cxl_region_attach_position() is done after sorting while
cxl_region_attach_auto() replaces cxl_region_validate_position() since
the latter is validating user input and the former is reacting to what
platform-firmware already successfully programmed.
