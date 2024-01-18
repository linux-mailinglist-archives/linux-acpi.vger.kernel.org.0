Return-Path: <linux-acpi+bounces-2931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B19831DD5
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F18E1C20AC1
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jan 2024 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A92C1AA;
	Thu, 18 Jan 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xix6PIm4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3228DD8
	for <linux-acpi@vger.kernel.org>; Thu, 18 Jan 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596681; cv=fail; b=MpGkyW3Ir6MwVmSmEqGMCWyehx3FDYIaohHgb8Aug2ZfbBg7NoCrmO3vOd55wOuLATILI2ss2Dj1xjRRr9H0kdWDvp8n0c+oSdfd7hAUxFtpUmfojVfkOlvELleke5ozU59xE8zzhgXEpFtcSSKnv+sKcAT2g4h6GO1kpIzQmVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596681; c=relaxed/simple;
	bh=PzL8ZUwdB57MCAZE07dcSXjXDQh8WEsX2ZfZPo+xLWE=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=hYhtBH9JesdccvVWolc+M74K48zpHJbn6ViwPet+HWw6VYThkmS5ChysbdfuT9BCRQSuP6VXn+3DIT7vnjYt6MOyP2t/7xH3Q/SUMDZS+AYscN4ntfAB+diU1cmf6z5IdTkRfsjy52D7SV9ZhdpuVM1oz6Wqt29OiUECUFpjO6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xix6PIm4; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705596680; x=1737132680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PzL8ZUwdB57MCAZE07dcSXjXDQh8WEsX2ZfZPo+xLWE=;
  b=Xix6PIm4AZDqHfdNt6V8IXhvC8ia6mWpvsrWmXqecBLk4c79iPsPomiz
   2rkAWPNMyy37Zye+wK8KxDWwPEEDmLd03xqi3Im9ISV7XGVVNNIsgCXj7
   qCcXWiIacrrcVdoOmihL56VZp+lVrqoQq08H6pA+SRTRimZex3L6ZleJo
   sLjQsyC9DmXL74SvDbT1bNiuw1GynfVxUL91g2t8hJZmpVxeY2IIX/kMb
   3P6WAiu/NOrTLyNke42pemWsAfBS7Ulnf9X7GW/xjcGsYlNvrYW8XZRZl
   oSGOm/4jvquyHRYZL5ue3LkoKmwUOeLNL9FPW6pvymaK75GBf+ezZdl78
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404265612"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="404265612"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 08:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="908079824"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="908079824"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 08:51:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 08:51:18 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 08:51:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 08:51:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 08:51:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZIprCfnSgZ4gJEfeaC2hpVmb7L6bwPABKvdSYPasY5rkI5OwBpnKrGmCERnPI2rqQDDtLmKfVkSSC2B3MPHq5Q5pxV5hFt33evUc9fG0RIAKzg5stSUEA5oHEUl5fQkh9Xp/GK5kJKKZIzWDui/210GVvyTTXXgG24dHUM2SqG77t3DUxQ/q72g2Od8RtCiKqkDnRmacG7OWXg1K4E8PUlI3shMBsOFgwtO3RnGUCmdY1ISpBVYtAM9SlMBRqOPDvrb4P1d8N1CP6Sbd5YXCdyoJdQsD89bcpZxOXbH3QDuvxNG6oq2tpSLU5s2sesrGvudKh36mloXaB6DUbmjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzL8ZUwdB57MCAZE07dcSXjXDQh8WEsX2ZfZPo+xLWE=;
 b=bMvUSwQa1+bHl73SSfJTBhw8BV1Gmd4xGmCtj4GqzuTscJieccpu2BtydgmgGq7+6fS3SsZPESU9NbwiEHR3iRJQj8WemovSgPv+08O45RHFz0MOotin7f10IKSm6CfKmfbq/GOeJG2FJuK9pCEW1AypscBSEIl8rsdirTKBThPTsj/Y7sv97rMzrySP2kYOU4gAsdYf9ZvThe8UMQg6Kg0+iRkX3h4kmxP+UTopjXeIAQs7dd1KCtE8G/kqmloy62iIF5IAxt8r47UzbLe+/4WKHqI39LipQwg5I/ZJ9T/WugmAb0K8gLeYJ3QbN03haaoatvjrW5BlE6enirJ+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW5PR11MB5905.namprd11.prod.outlook.com (2603:10b6:303:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 16:51:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 16:51:14 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "W_Armin@gmx.de" <W_Armin@gmx.de>
CC: "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: ACPI INT340E PTID device
Thread-Topic: ACPI INT340E PTID device
Thread-Index: AQHaRudEDd5bmTHMcE6Cr+tA+Gc8H7Da7CEAgAAurICABLR7gA==
Date: Thu, 18 Jan 2024 16:51:14 +0000
Message-ID: <f5c59585a73122b140411c3bd4ba24b2d0ca579a.camel@intel.com>
References: <14c6f480-66f4-4683-92d6-55a58eb98585@gmx.de>
	 <fec103c301df89c630d894d7c1f6db6f7ccea540.camel@intel.com>
	 <138c98d9-6a00-4b26-bdea-c7ac3cd3e94d@gmx.de>
In-Reply-To: <138c98d9-6a00-4b26-bdea-c7ac3cd3e94d@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW5PR11MB5905:EE_
x-ms-office365-filtering-correlation-id: 26398b47-7044-4707-d595-08dc1845af0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3JIR1pqDDwPI79JPYBgcElIiZQTaJoda2bLKmy3oaKpUb2UYiQLzNj0JJVBVJE3wqv/rMtdkMV4NwUv0uwVoa9pnsAKzkOa47TgwaDFZ9NhzoWz7jOxep9ZtdWem6z8LJ90zGqeyt10oY0LyPmG59WZsC5CguoManmN6Ttvv8QZr5/6++LS9GrhJfmsQ1CKF8Erg8zHXMWs4LowOl3k62wMhjorf+XDwJU8Zw8QkUD3nkcbhLNkzV2eBGeme3SFoJgyg5vzm3HcseIKJrW0BT7p4648vlHmihr9Kzk8kQEY0mcsiJkxSAIKgq73g7ULVaYqCjB4PmmQ719YdYPtX1CEKpzNhIpkLBW51+9l0792raCY6sibO19bduuHl70l3KSrnHoIC8eI93brJZ7jb8hzBekn2BPyJmwve29ADaW1Y75w3EG3kIRQgNQyadAvVY/NwLvyE5vXHbImQQigrgETFnSARQo7/kn6Yt58Yjd+K6/EB0amq3FIAi8HR6kP8H+RpgVXj/HkCMnBNyUQLw5uUuI+BdLUVCK1F1iN3kmGqaasRhekdZTI+lB/tX9FDXhPoxXptYMQZpi0xSqrslvtMjHei5RJ3aLx20LAA6AZ8d+gmqaV0iH1OVNLOhuPw0s6T6eSQVJe/sV6YTCnRDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(6506007)(71200400001)(2616005)(26005)(5660300002)(122000001)(83380400001)(4326008)(966005)(6486002)(2906002)(66556008)(64756008)(66446008)(66946007)(76116006)(91956017)(54906003)(8676002)(66476007)(110136005)(316002)(41300700001)(8936002)(478600001)(36756003)(82960400001)(86362001)(38070700009)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2tyc2dvMkQzUUsvU3ZTUXo2NzRHSGZXVE50bkhpYmJLSzgySmRVQzFleUZw?=
 =?utf-8?B?UWxhamNRSkVITnNQcS9tUjJhWm4zL1R0dlhiSXArdWFDZ0lBQ2pYMTlQTDRC?=
 =?utf-8?B?VktTeVdqK3FDVGlUaUFkdjFnZlNPUnFmQ1pqU3U4YmxFYzJKTFhkN1Y0dmY0?=
 =?utf-8?B?ZExheXVDdHFrd1U0SjlqS2d1dFN4SzBxREZrdXF4REFOd1FDU2VTYkMyWGps?=
 =?utf-8?B?Mzk1c1M2eU42MlFJNXEyeUtQOE5qUUUzTnB3WHhUR3FSMmVUVzhJd29XTGdu?=
 =?utf-8?B?N1dDZEhZR21aeVJmWEtEcndqNkhpWGVRL2pPdlZEc3ZPZnAyTHU2dXExUi84?=
 =?utf-8?B?bm1jd3p3V2VkRDFCeWlOVE94Ynl6SmNOVmZhRm9kVjd1TWwzQm0rREpXYmNX?=
 =?utf-8?B?Mm0wY3BPcWdRc2NTSytNSlJFR3FMWW9SUnB1Mnp2Q1JiRGZXTEdTLzhzRldm?=
 =?utf-8?B?YnpNbklETkVFbi9zN1NTazhNblYyOXRVTGZIQkJvL0IzQjhubGV5QzY3NFNw?=
 =?utf-8?B?aDE2azQxNE5FM3RGZ0RDSlBmd0JleGNPanJ4b0hDQnFvYTRvS2dUd2lhODFD?=
 =?utf-8?B?QUQxUURmZ3ZLZlF3QXU0VGxVK0RrbUZ0bERGV3Y1QkVRQTltelcvVFFBcG9a?=
 =?utf-8?B?Qk0vL3BWcFdwNGlpdDQwTVdReGczbnk3LzlTMisrZ2dZdko3R3l6Vmc2cVY2?=
 =?utf-8?B?b2hoMmNwVTQyNy9aSW9tak01dUt2d2t4bDZPNzFKU01jUTJLMUlqUGVLYzFW?=
 =?utf-8?B?eDIxbHdqWWdaWXNCeDhrenl4TC8xTzM4UHlxZEd0VWVSOFAzeWI4Y3NnQTdW?=
 =?utf-8?B?ZTl2MEVIU3NoMFJxd1FpN2VzUjJML25WckFtcExyMEJBUjZpeHhabFRKNnEz?=
 =?utf-8?B?L0dQUWxCcjZXeWRYazc3ODBGVEFJc3QwQW83eWVsTFNQN3RKQUs5b21xanFS?=
 =?utf-8?B?Vk02aUNVaVlRbVZwODFWZXlXdnkxdW1aYitMbE5wTm5XMWlTanFLUndxTHFs?=
 =?utf-8?B?MDVES01jY1owK1BGVjNBN3hnUzFaT1Z2QTJkdHRHSTl0UE1YeHBGSTk2bEdX?=
 =?utf-8?B?UUN2OHYvT1ViWkJ1NGpNZDhJYlFOMTJkOC9RV3Vnd3VNUkEyYWkxelMxY0NM?=
 =?utf-8?B?c0xFa2NrRkVIOEZNT09rS3hlY25pVlpNeWtWcFRENVdOZW5IeWc2TlZ2bWpN?=
 =?utf-8?B?a2xqUWxKTkVxaXZoNmxEZW1kTG9Xd0JydkJTV3FNYUQrc0ErZmRQMWtmOGhx?=
 =?utf-8?B?Z2paV2wwMXdXOFJud0p0TTlGTHdOWi9mdEpXZlJmRmJoaHM1ajJzd0tOK0Vj?=
 =?utf-8?B?Mmk4MlJwbmw2ekZ6S0tRNGdJdVNRSVhlSFpEZGRsRHZ0UkZ2QVVnVS9QczFv?=
 =?utf-8?B?SHBPQWFYVU9jOEhUMHdlUDllR2FGanpXbjQ5Zk5SUmIybUhadnkwQ3o2RVE1?=
 =?utf-8?B?UnFieFhwYkxCYUJqeDIxNmpwTEVnMC9NQjJqREl0VDlBTjcvdko5bGt4bzZN?=
 =?utf-8?B?KzV5RVQ5YUtrMG1WSUFjblR4OHlncVZhK3BGWmpMTzBvbkNqRlo3TmdDUlZC?=
 =?utf-8?B?bHZqZU1laWlNSXZ1YXdIQVNnaEVycDhoWEtTTWw3M1dnaHVUWXNkdVhUN04x?=
 =?utf-8?B?U21xb3h2TVVhS2xJZUpDUGQ2b3lMV1AzL01aS3AvdmVGV1Jtb1kxaTR1SjJT?=
 =?utf-8?B?clRrWWJyaGNRRkdwWmdERlc4cVkwbk5jWUxHNzNqMXlQQ29KK3grUHhxYnBq?=
 =?utf-8?B?NmhLN3Q0aTcvbUhELzg4QjFJWUk5Z1ZBb0R3OXVWYVRIZFFLRFp2Y3lqVC9j?=
 =?utf-8?B?Ty92U2dsamhmUmIzL2hkOTRuWjdrUXdVajdCWUltTnliTmR0N244eHN0Tmtx?=
 =?utf-8?B?UjhJQXExdENiWlpYSDJxNG5BUzF4aDRacExMVjRrSWtobW1VNEIvT0dMRmdN?=
 =?utf-8?B?V0JLdTRMVXg5aER0MS9EZXRHNTNyWmJiSHNLenFQMVlqbGNLUHY0THZPelgv?=
 =?utf-8?B?TmJwRmExL3k3aUIzR1lVWGFWSkMwTjZQcG5pWVh6N2JLMTJVN1FsWkhWbGFq?=
 =?utf-8?B?b3ZkR3FUY3ZBeE9DSDhYcW9NMFUvWUw0WURqdklkMy9TcGFQREF4R0M2TW8w?=
 =?utf-8?Q?BoR0p88isp4eHkD3Zin8S56VX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70199F657AF5834A81F2FDFBEA3A6C8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26398b47-7044-4707-d595-08dc1845af0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 16:51:14.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bx83klhB+dyGcj/qbVpGqck2kaZgLykBYXtUQUzGoyjJ4W0wggJbNNegkfFy5tcl1HY6r6yix1bN86n9aIeag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5905
X-OriginatorOrg: intel.com

SGksIEFybWluLA0KDQpUaGlzIGRldmljZSBpcyBkZXByZWNhdGVkLiBUaGVyZSBpcyBubyBndWFy
YW50ZWUgdGhhdCB0aGlzIGRldmljZSB3aWxsDQpleGlzdCBhbmQgZnVuY3Rpb24gaW4gY3VycmVu
dCBhbmQgZnV0dXJlIGRldmljZXMuDQpJIGRvbid0IGhhdmUgYW55IHBsYW4gdG8gc3VwcG9ydCB0
aGlzIGRldmljZSBhbmQgdGhlcmUgaXMgbm8gZG9jdW1lbnQNCmFib3V0IGl0Lg0KDQp0aGFua3Ms
DQpydWkgDQoNCk9uIE1vbiwgMjAyNC0wMS0xNSBhdCAxODowMCArMDEwMCwgQXJtaW4gV29sZiB3
cm90ZToNCj4gQW0gMTUuMDEuMjQgdW0gMTU6MTMgc2NocmllYiBaaGFuZywgUnVpOg0KPiANCj4g
PiBIaSwNCj4gPiANCj4gPiBPbiBTdW4sIDIwMjQtMDEtMTQgYXQgMTM6NDIgKzAxMDAsIEFybWlu
IFdvbGYgd3JvdGU6DQo+ID4gPiBIZWxsbywNCj4gPiA+IA0KPiA+ID4gYSB1c2VyIGhhcyBhc2tl
ZCBpZiB0aGUgQUNQSSBJTlQzNDBFIGRldmljZSBjb3VsZCBiZSBzdXBwb3J0ZWQuDQo+ID4gV2hh
dCBkb2VzIHRoaXMgZGV2aWNlIGJyaW5nIHRvIHRoZSB1c2VyPw0KPiANCj4gSGUgd2FudHMgdG8g
YmUgYWJsZSB0byBtb25pdG9yIHRoZSBmYW4gc3BlZWQgb24gaGlzIE1TSSBHRjYzLTEyVkYsDQo+
IHNlZQ0KPiBodHRwczovL2dpdGh1Yi5jb20vbG0tc2Vuc29ycy9sbS1zZW5zb3JzL2lzc3Vlcy80
NzXCoGZvciBkZXRhaWxzLg0KPiANCj4gPiA+IMKgIEl0cyBzZWVtcyB0aGF0IHRoaXMgZGV2aWNl
IGV4cG9zZXMNCj4gPiA+IHRoZXJtYWwgYW5kIHBvd2VyIHNlbnNvcnMgdG8gdGhlIG9wZXJhdGlu
ZyBzeXN0ZW0sIHBsdXMgc29tZQ0KPiA+ID4gZ2VuZXJhbA0KPiA+ID4gcHVycG9zZSAiT1NEIiBz
ZW5zb3JzLg0KPiA+IEhtbSwgSSBkb24ndCBrbm93IHdoYXQgdGhpcyBkZXZpY2UgcmVhbGx5IG1l
YW5zLiBBdCBsZWFzdCBpdCBpcyBub3QNCj4gPiByZWxhdGVkIHdpdGggdGhlIG90aGVyIElOVDM0
MFggZGV2aWNlcy4NCj4gPiANCj4gPiA+IFRoZSBkZXZpY2UgaXMgYWxyZWFkeSBzdXBwb3J0ZWQg
YnkgdGhlIEhhY2tpbnRvc2ggY29tbXVuaXR5LCBzZWUNCj4gPiA+IGhlcmU6DQo+ID4gPiBodHRw
czovL2dpdGh1Yi5jb20vUmVoYWJNYW4vT1MtWC1GYWtlU01DLWtvemxlay9ibG9iL21hc3Rlci9B
Q1BJU2Vuc29ycy9QVElEU2Vuc29ycy5jcHANCj4gPiA+IA0KPiA+ID4gQmFjayBpbiAyMDE0LCB0
aGUgSU5UMzQwRSBkZXZpY2Ugd2FzIG1lbnRpb25lZCBpbiBtZXNzYWdlDQo+ID4gPiAiMTQwODYy
MjkzNC4zMzE1LjguY2FtZWxAcnpoYW5nMS10b3NoaWJhIiBhczoNCj4gPiA+IA0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgVGhlIFBUSUQgZGV2aWNlIGhhcyBfQ0lEIFBOUDBDMDIsIGJ1dCBpdCBp
cyBhbHNvDQo+ID4gPiByZXByZXNlbnRzDQo+ID4gPiBhbg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgSU5UMzQwRSBkZXZpY2UsIHRoZXJlIGlzIGEgcGxhdGZvcm0gYnVzIGRyaXZlciBmb3IgdGhp
cw0KPiA+ID4gZGV2aWNlDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqB3aGljaCB3aWxsIGJlIGlu
dHJvZHVjZWQgYnkgbXlzZWxmIHNvb24uDQo+ID4gSW50ZXJlc3RpbmcsIEkgY2Fubm90IHJlY2Fs
bCB3aGF0IGhhcHBlbmVkLCBtYXliZSB0aGF0IGRldmljZSBJRCBpcw0KPiA+IGRlcHJlY2F0ZWQg
bGF0ZXIuDQo+ID4gDQo+ID4gQ0Mgc3Jpbml2YXMsIGFuZCB3ZSB3aWxsIG1ha2UgY2xlYXIgd2hh
dCBpdCBkb2VzIGJlZm9yZSBkb2luZw0KPiA+IGFueXRoaW5nLg0KPiANCj4gVGhhbmtzLA0KPiAN
Cj4gaXQgd291bGQgYmUgaGVscGZ1bCBpZiBJbnRlbCBjb3VsZCBwcm92aWRlIHNvbWUgZG9jdW1l
bnRhdGlvbiBvbiBob3cNCj4gdG8gdXNlIHRoaXMNCj4gZGV2aWNlIChBQ1BJIGNvbnRyb2wgbWV0
aG9kcywgZXRjKS4NCj4gDQo+IEFybWluIFdvbGYNCj4gDQo+ID4gdGhhbmtzLA0KPiA+IHJ1aQ0K
DQo=

