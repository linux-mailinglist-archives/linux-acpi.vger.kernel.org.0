Return-Path: <linux-acpi+bounces-21380-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG6nK3nYqGlmxwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21380-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:12:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 563DD209B7E
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9943E301F695
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447C23B61E;
	Thu,  5 Mar 2026 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eO22gOWY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D53368B7;
	Thu,  5 Mar 2026 01:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673143; cv=fail; b=IUFDH14Wn0YUo+lGJS2ZYjfu5KGiNPgqxQ3woaeZN3wrzEGmatuo4B5kpWDtmc4lOKbcPwGm7KSAddclhhXb+CTfSnZnTd4uT9CQ1WQajh/8bcqlPVrpPTF7kpodF5hWqP//YJ1t4867oR5amYRNxOh+Z1SdvT5QhNYwSJl5gOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673143; c=relaxed/simple;
	bh=FH4xwlUZtBt1mpVhT+TpMHSFb8l/fLo6cf+eB/Sr2P4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPi31JFz8IQ485fGz2Y8bC0sZtc2qocmwCWMXQ9o/aljpgxEDKiDlXX2i4dlfYMIrSFl06nr9Uyy+TIg+So4uoGRW9IqNs0GeHx1W4hkT3hNAedpDYmyN1KVCJiQe/J4WyhCCUR1qlYpyCxjSjUNXUCeygyrQMooNbQMRhKf8Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eO22gOWY; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772673142; x=1804209142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FH4xwlUZtBt1mpVhT+TpMHSFb8l/fLo6cf+eB/Sr2P4=;
  b=eO22gOWY/I0I1M/opOKf9v2S8Xpd6eUOgjg/1hAI0dsqm6KU4QTVPrqp
   ab6XWZ4PTaVy0U0F4mp1SJckz2NPnlQO08meo86kXsfgEBri/5S96ruU4
   HBCBGuuU9vgCQE4mWF7RioXbXgIz9tWGGXMDQWi5a5eoeXZB6L+4fXIad
   3fOIG/PqsNY4DysExlCkz4OOWBdzzqi3vYx8hZIoNcqHHgL/nKkn6DDRD
   ePEky1HTUgQdeN8HPNUz3hdkJsGCVvibJrZCmYxoDzsirJvC9gE824Et5
   lKJJYYfY8LDLMHJuUsXHgYtsjoVYKgD/3LKJp1y5PInTWgOyVnHqAKaiJ
   w==;
X-CSE-ConnectionGUID: LknYWAa6StCMkJAt2aAmlA==
X-CSE-MsgGUID: JW7Z8+AjT9q/drutsyXY4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77621046"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77621046"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 17:12:21 -0800
X-CSE-ConnectionGUID: ar/hjlumRda78+XiXNHEdw==
X-CSE-MsgGUID: 9Pd1EmY9TjyxEJspd3FVpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="215813342"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 17:12:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 17:12:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 17:12:19 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 17:12:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWkONziaxbYJ6kdMUzvCnuMfdY4LGiCuvcllYxKhJXE/iyHGzQEdc92s0YDOSqW2SjPla6T7dvrNVEZtuQk8THPErNGSxMpdRW3fuOXRBqpXx+4yJ5vKa7NynV+fThuEWVqqwIv5fET6W1gXB6olk1S6QtmkzVvR6FSFMPge6vUwY22E4bEfutEDABq6KO0wI7rik593uEfQDgHLkJIu1LIssk7E1hzOBTwhY2Ss268GABKKPg433CeuwvjB2h2Wfy4buzcpD7ddIw33PmiG2I1BP5k3lfx0pN3qnd5TlhL274YyF/wwAQWnXF0xV0d27uX4bIRaH3h8lV8QgDDXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH4xwlUZtBt1mpVhT+TpMHSFb8l/fLo6cf+eB/Sr2P4=;
 b=Q/fb9sMcUagtZYvlRpSgwQb9kmHiDbPXDnKTVHBoh/C4siveZE7TGRG/aRJOv3gHmY/VScr75n/9weWAQ7gAfKIEDW+L7St898TOSRVQYHinKHzHUw7MKQ0eikTs6XXUqDfQxh7IpoGCx0ZJFXMP8y8Tp0ow0z5lixsfhFgz3QB40vqy5TqYyDIhyjqFsSAKI2pWpzFd5s1A2vdl/5iJZNGc8KpLFBn3hKxAzYU/wGwqlRGVzceR9h8rqP89M4lmZQsjz4A/8g3aLHfwjsgatapirNhaZimAMv5XOf6BzNtNURnCtU/mSKVhppeI6VFxk1srIXnFSVAofS9dc/uEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 01:12:11 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 01:12:11 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Schofield, Alison" <alison.schofield@intel.com>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "gourry@gourry.net"
	<gourry@gourry.net>, "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Topic: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Index: AQHcrB6hFMt1tftCWUOUCZXHrNvLJLWe9ZgAgAAND4CAAAx6AIAACyEAgAAHooA=
Date: Thu, 5 Mar 2026 01:12:11 +0000
Message-ID: <1f5074979a58803ec875dd10c9234c7b1a17192d.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
	 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
	 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
	 <acc37740d0d7fb2bdf12f181028addb1eea2e169.camel@intel.com>
	 <aajR-DIeW99H-9Zv@aschofie-mobl2.lan>
In-Reply-To: <aajR-DIeW99H-9Zv@aschofie-mobl2.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA0PR11MB7283:EE_
x-ms-office365-filtering-correlation-id: 9958ad98-a45e-4a6c-fafb-08de7a543a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 6Nw1iL9qmEXqNCutb8HYbMxX0+pDihC6EBPpFONFOA7JoDHO2e0SvTRnq5RsrmcZPrmtmRS1X57r7vpelelqx8yzvVfuR+9OqhFav6TSIjicbUnkA5dDospTimQaan4XWBH4GR3B7Ms+l9djKwO1JGBTCIeaoHGMX8Hqegy5apjAnda6y7UKuwV4uEQyRIGXfjdk+qGNy5L+hncVe1w0aakFdwtGxIZ25sigQjvebGsiJJZqfemJ+H9GCvSaNKXN3StPbFPIewYsPpYjyP2f/UWJq9hPBi+MYBewvElKQfE1AdJfLYTV+utE/RPBN9WAqls4yaQkNA9eMio5ZvNz8isZ4ELrhckmMfvuzMdun2M1mwmXSmE45KxTwyAhfqYbA7EuhjS6oOvSt9I7BVD9dazCyGCBV4t/kWyiOJ0kzn8AjJ9Qj37Hj5XLTsPkFrOiwfZYWtZxyr1DCxu/K/ykmHa/kravEB9jH5nE+onixxW9O3FFuoRxtKMryBUuSnHReoG76iFLEfMSpta9qhkw7fGAiFfNj/J7WcY5Kvq1MparhUKnCldutYILr1wPmWk7QksfHNTD6I2I6U+AlFxw+TV4hDpeGEY0K5ClYu0Zhg8jcw6HYCiuUSajHkCmWn+0rfTwZ7lKT52h3iavKr0reuqEy+j/zER+fIqMxteaElNqztElJFGSzdXfiAR/T9VG2AQF8giqVInqm9IapNz86l3jWeES4lD2ruTDTcVp0msXJVgy/9UmArtT/7FMdqbCCa0tCw0zzGRLSrRdqJ/TCMDrzt4mztz8PvWHg9rH4Jo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFFuOCszT3E3QzNjaXZpek5PUCszNVM3OFZxM2Jlc1R4RXdvSG1xaGhkQ1ZC?=
 =?utf-8?B?OFJjWFR4VGJpUUlkVitZMFIwTy9USStqU2g4ZDExNXlZY1p5c01kSm5SUVJX?=
 =?utf-8?B?YnVRWmE5em0vTWRVVDNPV01CaWk2NjBVYTRobWJ4dnJwSk9qMFZsVHNiZE9L?=
 =?utf-8?B?N21FVlZKRlRlUGdxUlJHVFB3NXF4cU4wZllpbmdPOW1pSW5zLzVENUdPZURl?=
 =?utf-8?B?cVFQYi9xVTd1MExnVW55MGFGbzBkZmpMVU0zWjVhemVRWkN0UExYaFpwdzRD?=
 =?utf-8?B?MG53czN0cmJpOFQ1cCt2WVhpNWF1V1krTUlrSDU5SUtTSTY4S3lGQnJWbVBV?=
 =?utf-8?B?UG05WHBGSVE2ZXJiQkRBSlR6eVdtM3JsN0dmditrSCtRVW5TbVJBNXlyVkx3?=
 =?utf-8?B?ZndnMTljdm1ET1pndURFU1lUL3ZST1UvVTdoTnRRaTNyb08zRjVqWUpHNXBQ?=
 =?utf-8?B?aEN5NXlZTzlSTlliK0lqa0MwRW5xdUEyeGtQUUdSaXZkQzBSWTdjdDBmMXVT?=
 =?utf-8?B?aDdYZzVCYVpBRXBjREtocTdybURoVVBEeWIxbHk1VmpoSXIrT3RHWXE4c3kx?=
 =?utf-8?B?aVV2Sk5zdVN2VGlERnpvV21MM0R0YVpYcWhyNWNiMko1UjdiQWpGN2JwNXlT?=
 =?utf-8?B?OERHcmdFcUlNZkV4bFh0czFXQjUrZXFPNzFSU0xQcjRhYTdBcjlmMHJ0bUJ0?=
 =?utf-8?B?R2I5Z256NHhYRUlrL3JEelRtVDU0MVNlRnZlaGdUWFk0ejJVMGtqRXA4OHUz?=
 =?utf-8?B?bDhtcmtJamp4dVpJNjNyN3pnMWthUlNEbHB4Q0hCWWhQMDVTS3JiekNpMVJW?=
 =?utf-8?B?RExwWXZwWWpGMm5UdWUrTlFqaTV6dEMxN0t1TUs2bXBnRmlUVTVyY0hRd1B0?=
 =?utf-8?B?aWxTOVE5MTd2K0JQOUd5Y2c4cERoM3NIUmRnVFlTbGkrNVBJaEgzTUZ0ZWdP?=
 =?utf-8?B?M2xEQU84eUlJR2M5SVhTYmlnREZVeUpaSFo2YjJPVWgzaWZ6eWxPeDdkbnYr?=
 =?utf-8?B?RXRuaHRRb0dCNkkydTQzS3g1aHNDeUlhdEVaSnpRa1BQWWx6MW5CNXpYb2t1?=
 =?utf-8?B?RE9vZXRRSEhoazhzYndlRjZ5VDNJTHI0ZEdDUEdPNGplWGxsSVNNVG5ZWjVo?=
 =?utf-8?B?aHN3T0pQWmxqV3M5M0VEY1k2VG41ZWJXc2Ftb05lQk5qejlOcG5vaXZ4K1p6?=
 =?utf-8?B?V0lpWVR4cDN3OUhwYkxjVzUwcWtRTnFXYmdWR3BzMGdpUFIxUTgrSzQ3RUJE?=
 =?utf-8?B?UXVUYmZxYXhkU293T3VaVzU4TXNSemZ3OTF4YTdtd01UNHZEcnZTeXRBYWZ2?=
 =?utf-8?B?T0x6aGdmejNScW01SnVOdzZpb1dJRjhoZGVFVDEwTmlScjNRSXVhNlRXSEV0?=
 =?utf-8?B?eGQ4enMzbHQ1MGlRYWhZVDlCcm5jWFVMNXMxMkJHUkhINEF1QldxWUp5Ny9i?=
 =?utf-8?B?MURhMUVBOXFVSFY4eUhBKzJWUVRQa0J2R3dnVHBIT0VQWXdxRkVNQSsxaU1C?=
 =?utf-8?B?OWhUYzg1MTR4Vm9oT2xna0g4d2s2M29BVnJoZGVJaE9jRkVZZyt2bkhHZTla?=
 =?utf-8?B?aTNidHJPUmJ4dEx0c29MSWgwajRSKzdTNEdLT3h2WVdGVmFCWjZYZTBMTC94?=
 =?utf-8?B?T2tlSXdwK282aDVCT1BIUmsxUTBKRy9VNUh6a3ZVOTR0RkExdmt5R0tVRDdP?=
 =?utf-8?B?eWYxNEV0MFd5NVVnUU9WOGFvdjYwNEJaeUk1MmR4YzNPck1xUCtYMUdlTEdw?=
 =?utf-8?B?V1ZOaWN0U09pQ0ZydVcwaUN3ZndCUHZGUlBFL3JpVUxzZXpuaVA0dngwV2c3?=
 =?utf-8?B?a2h1KzJWY3Ywd0RUckc3dE51TUUzeVg3SUZxSmJmMXJEQlVnTkVXK1NFbWQz?=
 =?utf-8?B?andPaFZPRGFyTC9RKy9VZ3dGNWxsQXYvSm9lZGN1WnoxWVg0eXkyNjMwWUxw?=
 =?utf-8?B?b2xLTnZQdTl3TzN0VlRkZlRlZlU1RlN6Z1d5Ym12RXhRODFMNkcyZjFNK3Mv?=
 =?utf-8?B?OStUSFBqS3RveUQ1QVlDallRSktlaldraUgxTE5jd0h1ZU43VzBzUGVVYTFr?=
 =?utf-8?B?NGVHd2ljVjlwVURXRUc3RXBEU2MrOFF4SmJqaHUyMTY2MXZCTG91THZwczlE?=
 =?utf-8?B?a1FVa0pTQ0Z2K0gzT2FhTnpiQ3Q5Z3NSWDFRRE1YMTQwdXBOdUhibUFibUpM?=
 =?utf-8?B?cVR4M0tPSlpmSE91N2xPdENCTDVTUG1zOWNUQ2VtY1hQc1JlbVhuSGlkUDB1?=
 =?utf-8?B?Nlg1dEM3bnkvQWpqbmp3U3lDWEEvUjl0M2NkSGpMRGxySjF4T04wb2VySUZZ?=
 =?utf-8?B?ZjdyZDFCdkF4RythQ2tHY2xhQUFUUklFUlhwSzQzZkRMaUVYc1R1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97E89AD911E6224AAC5BEA04809E991A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9958ad98-a45e-4a6c-fafb-08de7a543a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 01:12:11.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDMQBzxw//rgbxv280CvZVsUKK2Si1LOTjT9WPaZ9YXRDWCbryMhtP3m8KiCiIJZ1QopNHM8zHoRKSIfKWuCSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 563DD209B7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21380-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDE2OjQ0IC0wODAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiA+IFdoZW4gSSBmb3VuZCB0aGlzIGlzc3VlIHRoZSBDWExfQUNQSSBpcyBlbmFibGVkIGlu
IEtjb25maWcsIGJ1dCB0aGVyZSdzIG5vDQo+ID4gYWN0dWFsIENYTCBtZW1vcnkgYmVpbmcgZGlz
Y292ZXJlZCBBRkFJQ1QuDQo+IA0KPiBTbyB0aGlzIHBhdGNoIHdpbGwgbm90IGZpeCB0aGF0IGNh
c2UsIGJlY2F1c2UgQ1hMX0FDUEkgd2lsbCBiZSBlbmFibGVkLg0KPiANCj4gSSdkIGxpa2UgdG8g
dGFrZSBhIGxvb2sgYXQgdGhhdCBzeXN0ZW0gS2FpLiBJJ2xsIHBpbmcgeW91IG9mZiBsaXN0Lg0K
DQpTZW50IHRoZSBtYWNoaW5lIGxvZ2luIHRvIHlvdS4NCg0KSSB3b3VsZCBzYXkgdGhpcyBwYXRj
aCBpcyBub3QgYWltaW5nIHRvIGZpeCBhbnkgaXNzdWUgdGhhdCBpcyBkdWUgdG8gYnJva2VuDQpm
aXJtd2FyZShlLmcuLCBJIGRpZG4ndCBtZW50aW9uIGFueXRoaW5nIGFib3V0IHRoYXQgaW4gdGhl
IGNoYW5nZWxvZykuDQoNClRoaXMgaXMgdG8gaW1wcm92ZSB0aGUga2VybmVsIGV2ZW4gb24gYSBm
aW5lIENYTC1tZW1vcnktY2FwYWJsZSBtYWNoaW5lIHdoZW4NCkNYTF9BQ1BJIGlzIG9mZi4NCg==

