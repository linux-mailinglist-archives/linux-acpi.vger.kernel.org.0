Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B30C69295E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 22:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjBJVgZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 16:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjBJVgY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 16:36:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0CD32CDF;
        Fri, 10 Feb 2023 13:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676064949; x=1707600949;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eHujy0CDGIHnqpC84TUVLj/84COPnbs2xTP2Pl847d0=;
  b=DUGuB/H31APf0790kjdJ7E4RJeRPD+Hj9OyitGbn9x2WQ+JInS226rH+
   dZBMhUYVBm+fzRpYzNPMiA9ng1VspEeBpNjWM04FD9QQWF+XLpPylKzNe
   NLIAa1aEEE9olEb2vm5+ukDDr9Rnl24jKU1oU0RRow63m22guzLl07blv
   em3lFjfbHm0BwyxE+8ovOQ8wWIEaE1mVlBLkt9lPj5KXtd3eDnQDrryj0
   fHhXwlGRmMmZm11fBfBXiwh2cIEGFUZKGeThDc1lMljep7elO3EFZ7dOd
   smDGWHiwEhfXX8Sj3c/jEbnxsx6Ow4WFaTqfeLP3RPpH3gdDZKqKo6tTt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310162865"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310162865"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756923951"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756923951"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 13:35:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 13:35:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 13:35:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 13:35:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 13:35:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/HSBJOd4VpdxpAsSr/LmQKxIyFYQTNSi38JzTZXiQ++Os4K5FqzU1yj4epH/w6HB+DpbaIrlXqyKR8UCjLFnfsX4ghUXNaxbhNfMZS0NfsjTuCRdJRaW+qJqrUBNNsHPGPld6Z1vzlcoP8lLctiBKeoJ/d+LHXldwdBDD+WMVk0npwN0h7VlhxPo4JFRs/8nPBBHsV1UX/GoDBSrhc1WPCAKDbaq88eCvClT4xfshegglNm2/JywYbiy/uDgeWJkKWpDw0qWFqKC4UBDk76WIWnZ/NEqlzhrTfBkRvM569LPsMN+WbgEgviG0QUFLGV6Hv+looALjRT4wXCK+n0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvMV6R2NEjcC2/OAfNdgjP44M5KXejWi6f7ILS5pfgo=;
 b=P0hRSINmue88Mjz5lER55XsCQP/L0Agj2TfaM3RJvpgEv/xPpXKP3PKnnQIEEJJzMJOpHEFJpGnuSE6yxzVe65Z3D1+N5k81VaC/igllx3A2beeCVaXEeHw7gwjMv0YuPdM4kUBJVKVbmzDWQx365O/14R/Z8Mqo/i+J6w/xrQCdAAj/5ETls89x97kdf0R3p8jbCEdg1dU84r8yS9/dPjd6oqnMiF3GaYd81EZQmLg5QdzDos+9q6YL/ybEQB5Z9Qg06hf4WkZI7OgMsk37lY0FVxeBY9oVREVUuX57/biDfnLHGSNROprdANHE519Oxm9r+QVK+ZqGPkmnnS/QqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 21:35:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 21:35:20 +0000
Date:   Fri, 10 Feb 2023 13:35:17 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Message-ID: <63e6b89581c3c_1db5d029467@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
 <20230210180958.00002e5a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230210180958.00002e5a@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ac955e-5909-4fa4-a1e0-08db0baeb54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/C0KLOC9gzBPsJwoSgUx6tDjN/63BaCAPYahKTzKBVMliAmC40Gn4N5d+waI6xTinz/0m15hFYDiJ7RVxfCg4kb0U/Hji++uzTV36YoNuGb8mtt6v2ePSXnSii4AFy/NpVS4aPjiybIgYwAeWPfWqWAu6vwPESDjd6Mg6QZiBfpS1EGKsQW45gzWlQ8lFoIoWpFtiMkD3o/prctRE+UH9rOYfsrwUSIleujbRIQuacJ+GMnHUynGFTHeTlAMQ2SCR9Ui4tSLcUcvIpyLCv55NfCSsiBbfVidhVHWKpnjSXFHCZz2jFJZ4mA4g5O+e4FK2kf2hUD5ipGRS8uOLKmnEB+Kic6uhcTB56Z8iMAKNbrztKmYRS8rIPaGZw9lZPAkxu12Im1yJtXpu33Iihv2QnKHk33VGQqxLTN2jboj+nT78c01HOOWu8TR6cFbsco+JohK2OufSPIQUMjQn5zuNy/MzmDlDstbi8hLABPAwXUhk+vS/NGEKa91Grz9lWYfK5Je64m8dvxJdcYKpmho6pWiGesw2PZR4BfUn/iRA7uoW+xyBgNwp3VPivwFh6HVTXJbNDhfEFFNiAqE1yVUP3ZeujiK5CnxvPanUiAwZ+QNdYat6dqGBj95gRl4QV3UEQQC6XheP1WUtvVHfZxu5SBcyPsFHzVcHRiVJyyDcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199018)(2906002)(86362001)(82960400001)(38100700002)(6486002)(966005)(186003)(6506007)(9686003)(6512007)(26005)(66946007)(66476007)(83380400001)(66556008)(316002)(110136005)(6666004)(4326008)(41300700001)(478600001)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+BYGcDTXdcJ1l6Rd1YLWf8ERnv9Mk8k+4C6XTVHI/izer2+MQiNWMTpLKT5X?=
 =?us-ascii?Q?LXVz3KS+Emhtee45YKCm/12Sgez9PY7Ivr1okEcPT61rNxD9ruze3Vsgtvr2?=
 =?us-ascii?Q?Ix5cjNuQ8i0tZyQJuRCTDM5s1enmefTTEXinu2S+hPR6T7blB9e6FIb6+XwR?=
 =?us-ascii?Q?RgriAArIAGGcFeeRTLXsczfBRNvzkT6BzwEt8fGxtIInfarDKpDlTigTbrp+?=
 =?us-ascii?Q?icMPaUswDA+eoGO8qIT8XATSprLisym8kWW60REHeoUnYxkrv2zk44lPptc0?=
 =?us-ascii?Q?OMxxEBk6e/xWwZOYL58UDpl4/3VsD34besIyUOzI+/qLBdGrq7EnthEoQ9ej?=
 =?us-ascii?Q?ZnROQ6P2IzPh9Ov8OYtTQL4PVdg8wauoR7MyDT3D7IOkvMxqrtI9rM1unMCA?=
 =?us-ascii?Q?YLkAvsTVx91uzoIfi3/gvwItcwIPwcp/H7N5Jmp3Sm2MmU4MClXp/2EwIZ/K?=
 =?us-ascii?Q?Bs6fVW9qEcPzoUdVHtiTJGGk305K0KMqmUwEE/xOQ1f6msE8ngvfLbgjCV3Z?=
 =?us-ascii?Q?uubQjUfFvkAddu102gM+PGE5VBC1ec9z6hRl8AKggiGfGj8u0gs1poU8xEXY?=
 =?us-ascii?Q?GZpGoUGesBS0X/iIzG1vvrx5c/CGeraWpm4icL9mhLig1ahR3rs4PZKsff1G?=
 =?us-ascii?Q?+khieKQuyJJm/GtlLVIw6rOVELl+Se+Cmxbf0uO/Hc3PMd2JxQjdC1wyY6Fn?=
 =?us-ascii?Q?mq/pD4kZVuo/p53hbGr4aJv37Z9Vf6wmyWhFzLK67k0aDPmJ5iQp1vUKIttW?=
 =?us-ascii?Q?wTXTe6JB35eXbqCMIfzaxcusOjyHt++7MKKaG0fah29fHqBlKC8QJXfzQA/Q?=
 =?us-ascii?Q?92n9avTXdeys8VJA0B9mTrwHcBQoX4xbUWK0BkKqBs0tkg1W4U3ygyfNaq4Z?=
 =?us-ascii?Q?ADJ+y1rM3zojnudsLphluiZadrZ039exsbJUD4ZhcKScOp3AGdEsaqZTbtaw?=
 =?us-ascii?Q?FuElgY8Hs2lfzHLTPhSPRwGzKtvgaOKiw2VxQ1udQ70PvB3gew9TlGeNuHKs?=
 =?us-ascii?Q?Fh+tpkxBSnBCL2bq9WIWWOUGT+AZdUp6h+cngLUfuIetbszE3sPJelOr81Z1?=
 =?us-ascii?Q?fR5FssO9I/unqB2AaWCB7V6Ddm7tqd6HvSTChWBd33CGoJ1UUjGiOiAXGShY?=
 =?us-ascii?Q?ud/whWk04A++bXEs0J9Li2Gl2LbVro02ic1BJFAeju2WL53YnvobtONrHLZh?=
 =?us-ascii?Q?cvDa4L1zFRAPjGT7ZXX0H1jfVOiN5azOQw8UKVlTJJLfbXEyK4Ag6EInsEps?=
 =?us-ascii?Q?RQsi7OWvkheV47j7ZmbOwyxp33d13dGp2yW9r4i21bDNixvZL+dSNDwXIoy7?=
 =?us-ascii?Q?Dbuzc8D1T6YLlJPl+3+v1jDr2Df0nl4PsvGctiv+h4Njl3HAAbOa9FfGABi6?=
 =?us-ascii?Q?oNoGUV+rWGrhWKmBpiR2ZMTbz7vPauo0i9cIvgtJtxryZTvhvOSlCd0Oa4TR?=
 =?us-ascii?Q?xyWBjvDShJfP6wMPZW7IVenDVaGQe5MknMoi6plMphppyKv88krePQmGqTnq?=
 =?us-ascii?Q?gbRcmrHmk+S5paVdrJiswkFxD64+wy9uTBcET6kpM2e2eztxWbFYDqllGFgR?=
 =?us-ascii?Q?6M/tsmDAlOx97mweX5Lk8iCqPKhU3/a+k2dX9dKIZxyl1IbUpXnQgS0dXevj?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ac955e-5909-4fa4-a1e0-08db0baeb54e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 21:35:20.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdiXCEjMtiEQyiCbksIb3rTtaYJGS3V1nvLbz3w23ekamg97/0GE3usubV2KdBgUTkke+761DrK/EqDfjHPCkORUVGuoKxCHrzSTGQCCzCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 10 Feb 2023 01:06:39 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
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
> > >From that point the region goes through the same setup and validation 
> Why the >? 

I believe this is auto-added by git send-email or public-inbox to make
sure that a sentence that begins with "From" is not misinterpreted as a
"From:" header. You can see this throughout the kernel commit history.
In this case I pulled the patches back down from lore before editing
them to collect review tags.

> > steps as user-created regions, but instead of programming the decoders
> > it validates that driver would have written the same values to the
> > decoders as were already present.
> > 
> > Tested-by: Fan Ni <fan.ni@samsung.com>
> > Link: https://lore.kernel.org/r/167564540972.847146.17096178433176097831.stgit@dwillia2-xfh.jf.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A few trivial things inline and this being complex code I'm not
> as confident about it as the rest of the series but with that in mind
> and the fact I didn't find anything that looked broken...
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ...
> 
> 
> 
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
> 
> If it makes sense to carry on after pos < 0 I'd like to see a comment here
> on why.  If not, nicer to have a separate dev_dbg() for failed case nad
> direct return here.

Ok, I'll add:

/*
 * Record that sorting failed, but still continue to restore cxled->pos
 * with its ->targets[] position so that follow-on code paths can reliably
 * do p->targets[cxled->pos] to self-reference their entry.
 */

> 
> > +		cxled->pos = i;
> > +	}
> > +
> > +	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
> > +	return rc;
> > +}
> > +
> 
> > +
> > +int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct range *hpa = &cxled->cxld.hpa_range;
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> > +	struct cxl_root_decoder *cxlrd;
> > +	struct cxl_region_params *p;
> > +	struct cxl_region *cxlr;
> > +	bool attach = false;
> > +	struct device *dev;
> > +	int rc;
> > +
> > +	dev = device_find_child(&root->dev, &cxld->hpa_range,
> > +				match_decoder_by_range);
> > +	if (!dev) {
> > +		dev_err(cxlmd->dev.parent,
> > +			"%s:%s no CXL window for range %#llx:%#llx\n",
> > +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> > +			cxld->hpa_range.start, cxld->hpa_range.end);
> > +		return -ENXIO;
> > +	}
> > +
> > +	cxlrd = to_cxl_root_decoder(dev);
> > +
> > +	/*
> > +	 * Ensure that if multiple threads race to construct_region() for @hpa
> > +	 * one does the construction and the others add to that.
> > +	 */
> > +	mutex_lock(&cxlrd->range_lock);
> > +	dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> > +				match_region_by_range);
> > +	if (!dev)
> > +		cxlr = construct_region(cxlrd, cxled);
> > +	else
> > +		cxlr = to_cxl_region(dev);
> > +	mutex_unlock(&cxlrd->range_lock);
> > +
> > +	if (IS_ERR(cxlr)) {
> > +		rc = PTR_ERR(cxlr);
> > +		goto out;
> > +	}
> > +
> > +	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> > +
> > +	down_read(&cxl_region_rwsem);
> > +	p = &cxlr->params;
> > +	attach = p->state == CXL_CONFIG_COMMIT;
> > +	up_read(&cxl_region_rwsem);
> > +
> > +	if (attach) {
> > +		int rc = device_attach(&cxlr->dev);
> 
> Shadowing int rc isn't great for readability. Just call it rc2 or something :)
> Or given you don't make use of the value...

0day did not like this either...

> 
> 		/*
> 		 * If device_attach() fails the range may still be active via
> 		 * the platform-firmware memory map, otherwise the driver for
> 		 * regions is local to this file, so driver matching can't fail
> +                * and hence device_attach() cannot return 1.
> 
> //very much not obvious otherwise to anyone who isn't far too familiar with device_attach()

Hence the comment? Not sure what else can be said here about why
device_attach() < 0 is a sufficient check.

> 
> 		 */
> 		if (device_attach(&cxlr->dev) < 0)
> 			dev_err()
> > +
> > +		/*
> > +		 * If device_attach() fails the range may still be active via
> > +		 * the platform-firmware memory map, otherwise the driver for
> > +		 * regions is local to this file, so driver matching can't fail.
> > +		 */
> > +		if (rc < 0)
> > +			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
> > +				p->res);
> > +	}
> > +
> > +	put_device(&cxlr->dev);
> > +out:
> > +	put_device(&cxlrd->cxlsd.cxld.dev);
> 
> Moderately horrible.  Maybe just keep an extra local variable around for the first
> use of struct device *dev?  or maybe add a put_cxl_root_decoder() helper?
> 
> There are lots of other deep structure access like this I guess, so I don't mind
> if you just leave this as yet another one.

Yeah, it's difficult to have symmetry here, but I think I'll switch to
using an @cxlrd_dev variable so better match the get with the put.

> 
> 
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
> 
> ...
> 
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index a8d46a67b45e..d88518836c2d 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -30,6 +30,34 @@ static void schedule_detach(void *cxlmd)
> >  	schedule_cxl_memdev_detach(cxlmd);
> >  }
> >  
> > +static int discover_region(struct device *dev, void *root)
> > +{
> > +	struct cxl_endpoint_decoder *cxled;
> > +	int rc;
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		return 0;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
> > +		return 0;
> > +
> > +	if (cxled->state != CXL_DECODER_STATE_AUTO)
> > +		return 0;
> > +
> > +	/*
> > +	 * Region enumeration is opportunistic, if this add-event fails,
> > +	 * continue to the next endpoint decoder.
> > +	 */
> > +	rc = cxl_add_to_region(root, cxled);
> > +	if (rc)
> > +		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
> > +			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> > +
> > +	return 0;
> > +}
> > +
> > +
> 
> Two blank lines?

Just stashing this here so I can introduce a spurious whitespace removal
in the next patch. Will clean up.
