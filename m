Return-Path: <linux-acpi+bounces-5978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC38CEA28
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB001F212D2
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866743987B;
	Fri, 24 May 2024 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2L7oYzW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB92381C6;
	Fri, 24 May 2024 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716577539; cv=fail; b=LRD8lalXVNgw9C239M9suM6jRkAl+pi8NOYNx4AD/B4v5o58FaD6CIOXDNbn729KEMixdroPDNF58avyUKiTNxXf1J9escKa5UI7u0p9YBibYqw7b+m+Wz945mT7WLeIftpygk3TTN5qXXkjQ9LDz4tPOEZXyBZdE7ZbxZlcps0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716577539; c=relaxed/simple;
	bh=djwBqAg8a4ZlMw6/n3YkjOwZvNR+0Ypa9N/OrctqBDI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=j9UmRulYsbZwcPWaDt5q6x6V7hJHCGGcePkhDlz76p3b1CKj61uJhh8RK9yN8DmpyrpG/exW8lUr0Z6HSTox2fjdJcW/bstBIANx2xfrvmhr/jJNHq2GBkYwY4JWp828wYzS0lShqHs0vw9vr+rUuaqt64d1HwiurLjGbBnHOb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2L7oYzW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716577537; x=1748113537;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=djwBqAg8a4ZlMw6/n3YkjOwZvNR+0Ypa9N/OrctqBDI=;
  b=h2L7oYzW2oANK+5vsyRjSerB3igfwzhe1itqW3YSOapMN/nlky4hng9i
   EgBhv44Xchh4D+c4kSJL15Hob3rxo7cL57BHbbtcA2PfZ5Lbt7OvPTOUx
   tXsXkkh3iVCr7ZiguCFyLx5BX185nyBBXhVtycW4Cicpe9i+hxIWd1SKv
   31aat3HMECgtvnuTq/JrolE4QM7WV69nyUsAsleNW3fv9+pwzgcm5O9OM
   ZgZPNCMIebyFJxFVsuXkH+E1c/S9AxfnGMXGyhel/JS2m/VxSjyVZEN7B
   lqGuBwKwJuG4hrXynZ/zcmgsOWesZ3le2ycy8iKPVAZoh8qcgpe90RID6
   g==;
X-CSE-ConnectionGUID: Zw+gftRnSSOwDxqZhdFcPA==
X-CSE-MsgGUID: 1aw45zH2T9iaQWRrfaCHLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="15913174"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="15913174"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 12:05:37 -0700
X-CSE-ConnectionGUID: DNvqAQ5DTmCojqVwtO9O/A==
X-CSE-MsgGUID: TREvF5ZqSKWLwWfmfgHckQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="65343438"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 12:05:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 12:05:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 12:05:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 12:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGMnSxQUg98QEL/L2/U11LqvzyfY7f7BeyllNmsujsKDv5IPGxqEOFmjy1X8bEABvpuMQo/WpDJRuxbif+ZKWOOXIQfvI/mst7OjRpnpQpu7TvGqmtbMkCq3Hy6bcW+/FK2CDXnqhmRqJLxBN2rZtEUUAAMyLxGZhCYATR8d9j1hWV0f26ROv/o9Lk4vuq2F526bFvJW07T1qCjyXbQZKt0htjO0ZARP2gXcZzKig3bxcfxjm8SMuzfa1vuYr76pDoA4PEQp0IqNG3C/GKybrsy46di8I6AAIZ7XPEf2yPKM25f+XOm5EPJyFwOByS+OtAFYwXut3ck6vwv0uqGfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPz14gDiy2YRm0wXJcuqoRkf/PlNlAPjTVT2TsxcOgE=;
 b=J0Uvs63j3iQ7NSiLBDzQ+ZJ5VzDTM0FulVVK8AnA5lemPcr+H6nCTk4QbhAmmSFwesdY8z6BdkD/pUuUo+ddpzWeaFUvRC3bblIU7MaayVDKHb19Y++28xEvWHHdxIA4SQcv7w9tMRHvRUESFdaB/VYB+KoRQCDCnX/SUdwAYr+DncqhmdW9grfHw66YMKKwxt07L3un3N16Rnzc5uBO27ycFl/byWUKtUdbXXNxyqgd1v7RbHgoHXQ+wCB6l9RVB9tbVWQ1ngBJVLDkPPG2XJYLHJ5FW79aTCu+te/xHcUOIqohnVBeBzthp59iPMlctAf2QKxUrCtUGQdCBeLT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 19:05:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Fri, 24 May 2024
 19:05:30 +0000
Date: Fri, 24 May 2024 12:05:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <mahesh.natu@intel.com>, <rafael@kernel.org>,
	<Jonathan.Cameron@huawei.com>
Subject: [ACPI Code First ECN] "Extended-linear" addressing for direct-mapped
 memory-side caches
Message-ID: <6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: a489ed55-4e6e-4fd9-ea21-08dc7c247ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJN7cvzKKmNqS1l+O9peYbdFq9c+8XZc3RlMxw4ChoOgRDEsHfNZ6h+5mzam?=
 =?us-ascii?Q?9kUkq/b0TJzd3MVNoilOVPqXWU+4qXkHvY8wPVzlaIjVgWmQa811OByjUxt+?=
 =?us-ascii?Q?B4LklUXvSTGWQ5CFaP03Ue3hWdDdA4Qo3QNjJxlxJyXDVfG/mO56EZ19wwOh?=
 =?us-ascii?Q?yfjIwfyFFjqEp94QkguiRPQmpv4IEaEvmqCk7/poUMlqbn2q74wmuk1DApea?=
 =?us-ascii?Q?1TmBPD9VOaIQGpsi0d/FFsdLZpcXFuX4miQshWgXMhfcQGuwghoYqZFR6tZJ?=
 =?us-ascii?Q?+nGV954Bj4ghrUjEymHMflSkEyscMx5yNspNF4vroJAK4myBTTYKFCttjFEE?=
 =?us-ascii?Q?1EWBPkHxN6s2av4STvznUxUTSmXflibJGru+nmBTyic3dHNRLLznsD/6pEu7?=
 =?us-ascii?Q?uS5E8fkMEndSJkR1rdxCIEAPRdwPKO78WvDeMIezw5FF2WUwLyUW+FV52X+l?=
 =?us-ascii?Q?jHm90qqdCW7cDAvoPFV+uWCzElgZqGay/L6Jug44vlLsOQMaWY4Sh9VUz5QN?=
 =?us-ascii?Q?BdHdd8yy6szGbcPGJ69SIKImrHqMZrr1oAe7TwgxuCpWj11i7GQSh/YJly+C?=
 =?us-ascii?Q?LswpMJ8ripGuVOdJxyqe+lFr5MqcjpR+eyp9Ept2+7ztRjPKSwzTqeMmqmU1?=
 =?us-ascii?Q?wvbb/5L18mdWX/crL8FrT8kys1Dn8EOiHtvAL1bLO8wYyRuJwRRMqtvOyIo7?=
 =?us-ascii?Q?8dG5epjFp0o3HtBXtjQ7ILzcP93QoPYZ8qP61uzGPntu5pqma+QEjETxsmRC?=
 =?us-ascii?Q?itlzJSpCsGzilqlg03AABykJa4wHzOSx005NMJ15CEI5RyvfaXhwNLl3Dnwz?=
 =?us-ascii?Q?aEvLbqtMf+ZCPAfdHz+NZOZUvr50ZVABXPo9iJO+k4Ttm9D8afzLIPSMbeSK?=
 =?us-ascii?Q?ST/VpyC3vPd9E6DAPGEoYZ1xA63bIB4IcbFKHClJaB9XqzpImFILOibHGV+n?=
 =?us-ascii?Q?GyvYY0OEBW7ZvRZtzJg1wX7YRiBP5IrBWWnps2ruVp9/2lT6KHP1KacJ4niL?=
 =?us-ascii?Q?kgAS+K8G3BjWaR3D7et2uLgQNKu9xb30qYQ+94JjduveuJtyaOACsBk4ri04?=
 =?us-ascii?Q?cwO5LoaFRUP9wkP7L96nHCiGNV6ybHYuaCjc2xAaDYIzceSMdKICjKSWynBR?=
 =?us-ascii?Q?ePDEHl6zeuV1hRE5pAmUAkzNdXpOLiC4RlN33dCFFmzgYC1WEngPo1dHFJMx?=
 =?us-ascii?Q?mEEPPehBe77EEA5ixBuF1gk6TW6i9eNiex0tkFHEQgv1zAEsCDu8KqAnPVo?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zdOtLju0ODGIlyrWobC1WFD7z/TFh0LOqFQAxeIVn+fGZetU0YUg6nw4dulC?=
 =?us-ascii?Q?OiniPc/ryCzG7MH77nni8w+hyIiqyyAogDcuLSeJvUqho+mYmxYIa6iCIA7x?=
 =?us-ascii?Q?SmMCx8YR0CHKT0IUOT4/Sc8uDqX5HTvAENXnWOfS16/qmodXRPfGwhq4+/L1?=
 =?us-ascii?Q?F+3ZXua8EbVxBeqMNoA939pM7Jxb3wDkq0sHaBhKoXpneHhABLvEqhmnuHa6?=
 =?us-ascii?Q?hO4rLMq2YLrsih8MZaPv+CMkxMkWuC5TInMLOtTrufUnAphdEBVMjhqATNJb?=
 =?us-ascii?Q?xvSZbBY2mZ6pEWQKSzp5zv8LSj4tWIZho/EEI8jUZLWw4HsmwQS0uoxYL+6G?=
 =?us-ascii?Q?ve65cyh4+1orVF1iaMyBCF5ACws6/8lKWuvvCaqGnz4TJl3OItds2EosmRKq?=
 =?us-ascii?Q?AJGO97lQJfJZ6clFPBN9SU+8kO8K6r9YVvZkjXFgmWGQEe7+mAcIC3L8CB20?=
 =?us-ascii?Q?GmLFUdcpPT/sjmVSIJEAgLxOCZ3H2nPNW/wyBWiGggGYCy7n1qOvt9c6Kvx+?=
 =?us-ascii?Q?G7Ct64y/YzaBSMXjZi+3dxaAuybNlrdb+SBVof3nBebp2xIedcn8eutgi6xH?=
 =?us-ascii?Q?Rpm/NpXX4DWgfsUWMyLF30L1zxC7Jvp8aP9/HpxMoQRFHKtimUluU+uokn3h?=
 =?us-ascii?Q?zapUaDi45Ns5+QaM4E+8nE4hFAzYW823gy27d6fBGc1S1UABxYjYzCjCO2Nn?=
 =?us-ascii?Q?FpUisre+W6uivv2ImAQemQP5pLvyMBlw68aYhswwmcp6mJHPvvQLbCsV1oJr?=
 =?us-ascii?Q?njQkxEKU18GrW5sdDoPrTD6uwnS1G8QYgRh7Pd2OAg4Ca+VSK9XkZAWUxhDG?=
 =?us-ascii?Q?sBUaWkIlYLvMn+ssCxuNU32kmQDYxfPzPbkwIN3O+T5tht/gvkJD1CefbrEL?=
 =?us-ascii?Q?EhsQSxJl8Al3vM5p9z8crAabWKfyo23t5dQsOmI0sUBJR3hYUzPikDNADvC0?=
 =?us-ascii?Q?gij3NlLO3Evt0BT9qYB67KQGpc9ZOCqT47s3WIw+UzWtg1sKHtDtEkFWM6Za?=
 =?us-ascii?Q?3EIE0sOEa0J3mniRcGDDhGN3fe1xlkqaofcdbjxuNl0TzyVj6JDsmzbSAfil?=
 =?us-ascii?Q?656qsMmQOJ4vsaaDbTLpiQh1yvHZhB8SqMSObIXi76Ed6FGhnJllrwatT5Mb?=
 =?us-ascii?Q?grl4qDadWYenje+FE1xwpuTOrrz63RQrLmcSg6BEhTsbQnmmpup7F8zZUI/f?=
 =?us-ascii?Q?+l/a6dlAxWIyicmtOtHTZcDrGiA47FiUbLzRcsxQ0dR3At9ixs9GHfRSmABw?=
 =?us-ascii?Q?/mM07B0PqwMAdgcTdO3QLFoQ4g779cFC/moAQgJxLYe+2RYlsAIVszYpDe1k?=
 =?us-ascii?Q?/aS85LvxfU38lw2FOLZ6wBkJqKe7gE8v51/bd+hJNpCJiXSrnxgnnzXPzKoX?=
 =?us-ascii?Q?uJBuPthmybvAsv29l8jTFFJl4RdMhsnm2q79IEV2izeu0PHdqUyhbWhAzxkf?=
 =?us-ascii?Q?KfdYLQc+2NApe+hbTg7y+A241Hb6kBdVPWFz0fcMudy79J104YQ7Z+ZBqDFy?=
 =?us-ascii?Q?N1zO+zs5X/qUc9GKnFMetqdLhcN5ZHmkRNZ56Z4sQgz5lF5Hfe66SL4lVc0b?=
 =?us-ascii?Q?xnkYcalYNIW23HTvgeA4jstIf62n6jOdEfJ2cmMGPzmyL32hN5Mwlpvsh/w6?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a489ed55-4e6e-4fd9-ea21-08dc7c247ade
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 19:05:30.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xwFcjyk2uZPFzbbHq4gpCmnsk4/Tnq6p1JxHAjF5BI5lp1Z/XRfNddNyMrmy2yg/q8sL6ikVhyijCdoMJI2sShESEbkAuEIcGDaCFcYjgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-OriginatorOrg: intel.com

# Title: "Extended-linear" addressing for direct-mapped memory-side caches

# Status: v3

# Document: ACPI Specification 6.6

# License
SPDX-License Identifier: CC-BY-4.0

# Submitter:
* Sponsor: Dan Williams, Intel
* Creators/Contributors:
    * Andy Rudoff, retired
    * Mahesh Natu, Intel
    * Ishwar Agarwal, Intel

# Changelog
* v3: Replace "Inclusive Linear" with "Extended-linear" term, and
  clarify the SPA vs HPA behavior of this cache addressing mode.
  (Jonathan Cameron)
* v2: Clarify the "Inclusive" term as "including the capacity of the cache
  in the SRAT range length"
* v2: Clarify that 0 is an undeclared / transparent Address Mode, and
  that Address Mode values other than 1 are Reserved.

# Summary of the Change
Recall that one of the modes available with persistent memory (PMEM) was a
direct-mapped memory-side cache where DDR-memory transparently cached
PMEM. This article has more details:

https://thessdguy.com/intels-optane-two-confusing-modes-part-2-memory-mode/

...but the main takeaway of that article that is relevant for this ECN
is:

    "[PMEM] is paired with a DRAM that behaves as a cache, and,
     like a cache, it is invisible to the user. [..] A typical system
     might combine a 64GB DRAM DIMM with a 512GB Optane DIMM, but the
     total memory size will appear to the software as only 512GB."

Instead, this new "extended-linear" direct-mapped memory-side cache
addressing mode would make the memory-size that appears to software in
the above example as 576GB. The inclusion of the DDR capacity to extend
the capacity visible to software may improve cache utilization.

A primary motiviation for updating HMAT to explicitly enumerate this
addressing mode is due to the OSPM's increased role for RAS and
address-translation with CXL topologies. With CXL and OS native RAS
flows OSPM is responsible for understanding and navigating the
relationship between System-Physical-Address (SPA) ranges published
ACPI.SRAT.MemoryAffinity, Host-Physical-Address ranges (HPA) published
in the ACPI.CEDT.CFMWS, and HPAs programmed in CXL memory expander
endpoints.

Enable an OSPM to enumerate that the capacity for a memory-side cache
extends an SRAT range. Typically the "Memory Side Cache Size" enumerated
in the HMAT is "excluded" from the SRAT range length because it is a
transparent cache of the SRAT capacity. The enumeration of this
addressing mode enables OSPM-memory-RAS (Reliability, Availability, and
Serviceability) flows.

# Benefits of the Change
Without this change an OSPM that encounters a memory-side cache
configuration of DDR fronting CXL may not understand that an SRAT range
extended by cache capacity should be maintained as one contiguous SPA
range even though the CXL HPA decode configuration only maps a subset of
the SRAT SPA range. In other words the memory-side-cache dynamically
maps access to that SPA range to either a CXL or DDR HPA.

When the OSPM knows about this relationship it can take actions like
quarantine / offline all the impacted aliased pages to prevent further
consumption of poison, or run repair operations on all the affected
targets. Without this change an OSPM may not accurately identify the HPA
associated with a given CXL endpoint DPA event, or it may misunderstand
the SPAs that map to CXL HPAs.

# Impact of the Change
The proposed "Address Mode" field consumes the 2 Reserved bytes
following the "Cache Attributes" field in the "Memory Side Cache
Information Structure". The default reserved value of 0 indicates the
status quo of an undeclared addressing mode where the expectation is
that it is safe to assume the cache-capacity is transparent to the SRAT
range capacity. An OSPM that knows about new values can consider SPA to
HPA relationships according to the address-layout definition proposed
below. A legacy OSPM will ignore it as a Reserved field.

# References
* Compute Express Link Specification v3.1,
<https://www.computeexpresslink.org/>

# Detailed Description of the Change

* Section Table 5.149: Memory Side Cache Information Structure redefine
  the 2 Reserved bytes starting at offset 28 as "Address Mode":

    * 0 - Reserved (OSPM may assume transparent cache addressing)
    * 1 - Extended-linear (N direct-map aliases linearly mapped)
    * 2..65535 - Reserved (Unknown Address Mode)

* Extend the implementation note after Table 5.149 to explain how to
  interpret the "Extended-linear" mode.

  * When Address Mode is 1 'Extended-Linear' it indicates that the
    associated address range (SRAT.MemoryAffinityStructure.Length) is
    comprised of the backing store capacity extended by the cache
    capacity. It is arranged such that there are N directly addressable
    aliases of a given cacheline where N is the ratio of target memory
    proximity domain size and the memory side cache size. Where the N
    aliased addresses for a given cacheline all share the same result
    for the operation 'address modulo cache size'. This setting is only
    allowed when 'Cache Associativity' is 'Direct Map'."

