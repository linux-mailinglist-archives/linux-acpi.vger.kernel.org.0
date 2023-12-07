Return-Path: <linux-acpi+bounces-2214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECF809740
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 01:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B051C20863
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD420F1
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nt9ykssa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557E171D;
	Thu,  7 Dec 2023 15:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991738; x=1733527738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WiC3kLqO6tYP6TcPvp+Q++/qiuJ0muDzRO/9wXHT9MY=;
  b=nt9ykssaDype18CvPHCqEpWAQy29O4dpfWnNOqFPfrAwwcfZ6zJHF5+0
   lCR2IYGnbOnjTJcPlrOsl06b9Zt5MBW3/jyUo/93tQw4UKJf3WwryRwJB
   jXKxZBQT/vpAQrRz3yFVLLhN+bGkSzaqBfkFSBCQYsV+TxRFrQi2MVaCB
   EQJWzqcagvGyokH/LRpDJgnyMoJc7hAWa03uxMAhu5h7iyqr6RGRPViYs
   VXuaDxRMFTuMUNatimbGvgWFuvigfke2cvc0dlA6m2P97qBlaf05gYGn6
   iDPjXdbKz80jlDBYNnCxz6l57EoUmTHHozE0mDzLMPY0KO0pWoZEGCSGz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7642974"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7642974"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842386436"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="842386436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 15:28:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:28:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 15:28:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 15:28:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W21fBxM5Ogcv2dzVTT418p1kjPZwwKMStTUROPM4qHQKJfE8FzwbaABBF1+D3sEHkb8UtU8KxRztV6Sh2ZlDeGOzqY2f+DAo5wudjen/X3Tg2F0rQI8yUB8ArS1nhLZVA4dW2wAVxeoBSXoZmZT7veOT15tOFm9P6+kdtOmSdnL5xQrDIQ8O1A7KgcqLqkcyjpPDuykTqqrrSGrxsFeQrfbQvt5k0KGYU/P5v6cZrn0tmo28W6YbQn+D3Wfeo9QSsCYc61b2EfBREfAK6DLs91Ozrq0DtlNuaeshxNUq4Xa94dhq9x6OUkSIYpblKhjri+rriqxIt4VljLhkYU71/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iED3yZD+lKqStaY8Fhlw4XCiBi2xJJ/aowIL/+KfDQA=;
 b=fxXixl4EgzxMeuVy+iu3BbsOQWeUv/sMvJKFAtnpilH0qyckru0fbVFxA0eUN3VAqx1rToR100zvBKQIzD38ssag6g6Ft7/aSe1uWYbqRsWXzx8GFpaVeynZ9rL4r3JaELuDp4ME2zsVEbW9kZ+iNVSie0diFpUbVRXk2bOjHRoUJZpyrm7cGyWLQ+5Edrm36vSUaAZmOIlNXfpzdFM+ZXE1trB9IBx/c/l2TeB0/v9PxYzyY5+bbFS83YESflpZ0panUR7MVVfNzc/uSjfbJAXo2MI0pD0bq+NKOeQITBnuaqfsPylpI0FeuL19LH+4RHext187itoeuvD9SENrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 23:28:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 23:28:54 +0000
Date: Thu, 7 Dec 2023 15:28:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v7 2/5] ACPI: Add CXL protocol error defines
Message-ID: <65725532ddac7_45e012941b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128160656.166609-3-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: c6477c55-6a33-403b-6334-08dbf77c46d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOgGkyzZHUVF1u4Fy0hgIzP0DDuuq+SPyU6UQhWvdiZP6rcqTK63qtSTkh1RiAyQdkkdm+iPMByRZKvmaDtWN5EXnQ9qo0E05cRtERthyGR+QfHTCrf82t7sFp30g9z7YN5mOMaRlvebmGLlz5dZZt8Jk0kQC+BQFM1AiDPtsjBr+1/HcHIBxjmHqshNAIqqqsrVWCpg+eGKB3aOQvViLUeoV69zxXkycb3Y2vHkJNM3CmktLLgcYEeTN7NmHOGl/WcK9qvl/war6Hq8RINKHCETxlXP/aHuQpqsh1vbiwe5e5DVPM+mBpACdj7gN5PsQuv0N+57aREgY3chNi5cX/iAvqSx6h+US/DNxpIJtcdAX117WBo9JDHwhI4NLteXjsy0FhXcajnE6On4/d7h6xpaIuDmeldOvYSZFbm3Cw2EZbJAz/sjORUG2qmdtsltNeWrDWPfE1FCK4gRxiQmmbEUReZfAOrXdVEwoOUjJ48SGGwT8b9T0gUxRD0E7JZ+pFjCI3tWc3LOxxnTYx40tuvg03ERmjPJCB/TLw2b00Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6666004)(6512007)(6506007)(9686003)(38100700002)(82960400001)(86362001)(4744005)(4326008)(41300700001)(8676002)(8936002)(83380400001)(5660300002)(316002)(66556008)(66946007)(66476007)(2906002)(478600001)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBeY0NE62sGMFCqx2aavV5XeEpITZiqpWXYgbTKCniyksTmSkuIWklxlxwZX?=
 =?us-ascii?Q?6sbShuS7IJsEXD2AWeEgrCPoPM/CqL5gw/yXLA8IAD6vzRH3R9I5t6RLWtpq?=
 =?us-ascii?Q?mH9emgn2fFtGb1T+Q/wOKNazmINWPpdCOSFMt2sbic5gU2wmS9f8864wmJog?=
 =?us-ascii?Q?psYKcoXTA/lXMd24JKcQRq/6fHKjuENXMdfMgTMUGk5FDHTSHw0foXt2EguA?=
 =?us-ascii?Q?dhknzh8TQw9aIQ+B7WmcUua957wKWhbzhTo8SyXkz6YDfvqlrl13C9pUr99F?=
 =?us-ascii?Q?r9SogeGE3PPQ0E5aE2b7/rP33DPxx57bT7CINnb6bm7Cc64k6dYQVj27kSi1?=
 =?us-ascii?Q?m7C8JZvuo8R8Z+9bjz1XaLzDi1jXBpP+harfY1yYkx5k2Mw67HU6nNnat0YT?=
 =?us-ascii?Q?uZ2v5MTkc9copuCaI7ki0Ni0cP8jIwlNokFz86nYeyf+D2UmbLxiq8bwJLOZ?=
 =?us-ascii?Q?ZyLlbitqbfk0F/oLwRqTsoMxcaKfOStpcsIjMVhT2vbn+BBjwLx+97b/9Bfm?=
 =?us-ascii?Q?3WLJYp2zuZeXbGLIvLzCP7BVeaP8w9CY3/Ax1PJY9W3Pa2vB/u7iuLIY8Js2?=
 =?us-ascii?Q?QnTfJREN9iUbQNfC7dUioiUfkbo73bn4LEcmvIUrPPAkLqtLwNXAcdu2HQlT?=
 =?us-ascii?Q?cSkGinjMjNquV93cxgojDMC+uXHjIG2vclH9Bst4oiojmTGAAuevqSrspiEV?=
 =?us-ascii?Q?2zy2yeHHKnGWBMXd5I3sF30mEygToFEWUszW1w2mTqangt5qIg5sHQHBEEHM?=
 =?us-ascii?Q?I0djFqxYcqBw3YcyxoK2wf70zvPbEn+AjIWmsEkSXiWyiDxE6IotLKa0cY7s?=
 =?us-ascii?Q?JPDO2bTE8AqDNJFVE72Stz0KkP/MoK6KWZBA4ytSTuwt8FnRTlZGbdKRCWXx?=
 =?us-ascii?Q?E/Y0tCpw49UaxV3xxGCF0OHfpvgg3Zn7aYCXrsFj29x4zZLK7BhqrfSXhlPQ?=
 =?us-ascii?Q?lVSUVteNCvpQmonDWfl1Tlf1/cLSltfDoLm1L9HaKeDXF5pd6D7jKrdXJAK0?=
 =?us-ascii?Q?5e2NCpbnyIwP56iWttgAsd2qeA5WV916cpjN9J0oUiC6ipCBl96SW9h391kV?=
 =?us-ascii?Q?++9sHOez3HJyOXMokKYyefXoKLVlg3LzbYKFeXne+zL2+SQldEPsIqtWC0mq?=
 =?us-ascii?Q?kffRSsZTlE1qsDCEqtBlhPI51llQ/02sn5Vfcc6/qUnI6z8LTPwJQWK/F33W?=
 =?us-ascii?Q?N6KRoxOsyMZqAueBTBIwZ44G+yD5h6d3T3mrLS7WEJAz5YnUvXud/SQbPzFA?=
 =?us-ascii?Q?LdgY1QR+GuZQRJAL42QT3fxveglqjwUmMqrhIGdsbIPNBef2qJGuB82RMbqE?=
 =?us-ascii?Q?2wZszCLpeRA0pFlAViWMXVpEogza3rTomaJT65dy7V7WycQM5YVTGWlkco2M?=
 =?us-ascii?Q?B/8KEGHHGperX4+BFq+VYQkZQSex8fGkhUxaH21bRoXdeBCwJtZJdZT0nLS9?=
 =?us-ascii?Q?0YykQsdc+6wEpIlluel3mRplattEzmuRxfe27Sej3qDFGbIhoXlBvwikZKaP?=
 =?us-ascii?Q?DrmpAHar5vLtWY59XYPR39kX3Gx5u+q/rCZ74MiXJ9gHU4Srls/Z6pHqVeQ8?=
 =?us-ascii?Q?kSUAF/IDOij7a6JEc2/vruY/1JERVlLvfwQU6FJD4nD7xWdOvIWrbIs4c2i0?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6477c55-6a33-403b-6334-08dbf77c46d6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:28:54.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM7fS9w9eIGsYR3vpM/J7HJtTp3d9jZ9jNn+NVYvweF10VLaga0vw8Y56+uDi+2msPX6qEVT4N9kCCHpVXknGD/ftpz3n9CMYUJFUGxQlOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Add CXL protocol error defines to include/actbl1.h.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> ---
> I made a pull request for adding this support into
> the acpica project that has already been merged [1],
> Feel free to discard this commit and use the acpica
> changes instead.
> 
> [1]:
> Link: https://github.com/acpica/acpica/pull/884

Yes, once this makes it into the acpica kernel branch then I can move
ahead with a CXL topic branch for this series.

Looks like we're still awaiting that update event.

