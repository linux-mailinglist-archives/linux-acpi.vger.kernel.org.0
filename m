Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D3B68FE40
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 05:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBIELz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 23:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBIELv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 23:11:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630CB367D3;
        Wed,  8 Feb 2023 20:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675915869; x=1707451869;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tglbjLWoGGAvKY+1vgfKxfcnk0LNU4ykE0+kwCDfo4M=;
  b=m7BesPN9ScvPmhAwoK2pnbjtwA1+Y/3PoESz5QyVSObsm5p1VdP7uVWU
   ftMOdc6V9qmFRpX7vlU2jJ3d7VOnm2HJjy5T/mo+DEAxvkFrHARoD7NYf
   BXIAcI7prb1vaUFlf/o7Law8w9KilAl/gADX1R8O2+xuwED6/r6XDbq6r
   bUbY+s7GDGr1055+BG3opDdEAhxZZO/RrXlF0mcnz3D1YJ0gTuyMxirCu
   OEr4Wdof0CFlX/vhMDV5vMpujJbCw+y0lau5AYZfDi1gK+1YmMnz2gLgg
   qphYaquvH2O4EyhENnpmTEFveS+PZocjdmNdaI7XjNmXENu/IW9Fc3kuR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416228999"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416228999"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:09:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="660866105"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="660866105"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2023 20:09:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:09:31 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 20:09:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 20:09:30 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 20:09:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2UXyh3y+DeVhoPprmd7Kb7Z8KqOI7tnxKBhl8uUea2IwXUgXgucs1gjPhlj7RorrxvPyLqBVjl22sOEEWgoNTvDHRfMwVwkqRCgEx6KF3ppS7Xrd8hl5Nl4/BUSrOmJfb7zDcvU2zMXDTzMolZAG+PjMMVEYlTie4eIc+CtsFTcHIvACc5q8l+FgIdwFxWht1c5KG1Mjc0N7yrfTYMj+PR6hVMO/rLA+c25iJWcw3xKID0jws2598f6WvPzxpJO3o/7XiIgvNINB3lPZe2UlhQzhr6fBfcgfPPwLC9UvMKcJi+g+r77FfKLm/xoqQ5RVdLvCQCDiHOe3raMwc70KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlW6uQVFDrAbUan7Sv+FDyHo4xCflI7DlutMYAV2JA0=;
 b=hQta3cTAYRWLrGVrnrPJd/HhhMDkSMaj6OiGYEfKyd9bekhMP2Aq7STxvyX8OGY1fpnIzYxD+A5wOEubpgPSw4twcbuzp3EMy+sEdu4T/o+CVcXTMZbnzOmrvbiQJPO2kdVHwlXCFD4LcvBk731DOcmH41ldHWwKsMUEeSUebvJW0OGTGRKxFNbTb43GfZDP/9EFfChgaFHh0X57ttq4KzELLObiC/u/23+sIAJzwiCWUKut7QqDxiPmg+GXbNy7YbN8QWSunIb8dfyX8130wgs+qMOiC6ozLnv0hWG/Gx5gaQDIoRsIg8Zh8EFLPkjB64w6gV6I1B2vZI9pLotNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 9 Feb
 2023 04:09:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 04:09:28 +0000
Date:   Wed, 8 Feb 2023 20:09:25 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
Message-ID: <63e471f5907f1_36c7294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
 <20230208123031.00006990@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208123031.00006990@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 26559e92-a6b8-4014-558c-08db0a536fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylFrMwoxGpdxXo6sE5R8OHJpFfTlsAMwo6aSDL46T0uSnkQvpa7Qj1owb/GViL/hdKM9mGanff2rCV1OSx3K8U0zw4Ni7cX8AAT9b7r7lv9Sa4QKqocjSuCwFYyLS6YzkXnD0lAP6oMRFCRM0haehJPwAi7YvC7ZhA9GeasGU1b83ScSJgppgQVWu53ZjeZKqKIomBjIlXOvXs355HCNquOHvngT5jIbENicsIuCgCWD8SsIv8ZMrL7xnaDAoD1pu5EZ4lw0wbjO+EjJugSrfgS+IOAd5SueApWiPnLeZhy2Ae5IuD8kiuHEmhOe+LkDM01R7erftu9eUJZ1kuQ+oXGelkRUA3anomCxxquZ7mDKS5S+g3P67p+HaKZQsP5k9Z+WSLqtNDXt3thRYo46BX/yyyy50KFMjr8SmldkzzFzd5+/3ul32Pvjd2c/yS+kT+kHZYWQzCCi9jC1srb2koga2n/gyytVLFD4tnKLerEZqjlkT3P+Au3GakNC9g3NaIBBFF7wDp8tY00Bx7r3PtcQcCFO115IK6MKxtkGD3o4d7/htwflLKipw7cgtrnno++i2wb1XVhowuIxw8OmxkTOyYUX2J9cf4CD8s9yceA762XGP5lhZkXA78iBMEuX87OtBkiizqPmsmIhn5dgIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199018)(38100700002)(82960400001)(66899018)(110136005)(316002)(6486002)(83380400001)(9686003)(6512007)(186003)(66556008)(66476007)(478600001)(66946007)(8936002)(2906002)(5660300002)(86362001)(8676002)(4326008)(26005)(6506007)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8npXT2eBJu02bySD9mNSk3NLj5LpxRDWQ4HSHQhPUB/0CHtktJiIH52dqUgs?=
 =?us-ascii?Q?F0ajR1s99fildOlmv7urx3UgA/w1oM+n6Yn8ziNFmytt3pshwMqgFkVo8v96?=
 =?us-ascii?Q?pWOx6tHLf/fVgWd0DFXEvWY9oCzXykKzUuPMPWv7hR6WcIz6URZEROe4JTDp?=
 =?us-ascii?Q?KfOyuTnV+fxjr9M0LmuW1vqXBRVLyrMuBs7NIT2H8eJKGMBIKUrFQJd9dfMt?=
 =?us-ascii?Q?LMfd0IRyy8yPVs7ZXiX9yotS0ufWGzuBO7S1apkJ1SjnhCaGmM6Tm0SX0IAF?=
 =?us-ascii?Q?2Z8otMRNK1sXKCFFyDdwLGzpCWzfw3CUAwjanDA+fUg/3lFHQD6rE0ubBHJt?=
 =?us-ascii?Q?jFK8fwu7o0+MNOmCnUNcWTzgOJCMj6mNamAuB4gL/JFmGhscA++g0fWNnnxL?=
 =?us-ascii?Q?T8y0f1FK9Jk10Z5HxyA6q1ecGMH5PvfladPX9WP4kdOtjuHombF269TIz8ev?=
 =?us-ascii?Q?RUZgf6+ObJGaCSSOGzLi4mnS3XuhZERupZSR6GSTKlZFbRi0Ecu1hLM565Yo?=
 =?us-ascii?Q?ptGPK6UnuU6IXh8JdgaE7mMLpgmGbdYOvZUO1J0RWFIZFcLd0A0QkFw6Jq2+?=
 =?us-ascii?Q?Vfoagk2RgYXr/MhKqFLDugQ+1SGbKOEpja1FzEbf/S1VLbgPva07BcMRbnxY?=
 =?us-ascii?Q?3xg4lSAbxfa3lUyZ3uH6lUz+brtxbqiyK1AKoKK7ESoqQ/rGD3e60PBJsI67?=
 =?us-ascii?Q?bmIcSwL0CXzxDY1ExyPCzYAye+9Fx34u0L0iKgdE/R3RgM2g6olC36uBQje1?=
 =?us-ascii?Q?GOHM1YLnUilgfUAm2DYUV6nxWMbH0K42l3Q5XBhWugQwrjmvpzEgtN+9VRBk?=
 =?us-ascii?Q?d7Tac3tMJGuch27JEwpYIgJ7EH/siRbdswK3y5Wdm1u9sZsLQ103yLUBrr1N?=
 =?us-ascii?Q?FwWH10+CR3nPzVtbjzvUDRtKl29uo/fWyPV5mViClYqyrz+xqgUyYruoauHh?=
 =?us-ascii?Q?pWpWNJZaW97eaB4VzTVvBotNAxQ2nkI/+skgm46UE/Htt4rrmgtr3pxXe2BK?=
 =?us-ascii?Q?e0y7uPmWtVpnIp68VmDJ9L3C9C3ZbTM+QlZJUtW5udhss7Xdhs/4hRuQnJj2?=
 =?us-ascii?Q?4M9H4l4U6JLvBojzNWP+fzR3G3Fg4rLHtyu+XBHp26R9rMGXwIhIONTmW7Pv?=
 =?us-ascii?Q?dcbObu+27EYVgjBp7DRqdqFrjvH/E9gvV1/7r8PSpiH+GRgDmum5n4i2l7F8?=
 =?us-ascii?Q?GDMoNA7obluTUF+Xt2Y+owdUK+kqzXo/prnw4fYaE3RicwxsgHHM+xJTYCCw?=
 =?us-ascii?Q?U+f9LyYklBTyUMp8h+u62fYk6IWktKU2gM7u2jpiKOwAiwnpGWgYA+GLsxJ1?=
 =?us-ascii?Q?KNVtotuqEJC5Zxg3120y7Hij008IeIq6s0QwKC7KoaUiT5PTS+ee2Z1IgtSX?=
 =?us-ascii?Q?5Q0zOqDxkIPfhtPdWB7i3Ff4inRHSvbtvFqNOUyLXZFp8pEIiIL67Q/AObGF?=
 =?us-ascii?Q?Wowp7/dw7D76B6u6NfVdrj5UWYLFbDjYEedI6Friic2CkNoKjTvO72K1PZg/?=
 =?us-ascii?Q?2JR32vh8vBTnCvoNE1FxAar44qGRNZlHHk90/gmQUpalgeZdTT0T+K8iyTPp?=
 =?us-ascii?Q?C/LJwIz/eXZsK1TuEDwIAlrNEWBMqXCI2JhGu8E2XFe/EmceMjj37Dsx/GKw?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26559e92-a6b8-4014-558c-08db0a536fd9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 04:09:28.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EncPgHZdOGbQYHTK8h/IW9nyJisi8W8YGnbkDbCO2EGiYrMNvLCMpNXUmD69AsiWEeDpWpNBgdmOxWZFHsI5DdPGQyhCYSs5uP9nUwt4T8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
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
> On Sun, 05 Feb 2023 17:03:07 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
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
> Hi Dan,
> 
> A few comments inline, but mostly reflect the original code rather than
> the refactoring you have done in this patch.
> 
> Jonathan
> 
> 
> > +static int cxl_region_attach(struct cxl_region *cxlr,
> > +			     struct cxl_endpoint_decoder *cxled, int pos)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_port *ep_port, *root_port;
> > +	struct cxl_dport *dport;
> > +	int rc = -ENXIO;
> > +
> > +	if (cxled->mode != cxlr->mode) {
> > +		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> > +			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (cxled->mode == CXL_DECODER_DEAD) {
> > +		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* all full of members, or interleave config not established? */
> > +	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
> > +		dev_dbg(&cxlr->dev, "region already active\n");
> > +		return -EBUSY;
> > +	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> > +		dev_dbg(&cxlr->dev, "interleave config missing\n");
> > +		return -ENXIO;
> > +	}
> > +
> >  	ep_port = cxled_to_port(cxled);
> >  	root_port = cxlrd_to_port(cxlrd);
> >  	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
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
> 
> >  	if (cxled->cxld.target_type != cxlr->type) {
> >  		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > @@ -1314,12 +1350,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -EINVAL;
> >  	}
> >  
> > -	for (iter = ep_port; !is_cxl_root(iter);
> > -	     iter = to_cxl_port(iter->dev.parent)) {
> > -		rc = cxl_port_attach_region(iter, cxlr, cxled, pos);
> > -		if (rc)
> > -			goto err;
> > -	}
> > +	rc = cxl_region_validate_position(cxlr, cxled, pos);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
> > +	if (rc)
> > +		return rc;
> >  
> >  	p->targets[pos] = cxled;
> >  	cxled->pos = pos;
> 
> More something about original code than the refactoring...
> 
> I'm not keen on the side effects that aren't unwound in the error paths.
> 
> p->targets[pos] and cxled->pos are left set.  Probably never matters
> but not elegant or as easy to reason about as it would be if they
> were cleared in error cases.  In particular there is a check on
> whether p->targets[pos] is set that will result in a dev_dbg even
> though setting it up actually failed.

I'll clean that up with a lead-in fixup.
