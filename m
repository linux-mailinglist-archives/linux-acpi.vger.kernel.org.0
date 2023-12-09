Return-Path: <linux-acpi+bounces-2252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729180B0C4
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Dec 2023 01:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350AA281A59
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Dec 2023 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD75369;
	Sat,  9 Dec 2023 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LqAKh6Dj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47986171F;
	Fri,  8 Dec 2023 16:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702080457; x=1733616457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zHjZfjwmeo5m62q2H7HEukvnsJDgAhtfXO6lPkp4JQw=;
  b=LqAKh6DjuD8espSZ9cxAwiK04EVY0WTdUhd7aGnkIMkHqGcfOifjUxx9
   RRdjm2lPtCRGdcaeCYTJ5ptAg1y7MLBxBGPjl3GNa/o4z/xVd4hyYBf0X
   en8ycceDdXJDnpSNBeyhgw6PQvzUv0P1pX7aZlnYhmdi3DqzXCZ2/59yu
   EbiAnJ2kNRO3yumdCZRqZ6V+qGFC2ixaimXjLsSBsJTAwSIJEsvmZqeW1
   nbvlXtSVKQCNx6SMoXyhMG12crga0f8tSmTVKSkNXyvlHd1wX97gkxS+z
   bU5eOviVoMfC6o/9S0R0btf9DzmCjgd+X1JzpfIVh4q3O0MRek6O9fS/q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1565989"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="1565989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 16:07:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="916128988"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="916128988"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 16:07:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 16:07:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 16:07:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 16:07:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFGR94d9Bgm1EeSZzqANt026tfJ7m0EYLTpeTEfSKCCWaxsw/QZ02Uuvse0lRqQYHxFVg956uGEiFX8SrVy3TGBZMOU1ykhIggdNPoHlr2Wk1yfG7PddXBFxCPliuaNR5j/WJLBlzyRn4vKniwYxjsdmdIkJsl0HLGsnXO6jP53UC4+/f8JxnTFii1M66yVL8He3Eva5Qd5ChARhpP8EeWUP8sJryU+P/HOmITvN8tCzfv0ylKVtXkNUvwbVxmuYYfU3w/vUZ32JjkbkgngoG2ve2c+EyLT4qwHHmxnD+h9/5mbb9S9MP4mZqk8/67cIX9qNMWCKfO7Khyd0jbqCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTFuhQnfRMDUXfxEDrEQtYEMBYNX+4o53hOElTO2XNk=;
 b=QOkrQkwGY+FrJlxM/gcgWceCF+3yBBk23u5UWXylufhwuVpB+/KpEVU7UPC/ojp3QizKhJIYfFfrb/YNcImUVFqOZkSRqisjLbOu4mbCOUARJAWHw/GewUrdoSejUUy4aNLdqxIGEQfWzF63wNFv7CEgKxW3Yjr8FYysGut94ZoEt/MPlJeDbLlDrgQufGr+SdCG05qGWbHraj1mo7bHwhqm4WOEOOWlJ+k8Vx6FmBEzdhD7b69Yq3Wv402Q7LoKXWUgi/dzzguGdSeJnsAhNwD7F3vapfbstvTBo9v/+ptjfjvPH82H2HaU1aPlv2UX33cWS5Hsx6js3eAJwv5R6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Sat, 9 Dec
 2023 00:07:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.028; Sat, 9 Dec 2023
 00:07:28 +0000
Date: Fri, 8 Dec 2023 16:07:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <yazen.ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] cxl/port: Add EINJ debugfs files and callback
 support
Message-ID: <6573afbd896f5_a04c52943@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-2-Benjamin.Cheatham@amd.com>
 <657251b0517bc_45e0129418@dwillia2-xfh.jf.intel.com.notmuch>
 <359bacbf-94d9-47b8-915f-dbf321cf0a9e@amd.com>
 <65735a0e595e_269bd2948a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <4b239b40-7a40-4261-8472-1bda0cbb5fa9@amd.com>
 <d40c1ab0-6edf-4c1a-a7d3-d28504ccf7f4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d40c1ab0-6edf-4c1a-a7d3-d28504ccf7f4@amd.com>
X-ClientProxiedBy: MW4PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:303:85::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: cb643adf-df9b-4f67-6760-08dbf84ad48d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeEow4aPqdDtIZi18E2IE/lWcUb86WJbDOug2XcBqWLF6WORJLZpIEI//aDE208rlpZj3olKxeB5I7r6qqi6bgZGhfSdsF5hUNNtFsSlA/32nQihLvyBeVnFtVf+h0em5tZ3llqdA6WW1A2VS8O2A1fE7A4IlLNm4PWV0AtzC2qkLfkucHKh2TvG+pcCljCMfAtfHUmea91dnghHzqcJ24oRDKwjEyLppX+DkpvrTGMh3LMz8hXgRJP0L24Si/Jbw+HzHuQG8upIzvfmEpUN7tATQWxDEUqndpSRITu2b6pxWKIP/nvjJQiOxlwVSeruWRADr9mu6PDmraAoQvj72CQexMnh+gcwpyKsu4W2H41LNAHmtMMSWGVL8b5rgCzbn58RIl20a6n5N5bqcSNLT9iNJip4mTDzW+6qgDz61qDM6wrNGwpBcbu6d49+zKcjJp01yAeHHx5dkSQHjWqp6GcOUog++pWNzYkt5sk3AeaB+LlpYFa2YLq4wi3yRzBgbUMU0IHJLCezZ9J+fcVAq9/GwH04qLrTgoW5RxYJ/S4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66899024)(26005)(478600001)(53546011)(9686003)(6666004)(6506007)(6512007)(38100700002)(82960400001)(86362001)(66476007)(41300700001)(5660300002)(110136005)(66556008)(66946007)(6486002)(2906002)(83380400001)(8676002)(8936002)(966005)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w8QAxI3Ges97mkoxG6RRJ2tC+pVj0u3YLt5sqAHpszQtNrsGUfPhvkUmUcNI?=
 =?us-ascii?Q?H92scEwI9fAWOg/3pmPVpHVnGZXrv+4BRoscstYBOX1zRKMwU20s0u/BKxb0?=
 =?us-ascii?Q?lpdoY/RBVeJ6fMTeXZc3TNcvmuEzm7yXbB9Rk0W0a4LxBYHL8BZNb7TDPPuv?=
 =?us-ascii?Q?WSKDOayrKQSy6FurcPdMi6bwL7NofEy5CTHt+zUbQh59WZVCOPAdWn7esMJ6?=
 =?us-ascii?Q?PL9dtGbIiQACPzMuymnJsaLGdhAPhDn10bqhxiK7hceS+WUR8sfco5doz3hf?=
 =?us-ascii?Q?25HEiTSmNkAD4bDWGM8t/kmqxN3QRHMG0/txh11kGl0Sv8H6jr8ykPtOx6Di?=
 =?us-ascii?Q?j1DpkHwrbYQQT0A8GBU4JsaIGBfTFt7aGjFb4nZo1XLWzYOUEQfCdC/zA55k?=
 =?us-ascii?Q?QXPjRm1N845tEswihhdfbbyeWm0c7JSg8CwEYSf1a6vmJJg/9gvOddr5qTBd?=
 =?us-ascii?Q?YQxywpeZi+WYdG9wBezWTeUU8lxSO3lkxq2WhF66Fa/c5jwjpEbOOjIi87sH?=
 =?us-ascii?Q?tjRyJSYHITSDOdJKBJBRCp+0AivMhVZDagqBpaDrA5gPtCF/emH4w+iXAV1o?=
 =?us-ascii?Q?sS/xMcjSzCp/mrb36YIM9BKtAAZ34T3qvTrNrzZ6+hdCP9L+QvlSOws2/8ER?=
 =?us-ascii?Q?e2aJcqINpfuABogcad+9P0HeaAY0etw+Oz5t+PiUh5qS+Rw+AOOKMSLbTsy9?=
 =?us-ascii?Q?t+Pel2HcjDMooSmta2mnxgnTDYfVMChljhnqtFS+L48wWEJpCikRKluOVcBh?=
 =?us-ascii?Q?hcWGHcS7IC7kJZn8qt5yjlQwDtIpl8AecL2HAlxCEpP9yDjqWvpUTscrbFnl?=
 =?us-ascii?Q?XC42fd7ST1x47Fq6gQPJtggyZG1oIN0vXO9mAoRXrVNRXripqmewfwf+/7RK?=
 =?us-ascii?Q?EBPUzVQv2mnB9hpFLcnZfP6Df2/M//KwL27/H3TZnUTyUXblyKsQHJ7rgs+a?=
 =?us-ascii?Q?V6hW/QL6DL2sC04Fg+m2bQTXQW+EVC3ppkNiW50gHbyq7vk29h5iEe5D4niJ?=
 =?us-ascii?Q?vP4eJW/RSeYIBpFXq0wY/H9CHmimUGP4b6kF9aGXDWJCKBJKSdkthE04Rf3b?=
 =?us-ascii?Q?VjNes6xhW0kbrgmYdCQF1t8+/2eNbq67pFEEfLK2niRzQYGWSNI8LD4U0Z4w?=
 =?us-ascii?Q?l4gcoHGmpQ17IDDDHI2ZkaJyaNe2Nqrju/bWf81XooERHkkRLhvpbtiqAL7R?=
 =?us-ascii?Q?J4rkkUPLb3K93q4RddNIKqAohi7x4XtNxqLuynRBgCebrOIqewkko/nRF2NX?=
 =?us-ascii?Q?FGvfqhj+ut0VOTXlY7CsAIvsSiqZjI9C26W/6q4rOkJ/kHQlLSI+qnwl1zjR?=
 =?us-ascii?Q?64pB0g169FSzc9kGFzdQetJSWp7YMRSqqsLfQSMeffBqtnjwd2akKusbj0SW?=
 =?us-ascii?Q?Ur/eO67nkWDcPflouL2lo9LYlabTsYaOnbjh0wcSWMOlqIbrL/f3n9LPJvug?=
 =?us-ascii?Q?a8NrUYOK4nP78fvVO+E1Vsi7d49YvVQSR1zk70MbaazdQdgd8Q4RM3AHnSrw?=
 =?us-ascii?Q?Y+2EeLXRwmNseYt8DQZtqJ8rnJmi0JtNXigPeVCoDbSpx+V/d+/9VwJxxHuA?=
 =?us-ascii?Q?dWDlSDr7I0I20AsLRudM97PLVDAoQPGjVlrWaVpjRJL9ROrD2N+U/joZROpV?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb643adf-df9b-4f67-6760-08dbf84ad48d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 00:07:28.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT6/Qnzldp1WKflliXDV3CWrAZIZfUKoASznBaqCAnZ1fpMHFVdMYuD5PVDXfPjdcN+ghQkhCw3ICRi7FKhpkj9FM/riHd+tqBiZ93ubiO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> 
> 
> On 12/8/23 2:35 PM, Ben Cheatham wrote:
> > 
> > 
> > On 12/8/23 12:01 PM, Dan Williams wrote:
> >> Ben Cheatham wrote:
> >> [..]
> >>>> This can be simplified. Have something like:
> >>>>
> >>>> config CXL_EINJ
> >>>> 	default CXL_BUS
> >>>> 	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
> >>>> 	...
> >>>>
> >>>> Then the documentation moves to Kconfig for how to enable this and the
> >>>> CXL code can directly call into the EINJ module without worry.
> >>>>
> >>>> It would of course need stubs like these in a shared header:
> >>>>
> >>>> #ifdef CONFIG_CXL_EINJ
> >>>> int cxl_einj_available_error_type(struct seq_file *m, void *v);
> >>>> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type);
> >>>> #else
> >>>> static inline int cxl_einj_available_error_type(struct seq_file *m, void *v)
> >>>> {
> >>>> 	return -ENXIO;
> >>>> }
> >>>>
> >>>> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
> >>>> {
> >>>> 	return -ENXIO;
> >>>> }
> >>>> #endif
> >>>>
> >>>
> >>> I had to go back and take a look, but I had a shared header in v5
> >>> (link:
> >>> https://lore.kernel.org/linux-cxl/20230926120418.0000575d@Huawei.com/).
> >>> Jonathan recommended that I instead include cxl.h directly, but that
> >>> was pretty much a completely different patch set at the time (and the
> >>> header was under include/linux/). That being said, I agree that a
> >>> header under drivers/cxl would make much more sense here.
> >>
> >> I agree with Jonathan that there are still cases where it makes sense to
> >> do the relative include thing, but cxl_pmu is an intimate extenstion of
> >> the CXL subsystem that just happens to live in a another directory. This
> >> EINJ support is a handful of functions to communicate between modules
> >> with no need for EINJ to understand all the gory details in cxl.h.
> >>
> > 
> > All right that makes sense. Thanks for the clarification.
> > 
> 
> Ok so I took a look at implementing this. I don't think this solution ends up having
> the intended behavior. Using a shared header and the Kconfig rules above introduces
> a dependency on the EINJ module, which I was trying to avoid by using the callbacks
> since I don't think the CXL core should fail to load if the EINJ module fails.

Good looking out for that. However, if EINJ is going to be offering
services to other parts of the kernel it needs to be better behaved as
library module that can export symbols independent of the platform
specific, not software, error conditions that can make einj_init() fail.

> So, unless you have any other suggestions, I'll use the Kconfig rules above but keep
> the callbacks (and also change the EINJ module to use IS_REACHABLE(CONFIG_CXL_EINJ) instead
> of IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)). I may also just
> be doing something wrong (most likely due to late Friday brain fog), so let me know if
> I got something wrong here.

I think the dependency is ok, it's the myriad of failure cases in
einj_init() that are at issue.

If einj.ko was loaded relative to a platform device then it would
already be the case that all of those platform specific setup details
would move to something like einj_probe() insted of einj_init().
Unfortuantely, a full refactor along those lines would probably yield
more violence than benefit.

However, something like that can be approximated since einj.ko, before
your changes, is only ever loaded manually. Just require it to be
unloaded manually unless CXL has it pinned, something like the below.

Open to suggestions from other linux-acpi@ denizens.

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..9c179766af88 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -137,6 +137,7 @@ static struct apei_exec_ins_type einj_ins_type[] = {
 static DEFINE_MUTEX(einj_mutex);
 
 static void *einj_param;
+static bool einj_initialized;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -684,7 +685,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
-static int __init einj_init(void)
+static int __init __einj_init(void)
 {
 	int rc;
 	acpi_status status;
@@ -782,10 +783,30 @@ static int __init einj_init(void)
 	return rc;
 }
 
+static int __init einj_init(void)
+{
+	int rc = __einj_init();
+
+	einj_initialized = (rc == 0);
+
+	/*
+	 * CXL needs to be able to link and call its error injection
+	 * helpers regardless of whether the EINJ table is present and
+	 * initialized correctly. Helpers check @einj_initialized.
+	 */
+	if (IS_ENABLED(CONFIG_CXL_EINJ))
+		return 0;
+
+	return rc;
+}
+
 static void __exit einj_exit(void)
 {
 	struct apei_exec_context ctx;
 
+	if (!einj_initialized)
+		return;
+
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
 			sizeof(struct set_error_type_with_address) :

