Return-Path: <linux-acpi+bounces-15712-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB72B271A2
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 00:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8BF1B67D9E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE427F749;
	Thu, 14 Aug 2025 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBAhZfbR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2E1C9DE5;
	Thu, 14 Aug 2025 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210796; cv=fail; b=KKjABvmjKsu3ZJr4BAQQGcrnahJ7j97tfWKU3ltRR94b/Gbm5s2fpy1F0gxya0ajhR6vBSa+AHpQMgo3ui8bLXa9UPYspPbCV9x/JCYKXvJrzQT6WMzv/tk26jfMzrRThA914UxERzzKJAvQzDrkiEU7OgL3T+FVTZ4mK4kojZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210796; c=relaxed/simple;
	bh=IlBPgeBEdr1OrgziVQScnCNGUA6wsgKQNIV8zjPZrmU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nCDUp0niozQh2zBAfVLAyZfjKt2AzuYCUxKKBFpcUKZFo645frEWWCJm8ZDW5+Bd1vNzOp0VhrQ+MOLoIahSSuRy8fDcXyO41gyixeAgd2ElYMWK4O84dVb98n2hWaW7fYCJcRydRmWpNgzUt3pJqAgY/s7OosSiAKYDeY6f6FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBAhZfbR; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755210795; x=1786746795;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=IlBPgeBEdr1OrgziVQScnCNGUA6wsgKQNIV8zjPZrmU=;
  b=bBAhZfbRtZ6i5+HGli3R/5doAj+4GnEvwGIcEX8lubeVCnnMlE8cxFC/
   VXln5oFw1k2pKefSU95+ZHga6OfQJnmOu/X3Q2bH3xaH4ODOcYKwF2vUD
   Ytio06rFGaDXS0RLOPu57Q//EQ78Axs1/4FUasaGyOgIEq39p9dS+Qe1Q
   MLJXeBNZrUFDWVYY7uWH4Fh62+igD9i887JI3nSKbTn2zGU269xr49QCv
   9B4FLKW11iL+LPJLEVf2U3LYfpdsGb6rBduHGHkjQArEJjRf6cVIQ41kq
   otTngblI2irOmHlIGGx37t6HIct1tdn5TyqjGdkuwvsQVDLVKY+lWXUrX
   Q==;
X-CSE-ConnectionGUID: F5kwJMPwRHyadTXCY1PMbg==
X-CSE-MsgGUID: mp2VzqBlRbasFG7EWW7Kig==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57610892"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57610892"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:33:11 -0700
X-CSE-ConnectionGUID: O+aZlP7JQ5uEyH2Y6tFDCA==
X-CSE-MsgGUID: beVmXELTQz+/MVa0yYPKlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167239885"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:33:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 15:33:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 15:33:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.80)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 15:33:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFl3Uz0OeSsmHQhPmK1getaNB8FKDDAXNI3e2jeKkVzPig66Iht3jW6+aVX6DslsEVbPc9F/L4XQMFNob6JvBzljnQ/S4XGvsV+oLNrNyITVA9UAlVRlMq0HHCZVPv9eMH5qQAf1tL1iUQlifHmjBP9k/sGtXFq9YyB8JHOMbL8lAn67/Nvt7P6SfdIFBoowgA0gMZ/DayVomvENWEpMOHyXpXMCnlu1j+/U6J1a0MNrPYLk/cTCO4VqqUc3Y1hpF3JVeaVPpZPXIqazMPVNhdp9TQDzxZEd8n9bg+9c7KrHTVYcg2g2vbjsMMVqjYp8G8hvH/dea1vhKCTqGgw7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvIdrP4DI/I4RMXMB31A8chH4vZvVDpNbTqIzrqBACI=;
 b=hLGSG/+ygEHdwNEv7/sofVdYsUl0NMEdhis9K1SgmYavmjx48NNaYyZEYIFCyLyO6UPPcfyr0VrY4pCCiz7Ycr12fDtRXL+NFRH4LR+ncDzPhw516kmPWVEiVuKIXjX8X0aFX+DtrHW/9VxQIX3XUOC0s++BqPhdxO6BKSlHmArKz5JvFVXcaaOd1APT8NSNXlW5e3iWFrhMX9orjsz4cVGLenUmQViE4c+Qy830XWAE7OR1Fq5afJMbbSLUvI9R+YtZkrne/V4OMhc0QX8M01TFK19D7DrVe+4hgc8/VvkBlrZ1Mn1jq53/3tMvlhkS9eor8OPvBtnnGECSQ41+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 22:33:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 22:33:08 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 14 Aug 2025 15:33:06 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<marc.herbert@linux.intel.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>
Message-ID: <689e64229859f_50ce10082@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250814171650.3002930-4-dave.jiang@intel.com>
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-4-dave.jiang@intel.com>
Subject: Re: [PATCH 3/4] cxl, acpi/hmat: Update CXL access coordinates
 directly instead of through HMAT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 27eb618d-6847-43ce-01e5-08dddb828b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEo0eFZ6cXdmMmhYNlE2Ri9tKzBUYUEwRGJhWGVTblZHaHdrM1RSZnpyNWdD?=
 =?utf-8?B?K0ZoZm5BUkVBOXdLU3FiSlFvTFJReUhCdm5iRmNzbkd2UU9OekdwSHhNZXNG?=
 =?utf-8?B?aGQ5a0ZyU3F5ZUUvWjVGQi83eThkd2ZYNWRPYXFWZXhOR2srYnRLNWt1U25K?=
 =?utf-8?B?MTZCb1FlTWVka1ZTZUgzU1hvRlc4bG1MTWIrR0MvRDFpTXFVbVdzU2xIQ210?=
 =?utf-8?B?VkJpTldXVHdyLzR4dmtjaHQyL1lTT2h6YlhaY2pzbGdUS09NZ2hxRURnbHly?=
 =?utf-8?B?M2pMVDc0Tk15a1d3TFcxTTBzNjA3aW5rRnAvaEVDRHhsQjFmTXhkdkxxOU1t?=
 =?utf-8?B?czUrTmVMY0E2WFJKRThBUjJYYmNGdzFCM2pqaVFycTFpUEI0UkdXUVV4aXBM?=
 =?utf-8?B?VEVwd0t3SDZzUkg5N1E4TDVzaXZkSUtTVnFEV3RJRFVoUmJCT1k0VmFRRFkw?=
 =?utf-8?B?cWhMMG9raG5GNnFGajRFK3VXRjlZbUl6SzhWcGhzNWtwQi8wSDBtWnVDSll6?=
 =?utf-8?B?NVI5eWw3dkZKeWMrQ2FMd1BlSWdFSVZVUjZKaGpTeFFpM2tlYWdvZW9WSmo2?=
 =?utf-8?B?MENEUFcwTWtpeW81a2dpQVhlR3ZqaHg4azhoc3BzVHZCTnpBWFAyZGhlRGZV?=
 =?utf-8?B?Z2N2N2dOaVVSdlg2eEsrWWxiSWt4bktDQ3pDSHJoYkVNQ2lJLzdiUTRQTVVE?=
 =?utf-8?B?V2RlL0lBQkhjajJtSmdKQkRFZXIyZ1ZwNVFtT2I1eVNUTjByMkNpRFJEdDhT?=
 =?utf-8?B?UU5HUnZsNHRKK1pDZHlwRXBZZkpqSlg1UDBiZ1FzTjJOdFJ5eUVsZ293ZFZE?=
 =?utf-8?B?Qms0YXYxL1Y2aGR1NnRtZTJNT2h3UXE2NVZITThrS1ZlenZyQTNVV1cyOFhN?=
 =?utf-8?B?U1NsYk0ybnYzVEE3MVRvcm9XRkUrYzZQdGpsd2RVS25mN1h1aXFwY0V6RXdJ?=
 =?utf-8?B?NzVKMWVRM1E2dUE2ZlhuQ1Z6TGNsN1hQSFpZRXpzR2pwTzUrME45M0Y4NFpp?=
 =?utf-8?B?ZkNqWXN3alVoU3M2SFk2WW1xd1hwcll3dUVLTzU0eUZOcDFsTTZNdjBNbGVK?=
 =?utf-8?B?RE1TaVN6VXo2UFc1UEZ5SXkwQW9OUlI1dXZ0THJHNVZYN1ZhQ1VoQWY5VUds?=
 =?utf-8?B?S0pBNWY5MENINWtIamppSWRDeTdEb3NwakVVYnowQ2tpZXRtb2E4MUg0Ly94?=
 =?utf-8?B?WkNEUVVYOVo4WGxDbHo1YUJrbUlQWG9DaTRSd2k2WW5kVnE5K2N3REljN0dp?=
 =?utf-8?B?WjFLTGNjbFBuZ3VHRllFaTh3V0o3NytzYklFQk9tTGhQcVZTdnFsRUxiSzRI?=
 =?utf-8?B?RnBYOUNYeFZKL1BBcUx5SmU3NW8rMTlYbkxQdmJML0F3UHhPc09KS0tPMUxI?=
 =?utf-8?B?elJKRjFxUVlzOHp4QWdweHJEdG02SWdobmlvbWRCQk8zZUYzUkFuWTRJRmh5?=
 =?utf-8?B?OXdOTURHanZOTWM0MjFMVjdESFZvd1JHY090S25CYUFqakZDZDZvWWd1UFpO?=
 =?utf-8?B?RzFGOVpsTitmR2F5bVZKMlg1WFF1L3ZCY0lsNzdOV085NHpzdFhlM1o3RXAr?=
 =?utf-8?B?d3RTNitVYzVKdER4UHdIVDE3K0NrRVBrb0lQbmNvVjArKzNLVUkrSEtpNDIr?=
 =?utf-8?B?bTNIcUVpYUROLzM1ZmtrNXdhVmExQllFVHhGY1dMUWxyaDJNNmZZYnFCdEYr?=
 =?utf-8?B?Qi9kSGlEendpbDhsTVZZR3Vtbm0zUEx4a01lb0p6cVk1bHY1SVNwZy92dHl2?=
 =?utf-8?B?cFNrckdBYzRqQ1V3cWR2YlhMOVRaQ3d5WnZRS3FXejdJUUtYcmNWRkNLNXhP?=
 =?utf-8?B?KzdxcHNhQWZvelRCOXhmYXlaMkE3STRyWm05eHdJblRHb1hOUnFES1A0d1h4?=
 =?utf-8?B?ejd2UTcvdUVuZ2pobi9KVEZUWTh0Rnk2dWZheGorR1dKV1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bktqUUo2cTBKbnYvY2VTNXdMd3cvUy9RTWJZOHJ5ME4yN28xb1MxWHF3eDRS?=
 =?utf-8?B?MkV6NVc4NmdoYzV2TU5oRkZLS3NkdU1NQjZzdzB0alVNTnBsS0haTjdCUGZX?=
 =?utf-8?B?Mk9VZXptQ1ZJb2REUkVRMkxzZ3ZwQjJkYmU0ci9vS0pNSEM0Mm5HZ0ZmOHB2?=
 =?utf-8?B?VTZZSUc3Qzk3K2xUQzlwblF6dmFoMGEwL3VCelJYc3N2bWRaNFpscWlKcm1s?=
 =?utf-8?B?UWh0cjJiSDlTclRDK2c3citSaFlrWTVMNng3ZVMwRjBkRVl6ajhPNzhmRDJs?=
 =?utf-8?B?MXlPbmhuQWxhcDMrNkJaUll4S2VqTm9EZjE2N3VVOUNrQWY5eXBwYlgyL0xn?=
 =?utf-8?B?eTBtT0x5T0FGYithRFZNM3QxdDhWYWFRbHJ0SjJ6WHh2TE9XNlNwTDFMa2xn?=
 =?utf-8?B?ZElyamY0ZnJ0N3lMUXN5RVNCRGF5MzhGTitGcUNPOXpzU0JWOHR2SUd5UzZW?=
 =?utf-8?B?VnVEWlhPeitGbVRoN1dJamJZUkUzbTZ3NGQzOGtFVHd3VWExVTRoZXpnN2s2?=
 =?utf-8?B?NmtnMXRFN2tTcm9sR0laQTVSdlQzNHp5ZmdGaXZWTlZnbzdwNFdDN0N1RHJu?=
 =?utf-8?B?OGJ5RW9OSXhjNHNQbHJLQ2FFYzNFTHovVklRek82VXo2NVpiNnUva2FISGNJ?=
 =?utf-8?B?dDdMOThjcWxWQU1lWVZsWkZNWGtNM0tEK1pycitVS1JoZXBENWZaY0ZObDM1?=
 =?utf-8?B?c2d1TEZSdFBCSll0UVhCRWxFMTl2UEN3RjFBaWtTTG5tQTNXc3NCajFSOUNj?=
 =?utf-8?B?WmVUcW4zTjdoYUVmNHRRTi82dVlUR3RiT2dTMnk5N3ZWL0E3R0JyQ3g2U0Jw?=
 =?utf-8?B?MjFsYmZkQlJmN01TNGNqL2VtR3RlVUFaWXB3Q0dkbHhnckcxbnZpdmhKVXZR?=
 =?utf-8?B?ckR5ZmJTU3pDZVdTRXMvY1NBTDFMaXRpeS85TVNrZkFKeUtKS2RHT2RJajkw?=
 =?utf-8?B?ZStzemFBaFNrbFprVXZXZk1vT1hPdXk3b1dtTWFaZXBzMDMrcGk5YitVQVJt?=
 =?utf-8?B?b0pzeWV1eitCM3Qwd29heUYxbnZmeWhuRXkyNS9yQmpjRW5YbTN0NFFPM203?=
 =?utf-8?B?STBSekRPOC8xRTNXZjhsRVZ5YlpXOGZOR0s0dHVFamRvT2JqK3RFcjBORml5?=
 =?utf-8?B?MWlNaExrcUtEelQ5WWsxd2R4V2NzQmM2MjltRVYvdHVXMjZXU1hvRjZvc3hz?=
 =?utf-8?B?U1dyYzlpVGcrWGJKR1lSa04xcElGdHJpSlNqbkQ4ZXJCNnNkVkRsUmplYmM1?=
 =?utf-8?B?M1pIdDZRcVlaa2hRRzZVNno5UXA0NjdIb0NtWXZxdEprbmxlQlZsWk5uY3JY?=
 =?utf-8?B?a0M0VWtlalFETGFtMGxrQ1RKdmpEdjVLaGxmOVE3M3VWc2hWMUlSZ25zNG8y?=
 =?utf-8?B?OFJROGZFZFZUMk1pdWtSVjNSSXJHSSt2SFBhLy9jdlV6L2tDY2xZNytLM3ox?=
 =?utf-8?B?UlpJbHNnMDFQSmJOWTI4K1AzYnVVdC82dHVuNDZYOXRBdUdHRE1ORktPejJn?=
 =?utf-8?B?QkMwaFRUTDVXa1c2U0xTYWR3RGpEN3lKWWlZYXlPNmpSbFBrS2VKOUtnYnF4?=
 =?utf-8?B?ZGJ4RldzazgyaEN0Y1FPSkRmQnJvWnRYaEI1djVmSTdlU2ZBZTlzQVJrM1Bt?=
 =?utf-8?B?cUwwTGdwbFJJRmJRTEMrT1pLejRvcjJXeVBIZWM5UnhCR0tpMDhTVzdDVHVB?=
 =?utf-8?B?QlVicnpaNWtmYW1obm5WT3lFMkw5N3BRL0RQell4WHdVZ3dsYXFzaE5vcTVq?=
 =?utf-8?B?RW55ekRKWFE2aitLc1NkRUcwWHZMcHFYaFlkRHJaajV2bzNXWWs5WDFRVXdP?=
 =?utf-8?B?M29zeVpxNHRmckpabkN6SFBoQ01COXcrMEJZNkFHVlpxVGVSOTB2Y0JlaFZH?=
 =?utf-8?B?NFBvdVhYZ09EOXRUQ0JnMEtGaFVncEZPVUNjVHUxUlpkbmZiRW1CcmIzZEln?=
 =?utf-8?B?c0Rua3N2a3I3Q3k5d1BIcytRTi9nNGp5NDd3dWJoVXlDZ0VpQkZaREllVno4?=
 =?utf-8?B?ZWNxUkxwVk1CSTl1bDJiTjBOd2Z1QmhtMlUzK3pmclhLTGN6alMwYzdLeWxC?=
 =?utf-8?B?T2tCaWtxYkUxQ243K2xSSU5zbjdqZzNyWDltMGNuaS9JVXdnM0c0UVVxbW9N?=
 =?utf-8?B?UXljRDcrYUg5L2lPdjZCUVNFUGpPWEZZb1pmbWlQdUZRUTJhYWlZZ0V1dWpt?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eb618d-6847-43ce-01e5-08dddb828b1d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 22:33:08.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMHyhs4dJaYSZrySUPSx8W4c3rJ6T770CaTopwRcnTbt2/rhyOjSP5NcD65XhNTl3+fVoNM3fzzYnZ3ZeORpjUqZDwARssPDAC7bs8Otbxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The current implementation of CXL memory hotplug notifier gets called
> before the HMAT memory hotplug notifier. The CXL driver calculates the
> access coordinates (bandwidth and latency values) for the CXL end to
> end path (i.e. CPU to endpoint). When the CXL region is onlined, the CXL
> memory hotplug notifier writes the access coordinates to the HMAT target
> structs. Then the HMAT memory hotplug notifier is called and it creates
> the access coordinates for the node sysfs attributes.

Perhaps summarize quickly here the before and after of sysfs, so people
know if they are impacted by this bug, and backporters can verify they
fixed it?

> The original intent of the 'ext_updated' flag in HMAT handling code was to
> stop HMAT memory hotplug callback from clobbering the access coordinates
> after CXL has injected its calculated coordinates and replaced the generic
> target access coordinates provided by the HMAT table in the HMAT target
> structs. However the flag is hacky at best and blocks the updates from
> other CXL regions that are onlined in the same node later on. Remove the
> 'ext_updated' flag usage and just update the access coordinates for the
> nodes directly without touching HMAT target data.
> 
> The hotplug memory callback ordering is changed. Instead of changing CXL,
> move HMAT back so there's room for the levels rather than have CXL share
> the same level as SLAB_CALLBACK_PRI. The change will resulting in the CXL
> callback to be executed after the HMAT callback.
> 
> With the change, the CXL hotplug memory notifier runs after the HMAT
> callback. The HMAT callback will create the node sysfs attributes for
> access coordinates. The CXL callback will write the access coordinates to
> the now created node sysfs attributes directly and will not pollute the
> HMAT target values.
> 
> Fixes: debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated by SRAT")

Why that one and not?

067353a46d8c cxl/region: Add memory hotplug notifier for cxl region

It is the ext_updated machinery that is the main problem that messes up
sysfs, right?

...and per the backport concern this should be cc: stable as well.

Other than that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

