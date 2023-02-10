Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6E69297F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 22:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjBJVtR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 16:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjBJVtQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 16:49:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E702E3D09C;
        Fri, 10 Feb 2023 13:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676065754; x=1707601754;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dyn5hnxL/2Df8dOOBwX/hrPjoK9QSALxCR0HdlRDAKI=;
  b=R7Qus9h+CkzC3CD5bX/tdCSi/6NV36Hk/8YdPdfbtyV2EC1GViLyu6H+
   ZQWA1gytdJJJ3mZrgS41JHEiOPw/10A1XtIOC6Dml/D/iyzFKJl0Iaw6A
   deSTdsyz9uFxKydAUyTiq+CICmaySRKZyK1VL0IrMS7BOTZi6eqOY4wdH
   WmspUn6MHKUp7KhHl039XQIjG9Bw2uKdYfS/KYJwLCk7LujZ3g1BWbjfj
   U/tEGUqyXoofYHIv5HvkimF11jM2wo5DbG6HLRu/VvdMdiBsWOh5Xabwr
   sBOnCl2TTpfEZsAOdy9SV4MrcIJws6dRftGQJB1TBOPCxCCyXFzVwVSch
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329165403"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329165403"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 13:49:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="792112868"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="792112868"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2023 13:49:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 13:49:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 13:49:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 13:49:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKe7DzKngUr7aGmpo8/sS4SqEo3w+hPZ51WAwlhPSGTzRLVhki6l/PHJI4f09AhmscTqz720SZBVMTt7nPoVKahP2F0msGZMRVgdYkE3nkE7skriUosETLYZ+/gKpEwMfOfaLjygsBTADCQoXGZWAUu0tCQ86IrDKrac/onrgV03IfKhyNJiuCMRiVFwj6XVP10WxpYde+ZOe433tlrxsYQ7m8ZAKz2glTd4VoH3eZMFOstRMcIlvIL79kZpOtBEiGzI/K3hUzgLUhNnWvyDOz9eHNZ1MkIgMsQjV4jzuNpwg8JRwlW3sr0c5b3fXNhmo1bnIxR08eXsq9z3o4xbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Esn9TcCGy3H/sMKfKPwQNp66GJrsPK+pyctETfAdeE=;
 b=RhK7iho/oUwZUVwuTMSAL2s6QKMchwlJwpRA5qQb46Zv6B5u+asok7jWMW81oyBCOzeelOAbOhXlpkTdMwNUu8r/1Y/y7+3RNwk8Y8ctlK3baxOKpGds1tB/J6VtLnrwgDP2tibmfXIkJbG0Ln0YjZkkIo+Teo8MrVJS6WimZs3roOoJafQHe9kwx1gGzF+Kxa9fi0ZE5ats2qNAALw7T7BJjCSKq2Kf/n8DNmd4dfFqnb5FqYN5tuJb/ujenp0RrX/NUaIlH+0Y9KOxOG6EIwoXeYMxKKRUie901Heoeyspv17ZVYzu73HYZ9Av4Imdz86TtYMQBGf1WOMyQg4F+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 21:49:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Fri, 10 Feb 2023
 21:49:11 +0000
Date:   Fri, 10 Feb 2023 13:49:08 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Message-ID: <63e6bbd4b5ec6_1db5d0294b6@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
 <20230210180958.00002e5a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230210180958.00002e5a@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9b6502-d80e-42bf-253d-08db0bb0a4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ycm4vmUFREyN3+kU4yXLgtUJUoPqE2ij4HiQF0FH5j3NLtFOZRVp2suzcstOU6f11RwEHYiA7IT72pvo1DqBZDQ/695DkkicT8vofFwbrQQyrVBs53f4gF/OqNqhbOcRIZvY3nZ4qjrS6QLnYm+JAp5kxVvWIpzvoludLJqM4zDpWLirXlztInpJVG6hcVjmVx96wZlcDzq+cTvm+cwsErjFCKuTWGJHJW/gXytcekhYTv/mQYAThdM44qyHHI2UPqYa4HqlJzIXcvS75LPbF1NbGRgH3PFvLT2erk7RSYglTGyueEkdRWAhkT6mB/HxEOa1ne0jI3h3L3zp3bAiVoppSV0wqBQzGrYq9kdbYKRxj53AAIaLKM5XJPGr5AcJuMTdBeq+OYhQQy4DuStorRvATdNI2Dzfhkv46Gkp/MHL8L1NJ+u2DZCcKp9bDFBz8f0GHsBGD/aDAQTA7otfNgLuTVEiwInB03Q3QcMHBQwFjks0RBBmk6tEfBUB8KZxM9/7AsZ00wYO8XjNDXiuVTFIDp1M4ze17w2S/LspcwJ0WPm9TvxpmjM7WQBlDudxQJNcn6Nepf20ME8cw7pTmfXmUNLNYRlU6xRsGdu5O/+OEI0JBnAW3tnqXDM7em+IrEMw13LJjsgT4km+ZBcnlp+HEWp5YIKyII5mEhm9VEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199018)(5660300002)(2906002)(83380400001)(66476007)(6512007)(82960400001)(110136005)(4326008)(8676002)(38100700002)(66946007)(8936002)(6666004)(66556008)(186003)(9686003)(6506007)(41300700001)(6486002)(478600001)(966005)(86362001)(26005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qeM1VfVv3MKMHZbj/k2M7rPSh9rochlDZIY188YDfv8kjyseLRbHf869eX5B?=
 =?us-ascii?Q?7DhRO9NHCgn1BGbh2j2/Zg0wMMr9PP6L1WrjLqDfM1EBMSn4QNqVuQaE+VWe?=
 =?us-ascii?Q?ANFedpV4QFOLnJ9WwlyrA2EHFJNrkF4CgjZC2WoX0hIlTquINgE9qjlNyqTk?=
 =?us-ascii?Q?KrNQAowmZ18HaFot1LHwFl/W9gDf0Wy+5NR5qThm7/9SrSTyla3JxEFG2NUJ?=
 =?us-ascii?Q?MTw1F7U+4aN8kDi/KDin0SLaufhozn/1VC6z0AXGywxIBCKNRd4J0+uGKIIE?=
 =?us-ascii?Q?RBUmsZFa5afPWc1IFM48YoAOLNme+uGiuJdR89jUPRhPZS6cQDriLRJFM8mG?=
 =?us-ascii?Q?8xbr95dv/M19Z5B/PIhjSflAVeGnG8C07C5eWFykwa9eSOxxiyRqTu7UTm33?=
 =?us-ascii?Q?9A0E7MT7e3T9Yqig2waGxUgqEaIWcjnp12s3uTy9xZS40XLtmjDm/Grlwnw1?=
 =?us-ascii?Q?BABskFVeBLpp2FtCij+CFkZ7yoYEpSFztxbqQyOIOdDmFKhGtIf58vwL7zOi?=
 =?us-ascii?Q?v5HGsYiaCMlYLEJJpPSYBqNPRW2mgY4xHsb8rGF5k6IXGZMQSzEzsGCBd6GB?=
 =?us-ascii?Q?jFE4OTSt6CQz642gA6Dm9cD+aMxp/fKwk3aNe/H2Fj3Rdt9hZQjhS3+YbCVb?=
 =?us-ascii?Q?d197soHmo2AgVSLvD0+OujnVJiVMNN5nfyy/JxO8s7+hKIjEwtIZw0sp2RLw?=
 =?us-ascii?Q?Wl5AJVOJzzqBMeCx1S1I35qfECLuPfff3sDavGtHULrh9+rkOeuGqwqSOmkZ?=
 =?us-ascii?Q?LXRXuvr1W+2U6j7gnCi4cqW2lxn493G0BkcdvkJfj54Ihl/hLirxPaO0cAcl?=
 =?us-ascii?Q?kD7wSWYHjucSXhaszA/UdmPK/yXi+21Cue7QrkQ/3s+XIM9zMHURSWy17Uao?=
 =?us-ascii?Q?cUOLlee86nnEBfRy+6sSMSuGPGPWG2G1OAO1jEqg1Iue+tEf2zPZ059rsbya?=
 =?us-ascii?Q?JZ+tnPZtwvNG9/AgO+1xsyvP0KdF04AJcCGd7wPArW92px72ab808rJdJ0xi?=
 =?us-ascii?Q?upIP5EnwUX0+WahK1mpWREayDoyPYvoKNOzsNzkWjwdx3czCuKMv1KW7UNFA?=
 =?us-ascii?Q?kvVjeOHdV7F2moNMt5UmZS/SpA4q6M4/rwaybNOJWUdbzHhK4D3pKmbN/6+6?=
 =?us-ascii?Q?qomaJw10T65zxh+EflaCvQki41+QLSqW5UL3y8twQISJ/y3/csylDr/+htnJ?=
 =?us-ascii?Q?e7WHo/KlXrIkKkBJK6pIfjlMhdOwMzcciFtqUzWwgmX8kMmHdNF+MqU/Jyg/?=
 =?us-ascii?Q?Ixp1KXtAa79usCxwKW1e7PexuyMAUd0z5tMVH7UD4pOs1Di182xb+jFPlQ2s?=
 =?us-ascii?Q?co7cZO1vf8iDtx4/u2QfVwfHjIx09MFJfUrsw4ohXN+Tvx7IQg7QLnxN7Mex?=
 =?us-ascii?Q?hHQrm9fsci3YmNLMwr5I/nM7M1Uw/W0aaJAlQgI1/0C0lVuG7hfdb7UTjBjV?=
 =?us-ascii?Q?Sg54puSslCedreOKC6VM/XRhn5BLqVz33Ya8/cEtvm+GIq8mNCmO8+NskxHT?=
 =?us-ascii?Q?pyKQYG8h5LK5hzvHeYz5l5lhzO81qQW6/BCiGt61VB2feAZz138wS1PJiFWu?=
 =?us-ascii?Q?KIA5/H7kg5VaYfkzKXPtzoESNXEYx7YTMWXW72z6tlJtSciQ+eVhqt9sWnjD?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9b6502-d80e-42bf-253d-08db0bb0a4a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 21:49:10.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIgmLqnNB3+g07IQI+m5nNF9gdB+GsSD/ahai+x1x/FMsN3lm9Rsi4nDhzRupsSdLIEi3Qb44UjI7lKZb8OEVaFDzvJlWno49Ge9EtM5IBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
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

Folded the following:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3f6453da2c51..1580170d5bdb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2479,16 +2479,16 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
+	struct device *cxlrd_dev, *region_dev;
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	bool attach = false;
-	struct device *dev;
 	int rc;
 
-	dev = device_find_child(&root->dev, &cxld->hpa_range,
-				match_decoder_by_range);
-	if (!dev) {
+	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+				      match_decoder_by_range);
+	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
@@ -2496,19 +2496,20 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 		return -ENXIO;
 	}
 
-	cxlrd = to_cxl_root_decoder(dev);
+	cxlrd = to_cxl_root_decoder(cxlrd_dev);
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
-				match_region_by_range);
-	if (!dev)
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+				       match_region_by_range);
+	if (!region_dev) {
 		cxlr = construct_region(cxlrd, cxled);
-	else
-		cxlr = to_cxl_region(dev);
+		region_dev = &cxlr->dev;
+	} else
+		cxlr = to_cxl_region(region_dev);
 	mutex_unlock(&cxlrd->range_lock);
 
 	if (IS_ERR(cxlr)) {
@@ -2524,21 +2525,19 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	up_read(&cxl_region_rwsem);
 
 	if (attach) {
-		int rc = device_attach(&cxlr->dev);
-
 		/*
 		 * If device_attach() fails the range may still be active via
 		 * the platform-firmware memory map, otherwise the driver for
 		 * regions is local to this file, so driver matching can't fail.
 		 */
-		if (rc < 0)
+		if (device_attach(&cxlr->dev) < 0)
 			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
 				p->res);
 	}
 
-	put_device(&cxlr->dev);
+	put_device(region_dev);
 out:
-	put_device(&cxlrd->cxlsd.cxld.dev);
+	put_device(cxlrd_dev);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d88518836c2d..d6c151dabaa7 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -57,7 +57,6 @@ static int discover_region(struct device *dev, void *root)
 	return 0;
 }
 
-
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
