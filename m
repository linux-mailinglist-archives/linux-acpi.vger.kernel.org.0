Return-Path: <linux-acpi+bounces-7755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B9D9594BC
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 08:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB8CB24B11
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F516DC2D;
	Wed, 21 Aug 2024 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqYWwWka"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1F15C159;
	Wed, 21 Aug 2024 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222031; cv=fail; b=TC/ODsVPcm2xy3NdihYrptYK6+T3u1ZrqOutKvWap2yRrGPQTXf1wuLyLzWZLdDrACHMR9vzBbUx3Mao+gjawImvZDL6yWb2u56PF3HeXwO29fP9Wcy6+BAgNhABEMOht+UZxmYQxQ9S2TQNGewGozzyyHPxzTgaYflQ1Mtr0KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222031; c=relaxed/simple;
	bh=Y+pqxFB1KC27o3+Rip395pso67r+9yYKPgvTJP9QbMM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQaX7HwpHjHdMJHMIE6SJ5nM26wlLMC88HlFkMhoMCFkYqRChyS461MaP2dvYQL1URgk5+MHbqOuc6KoPBb5X99YrLl2B1jgUla9SQL1MTCRNT2vCnAXb2vaDIIzuk2ryDsd8nyfk+JnQcPn/vDXUvuzaIRwrobZbw5VEDCM3+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqYWwWka; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724222030; x=1755758030;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Y+pqxFB1KC27o3+Rip395pso67r+9yYKPgvTJP9QbMM=;
  b=aqYWwWkaju9imOAxHm/NZTdtvDiEZUsTyFAPYBR5JWhh8RkrYnsrE1L4
   yMd38NYSa1+J8F8VY16occVDXHzjMkWQu9owDniCR7zaKfFmPfRw5u/WM
   KlNXa8iWJNpoUJ2OmUKGmVQKWCdra/gKmGe4BfZ59CqRAcshSrRcz+wdr
   FTBxtEbcxpgcvT84FkgAu0lz3m0i51GLyJw8snTQjgZJb8rDyihKJ/Fkr
   7myRl+AgCryciVNVZHG1FdaBNARcXQpLSjEiguAEL3CuZxPKbkE8qA0UV
   hvi93ew9GzpVu6RlDPUf9nhxnoQiZPgo8de/yDCyWB5PTMDF3/z75/BoX
   g==;
X-CSE-ConnectionGUID: DXIt+IV4TMyw7x/CcVJE0A==
X-CSE-MsgGUID: xGAeJyS/T6KwOMBMdaRwEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="25459942"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="25459942"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 23:33:49 -0700
X-CSE-ConnectionGUID: sPVKg8ndTci31jM3i411+A==
X-CSE-MsgGUID: BnFQz2j2Qb2Zw1pukRZtPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60959166"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 23:33:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:33:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:33:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 23:33:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 23:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EftZYG/ReE/KWySsEXYofZHNjxhRaWHzgolODMw8/dT3GbTUa8WGAW05DIPRSGd05mGTy9h1t4jEGucswxJh8g262clLPUIuI2uqoRnChU6bo/A/fzKv6lcMseW5dMngO6grhnWA9pFoTOi3OmLuKqyJyRiXfSKUHHhDQWgjEYbDp5DPH8lyDo1TMsBHHE4ELR3bKZBUiIkoZwsfRcLWAfZ8wkpmLUpF/xUYMsjBqGrAdGiLVL9ASuisTRSKyTrWoSM2iiE2aREi4JntR/lMN0d91GCU3FFBucU7pECjzdhSpZPhLqoi34e1d0LS/mbLLgfZaW1pJpQiEUgoDfGeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+pqxFB1KC27o3+Rip395pso67r+9yYKPgvTJP9QbMM=;
 b=YlBN294rXEIfmTOQdIwQe+LPNgP7Q7BtDcwzB2G7Hp2EvasbhgcAMfMe7Tf7m3ibhg0Q7RBTWQ9h339twT+dGEVKpmvak6uDZyBkWT7yHqeulkCkybBu3SeHR7IhlpcCxHUX4mmRK7SRZzd2hBpZz38ZxmMvtBlJvUIDolu4LHNr3Bq29LhojTL/kFL8CnXoFukeWVtkS8iW1poC6ljThbtQdKiHhELoU7Aq5wFpjHUy3rMQnc4Vg4kk0gBBz6bgO3RquLpx3oUuwKCmv9WiNTqfoBJtbpYVVAa9UbBNkxF8BLrksLQwumbJVIghwf8xC3f/a6lP34mtm4d62oUieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SN7PR11MB7565.namprd11.prod.outlook.com (2603:10b6:806:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 21 Aug
 2024 06:33:44 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 06:33:44 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "mochs@nvidia.com" <mochs@nvidia.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "erik.kaneda@intel.com"
	<erik.kaneda@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Ko, Koba" <kobak@nvidia.com>
Subject: Re: [PATCH] acpi/prmt: find block with specific type
Thread-Topic: [PATCH] acpi/prmt: find block with specific type
Thread-Index: AQHa47zv/FjSqarIqkGArXguHN663bIxKsIAgAALQ4CAAA8qgIAADrMAgAAMxIA=
Date: Wed, 21 Aug 2024 06:33:43 +0000
Message-ID: <4ea0db68415445e5aab405438bbd8ce4240d7ee4.camel@intel.com>
References: <20240801014853.1594699-1-kobak@nvidia.com>
	 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
	 <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
	 <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
	 <f6e581e1-2d24-4587-a193-bfeaf1a3cb1a@nvidia.com>
In-Reply-To: <f6e581e1-2d24-4587-a193-bfeaf1a3cb1a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SN7PR11MB7565:EE_
x-ms-office365-filtering-correlation-id: 1ba21413-df81-4948-937a-08dcc1ab343e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWszbWI4Z1dkajJDQUxTNG8vQzYxdnJickhkcTUzd2ZmSkljbjRlTCtIMFo2?=
 =?utf-8?B?WE04N2ZSNGQ1ZWVTWDRkYVh4Mkt0UU9wa29ZNnMrRzJ6d0kxRjRGWkR6cGhF?=
 =?utf-8?B?aXZiQ0V6Yzk3ZlpIanBTWk4weExCamp6S05OeGQxQWUrNnJFMkxRTDB6dTRO?=
 =?utf-8?B?OUVVL2d2bS9BUExUdnlPNXJ3azFHNFJLV0dQU25VS01RaXFMb0piQlE2K1Q5?=
 =?utf-8?B?SWxDTnhGb3d6V3RqYWhSNUJISldGUWZzUDFyMS9ac01RaUhMb2ZRZlpFd2FK?=
 =?utf-8?B?NFoza015RzdqdGh3M2tkb0IxRi9qSDdRMWdLTlBvKzlETGJXemxBWXQ4bUxx?=
 =?utf-8?B?Z0FYK0RzVFIxUHJYVDVzRWF3bXBWczBnVSs5VVNWOWhMY0lnVDh5UnZHbzhk?=
 =?utf-8?B?dmd4V29NMnhwR29XWEdKaVJ5SnNQVzJDL1Nhd0E4Um02a1BJL0k1N1pFa0l6?=
 =?utf-8?B?U2dTNGRTVHBvMjUwenlLb1FVdkJwSFF1N2c1YS9SWmRDSXdYWHdkYlpPV2x0?=
 =?utf-8?B?S1ZJd2ZjZEl3VGxoL29ZeTFkSitEdEc3NGh4U2NvNkVTMDBCaXBUUjdPU3E2?=
 =?utf-8?B?MVd6ZTY3YlFvTDBiY25LV2cybFlkTEZlQ2VTamFIS0tDY25uN2dHeHF5Szdl?=
 =?utf-8?B?K2xxdWVUR1FzaitmcHJoSnd4dUNIS1hSc1d2cElGY0M2RjdpTUxoZGFQVGhX?=
 =?utf-8?B?bTNVREM4clh1SlNIZFRZV0RWY2ZQNFdKQzFHTW9UbmlCODFNTzJVNzZFVG1r?=
 =?utf-8?B?dUJBT3kzVzlYT3lhNUlIeUQycVlob0s1blZKMmovb0RCaXZNOU1FV2JIK3ow?=
 =?utf-8?B?bEc4YVA1NUswa05IRytETXQ1VDBoSXp3MFB6b0Y0akpYdzU0bDltaFVaa1U4?=
 =?utf-8?B?WndkcjZTeTJmUzcvT2F0OXVFR3FiOFhkZGVVYmVIV0xNT1ZWOFRHUlZmUXp2?=
 =?utf-8?B?bWRlUHQ0aUpIMEVyMVNLLytyMGlmWll0MkJGamxuYVh1eW5MTGJnRENtNHhN?=
 =?utf-8?B?QjU4SWprMkZiR25IRWZlNHp2d3IzWlRSbnpVNDRsNm9jOFhRbFpUcGZiZ2ho?=
 =?utf-8?B?UEJqQUtIdG9jRFU0QXNxQjRMQkUxdFlvSXdVTTBIWjY1TnhrM01HRFUwemhs?=
 =?utf-8?B?V0F2aVAzMHl6MW5JaVg4QyswcUs2SkFFSHVmbDBmbUFQR1ZucXpvMUNqN0xh?=
 =?utf-8?B?WmZ2c1NjTGhXZlhCMW54cnVDZ1I3MlhqY2YweFZVSUxjdXJBLzhmUEUzayts?=
 =?utf-8?B?Q3c0NzZrWEsxNjlCVTFGcExab3NKc2xhbGVJOVI2dkVqRDhQMGt6ZFFNRU4x?=
 =?utf-8?B?Yk9BdlRzZE00eGR5TWhURkFTZWNVSitZcERwc3pqdmI5U2xhbCtNdmpGaGJo?=
 =?utf-8?B?V3pIUExLRkt0NEdxUW9KbmErSDJocnJKWGRybGRiTVVqYnFNQnl1RlZ5dUlq?=
 =?utf-8?B?SnZMYkh0S3ZBd3p5MFU5YndhOUtuN0p2QjhMcVFBRi84enZqRVUrK3BPTElx?=
 =?utf-8?B?eDZ4MXhhNlV1YWxrQlhsSG1xbktmS2VQaTI1ZE15SFFYZmdmdCtiT2J4Ymhz?=
 =?utf-8?B?SE8zeWxta2NyREFVdUlnU3hxNUtOQStLRDRPSy9NSUpobVVmVmgwbFlzK1J3?=
 =?utf-8?B?Si8xWmFjN1pWT3RzblRWa1l3Wkk0TzRhTTBreFJ6VmZQY1hIdEx6M3JRbVdt?=
 =?utf-8?B?bXA3K2IvTHF3UnIxOS9JaTlNQ2daUFArS1IvZW9UaDl4N3lzVDhEMlpaSHZF?=
 =?utf-8?B?cnVsUy9DdVJNNmFtZEtVSTJFZE84Qy8wODZMRmk5WitYTDZHRHh3YUs0eHFO?=
 =?utf-8?Q?y/TuVOn1Ni8MK9r3w+aWqbKUErdozPbMsodBQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHVCZHZZQ2J0SEdSVG84cGtaZkxBWCs0d1NmSWNFaU9EdWlPTGdEaHhRdFl4?=
 =?utf-8?B?STRTUjUvQkYvVlBqWGFiaC9lamFoRXEzbTRpWkdIbElXYVhRMUtndk82dEJJ?=
 =?utf-8?B?UlFGK20xKy9LbEFkbHhUVUJWOFNFdkcrZjJlVklmemJ5TTBaYWxoUGFMdzNh?=
 =?utf-8?B?TTRPODY4cWZ0YXVua2RmVEdQMjZiYkQzYkQzOWVMZGE4WGFON1NzOSs5REpx?=
 =?utf-8?B?a2tRcnE2d3VQNjVjNUNQVkFkdGtlbGtPQzhlZ1VJdTM5S0JQNTEySC9EKzBv?=
 =?utf-8?B?UVlqNitxWU8wVUxVSnhUaUtVOStFM1h5UnhUMkR0ckwyVkxvU1ZVcU1LOVg1?=
 =?utf-8?B?QVVXMUFDdEh5ZUpoMEJWQmQyNzljOEtZQXd5cW16bjhDc0llb0xCdTZheVZp?=
 =?utf-8?B?RHZ2bXZmVE1DQUxNdjNXbkFuQ2xwUlA5cVc1ODhSbTJMSkd4SU5HYjFkQlFs?=
 =?utf-8?B?Yk41TzF6SlpnOFQ1QnpNUld5Y0tQcjNvQXZsaGwwVDRwekNwamRIZU9FQk5R?=
 =?utf-8?B?WVlDa1NhWnljaTZEY0F5OXU4bXc4Z2J6V0M5WjVTc0F2M25GWGhQaHNhU0sr?=
 =?utf-8?B?bHFsK0dDcnd1bmlJRm9MT1JSY1BPRlVxdmRZRTVkM0JDM05ucm1JS1VoQUNS?=
 =?utf-8?B?SllhN2JTL1d4QVcraVdtK1JsRlVVbTJBK0FrMjJGYkFHV3JXU05hS1hRbTAz?=
 =?utf-8?B?Q3ZpV0dQR3V6YW1IZ2ZadkF5ZTFSTGtYVUhsZ0EwNGdsdmJaczhkdS85S1VE?=
 =?utf-8?B?MjZGclRLTXpPeTdlQnl0Z3REMlVZOFdCSSswQ3RvQytyTHlaVnY5Q3lBbmlM?=
 =?utf-8?B?YjFQWVV0eTdrWHF6ZExFV2VTejJIS0tiMFJYQmw4bE4wMGJraWpPemRlUldO?=
 =?utf-8?B?WHY0TnlxdGZ0Y0RQNDRTUXRWdmMzYWMzYllkYnBCMXI4V3JHUjZObHVtb1JI?=
 =?utf-8?B?RlBmeTdmQllnSWNSZzFPVksvUUVEY1dlamVpQ3hyZVBPSFpNNktDYWhyMklu?=
 =?utf-8?B?QjRCY3E1N1NEWVozWFBVMElyejAvMzNrdHZYUEN6d1JweVVqQjc2SzNsV3Bj?=
 =?utf-8?B?L0czN0NPMTRENURBVlBkQ3cvV1pXLzNpZkR3USt1ZEE2ZXlxaExWOFVrNjRN?=
 =?utf-8?B?NldpbndvMXdhZFAyazlaZ0k3K0lhZjczcWlPcTg0V083QWxkU0M5RmdqeVBo?=
 =?utf-8?B?ZU5HWDEvQzd6bmFneExrZENqVlR2aVF0SjlzVUVlZVRPK3Zqano3eG9xNm41?=
 =?utf-8?B?YmNvWlk3cUZTeld6bTdTZVcySmFKbDVhOXZNRDVKclpnWHJJWGwxalNaWjd4?=
 =?utf-8?B?U3FiSExKc0g2SnpNR1ppUGVVL0tmOGdOckd4Zkk1aTBaZkljZWRsRHhOMzJ5?=
 =?utf-8?B?VDVCSXhSZEw5NmU0dFZ2Z0NjcG9NK2s0bHRaUnRjYXAvU0luanNzVFoxejlt?=
 =?utf-8?B?YzcwY05SYURTbE9sRFh4S3hjbnI4Z3N3eDFXTkZjQXNienVWTGJIVi9aNTBY?=
 =?utf-8?B?UGdZRkJHY0JQTWZQYUxTK09KbUZ3TFY1QXZ1YThUYnBQbk53RHBqSVdSQTBz?=
 =?utf-8?B?eG9HL3Nyeml2NWI4YzkwSURVRmxCK2d4NUxiUUgwYnZMSThiWFF1ZW85eFU2?=
 =?utf-8?B?YmI0NUM2T3VVWHZBNHdvc2d1VisrdzkvR0YwYmVjVGtNOUFTQ1gyd0xGMkVJ?=
 =?utf-8?B?STVSUm5wVk9JWTNKcnhadlc0SnlPTjNWYk9nRUsvWmRCUTBOM1diNGttbS83?=
 =?utf-8?B?aWJ3RVAzR0Y2TVdMNjZzM3J2TkUyZU95eHVEanFXcFprMENMajc0N3RyUEN4?=
 =?utf-8?B?RnF4WmxVZ0E2V2ppOUw2anZWQ1hlOGRYU1ZPcWNtbFdSNDc0L2ZUQWZlRWhj?=
 =?utf-8?B?WDlRZ0Q1OENxVGV6Q2dtSlgyUFRYS3UwVFNQcGRjQkRQeTJFblhKNHc4VzdX?=
 =?utf-8?B?aDBZWk1XZjdyT21qWWExQjNwVmNneEcvRmovM3Z3amU0Q1liWnpqaDNxUklj?=
 =?utf-8?B?QXlQc3NLcmY2NUlaeEQ0aStwdGFLbkFVcGdFSDY3VldkZzNWT3dRK2lUY1BU?=
 =?utf-8?B?R0xsK0dueC9oTVNjWHNVNEZMRCtpV1YzbjlBaEE5MHBscEQ0YUJ3bENXNXZq?=
 =?utf-8?B?eVZ1Zk00NVRlVCt0RlRmYzBSbW0vTHl1ZTVQZitCVXVqVkxQMW13RFh3ZFRQ?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DDAE09569ECAC419C0DC0D90500B77F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba21413-df81-4948-937a-08dcc1ab343e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 06:33:43.9770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQoh3+dJFgtavGEXV87MPXbIWtFnBQqLT0lpPIoQ+mXLlR7phu/9eZHGq2jsrijS0bAX64aMDkGupCrSmNV1mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7565
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEzOjQ4ICswODAwLCBLb2JhIEtvIHdyb3RlOgo+IAo+IE9u
IDgvMjEvMjQgMTI6NTUsIFpoYW5nLCBSdWkgd3JvdGU6Cj4gPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+ID4gCj4gPiAKPiA+IE9uIFdl
ZCwgMjAyNC0wOC0yMSBhdCAxMjowMSArMDgwMCwgS29iYSBLbyB3cm90ZToKPiA+ID4gT24gOC8y
MS8yNCAxMToyMCwgWmhhbmcsIFJ1aSB3cm90ZToKPiA+ID4gPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+ID4gPiA+IAo+ID4gPiA+IAo+
ID4gPiA+IE9uIFRodSwgMjAyNC0wOC0wMSBhdCAwOTo0OCArMDgwMCwgS29iYUsgd3JvdGU6Cj4g
PiA+ID4gPiBQUk1UIG5lZWRzIHRvIGZpbmQgdGhlIGNvcnJlY3QgdHlwZSBvZiBibG9jayB0bwo+
ID4gPiA+ID4gdHJhbnNsYXRlIHRoZSBQQS1WQSBtYXBwaW5nIGZvciBFRkkgcnVudGltZSBzZXJ2
aWNlcy4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhlIGlzc3VlIGFyaXNlcyBiZWNhdXNlIHRoZSBQ
Uk1UIGlzIGZpbmRpbmcgYSBibG9jayBvZiB0eXBlCj4gPiA+ID4gPiBFRklfQ09OVkVOVElPTkFM
X01FTU9SWSwKPiA+ID4gPiA+IHdoaWNoIGlzIG5vdCBhcHByb3ByaWF0ZSBmb3IgcnVudGltZSBz
ZXJ2aWNlcyBhcyBkZXNjcmliZWQgaW4KPiA+ID4gPiA+IFNlY3Rpb24KPiA+ID4gPiA+IDIuMi4y
IChSdW50aW1lCj4gPiA+ID4gPiBTZXJ2aWNlcykgb2YgdGhlIFVFRkkgU3BlY2lmaWNhdGlvbiBb
MV0uIFNpbmNlIHRoZSBQUk0KPiA+ID4gPiA+IGhhbmRsZXIgaXMKPiA+ID4gPiA+IGEKPiA+ID4g
PiA+IHR5cGUgb2YgcnVudGltZQo+ID4gPiA+ID4gc2VydmljZSwgdGhpcyBjYXVzZXMgYW4gZXhj
ZXB0aW9uIHdoZW4gdGhlIFBSTSBoYW5kbGVyIGlzCj4gPiA+ID4gPiBjYWxsZWQuCj4gPiA+ID4g
PiAKPiA+ID4gPiBUb28gbWFueSBjaGFyYWN0ZXJzIGluIG9uZSBsaW5lLgo+ID4gPiA+IGh0dHBz
Oi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjdGhlLWNh
bm9uaWNhbC1wYXRjaC1mb3JtYXQKPiA+ID4gd2lsbCBmaXggdGhpcyBpbiB0aGUgZGVzY3JpcHRp
b24uCj4gPiA+ID4gCj4gPiA+ID4gPiDCoMKgwqDCoMKgIFtGaXJtd2FyZSBCdWddOiBVbmFibGUg
dG8gaGFuZGxlIHBhZ2luZyByZXF1ZXN0IGluIEVGSQo+ID4gPiA+ID4gcnVudGltZQo+ID4gPiA+
ID4gc2VydmljZQo+ID4gPiA+ID4gwqDCoMKgwqDCoCBXQVJOSU5HOiBDUFU6IDIyIFBJRDogNDMz
MCBhdAo+ID4gPiA+ID4gZHJpdmVycy9maXJtd2FyZS9lZmkvcnVudGltZS0KPiA+ID4gPiA+IHdy
YXBwZXJzLmM6MzQxIF9fZWZpX3F1ZXVlX3dvcmsrMHgxMWMvMHgxNzAKPiA+ID4gPiA+IMKgwqDC
oMKgwqAgQ2FsbCB0cmFjZToKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIF9fZWZpX3F1ZXVlX3dv
cmsrMHgxMWMvMHgxNzAKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGVmaV9jYWxsX2FjcGlfcHJt
X2hhbmRsZXIrMHg2OC8weGQwCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBhY3BpX3BsYXRmb3Jt
cnRfc3BhY2VfaGFuZGxlcisweDE5OC8weDI1OAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNw
aV9ldl9hZGRyZXNzX3NwYWNlX2Rpc3BhdGNoKzB4MTQ0LzB4Mzg4Cj4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoCBhY3BpX2V4X2FjY2Vzc19yZWdpb24rMHg5Yy8weDExOAo+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqAgYWNwaV9leF93cml0ZV9zZXJpYWxfYnVzKzB4YzQvMHgyMTgKPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgIGFjcGlfZXhfd3JpdGVfZGF0YV90b19maWVsZCsweDE2OC8weDIxOAo+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNwaV9leF9zdG9yZV9vYmplY3RfdG9fbm9kZSsweDFhOC8w
eDI1OAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNwaV9leF9zdG9yZSsweGVjLzB4MzMwCj4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBhY3BpX2V4X29wY29kZV8xQV8xVF8xUisweDE1Yy8weDYx
OAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNwaV9kc19leGVjX2VuZF9vcCsweDI3NC8weDU0
OAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNwaV9wc19wYXJzZV9sb29wKzB4MTBjLzB4NmI4
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBhY3BpX3BzX3BhcnNlX2FtbCsweDE0MC8weDNiMAo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNwaV9wc19leGVjdXRlX21ldGhvZCsweDEyYy8weDJh
MAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNwaV9uc19ldmFsdWF0ZSsweDIxMC8weDMxMAo+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgYWNwaV9ldmFsdWF0ZV9vYmplY3QrMHgxNzgvMHgzNTgK
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGFjcGlfcHJvY193cml0ZSsweDFhOC8weDhhMCBbYWNw
aV9jYWxsXQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgcHJvY19yZWdfd3JpdGUrMHhjYy8weDE1
MAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgdmZzX3dyaXRlKzB4ZDgvMHgzODAKPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgIGtzeXNfd3JpdGUrMHg3MC8weDEyMAo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqAgX19hcm02NF9zeXNfd3JpdGUrMHgyNC8weDQ4Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oCBpbnZva2Vfc3lzY2FsbC5jb25zdHByb3AuMCsweDgwLzB4ZjgKPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgIGRvX2VsMF9zdmMrMHg1MC8weDExMAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgZWww
X3N2YysweDQ4LzB4MWQwCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBlbDB0XzY0X3N5bmNfaGFu
ZGxlcisweDE1Yy8weDE3OAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgZWwwdF82NF9zeW5jKzB4
MWE4LzB4MWIwCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEZpbmQgYSBibG9jayB3aXRoIHNwZWNpZmlj
IHR5cGUgdG8gZml4IHRoaXMuCj4gPiA+ID4gPiBwcm10IGZpbmQgYSBibG9jayB3aXRoIEVGSV9S
VU5USU1FX1NFUlZJQ0VTX0RBVEEgZm9yIHBybQo+ID4gPiA+ID4gaGFuZGxlci4KPiA+ID4gPiA+
IHBybXQgZmluZCBhIGJsb2NrIHdpdGggRUZJX1JVTlRJTUVfU0VSVklDRVNfQ09ERSBmb3IgcHJt
Cj4gPiA+ID4gPiBjb250ZXh0Lgo+ID4gPiA+ID4gQnkgdXNpbmcgdGhlIGNvcnJlY3QgbWVtb3J5
IHR5cGVzIGZvciBydW50aW1lIHNlcnZpY2VzLAo+ID4gPiA+ID4gd2UgY2FuIGVuc3VyZSB0aGF0
IHRoZSBQUk0gaGFuZGxlciBhbmQKPiA+ID4gPiA+IGl0cyBjb250ZXh0IGFyZSBwcm9wZXJseSBt
YXBwZWQgaW4gdGhlIHZpcnR1YWwgYWRkcmVzcyBzcGFjZQo+ID4gPiA+ID4gZHVyaW5nCj4gPiA+
ID4gPiBydW50aW1lLAo+ID4gPiA+ID4gcHJldmVudGluZyB0aGUgcGFnaW5nIHJlcXVlc3QgZXJy
b3IuCj4gPiA+ID4gc29tZSBnZW5lcmFsIHJ1bGVzIHRvIGZvbGxvdyB3aGVuIHdyaXRpbmcgYSBj
aGFuZ2Vsb2cKPiA+ID4gPiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL21haW50YWlu
ZXItdGlwLmh0bWzCoDQuMi4zLgo+ID4gPiA+IENoYW5nZWxvZwo+ID4gPiB3aWxsIGRlY29yYXRl
IHRoaXMuCj4gPiA+ID4gPiBbMV0KPiA+ID4gPiA+IGh0dHBzOi8vdWVmaS5vcmcvc2l0ZXMvZGVm
YXVsdC9maWxlcy9yZXNvdXJjZXMvVUVGSV9TcGVjXzJfMTBfQXVnMjkucGRmCj4gPiA+ID4gPiAK
PiA+ID4gPiA+IEZpeGVzOiBjZWZjN2NhNDYyMzUgKCJBQ1BJOiBQUk06IGltcGxlbWVudCBPcGVy
YXRpb25SZWdpb24KPiA+ID4gPiA+IGhhbmRsZXIKPiA+ID4gPiA+IGZvciB0aGUgUGxhdGZvcm1S
dE1lY2hhbmlzbSBzdWJ0eXBlIikKPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtvYmFLIDxrb2Jh
a0BudmlkaWEuY29tPgo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgUi4gT2NocyA8bW9j
aHNAbnZpZGlhLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gwqDCoCBkcml2ZXJzL2FjcGkv
cHJtdC5jIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gPiA+ID4gPiAt
LS0tLQo+ID4gPiA+ID4gLS0tLS0KPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiDCoMKgIDEgZmlsZSBj
aGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKPiA+ID4gPiA+IAo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9wcm10LmMgYi9kcml2ZXJzL2FjcGkvcHJt
dC5jCj4gPiA+ID4gPiBpbmRleCBjNzg0NTNjNzRlZjUuLmUyZjBiZGQ4MTAxMyAxMDA2NDQKPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9wcm10LmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
YWNwaS9wcm10LmMKPiA+ID4gPiA+IEBAIC03MiwxNyArNzIsMjEgQEAgc3RydWN0IHBybV9tb2R1
bGVfaW5mbyB7Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBybV9oYW5kbGVy
X2luZm8gaGFuZGxlcnNbXQo+ID4gPiA+ID4gX19jb3VudGVkX2J5KGhhbmRsZXJfY291bnQpOwo+
ID4gPiA+ID4gwqDCoCB9Owo+ID4gPiA+ID4gCj4gPiA+ID4gPiAtc3RhdGljIHU2NCBlZmlfcGFf
dmFfbG9va3VwKHU2NCBwYSkKPiA+ID4gPiA+ICtzdGF0aWMgdTY0IGVmaV9wYV92YV9sb29rdXAo
dTY0IHBhLCB1MzIgdHlwZSkKPiA+ID4gPiA+IMKgwqAgewo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgIGVmaV9tZW1vcnlfZGVzY190ICptZDsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oCB1NjQgcGFfb2Zmc2V0ID0gcGEgJiB+UEFHRV9NQVNLOwo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgIHU2NCBwYWdlID0gcGEgJiBQQUdFX01BU0s7Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoCBmb3JfZWFjaF9lZmlfbWVtb3J5X2Rlc2MobWQpIHsKPiA+ID4gPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtZC0+cGh5c19hZGRyIDwgcGEgJiYg
cGEgPCBtZC0+cGh5c19hZGRyCj4gPiA+ID4gPiArCj4gPiA+ID4gPiBQQUdFX1NJWkUgKiBtZC0+
bnVtX3BhZ2VzKQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCht
ZC0+dHlwZSA9PSB0eXBlKSAmJgo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIChtZC0+cGh5c19hZGRyIDwgcGEgJiYgcGEgPCBtZC0KPiA+ID4g
PiA+ID5waHlzX2FkZHIKPiA+ID4gPiA+ICsKPiA+ID4gPiA+IFBBR0VfU0laRSAqIG1kLT5udW1f
cGFnZXMpKSB7Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gcGFfb2Zmc2V0ICsgbWQtPnZpcnRfYWRkciArCj4gPiA+ID4g
PiBwYWdlCj4gPiA+ID4gPiAtIG1kLQo+ID4gPiA+ID4gPiBwaHlzX2FkZHI7Cj4gPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+ID4gPiA+ID4gCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHByX2VycigiUFJNOiBGYWls
ZWQgdG8gZmluZCBhIGJsb2NrIGZvciBwYTogJWx4IHR5cGUKPiA+ID4gPiA+ICV1XG4iLAo+ID4g
PiA+ID4gcGEsIHR5cGUpOwo+ID4gPiA+ID4gKwo+ID4gPiA+IElmIGl0IGlzIGEgcHJfZXJyLCB3
aHkgbm90IGVycm9yIG91dD8KPiA+ID4gPiBvciB3aGF0IGlzIHRoZSBwcm9wZXIgaGFuZGxpbmcg
Zm9yIHN1Y2ggZmFpbHVyZXM/Cj4gPiA+ID4gCj4gPiBOb3Qgc3VyZSBpZiB5b3UgbWlzc2VkIHRo
aXMgb25lLgo+ID4gSXQgaXMgbm90IGNsZWFyIHdoYXQgaXMgdGhlIGV4cGVjdGVkIGJlaGF2aW9y
IGluIHRoaXMgY2FzZS4gQmV0dGVyCj4gPiB0bwo+ID4gZGVzY3JpYmUgdGhpcyBpbiB0aGUgY2hh
bmdlbG9nIGFzIHdlbGwuCj4gCj4gU29ycnksIG1pc3NlZC4KPiBpZiBnZXQgZmFpbHVyZSBhbmQg
cmV0dXJuIDAuCj4gaW4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIsIGl0IHRha2VzIGNh
cmUgdG8gaGFuZGxlIHRoZSBudWxsCj4gcG9pbnRlcnMuCj4gYGBgCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKCFoYW5kbGVyLT5oYW5kbGVyX2FkZHIgfHwgCj4gIWhhbmRsZXIt
PnN0YXRpY19kYXRhX2J1ZmZlcl9hZGRyIHx8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICFoYW5kbGVyLT5hY3BpX3BhcmFtX2J1ZmZlcl9hZGRyKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmZlci0+cHJt
X3N0YXR1cyA9IFBSTV9IQU5ETEVSX0VSUk9SOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPiBgYGAKPiB3aWxsIGFsc28gdXBkYXRlIGluIHRoZSBkZXNjcmlwdGlvbi4KClll
YWgsIGJ1dCBJIG1lYW4gcHJfZXJyKCkgbWF5IGJlIG92ZXJraWxsIGlmIHRoZSBkcml2ZXIgaXMg
c3RpbGwKZnVuY3Rpb25hbC4KCnRoYW5rcywKcnVpCgo+IAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAwOwo+ID4gPiA+ID4gwqDCoCB9Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IEBA
IC0xNDgsOSArMTUyLDEyIEBAIGFjcGlfcGFyc2VfcHJtdCh1bmlvbgo+ID4gPiA+ID4gYWNwaV9z
dWJ0YWJsZV9oZWFkZXJzCj4gPiA+ID4gPiAqaGVhZGVyLCBjb25zdCB1bnNpZ25lZCBsb25nIGVu
ZCkKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGggPSAmdG0t
PmhhbmRsZXJzW2N1cl9oYW5kbGVyXTsKPiA+ID4gPiA+IAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBndWlkX2NvcHkoJnRoLT5ndWlkLCAoZ3VpZF90Cj4gPiA+
ID4gPiAqKWhhbmRsZXJfaW5mby0KPiA+ID4gPiA+ID4gaGFuZGxlcl9ndWlkKTsKPiA+ID4gPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoLT5oYW5kbGVyX2FkZHIgPSAodm9pZAo+
ID4gPiA+ID4gKillZmlfcGFfdmFfbG9va3VwKGhhbmRsZXJfaW5mby0+aGFuZGxlcl9hZGRyZXNz
KTsKPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoLT5zdGF0aWNfZGF0
YV9idWZmZXJfYWRkciA9Cj4gPiA+ID4gPiBlZmlfcGFfdmFfbG9va3VwKGhhbmRsZXJfaW5mby0+
c3RhdGljX2RhdGFfYnVmZmVyX2FkZHJlc3MpOwo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHIgPQo+ID4gPiA+ID4gZWZpX3Bh
X3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHJlc3MpOwo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGgtPmhhbmRsZXJfYWRkciA9Cj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZv
aWQKPiA+ID4gPiA+ICopZWZpX3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tCj4gPiA+ID4gPiA+
IGhhbmRsZXJfYWRkcmVzcywgRUZJX1JVTlRJTUVfU0VSVklDRVNfQ09ERSk7Cj4gPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aC0+c3RhdGljX2RhdGFfYnVmZmVyX2FkZHIg
PQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVmaV9wYV92YV9sb29rdXAoaGFuZGxlcl9pbmZvLQo+ID4gPiA+ID4gPiBzdGF0aWNfZGF0YV9i
dWZmZXJfYWRkcmVzcywgRUZJX1JVTlRJTUVfU0VSVklDRVNfREFUQSk7Cj4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aC0+YWNwaV9wYXJhbV9idWZmZXJfYWRkciA9Cj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWZp
X3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tCj4gPiA+ID4gPiA+IGFjcGlfcGFyYW1fYnVmZmVy
X2FkZHJlc3MsIEVGSV9SVU5USU1FX1NFUlZJQ0VTX0RBVEEpOwo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgIH0gd2hpbGUgKCsrY3VyX2hhbmRsZXIgPCB0bS0+aGFuZGxlcl9jb3VudCAmJgo+
ID4gPiA+ID4gKGhhbmRsZXJfaW5mbyA9Cj4gPiA+ID4gPiBnZXRfbmV4dF9oYW5kbGVyKGhhbmRs
ZXJfaW5mbykpKTsKPiA+ID4gPiA+IAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+ID4gPiA+ID4gQEAgLTI1MCw4ICsyNTcsMTYgQEAgc3RhdGljIGFjcGlfc3RhdHVzCj4g
PiA+ID4gPiBhY3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcih1MzIgZnVuY3Rpb24sCj4gPiA+
ID4gPiAKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGFuZGxl
ciA9IGZpbmRfcHJtX2hhbmRsZXIoJmJ1ZmZlci0KPiA+ID4gPiA+ID4gaGFuZGxlcl9ndWlkKTsK
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbW9kdWxlID0gZmlu
ZF9wcm1fbW9kdWxlKCZidWZmZXItCj4gPiA+ID4gPiA+aGFuZGxlcl9ndWlkKTsKPiA+ID4gPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghaGFuZGxlciB8fCAhbW9kdWxlKQo+
ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gaW52YWxpZF9ndWlkOwo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFoYW5kbGVyIHx8ICFtb2R1bGUpIHsKPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZmZXItPnBybV9zdGF0dXMgPQo+ID4gPiA+ID4g
UFJNX0hBTkRMRVJfR1VJRF9OT1RfRk9VTkQ7Cj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcjsKPiA+ID4gPiBJIHRoaW5rIGl0
IGlzIG9rYXkgdG8gcmV0dXJuIEFFX09LIGRpcmVjdGx5LCByaWdodD8KPiA+ID4gPiAKPiA+ID4g
PiB0aGFua3MsCj4gPiA+ID4gcnVpCj4gPiA+IEknbSBhbHNvIGdvb2QgZm9yIHRoaXMuCj4gPiA+
IEkgZm9sbG93ZWQgdGhlIGNvbnZlbnRpb24gaW4gdGhpcyBibG9jay4KPiA+ID4gSWYgY2hhbmdl
IHRvICJyZXR1cm4iLCBpIHdpbGwgY2hhbmdlIGFsbCAiZ290byBlcnJvciIuCj4gPiA+IEhvdyBk
byB5b3UgdGhpbms/Cj4gPiBzb3VuZHMgZ29vZCB0byBtZS4KPiA+IAo+ID4gLXJ1aQo+ID4gCj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ID4gPiArCj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWhhbmRsZXItPmhhbmRsZXJf
YWRkciB8fCAhaGFuZGxlci0KPiA+ID4gPiA+ID4gc3RhdGljX2RhdGFfYnVmZmVyX2FkZHIgfHwK
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAh
aGFuZGxlci0+YWNwaV9wYXJhbV9idWZmZXJfYWRkcikgewo+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmZlci0+cHJtX3N0YXR1cyA9Cj4g
PiA+ID4gPiBQUk1fSEFORExFUl9FUlJPUjsKPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOwo+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiA+ID4gCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFDUElfQ09QWV9OQU1FU0VHKGNvbnRleHQuc2lnbmF0dXJl
LAo+ID4gPiA+ID4gIlBSTUMiKTsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY29udGV4dC5yZXZpc2lvbiA9IDB4MDsKPiA+ID4gPiA+IEBAIC0yNzQsOCArMjg5
LDEwIEBAIHN0YXRpYyBhY3BpX3N0YXR1cwo+ID4gPiA+ID4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNl
X2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
UFJNX0NNRF9TVEFSVF9UUkFOU0FDVElPTjoKPiA+ID4gPiA+IAo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb2R1bGUgPSBmaW5kX3BybV9tb2R1bGUoJmJ1ZmZl
ci0KPiA+ID4gPiA+ID5oYW5kbGVyX2d1aWQpOwo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKCFtb2R1bGUpCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBpbnZhbGlkX2d1aWQ7Cj4gPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW1vZHVsZSkgewo+ID4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmZlci0+cHJtX3N0YXR1
cyA9Cj4gPiA+ID4gPiBQUk1fSEFORExFUl9HVUlEX05PVF9GT1VORDsKPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOwo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiA+ID4gCj4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtb2R1bGUtPnVwZGF0YWJs
ZSkKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1vZHVsZS0+dXBkYXRhYmxlID0gZmFsc2U7Cj4gPiA+ID4gPiBAQCAtMjg2LDggKzMw
MywxMCBAQCBzdGF0aWMgYWNwaV9zdGF0dXMKPiA+ID4gPiA+IGFjcGlfcGxhdGZvcm1ydF9zcGFj
ZV9oYW5kbGVyKHUzMiBmdW5jdGlvbiwKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNl
IFBSTV9DTURfRU5EX1RSQU5TQUNUSU9OOgo+ID4gPiA+ID4gCj4gPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1vZHVsZSA9IGZpbmRfcHJtX21vZHVsZSgmYnVmZmVy
LQo+ID4gPiA+ID4gPmhhbmRsZXJfZ3VpZCk7Cj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIW1vZHVsZSkKPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGludmFsaWRfZ3VpZDsKPiA+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghbW9kdWxlKSB7Cj4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZmVyLT5wcm1fc3RhdHVz
ID0KPiA+ID4gPiA+IFBSTV9IQU5ETEVSX0dVSURfTk9UX0ZPVU5EOwo+ID4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3I7Cj4gPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ID4gPiAKPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1vZHVsZS0+dXBkYXRhYmxl
KQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYnVmZmVyLT5wcm1fc3RhdHVzID0KPiA+ID4gPiA+IFVQREFURV9VTkxPQ0tfV0lUSE9V
VF9MT0NLOwo+ID4gPiA+ID4gQEAgLTMwMSwxMCArMzIwLDcgQEAgc3RhdGljIGFjcGlfc3RhdHVz
Cj4gPiA+ID4gPiBhY3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcih1MzIgZnVuY3Rpb24sCj4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ID4gPiA+IAo+ID4gPiA+ID4gLcKgwqDCoMKgwqDC
oCByZXR1cm4gQUVfT0s7Cj4gPiA+ID4gPiAtCj4gPiA+ID4gPiAtaW52YWxpZF9ndWlkOgo+ID4g
PiA+ID4gLcKgwqDCoMKgwqDCoCBidWZmZXItPnBybV9zdGF0dXMgPSBQUk1fSEFORExFUl9HVUlE
X05PVF9GT1VORDsKPiA+ID4gPiA+ICtlcnJvcjoKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gQUVfT0s7Cj4gPiA+ID4gPiDCoMKgIH0KPiA+ID4gPiA+IAoK

