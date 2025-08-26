Return-Path: <linux-acpi+bounces-16059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F9B3500F
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 02:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7521B26D73
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934114B950;
	Tue, 26 Aug 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdLYLcak"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0113957E
	for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167161; cv=fail; b=JhuefKYN7zZbrpsaB7+btqYs8dQGRaJaCQEUzUTYiYDW+GihYdY8Np2gnsAdCoQhXxNUWki4dEnavc/0W0nVBE9WHof2IgZoPj6IWwNATcWGV5MYXaXY2Mt4T+BMSW+1vnUzf8tH6RS40VsxumZhHfvoMe1XhJYdxgptGkgBqKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167161; c=relaxed/simple;
	bh=FnltKEbk96fZ7aqbVptBggRtpBxRB8hyq2DAS42R7v0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AaJRlEKQODpmqhH8hxcjdpL2di4fE6o0Asu8WhhzQoeOURl+oDkqmWKZRUGMAlrZzk4dEkrWs+RcsknwXWKia7mM9xssbVNdmqXfFxT7YQjlQZZr/HU1pEYLjU52o2GbCPChG/GIHIMa8JPbeU746ur4X5piQDvhlMDK3KamW9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdLYLcak; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756167160; x=1787703160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FnltKEbk96fZ7aqbVptBggRtpBxRB8hyq2DAS42R7v0=;
  b=IdLYLcakNc6c58424xnU83zGzBbkPTEnobNnwnjOoGvAYGnC8aossj+u
   5OnJP4Sphz1zbr7JwqA2XZ2ewYeqXrxuaBgNXDHIN2zaMvMxW+a5MqsAj
   AHQxxRp3qPd/w2UJqEjbAvM9feNzCMO9s2N77VGyykbIBud1pt0rTEF0/
   MXrBQ77RzLB7eaKCSlPSKeF+PZDU4XmfQSLRiRtc+yPjCybLd1m5XVh06
   /a9uismyFsKBcNPpINDUfQzYm/CmkGcBNpfvEoS5/QWPoMMPVpDDq+463
   SwvCU87xDkNe1x+ra7KDPnXEmICqeCRzjtEyH51dEMqlzk/hrxZS/Fscg
   w==;
X-CSE-ConnectionGUID: aj6CprB9R1KMOdIVWen66w==
X-CSE-MsgGUID: RtTEeBVoQTqOaYJrz/hZJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68660826"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="68660826"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 17:12:38 -0700
X-CSE-ConnectionGUID: ZrVxpRbgR5O/1lw9MjBZPg==
X-CSE-MsgGUID: muIuygXOSLad/vq/F2BeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206588161"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 17:12:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 17:12:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 17:12:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.60)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 17:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbmEEAX1kgLorczkAbWX8LSgJ2laj7Par0KWxOzKPoqoT3qsMJpjDxnsnFasLOeTSfMlosQATzeucgCQhMG3UkZ4ht/TtMb3ZDiVOEPDTklKzjo3NMWSZUVx1PO7txA4XqzwQaTY9BuYVB0XeSm9TPKFW6jZEhbO5y4khnOnbePf0Xit+XlsdjbPV4Sat3HP8U8C4txhsKYo/F6hGW3XLj3FGpspeMQv/WEXy0DTzxqSFxkYnYDhaQLsDUfd3obGyJ/W7CyCLILwV95tLx26B8QxnJkThEYBsQLK72NBetiJ2uHSZ/pu54tI5hCA4wo4dtncKqwsIKmNCxMLKlW5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnltKEbk96fZ7aqbVptBggRtpBxRB8hyq2DAS42R7v0=;
 b=VL9a4mDgHoBlNBG9HWYGwBwr19RBGH+iUrpTdZQCO+cGznivPxNg5t2w9YnptNHdLSZxlOyFzMhIcqnJbZ+vW5Sb71i9C91anw7odMfekwujT5+vAcp4haH29iJvsoNxXX4TpYEAnqvkcCF8vnmVZIRSKj9fYMBwK4Gu527Hq7H+QOscRCbelzA4EiYyanxEMmGVtiawDkcdUoq0O5tZQcJHvZWfXkOj4edP4XngIRnKkn5a10Ii444nhyfVZ+qktNC01jKUMcf+9cBzaXwi2qDFgv/mBffyW7ekEBb4XvSuJS99rQoPhjYkMX+qosFJWjwzk7SaYxFQGsUBC8iXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ5PPF3F833FA49.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::823) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 00:12:32 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9052.013; Tue, 26 Aug 2025
 00:12:32 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jiaqi Yan <jiaqiyan@google.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "rafael@kernel.org" <rafael@kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v1] ACPI: APEI: EINJ: Allow injection on legacy persistent
 memory
Thread-Topic: [PATCH v1] ACPI: APEI: EINJ: Allow injection on legacy
 persistent memory
Thread-Index: AQHcFhBcAsa+U690Q0CvYc7/j3oqOLRz/4kAgAAOCQCAAADoIA==
Date: Tue, 26 Aug 2025 00:12:32 +0000
Message-ID: <SJ1PR11MB60835824926BEE57F094DE6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250825223348.3780279-1-jiaqiyan@google.com>
 <aKzuCobhkx9X-axW@agluck-desk3>
 <CACw3F52ov0ZwaecdP2Ky-N5h6hC4dwDZfjysoVF4oF-AhMRbbA@mail.gmail.com>
In-Reply-To: <CACw3F52ov0ZwaecdP2Ky-N5h6hC4dwDZfjysoVF4oF-AhMRbbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ5PPF3F833FA49:EE_
x-ms-office365-filtering-correlation-id: 8d734e73-1609-41cf-0652-08dde435409a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3Qra3c3dnFFVmJyNkVCKzNVdHVUMmt3ejVJMmxTUXBlT1pGcGZhMHpUelpT?=
 =?utf-8?B?VjIyU3hmQXdHMGVIVXg4bVNidGcza1RmVzBpd2xQSVdySGFuQWk3MHU2Zkww?=
 =?utf-8?B?cStEdE1DWlgyaDRpRkkrNVpGN3BvOEl2MjE5NmRRZG5FQ2tMb0NXOTRkQmYz?=
 =?utf-8?B?Y0ZtcmRQLzg5OXYzM2xoeFhSNmpOT2lQclczVnBzdHRGTmR4dzV3R0ZzZFFQ?=
 =?utf-8?B?MG1aU2dFOXZWYWZIZjBIZUhxTkdlVGd3c216TGdMaGd1SVhuY0s1QWV1Qnhh?=
 =?utf-8?B?dkxXOUcxT2h1RWRDYnA1TXZtVmsxUjJvTzRqRm5ES2xrRjBmOHVvTDREMFVt?=
 =?utf-8?B?WWlnc3JrT1RaeVZIOVdPdXJDNXo5QzhZMkVQMHRwNkpWaGc2bFpIVFZhQWlK?=
 =?utf-8?B?OW9pai83aHQxRmw2MlpmQU84Y2lMNUpOMDFIdzhwdkJrVkQvcGJyTFoveUts?=
 =?utf-8?B?OXJrTHZXS0xlUCs4NzRWcEN1RTNFcHMycTZ4SEtTMU1uRmV4RDl6WTZwcmU4?=
 =?utf-8?B?NTZ2TEQwUytwQ2RRUXk5WnJBdHZhTlhxMWR3U25MeWl2NjBmYVFpTW5qMXZJ?=
 =?utf-8?B?RlBmaVVGMGpiUU8vQUI3eVRRZXR6Q1E4VExkNHFvQ1hkQ2NyY1g2Q0ZKSzIx?=
 =?utf-8?B?TXJyR3RIanVjdDVEbG9qZ2N5cUxBNHhPbnp4eUpUUjhjanpIT1ZYcVlYUG9y?=
 =?utf-8?B?SzBzdzZuT0p4NTFEd2xGSjhkVG0rbHVkdkZOYkQ1UlZ3czVwejR1SG4rdStV?=
 =?utf-8?B?Smd2bVRtVEpGZnpwZ2ZuWUhqcHg0emlmU2xZSFppYUJqSVN4WGZFdE9xbDZt?=
 =?utf-8?B?b0RkUWtUYWhtanhSaGFSaG85a2Jta2ZrZC9YU1FpaG5RVlZjRXVQWVk2OXUz?=
 =?utf-8?B?cnhSa1ordDZvV2IvVmcyVXlKaDdQMXFaWTg4SGdMc0hoVlhTZWtwRHlXUDc4?=
 =?utf-8?B?SExQR0dsMHA4djFhcXlHc2Y2V0RsK3UwY29XVmp6NDljMWF2L3RhalFpU3dW?=
 =?utf-8?B?RnZVdnFpUkFObEN0ZGRBTHlTdm1ranN6M21mdjBldldmbDR5UWVkd3g3ZEJa?=
 =?utf-8?B?MXVNTjdwa25IOVRrcHljbWViVU5HbEwxR2FmWXBFYXYvUkdmZ3dtTTU4Zlhj?=
 =?utf-8?B?RGhuNExrN0FCS0hlMzNKU3UwT3J2RUhnTWp4YTg1VFZZdksvM3lFeXdsYjRa?=
 =?utf-8?B?Y3hUQUlMR2lBZSs5S2VWOWlCa2pXK2Jvd3U4bjBBSWxVbU5lOXh0Y2RYaWZJ?=
 =?utf-8?B?Z0hXN1BTRTlzU0VLTWNGdFJmMTBEQzNjajFyQWlKWDlkSURlc2RWRDVxOHp2?=
 =?utf-8?B?SkpVUTJYS3p3LytyQUNvLzhJYjg0RUNYL3hZVTdnTnpJRGhJeThTN05LeHo0?=
 =?utf-8?B?MU1NdlZTeTV6OFMvOUxQVVhjM3lGRGpCMW9mUXRTNHZKYlBPWVBNSlZJRFVm?=
 =?utf-8?B?VmwxZmdvWE45OG9TSFNmcWg4UkNmY0loY2lzL1FFUzJCM3BpYzdQakZvU2lM?=
 =?utf-8?B?ZzNDdVBDdjRWejNUVlBPNkx1YnY0UmZSZ3puK0tKeHhiK2VHQVFqOTllbGJu?=
 =?utf-8?B?WFVuY1l2ZlJ3OVJpVytnSHFReWRDQ0t3bitteXlhaWpZMG9XdUJxaXVLL3BG?=
 =?utf-8?B?UmI1VmxnbUxUUFlnWEhnWW1MbjNHV0xwZHlkZWNCRHlPVlVCc1RpNDhnN3BJ?=
 =?utf-8?B?NHlUMStMblloc05GMzYzcjArck03ckhOZDdrYjFuRzNzT0UwU2VhNDZ2RUlh?=
 =?utf-8?B?WXhKYitqbm5HV2dWcmZhN2F3bGM1Z0RkZXJPWUUyUFNFb1ZuOERLUkxCbEFq?=
 =?utf-8?B?YWZNNTNLNzFtU0JjNDE1ZkFjYVBWcHRDSXYrSDBvZmlwcU5VVEthcjA5OE5Z?=
 =?utf-8?B?YWttcnQvYjZnQ0ppTEV0bnVzMlJzRUozdzNZWE1NWEtmaUtHVkpHZjlma2RB?=
 =?utf-8?B?V2o1aUlmdkJNbDhRZlVid2srZXptOW9KRXYrOUJjay9YTFJCYXNDL3g4OTdU?=
 =?utf-8?B?cVZtUStlbzNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEZsOEdlanpnMjA5emVHbnlGeTRza2szMTAzNnVBWWZqb0ZHdENuSXVOayt2?=
 =?utf-8?B?THpJVGpDQjMrZjJKUjZENkdNM3JIdDVGbzRHMm5OUGxmdnFlcHVDUGhZWkVG?=
 =?utf-8?B?T3Evdk8yNmduZVo0SlcvRUlqVXhqOGErRHBYdXdzK2xMdVhLcEFvSHMxZ3dx?=
 =?utf-8?B?bWRKaVRhcFVCM09hWDRidDMzWGUzQ1pHZUYvWmxleGpFN3NnT3hUOUVMMktS?=
 =?utf-8?B?R0RObkcwSWVhRXIxeGZKUFZxOGNYc1FDS1RvWHg4Rk80NW5ySGQrSjNoc3dP?=
 =?utf-8?B?b3c5dmRZVFdmeGdzcHVJMGpack9mL1FiTUJPcFM5dUtvaytuSjlIZ3Z1UDNm?=
 =?utf-8?B?dFdxbEM4Y3F0bmxSWVFjc2d5RHF6TVgwclg0ZFprTXZpSml2UGM1ZUsybXdV?=
 =?utf-8?B?T2daQjY1dC9UWklJSWZZcWozVk5hbHRuSlE5YjJuclJWdUc5bmFqa0FudUpy?=
 =?utf-8?B?L0J6ZjZHaXVDb1hQSXo1Wit3UW5KR1pZZ0plR2FaVHNjZ1B4Z2NPMUZ1eVVG?=
 =?utf-8?B?cnNFN1lJMFZxTjRjQ01Hd3M3bXRtWFBrcHpEYXpWTDFvaHFlaW1ycTFGZTlh?=
 =?utf-8?B?Y1JIclRvdFhEa09CVVAweVhyRllMNGtRaVRsZGo0MEo2UVlrWmJQSUZSTklF?=
 =?utf-8?B?TjFxUmtFRW9oV1FOVmlyck9XSXRNZmpqT09YQytHeVpmRVAvNkpTaEZ1UFBO?=
 =?utf-8?B?NUtDa2MvODZOL2crdktmS0J1VkltOGp5bDFjSnBOUkd3Ukh2Y2NwbHJhTkM2?=
 =?utf-8?B?alZpeFV6OE5rK2Q5dlpyTDZ1SHAzYmFib25YS1BnSS9kSXJsL1NHSlVtcmU2?=
 =?utf-8?B?cldBVzU0Q3hMd0t0KzhQWG8rMHpmRHJMNDZiTnJqQlNzRGg3SWNmOVRDTThQ?=
 =?utf-8?B?enZDODkxMVFNZVRIRkxwT0JEcUVNVStBRnErZHowN20rdzBaaUJjTUk0VHpC?=
 =?utf-8?B?cndJU2pRSFZVLzVwYVhhTXFhbGd6NFJEU0ZIdTNJa2R4em5yTDRMcGVnV21p?=
 =?utf-8?B?QzVqQU51NEVYd0hyMkl1SFo4Wm83bmkya0EyZXY0cXA3VTZWRmNQM2Y5c3Uy?=
 =?utf-8?B?N1I0RkJzSjhZd2NObXloVU9IOE5yeXBqa0JKK282eTZ6YzFQRG5aRzA4K3NZ?=
 =?utf-8?B?aGR3R2VjaVQyRzdlMjhuOVRtTWdPeTFaNHZLRGJKZ2QyakRmYTg5NC9ER0RX?=
 =?utf-8?B?WE8ybDhlWVIydEpiY25NMHRzZHMxZTVwSDV1RnZjVHFiQnlpWGpsMC9SV2Rm?=
 =?utf-8?B?QmFHeHVnSkFGM2ZMLzRPZnRMWU4rMlZGYlpzZFN6Ly9SSjRseC9veEMyVkYr?=
 =?utf-8?B?UmxvWEVsRTRwMlFTVzNaVSsrZkFONnZodmVKOFMwZCtGVHBaY005cjhpZFI2?=
 =?utf-8?B?SktMTUdXVjBFYktpdGlqRXpMbmhTUmJJdlhib0FidkxrajNLZnE2bFVqUi8x?=
 =?utf-8?B?NG8wNzNvNTB5UGJmRDhGTkxnNEF2R3o3YldxMG5IcXhiY3NINHByUm1sQnhk?=
 =?utf-8?B?Qnl4dVkwZTlvVHpZSStrb3JLcXVucGJYR1Z3cHY1dlZaUkZIdStmSmlWYWVn?=
 =?utf-8?B?MjNTZVUrdTF6THE3NUV3Q01NNndQQ080UDNZVmFudTNsTFFSaFBteFA5TkF4?=
 =?utf-8?B?UDFZeVRnMXRGalNxd0JTM0JzbFdjaXE4bXdDYTFPdFU1UFE1cUN0dGtwUnBo?=
 =?utf-8?B?Ni9sQTVibzIxcFM3ZU0xZUlOYnE2anVNY0VlRmcwQ3NITUpMaElyK0gyZzNF?=
 =?utf-8?B?YlR4Rm5VN29QQ242enF0ajVjM0N1ZVQxU1VKU1YrR0k4Z21CSDdXVm9Rcjh5?=
 =?utf-8?B?V0RKMHlHY1UveWxWS3pPNStydzMzZVRaK2xIZEozYWlzVHRvWGU4WWZqMGQw?=
 =?utf-8?B?c3dnaGUweXVjUGRSbEtWejE0Qm1McDk1QjM4OXhuQ0E0M3RQdGdldDc3b0I2?=
 =?utf-8?B?L1Bsc21RNDRYSlhpU1dNc29iVzc1bEFVcWoxQjlJZXVpTDVoS1Q4NU9xQy80?=
 =?utf-8?B?b3hmZnh1c3ExTSsyRjM1Z1dHVXNHdVk0eUxwNVhyOXhsVUEvaDhIRVNoOWkw?=
 =?utf-8?B?Yi9EejIrdjBBMXRyVG40UjZlNU9mV3dha0pSekJZOWE4bzhXNzRxQWF1Zllv?=
 =?utf-8?Q?NQEHHJyWFUl0Ma749lvEVTdyZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d734e73-1609-41cf-0652-08dde435409a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 00:12:32.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v1lezzhdLw9w9Pg9bWDqc4D6qqE9mcM0s2EmWCLkiggUmz/xHk6SegB5NT3XwspjYcHioOH2dnGt7l+Ev2f1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3F833FA49
X-OriginatorOrg: intel.com

PiA+IEkgY2hhdHRlZCBvZmZsaW5lIHdpdGggRGFuIFdpbGxpYW1zLiBIZSB3b25kZXJlZCB3aGV0
aGVyIHRoaXMgc2FuaXR5DQo+ID4gY2hlY2sgc2hvdWxkIGp1c3QgYmUgcmVkdWNlZCB0byBwYXNz
IHRocm91Z2ggYW55IGFkZHJlc3MgZXhjZXB0IE1NSU8NCj4gPiBhbmQgbGVhdmUgaXQgdG8gdGhl
IEJJT1MgdG8gZGVjaWRlIHdoYXQgaXMgYSBsZWdpdGltYXRlIGluamVjdGlvbg0KPiA+IHRhcmdl
dC4NCj4NCj4gSSBndWVzcyB0aGF0J3MgZmluZSwgYnV0IHdvbmRlciBzaG91bGQgdGhlIEVJTkog
ZHJpdmVyIHN0aWxsIGV4Y2x1ZGUNCj4gSU9SRVNfREVTQ19BQ1BJX1RBQkxFUyBhbmQgSU9SRVNf
REVTQ19BQ1BJX05WX1NUT1JBR0U/IHRvIHByZXZlbnQNCj4gdGhhdCwgc2F5LCBieSBjb2luY2lk
ZW5jZSBvciBub3QgYW4gZXJyb3IgImNvcnJ1cHRlZCIgRUlOSiB0YWJsZQ0KPiBpdHNlbGYsIG9y
ICJjb3JydXB0ZWQiIG90aGVyIEFDUEkgZGF0YS4NCg0KV2hhdCBpZiBJIHdhbnQgdG8gZmluZCBv
dXQgd2hhdCB0aGUgc3lzdGVtIGRvZXMgd2l0aCBhIGNvcnJ1cHRlZCBBQ1BJIHRhYmxlPw0KDQpT
ZWUgZGlzY3Vzc2lvbiBlYXJsaWVyIHRoaXMgeWVhciBhYm91dCBsaW1pdGluZyBlcnJvciBpbmpl
Y3Rpb246DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hRHQ3N3A5R1lDSVJJT01hQGFn
bHVjay1kZXNrMy8NCg0KLVRvbnkNCg==

