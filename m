Return-Path: <linux-acpi+bounces-3670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE28599D3
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 23:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3568EB20D82
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254941A91;
	Sun, 18 Feb 2024 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpCrBQtL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8580EAD3;
	Sun, 18 Feb 2024 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708296520; cv=fail; b=RUQix5RuTTZzBR8oJCi6/fokH0TbGHJOCAXufhaiCE5fSCZegBEztmnihET2g9J+9zCCnVeIhj0rn5qoJBe7AZk/lh1fKThewQFuyApqWkfJMIFjjHuM+u3y5oEbsIr46Ru7pPIwWPetK5t9cdHv8elb2qq2RnWpAGDWo2ln7BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708296520; c=relaxed/simple;
	bh=8l0ZH15pXB66aJZjG10GHmDcRmf7avZyljd/NVNMIHc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gYhgvqa6ExxMPWCRAUN70PuoCE2lWwCtXg8tRi2PsX5zFCFQJWv9dUUrffA639wVgv2elwx1BZSXncwQAKFAQ5P58R/1RWy6lMJgUQZYjrkVgQJTnygca8fq6U+gfEpL8utf4qlpU95Jp3itbVyQtstprRCtzzB0t3ctg4YSiYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpCrBQtL; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708296519; x=1739832519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8l0ZH15pXB66aJZjG10GHmDcRmf7avZyljd/NVNMIHc=;
  b=lpCrBQtLKSNBjToXIlq6No1AKx2Kds6E/xmq9ySmTPP1mDAvEvZqEoaX
   45cBJRBNLozFPsQNtRb8a1+szcLQy7YgcULPd6YdN/sI6g6+tHD7bZDDh
   N0FRKDisp6bYQnYtQntGdo0RSZ+aKzgC8+dUaPZaCQneY3fnF29suOhIO
   er0V6we9Bu9naKiR+AWXwPgdoPGnlfm5iKBa1/nh8nBIfxyo+FWY5qAPI
   4KsNYHHMLhHirqwH/XBlNUK21wDV5HsdvEQ4Levz7tbBKnRS6s222abQC
   rap2T57gQDuxVY5Fs6ZLdcz9LvzL9jj8LDrlw4HJCjrb9MAzo1U0wFmm6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6167461"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="6167461"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 14:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="4683851"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 14:48:38 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 14:48:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 14:48:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 14:48:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOOUR2NO/FApOZvVsGtm5ODvPCoA/JfzWEuYywidc1Hfj1kDVIhZzLtqVX81sRVXHIC6ef/qwcOuiOjaTQ0OeVXdy4yW5Mq20lOBqOGgxo7cumI69ILRvEXhd/Lwcxb0uxPzXo3PQKHuEsSZlhvCIwg90ps3uSbcICkZ9YXu96s8lxjuRh0QnWSMS0bGPWXPZJ3VPV/ft9S2h8CTCH3MwQYL20300qGc8ZrGT8zTGPzXbfVaYbJ8mYRc/DJvyP28lE3EIi5TgmUYk7ZkCQhFe7dJB7qFvJl/hbf0jSZr6/0aEwHQQt/r5KpdTp3YPZEjgU9XOvj78xi0xElZ0ryURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYPm2z9tMPMXpaO2ZGVUHdI3sunXFINgHjuC7rwEpbw=;
 b=VycUMw2tcGDuNXFMgfhbKqRdYAXYW0OCSLJlt6s4ixLVWAtb6nOYct2fbST0ZMKKOASEJpyxNzfvouoB++oDNKBjJtMD/SYPQbC2/ecHusVqSvJfZyUCIes5vI5oe0h1b4fYP5yauvjTXgckK46eQ0/RJ3JRGePiWF1GTeTTad4S0ADLQw7n0Af+6cJ9c/sicQvHxq+MvmyxiSk/esyB+lUeJ9pIH1M8D3PVFUVD7MeXHlP287m9chvU1KQuwxWAAPmS9+L8alknS8CsXhO3JDNKb7hKjHqOzaDMNhtIbWsZue+zSTDUZ/l6sR+kUOTBrSW4oef/IF1I3ndDlfWk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 22:48:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7292.036; Sun, 18 Feb 2024
 22:48:35 +0000
Date: Sun, 18 Feb 2024 14:48:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi/ghes: Remove CXL CPER notifications
Message-ID: <65d28940ea98e_1711029492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW3PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:303:2a::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: c94f777a-c971-4eaa-2d42-08dc30d3bd29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpWnYOec8RgBRayd0vDP+rlJygoaHoqd/dLRSEuUeWRnn3rcUaVDcwJyfQJxkGsnxifhF8PqVcJPN5mj02TqAQUOX5nx+/pXSW+fEVs1IxiMyYlPmt26FpFe0YQ3wnIFyWf+ccePDjyiXdf3vPQynBDIJEieqU3RicnWQbS+xY2cZzddkdLczD1KLxf2S9NntUlPhLgNDpEyP4KvvMloLO+xH0+nH+jmtk61TGblmrL4S8odD9lQAHAtEO8oWFa+3VQzaEoxg4Ebd6Xpp5Usq9fnIAb7Zz560QHMqBRIRyyOsnXUBDjx9tJnk489oxvVPD4ZTeXnM3UHKePyzxVUVvjppvhxi2seNeaIHaCTfvePvBo//qpI0lZxIKUuuNXwWO5jcMyj7raCb6GCSIQadyzpysER7L17sYogBCRsY/LF0KBwvZH1bT4lUro7yCgojAt0kfB/KTrATrnMJoBf11u0ZsZT8cV2y4Qzhi1z6RvYQx+PEA9gYRcafNUVCKZJNgDhm3xBlOr9lkX6nwga7JiYrCUJ6FSih/Iv+BL6D4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(82960400001)(86362001)(38100700002)(6486002)(478600001)(966005)(54906003)(66476007)(66556008)(66946007)(26005)(316002)(6666004)(6506007)(6512007)(9686003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(2906002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JI6rlTk5GlQJ/4Xc2H6ibqCAhZ4lCxAeQO0LAZt2Xjq9/Cuh48XTtQp3gzk3?=
 =?us-ascii?Q?JxS/0G1NO/3dC/fPr26p1IMvoNbCGNGQ0NyC33yfjeu0OFrEYatZgw4OhLrg?=
 =?us-ascii?Q?Oxea4NCApq0lCkWlWCuXT63HEb6dLRdlbA99FCHwTr+3ittZOvc3G8jgi0TD?=
 =?us-ascii?Q?IHL1m7n9bDSlkZBqO1IIrEW5A+HglRnbROd+C0s5XxWqBgAYWQTRWmSxHypL?=
 =?us-ascii?Q?s6RaEM4ryQx9Y1GzooyTJReIoQBpwKEyrwSQqAZKo5vQFBp0XIr385TwzGmh?=
 =?us-ascii?Q?WynBVLvCudYLPtefh2aBgcW0WLTwsrhtJm16ILqhtuPoD5eW0C9NLPBVy6bm?=
 =?us-ascii?Q?HQeso919J36XHRIcVfNZnk4vyiLm7ANQrNOP5fdzktAq8ECpRIlZj80VJXKz?=
 =?us-ascii?Q?K/j8MlZar8u9PXdYnTk77U+pHOjU3P8b1qkTm3W/oDUSbmh2LKhxClKEgkU2?=
 =?us-ascii?Q?EUXqQ03CSdSt7ZxgWWWzN+Q+6lodpFdKSDbsVZv8gyaJnxUuY49xtIiUvsTN?=
 =?us-ascii?Q?Zw+lGmOqjLj9sUAF+PDFRJ6G//4KGSoRkEb/qNmFpu3BVgG7TnhiIOiVNy/D?=
 =?us-ascii?Q?3C3CWJ7gAHCYlRXShezrNO925RuSXEYr8IktDVfYCqBPNOmTKP4Id2xnpPpl?=
 =?us-ascii?Q?LuMiRuSNHaB022iX9fuN4IhgC5yQ3vhDTGs5/4X8ChbpRU+zYUd0qpMTRMkv?=
 =?us-ascii?Q?UIkxOV/bVJCJEQqXHqxCUl9oGYLITVOkvHY5TVgPFxXbjN5BTujRq96GNIA8?=
 =?us-ascii?Q?1a/VddxVy34Ynq1KRhAIfJ+aJ/CR+afs5/jgqK3CTFqCWmj1SM57M2sFNKrX?=
 =?us-ascii?Q?AT7E1Nk5H4YfuusXmjY0iEre1WguIi3Qyd52B161MIHe+TZ0KZFj9UoLxH6k?=
 =?us-ascii?Q?Ljs2krFdm44s3Vcn5fr7Uq6TFvp4zra6EmOWQHfwYLv8r54jPNzlHl9HUNGX?=
 =?us-ascii?Q?4WzBi/sEnuiWWV3x1gaU/RQBqCCRiM7bJcz1zjXbkwxDtGT5qSSxr2KyGCYM?=
 =?us-ascii?Q?zatYrbNranHNBmVByYW4GptpOVvubbS9YWdZAJwEfAeMyeaFrXeWRvBEcslv?=
 =?us-ascii?Q?g8V6EOm2DxgbuZjupkj/USlf6Uxw5NhAAPhzdK6uE2/Zp5e3ZWzGdmCkz4g/?=
 =?us-ascii?Q?RRDKvcEOwyE5y6aTRkx1RTiazxDGe6sx8R6u8kDfbZqSizOejH2Q4oQqMS3M?=
 =?us-ascii?Q?RZRB3JykZGmjkd/p5BfBJSN0Rp7lY4+LQZlyUxR+ydF/tHnLzJI6XwqPKOtH?=
 =?us-ascii?Q?ex4SNCmlM0Zc9fhbzY3tiFZVPEhro8MDzDa2vueQI2+R51XU6J6DsrVw8slg?=
 =?us-ascii?Q?NpjbC28jMfd5Rl0SuU4QIe/wx50nTO/N1mud/U2YPhx0ipvnMtjq89r5umTy?=
 =?us-ascii?Q?pzfP4Iz4YK7zhkHxnYXzAq9rDAGY1ki7JF5MRwDN0u3Lh1s2GbgP/6gN6ikb?=
 =?us-ascii?Q?zlGHeeSTatKnCJRrGGdqbEJyu+y3XWv+qZjM3ho7rMop5PFmSDOme2MEoAi/?=
 =?us-ascii?Q?pfA5eilTuWcYEIW8CLodZq1rNmgRe5VBJQau6B582NDTNiSlE5X4TjlpZpU8?=
 =?us-ascii?Q?lmt2VhpKCUt/GCdWfmxZZN8+JgqJwGiH629dXnSUBucjyhVuOVg+X6lU3e6n?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c94f777a-c971-4eaa-2d42-08dc30d3bd29
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 22:48:35.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tix/yogFHCiQnb61lK844stXO4Wcw59+9z7108d3nvXS8SYvG0JN01EJCSDeI2QDNXuDvBeoSKHXsRylvD2l3Uy6NGVLgmuxsT/Bh6fZNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
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

Stephen noticed that the fix for this already went upstream as:

    54ce1927eb78 ("cxl/cper: Fix errant CPER prints for CXL events")

...and it collides with this removal. I really do not want to have a
fire drill to fix locking this late in the cycle, so I still think
trying again for v6.9 is more comfortable. That also allows collecting
Smita's work as well.

I will fix up the changelog to:

---
Initial tests with the CXL CPER implementation identified that error
reports were being duplicated in the log and the trace event [1].  Then
it was discovered that the notification handler took sleeping locks
while the GHES event handling runs in spin_lock_irqsave() context [2]

While the duplicate reporting was fixed in v6.8-rc4, the fix for the
sleeping-lock-vs-atomic collision would enjoy more time to settle and
gain some test cycles.  Given how late it is in the development cycle,
remove the CXL hookup for now and try again during the next merge
window.

Note that end result is that v6.8 does not emit CXL CPER payloads to the
kernel log, but this is in line with the CXL trend to move error
reporting to trace events instead of the kernel log.
---

