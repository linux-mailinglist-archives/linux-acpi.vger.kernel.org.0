Return-Path: <linux-acpi+bounces-14650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B40AE8FFA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71177A3858
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B120F098;
	Wed, 25 Jun 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXhSAJp+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE8C8EB;
	Wed, 25 Jun 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885701; cv=fail; b=Mxn5JBsmFo8jKg8u9gYRzT8IJQdGO/bN41cJdSbEJg/ayEn+mx+El4p+s66T5optAJFZhnLbS1SnoXiftjKhf34SEozvULPo/ePa7CgCi+FsOJoynFAltbcSsINh+MlP+WxoR5+m0Rk6rNt9DXilH0J0n6EYhrDBg6W3kQPvV8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885701; c=relaxed/simple;
	bh=twP7W0fUZASF7JyMd3gL9MNiB9XLqLmzf82o1dYILME=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=hVRa+JZutXx/p//qKupLtXeoFiFbQvrWQMryfevo0MMmarEF8hkgKUvpReLEJtmCHPbWOeVMMCLzes6T49E/fIrPzrJeQec5EF/F22HfGCCKFRa5p2NgxdhA1i/HWLo8ol0BrG1yNcOD1a/B1yKVhayq11NaIc2UnpoajaRxy7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXhSAJp+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750885700; x=1782421700;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=twP7W0fUZASF7JyMd3gL9MNiB9XLqLmzf82o1dYILME=;
  b=OXhSAJp+KsAVw7YTNaO+m9ScUXIYkI4fKdeEJFretzEMD86GDOrfxkTE
   u544C35/5wftxYC3A6q/35dQX2sldUbs+UOloOMxx0sbr0DSam7bI2z1p
   05WkwfmaILPKPZrk4X5hnSgLGYkGpzBoEvshEVdttSkn//PntaNixHE5n
   c99oSbdXo63sMY9zvUPlyBoZSDcGMnLYHN5v/hFtvV5zC8Ox0E7RUyOBP
   I+rVEa1/LXFS+aTZVsh0LKPJZavEaFJ/iBiJ7JMIvqDawsf9pra6lNEsR
   Pj26Y+MBGsVexld8HCY59PKX26rJh683ZMZLQdq4TqbqNWMJIemJgEFdP
   g==;
X-CSE-ConnectionGUID: UpcannRHRiywldAAIczE1Q==
X-CSE-MsgGUID: xN/TIDDJQaGvtWc7xjdzVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="78603883"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="78603883"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:08:19 -0700
X-CSE-ConnectionGUID: Kv3OYeQnQQy+MLCOPD6HaQ==
X-CSE-MsgGUID: 5OrBBRNGQISqJanWF2R7mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="156903161"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:08:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:08:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 14:08:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.82)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/gyovVHXY6juXgTtl4eqAgiYFftEoVYjs9oowl7181G+gUMHSOkvWld/3+o0/ME4jcSZ/14E/UEru7RmlakO6Th8BFnOoZX/L6QqVp2vJlenNyKdZ4riA0Rsgmo6USnhdElqSW18Mj4rHySD0lTRyDaa0ekxhAj5AWdzyNrx9nUy0hdmh+X3tVGujCT2ZEHGiSSo+pbb2uIFG2GXmbt/jVTlsjpk8Ohzg99yl/aYtO2OrB7Z6mn85MquJpP7lm2dWTZk2pUyLd4zNTQKGBSf2VFB8o5UfCAZMTUNCt6acZj/a24Kmddvy/BwePa+eYpP50pO0D8hVo1YRVx+lDhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MpZbhV7GvTIZOqqs9MqFE4ZXYAKGNXjOVyOkjOIv4w=;
 b=xT/Zwqtyv1RprCgl6jQOQRGgECZwlcZ16fEev1mfAqW9n2HwrKhdSvbFf5tMDOzTUab6OQg3SdYN3Q/hC5YyhDt2fCIvhNXYvOV+vYzthWaYADAGHTFh92OolQbXL9+/xiRuePj3l3GjOB7nE9+Dk2R8x9FXUysLtb96w5seCM27ZLLAzScREvhpfG0da2yK4qay1l9wPwOwETY3eE+SEg6nONpRbxHvpyFWaoavaWHz0jbuGmfvNWM+4143AHH8oGBfjCzLWbLT28GDyIRZ48q6ULKDKQkWo1BxC/YZxReqeRliqFj65rZpin7eK28Js9pZf2iaW9c1eFTm2hq5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5980.namprd11.prod.outlook.com (2603:10b6:208:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 21:08:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8857.025; Wed, 25 Jun 2025
 21:08:12 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 25 Jun 2025 14:08:10 -0700
To: <dan.j.williams@intel.com>, "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Message-ID: <685c653a6fe42_1608bd100d0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <685c5d0062f2b_1608bd10051@dwillia2-xfh.jf.intel.com.notmuch>
References: <aEneid7gdAZr1_kR@kspp>
 <202506250950.31C8A58E@keescook>
 <e0adad17-5d4f-4309-9975-81971597da65@embeddedor.com>
 <685c5d0062f2b_1608bd10051@dwillia2-xfh.jf.intel.com.notmuch>
Subject: Re: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::48) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: d173f005-8105-4712-ea34-08ddb42c6533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGJBVUEyZk5HOTNsbjFHZUUzbEx6V1lpTk1mbEtURE9wWnhvNGhEdHdPRzJL?=
 =?utf-8?B?amM4QjIvZFNJS2pGK2VoalZhQ2d4MDhtRXcyMGdzZ1FjeFg0M3RRUXBwMDFG?=
 =?utf-8?B?VllheGEzbyttRTBDbXhiaUhIeHNyN0JZdGRJWGU3R2tCY0FjZmRaZ09KdE1x?=
 =?utf-8?B?bE5XTThCNDVDRFFBSVJLNG05ajVRdk5KeE5BR0VRM3JmQlpWay9PcTF2eVJq?=
 =?utf-8?B?c3pROVFQRDg4Y3JJdnYwWU5WUEhQYzJUODhNR2RPYUI2aE4xcmJvVkdzaExS?=
 =?utf-8?B?ZE5mNzI0T3lzMjVBaEs2aTdDSE9POXdlQlFjSWxOVk5hVzFJNkUybWs4UkRT?=
 =?utf-8?B?Y2c2R1RtQmN6NkRVbEZ4VksreW0waHhEUXFtWE5UYTV5S0c5cHhMOXQvMnN5?=
 =?utf-8?B?TE00TUh1NnFMRkQ2V2gvdzVQQzBFWDRKbWVMVGpZdTZDOXZiYk5SNzMvNmlp?=
 =?utf-8?B?TWh4TDBoYmtMZHNDUmNoSnp4Nys5blZWUlBTcTZDak9uVWF1Q0JDdzIwRktO?=
 =?utf-8?B?V0Y5VnEvV1BoWFROT0NlYy83NlVjelVYM09LbkxlZUhROTRQaEFYRnVWcUI2?=
 =?utf-8?B?Z2JlSEJFYXBzUXluakJoTklNVjFrNUN1NDN5UkRHNWNyZTZUMEpmUDd4V25J?=
 =?utf-8?B?WXFudzcyM1hMTW5QZU5GSit2VjJXcjBBMEhNVWs0bW5lYTY1MlZsVDVSZVdr?=
 =?utf-8?B?eTkrd1UrYk5iQnVYQkdCajRjdFMxYUZFYmphOXJ5UlcxK2JVSkRyRU5JUmdJ?=
 =?utf-8?B?dHcvR05pU0RlZWc4dXhnSGJhcjVKR1c4WGlVYTVQenAzcWtxYXFSbWl6YW4r?=
 =?utf-8?B?U3RqQS90bFBaTmtnL3o1Q1kxOTZ4aWozcE92ZVo5WVF1eGY3eDRwS0VJdStM?=
 =?utf-8?B?KzFDVWgwcWtadk1scHg1NkVMRTQwdHlwajNYdWtlWXFhYkVYVEhSNTFCaHlH?=
 =?utf-8?B?MmRUa1REa3A4aVU1SzltREZONW9DMUZpZ2pGSnY5Wm5kcTVKb3psOGJLcTNt?=
 =?utf-8?B?TWxsdTd0MWFpUFUzWFF3TlhhWXdoYXoxaUNxeS9scTN1WS9NWHhsZ2J0S0I2?=
 =?utf-8?B?MW1mM1oxSGswdWFOY214VW1jRzdKdjFldzBHNEpLVG9DVktCZ2hTWTd2KzVX?=
 =?utf-8?B?UEFObUhXME92bFQ2TlkyUENtME1uQlhwaENoVVBHcjJseE1qWnJyc2xzRVVt?=
 =?utf-8?B?dzFBMDFBNHdDZmMyWXFBcEFBS1k1NjhFb1UwVllQekYrUG8yZWxpUWFIQU5S?=
 =?utf-8?B?U0NzMi9wWk5sRlFhSmtKamxoUjdOVEkvUUxEOWJjN1NZUyt0RDVUMnduT3p0?=
 =?utf-8?B?R3BuTEtKTVNSaE02Y3ZHR2dXK1VkTTBxajhDV0VoRVJKTTA4Yzltb1BBWG8v?=
 =?utf-8?B?UkhuT21pVXcrZDY5c2xIdm9WdStJSDM1K2hWMDRlUXRqMUVLSytZeTIxd2Zt?=
 =?utf-8?B?eUFOczlYbzhQeW1NUjEvci9hNGsrMUZiQ2dZd0hnTjk0L1R4YzNmZGVKblBp?=
 =?utf-8?B?Rk9GaHQ4eDBMWHBUOURHMTVITVlNa1NiZEFvSEo3KytFTjFxeW4ySVE2dHdH?=
 =?utf-8?B?Y0k4SXhFZXJobk0rQjd3ZTl3R2xqa29xMzZKT0NlRi9NVFNlZk9jWU4vWHBq?=
 =?utf-8?B?ZXljRXB2RzJ6ekxjd1FVdS9PLzkrWmN0ZDBBd1RSVWIxdzg2OEZ1NzBtN0o5?=
 =?utf-8?B?Z2Ewb0psR1k1cUt3SHErMzZQdW91alhxdUtVU0krSkVSeHZpM1lVOWlVeW9k?=
 =?utf-8?B?dXk5d0NPM2Z0MElqbXE5WDhaQnNGZ3UveWtpY21ydHRZNFlTMEhJSFJMeDRT?=
 =?utf-8?B?Znc4RGVFajJUVXZEU1RhSThDWUk5K1Y4VkFXZUtiWUduWGJMZk9sOThzZUZY?=
 =?utf-8?B?RzhwdWRSSEdIbzdyazM5V3lvUHVvSEJyVDVjaWh0T0paWFdkUlBELzNXQUg2?=
 =?utf-8?Q?lyqWkFGsHhA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVdLaFhVVEtCSUo1QUVCczlNQkE0cFFaNlhHbmxnK3JzRW1YRlU1S0l4V2tp?=
 =?utf-8?B?VlA0VjdGNlpCdzFKMzYwdkRsU1hLSWFFR1ZBWVU0MXVXUFZIZldGMzlKN0VO?=
 =?utf-8?B?aHZsbFM3aWtwcVB1NC96Y2hkTjZnQngvSzBvWEZDSGRnTnV2MUoydU5RWlZP?=
 =?utf-8?B?Y3Y4a29FRk8xZUEyNmlsVmZNZ1ZTZWdMZWV5SFlpNWE2emV1Zm9xL09lRSsv?=
 =?utf-8?B?aTlyV3RyTk9XUUpYQ0xCbzE4SEhwV2hWbGpiK28wdGlBUVdOeXJXVTBkYWN1?=
 =?utf-8?B?Q2VUcjh5U0huT1NGS1BFRlFGejF6YVFvVkEydmlaNGtRazIxTnBBeTVSYnU3?=
 =?utf-8?B?L3RJVXBiTTdPVjR5bi9zYmlIYzc3TFJWOWlmdUlBRzZmd21kbldiMng5MGFy?=
 =?utf-8?B?Y3NNMnVybXdOaGVFUWx0Wmo2SXBQWCtsWHdWSUtabm1XQ2hTbW9ISndKZWYw?=
 =?utf-8?B?cUNEMDg5RlJuQ2ZINEt0NWFsZDd3YkRqd05jb1UyS3UvTHFNQjE0TWhWdzEv?=
 =?utf-8?B?UmxkZjhvZzA3VWRkdnFCd1Vvb1pJbXJWcmVRbm5zbUdmc0x1c0JjZmE5ZlFt?=
 =?utf-8?B?c2ltVUthcWJRVk5SVEFhdDZBUlh2MGlQWXloSll3L0lhU3hpR0o0dWhvVGM5?=
 =?utf-8?B?MmJlWEVpTkJ2Rm9hcnBoSW5XYUtxNTJMeFdrNmRudlh3amNVcUQrczloZUd2?=
 =?utf-8?B?OWR1Z0ludFQwcDB2VXpaNjFGZEw0THAyd01WdEoyYmE1Zm9WNW02aFh0WVhN?=
 =?utf-8?B?VlJiZ1ZPRXpIMExydURYdkp5RTlyWFgra1ltbnlNTzdjdXFJcGRRNVFNUU1H?=
 =?utf-8?B?VUJWRmlndzJXOTBKbk13SU1TTUJRaWkwZHUyVXlDZ2JqQ2ptOWhNSEttc0Yz?=
 =?utf-8?B?Nml2VFkxYzQ0N0lrcFNRV2RYZ0VObXpYVld6dDdWa2pFTzV1REx1VnFxTVM1?=
 =?utf-8?B?dDVvWmhJalBDUzI0bE9ZYlRVd1BIZk02TnhXS2k3eDVadDk5SklxQ0R5UDVK?=
 =?utf-8?B?Uk5yVXVya241U1VJUWd6TnNIQ1hGZXg5azBGKzZyY2dmYTFIV210SDRqTnV4?=
 =?utf-8?B?UzFVVXJRTGNTRzhXUVMxRThUdk00WXNLNFV5WHFDanJvWkhCVkJTWEhZbllh?=
 =?utf-8?B?MUtLRkR2c1JLOGxRQWd1UzdXM2lnbWRUM3Vlb3pzUzZsRlkzMVZ5SzNUM3BZ?=
 =?utf-8?B?bXRKZ1ZHSTFaVzN1NE0wenc3aE5xUVhiaEpmbFFZTlFBS1o0bUZLcS9nbkVI?=
 =?utf-8?B?TDRoSk52eWs2UXVNWGxNVFEzSVRhZldreko4R3lURHhKbXQwZkxIY0YyOE9V?=
 =?utf-8?B?NkpDQ3BsVUVBYSs5aXJkUjErUnhUbVl0N05QRTVMWkFMUnZTS3VzNWo3SzRX?=
 =?utf-8?B?RDMrbEhXYlJjNFpuNjN6Qjc4UTRXNDZNZkptSk01VzZRS0pqWlM2ZWVWUzhE?=
 =?utf-8?B?UzNVZUZpYnE1ZkVSVElYM2xTNER4OGpyL2NVWExwMC9EUVlUN2pqTzJNTXJW?=
 =?utf-8?B?WlVvSUptTTN6VzR4Wkd1RldPU25JVXhWTWhiTzdseVdxRGxNQUhYdEp4bVZ5?=
 =?utf-8?B?dndZZ3M2WFROYXpmVWRWaTBENlNjand1QVhGaUJRVXJ3UW0rbGxqbWVISVI0?=
 =?utf-8?B?dHRra1orS2VDRktraDBLM0V0Q0NmTGVRaC9SKytXWjNUV0hmbjdyNUhJSmEy?=
 =?utf-8?B?L2JsK0pEeFQ1bUVVVVMzSm50RnNMTDlKY1hyWTVYWHU3MGEzTEFDK2YwS3pJ?=
 =?utf-8?B?VkgrR1NIakp6T0tNdWxCRnYyS3YwWHJyVjJDd0hwb3hFRjhBWXphUnptVHZR?=
 =?utf-8?B?dDVIbTdtNEpzNHg3ZStzYmdRcXVESmg4SVhTYThTWnNzVXVVMlNGbXVITmJ6?=
 =?utf-8?B?NDYrRTI5ZWZUS3dMa1VUYXRIYlhvM2FHaVBNUnIxU3RsMUVndlIzR3VDUEl5?=
 =?utf-8?B?QnR4RjhMN0JjRTdzMW1rM0FJbHM4WE9abUtUWVZXdElvZXVCVG9kL2JjRG5i?=
 =?utf-8?B?TE9VZTlYenFPbzF6Yk0vOU5VbGtVNFhiQVAwd0pMTVJoVFRyVGsySnk3WHVl?=
 =?utf-8?B?ZmljQkFFd3BkaHcyRXA2Umc4RnNJTHNSNWg3SmJYVkVPdzhVNUd0OXgrcm9l?=
 =?utf-8?B?cDlQbWVsbEhjazhsRG8ybis1eU42RW5POHkwdUJ0Ym9UYzBQdTBUWGtTaFBC?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d173f005-8105-4712-ea34-08ddb42c6533
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:08:12.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztQLGW8EyRbpq4dl2vYQDpwqHUSgoWt80fRcEwQBXXhVZ+yrm6zMvtWABL9y9UJy0wdPqruk71W8K1BxZacOW97Lj4HSNQWZ4H8YOy/jV6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5980
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
> Gustavo A. R. Silva wrote:
> [..]
> > > I think it would be a pretty small and direct replacement:
> > > 
> > > 	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> > > 			 struct nd_intel_get_security_state cmd;
> > > 	) nd_cmd = {
> > > 		...
> > 
> > Yes, this works. Hopefully, maintainers will comment on this and let us
> > know what they prefer. :)
> 
> Hey Gustavo, apologies for the latency here. I think TRAILING_OVERLAP()
> looks lovely for this if only because I can read that and have an idea
> what it means vs wondering what this _offset_to_fam is about and needing
> to read the comment.
> 
> If you can get me that patch on top of the TRAILING_OVERLAP() branch I
> can test it out and ack it to let it do in through the KSPP tree.

Just to move this along, I gave this conversion a try and all looks good
here. So feel free to fold this in and add:

Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>

...and take it through the KSPP tree with the TRAILING_OVERLAP() merge.

-- 8< --
diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 987d427ec2b6..c88647428715 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -55,17 +55,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned long security_flags = 0;
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_get_security_state cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_get_security_state cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -127,17 +119,9 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 static int intel_security_freeze(struct nvdimm *nvdimm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_freeze_lock cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_freeze_lock cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FREEZE_LOCK,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -167,17 +151,9 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
 		NVDIMM_INTEL_SET_PASSPHRASE;
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_set_passphrase cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_set_passphrase cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_family = NVDIMM_FAMILY_INTEL,
 			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE * 2,
@@ -216,17 +192,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_unlock_unit cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_unlock_unit cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_UNLOCK_UNIT,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -262,17 +230,9 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_disable_passphrase cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_disable_passphrase cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_DISABLE_PASSPHRASE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -312,17 +272,9 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_secure_erase cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_secure_erase cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_family = NVDIMM_FAMILY_INTEL,
 			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE,
@@ -360,17 +312,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_query_overwrite cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_query_overwrite cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_QUERY_OVERWRITE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -403,17 +347,9 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_overwrite cmd;
-		};
-	} nd_cmd = {
+        TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+                         struct nd_intel_overwrite cmd;
+        ) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_OVERWRITE,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -463,17 +399,9 @@ const struct nvdimm_security_ops *intel_security_ops = &__intel_security_ops;
 static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
 		struct nd_intel_bus_fw_activate_businfo *info)
 {
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_bus_fw_activate_businfo cmd;
-		};
-	} nd_cmd = {
+        TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+                         struct nd_intel_bus_fw_activate_businfo cmd;
+        ) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
 			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
@@ -581,17 +509,9 @@ static enum nvdimm_fwa_capability intel_bus_fwa_capability(
 static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_bus_fw_activate cmd;
-		};
-	} nd_cmd = {
+        TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+                         struct nd_intel_bus_fw_activate cmd;
+        ) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
 			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
@@ -652,17 +572,9 @@ const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
 static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
 		struct nd_intel_fw_activate_dimminfo *info)
 {
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_fw_activate_dimminfo cmd;
-		};
-	} nd_cmd = {
+        TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+                         struct nd_intel_fw_activate_dimminfo cmd;
+        ) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
 			.nd_family = NVDIMM_FAMILY_INTEL,
@@ -765,17 +677,9 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
-	/*
-	 * This effectively creates a union between the flexible-array member
-	 * and any members after _offset_to_fam.
-	 */
-	union {
-		struct nd_cmd_pkg pkg;
-		struct {
-			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
-			struct nd_intel_fw_activate_arm cmd;
-		};
-	} nd_cmd = {
+	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
+			 struct nd_intel_fw_activate_arm cmd;
+	) nd_cmd = {
 		.pkg = {
 			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
 			.nd_family = NVDIMM_FAMILY_INTEL,

