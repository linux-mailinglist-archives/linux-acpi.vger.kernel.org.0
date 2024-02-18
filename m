Return-Path: <linux-acpi+bounces-3669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D58599A2
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 22:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C741F2127D
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5E7319A;
	Sun, 18 Feb 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUt8/AXp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475265BC0;
	Sun, 18 Feb 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708293269; cv=fail; b=trpuA+PM+dkCoRM7hfO1/A3AfbUEKszBpBmzbbEssNfjQa6hbmFQ4urRezt6hUpn7qntCfXYjNpvDGrhOSmwoxnujQHVfQ8poD8flDewtnGn4hJcdLjEPWmX+F7CeDDbsPXzkrG3v9c6w/XS6swRPFWrzAvXACrt64Pa/WisAxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708293269; c=relaxed/simple;
	bh=W7mk/A54267/2qupu7IYDfHqTILN1g8A9+tbElEJChs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S2JramypFPPPswBYPHPJBobRq4aa+xzVanaWJxuZbjixyLl3oxk2OpO3JhISZgN35ys2ZHBictsPzJpPTKOTS9cM3L25eY2C0mmckroc9XI+7VOA2N3EKEzoN0Wxu+HGb5wMrZv7FVKiQJOaqM/hySdB8XvLZItM1dfGEUCQybc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUt8/AXp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708293268; x=1739829268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W7mk/A54267/2qupu7IYDfHqTILN1g8A9+tbElEJChs=;
  b=iUt8/AXpfySVSqT/MjLynPCDntjexL6WxvfCshVT1YxN/Xpc921Y30LZ
   5UDccLG5Ip2kvsykBWLYYEfw/AhssUd0Tu/H1n9W53l3ZY/LXVxrMCVgR
   74nUjXYm3n5e7NL8AYYI9E1xIhkrbbxM5ylx1pVJvnzcrW3Z1He/EXAzD
   OAZXClIcdnZHZ+arfDQ+gycnWZ+Lc+pdFm4zQ61S1Ht4VbMxfhCYUt4+Z
   VclVwRDjTnkaOQOWmR1jxfS7oAeyOGKKHCnivIgyJptKjxzxihb8VGOqA
   fEVSXw29PwvaTDNTcCFBdFICee8Ay2FfvqVAMgBlUEtk84Q9k3Jjow3Fc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2226397"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2226397"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 13:54:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="9007320"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 13:54:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 13:54:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 13:54:25 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 13:54:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6ZFxZ7/m2CdTb0efleMizT1ldtOWHzuMHuaV88BDtQzP5OZbtBy2mDV42nmRfQ2JWBygJZWe/oldInjXfTo/Rl0Mx2gHi9tt8O9+dGGmAtVC5SGmCR/4SyxNOpskpqW3gOItHc7a+0jPw0M3YuajhPZnOrJE+yGMJJPUFAvhXmPCH/jCfgB8vYLg/KdCapdTgo8jqseJQmCWiQobH8LxSFB8QcVKmc3859HMm9PR28x2MeTPGzNk+mh6M/Aut426Bx3XQT4pYunXxtuITAjpv3XqedveaRrLJ17YoN9e1teyXtVqiDPPIwEilMOdO0yOQhO9K2nhkOoxOhpGkMqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXcrc50Sd1BfbH683VuotXvo78RQ2VQB/W2j4Au2rPk=;
 b=CndJeX7vq7n84Xq7D16ze5Vv6tKpW/NCBS0l+JSrMc69JgZYKnTVu+xhfQJ0szFbIw+CRN+6KjrlCQevydlMKPEJtFB0ElJHXgS1WfQZDcxuxq+hYA8TrGxJQrxYVxJ9cvl3Fz3PNlX/jKPMpzniLwsy9l7cFmX+5Q7JBMR95fUVicLir2Y7BDtPaGKBxAqS+BmEoAk0e5vTj60AVsIfOmRSPEXfAVPc6Se4xcPP17qB1UGkQnvGiML1plQU3Dr6MEuRZBpORWKWSc+PRTKU4cZUYiIvSekzrGcjwMVGXQpE3QltRj/mhopJZt5jXuVvT+PBPT8/pOhDM+H2eaeidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 21:54:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 21:54:23 +0000
Date: Sun, 18 Feb 2024 13:54:18 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi/ghes: Remove CXL CPER notifications
Message-ID: <65d27c8a8cb95_16949a2943e@iweiny-mobl.notmuch>
References: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 50230196-2edb-4bde-65ed-08dc30cc2ae4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npL7ps8ibboDSYcG7xIjgmN8/Bpk5yKRVX41aoFFxnTHEdAV1vnmgaQnP25zm3FO01S0hckESG8tVz/9Gy0CSoRiKR+V+guujEsUkvIQw8S/boCApgmYIiL7x6kBjPrPIyhhgmt1LCOBFv/4xRpfiy3aJZSr7bhkCfMLgUI6q1gRZO++EGhR8qVppmgzaasuBVFG7TYZqK43ZgQGHJ7MsvF2INEl5U+igdnrHFVX78nY+sScLAPGCHbNzEpaSHV+T6mnD4bRCRiijFpAqllEiEJSIIxXgwbwbcwOSk402GJqKOqXebZqELV+LVatmLYEHo3PVEx3otW/tYb8q/Kn/YtccAr/xrYIckkf6CNVWT+nKcZIRpH0HSDEBDQeyAZoVTs8Yt2KOt0AT63LNrIxKA0iv6XtEXPpmaPGdb3bP8oKlH7CM6Uf93ICEROEtkIda2mUrYy7TVPGasGpXwftapCcSdrVxIeY+Svgolj16wJsYMDYhP9JmRnFFb2qOIZMip9Q8z0J/j0ncreKegwmgNTEhPXiXI2flxhzRvjO8Yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(86362001)(44832011)(26005)(41300700001)(6666004)(316002)(54906003)(83380400001)(478600001)(6486002)(9686003)(6506007)(6512007)(966005)(5660300002)(15650500001)(8676002)(4326008)(8936002)(66556008)(66476007)(66946007)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6squCaccIEBVZcfbP9j+uRB5BCOD5M7hp/T/+DklGBxcEaXWG2CkiBuk90h?=
 =?us-ascii?Q?E7QWTidFDb5+dW/p39GFGpxKv6IPztsz8n5MZVVIu019T03HvULIW5qOK3bT?=
 =?us-ascii?Q?qNtmMltitv0n0iJGK8vaiWxSm1Lqq6Qrng+iG9PNuPDx/Huxbkkc5c91CaZA?=
 =?us-ascii?Q?029oMNlQWNKJEtCH/zJkLIAXTso+gkDrM8Q7tfwa0QjFWsvie/pXsFz/D+kE?=
 =?us-ascii?Q?8v2ekcf9Lx+9vmHQmKalSzwGA28IcjCyWhAy/5vjjzXsaa2uQAlmAslCL26A?=
 =?us-ascii?Q?3s1wWfLEli8JbLjLUBW02Gu0x/EZyz8vkcSBrkSSk55pdZGX/VdVhEPPzcko?=
 =?us-ascii?Q?rrgB2vu5J9DQeNsoMJoCzNbYvtFcodSGqXQF8OxKBTdSFI9Kbo0og+jgEOpE?=
 =?us-ascii?Q?oywBlZMOfvFLaEuRSnABR2LJlJdZHR3Yvkf8lxrfavZLhgN7Kr5Oi/alKnVc?=
 =?us-ascii?Q?FK2hMhh6IzqNzBCmUUHJRAqN569Kjz3kB43o8RMsb7HTkAxVDJw+bm1/uO9C?=
 =?us-ascii?Q?EJgvBboJdrZzOFJbmuPQkWElvIYOER+ygdwcFkkPgA+Zebs5CjOv+LHYvggZ?=
 =?us-ascii?Q?vLDqxXqN/wrPsK48WHEPMolnmdvVblPy20z3/9YNh3OIuVgO5VzRbh0uZ4S1?=
 =?us-ascii?Q?RYi1ovCA1LBmUXiVUSAK6N7HP0nWYQUjSLv36DBrcRh8iItF5frJM8zuhG7L?=
 =?us-ascii?Q?Z8CJvyObjoAroeHtxaVL+esihCO1+RJeNgF4M1oYC6E0I3vDLSLEn0TJwY7O?=
 =?us-ascii?Q?9kMHUeI9Ze+f7Mt3ITI9OAPAh+Fu0AWIRaMimFA1ve30ZuBg65x/N4htUTX8?=
 =?us-ascii?Q?+Qduzq5fLekCyqxqIFSkuFfuUvJwvdXrLWFtOgYrcVWYwsyEknTCWQQcTo35?=
 =?us-ascii?Q?l7ioScqruTPOAR4R/Ky2uTMTfHrxzeWnMPz2X6mq2RkQn7mED2bFjUkneDIu?=
 =?us-ascii?Q?Hn0GUMVJWFXqCCTyJNvP5uWbnsSmQuSdjWuPzpHCQWGylCtvSvoBMj3z5WmJ?=
 =?us-ascii?Q?IcwNSPjrJrZJTHNiIhRSfYdyC8ArK2gkqorZpaXGumVg4oWQ0Ee1+ziz849f?=
 =?us-ascii?Q?p3DRoJmKjLHggce4h324AF5nc4JwrMGpqZkguD0eZNFgHFX94YR6gSVUrnPb?=
 =?us-ascii?Q?mCXdl3p+r1XE+h3Siwqqq4Aqy2I9D0pR9dhJrbCBQH1Y6N3TLweG0bOVuATi?=
 =?us-ascii?Q?IUz4pyJUOjp58RsES+3kgDobwvVYp6NTFP6/CQvYIJs6TC43pTu2eRxkG244?=
 =?us-ascii?Q?1h7m7rlBSdD8dDLJ8RSRp0REH7r8SVhoqTMJHwHVZBJm27CXRn95W4BLGlgi?=
 =?us-ascii?Q?Mclt7DMbw0QSlLc5oFlQES225Gf+cfSnUADhhy0a2tLw4fYVXHIawDDAlKP1?=
 =?us-ascii?Q?UKTQ7VaFNNbWXicEE+sx5gs24wmzmrZPzLsGXX17v1DDt/K9cpY/bLCdj7AO?=
 =?us-ascii?Q?pkSsXazyamG0iq1cBNhhJVdPTciEKohUwQcfF81JLmsY2JiAjbVnSx50hoKJ?=
 =?us-ascii?Q?WbM8KbADCUZASCUcyJ54K4h+a6OShqDDAvoQ6SH6c/ws2UqVq3mKijPqVJr9?=
 =?us-ascii?Q?J9703z4pjgY23olv0hX8VrFrl12wn4DQZeqfuSIZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50230196-2edb-4bde-65ed-08dc30cc2ae4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 21:54:23.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiADx6rfD2q/ktCeeRrKAbM206SeGt6qRziZ/3hTD13J1Y7btpkM2k0vpZBCYYB1BwstiOINyWasTpaDf+wzVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Initial tests with the CXL CPER implementation identified that error
> reports were being duplicated in the log and the trace event [1].  Then
> it was discovered that the notification handler took sleeping locks
> while the GHES event handling runs in spin_lock_irqsave() context [2]
> 
> Given multiple bugs to fix and how late it is in the development cycle,
> remove the CXL hookup for now and try again during the next merge
> window.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: http://lore.kernel.org/r/20240108165855.00002f5a@Huawei.com [1]
> Closes: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Dan should we add the following hunk to remove that dead code for now?

With or without this hunk.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..f4934d0d1fb2 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -114,30 +114,4 @@ enum cxl_event_type {
        CXL_CPER_EVENT_MEM_MODULE,
 };
 
-#define CPER_CXL_DEVICE_ID_VALID               BIT(0)
-#define CPER_CXL_DEVICE_SN_VALID               BIT(1)
-#define CPER_CXL_COMP_EVENT_LOG_VALID          BIT(2)
-struct cxl_cper_event_rec {
-       struct {
-               u32 length;
-               u64 validation_bits;
-               struct cper_cxl_event_devid {
-                       u16 vendor_id;
-                       u16 device_id;
-                       u8 func_num;
-                       u8 device_num;
-                       u8 bus_num;
-                       u16 segment_num;
-                       u16 slot_num; /* bits 2:0 reserved */
-                       u8 reserved;
-               } __packed device_id;
-               struct cper_cxl_event_sn {
-                       u32 lower_dw;
-                       u32 upper_dw;
-               } __packed dev_serial_num;
-       } __packed hdr;
-
-       union cxl_event event;
-} __packed;
-
 #endif /* _LINUX_CXL_EVENT_H */

