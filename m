Return-Path: <linux-acpi+bounces-3671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEED8599D4
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 23:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F93E1C20AA9
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183274F8AA;
	Sun, 18 Feb 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emtkzcpm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4EEAD3;
	Sun, 18 Feb 2024 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708296582; cv=fail; b=blfZdNZGQkNJSgEczkJvfcbDIC5T4n3//oB8mXqJxhnS7jUCfT56PfecQr+Rn1a2F3KAnuHbNiAjAQ4SS62ZK39V51tTBI9N6t+M3fqdTkREvKuBOJDcLvUnr+WpMhFA7zKF9k7UrE6BH+BE4Ze2dN4JTSAAsklkdkbqPyEcu04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708296582; c=relaxed/simple;
	bh=p1F2qS3FtTy0gaDP8L66JDbaEJkJQSN9iRLiFZ+MYg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NxHYBmel3ROsMiYRk+uBWP/wvp1Gk2x85fUMjm4lH4tDHpM2L5sasAUojlDuDBjPs8wNqCu7BvutO4RBcuJZsvKThW0EjWmb94BhiqNM38YJYRliCOZAJ2DfoJlPx1Kh9hXIPry8HO54wwRQtXW+opHX8YN+j9us+hLBXDbFKoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emtkzcpm; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708296580; x=1739832580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p1F2qS3FtTy0gaDP8L66JDbaEJkJQSN9iRLiFZ+MYg0=;
  b=emtkzcpmtKvbZx5M1cN1Jlnb9N6AeQu6rhhNrImc558h1YEWgbte6Jv6
   pwSkNeVajWEtSNjimPvDbJVIQ1UPQJNw9USwFghA7Zo1DL7pjCwAA4kBM
   n0UmaZZfSBve5Swzq4n3AXA3Ki9Ojt1sUbh+7KnNpJ6fVumWsFqzrBeXe
   dIFzw4sMgbOI4oZbFi6Me3habAnqFGzAv1g0P1rXfKXmHaTzvViPtINrr
   j3a59DlsVtOQwi3eZ6kcAKvWf3S2vR+5IQeekmLLE4howAUIiw2tb1Rgs
   cXEF6K1S5/CZRo96HAEYkP1BHRxJCjlXQtpQQ6IClXZkWoOAhErrXOJN2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6167478"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="6167478"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 14:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="4683935"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 14:49:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 14:49:39 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 14:49:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 14:49:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 14:49:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPm+m4G7Hlp/9uZYLX7NGCB2SwSixUPhLSzlM4eVbwU2T+eJ7YvSEJIV1JTh5zr8HnEP7TIYPlxyaYs1MhdC1ZOAnRUVOLwMTUHTgHvW1Kd7it2wgUiwvSZSbZMw3lPFJE35fA30aY31X9q+ib6Gm0ZsEbKDsT3brunohUNttRN9oTRTsgwo1X4ohw256BfTqZyGzITqj1uTT7O0T3JNoeaFvM3kEZqZYQPyxxlShHHhenBKc6+ky9a7IQaS+ePAnuPA2nBbX0u8e95xeCBGd64NZErkwWHojFbAJL+ZBWK3PLwRh72oVx3IyDoyqoIyYrfS2in/AL2gYhybN/g/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XNhqA4PtTpU6snjDRKd4ZFC82XX5jqKfw9mro1WPUs=;
 b=X016EOyNx+XbtoFspmnx5Xt7lwq9HgIxZ8z+sITVModHQWTXtcjCBFA7hrKvMfwk/Dn1RprkstFKvT0tWn7qdQka7QCm05CXgQp8yMc0YkByebH9Kbaitpm+Ph/Jiq8BdjlVR3St1cQu1DVfVrAp43JsM7kM73uSE/QvfT/N6SHvi6lKe3YlW4QHql03dYwg/KaABB27esEHkqt1BOVlpHMlDAjsZHd3laOuiFRRPOrVKyiZAXCgpQg7mShjldlosvHG1i0CrQb52bHJ5/hCXz5ZwJHCInCPw4aioPjkiT16pYWvCpoxFu6T3qP2RAfZI2Mk2KCr5E3Vt/+FHQdrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 22:49:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7292.036; Sun, 18 Feb 2024
 22:49:36 +0000
Date: Sun, 18 Feb 2024 14:49:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi/ghes: Remove CXL CPER notifications
Message-ID: <65d2897de9987_1711029420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
 <65d27c8a8cb95_16949a2943e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65d27c8a8cb95_16949a2943e@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9207b72c-703d-4bf3-8891-08dc30d3e1d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9vIcGZw5KAFX9wjhwT1/+yv9dVoybZG/xDfue6429lMHbdGrhqvG1kHRGJrQ4RRtBrpBZfgQ4MfuPpSYXrgqoocseTBi2JnemzL0iyfiiosuypMZ/W8TQBk6s73UW6jToejqOPjL3bvuZmzoXHXfU2arqQ870v0tYQIEIazqErZQo0lYg3O3Ur03ZGB53lJQW9v6pa0s/SEVTHIxyl794IgiZeYpy8mIrIw3B0AcomzaR/dxMh1d0ULxW49l1FdejhbcC62Rv3Vf+G6iZ1kxpi3n+cKl9woVR3ynMreJ4da6p40lu0JrLED/GEG6GUFLU2KVAR+lKPMz1jseiGUTpU+xtRkFywnbj8WBVwbDYBQyAMrti5lmtiQ7LSM32jWawoLZNBScsyPPlnedSzmvZuvGe8SJTNM+dA51QlJT05rUn5baA0iKnGcz93QX7OIGMcK1SFSxONaz89yfq0sf/r/PzoC1229QFUCpe5B1oG6iMmQcpOnXuMzgJi777JOdPRbn6hgiXZXTrEQ5+BPi51/WNYtV49odT1gVnx99wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(82960400001)(86362001)(38100700002)(6486002)(478600001)(966005)(54906003)(66476007)(66556008)(66946007)(110136005)(26005)(316002)(6506007)(6512007)(9686003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(2906002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLupw9CSn2wOtPn1aqa0tTyU7L06BCtk0k0S3I8SeBxrWzdtDQYNs1RR30SG?=
 =?us-ascii?Q?WCC1mpsZKXvXWJFbG+igvOqELILZ9ejrEWzlrCiJtxkvY5hja9ycBFKGyddJ?=
 =?us-ascii?Q?sFDrczPmE56qpcxCLopy5PyZaf1jx8FK7ONXTFzSNOFOFjhPoplf7S+1C/QN?=
 =?us-ascii?Q?S+HkexIuH2HzjnQPLta+BWpmDw6tF9DmiNAzXRZrYh+fMblbGj5uvJL7TydW?=
 =?us-ascii?Q?KRxS5YufFPjjkWhW6E0md2DHn1vP9awlshCVB5y+9xCM6X4hnYYBc1qIxCqi?=
 =?us-ascii?Q?f4YXIxvokvEIExrEjdofwGPU6jdvtqndLTsgEN0o6RRYOHtrn6VzIYP+qbQs?=
 =?us-ascii?Q?qfA8ICmGxUJuWC/Qqqi0NgQAri2jCupNWhjoX1F6Zx8CFwAOyvQ/rjNr9TZ2?=
 =?us-ascii?Q?RcRtoojnoh2NkwfTRubUpaI/SGY9bV21WGm8RWJ52TscrcI/mZgz7p69vD8U?=
 =?us-ascii?Q?lMeyEngEY+R3w8cIpOoLC0tWNBKNHHms12P5iJT0UBpzuUys1oqGFiz99FHX?=
 =?us-ascii?Q?QDZa9LsVFbetRPywf9LCddAKToCeIAD3WjWZqqQYeot47YSfsPDNkgLsEESS?=
 =?us-ascii?Q?1G0ZV4bBiBclEggBZC3VMy2YFQOtyiIE+EERBq2G1JAZDjgMkOMVSd+ZgA9K?=
 =?us-ascii?Q?mLUQY2AEFY3fwkGklmob2GOMGFVsioVuRQJ25gyBbNh11BAGWP/TpOsSB6sm?=
 =?us-ascii?Q?K0KPjbFVNBJgJf5USL32wblmASbqTleQFijeS0yHWdGKFZSnmARKaf44/hNq?=
 =?us-ascii?Q?hCP+pt0S6XrY3cBAUraooZs8IAdanCvoCAuB7br7TkK++WYUWS+mnO+BFuA8?=
 =?us-ascii?Q?OdKVlABntaLgPtuR66WbAgCF/BmyudQRvNSLfck2Ls1zKYZdigciVSNd+J+v?=
 =?us-ascii?Q?Z1ZNny0gj0J1lTjv/9q0mKErM1GukShms7mCV0TH/GmDqANOcpMPqnsPz3Yq?=
 =?us-ascii?Q?I7+C4EXBgOgX7oljTB46druw4/Fk8PH0wi7ri1HIOURCIKjZpdZBG6B9ib5N?=
 =?us-ascii?Q?J0nUuJ9CaYssYWySDJFgRw2TF5yqbJphROpsO1S2SZ719eg9dDQbzq+p3qRU?=
 =?us-ascii?Q?LDN0iaHgQ37TlsSRF5ElodnswCX8dE0K4ZW40laVFyVuhmxipZXUZQLyvkFr?=
 =?us-ascii?Q?/HLMakSIjbDqLCBcGK6vTPdalxPizxjIlpODva3pkULua7qTcDLBpdVdtTHn?=
 =?us-ascii?Q?RYNyQIYilI1Zq9Tr30fLvHZDKBv7h029Fox06+THclYaZSBHcq9oynMLuYWF?=
 =?us-ascii?Q?WFOKvr7qnV1I5VcQE7kK+hdy4lbhLOG3n8z3SME+Wc0tUVdxW1TkiyG50ihJ?=
 =?us-ascii?Q?ez1m9jaNgy260OFqY7835DcOm9KuvUJ49HnhsAvF2cD5Iq6rKbS4VPt6A+xc?=
 =?us-ascii?Q?LTh5WqRj22Y/+lNhvK0mUkJvYcZBdT/tSdlzKRC9CqLC24OzIMmfNhhlpIxD?=
 =?us-ascii?Q?uhwMBGYo3+9MeCEKI40RT75rZr3I14gtHJpJbzjj9ty/ZcqwS0o8QYCZ7VxA?=
 =?us-ascii?Q?Y5CqjcAb1L+QZvxtc4HPgfVIAr3TuHTMTB5gf7y3pR+aDNtNMU72SfE3LVgX?=
 =?us-ascii?Q?FP1lkgNB3SEeATOtFOZ78oQjOaDrieZujtSa3f+xAkFAsde7sw62SbQi8amC?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9207b72c-703d-4bf3-8891-08dc30d3e1d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 22:49:36.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmZ9LUYlXHD9KazLik2KGy1eVdsQg77X1QEQdf5MXAzGfSGcvWU3dz/BwmlvFriBNpHjtDSB/IoWioJmRCVnRaSq9Nnr6ePIXoG0xpz8n8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Initial tests with the CXL CPER implementation identified that error
> > reports were being duplicated in the log and the trace event [1].  Then
> > it was discovered that the notification handler took sleeping locks
> > while the GHES event handling runs in spin_lock_irqsave() context [2]
> > 
> > Given multiple bugs to fix and how late it is in the development cycle,
> > remove the CXL hookup for now and try again during the next merge
> > window.
> > 
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Link: http://lore.kernel.org/r/20240108165855.00002f5a@Huawei.com [1]
> > Closes: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Dan should we add the following hunk to remove that dead code for now?

A dead definition, not dead logic. I think it is ok to stick around.

