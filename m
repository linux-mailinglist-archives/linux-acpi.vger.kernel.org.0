Return-Path: <linux-acpi+bounces-18570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B425C38AFA
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 02:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FD7D4E0F4C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1C1E5205;
	Thu,  6 Nov 2025 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Er5atm9T";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="djOIprOA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E947E0E8;
	Thu,  6 Nov 2025 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392028; cv=fail; b=FbPNOnJnleVNV+yTLW4ko+mx4kSKHf0CfFYjnahFITXsdBi80xPNimN5p0UxmBm9mNomtyZcW0R4UH2qP1c0NeBNS7GYjKs2C7SwhZQYt5IHaThyywt1u5Hb0bCImP8NNMkdolP/bZmccLiACfk6Uwe/2hDCbi1sUshplfTo2no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392028; c=relaxed/simple;
	bh=ONzzjPPwYObBKuHOTPbO6B+AjWDzE3J0ImQfPAXXJ70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AwzxDotSn2vrtcPp7dHJhDVeBYrkqMLtLCmNmDDmDBYj8QfJUGfayaxn7obIzue2p+TLDr+dn+5wn/ZxOTI7UGZ1tZlUiuyfkoGox5naSfmPZm4J4J7AnsKtLeP+WngnaCfR7SUSZYJEj8KIDZQvBnvUWtDbo8KrvBxDAfuP8VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Er5atm9T; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=djOIprOA; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1762392027; x=1793928027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ONzzjPPwYObBKuHOTPbO6B+AjWDzE3J0ImQfPAXXJ70=;
  b=Er5atm9TIrA37dEk50g9c9+Nm21x60DH1+NUMfGxx+2EILmsyb6ysxbI
   EJS1U/ct6n5oJpUqDTlOsoAGDOwhXGDsYUU6F6bU7SQYkm7TX9XoqrPF+
   8jlTaucL1tx63V/wadAcRpqh6vRRWsUH8r5Gj2xCzmJoGAYEjuxC4yKSL
   ZCtC3le0bqtNbqGVcogyzgpKM3ojZoGnPWek1h9uyu3OnpynQHectEQNL
   W1nMNFmqKY1mg/5/Bc4gY1PFrNtbE0pte3hla3wKC5FM1gTW8iCrXhz9g
   TaNblseMNajzRw9C3XMKC6QosQ1xoD3xsop2aksvymn6l3IoLZoxExh1R
   w==;
X-CSE-ConnectionGUID: IoCrPjvGTIKMCCr1iu+C1A==
X-CSE-MsgGUID: vO3lXR6gRR2l5lp66btuIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="173023437"
X-IronPort-AV: E=Sophos;i="6.19,283,1754924400"; 
   d="scan'208";a="173023437"
Received: from mail-japanwestazon11010010.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.10])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:19:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDrVoRL6INeHPPWWeUDsX/fqJSiI3BSlPpV09doDDmCIQar6e7jh+ONbfp5uTfVs29NRyliwldXfN5/bKUeQHInR4XDUDbj1RZxHqpfvaFtu45H44cG2fi7iSvd+PstGiClrxiDmAjXDVJVppoq0Ut9w7xyYmTlmFMpVO9WZpNHbpQThnOeAFH50mxNGeXQvyixfOXu2hw4YcMdnERJuHmE64wXo4lepoupqjbNMMLnurxcPhijNTHaj+Vrcvdm7gPcD6H6ZnHeUhWVBk3cgbjrCrbLRZEXnoysJIkSyoEkYGaJVLfplDSWC3b3Vadi+ZCoPo4vdpiP4nl2Tp6xNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gASq+sNbdvovAzqo7xNrfe9ZIri+oM0txNZZ1BGIy+s=;
 b=rLNnGQi67V9XxN1A4zOd8xraowrwHf2i7FrlKGVRmp39QR1Ek6WpU9Omao60uDVX/0MH6xcgOMJdxNXICflISidH+hBjOR3GhdjitI50d4/9sVGEaiupIUf/NqaJhk8aJ0lmJ6OGFLkqQBR/9mjc8Y05YMQiFTrFrwI2sXuYo4ual74qZu6FduEH5W9FQYnBG9AmdhtljDskWR6XHW7mL+kKeoBTi0cBVMjyzww9s1FJEDtZUioaSEiSzEL2kfY+upWxXnMMmCCbuRtugCDosXuDq0+CTPgvj8cFDkMRpXanEPGbIsIwot/gGQHSWPQ9nhJMk/5eIFVtbRaQRvlCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gASq+sNbdvovAzqo7xNrfe9ZIri+oM0txNZZ1BGIy+s=;
 b=djOIprOAoLzvbJIwdT2QaQ34lW41Q7XBLYlfHOslZfEaiBQv5Fagdjj44Q6euUxj/KHZHEwQ/hfhTRxc141iVEWcmpRuszr3WkmYG8TnwGnqdUa5wowjmBDnT2t7v+DC8he9opU732O4cFi2V4f74pAxtfnfPeoWsZuZG5fzsroXexLPVfkv3WDC42iCBXOfmIxBVGgHntr09FmoYfRmucFaI6MvwWqknItembp+m7V1faKJ6sZVsVZBTQxClRUbzkELkasJtimFM5TfBDmyJXtyEnfKaqTnMbvu0hvq6HL82r5+fQKdkp+nFUPqb4+Q2wdW21n5aG8N7QfPUQGYXA==
Received: from OSAPR01MB7669.jpnprd01.prod.outlook.com (2603:1096:604:142::8)
 by TYRPR01MB12515.jpnprd01.prod.outlook.com (2603:1096:405:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 01:19:08 +0000
Received: from OSAPR01MB7669.jpnprd01.prod.outlook.com
 ([fe80::2b44:88c5:b2fe:5b4a]) by OSAPR01MB7669.jpnprd01.prod.outlook.com
 ([fe80::2b44:88c5:b2fe:5b4a%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 01:19:08 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Will Deacon' <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>,
	"Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
Subject: RE: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcPzk5+UU2j3z+uUO7itsPcFLu87TLCuOAgBfAiwCAAiHCgA==
Date: Thu, 6 Nov 2025 01:19:07 +0000
Message-ID:
 <OSAPR01MB766951191ACB95ABCD7DD319D5C2A@OSAPR01MB7669.jpnprd01.prod.outlook.com>
References: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
 <a93e845a-b084-a680-7158-68363c492b75@huawei.com>
 <aQokdBkjFqw9ZGRt@willie-the-truck>
In-Reply-To: <aQokdBkjFqw9ZGRt@willie-the-truck>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=9d23579d-4314-443f-9efa-68a78df3a4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-11-06T00:39:51Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7669:EE_|TYRPR01MB12515:EE_
x-ms-office365-filtering-correlation-id: b5573d3b-f059-451d-0404-08de1cd27b76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?T1B2anJmd3czYTQydkM2RUJVZ1l3bkxHRHZQRHNpUE5taGxSaE11T0wz?=
 =?iso-2022-jp?B?ek1lQytEL2g4dUNEK0szVjQ2bGgwcGVBZDEwd0czMG1mY3VwVXo5TVFQ?=
 =?iso-2022-jp?B?KzFla2ZCYTFpMmUzZVNMc3p0WDQyR2ZBWmJJbVhaT2hBR29tbkw2NXV2?=
 =?iso-2022-jp?B?Q2d2cytqeGxKYkdJTWZIYUFGakJmZUxWRmo5ZHlKVk10ZDlHUkNHWHFT?=
 =?iso-2022-jp?B?cFlkcmYyUkJ2OGVLQk0xVXNIMTdSSFpaamFyWkUzRUdialFWSmliclNX?=
 =?iso-2022-jp?B?L21BUk9MYW9sa2g4TVhVbGpqWDNvSnBrNG1TQm5JT2E2NnlaZ2JMbHBU?=
 =?iso-2022-jp?B?ODVvTjAvVEdPaUdtMXRCTmM4YjU0WEZHTzNzM0kwcnFzYURTYjF6dm9S?=
 =?iso-2022-jp?B?UDF2Vm9aSFExcXZvNlZManhTVVR1UFR2YVc2cnh3akxUc25XTlFLb0hz?=
 =?iso-2022-jp?B?RVNOZ2E2a2JIUVlJUm13eXVUNytmMzVRcHdGTTVFUUxQTDBCMjBabUp2?=
 =?iso-2022-jp?B?SG9NSEdWbFpNM1lGZDg2Q2xjcnRsaWE5YmIyd1Y1aHJFNG5CZDVxb040?=
 =?iso-2022-jp?B?SUdCM2Q1bk9OdnhlMWh5N1ZzQlR3TlB5MzdhSXpiVzUvb1g2eGZHWXF5?=
 =?iso-2022-jp?B?Z3NqOFczNElVc0FjWG4wRk9SZkphanEvL0N1RzFXMkU2QUdPcFg0cUNK?=
 =?iso-2022-jp?B?blY4R29NQzlIZ2g5bzNTMFFkdFVLdGUzd0ExOVVhajJMOWpoYnJ1MDF0?=
 =?iso-2022-jp?B?cHJxUmtBdko4NzRLTE5iQUVsZFFRVmVpR3BYQUFPbmw1eHArTGhrMWIy?=
 =?iso-2022-jp?B?VFg0bG1WRUF1b2ZnVGNCOS93SHdCYk5YMTBqRkxVVG9SU0w4MElOeFdr?=
 =?iso-2022-jp?B?WE1VZndsRjA4NUs4MEZzT25BdFRNOTBFUkFJM1E1dWVmTHA0eUxDV2lP?=
 =?iso-2022-jp?B?U1J1V1RKRFV2Q0hkNWR3L0loZjNrYXBmQmRONEFxK2JkQkI2TThNMUlU?=
 =?iso-2022-jp?B?UVF1UFk3dU5JdVlGWUtZcTlXdDRlMHdzbkJVQ1IzNm1TM0xiellWeEpw?=
 =?iso-2022-jp?B?STFyQmVhcEpIMS9yZGhzQSs3N0p5eEsxeWk2Uks4K2RMTnN6L2NXYlRz?=
 =?iso-2022-jp?B?eEtra3ViVjVGZlc1WS9UZUdYS0tNWXVHTXNmZTJuaXFGVXV1akdSM2ta?=
 =?iso-2022-jp?B?Tld5Vy83OVlPT0syTWoxelZsTXJGRkorSm5xVG5mZWpsbmFyemR6TlBI?=
 =?iso-2022-jp?B?YzAxOVJTbTV0LzlrU1B2SE9yRStSQkR0M1JDeGZKbUJwemsxNTVwY05T?=
 =?iso-2022-jp?B?aTZvVTdHOUNzcWZraWVoelYxQ3dqWjBieS9PVmpsQnI3djNNVjZPUFI0?=
 =?iso-2022-jp?B?UUlTNUl0ZmJWRy9yekdQOVBBVmdISVpwVE9ReG5YUGlTR2QzUWJGYTlx?=
 =?iso-2022-jp?B?MU1zQmJmdnJycDI0V3JiNUhTS0xkakZxVzVaTWVyYmJEYmxmVnNLUmpV?=
 =?iso-2022-jp?B?T1Iza3lsaGVWRksvakVNdDRKN3ZsYm0xQVE4eXNoT1ZZUlZVd3pUTHVW?=
 =?iso-2022-jp?B?N0x0c1VOYVFySzNzMmFaQTc0TGdsTlNSb0pPUldCblhpLzYyTEkrSGtv?=
 =?iso-2022-jp?B?L0NONmxtSThBY0JUVkFNK0tYbk5DbE1oUVBBZnorQ09XbjlWRzVtYnd2?=
 =?iso-2022-jp?B?TTBLTE5vY1AxZ1N4MmNwS0lDaGJhOU5JcEx6a1N6QWRDdzBERUgxKzFj?=
 =?iso-2022-jp?B?c1VuVldHdFAydG9QN0hEUGgzaXh1aHRoOTBHMEtqc1Z0OEc0SHVLT2Nk?=
 =?iso-2022-jp?B?ZWczUkpqMXVSNkVOb2YvaXcrUkJMYzN4WWtLVmhWQkl2djZWSU1LdTZY?=
 =?iso-2022-jp?B?ZVJpNGtyQm91bE9GRzhyTGI0ZVB0QytjbVpCU0tjbHc4ODZxZXIyTEMr?=
 =?iso-2022-jp?B?emdHc3R5NTR1UktycTIvaDB6Rit2MW5YWStaeXI1VXVOYmhiQWZ2M0cr?=
 =?iso-2022-jp?B?SkFjYWZXdm9lUFdCc0tITDJwN3ppUHFKTGZweWR4TFpYU2JycVNSK1RI?=
 =?iso-2022-jp?B?WldLaWVsclQwMStZT3pRK25VNmxsL0w5WkFUMEh5enRhaUhyblJ0YXNy?=
 =?iso-2022-jp?B?eE8rQURzQnhza3pHWTdMQUFmZng3YzVRRlA4cUJqdWRoMk5RV2JkZWhz?=
 =?iso-2022-jp?B?MnhKVElWL0pwc21IQVNIVmpGVWNtaVo5ZVVUUTRVQnB1QlpmeHdVbGZ0?=
 =?iso-2022-jp?B?S0UyQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WUxFNEN3SUN6ckRlN0hzeFBZZFQwM1NWVitWRnpqRVNUM0xyMm5yY0Iz?=
 =?iso-2022-jp?B?S2MxZjJGbUZTUG1rY29DNkwrYytUNVhUcmJIQ2dwYTY0MUJmNi9GQVNU?=
 =?iso-2022-jp?B?SEVQTUhheFNhekk0ZngwRWpEZHo2TEpvWHRvSWZObmtEaGNzcVFmc2Vs?=
 =?iso-2022-jp?B?aGtqQzRzdXgzUDd6bVZZV3RERlpaOVdxek5iWnVMN3IybnkwbWhOSE9H?=
 =?iso-2022-jp?B?M1FNbERhQS9jckZuay9valdueE1LTytidCtLMS9DRktBdmpZMnVxWmRF?=
 =?iso-2022-jp?B?V05rVktmNk9Ya1NPV050ajhWOEduMmxtSE1Idmw4VStiLzlCcFcwU05L?=
 =?iso-2022-jp?B?Mm40eWdJeVpRVGF2NnowNXVZeFgxQVRkcnRIVjAwZjJMK1FwUWRqbFpZ?=
 =?iso-2022-jp?B?YXVWY2lpdjhpV2xmQzZJR0xrSERLd1pMbURiZzV3dzRDNy9DNHpBbjNp?=
 =?iso-2022-jp?B?OUV1UU4wVFc4U1lQSHRIbHV0Rm1wWnZuaXBIU3B0N0l4U3lzQnZPU0xz?=
 =?iso-2022-jp?B?UG5HZnJMOThiNE91eGEwUER1bUJjbmxpUTVjUk1VbFRKaEdGNjZueits?=
 =?iso-2022-jp?B?NFpMRC84Q1lRb1Zud3Y1ZDlHeHhNUGxwbS84SmlGZ0loTnNmTDJIUCtG?=
 =?iso-2022-jp?B?MHl5ODlBU3JxamRtNXhqV0tDNno3eXhFZGdaNjlWb3l3MUhQV1htb1dX?=
 =?iso-2022-jp?B?R0VwNWMrME1FbHRZbnliMTlyYVlUQmdQQi9oL0U2MVdOM3VPeCs5cGFS?=
 =?iso-2022-jp?B?Z3VheHE3QXdQS29oWFc1ZDZER0ROWlBXTzVXUCt5VHh4UjNvNUZIZHZH?=
 =?iso-2022-jp?B?aUVnYWFQMVp1c3dBVlJ2R2d5ZmhsZk1kMzZoS2xOMUk5NUk3MjR0NDls?=
 =?iso-2022-jp?B?aTJmdUhIT1d1dXBLWVBVOXZBMi95WXc2UDJWVVk2SUJYdER2cVdQemsv?=
 =?iso-2022-jp?B?elBEQjB0aUd5OVpvbzJseG5tVWhJZ28xcFdaYXE3TjBaSHBxRE1EOXg2?=
 =?iso-2022-jp?B?MkdmbFpwb3FWSTV1VFQxa1FSMThTVXIyVmtwcjN6ZDZrQnBTY2UvSFRE?=
 =?iso-2022-jp?B?b3luYzZodUJhU1RORkxVZ1VMSUNDRU1FZlhPRjZubFVNRS90Qi8wajYy?=
 =?iso-2022-jp?B?aFhDbkpIMkdjMzg3eVN4VFVKTk5leUV2c0VkUXhMVnZ5ckUzQ05KU1Fm?=
 =?iso-2022-jp?B?VjFjaWdyZ0cyczZvUmlOV1dRWVUybVk4N0tFQVVxak90Q29RNmVraVU0?=
 =?iso-2022-jp?B?TWpGZ2ViazY1WDRSS1Z2YTVUM2ZZTkFyUlhRbW04dzNlMitldWFtQk1r?=
 =?iso-2022-jp?B?V0FjNUFLV3pBc3RoUkg0UzltbjYwNlJUazU0cVpPWXRUcm16M05saUdr?=
 =?iso-2022-jp?B?S2FUUTRydHlSZmtTZXNpTVUwejFMaU1vbkt1Y25Fbk5ncHFtbS9ReFVU?=
 =?iso-2022-jp?B?dFBkdlVkZEJ5RVJ4R0dPamh4RlR5UUZuR0RvazQybkpmNU5TVEpkOUdK?=
 =?iso-2022-jp?B?akUzMEJpeWVDM3MxSzRMUnlBN0pLYmtGQnZlN2ZoeUsyU2NYcklIZkxD?=
 =?iso-2022-jp?B?SG1wMlg5NnZiMEFPNXR5QkxMUmZLakFESXVGVitKZUhoNytpRzJZa1E3?=
 =?iso-2022-jp?B?cEhhNTRFWWpxWGdWditsam1vYXNhV25VKzRPVDNLSm5SdGNCZUJYbE5p?=
 =?iso-2022-jp?B?VzVPUURwaWRHdnY5ei9Sck9BblNKY3FzM2dkUjcxZExhOUgyeXhEdkdF?=
 =?iso-2022-jp?B?U3MzNE40S0hJOHNrUnJSbUpvdWZSRlBJbUlYWHZ0MSs4bnJsSjFRcXRm?=
 =?iso-2022-jp?B?U1M2SkdvSENRZDVxdmZsWmVhclZLLzZyZ08zTXQ1K3F1MVI5V3QvWnoy?=
 =?iso-2022-jp?B?NkdISVgra3hheDdINW9HNkVEbFcwb2k3WHJveG1jNUJJVVVxUFNCdFhm?=
 =?iso-2022-jp?B?ZnhLa0FTTjQ3dnNITFBjNENTM2REYUNLbkVSeE9hNm5waDNMdWJBQXRM?=
 =?iso-2022-jp?B?U2tQY2tyQTRSdENiemZ6ZmRPQnY2Q0I4Z2FCUHpNcHg1QWN4N3U5UzJ1?=
 =?iso-2022-jp?B?VTF1N3R2TGRydzhXOHlZWDJBNVRqYWg4ekE4aXBCcHZqTnpjcERZUlEv?=
 =?iso-2022-jp?B?N1FtcFlYQk1rU1ExTEJqR0FEMzlqQWZsdTB0dXd4ZDVuWlV4a1o2Sm1L?=
 =?iso-2022-jp?B?TlJzRDhjMEZ4dmlxRjF6QmlxRGRwdDhUZ21DcUZyZkFwUjg5cHJrRkF3?=
 =?iso-2022-jp?B?UUptT2F0cm9OYU54VzdNS2VWZDl3b0xibWpiV0s0T1FOUitaYXNpTzZW?=
 =?iso-2022-jp?B?UmFQS3JZOVpFQTJNVURaNE1pUWFMRkZoMEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nyS99uHqWY8WHZSOSUBnDfgtyjAvAS1WVj/Iw2g8Jvf0LjiDz2j5pT7bxcU34kqKPzJ5ykzhEwW2aegPnmjhD1VaNtomD2UuLBCV9NjaaWUM5pRh52o6H6hGhXaFwTIuADGnvrVZ3zqzDG86UjuZSf04Uk0tQg19wTev+gGLnDBrYd8V//O43WmVG6mI53Xbp1nNHCU2+bQWDQBjHDCE1wHUlCeimFPlI4z9aFP/LRJLaxqylsq4nXkbI9nRPZfO1fjb5apasay0FnReRu+JVLl9kYeqcRhxXj0XuWkjNDopudDKwCTFfSncVD8KghU/qIb7/NK1ggVHxwDs5HUAANYrGDwByOxqPmN/1oS74GDBAchURF7SGcKP93dEcn2BifWjOwYtm7+keXj+RjwBSR1AbWsjJ29s4hKZM8u3K+esQ3mc2c2L3slWQLaYa4xqS6RxxMt46F/Pt5EBHRYvewU+sGYb5hq/9ZtmQJ8F9SXhH7yPSxOITGeIwnb/xWe2d0nFXK2yKC20HV0QcOKI/sp2PCBhrlDIHrwJQuOB47xxnLWG1+hNRVFfjH06dsfccacFrqepMLcC0uOYfKr5IMxWPkSVC06RHMgndz/p+EvqquiJl0YoedlI0qleakNz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5573d3b-f059-451d-0404-08de1cd27b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 01:19:07.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlYyaV+OkwoCyyBHW4dHYHP0XJZXBUlz/N1DfmG/8FPMhSyNkDMgJ8WfFWN0hw8l/DKQcOlnXmjUOs/sFilp3GsmLMq+lmoIc36wpbIUsnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12515

Hi Will,

> [You don't often get email from will@kernel.org. Learn why this is import=
ant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
> > On 2025/10/17 15:39, Kazuhiro Abe wrote:
> > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > Currently, the AGDI driver only supports SDEI.
> > > Therefore, add support for interrupt signaling mode The interrupt
> > > vector is retrieved from the AGDI table, and call panic function
> > > when an interrupt occurs.
> > >
> > > Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > > ---
> > > Hanjun, I have addressed all your comments.
> > > Please review them.
> > >
> > > v3->v4
> > >   - Add a comment to the flags member.
> > >   - Fix agdi_interrupt_probe.
> > >   - Fix agdi_interrupt_remove.
> > >   - Add space in struct initializsation.
> > >   - Delete curly braces.
> >
> > Looks good to me,
> >
> > Acked-by: Hanjun Guo <guohanjun@huawei.com>
>=20
> I wasn't cc'd on the original patch but I couldn't figure out why it uses
> IRQF_NO_AUTOEN when requesting the irq given that the first thing it does=
 is
> enable it.

I misunderstood the usage of request_irq and enable_irq.
Since there's no need to separate them, I will remove IRQF_NO_AUTOEN and th=
e enable_irq call, and send v5.

Best Regards,
Kazuhiro Abe

>=20
> Will

