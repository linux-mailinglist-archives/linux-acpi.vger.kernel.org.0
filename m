Return-Path: <linux-acpi+bounces-21408-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHTQEcdaqWmE6AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21408-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 11:28:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A029420FAF9
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 11:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4F6630D3333
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1737F724;
	Thu,  5 Mar 2026 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd3936ER"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742F37F739;
	Thu,  5 Mar 2026 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706281; cv=fail; b=sPJ/xL6Q18UtK/0qMWbrBFKqzp2tPgRgkJB33ZAzkBpvE2At2u5XdUkPlbJ4TfvKT3gDLvI8QKkQQsvRDeC8OOel8QTsvDSAmP+4eordVVdMx2Rh5YGMHHp/sdxsLWsmOV5nliaANnkWuYbU5uRBMLMbaruT/WXvpnxzlasHl5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706281; c=relaxed/simple;
	bh=V2HW/NWQ+jJdcCpWCJs7kU/Jye+k/8qPQsRiGRsZKls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=REmpua/xFR81v6YCYcbNbeb66T046wmJO1ezZ2VdHDirjUzy9vq/hwh/NVYzynwsHUmA/bDNP4/5+PETJq1QhD9K6O3AdzpXhD98OLuZPQNomaDL1Er2hXtC09E2hd4nw0+pLnhD1PqR7FEqSMjCVySY24adRNoO4n7CQQnnHJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nd3936ER; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772706278; x=1804242278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V2HW/NWQ+jJdcCpWCJs7kU/Jye+k/8qPQsRiGRsZKls=;
  b=Nd3936EROmvSkarPjcr8MAkJmsBEOHYLzoki4Wl4NlGZ5+kPEUfOYgXi
   YgyhXW5z8uSqYis8FjQyXR95XHyl9EEdnk5FCF+6wsHfa9GfaHgP156Vw
   TvoSRVV5rtYNpve11WJvwV5L+rW/u+UBQaJUmCGnd7M/80q/zxUu70h8W
   afvl2+BdK7EvPp5BmTMible5JqS8GKPAXUxA5b3ngJDdJyBE9n9lGAdQD
   DGPx+U0GI85D7jobXSEBhbiTGBShoMFtAOx9tkOOR7LNBS+tz5MZD7rC9
   mORZyQMQdZKjUg9My99+9nj5ZEGOIW52bPi7mtTxcokhHjZjrL1NZxX9Q
   w==;
X-CSE-ConnectionGUID: t9nLUuBPSmK1DyT7is7k9A==
X-CSE-MsgGUID: vcLSrQcgRim3UcOrfWORww==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73858502"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="73858502"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 02:24:37 -0800
X-CSE-ConnectionGUID: 2k6tmJ9CS66O/bavqXofQA==
X-CSE-MsgGUID: boMsSdLUSiuJVlpzcVNSzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="222788211"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 02:24:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 02:24:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 02:24:36 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 02:24:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDdkXcEK5ploZt0pqHUg7zPTti2sSFoQ8tWTAaf5ZlDrdOs3navAWKjfFbzLYiE2aauBu8SAcWUkBQZxt000XR/Kn5rgQWXY1OdTxEAYogXlUytrW9NYoWPhmZzbf/aH3Y319v1ZIBcfW4WOSq2fQv6g36SRbtNDt56VD792yzKzC60ZfJ3SmPpBR947xEhAIblRBuZKrT9Ki7e09iKLD+pSeQsq1Y+QkcvdWMABLEeUvyRsz/QcEfFByAS3nJ2Jj7W5JIQbhD3vd9GHbQQxTA4DYhg+dMA2maMjTWCO6/uhgjxn6IwmFovACOIKRVA/azlpq70mZE2KbZy0ItEOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2HW/NWQ+jJdcCpWCJs7kU/Jye+k/8qPQsRiGRsZKls=;
 b=U0BlwLzVwr6nrIEgAygKqJ0rwMf/X7UN6w2/DJSfDPLuZl8j2ed9SvBcE5IArDWr/I4084Qjb3B2I48uHl0oRdigiuzlvf4cd4FpOkG/Q/A9Ml8ChEI6S4LDMoZvEmLpca3xOx9jlbXnOTB1AP9l6M8rDyO8qsEFZy81RP66tut33DqtNGVQwqkLJnXX8Qav3NWirPlgvGos1IQMZT/eeaiF8fZrL0/qgzEckspZL3RYNj1EoyttZE4BLDSKIScwRNP1R+5IL/oMWN1SVpbQuANDtabKDe7xcu+UJd9nMjttJx25LVuPyH7jpuegUluDF0tfy/C3ZG8u56RtW+XwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 10:24:33 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:24:33 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "gourry@gourry.net"
	<gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Schofield, Alison"
	<alison.schofield@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "thorsten.blum@linux.dev"
	<thorsten.blum@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Topic: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Index: AQHcrB6hFMt1tftCWUOUCZXHrNvLJLWe9ZgAgAAND4CAAAoyAIAABQUAgAAEMQCAAARwgIAADEwAgAAGCICAAATiAIAAA9GAgAAK9wCAAHvHgA==
Date: Thu, 5 Mar 2026 10:24:33 +0000
Message-ID: <4641cfbfd87e00438a1361f6b2900c980725a612.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
	 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
	 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
	 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
	 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
	 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
	 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
	 <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
	 <bf78a2ee58e99e1fab9df3b5406f20edf9420415.camel@intel.com>
	 <69a8e5a4d2372_2f4a10056@dwillia2-mobl4.notmuch>
	 <aajo16gazmWSsXDh@gourry-fedora-PF4VCD3F>
	 <69a8f20ad67cf_2f4a100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <69a8f20ad67cf_2f4a100f4@dwillia2-mobl4.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS4PPF2AD6B04BA:EE_
x-ms-office365-filtering-correlation-id: 5e73bf34-c1a3-4d96-1929-08de7aa164ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: azKwdET1lkXLLHB8R36t5D6UHyOoFJ7S1VLSRDoq6Ch6NB3rP+YHAH8Wsky1Nrmk7KC5IZTpBD4xsEbxt72H6gFQEZ7oNh9w0+9XEGw350haJ0Mt5fvvQSfQlHWQEmlnBkNC40aFHlD3CFQp5v6OnwlNCeLwdw3C2LY4OXZ5k26zZBdX/pARnnwUKWICfeZHQrsSod2OPOviGoxZjUz80AGs/z7nXutDVvH9q57T+5lpSOBH8h5FaGqnwCqt6ILLSv4+nQ3XpAK3u7kTrLwyaoHyBBo43n7Ajkg7+Jp4slGxUmTcQULRdMsGvP2PZHtwQi2CHJuLpVqmflZ83j/yJqF85gL8G/8nb1G5lZf1eNX/EAW4b1B0lV9tuKL9oOjgLQJJswpT6b2drVKlWB5JLJ2HDvgzWDkQ+wa53RFMSh/w5chen7SXGRnu4K/q4wHHR1UmSO9I19ICnzovqUGeS/YgSOPMAS01ULO/PHFSt5WjGI7W+v5dZA38tW8JW8kc+dUd8SdedAECGSjlVFJVnVCc+tMraOPzds5xr2yqnFWKjesvkdmQMWSAIQ6nMUnEUf9n0IpJGBz9mO92yK2W59keQEwqNGL4I1G/DUNq0xxxWdn43OBEMibORjB9vhBqScL/kI6GLZAOtLQMAriNZBAVtDCAfaY00iWCF+O0KhmMSCqVyfY7+ZVmrdQhcK/Gys7GoLMQzEbCh23IO05OXuxlxy2TJi4o7tSdQL+R7PsSMMkBUP9GJmwEWmnM8YqQaiKokOORwXD3WLeTDEvxrRNbi8A3QSPiEh+gQOO/3bo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlA0UkJyaEFibWQ3MTFVS2ZNcnVVUnRUY29QWXRJSVFDa084VEQ0MXdJV01T?=
 =?utf-8?B?eDdKMzhSR3FmbTVpK0V4eUVtMG5oemlUKzhxbzJQSW9IeWFuU1F3L0pSQTRR?=
 =?utf-8?B?Qmp5OWJ6dWY3azErTlNGRTV0eFFycGVTUDQ4cldWZTZ6Smw4WXVBKzNyNmln?=
 =?utf-8?B?REJoQXA1Nmx0ZndPTnNVaktXanlpcWhtSFoxTHNtQm8veFB0WG51SkYzcGtu?=
 =?utf-8?B?dmJQYVpRYkdTZmxUSWt3TmxXSFE2WWJtN1FleXZaNE9EekhFSUtXVDBFK0d3?=
 =?utf-8?B?T1JaRjRTL3FTTjNsUEFBWHpiT0V3YktKZTc3NXFQVHFZQk1UeWI3ck92Rktk?=
 =?utf-8?B?d3ZkZlU4UEphR2syRVVCR3h6TW5EcUJNSDN5RmxiZzJGY2h3VGoyS2U1NjQ1?=
 =?utf-8?B?T1dMWVpLWGJTRG95aFJvbTZkRG4ySGxCNHgyZFVUT0d5THNiNHVUQkRXbmtL?=
 =?utf-8?B?anBuSlRnOUR6SjlNSTFQRGlSaGpmTk5OTWEvSHFERm1OcEJHWTJ1OXY1bnRY?=
 =?utf-8?B?cUJpb1UrRWJkRXJ5SGNQdXB4Q21iVWd6MUM0all6eDMyUlBxTjlNZFZ2RHdy?=
 =?utf-8?B?NlB3Q0Z3MGFQWXd6NDlkWGZCeTBvMFlqSlBsbHBzdEl3RWhlOVFZSTcvYUVV?=
 =?utf-8?B?TUpEMHNOQ2NBNE40M1plTCtNeTB3UFNWd2cxdXo5eDE0d0Z6UGs1WngyVnVv?=
 =?utf-8?B?QTRmaDl0VGNaZllXZHk2cnhsZVpOTkY2ZW1oWHJwQWtPaUxlVXAzL3dxK1NF?=
 =?utf-8?B?SUpUb3A4TjR0UEpRVkNWcEVReFdQaG9Tby9xV2F2SVpjeEx5SjllV1dBQ25P?=
 =?utf-8?B?Q1BKNW5yQ29oYk90R1RBcnNQMkdrc1R0TlhHUkVZemNldlM3cE1YSkthRlQ0?=
 =?utf-8?B?Q3dmdjYxQnhINHdlckN4RzlUN3NWeU50RUNwakVJZ1E0U2pSRzRWMHpWamx6?=
 =?utf-8?B?UGdlY2ozTUcrU1RwUCtoR29BaFUxWGwrUWE4TjhmWlh5aUU5K0d3Tk93T0Nr?=
 =?utf-8?B?RDlBOUhhVEVxai9EdzU4aExEaW03RzBUMmFod2dDRkRQaW1VZWxmeDlsWjNj?=
 =?utf-8?B?d1Rhc0t6OVc2OWlCMXZ4ZVRHcnc5Tlk5K1NES25RVWE1V3lpQlRuOXNkeGNq?=
 =?utf-8?B?RzQ4YWgyd0VFUFJCVkVZVzJMNVFJT1Y0bkVNZzlWVmdxZDdYT0VJSlFoUHJF?=
 =?utf-8?B?akY1Uk95TDE2eGJMT2VXTEJWMmZZcEZuOC91cndCcWFpSWt4ODdndGxaNUU3?=
 =?utf-8?B?T09vV1RRUTFYZ2licytJdkVGV3ZwZXUyazNTZUpXcW9sUVp6U3dTc1lja2dq?=
 =?utf-8?B?OWxWR2lwMnRLUmtJbjFlSVFQemtKWTAwLytmZjBMWG1uVTZtUkhHNS9wTDNN?=
 =?utf-8?B?YzRucS9GenhhTTluK3ZaeGh3QzVDTkRNV2wzdjNZQ09aeDNwZU1UQ1RzbGpU?=
 =?utf-8?B?UG5JeDJQb2J1VHNTOTRkVS80YlpyWEZ2ZUgzZkpZQTZLQnJvaGIzZ2d2Mlov?=
 =?utf-8?B?b054cmhiSEhhVHBwVjRzbXRPd1E1YWk4d0ovU1RnRWlYUU9DUHpvY0dIWEZo?=
 =?utf-8?B?NGxlL3BmSXRJdGgzTkNQemxLNFRsS0pFZjFUTjFVclY2RlpkczhPV0t3aUds?=
 =?utf-8?B?ZllOWkVkT1hkVTQxSjA3NE8zbFJqZDAvOGZ4c01YYzFobVpBUlJXN1lxaVlj?=
 =?utf-8?B?ZkdVMjlTQy9UTng1RjcxanBwV3JadzI5U251bVhpaGpBdXlnUzcxaDRRa1c2?=
 =?utf-8?B?VXdpdzQ2My9FWUN1blp1bXZiUlBqRUlKbHNNcUhaU3NwWTl0WDJGYmRDVHlx?=
 =?utf-8?B?anFSTHdqc1BRZmhJaUNzMnNWcG9YY0U2d3J2c00vd0xvZ3JUNjZmR2FBMUsr?=
 =?utf-8?B?K3hiUnRid1pTZW1FRHk3dHlxMHg2K1F4ZG1oTUdLZ2c0czlTUmdUZkRZcjRj?=
 =?utf-8?B?N29MWStSbWlwVFk0TDN1L0hqZjZQOVBhWCsyWjA2UjNNTkNNcG0zakIzRXdE?=
 =?utf-8?B?bGpySU56bG15aHJ5TUc4SEk3LytweUtBUUg2bHJJU2ZDb2djcFU3V0ZDeDlm?=
 =?utf-8?B?YngxREJzY1BJdWs1dHNSV3BtckZsQzJqR1NwUXdDdXNPYjZlNVE2aERzZkpQ?=
 =?utf-8?B?V2JvSzNienB6SXVxYVB0cVNOK3d0UzhVc1U3NlR1TlBzWWZkc2wxalpUMkJO?=
 =?utf-8?B?VUxmWk5JR3dpb1RpeEMwdTZsQi9WN0lOZzdaTFk3ejErejlLZzBQektPQlcy?=
 =?utf-8?B?ajNHY2xIbVJLSE92alZuZ29tUndmcFljRk5EVTZLOGJqYkdmRGZkbnBaQlR6?=
 =?utf-8?B?THBzNXR0YWVVWUFvZ3RBUnJaSkh6UXdjbWhtelp6Ni9yWnJSQkc0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4941A819747EBB4B9E94196D483E04BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e73bf34-c1a3-4d96-1929-08de7aa164ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 10:24:33.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUF3YxuUBoXsanY08K7pDYDQciBOFPayruuW0qSeg9m/2cMO6tmm+E+v8s2ZsOPNqqtPEPH441WB915ESFs39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A029420FAF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21408-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDE5OjAxIC0wODAwLCBkYW4uai53aWxsaWFtc0BpbnRlbC5j
b20gd3JvdGU6DQo+IEdyZWdvcnkgUHJpY2Ugd3JvdGU6DQo+ID4gT24gV2VkLCBNYXIgMDQsIDIw
MjYgYXQgMDY6MDg6MzZQTSAtMDgwMCwgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tIHdyb3RlOg0K
PiA+ID4gSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gQSBzbWFsbCAyIGxpbmUgcGF0
Y2ggdG8gc2F2ZSBhIGZldyBtZWdhYnl0ZXMgb2YgbWVtb3J5LCBzdXJlLiBBDQo+ID4gPiBwYXJh
Z3JhcGggb2YgY29udGV4dCB0aGF0IGFsbW9zdCBub2JvZHkgd2lsbCBldmVyIGNhcmUgYWJvdXQg
b24gYSBnbw0KPiA+ID4gZm9yd2FyZCBiYXNpcz8gTm8sIHRoYW5rIHlvdS4NCj4gPiANCj4gPiBl
aCB0aHJvdyBpdCBpbiB0aGUgY2hhbmdlbG9nICpzaHJ1ZyosIGkgdGhpbmsgaXQncyB1c2VmdWwg
Y29udGV4dC4NCj4gDQo+IERlZmluaXRlbHkgZ3JlYXQgY2hhbmdlbG9nIGZvZGRlciBhbmQgeWVz
LCB1c2VmdWwgY29udGV4dC4NCg0KVGhhbmtzIGZvciBhbGwgdGhlIGZlZWRiYWNrLg0KDQpTbyBp
ZiBJIGZvbGxvdyB5b3UgZ3V5cyBjb3JyZWN0bHksIHRoZSBjb250ZXh0IEkgcHJvdmlkZWQgaW4g
dGhlIGNoYW5nZWxvZw0KaXMgc3RpbGwgdXNlZnVsLiAgQW5kIHRoZSAic2F2ZSBhIGZldyBtZWdh
Ynl0ZXMgb2YgbWVtb3J5IiBpcyBhbHNvIGNvdmVyZWQNCnNpbmNlIEkgcHJvdmlkZWQgc29tZSBk
YXRhIGFib3V0ICJTbGFiIiBpbiAvcHJvYy9tZW1pbmZvLiAgU28gdG8gbWUgSSdsbA0Ka2VlcCB0
aGUgY2hhbmdlbG9nIGFzLWlzIGluIHYyLg0KDQpCdHcsIEkgdHJpZWQgdG8gYnVpbGQgd2l0aCBX
PTEgd2hlbiBDWExfQUNQSSBpcyBvZmYgdG8gdmVyaWZ5IHdoYXQgRGFuIHNhaWQNCmFib3V0IHRo
ZSBhY3BpX3BhcnNlX2NmbXdzKCkgd2lsbCBnZXQgY29tcGlsZWQgb3V0IChvdGhlcndpc2Ugd2Ug
d2lsbCBzZWUgJy0NCld1bnVzZWQtZnVuY3Rpb24nIHdhcm5pbmcpOg0KDQogIFRoZSBjYWxsIHRv
IGFjcGlfdGFibGVfcGFyc2VfY2VkdCgpIHdpbGwgZ2V0IHNraXBwZWQgYW5kIHRoZSBjb2RlIGZv
cg0KICBhY3BpX3BhcnNlX2NmbXdzKCkgd2lsbCBnZXQgYXV0b21hdGljYWxseSBjb21waWxlZCBv
dXQgb2YgdGhlIGZpbGUuDQoNCkkgdHJpZWQgYm90aCAtTzIgKENDX09QVElNSVpFX0ZPUl9QRVJG
T1JNQU5DRSkgYW5kIC1Pcw0KKENDX09QVElNSVpFX0ZPUl9TSVpFKSB3aXRoIFc9MSBhbmQgbm8g
d2FybmluZyB3YXMgZm91bmQuICBJIGFsc28gdHJpZWQgYm90aA0KZ2NjIGFuZCBjbGFuZyBhbmQg
bm8gd2FybmluZyB3YXMgZm91bmQgZWl0aGVyLg0KDQpTbyBJJ2xsIGZvbGxvdyBEYW4ncyBzdWdn
ZXN0aW9uIHRvIG1ha2UgdGhlIGRpZmYgc21hbGxlci4NCg0KSGkgQWxpc29uLCBHcmVnb3J5LCB0
aGFua3MgZm9yIHlvdXIgcmV2aWV3LCBwbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUNCmFu
eSBjb25jZXJuLg0KDQpUaGFua3MuDQo=

