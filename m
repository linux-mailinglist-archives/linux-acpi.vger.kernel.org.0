Return-Path: <linux-acpi+bounces-7757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F6795950C
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 08:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E2E1F2112A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 06:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB2186608;
	Wed, 21 Aug 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC6Y9jzX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883C1865FD;
	Wed, 21 Aug 2024 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222948; cv=fail; b=nXsAOJOIdavZvEi4rPyH2a2SzyTt6JKSL39UgVlnWPKLISCkAFtJ8qf1QS3r+lr3o8L/ZPbBhk2RSP4gy9PpopiD1vRPKqTVrQrhBkHHbqQEM7QZP5ph2jlBlyOYZAUVv2gQSQsyqUT9ifDXkPWhbxyEAG4qzfZaLp3N3MO5bj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222948; c=relaxed/simple;
	bh=AEQfUWJNiwUKBArQWTjpxTvVj6L7s+W6r2CMcAKbHcw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=px0OQjWPBDBjOyw5EkSu+JRIWfpo6+CCTC7e2DXnAKhHBc1px2VQXb0mHE1y7voDAgB9iT8i1RFt/zm0GnO1vN7N3jBRezo2NtJOjPV4S3b8o0wVeJyK+DC8e8mcpSahYhv1xv0Tbo3ia6PbtnaGzlc2MiAx7TF+De4LyIIZAA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC6Y9jzX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724222947; x=1755758947;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=AEQfUWJNiwUKBArQWTjpxTvVj6L7s+W6r2CMcAKbHcw=;
  b=XC6Y9jzXoNYd3IsvfvmyNvouhSYqTEvkb0FmcJLmk2D1L+l8AC50g+Qy
   xNzI9buV4XDMn7qX60nQVA8GUEOxIy1NiIGOTF7ugQpO0P1ruIeIelGyx
   pq8J2gV582czfYxW1+gJoeDuvqX5akmZ7aBah5E/0XwubRrYTsPGOYrIt
   o22j0+KQ30yGo+Y4cD+mLMs9ZpXmcfcTObRxhtrHFHTTkFZDgTz4OVqTo
   DyUa5Y3OE00ZiuwEvhBi20oKXPYmLwOBbDfBiEWLb+4tf5lf8FZJ5q2qM
   Fm7ob5Hdb7LBL8jaQTBDba4655Q3R23PBcHsS5fAcZ349CRzodORI8y7t
   A==;
X-CSE-ConnectionGUID: XJYNWKfhQrGvsvV3dQsMhw==
X-CSE-MsgGUID: 6gSrMpuXSO+4WP7wOHqMTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33131830"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33131830"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 23:49:06 -0700
X-CSE-ConnectionGUID: EyUc5Um/Teq+nX5EBHOHCw==
X-CSE-MsgGUID: KEtT/9H7RIG2pJqTymNf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65833286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 23:49:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:49:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:49:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 23:49:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 23:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atNMdmnxIDP+JDMTMzQWX5tnUn81CegYP2lLmXEiI6f7PZb0wWqc37JhHbHbxRnoRlS820uPTU3dZHyZscmkeg2QdeyB2y8H0EWc5bbpm7sqpcCoGIdshzWBaE0zPYUK2BI0igQQUozN2ZZz8Cz3OYBaoxcKu15zGoJuDauyYlvn+yMUMQusd1guhGiPjH42zAPAlVOhiXXXnwHR5ACyqedyxZA3iJKR7BPRj9+7NuNLuyHMiB+6PQnFEnEktVA0XnHelWyoUWMsmG/ZtDg7vSGvXhhmjB5rbaZUxCaaDm09lxH/qm+b5sRNydxed8uJLQYMLI9Ga0YTA/k5bK642g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEQfUWJNiwUKBArQWTjpxTvVj6L7s+W6r2CMcAKbHcw=;
 b=axdu3N9OQULzVLb3v1AOEZwJogNdbDZA8p1wlQmWG00WtHtA6F4z3sG9ZlGR951ar46jrrooUtWEaiDR+z1BwVUTRZBx7PZUbAwCa0UpN8x3VTYOcKSm0yXM4h+C/ysuwYtgSsO+OueNUr8Fg978NN31TbFo0Gy1y0UgKXbuLQZfwM1gVVUbWdTAJ5ql21kpKNAPpINGtxI0+YnzHbBKj2RZusI3sK3dOPyor6UsxscaoPhao7vu77hsp+k7l4GZPFeCR3UeNmMW1CaW7OzYa9jW3D6l9O/2LXcYNZM46kzSbbDAaWFCKmuaSui2zaQGGmrdyhs8rKShZb0ZAfZTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CO1PR11MB5153.namprd11.prod.outlook.com (2603:10b6:303:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 06:48:59 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 06:48:59 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "mochs@nvidia.com" <mochs@nvidia.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "erik.kaneda@intel.com"
	<erik.kaneda@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Ko, Koba" <kobak@nvidia.com>
Subject: Re: [PATCH] acpi/prmt: find block with specific type
Thread-Topic: [PATCH] acpi/prmt: find block with specific type
Thread-Index: AQHa47zv/FjSqarIqkGArXguHN663bIxKsIAgAALQ4CAAA8qgIAADrMAgAAMxICAAADKgIAAA3qA
Date: Wed, 21 Aug 2024 06:48:59 +0000
Message-ID: <13f458859adcb75d0930f1a76d7c0e2f74f5e7d5.camel@intel.com>
References: <20240801014853.1594699-1-kobak@nvidia.com>
	 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
	 <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
	 <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
	 <f6e581e1-2d24-4587-a193-bfeaf1a3cb1a@nvidia.com>
	 <4ea0db68415445e5aab405438bbd8ce4240d7ee4.camel@intel.com>
	 <519e8e00-cd82-485f-8871-81fb703c7592@nvidia.com>
In-Reply-To: <519e8e00-cd82-485f-8871-81fb703c7592@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CO1PR11MB5153:EE_
x-ms-office365-filtering-correlation-id: cacbf4f1-6dfa-4121-89bd-08dcc1ad55d4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MjdtcEZPbmdBM0tWbEhTWG9Hd1hpempBSVR4L3cranhOLzN6SFczOXRvQkQ5?=
 =?utf-8?B?dng3VXNGME5oYnA1V3k1S013UmtjVVIzUEVGN1NENE5BVnJUWEV0UGZhWXRH?=
 =?utf-8?B?ZWpxWnhzVzlOWHpkUjN1TEYwU21teFh0akhSejdPUFE4UWFMV0IyQkN2bTFX?=
 =?utf-8?B?aldaOTFIenhFUzJxTzR0VTFuMW9aQ0hxM3RIdHhlNDRtblJ6MmVUVUZCQm9E?=
 =?utf-8?B?ajVwalMxSzlzemQ2OU5aNHZCYkg2OTNRc0ovdUVaaWNLRTlQU1ZvWS8xaE5D?=
 =?utf-8?B?bHJUd0ZYMjhndjdPcExSTldISG5OOW1pTEVBTkNabnFvZ3lBNklaR0dha0lx?=
 =?utf-8?B?R1VWQmdsTy9YeWZ0b0lwN0JsejY5UURkTnZycStVY1BQOTMyQUZQNTZJQ1lm?=
 =?utf-8?B?WXZWL2MrQk5PdFlCaG5YWjVMdkxibXJZNG1KR2FRZFhWTVQxQi9QbWtVMUp6?=
 =?utf-8?B?UzZLa3RtOUJndGNBUlEyem9wUTIxUGx1S1lLQjAwbWlENGNmNDZESWZReHJN?=
 =?utf-8?B?WUhsTjJ5ejdNckhxWTEvU01aR0k0TmtNM29sUFhGeUVubnRUZEZTWEdEbjdZ?=
 =?utf-8?B?MTIxSXJLeXdVcFZ2U0h6dkNJek9PMWU0alpleGtWUjd0bTBiNmNEdE9sL3FZ?=
 =?utf-8?B?VllLYzlmNEtLOUkzdVViNjZXQnQvNmpPZVpkUm8wU3g0blIxR2hRQTJLbTl3?=
 =?utf-8?B?aFozMEVwRzFpSy9hbUJLN0ZmTFRBdzNKUHdyOHVqb3NrVXA3MkJVS2VjWnk4?=
 =?utf-8?B?S2lHaW5lVlcrRnBtR21tK1dYdjNjWlpHQUdjUlhwYUkwTFVXTFVwZlVpSGpQ?=
 =?utf-8?B?NEVlQTRsODdrYnZ6akduM2cyOHFqeSsxUFZhc1lKMTVqbXQ4SnJKR1NvZUFo?=
 =?utf-8?B?ZmNkbFZ2bG5qaXEySS9MQ3ZlVzB5SFBtN3lZTWNrc1ZTVmM1Kzc5emJCclFx?=
 =?utf-8?B?ZW5PdjZPOXhITkx5ZU5RM2hwT2lEd0YzMkQvSkZsUXFzb2JTck90LzAwN3ZZ?=
 =?utf-8?B?V2JpN3NUOEdEbXcwTjNvSkxwcVVxcm9EMG5DR1BtTjJQZUcxN1VMdm5BQzZ2?=
 =?utf-8?B?eHQrazlHaVEveUlXSGh2Z3oxZTNJVXRkeWJpbVYwOUN0VlNDVERocWlVN0dX?=
 =?utf-8?B?anMxOXdlRmdpL2N3S0xwa2VkMklzT0l4d0JJbGo4di9pcy9qdnQ2SEV0VmpB?=
 =?utf-8?B?Z3l0blZWcnprRGFPZXQ4aFZzbHM4dnZHZlI4TU02RU1xa0lCSnhWMmtEUkZQ?=
 =?utf-8?B?dnVmOVRjUHZZd3U5WXZMeG93QkM1cjJQcEFsOXFQSDhjRVVIMUtXWE5mRmcv?=
 =?utf-8?B?Z3QrTXRuSE1hWTVQQzVDeGMvTnVrWlFicGxjdzJWK2E1Yzh2MWxpZzdmRzhv?=
 =?utf-8?B?TkRyeXIvZS8zQWJ3VGFpTmlzOGMyN2cvYUs5TkpLRVViTGlvWkQvTzRzY3Rj?=
 =?utf-8?B?RUlYK2lTTHc3UmpFeitSQThpNkVNbGpneVJjLzlzSm5TMHYwY1JhU3RMd3Jo?=
 =?utf-8?B?cDlXalZ4c2pXY1VITFErN0tQWHRnZFBZWnZVakZ2TWhHZmY5TFVvYlY1c2dy?=
 =?utf-8?B?dXU0ZXlOSE1MMjR6L3lzcm9OUmh0OVlnR29wS0M4NHAvK2ltRm43THY4N2Ey?=
 =?utf-8?B?aHdzdkYwblVvZzJSM1hmeGhacEY3eWwvTzNqaW1QQXZpNmFPM1V4NnF5NkFP?=
 =?utf-8?B?UlZxbVhWVGt0ckZoeDZpdUR0SUZKWXVhS1lhdGwwK2p4aVY1aG5lUUFwTnli?=
 =?utf-8?B?d2lHSkovNFJkalVLRWowWGtrZWJhencrMDFUN3JjRE9UZzNSak9NekhRMS8y?=
 =?utf-8?B?MDdTemxzalhrZ0lqcWN0NjdFd0NGN2Eyc0Z2d29ySFRBWkxNb2NCbkpyaWQw?=
 =?utf-8?B?NG15K0NMZ3NMTnA2K3hXNGd3VjNnZ3NUTFJGVGZMQ25CL0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjEvRXhYU2xZaVM1UjlPdk5DemNEdlAwTllqV05oRm9MRUdjb1ArMTFLSng4?=
 =?utf-8?B?MWdVMlVsc09sMW8xbFZ1YTFST0pMNUpORWFWVCt6bXhyMVcwWjF3RTN4NGRD?=
 =?utf-8?B?YzBhSWNBd2MzWSt6aUlxWWlQNXN2WFJ1QVpTNUVWWDMwK2Jac2JZRjdNL2tq?=
 =?utf-8?B?b29RNXVCRFNOSDVGdlNKSmdUbVdyV1Z2dXJ2VmRFME96ajZRaXhJaC9GWFVt?=
 =?utf-8?B?VWxidTJtQXFWRW1hd1B2YzFFNW9paXVydStnNnBZdVZGQ0sxYk5raEk5V3Bk?=
 =?utf-8?B?YkU3YlVOczc0anRBYWtKYUNQdVlFUWkzMlFMVDBDRklMZzBjcTRObU50Q0RZ?=
 =?utf-8?B?dDY4MGlYTVEyOEZ3OEtXZFdhRHVRLzhrNTVla04xZmZ5TWM1RTB5cTRVTFhG?=
 =?utf-8?B?emJua3U5YXJGeEpLcEZ3M2N5dUx0Z2FzNHh2bTU1VHhrZ3JiakhoRU9sY2NZ?=
 =?utf-8?B?c2ZJQ003eGFCcXBXY1lwRUNOSVp6UzF6QktnNzVBUDd2TXJ1czlwUXBHZUpW?=
 =?utf-8?B?bmorMDd6UVpRNjdRcENodkVrTTNLa011VDJlVjRQME1zZlRZU28zQ0E1V2Fl?=
 =?utf-8?B?b0tqK0FibWpFb1lEalBiQTdnazQ4K3Vzd1l2MHZ6c2syMmdqL0pzRTRTa2sx?=
 =?utf-8?B?aEtmakRzWk1lS1YzZTNLTmRFSmpFTTF5a0xrajllVjNWKytYNG5tTHM4NGVL?=
 =?utf-8?B?TlkrQWRNNkMxNHN1dXdOalVkZXF3S1B0bjRLck10ZExXeGx4RVhGZ25kMEli?=
 =?utf-8?B?NzJ2TVIweUZLMFJuVTZGYU5WQUk0VXhFdVNzM0p1MSs3Q1RsdzFyS1oxSkdR?=
 =?utf-8?B?bFdOZXFMM2FPSkY2cjUyTTNHR2VrQjF1Nlh5TXlkRnNpSDhkK0l5Qjg3NmhC?=
 =?utf-8?B?NHlYcDY5S2dPL2ZnRHc1NmhvNnh6SkdqMmhVVCtXVTdBM0FGN1JrMFBFWnZy?=
 =?utf-8?B?bzJFTUltcFlick9WR0g4RmNqc2srRUhMYWNBUEI3WFZtUkRid0VaSDJsY01u?=
 =?utf-8?B?YVd0QVhWcTU1NEVvS0NRYTdPNU5rb2JLS0lxU0hCNGh1Rm56N2tTcnpZZWpN?=
 =?utf-8?B?eXlQbXBaVWFnVFZGMCtNNWN5c1NwUWd2Wm95QWYxY1lkTjhxcVFUVGw3MDNV?=
 =?utf-8?B?RkhKeWdPVDhtR1EzTUpIWGRzb2dYV2JmSzEvM0I5d0tvd2djTXJtWVA5L1kw?=
 =?utf-8?B?cWZKV1NxVE1wZjJrMkFGK2MxaWxlQWpyR0pCYWZYQ290Vno5dFp2L3RwTGhl?=
 =?utf-8?B?bm4ySWY5dy9KeWdKdkhCKys1dXpibTVkUXhyWk01SUJYU1BWc1dtMURmNVlJ?=
 =?utf-8?B?ZWs1NjdBV1lxcmpwTURNQjE5UkplVkg0Qnh6SXRxNTN4UG8rY2V5MGp2RXBS?=
 =?utf-8?B?c0ZTSWhOM1YwNXRGdjBqMC9IMlZSa3JTc2lCdWt3U3Q3Wi9RbXpRNU8vcGpV?=
 =?utf-8?B?TndUUWpET3FubHJML0hxWlJaRVlwK1psNWlyN1BpOTBXbFRmSW5nalJidC8x?=
 =?utf-8?B?V205VDFta25XaCtieWh5NHpjOFNJNUxlZm9xS2Z0ZFFnbk9jN3Z4TEZUS1l0?=
 =?utf-8?B?N1JpRHp4Q1c2ck1GY0VpYzdTQXB3S0JFcnVLZ3E5T2JTWUs3Zmh0NGM5c3Mz?=
 =?utf-8?B?ZjErc0dTOSthbU1qdkJHWlpmQVhtenRXeXBSS3AyWUhGNU1kc3lRRjBGMkxp?=
 =?utf-8?B?aFg0dHFuK1hUdEJGLzVIczFDWnJpRGVxemFEOGR1OUpZQnU3NlZTeTRFcTE5?=
 =?utf-8?B?SU9McEFMRFd5Rk53eGJUeW1LWFRkaVAzbE5HWFQ5bmdiSzZlbUhRcEUxREhW?=
 =?utf-8?B?eWcvMU81RDJzWlBldVl1QWpLNDh5U1RBZVBCc0N3Q2pkM1VQMjJtam9TS2xG?=
 =?utf-8?B?cWE2aFp4cHRkUXhWenZsbVRldHRsb25ITllYQ3lRRVBJRjkxektKcmxRVlJM?=
 =?utf-8?B?WS9wbEVUTzhCTEo0U3d2OG1UZXFnNUlYS2d2ZlkxWE9pRHIxdVlaSnBzemE3?=
 =?utf-8?B?aExRb1pxd0VTY1llRldIOTAyVnBQaXBCd3Y0eFhXSnRJOE1QYjg0MFZEcXdU?=
 =?utf-8?B?T1pGOC9NVGN3dWZ4b2xXNUlsS0dUWjRUNlBHdmJLeXZLTGVlOXB6bmF1Z0hu?=
 =?utf-8?B?Sk9TQVJLQVpqYUJPdGh5aFF6bmQvbkxrTHBSanNpdjhvc0podEdTdEVVMHdi?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41E3E763B7465B4ABBF8752CEF9E41A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacbf4f1-6dfa-4121-89bd-08dcc1ad55d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 06:48:59.2682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bOT/4beCWUtRAGD1BfYxFULSlGPyhf+clcCM8LyG7QxawUSpM1l2RPuPl2i/3ll5I1rfXflLspdxZC6uOcP3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5153
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDE0OjM2ICswODAwLCBLb2JhIEtvIHdyb3RlOg0KPiANCj4g
T24gOC8yMS8yNCAxNDozMywgWmhhbmcsIFJ1aSB3cm90ZToNCj4gPiBZZWFoLCBidXQgSSBtZWFu
IHByX2VycigpIG1heSBiZSBvdmVya2lsbCBpZiB0aGUgZHJpdmVyIGlzIHN0aWxsDQo+ID4gZnVu
Y3Rpb25hbC4NCj4gDQo+IGhvdyBhYm91dCByZXBsYWNlIHdpdGggcHJfd2Fybj8NCg0Kd2hlbiBp
dCBmYWlscywNCjEuIHRoZSBhZGRyZXNzIHNwYWNlIGhhbmRsZXIgc3RpbGwgcmV0dXJucyBBRV9P
SyAoaXMgaXQgcmlnaHQ/KQ0KMi4gSSBkb24ndCBzZWUgaG93IFBSTV9IQU5ETEVSX0dVSURfTk9U
X0ZPVU5EIHBybV9zdGF0dXMgaXMgaGFuZGxlZA0KDQpTbywgaWYgaXQgaXMgYSBjcml0aWNhbCBl
cnJvciwgd2Ugc2hvdWxkIGZhaWwgdGhlIHBybXQgcHJvYmUNCmltbWVkaWF0ZWx5Lg0KSWYgaXQg
aXMgbm90LCB3ZSBjYW4gbGV0IHNwYWNlIGhhbmRsZXIgcmV0dXJucyBBRV9PSyBsaWtlIHlvdSBk
byBpbg0KdGhpcyBwYXRjaCwgYW5kIGluIHRoaXMgY2FzZSwgZXZlbiBhIHByX2luZm8oKSBpcyBz
dWZmaWNpZW50IElNVi4NCg0KdGhhbmtzLA0KcnVpDQo=

