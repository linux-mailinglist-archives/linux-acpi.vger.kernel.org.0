Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588FA69FE5F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Feb 2023 23:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjBVWS6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Feb 2023 17:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjBVWSt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Feb 2023 17:18:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14E469A;
        Wed, 22 Feb 2023 14:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677104306; x=1708640306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dy5EnaRDOp3Ku3VThQS0qowUYay7A32JoU6kRDQ10gQ=;
  b=jR90Gty9xd3qAgFXen9HPkRdfywAUxbVW2ls1sWtLd9+y2BsFN4Ln0mF
   2jdgEwpB2FsUpzOzYHrvbBZ5U9rfKm0YoAggv5B/Y1U5QV77s3+xOCZzp
   hmM8f4PwiNi2d99muLEircY4mk3h2BSaWCZS/TowjrAV2p06j4/ZQ34ZY
   kfikGccLA9SGt0yuoNOiB0bdOQAQ7UO+PlAhxTWsQ4j+QyGyqChJSDmzG
   ul/mKAPpyoN6rzoyDjqxaruGZpZOY/nRREdJFKaXUrMKjriCAVNWx6eya
   if5RrB0wKR0133zljJR2Kt/6MDdoN98eXhWcyc83OaDEmjcauwqSAthbi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="316780407"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="316780407"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 14:18:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="704614112"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="704614112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 22 Feb 2023 14:18:15 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 14:18:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 14:18:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 14:18:14 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 14:18:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUAu9LH91o+vYG5ppbeLrSDmjqIygSmu8UBhsMzu0JSAeMfCeZZL4o2n82sIvtm2sB0MNryl8I/QboLiPrunFhS6xgONecD00AIMy3iEAsEY0k2awehkDZpx01fUh7Ieoxneae9DsCmXcEW3u2OWJsSP6sgqXHheBhKvwWZTE9MxYp2JfhYPWkq4Lsx54Lgjui8Rp37WyxUoVyI3U9yq/u8urkGjzU289aQT6f8us2UISx61USKfXc7t1GLpzlHYxT1/vbQ5mbT/w8Lxu7ctkhtYN1T3eQHmOWCnTtkmCHI7kDh94pxT9an6XGXt+owPM8YNZA4T8qbnwqPDxFo54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pIZOtCs3GbvReSnpMhVHuc7G3rHBPdEqivzWP62Yyw=;
 b=Z2rlv2KN9pNmYv0PFQwksmSviSRpHkzO9U9j/8yAgzK4KCq8UGj/KOvKA96QcsHNtp5dM3heGObNHeqcSU6fC2wd2WwkhGBdUo6EHeyZGdDs+lrP/+/poWzA8yekO3SlyqMyrFBX4bLnnioCuA7Jf8lOfusaAO8+4jOrzpa/VoHIa1/qINbHi4z7RmbwKPWS+pfzvyktfTlB+1B8cX0j6M1ko5kN6APsHdukXhXDvqWqfPmUisqxGTmMEyKkbQgV0+rauUpZoX75g7omVo3iazBeL/E8cXmQl8HMgigji/jfaPtmjFxXs06slYUgPf38DFxiaHZ5BRNGi7oy+FmcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7884.namprd11.prod.outlook.com (2603:10b6:208:3dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 22:18:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 22:18:08 +0000
Date:   Wed, 22 Feb 2023 14:18:05 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        Gregory Price <gregory.price@memverge.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "David Hildenbrand" <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v2 00/20] CXL RAM and the 'Soft Reserved' => 'System RAM'
 default
Message-ID: <63f6949d71917_19f329463@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
 <Y+p/2S4rnrOOyZ8w@memverge.com>
 <Y+qB9T/PCZ6TpYlK@memverge.com>
 <CGME20230222214151uscas1p26d53b2e198f63a1f382fe575c6c25070@uscas1p2.samsung.com>
 <20230222214140.GA1276133@bgt-140510-bm03>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230222214140.GA1276133@bgt-140510-bm03>
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: d37f597a-4c1f-4b26-c7f6-08db1522ad26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7LlIwe613E3sd88gMG2+aVSzNT1yqJpXzmUvZNcfwxhzffitc7Mf0X+Eeu280+8IxSiyObhQq2ExHz1hhSpPUWYb2s9/3F4tivNvKsrD8kO/jcs3bSXgKY7OTVnoRFbG0U+9g9gC5JBw6XCegbYsg5FxF/Ps2t4dIGvlsVzbSsc6fPUHfVjAS7R6rp4VWmIm3c7Lx5aQ4TULYogg8cj+EeEcaeb2NmC5SVpCtFDm/o8CeNnnsARdQTRSVkDQJ/7YCWI1QycrsEQTdC5Oom/dUU9ju2FDVyJ9GsS7jD5+jOZC0o2YVhNLLokMjmsPEzIWGYdM1XjRgOwA6iP8K2tW4EiHgiUeB1WhD2dWG6vzPjlCzqVxs8BemMbPETuiEvquigoPUP1sxSXxix4intscFdHwy8uUncFT3hK1yECnu/UVWqQkhI9YBSSeEiRZ6JzC5ouHxs29WzPwPYJBKSNKUHSkzmer+5UePm5wHi13KdqXlEdz3UDOSOHs+QbXEPlFn963KH9yGkAicnc0W8uGEQh2FkLVmcxUEUORtOJVg3GBms5I0oc8Vv9bDhbv26zuvAGVVQYbJbzQIkkTEFRPV9TWErnH3V4Ufpr5d+HZJMUmjy9WmABwWgBAIsyKattm2tOA3tC7qEoPwqZX7y0RclA6bZVjBP1pFj2uOLfOQ5t0qYrjrXnq+px+WTciuwB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(38100700002)(66556008)(66946007)(66476007)(8676002)(83380400001)(6506007)(26005)(6512007)(186003)(86362001)(9686003)(6666004)(82960400001)(110136005)(54906003)(316002)(478600001)(6486002)(4326008)(5660300002)(2906002)(8936002)(7416002)(41300700001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/XnhGlWofZ3vRSK6uOH+i3gAMXBDRAhiYuYSRgtDdEzIyUiwvde+U7S6YL9?=
 =?us-ascii?Q?Z1tTgOH303DSvafFnaOkEcmM8DqX21rnuY47oEq1b0ltMmu1eaID0qHT214V?=
 =?us-ascii?Q?HUa0CvtD+Dm3hdnziNYLTgJp6PetJyyg7weyyPhIoIcTU00lr7mjq/57MQWA?=
 =?us-ascii?Q?njQ98ZfA+UF1pD+I0ZzbYbjSgQaq+/R+5HbHZ99mcvB1p6G7VxTBQbSdmZaB?=
 =?us-ascii?Q?wzlg35R3dHE5S75pqvQHKt6juJDhPV6PEPH1lZt+1UedANy6BBwVAvGZF8vM?=
 =?us-ascii?Q?JLirvv9JvCzBZni/wt+t5LFb5YLODDpf+dE6Q+KXDdERK9i5HgcCWgassmF5?=
 =?us-ascii?Q?P+4YMDGB51i4BPVenSQBytheschvIP3OLDmUlqM2YzEI1BZZULddd45K3mQJ?=
 =?us-ascii?Q?keBNmTXtuF4ZMrYYRnIdC38adA0CcSpHiNy3xUuu5HOhBzeREbBVNRbs1vbu?=
 =?us-ascii?Q?OJFXjiu5yTmZnDnwUxv35RT/ZgWtzb0ySvt4OU6Q0gCIkiHtknKnMnXB8ezQ?=
 =?us-ascii?Q?LV48ub5gidzK+Sjfrxl3gz1sJwd2MPPOP8yGY+Vjw2bsZGowe8e0Gm7fLaDj?=
 =?us-ascii?Q?KZ2P1FRlK5b5Bx3mGNLMXMa5dZ0Okch90v0lRqBljA9qCsfjWqG8EBLNEFu/?=
 =?us-ascii?Q?fHCFtDqMcsR5x7A8DFyZntrnU3z1KBdRR8p8bMZOZUCBD1KTi7X5ZqhVtIV+?=
 =?us-ascii?Q?HH6iDR12QvVhdHFINGPoN7jaOQJIvBEbMbgu5tfXwuRKkK8v6hACAYq9JNkL?=
 =?us-ascii?Q?THaBBv/tbV2nfsG37qZQ2RjBmvBjmin2+akLxXQlbbDmFhCmbDuVwO/ekW9l?=
 =?us-ascii?Q?SHJQv+yesLgdZsLEDrG9x8ykLQ8rxKX1GiuDuZXiNV0KI8wV0V8aGXaVgVX1?=
 =?us-ascii?Q?tqzr5DDfoPJ2OyJMxvn3js3bRFuJlGeQBURboGLAIZCiNE6UuG40JDwMSTCE?=
 =?us-ascii?Q?xxNgvFWsv/PGNwjo4OkfzijpbYAjVW4tF2oYtuT2b8Mg1L5gMNy8VDgfOOs+?=
 =?us-ascii?Q?fHOiEt3DINhIBEHG5x7CGcsSMe3nz3opqqAWUo51ruC58ZXNsxpG83pvqfjw?=
 =?us-ascii?Q?Ux2VzPpcF+0PN3jwKOHtAlrth82andJ/pTENgH9cWkjUF8EkV385yGdZb6d2?=
 =?us-ascii?Q?/cgJjoVM9fl5LPZA6bBynR+TCtj9K9wPONCDv2Ys6eyYJNZc43WrNPb9rey0?=
 =?us-ascii?Q?5uyvyI8VzTOyZY74lEHcXIOjE/G0syKIgwXwWynI9Un24c1A+8Wyla3WvGzg?=
 =?us-ascii?Q?cye0nHQ8FG4EBB7yW1fiHjy91UXlPJhX6lv6DoySMEvC4dfYTV3YARFpjNf2?=
 =?us-ascii?Q?NdrbqGAmzlNokFX2mKdR4YtiRslHDfKpiYNkSdJi0swkzkCPoeApQHxOVhMb?=
 =?us-ascii?Q?mdUCfYtStEvdQmKD8PtIaGdLRI2f03ztXjay2IEtboI3B6aTKVFCZRBnfCXL?=
 =?us-ascii?Q?zhND3QfSK6i5mJu6+vSxCJlx57eRBgX7OelTNcFA6rcRk27RQZS1ecKJBid4?=
 =?us-ascii?Q?T4l6lnh519fAfDI6ZeIN9muoRg74DtN+EJSG0wJnkK3LPaQPHll+cfXDa1I8?=
 =?us-ascii?Q?QBm0VhLboWIeNcTqzsagGobIhUVf7yPuAd8NWA4nfjHZoqimCTkOSIZMJ0vx?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d37f597a-4c1f-4b26-c7f6-08db1522ad26
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 22:18:08.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxcFgXNA/UQG5i/1iR8Fpg7K1nwYhiHKBleLT3vIt1hyBDSPk+fKZyJERlThuXbiKe2rXSSOy13zalL20gJOErHH1mZ3sUuF3X36Eu8jSW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7884
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fan Ni wrote:
> On Mon, Feb 13, 2023 at 01:31:17PM -0500, Gregory Price wrote:
> 
> > On Mon, Feb 13, 2023 at 01:22:17PM -0500, Gregory Price wrote:
> > > On Fri, Feb 10, 2023 at 01:05:21AM -0800, Dan Williams wrote:
> > > > Changes since v1: [1]
> > > > [... snip ...]
> > > [... snip ...]
> > > Really i see these decoders and device mappings setup:
> > > port1 -> mem2
> > > port2 -> mem1
> > > port3 -> mem0
> > 
> > small correction:
> > port1 -> mem1
> > port3 -> mem0
> > port2 -> mem2
> > 
> > > 
> > > Therefore I should expect
> > > decoder0.0 -> mem2
> > > decoder0.1 -> mem1
> > > decoder0.2 -> mem0
> > > 
> > 
> > this end up mapping this way, which is still further jumbled.
> > 
> > Something feels like there's an off-by-one
> > 
> 
> Currently, the naming of memdevs can be out-of-order due to the
> following two reasons,
> 1. At kernel side, cxl port driver does async device probe, which can
> change the memdev naming even within a single OS boot and among multiple
> time of device enumeration. The pattern can be observed with following
> steps in the guest,
> 	loop(){
> 	a) modprobe cxl_xxx
> 	b)cxl list  --> you will see the memdev name changes (like mem0->mem1).
> 	c) rmmod cxl_xxx
> 	}
> This behaviour can be avoided by using sync device probe by making the
> following change
> --------------------------------------------
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 258004f34281..f3f90fad62b5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -663,7 +663,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.probe			= cxl_pci_probe,
>  	.err_handler		= &cxl_error_handlers,
>  	.driver	= {
> -		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  	},
>  };
> -------------------------------------------
> 
> The above patch, you will see consistent memdev naming within one
> OS boot, however, the order can be still different from what we expect with
> the qemu config options we use. We need to make some change at QEMU side
> also as shown below.

This is by design. Kernel device name order is not guaranteed even with
synchronous probing and the async probing acts to make sure these names
are always random for memdevs. For a memdev the recommendation is to
identify them by 'host'/'path' or by 'serial':

# cxl list -u -m 0000:35:00.0
{
  "memdev":"mem0",
  "pmem_size":"512.00 MiB (536.87 MB)",
  "serial":"0",
  "host":"0000:35:00.0"
}


# cxl list -u -s 0
{
  "memdev":"mem0",
  "pmem_size":"512.00 MiB (536.87 MB)",
  "serial":"0",
  "host":"0000:35:00.0"
}

Although, in real life a CXL device will have a non-zero unique serial
number.

> 2. Currently in Qemu, multiple components at the same topology level are
> stored in a data structure called QLIST as defined in
> include/qemu/queue.h. When enqueuing a component, current qemu code uses
> QLIST_INSERT_HEAD to insert the item at the head, but when iterating, it
> uses QLIST_FOREACH/QLIST_FOREACH_SAFE which is also from the head of the
> list. That is to say, if we enqueue items P1,P2,P3 in order, when iterating,
> we get P3,P2,P1. I have a simple test with the below code change(always
> insert to the list tail), the order issue is fixed.

Again, kernel does not and should not be expected to guarantee kernel
device name ordering. Perhaps this merits /dev/cxl/by-path and
/dev/cxl/by-id similar to /dev/disk/by-path and /dev/disk/by-id for
semi-persistent / persistent naming.

That's a conversation to have with the systemd-udev folks.
