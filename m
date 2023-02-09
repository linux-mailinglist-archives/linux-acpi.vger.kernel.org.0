Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A61D68FE3A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 05:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjBIEH0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 23:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjBIEHV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 23:07:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177794215;
        Wed,  8 Feb 2023 20:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675915638; x=1707451638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tffXJPYtQ4gvYeRDfFGNIMJBCmRd0LV69QwRotXbVuk=;
  b=IOML374roTbrHd9Hky/iLkcKcGfv5lBLx5kr4A7LWFN5/DNdZgGJoQlc
   z/L4Lg7jGIXAceSVJMdAQVHCae5hf0c2xw1J/xuIGH1OliwbQtYUpzu8y
   TJbNrgfO2Ux5U0LYGFZbu+HWXNPW9Fvv94+TwIAnNIXPY4ZrXfM29QlaO
   qcQdj0W3bZV97C8+kWgtZ/s5q1lCfkwusYpN0ZEYcmobYwUQnRhxWky6+
   JjdNi3KHB5lF/9JLitJ78Fch1yK/5CeYKOSkln3QtdOba88jPAMuttdEn
   IMAhped+YSSvZwG18YyrPLfbhTpqInMg8e30V3O4P21ya6YJ3ZaRnpHOD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313640079"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313640079"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667493970"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667493970"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 08 Feb 2023 20:07:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:07:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:07:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 20:07:16 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 20:07:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuA64N5smtoGPjUhztaxqOPA3WcwWqkI5Wn915mAhpVdpcWAXrXcRacPoxciis2p540teoNNWLhYODCk8STJ8xNDTIa8mlxPG5UdX2B7pJFr9Goqrv6o92RL56zaRp2DNMyuuizzK1a81hy8dkOYm4j1j6/+iUFPeCD6l/bkLS7rw1KNcoKEierDe0TU2Xh0k8GdOTHY7OaygWOVhrDFcXfZVJ14TasLMrEGpl7jAJ5uGouqVDyEXJUyCjQVrrMH51xJ2TdavgJ/Zy6EUb+MBA7hiuIdnC9KE4OHxscV6AZ1SvPtbB8bUcvFsBIaC3fdV6qgrZR08hfPborGHFSpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGgwrVpkg98ywz9Ksb4BgV3YkDF4lmIS1MSqOoAX8D8=;
 b=NNlIoE2Vd/OduFWectJBJhINtSKrVHmEL5awMHxX5tmo8A7dGZLuCqst314DPOtnoFJsvT8n+9s1Hb8K48+joYQ00UJFy238QVSj3Iwba8TIWz9Ax7xQbrpOdFisLx7wVz6OLQtUQiFhULEvAPHYgZSUv4d5Hyx6oRLqJv7GGFD3IqS0IRKHhP5i+MuwTGTZJVuo44wemI3bpxg/rXWAnL1l6+MhnlPUOVDeO8zy0BzTiHSDtygjmp5DyF2grNCfGBAoeKw8SIAySBf9XAWh85EaPSSRP14Gw93nso+Zpc5eb25+ZHuOzyJl8AEOcves5v7dc+INXVLtyqTL/YKEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 9 Feb
 2023 04:07:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 04:07:13 +0000
Date:   Wed, 8 Feb 2023 20:07:10 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 11/18] cxl/region: Add region autodiscovery
Message-ID: <63e4716e5294_36c7294da@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com>
 <20230208170724.000067ec@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208170724.000067ec@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 38416157-a77a-400e-8e08-08db0a531f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiENLFBV3ZlAdZf+piHed0hgJuxGiHAS1aKHoIqP/N0UrFfb8kQBfCdqDvoQRCw1/YEsDfY8X8V6yF+LIXNmFxbom8yDJCJoaqjAG7LdoF8zAfpurqtc0tHqzLguMI74Exv1CL7QK8qhADlGzltksPyCJOOU/4r/2TCQcUebD6KNJ9sPV0CLH2RLByByn1oEf/SZpPjQ1jsXJELEwTSkTb6rqesyUN3Jj7mHY0NziO8FNByqrHiDCTSWJFmWdfJGQUFttzby0O86tMJdlp8ADeVrJQr7hqdKWWYHB3/H6eLGcB8N2mY0CKBTMaPj3fkpoqBy0LUp1SLl4jQMOmmOjN28WSQy18Th+9Fssw181B2rlKT+QOMo8j+rTEg/ct2lZ8cHfCy+svcl0/tTaWdCzc0QppTDNijPuSfDQDqNv8ERf1SPAD9qRHY5wFcYRhSb3OpHnf/6l8IfBJLdIVWT4xnsHiDiVqvTAI/4kD6LL0GE6LlhnO52tJT5nmrNNczCfwz2TGgcKg46S9qj6nlS8c0XyLKJc9GS+euaF9uopJHEcVuA/skVzjRG32tzvO+Th0s3Mn2zD5fKNiNxaXLhBzujhP8QRIlzuyZT/lNx+XYNKZVzSuwo0nBmDNKVN3gplNt+JtcV2lHhgi8zusglMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199018)(38100700002)(82960400001)(110136005)(30864003)(316002)(6486002)(83380400001)(9686003)(6512007)(186003)(66556008)(66476007)(478600001)(66946007)(8936002)(2906002)(5660300002)(86362001)(8676002)(4326008)(26005)(6506007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1z6/YuBXE1haL8i88fnJAmJ9XYcrS5eWQmodrcPepiXHAXwI2VFTljgBzyy?=
 =?us-ascii?Q?0pF+zytrCtDAmLAfGwcXxHqSOdyAF5LpEKm8Ug1QvVFvcWMjeEPDn8fk8RIS?=
 =?us-ascii?Q?pOWkSKioJdyWpDPL8dRZ+FWEjIl/xHolD9mBUaW/6NvUAib38p8InyCZ7xnG?=
 =?us-ascii?Q?jRxXJFu/36dQvAdaoqfzZbKlzVPLajq22dY7TE78c62TvGyqpTjhnGOvOJHe?=
 =?us-ascii?Q?NHqbdz7JRbfyiRrZPb70Fd/yoyMr5iVuSFVIDkN4gL8MWVgJALU7jmx7zTlS?=
 =?us-ascii?Q?vpYF76V3aIu6kVV7G5/5K2S2s0MJ7XmOgUUHZ27DV6T6qzUeaAocUBN/B913?=
 =?us-ascii?Q?4NZjyFozyFBcte5KDIt4e5WGWdsO/IEe591q7V1IkZUdSYPA4UdMLe7TG0Fn?=
 =?us-ascii?Q?7hA+fCUkxteke0jiCvcGerHm6AfZitVXK20TCn2sAHjB/j/GWPasBZlfZS4S?=
 =?us-ascii?Q?BwsyFohYtnv/Khtar0NWFDthVcT9CG6M4RJz1n6ifb5Shq5sJq0n/3BcSIOx?=
 =?us-ascii?Q?l+8lcd9UqEFq3hf2jdTRLhV8xJNaEr/7Sq61ljOiLDd3Jd4an/S/Hq6qC2WG?=
 =?us-ascii?Q?a5pCxxRhqO1A4xue27106gooq7hz3Pe2F69vHF7A1qEHv651Vf/8NbhfQEvb?=
 =?us-ascii?Q?ZalegRablgFvyUFcDzCrsUi18khtVXktwIjPcSATwX/XjoDCarA9Sh7eXxzX?=
 =?us-ascii?Q?DRLduA0lU+iQOREGl92kxc5vl4zeK6jG7VzCcBNJCSFeOLBaHPK57kc9narH?=
 =?us-ascii?Q?TBwG9ulwtH2XRzLDHvC5V+Uy1CtR3IOfLPV96ipqBUs9LZlvJYJQj/PbyD3e?=
 =?us-ascii?Q?J+j+Y9UPZTnzoBZ8oZVWvyFx4ocC7qwlNLvnWNr5t1584VcyBOj3kbJlUc9r?=
 =?us-ascii?Q?3P57YaxLVUYK2xQ/8dmMpVu74ILuBFlxGtO/B1Y3CDiVOgd+R7qLb+XCylbF?=
 =?us-ascii?Q?OiwNRXRHaCG9+uC/NSUNVRdFDf9nv1CYiAG3BoFyC4HRxr8L2OAdiLppHm9X?=
 =?us-ascii?Q?HUeKsISe7mVwzL04kKH2DQ5BYwRZhZCvrQA/M2FXMEsySzqwSOv8iXjwgfBB?=
 =?us-ascii?Q?gtFO1DS0j7VkgfDdIeCKgNHKzy4eYlSS9v7E07Va1NHx/acKJBIDGCFkXktq?=
 =?us-ascii?Q?sg2N/Fj1c3psYpHiY+h6T6shS69Qai65xD5cwpvfK4JmHeHpdlTV9tUibv7t?=
 =?us-ascii?Q?I0A3ZDQYYVWqOuw4AwJOssjP1ZtLHb0RvLQxJu8yLFpqH2k84tCUYcNTcw6X?=
 =?us-ascii?Q?tbqYiux0azs5P3N1f5hXR5j5Nja7oK8O9E7SANk8XVnb8BSYN8MX1KCQxqK8?=
 =?us-ascii?Q?F8no0kabYbzxi8LiVkv9A//6HqhhjiJSxRd8ezMpcncrCmzeNLeqUaQFrpZb?=
 =?us-ascii?Q?6pgYh4yN+fivM3LeoJ42vxcP3/yT9yxR214lNWAHvVo553VHvcnfqIN7Zheu?=
 =?us-ascii?Q?2DcY6AxNPoXm5USR2VlJQpY4jKEdD79m0EuV6ntxI4KMO3l/DkcZC85Lu8xJ?=
 =?us-ascii?Q?CCPwbwcccr0+lBdwgCutgaFG3Zb6L0pz5Ej3fXCp1QfIRqRDtMOyJm3Wkalr?=
 =?us-ascii?Q?5zIxmJlAQutgjYk+kuzXVIr9ns5oF9L18y1smuDTycyHsb/RCJpXVj9i2cHZ?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38416157-a77a-400e-8e08-08db0a531f9b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 04:07:13.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Srnfg9Z+vLh48XmXbhzw2iDI4vIUIu9F92tVCW0/aM6U2qY1W4eAJVMluah+SLIqbK0B1orYpO9nxna+h0W/4dOlj9GzxffKbIGtISDpru0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 05 Feb 2023 17:03:29 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Region autodiscovery is an asynchrounous state machine advanced by
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
> > >From that point the region goes through the same setup and validation  
> > steps as user-created regions, but instead of programming the decoders
> > it validates that driver would have written the same values to the
> > decoders as were already present.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few comments inline,
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/hdm.c    |    5 
> >  drivers/cxl/core/port.c   |    2 
> >  drivers/cxl/core/region.c |  496 ++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h         |   16 +
> >  drivers/cxl/port.c        |   26 ++
> >  5 files changed, 531 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index dcc16d7cb8f3..174cddfec6e8 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -674,7 +674,7 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
> >  	up_read(&cxl_dpa_rwsem);
> >  
> >  	port->commit_end--;
> > -	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> > +	cxld->flags &= ~(CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO);
> >  
> >  	return 0;
> >  }
> > @@ -719,7 +719,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  
> >  	/* decoders are enabled if committed */
> >  	if (committed) {
> > -		cxld->flags |= CXL_DECODER_F_ENABLE;
> > +		cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO;
> >  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> >  			cxld->flags |= CXL_DECODER_F_LOCK;
> >  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> > @@ -783,6 +783,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  		return rc;
> >  	}
> >  	*dpa_base += dpa_size + skip;
> > +
> 
> :)  No comment.

Spurious newlines... my old friend.

> 
> >  	return 0;
> >  }
> >  
> 
> 
> ...
> 
> 
> > +static int cmp_decode_pos(const void *a, const void *b)
> > +{
> > +	struct cxl_endpoint_decoder *cxled_a = *(typeof(cxled_a) *)a;
> > +	struct cxl_endpoint_decoder *cxled_b = *(typeof(cxled_b) *)b;
> > +	struct cxl_memdev *cxlmd_a = cxled_to_memdev(cxled_a);
> > +	struct cxl_memdev *cxlmd_b = cxled_to_memdev(cxled_b);
> > +	struct cxl_port *port_a = cxled_to_port(cxled_a);
> > +	struct cxl_port *port_b = cxled_to_port(cxled_b);
> > +	struct cxl_port *iter_a, *iter_b;
> > +
> > +	/* Exit early if any prior sorting failed */
> > +	if (cxled_a->pos < 0 || cxled_b->pos < 0)
> > +		return 0;
> > +
> > +	/*
> > +	 * Walk up the hierarchy to find a shared port, find the decoder
> > +	 * that maps the range, compare the relative position of those
> > +	 * dport mappings.
> > +	 */
> > +	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
> > +		struct cxl_port *next_a, *next_b, *port;
> > +		struct cxl_switch_decoder *cxlsd;
> > +
> > +		next_a = next_port(iter_a);
> > +		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
> > +			int a_pos, b_pos, result;
> > +			struct device *dev;
> > +			unsigned int seq;
> > +
> > +			next_b = next_port(iter_b);
> > +			if (next_a != next_b)
> > +				continue;
> > +			if (!next_a)
> > +				goto out;
> Perhaps treat this as a 'find the match' then carry on, so as to avoid having the
> guts of the handling nested so deep.  So something like.

I always like a good out-indent, will give it a look.

> 
> 	struct cxl_switch_decoder *cxlsd;
> 	struct cxl_port *next_a, *next_b, *port;
> 	bool matched = false; // May be simpler test - I'm just lazy
> 
> 	// possibly pull this out as a utility function so that
> 	// error handling can be tidied up by simply returning 
> 	// rather than gotos.
> 	for (iter_a = port_a; iter_a; iter_a = next_port(iter_a)) {
> 		next_a = next_port(iter_a);
> 		for (iter_b = port_b; iter_b; iter_b = next_port(iter_b)) {
> 			int a_pos, b_pos, result;
> 			struct device *dev;
> 			unsigned int seq;
> 
> 			next_b = next_port(iter_b);
> 			if (next_a != next_b)
> 				continue;
> 			if (!next_a)
> 				goto out;
> 			port = next_a;
> 			found = true;

@found can just be @port.

> 			break;
> 		}
> 		if (found)
> 			break;
> 	}
> 	if (!found)
> 		goto out;
> 
> 	dev = device_find_child(&port->dev, cxled_a,
> 				decoder_match_range);
> 	if (!dev) {
> 		struct range *range = &cxled_a->cxld.hpa_range;
> 		dev_err(port->uport,
> 			"failed to find decoder that maps %#llx-:%#llx\n",
> 		range->start, range->end);
> 		cxled_a->pos = -1;
> 		return 0;
> 	}
> 
> 	cxlsd = to_cxl_switch_decoder(dev);
> 	do {
> 		seq = read_seqbegin(&cxlsd->target_lock);
> 		find_positions(cxlsd, iter_a, iter_b, &a_pos, &b_pos);
> 	} while (read_seqretry(&cxlsd->target_lock, seq));
> 
> 	if (a_pos < 0 || b_pos < 0) {
> 		dev_err(port->uport,
> 			"failed to find shared decoder for %s and %s\n",
> 			dev_name(cxlmd_a->dev.parent),
> 			dev_name(cxlmd_b->dev.parent));
> 		cxled_a->pos = -1;
> 		result = 0;
> //if factored as suggested above then a goto here and drop
> // the else would be neater again.

Perhaps, I'll take a look.

> 
> 	} else {
> 		result = a_pos - b_pos;
> 		dev_dbg(port->uport, "%s: %s comes %s %s\n",
> 			dev_name(&cxlsd->cxld.dev),
> 			dev_name(cxlmd_a->dev.parent),
> 			result < 0 ? "before" : "after",
> 			dev_name(cxlmd_b->dev.parent));
> 		}
> 	put_device(dev);
> 
> 	return result;
> out:
> 	dev_err(cxlmd_a->dev.parent, "failed to find shared port with %s\n",
> 		dev_name(cxlmd_b->dev.parent));
> 	cxled_a->pos = -1;
> 	return 0;
> }
> 
> 
> > +			dev = device_find_child(&port->dev, cxled_a,
> > +						decoder_match_range);
> > +			if (!dev) {
> > +				struct range *range = &cxled_a->cxld.hpa_range;
> > +
> > +				dev_err(port->uport,
> > +					"failed to find decoder that maps %#llx-:%#llx\n",
> > +					range->start, range->end);
> > +				cxled_a->pos = -1;
> > +				return 0;
> > +			}
> > +
> > +			cxlsd = to_cxl_switch_decoder(dev);
> > +			do {
> > +				seq = read_seqbegin(&cxlsd->target_lock);
> > +				find_positions(cxlsd, iter_a, iter_b, &a_pos,
> > +					       &b_pos);
> > +			} while (read_seqretry(&cxlsd->target_lock, seq));
> > +
> > +			if (a_pos < 0 || b_pos < 0) {
> > +				dev_err(port->uport,
> > +					"failed to find shared decoder for %s and %s\n",
> > +					dev_name(cxlmd_a->dev.parent),
> > +					dev_name(cxlmd_b->dev.parent));
> > +				cxled_a->pos = -1;
> > +				result = 0;
> > +			} else {
> > +				result = a_pos - b_pos;
> > +				dev_dbg(port->uport, "%s: %s comes %s %s\n",
> > +					dev_name(&cxlsd->cxld.dev),
> > +					dev_name(cxlmd_a->dev.parent),
> > +					result < 0 ? "before" : "after",
> > +					dev_name(cxlmd_b->dev.parent));
> > +			}
> > +
> > +			put_device(dev);
> > +
> > +			return result;
> > +		}
> > +	}
> > +out:
> > +	dev_err(cxlmd_a->dev.parent, "failed to find shared port with %s\n",
> > +		dev_name(cxlmd_b->dev.parent));
> > +	cxled_a->pos = -1;
> > +	return 0;
> > +}
> > +
> > +static int cxl_region_sort_targets(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int i, rc = 0;
> > +
> > +	sort(p->targets, p->nr_targets, sizeof(p->targets[0]), cmp_decode_pos,
> > +	     NULL);
> > +
> > +	for (i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +
> > +		if (cxled->pos < 0)
> > +			rc = -ENXIO;
> > +		cxled->pos = i;
> > +	}
> > +
> > +	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
> > +	return rc;
> > +}
> > +
> >  static int cxl_region_attach(struct cxl_region *cxlr,
> >  			     struct cxl_endpoint_decoder *cxled, int pos)
> >  {
> > @@ -1350,6 +1572,50 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > +		int i;
> > +
> > +		rc = cxl_region_attach_auto(cxlr, cxled, pos);
> > +		if (rc)
> > +			return rc;
> > +
> > +		/* await more targets to arrive... */
> > +		if (p->nr_targets < p->interleave_ways)
> > +			return 0;
> > +
> > +		/*
> > +		 * All targets are here, which implies all PCI enumeration that
> > +		 * affects this region has been completed. Walk the topology to
> > +		 * sort the devices into their relative region decode position.
> > +		 */
> > +		rc = cxl_region_sort_targets(cxlr);
> > +		if (rc)
> > +			return rc;
> > +
> > +		for (i = 0; i < p->nr_targets; i++) {
> > +			cxled = p->targets[i];
> > +			ep_port = cxled_to_port(cxled);
> > +			dport = cxl_find_dport_by_dev(root_port,
> > +						      ep_port->host_bridge);
> > +			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> > +							dport, i);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +
> > +		rc = cxl_region_setup_targets(cxlr);
> > +		if (rc)
> > +			return rc;
> > +
> > +		/*
> > +		 * If target setup succeeds in the autodiscovery case
> > +		 * then the region is already committed.
> > +		 */
> > +		p->state = CXL_CONFIG_COMMIT;
> > +
> > +		return 0;
> > +	}
> > +
> >  	rc = cxl_region_validate_position(cxlr, cxled, pos);
> >  	if (rc)
> >  		return rc;
> > @@ -1500,8 +1766,8 @@ static int detach_target(struct cxl_region *cxlr, int pos)
> >  	return rc;
> >  }
> >  
> > -static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> > -			    size_t len)
> > +static ssize_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> > +			     size_t len)
> 
> ?
> 
> 
> 
> ...
> 
> 
> > +
> > +void cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct range *hpa = &cxled->cxld.hpa_range;
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> > +	struct cxl_root_decoder *cxlrd;
> > +	struct cxl_region_params *p;
> > +	struct cxl_region *cxlr;
> > +	struct cxl_port *root;
> > +	bool attach = false;
> > +	struct device *dev;
> > +
> > +	root = find_cxl_root(&cxlmd->dev);
> > +	if (!root) {
> > +		dev_err(cxlmd->dev.parent, "%s: failed to map CXL root\n",
> > +			dev_name(&cxlmd->dev));
> > +		return;
> 
> I'm not a fan of muddling on from errors at lower layers of code.
> I'd push that decision up to the caller - so return an error code from here.
> If caller just wants to ignore it (with appropriate comment on why) then
> that is fine by me.

Yeah, in fact the caller should already know about the root at this
point since this is called from cxl_port_probe() that did that port
establishment. Perhaps this can just take @root as an argument.

Note though that all errors here are ignored by the caller because there
is simply no way to know ahead of time whether this region will succeed
in receiving all its members. So the failure scenario is missing
regions, not anything that would make the port driver fail to load.

> 
> 
> > +	}
> > +
> > +	dev = device_find_child(&root->dev, &cxld->hpa_range,
> > +				  match_decoder_by_range);
> 
> device_find_child is acquiring a reference to the child I think.
> 
> > +	if (!dev) {
> > +		dev_err(cxlmd->dev.parent,
> > +			"%s:%s no CXL window for range %#llx:%#llx\n",
> > +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> > +			cxld->hpa_range.start, cxld->hpa_range.end);
> > +		goto out;
> > +	}
> > +	cxlrd = to_cxl_root_decoder(dev);
> Here we've stashed the dev that we have a reference to in cxlrd.
> > +
> > +	mutex_lock(&cxlrd->range_lock);
> > +	dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> > +				match_region_by_range);
> > +	if (!dev)
> > +		cxlr = construct_region(cxlrd, cxled);
> > +	else
> > +		cxlr = to_cxl_region(dev);
> > +	mutex_unlock(&cxlrd->range_lock);
> > +
> > +	if (IS_ERR(cxlr))
> 
> In this path, do we drop the reference to cxlrd->dev?

No, good eye. The reference can be dropped immediately since the root
decoder will not be unregistered until the root port is removed and by
this point this port has registered itself in the device_unregister()
chain when its ancestors are taken out.

> 
> > +		goto out;
> > +
> > +	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> > +
> > +	down_read(&cxl_region_rwsem);
> > +	p = &cxlr->params;
> > +	attach = p->state >= CXL_CONFIG_COMMIT;
> 
> Test is a bit non obvious.  In the tree I'm looking at
> CXL_CONFIG_COMMIT is last value in the enum.

Can switch to "=="

> 
> 
> > +	up_read(&cxl_region_rwsem);
> > +
> > +	if (attach) {
> > +		int rc = device_attach(&cxlr->dev);
> > +
> > +		/*
> > +		 * If device_attach() fails the range may still be
> > +		 * active via the platform-firmware memory map
> > +		 */
> > +		if (rc < 0)
> 
> We also want to know if the no matching driver found case happened so perhaps
> 		if (rc != 1)

That can't happen as the only possible driver, cxl_region_driver, is in
this same file. I'll add a comment to that effect as its a small
layering violation to know that.

> 
> > +			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
> > +				p->res);
> > +	}
> > +
> > +	put_device(&cxlr->dev);
> > +out:
> > +	put_device(&root->dev);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
> > +
> >  static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> >  {
> >  	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
> > @@ -2103,6 +2554,15 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> >  	return 0;
> >  }
> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index ca76879af1de..9b3765c5c81a 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -261,6 +261,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
> >   * cxl_decoder flags that define the type of memory / devices this
> >   * decoder supports as well as configuration lock status See "CXL 2.0
> >   * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
> > + * Additionally indicate whether decoder settings were autodetected,
> > + * user customized.
> >   */
> >  #define CXL_DECODER_F_RAM   BIT(0)
> >  #define CXL_DECODER_F_PMEM  BIT(1)
> > @@ -268,6 +270,7 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
> >  #define CXL_DECODER_F_TYPE3 BIT(3)
> >  #define CXL_DECODER_F_LOCK  BIT(4)
> >  #define CXL_DECODER_F_ENABLE    BIT(5)
> > +#define CXL_DECODER_F_AUTO  BIT(6)
> 
> That's a bit nasty and unexpected - can we rename to make it really clear
> it's not a hardware flag at the point of usage.
> Or just put it in a a new structure field rather than pushing it in here.

I'll move it to an endpoint-flag value since it is only relevant for
those.

> >  #define CXL_DECODER_F_MASK  GENMASK(5, 0)
> 
> Hmm. This mask isn't currently used and now has
> an odd meaning because of hiding a flag in bit(6).

True, it can be deleted by a separate cleanup.

> 
> 
> ...
> 
> >  
> >  /*
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 5453771bf330..012a0c6f8476 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -30,6 +30,23 @@ static void schedule_detach(void *cxlmd)
> >  	schedule_cxl_memdev_detach(cxlmd);
> >  }
> >  
> > +static int discover_region(struct device *dev, void *data)
> > +{
> > +	const unsigned long flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO;
> > +	struct cxl_endpoint_decoder *cxled;
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		return 0;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	if ((cxled->cxld.flags & flags) != flags)
> > +		return 0;
> > +
> > +	cxl_add_to_region(cxled);
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_port_probe(struct device *dev)
> >  {
> >  	struct cxl_port *port = to_cxl_port(dev);
> > @@ -78,6 +95,15 @@ static int cxl_port_probe(struct device *dev)
> >  		return rc;
> >  	}
> >  
> > +	if (!is_cxl_endpoint(port))
> > +		return 0;
> > +
> > +	/*
> > +	 * Now that all endpoint decoders are successfully enumerated,
> > +	 * try to assemble regions from committed decoders
> > +	 */
> > +	device_for_each_child(dev, NULL, discover_region);
> > +
> 
> There is a steady reduction in common code vs specific code for the two
> cases in here.  Maybe it's time just to split the probe into
> 
> static int cxl_port_probe(struct device *dev)
> {
> 	if (is_cxl_endpoint(port))
> 		cxl_port_probe_endpoint();
> 	else
> 		cxl_port_probe_not endpoint(); //with better naming.
> }
> 
> Shared code is about 7 lines vs 40+ unshared.

Works for me.
