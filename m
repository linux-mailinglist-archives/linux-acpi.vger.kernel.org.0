Return-Path: <linux-acpi+bounces-21384-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F4kGbTlqGk3ygAAu9opvQ
	(envelope-from <linux-acpi+bounces-21384-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 03:08:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0A20A186
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 03:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CBD33013892
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A61A8F84;
	Thu,  5 Mar 2026 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAHdHwAh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8E29A1;
	Thu,  5 Mar 2026 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676527; cv=fail; b=Opp37DlV31tuueH4iwYuCTE/xHvmMcGPeKgh8WiFAC04xnn7ylwLXj8wUeYZmnJfoB6JjHrQLNCto16xN7eDQhSWv4vBEt4vkGI/RzHxK28/R7rwD6nuDg5ZB4ZnaXenHSLMr/RAGUNN5wT3ZQz5NvrS5wRltl105kMwF/GrrBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676527; c=relaxed/simple;
	bh=ZQtEfEyUD/6/OhDb1iC1ux6p3Iy94U7Xllu0ucNU5lw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=oX4ZSgNFtj0Dh7Bt5S9PLdw8QezOrMRQjTCjhK2LGhsPb5t+HUcUrqtb0M8ZZf/S4IF/tAx/xIZE/N7W2WvWMLXC+xut1lGMw8rPmRdbj4i/0AN59iwCWfwrfOEGJ+hbT/Ttb1TCL3agN7nmnbEs5F64avcwh92WS+z7eYCXQ4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAHdHwAh; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772676524; x=1804212524;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ZQtEfEyUD/6/OhDb1iC1ux6p3Iy94U7Xllu0ucNU5lw=;
  b=ZAHdHwAh7AKTSRJdjmHCNNUVKtXNHRaiJbaR0qjac+QFOpCGuQFdDiHJ
   yUo+rLyZ3XcwEoQCQJHkQMmhWC2XNpUikzlOA0tvRVvkCKPP8m17kS9mC
   HqwZIuWpRQa3UAypU/5ZkmM3kiajpJi6WQFTddH0+v/SFx4TGGF0TU6H1
   UM4FWWL+E/njIgS4wCx0UEEt6urnapZF7NRoinGX48CEbWmjD7qXwTBzs
   wUrkup0+IMQ1Y5sD/39ofllj6BRpqxAW8HB6D3TK9e/p2CLV3z3fL4iI0
   ykg6T3Ft/IbJmgCDN46Ezmj39chV3cfWSb/5Ip6tsHbf5wsBT0y1DoJAk
   A==;
X-CSE-ConnectionGUID: lcLtClClSQSUVCErg+uvyQ==
X-CSE-MsgGUID: i8yhh+pmSY2IoByLX355uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91143975"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="91143975"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 18:08:44 -0800
X-CSE-ConnectionGUID: fEQY5X6RQRiRfPs/nzbG4Q==
X-CSE-MsgGUID: eV403TqqTMqfP+3MUQ+JOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="218518832"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 18:08:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 18:08:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 18:08:42 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 18:08:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWOpIrqzgcJMXk9rgFRCwlg0ftV/YcNAj5vLmkrIsO+wFPKccDiYMigWEWvn5CHqFrT7EvF5keRvbSodsQ2XYeJDUXGaiGvR4njaafBIGgikhlOoMbVDKDOa5nNTTExLkiMNr+/s8oNVLfEE01S77tQw9LEqhegtwJ1zCcJuUVulpiyP+qmzWHPpupSnEN2SzxB01SaCf8ikGe7thjVxOA3De/BE3yCZBv5ileYsY8qi9s8eAeEUJJTiWuXlsemInQ1frf8n/JTygHV9wVHaN2kLre7Hnl66y6zwVuQemGEXMI0Lh97WyNJcfWMrMNZfpUvWw2oSBx5dh0ybJwaD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fao3WdA1rvNTn37bF8dRjSGM0cqX3ZS5HOyhnmr8H8c=;
 b=gjdHGz0GwlI6QzHJc1TUxXOqkpnFS/9koci30rri/eJVcBtx2Jl4rx7IPtF8aFwdYQApmZYz4MYi6wAYt17vceuhuREkO/zQJGFjyKBWQPzf2Cd+aeNdXSZcan9h/LFJskIYm22FHbcuh9QTmV4YjWSiUR2qr1vpHigBsilPBVNbB/8w/W/UYUQVQbQSRrKj2Jy5MpyQsYAl0r0XMYOA+tSHDWbjSjB4cTiVrOw9Kr7avg55ZUAkF5NAsSTV4uDFedSfDnbVRNuCP0cjsydpTV2F+nmCE/Vt+/4lfV/h6BOf/weLRtOvXE+UjXIPIEvQN+q0avOV9rflYfzxoL6i1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Thu, 5 Mar 2026 02:08:39 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 02:08:39 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Mar 2026 18:08:36 -0800
To: "Huang, Kai" <kai.huang@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "gourry@gourry.net" <gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "Schofield, Alison"
	<alison.schofield@intel.com>, "thorsten.blum@linux.dev"
	<thorsten.blum@linux.dev>, "wangyuquan1236@phytium.com.cn"
	<wangyuquan1236@phytium.com.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
Message-ID: <69a8e5a4d2372_2f4a10056@dwillia2-mobl4.notmuch>
In-Reply-To: <bf78a2ee58e99e1fab9df3b5406f20edf9420415.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
 <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
 <bf78a2ee58e99e1fab9df3b5406f20edf9420415.camel@intel.com>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d39ae82-47be-4fca-052b-08de7a5c1d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: U1pUsDUnZGQdh87t7MO1mUd8cLUgREDSX9X/jxKd3JBMiT5F965AAimGVdKQ8JXop95QP8ctKzFqdaOlJ99wG2wbTu1Kx67e6b+XgZ9BHiIpfmPhqp/R5kbuKwiwMsVChc1IuZBBT0yHXmuaQhfbq4TWh+bx2P+QF6JOvKplP0sSwKVcWpxqMSCt1f6K6cceYm4Up7G+wqqZVjzzaQJlDyiUT9ZQTQLv1Wrn60D7FObGRU3J4Tb35eBcG8hXTQylvlLe7NJW7iyrm/EZh1v0FkqgwWuIPOG5NSOcTOlKkzvKIswwZtVh7bSYIHhUJEr9XjK/UXRfDfDgjJ5a0N5wh/2EGNxVJS+zi+ChdRNooByJfKWZIjzBBVY1kuOuQkbtvIWqDyVgdBGh1LFqHnt6JRiD9pE8be5qmC92XTTXh749HhqlUW+5eXG2g7OrNveSIOY9XTY8Af5/tlhOZyh9nT5FxgLV3nMITdUPq7LGQ5fk1QzvPp6d+WfD4rcWwxb04Rd8YKBjxPed7k37x9T3M063UMWTYeVxk7nvTKNZfGEwNOpHxsJPEriwjaRndqMGPR1HYhbqHgWhLwLqsuqsYuvWHwHOONZ6ZGRw+kCxkvvQ4l1tsdOSjv/f4OgW1ZNAERjrKHaH86dp4PlXnEa82o7+yD3v4n5RV+WmZEVRXcPGZm/zsnEOitERTD7MPnzNPZaooAlZc977+BUgwrKNfGKWQGRdfDx0Tew6ziylZdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUx4TW5oNUk1dng2a2RHY0RTS1BHYnhVMm9naG03ZVhaRGdUd2xkbE5FWVhD?=
 =?utf-8?B?di9lN3NSUWJOQ3RTL01JcEdWWTYwS0g4RjNtNXMyUFNUbjhGL1QzamFodTJx?=
 =?utf-8?B?RmZ4ZnRMSXBYYWp6K1lZa2tlNy9YQTN1cjcxczh4VUk3VVgveERQQzk3NFF2?=
 =?utf-8?B?ek1yOFNZQXAxL0tKSThuZjhia1JDblBTMXlML3NqeXYwS0EzT2JDakVheUU0?=
 =?utf-8?B?WGZYRE1FZWlvcTlpa1NxTUJRNUNUN05XRUhoZG8rTVorTHplV2Mwa2IzRHg0?=
 =?utf-8?B?akI2b3dFQ0tIblFjNlhlelhBUW5SUTJuUFROREU4SHc0YUZ5blVsbk4yNURY?=
 =?utf-8?B?SGdKZDV2N0x6YjBMSGwrZVg0UDJwalVRTm5DY21WZllRTDUyTDlZRXdMelpl?=
 =?utf-8?B?YjE0alhjSDhNU0VDZnUybnVNNmQ4SHVhMUxOM0ZWaDR5RkhVWlRONkJtYVly?=
 =?utf-8?B?dDErY0pEaC9ORHNZeEJnNzc4cytmRStnQVMxODEvbGVjT0VSTDE4SFZLVkdN?=
 =?utf-8?B?bVlSdDFLYkNOUVJjWVU4dVRNS3NRWEQ3L0tiaGgwRDlyMTFORS9mR256c3hV?=
 =?utf-8?B?WDlmeCsxS2J3L0JYMk84YnBJc1FWRnp3Z0lxWVJFb3lHNVJMQ3N3Nzg1TTV3?=
 =?utf-8?B?Njk1S3ZMMVY1K3MzOFRNb3dCSXpzaldEajNOL0FzS24yREhJcUhxdEljQXM3?=
 =?utf-8?B?NlE2eGpXYSthTXdmYW1FaDRaQXRLZWM4TkppS3dibWUwRzNqM3Q3UUM3ODhS?=
 =?utf-8?B?d05iWTcrcDRzbFJ0NW5yRHpVZlhpNHRFV3hTM1ovNzNOUjZYLy8walVtSE5p?=
 =?utf-8?B?aWJ3NTg1WkpjaG9QWGxaNHFDaFB1K1FMa1FYYzJkM1lEanIxZWoycHpXLzFy?=
 =?utf-8?B?T2tTaEJuc0cyQmI3UVAzZ3NWdU1jK3V5N2NUNU1KUGZjWDEzK3cxZ21CMjFq?=
 =?utf-8?B?VEtwL3hVVkxQUmlPaWQ0VlJZMS9OT0NDeFplSnZzakdUZ0FsUWNSdCtQcjJm?=
 =?utf-8?B?SURmN0VmNm83ZEZoTndBRjV3b2hlVk5ESXZ5cCtIRjNoQ05HYW8rT0U4SFJi?=
 =?utf-8?B?MXNIbHJYM1pDUlkrZDdYSzREazJGNkpPY200WGJySGdIdTZEM0g5c0l6NlYy?=
 =?utf-8?B?bytRYjNoTHN3dUxDc1RUYkxqdjdtem1XSDdVS0lEYk9XUnhEeTcrajZFbldi?=
 =?utf-8?B?a0d1bEl1ZjZ3SEZWK3NzUDlJSWUvaVlocjhvTEdjVW9WOGV6T2dwaDRIUVY3?=
 =?utf-8?B?QnhZOWgxUmJlTTFZbmd3dDExYjRNeVQycHVwZzZKVFV0MkRlTFFzSTJkWHZQ?=
 =?utf-8?B?UTVCR29INkt5aUx4cTNoRFM0VFJSQmN3Ujg4MEdLZ01NSWtNUWlJUVdsaWRD?=
 =?utf-8?B?TjY1cEtWOTZhYlE2S2d0UEFmRWVmeE5QYTE2SFcwNkZBZE9KR3JxR1lSdjVH?=
 =?utf-8?B?N1NIaE5WbFNqakx0bzM5UkRkSnFUazMrVTFYc0hzZTV6cXdxOUFzcDk1MWRY?=
 =?utf-8?B?M3Q3TmRYUkwrQm4wWHJaUGYxTVBuV01zWW96T0tXRExCZ3RZdUhBWmlMSzQz?=
 =?utf-8?B?aGF5aHlFL0E4dSt4Q1htM2lPVjh1SitUSi93SDRjWHlrcW9LRXFZME1LU3JB?=
 =?utf-8?B?NFJlNk41NTBPR0w5VFZXMUxqYVhXWHRIdmRlYlUzdHJ5dklrWHJyYk4ybGRD?=
 =?utf-8?B?MGM4dDhGTGxYY0x0WHRpcjg4dmYvZkdBNFRJTnNmQTV1alV3M1ltUmZrOTQ1?=
 =?utf-8?B?M3JLdUsxYmc4cEt2dmZPU2Nnd3hSZCtXRXdiVUJnSzFvR1QvN2M2VEtQRzZB?=
 =?utf-8?B?dVp2amtUVks2bDViNlo5cHhxbExMRjFib1VVOHE4TWduOUpWWGRwRDg0Mytx?=
 =?utf-8?B?cVExZ29JeGFreHNEWHZrcGVlNjhXVGhqZVladmFpT0EvSm83bEsraWpUanRQ?=
 =?utf-8?B?VXJwS0N3MnNNRWJzWmhqS1I5S3dCWlk4bmxobXd3RDBtUFJYV244QXBmN0dx?=
 =?utf-8?B?VlpFRWdKL1RZZCt3RFJWM1dlN0hVTndZUWQwd3dFSlROYkxUSFR4aU4vR1VD?=
 =?utf-8?B?WUdsTmUrVlk1TFpncHA1OURjdGUrc1Rid3YyZ001SzI2SEg2dVE5R2xxcjBq?=
 =?utf-8?B?eWFpeVllOFNiY1p0NU1VNFNTcWhmc1RBMTdYN1FUbWlCcVRldGViYXp4MGxT?=
 =?utf-8?B?WFMyR3J4WXFuN1NDYUNIcjdiMnNCelk3M3IxcVY3S2NOVzUxY2ZqTVkrdmY0?=
 =?utf-8?B?TU00TXlXT1hUYmJjaWxTR0xFNThlT2dTbC9ZQ2hkVGlPbTRXMUlkRFprems2?=
 =?utf-8?B?RUZReWNtS2hTVXN2aVM5c2ZYUnRxRERDblhGR1JJOHJSWDc5SXU5SmFzOUFD?=
 =?utf-8?Q?AdNMeZnQtQndQ0FU=3D?=
X-Exchange-RoutingPolicyChecked: dB6xj3KzyX+JBXFDyYEMfJoVRNvJxmz3VFhiEHT8vny9/tyw1u92Mf+7ZPtmg0/mGr7oVw0sLUxWtvoIx2kiPEbYEZElHUyE2c+K5UGmxTXQqcvO7IjS7rdxq1phKST48hFxQUCuDaTVRWZjGwbkG1Toszr7NTBp2mVGcWNmuuhD5T9Qh8lvUZe0KkeIGMd3Pmm5UKjOCvthMeAxvjHWY7MfH1U9rqmA2yGfyE9tf7aJq0WAg8NdAWv2Ize18XpPA8+JocE5LwFwkLJ9MRqvwPb5xUe2Fm+es2AUGUR9wO2QKovnzPVcIDimVg6BRd7Gq2+iAUFAGTeV3LXMcp2ksg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d39ae82-47be-4fca-052b-08de7a5c1d7b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 02:08:38.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzSu4S2r9EIqzR4sWKnVzoouto8Ng3KsiYiTfkjkB5sB95EhU4bj2Lwjg0pFqSDLjFflU8RHflnohVS3WY3VwwR+k+uv/Lsmo5YTDsLTZOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D2D0A20A186
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21384-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,dwillia2-mobl4.notmuch:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Huang, Kai wrote:
[..]
> > I think it makes sense that if you disable CXL hotplug by setting
> > CONFIG_CXL_ACPI=n then no need to reserve numa ids. However, just do
> > something like this rather than add ifdefs to the code:
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index aa87ee1583a4..62d4a8df0b8c 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -654,8 +654,11 @@ int __init acpi_numa_init(void)
> >  	}
> >  	last_real_pxm = fake_pxm;
> >  	fake_pxm++;
> > -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> > -			      &fake_pxm);
> > +
> > +	/* No need to expand numa nodes if CXL is disabled */
> > +	if (IS_ENABLED(CONFIG_CXL_ACPI))
> > +		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> > +				      &fake_pxm);
> >  
> >  	if (cnt < 0)
> >  		return cnt;
> > 
> > The call to acpi_table_parse_cedt() will get skipped and the code for
> > acpi_parse_cfmws() will get automatically compiled out of the file.
> 
> Yeah agreed this is simpler.  Thanks for the suggestion.
> 
> I would like to honor Gregory's suggestion about the comment since it
> provides more info if you agree?
> 
> (I also added "impacts certain NUMA userspace ABIs")
> 
> /*
>  * Some platforms report CEDT CFMWS for hotplug device support. These
>  * windows are unusable without CXL drivers, so don't reserve fake nodes
>  * if they're compiled out - it wastes memory on per-node structures and
>  * impacts certain NUMA userspace ABIs.
>  */

I feel like this is just too much scary detail for a tiny corner case
that maybe only effects a handful of kernel developers at hardware
companies with advanced server platforms.

    /* No need to expand numa nodes if CXL is disabled */

...is more than sufficient.

> > At the same time I doubt this patch provides end users much value in
> > practice as most distro kernels have CONFIG_CXL_ACPI, and the few end
> > users that have CXL are not going blink at the overhead to support the
> > full feature set.
> > 
> > Can you not just disable CXL support in the BIOS for your system and
> > avoid complicating this code path for a small win?
> 
> Sure I can (I need to figure out how, though).  But I think it's still
> useful for developers because some of them will tend to only enable Kconfig
> options that they need to save build time.
> 
> And sometimes it's not quite easy to turn off CXL in the BIOS since the
> machine would be mostly remote.
> 
> So I think this patch is still worthy to do?

A small 2 line patch to save a few megabytes of memory, sure. A
paragraph of context that almost nobody will ever care about on a go
forward basis? No, thank you.

