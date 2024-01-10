Return-Path: <linux-acpi+bounces-2776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7B1829303
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 05:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34ED1C21822
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 04:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEEE80D;
	Wed, 10 Jan 2024 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWO0HJce"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E127EF;
	Wed, 10 Jan 2024 04:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704861036; x=1736397036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3A6a5TwiFOECcztSm7mgNNg8SPuxFMiYpw/GhRBwV2Q=;
  b=bWO0HJceHUkh9Bp8u3s8my1tMKIl4GgutCOmC7TE/T84rFHr4uWlGuaE
   WAoIp+4sTDCUIdrh+GItCczBGlgdncVAQivLw7fpyok9TfRs1KyYFh8On
   uiHdKqMnbDiB8rukKKbaBa3fie829n3pvNTyEMeUR+6drtkGoMLptOzdv
   p3YkHcYkk4oKxu71Mt2UPxle664l/7k1OUyt5l6LKdWx7OVRhVCY1eRts
   yRyy0jhfvekuSsxBTjiuANVoURZ7LBmU9isGg6VlrGdeirjF6A7u6Pi+l
   etuBq5uPEHIWbCwaNmrguQXUyEDH34KQTksTZm1SlvAIOOYaCgbz0/uT1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5177177"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5177177"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 20:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="905389911"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905389911"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 20:30:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 20:30:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 20:30:33 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 20:30:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCFC5R6f325Ifr2eUJWnwPyuaLXMcrOmixvOAZ4GGqoiK9qQA4NergR357FNQyYzYynz9wUmBqv2KR8dvrHzZCXedRSFqkmCTitifwdo6YHJqVLS5cg+3fIXNcQiJ9IQaS0hmRieVGgAoC9rImBNz7mXGWaYIKg9T3MBNe1p3Twk4CYR5AaGV++nbWeb/6MJ8sHD/W3F3qrAFZkq1Xy8jdESaDAUNMYy2Xf/xFfx31v9YzHrI8RbelHzLDrcB3UW4rOHsG2MeDvKr0B+6BoEbqEyFYGzyizF4h0hkytZ7AGJOXBRLaqrR3b7BX8NF+rsbwwcK4YJv12wzo6rgjQgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piXOARPCuzPeY8R4tCrZmx4dkqvT/os2RCvsfjNlNrU=;
 b=d821m6g4H9eJXr99E7pq4s6Xhty//zgMcGV0Xt3KlHQ2wPEG2KxwPjCZ7uvwaexHNVL8CFYHxTKVJqZA7HWHnV0/D8fd2RLk1t5/S5YJGe8PbBYXRWwQn6nCUik1bhjIoMU7YIX+vrQjkT/OFv0Sp3SDSE5isjFPJe5UMptGFHluDOfkFqEsnpL1SDmuW6xFDTC4FAosScrJYkuPgLqEuJq1sVn9wYmOzpFY1z10hYNyMvpyH1njprYE2K7C/c/U5Kss21FB+ftA0GMCuRA5p6dfUGHXHGT0PKPW7EYwOqZfu33I8iCBeszyYQlX0TSQNqs005qYcSO3nxS8hWc5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5463.namprd11.prod.outlook.com (2603:10b6:208:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 04:30:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 04:30:31 +0000
Date: Tue, 9 Jan 2024 20:30:28 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: <xueshuai@linux.alibaba.com>, <linux-next@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>
Subject: FYI, cxl.git vs acpi.git conflict entering linux-next
 (for-6.8/cxl-cper)
Message-ID: <659e1d64dcec7_5cee294b3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3bf35d-8b46-4bb4-56df-08dc1194e161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW/RlUED2N6w/0vja3oDsheO5Ey+6AE2KWQGa/Js82/IEX+HpikgSXD2gpHneSHik2Agolzl/pLFOkR0WhVM2MUE7yIBcau+fxnncbLzmmNlEl0fTuW+G9EInf2S0+NJQakpH6w3lAB50KfeJLTCcnKdqLDxurKL/KdXheCZtN/nBLWnqLrABV/FM8iHyNYArsS+2T5OnyfAtLmhf0CyyUs+1NnN2RjcWEuKJ/4QxNTo+iqQRF7jL4hgI0RnDlA4ea+rf3np6FJ1ykJ/a0ydjFsy0p74yyDeHCWatYRZxatDsNK1KgkDOY6UWBjDT16lnXq59nje6ZYXdi3f8t6zXM157Ve6wOM2l1rKF+yFEEQkD9ApQ6z99CRQZTgTt6AXXoVB8kfgp0x3FOE2Slaz9HPdneNUGFaMjKjJkGqtJb+lpXr95Kx8kGfwGggblHrsj8y8rL1aQpHFhLeQAhFQG49oKxX67b7/yLtPCMR5UdXdSo37TPl9Ru0iIczbd1FhUMMQQtTfokgQObyteXefSW44lSnRro+t0Yd8G9ew74ZlLfpZykP5I3VsUVCvf64O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(6512007)(9686003)(6506007)(107886003)(38100700002)(4326008)(8676002)(8936002)(5660300002)(54906003)(2906002)(478600001)(6486002)(6666004)(6916009)(66476007)(66556008)(316002)(66946007)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?scFwZH22i3TLd/xsiJyWHWCnvR8T/TkZ03Dyal+Uau0QsQgrUtTdKJ8in+VG?=
 =?us-ascii?Q?z7XRY1jhnbfAciD6ZseDRRmlbETuWZVoqpPt2PAqXyY8Gz6liDaqNobeRklT?=
 =?us-ascii?Q?rTlon0qs+xzilSb1RQv5gFGf2blQ3DpBKVydpgCc2hukBM5NTXQ+sD7QO2zy?=
 =?us-ascii?Q?MpKKLco8HJKSZvJd0GY8wTE2jzQvIRwKwPD4PStUsn+aQKM6U2Cbgnej/8tN?=
 =?us-ascii?Q?Dqs08ZDLEOLJwN90DTN8l09MFcuW2pt5ubc0+tH1wlHCWf8FRamUrKEb5dJP?=
 =?us-ascii?Q?dFI0icfLtpsM9y0MR/mJA2I00Tt4cbYq8Y7rdmFcOhPys1ode4DiZBGVddls?=
 =?us-ascii?Q?gteWYuMpJuYlCyQ6ynhNMNcb3qEeN09u0ALCINZscehUJmm0m6aoIhCBoT2x?=
 =?us-ascii?Q?5pP+JYXws4/zcku2ioaFOPOXrtjPeO9drPjASIlFwpOBc1hMXp+END0tp5Kc?=
 =?us-ascii?Q?cb41kAuT5zKXMWiPGk98NsxtTyTnMPexxg1Bw4vhvliv/DzEHXjpd1qAM77z?=
 =?us-ascii?Q?QRL0aHU6mjsLggL1hFywKqlH3gIBx+7+WjVi+fvD99x1pzLFbjr8KMtUDDf5?=
 =?us-ascii?Q?t+H0YeomuB5A843wZJ2Pfco8wt/bpAgdmMdxIfUn9FFpusHhO0E6iA694ziB?=
 =?us-ascii?Q?IYwg9wpfEn23/gveqhC2ANYl/MOUF+pvPPYw2caJDsbcFTGe0av13dPBszd4?=
 =?us-ascii?Q?cReruyGQprpIpnh2QXx3jFIstA+VsVXKsK6rjkOMw1QApL30jKQDzIRFdHAO?=
 =?us-ascii?Q?jxPx5GqU1z7UgrC3p3NO6KVyNbv723jgadphYLUvqWcgh3uY0Px+5lJyQ9b4?=
 =?us-ascii?Q?+p/1xaAM7SzZ2cb/KA8Y4aDZs7LgqMjI661LNq0cBFjjaS8jrB7vIupXEDVi?=
 =?us-ascii?Q?+OiFv46P7I2GYW7p4di1sPdZQZPGwoAyur6YyZWgefRzm+MuSQrLMVOVtAQh?=
 =?us-ascii?Q?DwV5cR56zw3Pa7VrvRTLxNyVztQG/5nOlLb+BGt6q0eRi9qqrfQA2IiAY+CI?=
 =?us-ascii?Q?d20VsWU06hAw5mUFZ1XDr5myL7sUD667gA6JEe6Fm5o5ePCYFAwK0liZQ5Jm?=
 =?us-ascii?Q?5LpFPrSdZCSKuGH+UdADuEY9eZq64D4nYIbDIZjJ6KBNumVPsZs8H781wxp1?=
 =?us-ascii?Q?0V8h4DHKl5aDE3D8L268GzoYdgstYzCjP23fQ0Q9Pr6k4AJyOSfy9LLbJv1e?=
 =?us-ascii?Q?h4ifllusch52xOGpafbwk5ePck3MYUjB5QakZukrTpoqh3qzjGYMAafHJr5c?=
 =?us-ascii?Q?6cRIFiQfNfWmCJKgTwT7bkfWDglX0zRbtxLlE7NDGGbdUTEcS4G86Nf4rCWB?=
 =?us-ascii?Q?/McIz1srOy868N3WCCcxvANMAOFqJ2TOtqwAbg2w75CSF8FAIIu8kjQ/P6e0?=
 =?us-ascii?Q?qXl3Jxxun1XP3YGOKnTZcW+Rqx5S2eaUaM5Qdu/dqYXRZm5wQQ3ZEPbp1w22?=
 =?us-ascii?Q?JkICRbJXMFpkHhAybvNBOcEaQcuqjiRf1LA7p7IA2eIARr+iZid00M1+nKM6?=
 =?us-ascii?Q?RED+m3B0uRs+klEOvBgsPY4ljKrvqrWfr5wE2/R7kDErPkNCO/htq9m0mDPd?=
 =?us-ascii?Q?E4Y9ejOwACBVjXQGJGicM5skgP6owFlfWeTzOkkEQ9m+XsfqvTDlzspcr0bQ?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3bf35d-8b46-4bb4-56df-08dc1194e161
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 04:30:31.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcOeRVOFci5nswfGZypp0geU+pSnwyi0ZKtkStzLzTulXu7BXKdHi5ypTGbyHDSW7PKXz9HR5Iz0U2TU7lGZhtCAB2kYv2G7NRCXdYNF6ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5463
X-OriginatorOrg: intel.com

The final topic branch I want to merge for v6.8 contains a conflict with
acpi.git commit:

a70297d22132 ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events

...here is my resolution:

diff --cc drivers/acpi/apei/ghes.c
index ab2a82cb1b0b,56a5d2ef9e0a..7b7c605166e0
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@@ -706,7 -762,23 +779,23 @@@ static bool ghes_do_proc(struct ghes *g
                        ghes_handle_aer(gdata);
                }
                else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 -                      queued = ghes_handle_arm_hw_error(gdata, sev);
 +                      queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+               } else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+                       struct cxl_cper_event_rec *rec =
+                               acpi_hest_get_payload(gdata);
+ 
+                       cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+               } else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+                       struct cxl_cper_event_rec *rec =
+                               acpi_hest_get_payload(gdata);
+ 
+                       cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+               } else if (guid_equal(sec_type,
+                                     &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+                       struct cxl_cper_event_rec *rec =
+                               acpi_hest_get_payload(gdata);
+ 
+                       cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
                } else {
                        void *err = acpi_hest_get_payload(gdata);
  
No other feature additions are pending for this cycle. Given this topic's
readiness and testing I saw no immediate reason to hold this off until v6.9,
but yes I wish it would have settled a bit earlier.

