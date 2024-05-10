Return-Path: <linux-acpi+bounces-5764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94888C2CCB
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E1B1F223FD
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E76C125;
	Fri, 10 May 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJQjPCeE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176313CFA8;
	Fri, 10 May 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715382034; cv=fail; b=q0ejHcW8EjDl0p3T1x19R7GGQLF4G51IfMRXBwTiLzvMvsX4kxoTCGn/WfmxzLUv1Z8ZaaBVs2kgjYbch0S/i6YlujVlYfxeImhkJfmzgk6Bo4fQs01O++ncDpIiN7d4auDdWU2C1+0P+gOD30LS0jYpTiAsqrWqxEehtlLCDM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715382034; c=relaxed/simple;
	bh=oXwGWd+OzzCAO1H9SZHiRftQJTc26n0xeAGdc1+Pdho=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hdzzax+cj5nMZWK8CtGydE4Qg6rx9v8TZf2fR/NqH5+WntxMram4EOyEBS7T1CIPAfg+PVSnOSmt066x5uUbS1a0K4r8Y7QGI8YXIqm/C+EWEgu6i3fCH76p2zchRG3pL2um9FXt5a992BeZTzdXZFfSq9rFt7p1bO5VK0CxO2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJQjPCeE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715382032; x=1746918032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oXwGWd+OzzCAO1H9SZHiRftQJTc26n0xeAGdc1+Pdho=;
  b=WJQjPCeESk/LPnFpW7fsGq96Qx9kpW0gkERxG6kq5oxYH4f2twHvvUUK
   6WuDWLBqDDKbS3PpLw85PWLrkLFa1B7sRbsNUy31Sn+DJjDMrUFGEvlxs
   bPAG/HTGhPfBPsV8oIBIqcEmN/2xpW8pcwx+hI9qtMKky7fi7Cokj5k39
   0gmTU6XLP7M5OxcxMtorYZsyZ9zPmWp032ukNBsrOSX2qKX49b/oz1tgX
   XMHbnDAolRd1kox5SsQH6rMBVeSmyUewVbb7PPJO5eU5mFf0PXXhQbMRf
   om1ZPPp4c5zqAMSVidW7NX2yLPtItSgGCyhVWwEe1ssdWBgP6M76YGzzP
   Q==;
X-CSE-ConnectionGUID: Js9VJeVvTPCn8ki/eFHLXQ==
X-CSE-MsgGUID: giROmCiNQr2XUoULQ/W68Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22782164"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="22782164"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 16:00:31 -0700
X-CSE-ConnectionGUID: LNWd5240Td61ycSEf0SJbw==
X-CSE-MsgGUID: NsHgmze/QLm16VOZfneCeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="34521413"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 16:00:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 16:00:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 16:00:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 16:00:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnMJZehjj/bUkT6y8jXrCpHwlnreS03dpCOCFeIgglRkdrzs/d7jKfWEq18+vezAB5GOzfMvCV9NJGvIoC3p2fkWLDFSXYCf6HAOirI+RONPhPHOGG73cKX+Mcb/SpGZ6A5N+5Qr/BlUcOJOthyo84D9ojPdO1bZ83dB4VYgYgq0Y/vSbnHwUoRF73lwZB3OumC04Qur8VnuZ4Qilr6GcRPTH6yLasG2ahwWwtM5GmjLrR6dS4K1y5KlroRXLJIZrP2g/k6r24FXxCWSXDz+h/WxtTAEFnDxpV/9Lz4WjEa1vWJ3N208h5vVY4eYe1deg0r4vs9szPUiaDhvDomRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3vwhIubymIQXQHZCNUfDtMdi+lq/+GmRs41eQ60M8M=;
 b=Lu6s2+T8o0fpEoYzZn8J192bWKzEfKZNtuj2SQuCJbFufVQoOfyEyCuF4ljShljJIKeS4lq28HwSe9DM2K6MneTMnOartszr2XBFTMkSm7NgGh29JCYOT7M7KznM5XqymYDc3a7IgmM12yF9P5APN9rzsUQqwClsQLCdB6+oh1vS4UfUMroqHtO5/D9gxDSk+1dLYN64QQqbEX5FXGjlfQOhskftMG6Q8Sy1gXc5TxIKFfDrtiaBHPnj764uh0BkYQlU7ImbHvleNVQkKuMddmdbxYfePHR6cKouHODZmOsJTySiqTRXLtY5/UtZKGCmPzRhOIeXTCBr0IL6G7dR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8535.namprd11.prod.outlook.com (2603:10b6:408:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 10 May
 2024 23:00:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 23:00:26 +0000
Date: Fri, 10 May 2024 16:00:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: [ACPI Code First ECN] Enumerate "Inclusive Linear Address Mode"
 memory-side caches
Message-ID: <663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: dc60dd6a-52d4-4c96-651a-08dc7144fb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KAuzGjCWIJhvq+OnblOdURLm8UQ/1zuHaY9c3ODoyvN9GlFGy8IC1Id4ue9x?=
 =?us-ascii?Q?LPOTLZ4hstWZFuvxrcKPKEjKeqTomGCDDPn0bymCfE16JhBCxl/7MtH0jxIy?=
 =?us-ascii?Q?2uzfBToHUr7KGOMvmf2BtOV2FeHU7al/2fg6wV/z48aKlwaqAt7yzo5i+iW4?=
 =?us-ascii?Q?ZsytNVyea9LOJQN4TQtagP6WQKurlQjSSB2ZSGMfSQlSDGlv286w8qCjcEcg?=
 =?us-ascii?Q?RjAgGucgp4Uw7qZ/ePNAbJA+E8Sx8OX4A0vTxqV7UQhhETy/55dgPGzanFrr?=
 =?us-ascii?Q?SkGmt08T8FCkK6vdPgY7oZ2Rzy5Sv2c0xmvyCnoQyCPZ7pzFDkFTn4Qm53YC?=
 =?us-ascii?Q?2Cu9On0eH+j2eO7BBAJL03XUR8ZYGOshrMhmo0j+C7eEg7C01EiCHJOpcFC+?=
 =?us-ascii?Q?jTcqxQSYsgoPDKyuIZVIWruMCrrdUtwjQndDBkMN4TzzBxyC1eza4p54j30l?=
 =?us-ascii?Q?wj3ee+NTfalEegojvLTwHGXb7qIXvV5lL/pa487vKm811EjWTYdPxDp0yUMs?=
 =?us-ascii?Q?YtyAcHbR6Q1tdJtcpw26YDkBZrtYUwnEBuYQeCawAC7b+/faHEFMDKa3fhSR?=
 =?us-ascii?Q?hMioGgJXop/9D93UUhZ3udklAGHFe//tqa15Ixsd259+pEtSq82/0s6qOh2m?=
 =?us-ascii?Q?okC0uccL4+yc/FRjuEHayEG7Ujcp3A+2QwZsTyFoxqcByMAfE2rKP0mCKWvD?=
 =?us-ascii?Q?AQoYU3EpHWW3fQIC3n0EK13qFlmlA/phx1L6Vevc89Z+ksREnpgJN8l5LAi3?=
 =?us-ascii?Q?6Qoo3P79xrBfHoIt6qtPZvbQIKpSEf/NJtL7IEOCi/toTcXJvlWr/6JIqlUx?=
 =?us-ascii?Q?7+FZu51BzMXVJbhTI7PrUXwKZ3MXq9RnHMrol9W5NWC6SARFsOp0cFWxgZ4O?=
 =?us-ascii?Q?/4ilVYzDWy65bf5FUNRWhfrvLBQOm7FwAv5XDG3xaiPINKmfr11bB7SK40Td?=
 =?us-ascii?Q?GWB8EVV+9irss/EPHPUMrMz4a11XWIlU+5Ly0Z7ELmqBlnrkQYgFwbi7YBRD?=
 =?us-ascii?Q?oKNTa961TimmL5okhhHQQlirbdf+5adODUahDRksqydY2F4MYVdGAG2p+lBF?=
 =?us-ascii?Q?Ig48Yf+8ArxG68BHQoK4g5DyCzsfYPdWfPGfHgAmXNy7M9XhTGdmv3KmrFLR?=
 =?us-ascii?Q?tXbXe2OLrkQZpnLgi5S9VA9hgvbpNagZ9+6PmQGRGOVXn2zlxK6WSTuveapV?=
 =?us-ascii?Q?3ZWgkORxHLnKtz1peys8Cs4dKQ8g3duS/NjxWnIowJ7issHt6y4hFOAmQDA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?daVb1pTAB1RJwUpy3p4aTdcYEKCSOhm7Kxre4tkpWSHgw8lSPzJZ5mo2eOGN?=
 =?us-ascii?Q?0aFkLEpRLAWz8YnXqRTk4uuEfiVY3+ceOW2FkmOw/NaKp+dGe92IH806dZws?=
 =?us-ascii?Q?3yP8cmBIylDZunLRDAR5wvIZuf81GggbUIpLXuBU0wan4hGcF4aCgs5o4Izf?=
 =?us-ascii?Q?43mv9F2QOU3JGZ0pXaRj9dkJCNJJ+cbKIdxacnJrZ6qY4JsoK2Xqo0pUtmx9?=
 =?us-ascii?Q?2fwxINCXJx/eZ4cGhfvJCtxiw07xFuOcJaeeO6pns10bIMLQ2bLtyRPgteX9?=
 =?us-ascii?Q?oqOsKAGDhCx39O/8RaoDCXcR3NQWSjZmnzhL4CUWyfwA7Y/zRGCo3rCgvXuH?=
 =?us-ascii?Q?XfERF3N4zr61kJkFgc5LOwfhMNZj3400tPBf6AJRQFQOHP/eZgA4AEISXrUZ?=
 =?us-ascii?Q?CgRh7qO8uiXVdZP1y08a90rjBMrN6ngiSDJr712+Wfr6N/UycIH4DaJoleSH?=
 =?us-ascii?Q?l/dLCk8b6Cz6Wbv6NswkEdfeQIrcR1NwT5Zd2RxqZGt/PkhOBI9n1f8EX1NE?=
 =?us-ascii?Q?bRETzEhfwK87urbVkfe+Z3PUMJTyr3tbOajcnRjOzZ1I0Ltdd15JZVUy197X?=
 =?us-ascii?Q?RMZJMg8zoc0DT7Yee8Yb3LygisXHW61X8sruL9wBc/HFt608S2dHolPnDGJP?=
 =?us-ascii?Q?ZuqTzT3eO4vyaDq8gJymPM/wAYT8DmGGFM9bOIptoEHmP4Dz/2OS3Hq3a93M?=
 =?us-ascii?Q?vy+y8C8/oVGcuDtvAw8TWavk2lwYcHgEfzq4Nis/TFRINaZa4MxEP6vGQYH1?=
 =?us-ascii?Q?GjMDNBz+e56l1R85WqpgZ/2TLWr6gCnuJs13sFVi4XBosuj1ieZH9el5BPUT?=
 =?us-ascii?Q?dr7O4xkfxVw9kIe6WgpNCMiEL7bp3lV6Ru8fPqkwfi7EAA0mtcirkqo9/Ivl?=
 =?us-ascii?Q?wbGBgOJAMTciGWy/MQUSBtDBCe7RvUo+MGqL34hyMZ6djGI4CUW3dKepAMa1?=
 =?us-ascii?Q?0SHRbZxlHgRBMVZ1j9r2aRirjuw4t5KsDoR9MHe/eQs4AEr0JxNtw27qzsKK?=
 =?us-ascii?Q?pq7UyHirFiV4VYUDxzG4l4eRNHHGokkjNCtkWrT6aSEhTsQtUL3zdH86ax+f?=
 =?us-ascii?Q?d8oVKtmVnNqpLgpPo6V2aUt8ARcblw4Rm7qB7aqVBPr23YgubVLqkj6j+b1X?=
 =?us-ascii?Q?ZGdy3xv58Fsj7KJ+uoQoIRCRAiLWXOCPULIW047DR+HixUQ5CRi3Cp3vg9PN?=
 =?us-ascii?Q?Hek/syHVLI8rHiKaeNS+hrj0wod6l2MC+GAneXm9OBjwSoHuGL8acynAHxvJ?=
 =?us-ascii?Q?WE7aYCypIYZERg4Dx2MnGj3+tXp9OI66wY3CK1mmhwWffDx65eikQEn081+e?=
 =?us-ascii?Q?Z3l/srT4jzydcZfY7IF6La46/empJC63ydU4ULYZYj8WiDOyWDwp1t+RQ0KQ?=
 =?us-ascii?Q?4iCx3NqWe8r6N45OBznmTMxcYnJlYV0QoWMkmkA9HSwD4QnjejydtrJHoUHH?=
 =?us-ascii?Q?97OcO9l515B5hTn/0NEE0ZrCHFb3aUY/Ix+0ikb7bO2VqO5u0C0LyxOxt8qD?=
 =?us-ascii?Q?XjQFlF85l1bH0Ob13maVFHrPmC+qVZB9jc9o8bjzX6zPMK40qqDEolxErpwi?=
 =?us-ascii?Q?iSMTB0lU7SCE9fKTL1UwI76QfpZf9AWJIEAbGxcIQvacr8RJb5r96rON1i5u?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc60dd6a-52d4-4c96-651a-08dc7144fb2b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 23:00:26.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E12M815zDZoEku+xcsuJKmzzNumBhhwRAUw2AidjUykpiXjjvYvoZoTitxkO6d+EbwBOhz4mn/OtsnsORd/TdsXv55U9r3Ye7PflMZXZ4q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8535
X-OriginatorOrg: intel.com

# Title: Enumerate "Inclusive Linear Address Mode" memory-side caches

# Status: Draft v2

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
* v2: Clarify the "Inclusive" term as "including the capacity of the cache
  in the SRAT range length"
* v2: Clarify that 0 is an undeclared / transparent Address Mode, and
  that Address Mode values other than 1 are Reserved.

# Summary of the Change
Enable an OSPM to enumerate that the capacity for a memory-side cache is
"included" in an SRAT range. Typically the "Memory Side Cache Size"
enumerated in the HMAT is "excluded" from the SRAT range length because
it is a transparent cache of the SRAT capacity. The enumeration of this
addressing mode enables OSPM memory RAS (Reliability, Availability, and
Serviceability) flows.

Recall that the CXL specification allows for platform address ranges to
be interleaved across CXL and non-CXL targets. CXL 3.1 Table 9-22 CFMWS
Structure states "If the Interleave Set spans non-CXL domains, this list
may contain values that do not match \_UID field in any CHBS structures.
These entries represent Interleave Targets that are not CXL Host
Bridges". For an OSPM this means address translation needs to be
prepared for non-CXL targets. Now consider the case when that CXL
address range is flagged as a memory side cache in the ACPI HMAT.
Address translation needs to consider that the decode for an error may
impact multiple components (FRUs fields replaceable units).

Now consider the implications of ["Flat Memory Mode" (Intel presentation
at Hot Chips
2023)](https://cdrdv2-public.intel.com/787386/Hot%20Chips%20-%20Aug%2023%20-%20BHS%20and%20Granite%20Rapid%20-%20Xeon%20-%20Architecture%20-%20Public.pdf).
This cache geometry implies an address space that includes the
memory-side cache size in the reported address range. For example, a
typical address space layout for a memory-side-cache of 32GB of DDR
fronting 64GB of CXL would report 64GB in the "Length" field of the
SRAT's "Memory Affinity Structure" and 32GB in the "Memory Side Cache
Size" field of the HMAT's "Memory Side Cache Information Structure". An
inclusive address-space layout of the same configuration would report
96GB in the "Length" field of the SRAT's "Memory Affinity Structure" and
32GB in the "Memory Side Cache Size" field of the HMAT's "Memory Side
Cache Information Structure". The implication for address translation in
the inclusive case, is that there are N potential aliased address
impacted by a memory error where N is the ratio of:

SRAT.MemoryAffinityStructure.Length /
HMAT.MemorySideCacheInformation.CacheSize

This change request is not exclusive to CXL, the concept is applicable
to any memory-side-cache configuration that the HMAT+SRAT can describe.
However, CXL is a primary motivator given the OSPM role in address
translation for device-physical-address (DPA) events being translated to
impacted host-physical-address (HPA) events.

# Benefits of the Change
An OSPM, when it knows about inclusive cache address space, can take
actions like quarantine / offline all the impacted aliased pages to
prevent further consumption of poison, or run repair operations on all
the affected targets. Without this change an OSPM may not accurately
identify the HPA associated with a given CXL FRU event, or it may
misunderstand that an SRAT memory affinity range is an amalgam of CXL
and cache capacity.

# Impact of the Change
The proposed "Address Mode" field to convey this configuration consumes
the 2 Reserved bytes following the "Cache Attributes" field in the
"Memory Side Cache Information Structure". The default reserved value of
0 indicates the status quo of an undeclared addressing mode where the
expectation is that it is safe to assume a transparent cache where the
cache-capacity is not included in the SRAT range capacity. An OSPM that
knows about new values can perform address decode according to the
proposed details below and a legacy OSPM will ignore it as a Reserved
field.

# References
* Compute Express Link Specification v3.1,
<https://www.computeexpresslink.org/>

# Detailed Description of the Change

* Section Table 5.149: Memory Side Cache Information Structure redefine
  the 2 Reserved bytes starting at offset 28 as "Address Mode":

    * 0 - Reserved (OSPM may assume transparent cache addressing)
    * 1 - Inclusive linear (N aliases linearly mapped)
    * 2..65535 - Reserved (Unknown Address Mode)

* Extend the implementation note after Table 5.149 to explain how to
  interpret the "Inclusive linear" mode.

    * "When Address Mode is 1 'Inclusive Linear' it indicates that there
      are N directly addressable aliases of a given cacheline
      where N is the ratio of target memory proximity domain size and
      the memory side cache size.  Where the N aliased addresses for a
      given cacheline all share the same result for the operation
      'address modulo cache size'."

