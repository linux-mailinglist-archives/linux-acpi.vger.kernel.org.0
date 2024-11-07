Return-Path: <linux-acpi+bounces-9421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ADF9C10BD
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC6BB23F8E
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 21:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9C2185BE;
	Thu,  7 Nov 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uhjjj5iz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C351218921;
	Thu,  7 Nov 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013788; cv=fail; b=TsVWkkiCWwRKvpf44tCAL6GyLn+1fepMmcXKGsOHfd+dG53c5Gyjg73gNpae7uLE2aYYSw1leeD9ztPfmeNmSyQtpy8tlYjgjjpGHwJCzkaRCVn8beFv+/d7ZFi0BuFNAM/BY7BGFv8VIKzdExViVN9nZNsyrltuY2GpwCc9OHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013788; c=relaxed/simple;
	bh=TsW3N3JpvXjSDOeGNTNJSg7eG3Vv0Z747SiFn+eRXdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZmlVmXGl1bLGNBLKN3ZefrTp19ax39znofdU1IqCLwVqXVJ04gDaouXB+zU0P7h+ElnpJY6OA+ZylZQ9kF6AnMAIb6PaMiC0T9ZG/UKQxTT15JsLD0FBJyTYml1HI86V/rm050BCyIwt9wi1N1aN27bbMhY0gpEeD72CqtaAmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uhjjj5iz; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9XhZbWS2exVZrcs3OocnLEgACRJyxByJ3ufFwTIhst3sqfLi4/JtiQn9US/uNCsZT7flX6XQ7FJVPrFE74mBVeaiKrCU4Ar20LBaIFA+9q7xSanpsf+hZoZstITy+N+tp9IOsj2JM4FqJOT62Bv4MDt2kKDiqH/XEAaoocYRzJ1dS/oZ+MiWueqHnARKLLEvrbmQIpDforpnKEcRamIScxPbMcs4+59072vOREzGdMXi3pflu4CdnxtauZ28RhE7OOPPtk/JNgDA2+GWtdILrwPdXaWFC7bXMr+F9GDvfJFnIruMZSdbtiXXYpVLG6qeEMiwC5ZCW7xhrNZFbHebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33h4ZbXUZj+IfkBC/OFe5IlC7aOcMQTc4N+fWBFO0I4=;
 b=n7UJg9QkUWj776MFdV1SF/bPNPFCrk76CjQ8WrtlUepe9V/+uxB3tLBe3PHMj5OpMRcGb4sAMgRHc/HhIn1+Ik4weUARpesWZ8FslX0cspO6TmMDdvM4ZiZEdWtbdAK3m2zTr5adR8T8mrwgsfLWvPBXTiaReyoZAiO6IpZb1c0eE9PsA2aS1pE6syPGr5qux+zOgm62W7Rem5PvmQ2QRjiMRhQqXJejR/vUOByt8HwxCqVqTvZHRvG+hJgbnVC4J7ODbphwH2cLos9AEcOfHP1Xy2FZaMBSVIL+VZnkgtDra5FwY/WcvkPfcfuYJ/7ZF20+lNmPO4loWLXqtLdjTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33h4ZbXUZj+IfkBC/OFe5IlC7aOcMQTc4N+fWBFO0I4=;
 b=Uhjjj5izOt9sO23pyqhzaG+6GBP1oNvjuWt7DzsoS8N3JmC2DZpmLi8ea+H4SE+j/psO4rXgz0diNO0GzyZ/QMOIlCU4UEPYYuQgajya5kAcA2AWh7UFt9kXDx/nJHNxUp5pLzCt9XH9VAK5IW4MtcpYTwvGREI6w7ZVyiGsAlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 21:09:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 21:09:43 +0000
Message-ID: <67f147a9-9c4c-4923-95fb-6186f8b51d77@amd.com>
Date: Thu, 7 Nov 2024 15:09:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/20] ACPI: platform_profile: Create class for ACPI
 platform profile
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-9-mario.limonciello@amd.com>
 <84a647ba-50ec-4d60-b4be-758ff50335bd@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <84a647ba-50ec-4d60-b4be-758ff50335bd@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a6ca4d-5774-45db-ea0f-08dcff708034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGxjQkpxNm5ROTh2c0VBR0V5c2NSTlhTR1lIeE1RNTlUL2piV0ZiQWw5WUh1?=
 =?utf-8?B?ZWZpa3FNWEwrc2RmK2UvZUxPMmplZFpuV2VKRlZiY1JJT1lUV05PQk4zWS96?=
 =?utf-8?B?M0JuK3V3TmNTQkgxck94VHJqZXZJZGtBZHFoMDY4VURIK3o0TWdvd3VIeUt3?=
 =?utf-8?B?eWx6SjhtaFVoc3dFTEZZOXcva3BQQ0FLcVhNaVkwcEVyOU9zZjBDMytnaGgv?=
 =?utf-8?B?U0lvdmZNYVJwM0JHaFdZZkFKQjlXU1NkWU5FbXF4NUtzaGV1eG1lWkFnSVFj?=
 =?utf-8?B?MnpSWFJOS2hCMUpvU3I5YmtINUp3a3pVTTdjb3dYdTdDVDd3MTEyc0hkRkww?=
 =?utf-8?B?alRPZXQ0bkpVSnF0cEpUU215c29FK1U1WnlTWEF6bnZubng1c0FYRlMwRFpt?=
 =?utf-8?B?ZVRVZGVPbDhLZEFOc0EwckRwUjRsd1ZUODdlQzlGa1hEK3Rlc3YwQ0piWm5P?=
 =?utf-8?B?VFQ3amtXcTRvRDVNbElBRTNNLzZxdG9LUlhROHM3eVUwYm10OW5yR2t6Tkov?=
 =?utf-8?B?bkJZTUQ2SDVCVitQOGpRSUY2L3BvWmFsdm1GZHVQbnlBQkhTeGQveXhIWi9n?=
 =?utf-8?B?OVFXVFRkWDc3dk9raFB3SWZOWlZJZ0l0UnpKd0dRLzdqY3U2ZDZIa2dQbEg2?=
 =?utf-8?B?NDFHN2FCQzJrTis4RTZQYzBLVXFnUEJHYXRZSkxTWWp2b2M4K3ZvckszeDUr?=
 =?utf-8?B?WDhXV2hFMEVhdmhXK0sydXpYQUJ4WTZUZlBvREZxTklPaks1ZXB4akI1dWdL?=
 =?utf-8?B?Nk0ySDRVMW5laTFPZkJZRU9aVnFsRS9EcDA5cHBqdjljQWdXb1U4RldJTkNl?=
 =?utf-8?B?NGRuR0g0M3RDUlBDd2xRY3ZHbTZBTEdhcU5PZTNicWR5MUtRUEhjUXJGYytX?=
 =?utf-8?B?RjhmKzFydVJyM1NJTm5YdmFFNm9NTk44bkZlY3U1VHhHUFh5U3Urekd4WEs1?=
 =?utf-8?B?eUhaMFFmc3pBOUNjckVzdDhnSWM4QTByS0dkTDBkcG5aRnJjU0RUMGxjWGdU?=
 =?utf-8?B?WU80cU5zVXVMY084OURWaXpZMzk3THFRemRjU29VMlJsWDlZMFVWOGJXc0hq?=
 =?utf-8?B?Yi9SVW1GMTBKWjlIS3hYeEQxNlZ0U3dPT3FyZWMxTWNwNU94eXAyNE5LbERC?=
 =?utf-8?B?QW1rT0RYc3gxNHlQNkQya3NaeTVBUjgwSUF3cmE1Vnh5cFpoVVc0aitrOFZG?=
 =?utf-8?B?Y0pBczNZZE5adHdsTjh1VUgycStKUWFxZk02V0pFeHhtT2pyd3lmMXBYbHRN?=
 =?utf-8?B?MkZJYm82NTV5Mys4ZlVzbVI3Z1ZyWE1LUnpTUkw5T0k4a0NKMW9pRlRQZm4z?=
 =?utf-8?B?WVFXMW1tUW0wNkZCOW93dVFEbnBsYkVDT2M0dTJFTUZBOUphRHZ2cGY0aUh1?=
 =?utf-8?B?WmJmUlA2MUpyaE9hSWlJVXRVc05leHp5ejc5MHdQSlI3TCtBeWlFTldKQWNE?=
 =?utf-8?B?b2xpamREc0FKSkJHSlFVL3J6aHRjWVBjVlFQOW9QQzBDYW5QTEEwT2hYTXcy?=
 =?utf-8?B?MWZCeXJHSzc4OElzYUV0aWMrSWMvQ0svOFF2RUYyS1hsS3dyMXFHUlc2ZmJy?=
 =?utf-8?B?NXpKa3BzSXBpNTcwcGtxNXJVR1dzWk5jRDVySkxNVFlobjBhTDZWOVY2a3Rw?=
 =?utf-8?B?dHJCS3dHTEVNOC9GYmIrY1h2cml3Tk9mZGZmNzN1OVJTTVVUTERZQWdGQ3BV?=
 =?utf-8?B?N3dOMkNWSXBFTnRHVFFFek9EMEM2WjR3MVduVXN0WU02eUZPWGlYZEFjQVNu?=
 =?utf-8?Q?HfgMS/uOeWWUU0czs1dNmmf/nGAmxnIkOutySv9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm5SSVoyak1RSW5lM2xFSlYralRyQk5TNVRqMDUrTnlZQVBxa2daMEptclZ0?=
 =?utf-8?B?a0VaVmdhdVdhSThFTURNdFZrYnc3UmFnK3FSYzQvR1ZlK2Jid2JpVDk0Wk9H?=
 =?utf-8?B?U1VESm1hcWs2d2l3MGFRU0xrLzE3VzBMRllIV0dycTlzUTBPSWZoeGw1UE1H?=
 =?utf-8?B?VTZ4dVovT1FEeTdOY1dUVmV3MTZRS0VsR1NlMERLMkFMblc4WW1XdndaYVQ3?=
 =?utf-8?B?OVJPZDRKVmNJQk5ISEZkWmt0Y0V1U1hTb04rQ3dDd3ZLU1Fac1grY3lqZzYr?=
 =?utf-8?B?OXRkUDFkSDQ0QmJhejhIeWcxUllFVXRqM1JsRHNnMy9CeG4zUW5mblZKSU1X?=
 =?utf-8?B?ZTZyMW5tVWxHMUo5RkpqZE1YMjJNaFM4YVp5QkxXbWVSN3Q3Q0lWNEtiZHMx?=
 =?utf-8?B?Tm91d1B0NmxkUmpKcXFVR0pGQlAwd0t4cFIrT1hQek02WTE2UzhEZzZJQXZq?=
 =?utf-8?B?QmJ2bGQ2RnZTU0dmSmh5UU9DcDdrK3lCQ0MxdDVFelErcko5S1FWZEMyOWFB?=
 =?utf-8?B?NGpXdVFNakpseloxZ0Fyb0EreFF4cUFBcjFyR3VJaGJwNXo3YWlPWm1RblNz?=
 =?utf-8?B?VnFaK2J0YkcxbThjZll6Nlc0V3BYZFc3d09KRnh6V0NWS0xROFU1b0dDMDly?=
 =?utf-8?B?di9kOEF6cXV0TTMxdGlKRnJudGgxbkdZQzFWbkVNb1o4eFJZU05EN3RTd2ZQ?=
 =?utf-8?B?WkpMUzJDaFkvY0Q1Y2JjY2d5V2NiN0ZoZzJwN21OSlNNSjM0UXAvd3djU1RO?=
 =?utf-8?B?bUxlK3BMcVhCQjlrNlpPUmd1UnBXUWhWbXppRFUvbG02QjVGdktUSnZkcUdZ?=
 =?utf-8?B?K3hva283eS9aVzNGY1hOUnNOMDBwRStkV2cyVjduN1VMUzlLN3cwOFhTUXk4?=
 =?utf-8?B?OExjZ0t4MDgvREpaWC9kTTVpKzlvYjRHSWNkcTNkOC9yKytSLys1SklwWXNR?=
 =?utf-8?B?NW41YkgrVVlybTNMSmN6RFphYlNZTVpSNkFpOVB0WXBGWGFZZXFxOEZ4clBF?=
 =?utf-8?B?UmoxTFN3TGdGejJuQjBualpoN04wOTdMOXF6ZDh0dGEzbTVlRUlqY25lYzRI?=
 =?utf-8?B?Z3NlT2FMTFpaQmtnRnNzRStFVktIUTNCU0lIak8wN21xeXhTUEEwOXF1MXlH?=
 =?utf-8?B?UWNlRytQZHhPdWk2dkVNMThyYTBwRE83UXlpS0RDRWhPV3JmbnpDYTZrVmlR?=
 =?utf-8?B?bXVPWWhaN1NmOHIxK1RiZ0grM2phdGc4Vy9xUGFSMG11RTZITVJabVRqVFVv?=
 =?utf-8?B?WXF5NFRtSlViZVlmYzQyK0p1Z1ZLeHVvRFVuYzl1ZjNhTEQ5V2tIaTByRHY2?=
 =?utf-8?B?T1hTZWduSkdVcTd6ZEdQNUhYLzN6Zkh1RjBWWTZnWFVneEVMZTRPRFQyTWNz?=
 =?utf-8?B?RFpoeFo1Mmk1UUorNkJZZW9qdHlHVVJ0dUpYTWN0N0srcjNFWk9KOFcwSmJx?=
 =?utf-8?B?eFl6Tmo0cHFJZTUxbG5kQ0I4QmI3Z2ZURmFZQ2w4M0IvM244UlhNWTZmUlVQ?=
 =?utf-8?B?WGhNOTNPNUVjdnhpaU5HY1ZaWjRHSlZmYklZYjVSZ1VncW9TVjZxcGpqc1Az?=
 =?utf-8?B?TzhUYkpJUDcvR3l1bFRYZW5EN3NzUXl5TW1KNGFEL0Z0dXRBK09NNCtjdzRq?=
 =?utf-8?B?SzVPY1k4dFFwc2h2ZW95RTZhdjNDV3NUWXRseUoyWkVzMDc5M0Y0TXluQ3dm?=
 =?utf-8?B?azl6U3RjcUZKWlRJTjI1S0NzNUV5MU1wMjVvRFpVMms3Z3NkZnpDSkhSMXdG?=
 =?utf-8?B?eW1oTi9VYmoyV0RYSFpXMmh2amRFYmRiUXFyWU1rck9nOENOL2cyT2pjaW5O?=
 =?utf-8?B?aVBYZWxheFJNUmUxYlNla013T1RvSVp2cW9QRVV5TWg4UDAwNmVEVWdGWCsy?=
 =?utf-8?B?dGpuNmpnSWtneUFldkFXWGVGQTBwQmhJeVFuelRDNVF2c2g0cFladHNNK2Zm?=
 =?utf-8?B?TjFCT2xsMDdZSzF4L0U5U3JQV2tFbkZjWmI5M1JnejVvcDJtNUxONE0wdzJk?=
 =?utf-8?B?VytwcWlNZDl1OUlxODRreVRNcjJGMUtNTldORDFNNWc4T2lRQ2dTT1F2NmlD?=
 =?utf-8?B?bFZPZmMxQ1RuOCt6aEZaMldUQW5kazFVamE5TW5BcUZLb0tMVm5xSlN3dk1s?=
 =?utf-8?Q?iYuQs6806L/N8iOah8Lf28VY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a6ca4d-5774-45db-ea0f-08dcff708034
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 21:09:43.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umyx3fFeg2b4r8ew4RSbcCYe6qEiNgVO4VrPUNVKByLDuBsEytCFxXI3rXb+YI/LWu97SSwb6wZpc5KXF4mCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

On 11/7/2024 02:16, Armin Wolf wrote:
> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
> 
>> When registering a platform profile handler create a class device
>> that will allow changing a single platform profile handler.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v5:
>>   * Use ida instead of idr
>>   * Use device_unregister instead of device_destroy()
>>   * MKDEV (0, 0)
>> ---
>>   drivers/acpi/platform_profile.c  | 50 +++++++++++++++++++++++++++++---
>>   include/linux/platform_profile.h |  2 ++
>>   2 files changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index 0450bdae7c88b..652034b71ee9b 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/acpi.h>
>>   #include <linux/bits.h>
>>   #include <linux/init.h>
>> +#include <linux/kdev_t.h>
>>   #include <linux/mutex.h>
>>   #include <linux/platform_profile.h>
>>   #include <linux/sysfs.h>
>> @@ -22,6 +23,12 @@ static const char * const profile_names[] = {
>>   };
>>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>>
>> +static DEFINE_IDA(platform_profile_ida);
>> +
>> +static const struct class platform_profile_class = {
>> +    .name = "platform-profile",
>> +};
>> +
>>   static ssize_t platform_profile_choices_show(struct device *dev,
>>                       struct device_attribute *attr,
>>                       char *buf)
>> @@ -113,6 +120,8 @@ void platform_profile_notify(void)
>>   {
>>       if (!cur_profile)
>>           return;
>> +    if (!class_is_registered(&platform_profile_class))
>> +        return;
>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>> @@ -123,6 +132,9 @@ int platform_profile_cycle(void)
>>       enum platform_profile_option next;
>>       int err;
>>
>> +    if (!class_is_registered(&platform_profile_class))
>> +        return -ENODEV;
>> +
>>       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>           if (!cur_profile)
>>               return -ENODEV;
>> @@ -163,20 +175,50 @@ int platform_profile_register(struct 
>> platform_profile_handler *pprof)
>>       if (cur_profile)
>>           return -EEXIST;
>>
>> -    err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> -    if (err)
>> -        return err;
>> +    if (!class_is_registered(&platform_profile_class)) {
>> +        /* class for individual handlers */
>> +        err = class_register(&platform_profile_class);
>> +        if (err)
>> +            return err;
>> +        /* legacy sysfs files */
>> +        err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +        if (err)
>> +            goto cleanup_class;
>> +    }
>> +
>> +    /* create class interface for individual handler */
>> +    pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
> 
> Missing error handling.

Ack.

> 
>> +    pprof->class_dev = device_create(&platform_profile_class, NULL,
>> +                     MKDEV(0, 0), NULL, "platform-profile-%d",
>> +                     pprof->minor);
> 
> Two things:
> 
> 1. Please allow drivers to pass in their struct device so the resulting 
> class device
> has a parent device. This would allow userspace applications to 
> determine which device
> handles which platform profile device. This parameter is optional and 
> can be NULL.
> 

I previously did this indirectly by letting them set it in the
"struct platform_profile_handler *pprof" and then used that value.

You had said that wasn't necessary so I dropped that patch.  I would 
rather go back to including that then having another argument to 
platform_profile_register().

> 2. Please use the fourth argument of device_create() instead of 
> dev_set_drvdata().

OK.

> 
> Thanks,
> Armin Wolf
> 
>> +    if (IS_ERR(pprof->class_dev)) {
>> +        err = PTR_ERR(pprof->class_dev);
>> +        goto cleanup_ida;
>> +    }
>> +    dev_set_drvdata(pprof->class_dev, pprof);
>>
>>       cur_profile = pprof;
>>       return 0;
>> +
>> +cleanup_ida:
>> +    ida_free(&platform_profile_ida, pprof->minor);
>> +
>> +cleanup_class:
>> +    class_unregister(&platform_profile_class);
>> +
>> +    return err;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_register);
>>
>>   int platform_profile_remove(struct platform_profile_handler *pprof)
>>   {
>> +    int id;
>>       guard(mutex)(&profile_lock);
>>
>> -    sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +    id = pprof->minor;
>> +    device_unregister(pprof->class_dev);
>> +    ida_free(&platform_profile_ida, id);
>> +
>>       cur_profile = NULL;
>>       return 0;
>>   }
>> diff --git a/include/linux/platform_profile.h b/include/linux/ 
>> platform_profile.h
>> index 58279b76d740e..d92a035e6ba6a 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -28,6 +28,8 @@ enum platform_profile_option {
>>
>>   struct platform_profile_handler {
>>       const char *name;
>> +    struct device *class_dev;
>> +    int minor;
>>       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>       int (*profile_get)(struct platform_profile_handler *pprof,
>>                   enum platform_profile_option *profile);


