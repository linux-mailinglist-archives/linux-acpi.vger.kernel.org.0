Return-Path: <linux-acpi+bounces-21378-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEsEHj/SqGmlxgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21378-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:45:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF542098E4
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7110830166DE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 00:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DAC33985;
	Thu,  5 Mar 2026 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fczbiiCt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE011E531;
	Thu,  5 Mar 2026 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671548; cv=fail; b=W3MFoTqLTdmx1IyKHCXE0WjKuPGAo5P0rhk6Z88sXUuduQvvPgSeooaiOoR97pk2cHsqs4PmKhyyTD3zQmI2sQaV38XNjYwqDYBK2BYCs3JPB41SkqzXioAl5IbFe3JfTm4dBZehTJlA7NycYlpK0hPM1Ngu9pPQFJG0CU8EclQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671548; c=relaxed/simple;
	bh=F0oJqoC5OLrPCOP/+8R79b1n3e5Hot5U49d3ZU1cJd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=szqBImas5sj4mZOnQKBys95XIgbgA8kdjRTLf7fYH+7+qaoXBDnXH2afv9+ai5Qzh+7MZD49CfSLUNW98qVTLRBXa82wEE0qOun62GUCb32TA82OjM5a+U7aiNj384Pm+X6eHZu50Eyti3mNbQFZkAbZn2IW/Q56HWj0n7cx8Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fczbiiCt; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772671546; x=1804207546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F0oJqoC5OLrPCOP/+8R79b1n3e5Hot5U49d3ZU1cJd8=;
  b=fczbiiCt7C+WXHTSj8w91yVcMhf9jfs1exj7Ny44A6at1oNF/VuVwsJs
   ICAh1eo5Oc8bPpC51jJKg6aHaZEXI38MQ/x8PY816ODnqxcpOOE+zprvY
   wb+ZTBzmqpErcIZ/BhwSh2V5NpyEghmvEApx7EQLaqRnFqOVpW+zEWQbK
   xrfxR/3hjfp/e/e0iymnARelyNRE+HmPXAw17OrTZlTlBy8pZ2lcUvS6x
   hOQ/2iVUcQ1nPmoRANemvf5cymXbHsAU6tqsDJQe2qSWsFE17jndoB09V
   4llglPX7Ag/0hA3/NJvH4wHunYDU32t7OIf34azqjf7kLF2TPAuI/zFbg
   Q==;
X-CSE-ConnectionGUID: pfO+5gyPR8ubyTgmYqzDxg==
X-CSE-MsgGUID: 32w03Ex4T+2v1rFiw7hayQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84081911"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="84081911"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:45:46 -0800
X-CSE-ConnectionGUID: zeBgnRqGQxmcrN1D5NovSA==
X-CSE-MsgGUID: nu1+DGl1SjKten8xwuX0eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="216347773"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:45:46 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:45:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 16:45:45 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:45:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEm+A+QNdik+5xjm1OqFfwTP8gt77TLXyfr+sgeoyTAkVSwwGqvQaeI4dMUOVH44vacmXFnJfdShjINE/8fL2WvAk6rpWCQULoUm452Je6vl81a6sTb8XO0O//+AmFG9bfGtxFXUPrmuw3fNsKOlxClq2AMra1ksszalTsjqrrIRsgTT8f724zw6GC7yR9hpIgCgDDDLUjqIbGa10xl9S7v1vHkdQMANlGr/xBhoByvgK02u2y10qfZgYypxgPoM6mijeyaxlfsDQWn4AyOHUwgapgwzQfd60ShiIqQimJOy6VIZuvv6Z047WmYxhadLALhM347WArD08gLkqQTFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0oJqoC5OLrPCOP/+8R79b1n3e5Hot5U49d3ZU1cJd8=;
 b=jiMmQmOTnWki67o/FIpR7T4bASpWYUyMxLsXI6bj986HkdHBwFjM+FKq9wb2XQ8Nu0JzGOXwz/AqCVkQGWvuJ8v2nshE36wzJaHq8XkVx+ogA9d14YXTZlNL9bcJMehldkJaeNiX9DTOo+4X3TGgAL/OLzggjEv2QYc3OPPED4m6/F4w3vtx6R9wNPoSdvjg74Y6ehmWex9/oP/R1+5T5fa1ZehGcLpY9XZc6AWO1hzyOy1cu1b3yO/3EOceYUU76PHMay2+2wR9kWBerzlMhWACZr2wVcdK822eCaD4/t1EnxHV8wjRt7W5gExcKl/3bGZ+K7Z33Wy+nIYHVqWqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB9479.namprd11.prod.outlook.com (2603:10b6:8:296::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Thu, 5 Mar 2026 00:45:40 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 00:45:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "gourry@gourry.net" <gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "Schofield, Alison"
	<alison.schofield@intel.com>, "thorsten.blum@linux.dev"
	<thorsten.blum@linux.dev>, "wangyuquan1236@phytium.com.cn"
	<wangyuquan1236@phytium.com.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Topic: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Index: AQHcrB6hFMt1tftCWUOUCZXHrNvLJLWe9ZgAgAAND4CAAAoyAIAABQUAgAAEMQCAAARwgA==
Date: Thu, 5 Mar 2026 00:45:39 +0000
Message-ID: <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
	 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
	 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
	 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
	 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
	 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
In-Reply-To: <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB9479:EE_
x-ms-office365-filtering-correlation-id: 783dcbc5-eca3-405e-14da-08de7a50861e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: HGpj3zMj+/TLGMau2N4AsHAKte9hl3uLPf/AmamZxumz39z/+P0QbIsDG0kSDHpjE9t2Ru6AJDrAXQUz5EUDXiY2sIsoqah4iMcRCqejqPHRDTnho6DNPnx1Wn3d+gawcr6ETtU/WMDBzsrsnzOs95hHdQM8dh7bMTbPkJ6I44Yf+u+u3mM0i7Qs6WOq762vNNWIf7aqM/xCTejSLbY85SribELb3SByQ04/DWIZLVpV0UvZQRA6xni5/gdzKP6GlZiK89A88nB4pWWpTcDz0Pt5DsA+5i6K2iG22p9z59Of8TEjXkz2/u043IwttS9IMN9EKlh0FD0VYbr/F4AaiN7bhLI8l3aOy1pRICA+VySrXkYx16uGokV6s5geB48Qt8VsCadFuqBVOCw3Ue2oBMw7J2cedKewsBjiIFEGwp2cdmXExFywSSrQ9klutZ2sglLBfWFb+bE9/eBTr6LfXvBw213ZM098my5SBBtmzyXueWlJA3Xs0E3kEBuwQIHFxYnY1dTK6OKFG6h6axvBFCZN3hbPwnP6qe8VuESRbKCiaML8w7m5W1oRS4e24n3H5jsUw0WL3d48N/ymm+WebtkuXxRHDvviDM/Tclu2kxDDYeSiW2YHs+H5AIw+AxhWTNZBl8VXqjG1x1cMTnUBh0oP8V7CkRmNil4SGFZefCJs4X5PiEwzZu78bFkhQBEiJmU8DTt8IJv0AqMeAVQc+bR961dY75GC+OgugEFULcdfCXluxvluSMOw67KblG799F3rjBf+5Et1wo1zsVUUiNK2n9CGmeDv9V/fs+l7dic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1QwdWZ2VkpXT09NRmlnZWZLalhPY0lXenRwOXg3dk9hZU1JV1dhUmo5clg5?=
 =?utf-8?B?QnVxaEdQbTJiTGgxMmUyeTVja3hnUVNxdHlSMDFpMkdjdUgzQTJGQ0hPeFVl?=
 =?utf-8?B?UW5sdjl5WityWXljdFY4L1dheWcyMm04TUFrMWZqa2tLNEFTU0xadDYyc09Y?=
 =?utf-8?B?VkVZKy8weUpEZEtiODNLc3ZrWUZaQnhBcmczNzZ5UU4rckJGekdVdlVYWGk4?=
 =?utf-8?B?UkszVDJidWltTnJkZVVqd01zUzVkWGxSbjBNeFh0NFoyVUF0YUJaVlh5VDdL?=
 =?utf-8?B?dVFwaTJYWXB5RXlxWWdGWTFOSTRjTDNsbXEyUDVoVkxHOXBOL0tJNVlMYjE5?=
 =?utf-8?B?L0J2bmNQTGxGa2ZMUzZiNlpKUU9vcUprWldKcUs2N1RNQ09aUUJlazZVQ1M5?=
 =?utf-8?B?OHhDV2F0Y3NINnZDcWw5L1BJeUtCdWdEVGZseFprSmt4RXlBZldQdEhDUnVw?=
 =?utf-8?B?SXRGUWlEMDRMYWo0ZTd1MkNOcXV2ZjRkWDBjNU0zM0VxT01pODBwQ1kvOVI2?=
 =?utf-8?B?REcwSkpYSHNvZHZ0dC9LNU02M3krVWJFVHJxcnFEVU5ndmVXWnVQTnVPdk9N?=
 =?utf-8?B?ZnU4NDZERnJMMmZ2ZmZ5MWgyaE5BTmhzNHMvTm8xWHc4d1JtUmdWRnY2dEtZ?=
 =?utf-8?B?WldVazNVdklPWWJsaGZFeVI4Z2ZVWENEVUNjRmJ2akF0b2xldE5keUszNi9q?=
 =?utf-8?B?YlNmQ3dmMzAzRWNyakFCNmdieXdUMGo3N0lKOHN3WUZHRTlQaCtUM2lkUmM2?=
 =?utf-8?B?YUdlWlUvdmlwVUpkOHhucDJJNXJPazdIcVFXU2Nzb0RNOFJrV21TQXlUa3ds?=
 =?utf-8?B?SzdMSVlmZXVhZklJaloxSFVMNkZ2MzFkUVpoQm5EQnJYWTJ6ekQ0Q3lkQmU1?=
 =?utf-8?B?M2trYUdwaGp5ZWJ1UFJGc0xqZTVmU2RUYk9rVnViSzlsZ1hERllHYkhaQitT?=
 =?utf-8?B?VVBGNmNOcFhDa09paVVHM21lNmZWNk1vbFVHZVRjT1VwWWVlTHBIZ3MzWDlD?=
 =?utf-8?B?QUJvSFRvRVlkYnhsc2MramNrV3QyNzNicjllK244U3k1UzFSZG5tS2J1QW9E?=
 =?utf-8?B?VkxpNzE3c2JEZ2poM2xTQ2NENU9tcHhSYkhSTnRHdnpnaTh2alBwWVh5M1VO?=
 =?utf-8?B?L2N2aTBabnhNSXpOd2xxeHRGVUdaN2M0UTNiMERYdHo3eVRsNjVXeXFqWmdG?=
 =?utf-8?B?V3JJQ1hwRk90K1ZDeHF1OFZGcjJ4OGVIeDVXQkxqNG95dVdnR2txREdneDRE?=
 =?utf-8?B?THB3ZE9hZ0xqNjl1azJ0SjZkRFJDZlBscWZPbTFxNWFwOVZlZDY5N3l2T0do?=
 =?utf-8?B?dzV1cjAyMndIemFmb2tXTXVNRzBnYWtRV3hwS1hSSzBWRXdUZVFVWWxuZ2Rk?=
 =?utf-8?B?ZWxMaCt5TmVPR2tsRkFGZHpSY3NoTHRjZ0tOdFU2enduVENLNXRSNzJkRHlP?=
 =?utf-8?B?eGNmclRFY3F2ZUV4OG9MSUxBWUJycE02OCtnWmNWRUVDeTJXOWhLMm50MFAv?=
 =?utf-8?B?Nk9EaVQzVndFSTE4QU1xM3E0WlNXR0grUGszNCtPNUpxVWFUc1RoV1Q4SjZr?=
 =?utf-8?B?WnRmeHp5OG1UYXR4KzR6a3doWlVUS21Vb3BPaEwwaVAzdEMxQml3dlQrNlM3?=
 =?utf-8?B?Y0FFdE1FYVBQM1lNMGR6Y0hCRy9YS1IyTU9ycGozUjNOS1RVV0lta1pOVy9E?=
 =?utf-8?B?NmlBbDFuRG5kZU1qSzVad1o0L2dRcFlWcmpnNEdKQ0pyL3F0ZGxhZndrWk5m?=
 =?utf-8?B?R0JreTMvUEV0Z0pHUU1ZNGxkMjgrQndTamlOaElKSS9URWZTcjRsampzMklU?=
 =?utf-8?B?M0tMQ0o1OVBOUm1zSXlLNC9zRWFPYktpeHJkYTByOENqYXRyZk1IUFRVNWRu?=
 =?utf-8?B?a3FFUDJvM01VWUhONkFjVCs2KzRNNlJvZTIyUkFaeEFzQlY5RUVuUWNZVE9S?=
 =?utf-8?B?V28vYTE3YnBxN0Z2LzZ0cm1VZUlzeWoyQ0dlcHpaNHZhT21XdXI1c25aNTFJ?=
 =?utf-8?B?MU51L2dqcmxvWlpjbDBWWGFlWXEzbGFTMEhSMFAzMnFSQ1ZEQWFUcVhTMVVn?=
 =?utf-8?B?MytocDBrWGM0UkFiWnFZUHNNYTVweW96Y0pKampVYk5PMWFOTy9BeFlZd284?=
 =?utf-8?B?V2liNVRuOXV4K3BpcSt5Nmg1N01UTUxmN2krZ2hNVTdqUXI5Sk43blNLR2J4?=
 =?utf-8?B?V3RNNURiU2lLZDZ3RzBWOHVRUmxuT2k0SE1CTmkxZ0hFTWZVc2sxdVlHME0z?=
 =?utf-8?B?RldrNkhtR2FoZkdGcFdGRDNVYTdrMDdJamhEcExybFdxTGpmQUcyWHR2dU91?=
 =?utf-8?B?WTRhZmN6V3dPRUE3bDhmeGpwdGZXdVVNTDBTTU1DQVh5Y0RmbncrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B39BD7694B9B9F439D4F46AE516ACC99@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t/R+uS3SH090K74tuD/vff9QZehOuxxTOyGv0tFgCFHhU7efCU7IXag4Cv0ON/PmgrisJD9lxVVc12f0vuSPoOMYYAJYJ0SuywVkPWMx66AcDTc+alKUBUY6XGygjUqc0xg8ew+pPWqXT1BENu/i9DciJ388QEm+GSSWlY6sTuGWgfVZ+xZ/3rE4xRsA+4myLXcMyVDYECPibpnSTgNiXc0Dku69dfuPE2uHCr1TsEWj5JdH8ZDPDDNWsB8sdev3tuyaCIsI9BsXjHINJZyp0tA0eAVPA7aJ8taL6Ct4jSDsapt7L9sR3lgboockRwoyeNQh+aaTOJ5zrZNIC/fxBQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783dcbc5-eca3-405e-14da-08de7a50861e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 00:45:39.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9PI5eQaq7C/l4agY98JRatEv4dQPh9nJoA9YRGKOcBgi/57514VcW8YQMrVnqCcHoRFmDE1DCsdnNaQ+SlSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9479
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DFF542098E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21378-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDE5OjI5IC0wNTAwLCBHcmVnb3J5IFByaWNlIHdyb3RlOg0K
PiBPbiBUaHUsIE1hciAwNSwgMjAyNiBhdCAxMjoxNDo1MkFNICswMDAwLCBIdWFuZywgS2FpIHdy
b3RlOg0KPiA+IE9uIFdlZCwgMjAyNi0wMy0wNCBhdCAxODo1NiAtMDUwMCwgR3JlZ29yeSBQcmlj
ZSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gVGhpcyBiYXNpY2FsbHkgc2F5cyBpZiBzcGVjaWZpY2Fs
bHkgQ1hMX0FDUEkgaXMgYnVpbHQgb3V0LCB0aGUgTlVNQQ0KPiA+ID4gc3RydWN0dXJlIGlzIGZv
cmV2ZXIgbG9zdCAtIGV2ZW4gdGhvdWdoIGl0J3MgYWNjdXJhdGVseSBkZXNjcmliZWQgYnkNCj4g
PiA+IEJJT1MuIMKgDQo+ID4gPiANCj4gPiANCj4gPiBUaGUgbm9ybWFsIE5VTUEgaW5mbyBkZXNj
cmliZWQgaW4gU1JBVCBpcyBzdGlsbCB0aGVyZS4gIEl0IG9ubHkgYXZvaWRzDQo+ID4gZGV0ZWN0
aW5nIENGTVdTLCB3aGljaCBkb2Vzbid0IHByb3ZpZGUgYW55IE5VTUEgaW5mbyBhY3R1YWxseSAt
LSB0aGF0J3Mgd2h5DQo+ID4ga2VybmVsIGFzc2lnbnMgYSAnZmFrZWQnIE5VTUEgbm9kZSBmb3Ig
ZWFjaCBvZiB0aGVtLg0KPiA+IA0KPiA+IFNvIHdlIGFyZSBub3QgbG9zaW5nIGFueXRoaW5nIEFG
QUlDVC4NCj4gDQo+IFdlbGwsIEknbSBtb3N0bHkgY29uZnVzZWQgd2h5IHRoZXJlIGFyZSBDRURU
IGVudHJpZXMgZm9yIGhhcmR3YXJlIHRoYXQNCj4gcHJlc3VtYWJseSBpc24ndCBldmVuIHRoZXJl
IC0gdW5sZXNzIHRoaXMgcGxhdGZvcm0gaXMgcmVzZXJ2aW5nIHNwYWNlDQo+IGZvciBmdXR1cmUg
aG90cGx1Zy4gwqANCj4gDQoNCkkgdGhpbmsgdGhpcyBzaG91bGQgYmUgdGhlIGNhc2UuDQoNCj4g
SnVzdCB3YW50IHRvIG1ha2Ugc3VyZSB3ZSdyZSBub3QgYWRqdXN0aW5nIGZvcg0KPiBzdHJhbmdl
IGZpcm13YXJlIGJlaGF2aW9yLg0KDQpIb3cgdG8gY2hlY2sgd2hldGhlciBpdCBpcyAic3RyYW5n
ZSI/DQoNCkkgZHVtcGVkIHRoZSBBQ1BJIHRhYmxlIG9uIHRoYXQgcGxhdGZvcm0sIGFuZCB3aGF0
IEkgY2FuIHNlZSBpcyB0aGVyZSdzIENFRFQNCnRhYmxlIHdoaWNoIGNvbnRhaW5zIGNvdXBsZSBv
ZiAiW0NYTCBIb3N0IEJyaWRnZSBTdHJ1Y3R1cmVdIiBhbmQgIltDWEwgRml4ZWQNCk1lbW9yeSBX
aW5kb3cgU3RydWN0dXJlXSIuDQoNCkkgcGFzdGVkIG9uZSBmb3IgZWFjaCBvZiB0aGVtIGhlcmUg
RllJOg0KDQpbMDI0aCAwMDM2IDAwMWhdICAgICAgICAgICAgICAgU3VidGFibGUgVHlwZSA6IDAw
IFtDWEwgSG9zdCBCcmlkZ2UNClN0cnVjdHVyZV0NClswMjVoIDAwMzcgMDAxaF0gICAgICAgICAg
ICAgICAgICAgIFJlc2VydmVkIDogMDANClswMjZoIDAwMzggMDAyaF0gICAgICAgICAgICAgICAg
ICAgICAgTGVuZ3RoIDogMDAyMA0KWzAyOGggMDA0MCAwMDRoXSAgICAgIEFzc29jaWF0ZWQgaG9z
dCBicmlkZ2UgOiAwMDAwMDAwMw0KWzAyQ2ggMDA0NCAwMDRoXSAgICAgICBTcGVjaWZpY2F0aW9u
IHZlcnNpb24gOiAwMDAwMDAwMQ0KWzAzMGggMDA0OCAwMDRoXSAgICAgICAgICAgICAgICAgICAg
UmVzZXJ2ZWQgOiAwMDAwMDAwMA0KWzAzNGggMDA1MiAwMDhoXSAgICAgICAgICAgICAgIFJlZ2lz
dGVyIGJhc2UgOiAwMDAwMDAwMDk5N0YwMDAwDQpbMDNDaCAwMDYwIDAwOGhdICAgICAgICAgICAg
IFJlZ2lzdGVyIGxlbmd0aCA6IDAwMDAwMDAwMDAwMTAwMDANCg0KWzEyNGggMDI5MiAwMDFoXSAg
ICAgICAgICAgICAgIFN1YnRhYmxlIFR5cGUgOiAwMSBbQ1hMIEZpeGVkIE1lbW9yeSBXaW5kb3cN
ClN0cnVjdHVyZV0NClsxMjVoIDAyOTMgMDAxaF0gICAgICAgICAgICAgICAgICAgIFJlc2VydmVk
IDogMDANClsxMjZoIDAyOTQgMDAyaF0gICAgICAgICAgICAgICAgICAgICAgTGVuZ3RoIDogMDAz
NA0KWzEyOGggMDI5NiAwMDRoXSAgICAgICAgICAgICAgICAgICAgUmVzZXJ2ZWQgOiAwMDAwMDAw
MA0KWzEyQ2ggMDMwMCAwMDhoXSAgICAgICAgIFdpbmRvdyBiYXNlIGFkZHJlc3MgOiAwMDAwMDAy
MDgwMDAwMDAwDQpbMTM0aCAwMzA4IDAwOGhdICAgICAgICAgICAgICAgICBXaW5kb3cgc2l6ZSA6
IDAwMDAwMTdCMDAwMDAwMDANClsxM0NoIDAzMTYgMDAxaF0gICAgSW50ZXJsZWF2ZSBNZW1iZXJz
ICgyXm4pIDogMDINClsxM0RoIDAzMTcgMDAxaF0gICAgICAgSW50ZXJsZWF2ZSBBcml0aG1ldGlj
IDogMDENClsxM0VoIDAzMTggMDAyaF0gICAgICAgICAgICAgICAgICAgIFJlc2VydmVkIDogMDAw
MA0KWzE0MGggMDMyMCAwMDRoXSAgICAgICAgICAgICAgICAgR3JhbnVsYXJpdHkgOiAwMDAwMDAw
MA0KWzE0NGggMDMyNCAwMDJoXSAgICAgICAgICAgICAgICBSZXN0cmljdGlvbnMgOiAwMDA2DQpb
MTQ2aCAwMzI2IDAwMmhdICAgICAgICAgICAgICAgICAgICAgICBRdGdJZCA6IDAwMDANClsxNDho
IDAzMjggMDA0aF0gICAgICAgICAgICAgICAgRmlyc3QgVGFyZ2V0IDogMDAwMDAwMDMNClsxNENo
IDAzMzIgMDA0aF0gICAgICAgICAgICAgICAgIE5leHQgVGFyZ2V0IDogMDAwMDAwMjMNClsxNTBo
IDAzMzYgMDA0aF0gICAgICAgICAgICAgICAgIE5leHQgVGFyZ2V0IDogMDAwMDAwNDMNClsxNTRo
IDAzNDAgMDA0aF0gICAgICAgICAgICAgICAgIE5leHQgVGFyZ2V0IDogMDAwMDAwNTMNCg0KDQo+
IA0KPiBUaGUgb25seSBwbGF0Zm9ybSB3ZSd2ZSBzZWVuIHRoaXMgYmVoYXZpb3Igb24gcHJldmlv
dXNseSB3YXMgUUVNVSwgYnV0DQo+IHRoYXQgd2FzIGJlY2F1c2UgaXQgbmV2ZXIgZW1pdHRlZCBT
UkFULMKgDQo+IA0KDQpNeSBtYWNoaW5lIGhhcyBhIGxlZ2l0aW1hdGUgU1JBVC4gIFRoZSBrZXJu
ZWwgZGV0ZWN0cyBpdCBoYXMgNCBub2RlcyB3aXRoDQoyNTYgQ1BVcyArIDI1NkcgbWVtb3J5Lg0K
DQo+IHNvIGkgd2FzIHdvbmRlcmluZyBpZiB0aGVyZSdzDQo+IG9kZCBmaXJtd2FyZSBiZWhhdmlv
ciBnb2luZyBvbiAoZW1pdHRpbmcgQ0VEVHMgd2hlbiBpdCBzaG91bGRuJ3QpIGJlZm9yZQ0KPiB3
ZSBqdW1wIHRvIGRyb3BwaW5nIG5vZGVzIHRoYXQgd291bGQgaGF2ZSBvdGhlcndpc2UgaGF2ZSBi
ZWVuIHByZXNlbnQNCj4gb24gZXhpc3Rpbmcgc3lzdGVtcyB3aG8gbWlnaHQgaGF2ZSBjb21waWxl
ZCBDWExfQUNQSSBvdXQuDQoNCkkgZG9uJ3Qga25vdyBob3cgdG8gY2hlY2sgd2hldGhlciB0aGUg
QklPUyAic2hvdWxkIiBvciAic2hvdWxkIG5vdCIgZ2VuZXJhdGUNCkNFRFQuICBJIGNhbiBjaGVj
ayBteSBtYWNoaW5lIGlmIHlvdSBsZXQgbWUga25vdyB3aGF0IHRvIGNoZWNrIHNwZWNpZmljYWxs
eT8NCg0KPiANCj4gWW91IGFyZSB0YWtpbmcgc29tZXRoaW5nIGF3YXkgYnkgbmF0dXJlIG9mIGNv
bXBpbGluZyBzb21ldGhpbmcgb3V0IGJ5DQo+IGRlZmF1bHQgdGhhdCB3YXMgcHJldmlvdXNseSBu
b3QgY29tcGlsZWQgb3V0IGJ5IGRlZmF1bHQuDQoNClllYWgsIGFuZCBpdCBpcyBkdWUgdG8gInRo
ZXJlJ3MgYSBjb3N0IiBpZiB3ZSBkb24ndCBjb21waWxlIG91dCBieSBkZWZhdWx0Lg0KDQpIb3Bl
IHRoYXQganVzdGlmaWVzPw0K

