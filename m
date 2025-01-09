Return-Path: <linux-acpi+bounces-10473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB6A07D9F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80153A20AB
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BA223315;
	Thu,  9 Jan 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wZapW/WQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220621C176;
	Thu,  9 Jan 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440369; cv=fail; b=RxfxlGFlnVJZjfXLp4DaRsiFZCn1200BeLqjgdfAWHvLCvXSMlgzKp2oK4eTDxjKIOohNaRAWZRdWfIqPre5yXfQoPDG4W9uHoqPnhVBEca4tbc53qKO10Opzed490O00vvOw+eTIBfBk5s2Z3cz+Ha9b3Jf4x7pYECzC+er7SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440369; c=relaxed/simple;
	bh=ZZVJphErQryXwvpNpuo9egQC6YDvQ3uBMhbUguTbYwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bii3JUMSK0+eRsZLfsonIjBDmbeyakLfkfqLwwCErH+2pCECqhTQxqLkWURIHLfmrBuNqRplz2mChkdQi4VDDg3zofJoXR35FDGfBGLazrjr7t8O7o9bF4MS9D84wfcna3w3eW18FjgMKbXwlgWP/4K9RgxIEtkhCuBHKP0s0WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wZapW/WQ; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5EkCoRiAYO7dK5l/eJ6+oiXcTdqWePW4fSYDtE1ur1V9MspVc7h7v89JWQGxA4aKu9gCSr+o10DgwtnnpOhmASZvLTmS/9sWcZDMS+VURvtjpDGjm2/ewXLrsRssh/hBCUvCa+I2p3q+1EcfHW8kr7K2vPw5Zm+Swos+r+xUjtAXvew83hZx3lsE5N+KkQf7LyglvrgmWui+ytbrj0OReughrHGvAJPzaPpnHOzhnyVCb01zfjgiWVk/yP6Z0pgWBf5YRHd7295iH8SLlaIZYAub8Qaex9W0zV/z1tQwheuRKJrbTIfpsqV8HtaGntWiK4t3t2Eq8GuR2qcLW5OBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrbPrzsrrCQu74ovTI/g97YiagZMytW8o0oXiLTyrH0=;
 b=n5ci9QX2zqFsb2feV+JMOyETggC4oUVYLm7Jwxz32J8/4/EmNsj7mU6FgBSHBRbFegvcZKZrrU8UckvoDbO+p26GW/fpbkXGJnxshnudEPSV6NU6P5ow86oLWocH0LwTog+Z1mX7xJm2IkARwuk/DVjyKy1i7OWFshLhzDadIsE18kLJrM4FKZHFZkLJe0xSWGy3V7yVzeAimQb0af3xLnR8Y/npMuubD1dfUwrSY/Wzp6Mn5oBqYZCuv9nFdaqdWYkX0xsR9Pqn5BSPM0/SckBICZbuSB4woqQCKkeUqxLk44UZ0AGrAY+3v4vAfGzAT3A2ez/Vwv9ahJRLWn4DxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrbPrzsrrCQu74ovTI/g97YiagZMytW8o0oXiLTyrH0=;
 b=wZapW/WQJ5Qb6nkm1qxnF5di7Q2rP33pRjwHMi7wCDklAA7Hh7HHsZ2bGtpHrHOJ4SEkeruwZxDV+u9nECo04Pf5EQvtgdzYbluw27TPUnMfjf/R5kGQUpFfEy9c9wA1ZLihvG9OCZ2c8pywLcXxa+pTvJNm/HkgTZ1Mh/es70g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:32:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:32:44 +0000
Message-ID: <8de631a8-f2fb-468f-810e-65226dda5e69@amd.com>
Date: Thu, 9 Jan 2025 10:32:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] ACPI: platform_profile: Add `ops` member to
 handlers
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-2-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 6402476b-6aa1-4303-15f0-08dd30cb3ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkY0TUxVQlBFSklWbzYvYm1iY0w1K2I3c25jOXF5T3Bmbm50NCthYVhnVXd1?=
 =?utf-8?B?Wk85VlNMNmxXbnQvZGRjbUQ5TkUwVWR0QmVkVGR2YmVMbG9YdldQSnlpMmta?=
 =?utf-8?B?MHFJYUYwVm40cEVUSDkxWlp4MG1Xb3JKSFliY0pUeGxISzRQalU0QWFyeU1S?=
 =?utf-8?B?UldvakdxUWtINm1kcGZ4c3B4Tkd3MVFVaWs5Zm0xMGpPWEJIeWV2SnlpSTdm?=
 =?utf-8?B?eWZYNzhYZFpmdWNmY3J5azhsczVCNzZ4bXdaNGY2MXdSTGVEZ3RyOTFva0pF?=
 =?utf-8?B?STBuYjJrR3ZuMi9rZWE5NEJJR0NpSUIrL1BrVGtZTzJBNWNGOFk0KzhuamVi?=
 =?utf-8?B?RndLbHBiY3dSWEhRQkdjeXU1a2hLV2RYRCs4U0NsemcvVDg5R0JuYm04bE5m?=
 =?utf-8?B?ZGxmVUxTVU1lVFdGcHFjZGUwUzQvQ0U0NC9KZHpQcnN4WWpDaTRDMlVmSWxM?=
 =?utf-8?B?R1Jsc29EaU00Y3JDUkkwVWZIVzlLM0lWakhwOTJrMXlzeFNseHZYV3ZxTjRm?=
 =?utf-8?B?Vk5vaWEyOGd2anVUcDZ3TjVlZFNGWTJJb2toeG5IT1QwNWlOUTdXZWgvVXFH?=
 =?utf-8?B?RkZIUXE0QUkyM0lRcGVNSlB2TEZuWmlZV3dhbFdWVUYxZ2tJZHZyNThjblRQ?=
 =?utf-8?B?S3k4OUpBY21uL0JsdUlxSEZyUlN6aXg2SnFNWS90K3NQQW5YV1NmSHcvV3ls?=
 =?utf-8?B?bUdjWGZHK09vWmhMd2Ezc1N5bnJuSEZsa0R3aVlLdXlEbElXdmVxOGFKZmR2?=
 =?utf-8?B?aElCN2xUOEJiZkJlYkRLWDN4b1grVW9iL0c5c2NVYlJ4UVk4Si90YUhxSVUy?=
 =?utf-8?B?OFdHYzBTQ0FDY1krdkVRaFVuOU1BTHVhcUZxMlFhTW5iNVpLOGNvSFlQbXNC?=
 =?utf-8?B?WWlrSkhzdmwxWjh0eXU3WjVuMmsxNWF2Z25rUjhNZ2VPMXY1Z20wWEtEeE5V?=
 =?utf-8?B?Z0dQZ20yU2c1RWxiM0RnSnBkYmhNVlQyWkFzU3phTkpja0ErR2JRcTBqQWFR?=
 =?utf-8?B?Y3daMkJsdGdUZWJFY0pXd2ZaQ1dhbWRrcDF1UVR1QnMrTDU4YXQraVBSNXBG?=
 =?utf-8?B?NmIrRCtuZzB0RFNyUkUwajdBVGtpRzZva0tjU21xMzZYVFNrUERVQmlRN04r?=
 =?utf-8?B?ZmdBdUg4cTVrWGpwNEk5bmpSc3p2a1hZMkdhb3hWY1dmU2xUZDN3U1hoazly?=
 =?utf-8?B?NlpkSFN5VVNDL3VjZ0NPTURWbEIzUStBVWVSMnN4NGFFaTlrS01BQnlyeFAv?=
 =?utf-8?B?eG1qNmtLUGxYRm16T3M2cFhOVHNQa09KUEJDME1iY0JGU2RIcnJPbDVHZnRG?=
 =?utf-8?B?ajRGZXVXcXduZGt3TnUzT2ZrN2dKVDNUejd0QUFjd0V0L2hUYnh3NEpWNFVw?=
 =?utf-8?B?djJmTTFXY0VYR0Y3YnE1VEMvQUtCb2svY2paV3pBMlNmTnBmTmdUNEliSjBu?=
 =?utf-8?B?UmVNTFBWYURETWh5bmlFOTB4WDlOWi84UWhlNXBMd1RaNm1vV0YvK29MT1Vl?=
 =?utf-8?B?Tk1JQVhYdE1jTHVheDRwK3V4WlBVUTE2ZHJNWHo1TnpuUmFtSHJXLzJVN0ds?=
 =?utf-8?B?b2NCVVFtWCtTZEhZREpIbEwzLzJqNkRIMnVXaEhaN0ltakZOUTgrU1l0RXVp?=
 =?utf-8?B?RUhPSjFhS1NKc0ZjV0ZlN3lLdU1HV1VzNmNnNzRJV1pLdHNWb2dFOEpIYWlS?=
 =?utf-8?B?MHd5RVFOZFVhSW0rY0dGOG1STzFNc3V5SGwwMFQ4ZzdNdTIzS1RMVExvMmd6?=
 =?utf-8?B?b3BpNjhGazhob28wbTE4WStLVmZkZ05iZzVGOUdGSVlySlFFalJRNytFU0tt?=
 =?utf-8?B?S0pYZlNUbi9lQjNUQ0x4Tk5hVllEbVMwdzBHNVZhMzdMVGFadXlpUEliM3dt?=
 =?utf-8?Q?V4s58FzUm//Qu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXA1WVRDekN2eVhzWTFFUGZIWjlOWGVaQVUyQ2ZxNjQxa0kvMDJUTEl4MHJl?=
 =?utf-8?B?enliTHEyUEFIWlI1QUd0OUhxTXZmVHZmRUhldlVkUUlCWmhyejhjZkxJNDhJ?=
 =?utf-8?B?OWkydE5ENEtadC9pbDR6VDZONWdOODkvOWVKNDJxd2NhU05zQmQxNHppV2hj?=
 =?utf-8?B?SS8zU0tDeEVJM2pMWjQzdXh6WVB0azdVaEZwaWJ2bndGMEo2VUxkcEhROXAw?=
 =?utf-8?B?UW9jNW85SWd1L2I4KzNQenl1OFZKMEw3STg4OVp5TDNQOEp4NW9EdHZnanZw?=
 =?utf-8?B?SS9OdkxUMDBGL0hZZ2pQa3ppQXI4SlVraml0eWtCU0ZqRjNnUU1nNHpzeWcw?=
 =?utf-8?B?cEVyRDI3RHNVcFFDTHhMeGJqV3VrSHRlL1VZd0dOcjJFQjBZTnZXbUpOdFJo?=
 =?utf-8?B?RW1zaUJLaGZjV2FwWTVXdFF5NzluNmNURk1aZzNTaGVGb0NRc0pQZ2srakty?=
 =?utf-8?B?bitDYmR1dytqSXE5dWx4eVB3UHpHT05CUkFmU1lLSmxDcHpEQnZzMEhnT3RT?=
 =?utf-8?B?WW4wR1pRUE15WHdjQ3NLQTlndzRjL0hzeXdHR0tkc1JSMTVBNDhXenVzTmZ0?=
 =?utf-8?B?d2N0S2pyVW81bzIvQjZ3ejY1SThMaUpMbDZSZ3BUa293OVpmZ0Rqd3Z0enpp?=
 =?utf-8?B?OFN6TU5wQlJvd1BXa0JXUUxPcGJ2eGcxdjA2M24zS0VncVVxcmV4dVN2YWRV?=
 =?utf-8?B?SjU3RzY3c0xqaXkxU3JweWUzY1ZxbjdrelVsSUorZWFDUmFtSkwyZEVCWmFR?=
 =?utf-8?B?eWo5alRtajNiUVhuYmdERmQ3ZnJLV2pQLzByL29LQ0xiYXZtbXYrdk5Za1ho?=
 =?utf-8?B?dUtjSVBkeENXRXloY0dBUFllMEFyOGRZYXNpYjJJalAzQlFCVnRhd0l6WEFm?=
 =?utf-8?B?dTNqNERnZmpVR1BWUlJ1b3JLR2RRSzVLdGtha1lJWXdqR2NLbDBhQW1LZEhV?=
 =?utf-8?B?cHhGTk02UTc0R0E1YkRTazVBZ3lKc3FoZ2FUUHJCaFptODdEeFgzYm5jRmw2?=
 =?utf-8?B?eGphYlBUV0NQdEFHd2JNSXd4Z1VzOWs2bWg3TlAwUU5iZE1wOEljVmxkeCs4?=
 =?utf-8?B?eGJQUXluejYwYkVUcHFGRGVtVjhrME9vVXlmUGltVWZzUnVTakp6WVl2QmRQ?=
 =?utf-8?B?Z0hqTk85YjNmSXlRZWF3MmdVT1p0Y2x1WmZsQUFmMDZIZ05yWkZWeHBUdk5N?=
 =?utf-8?B?SWMrSmx5ZXZYZzRPUHFndTVtMjVLSUNORm44UmdndGxpcnY1K2thT0JSR1dW?=
 =?utf-8?B?TUVVYUgxWXRhOXIzOG9ScnhUVW54SGpDMUMwT3dlN2ZjclhBVFUvL1lJRXlO?=
 =?utf-8?B?RUpvcHZwczI3ZE5OM3JLdS9Qb0VuWFB3TldKcEdIaFlXblZuamFEUG10dVJu?=
 =?utf-8?B?bGdyUUsvL20wTWRQd3VLbS9heXdQSFJ5alAyYWYwTzBxWXE4WUF2a1J3V1Vn?=
 =?utf-8?B?alIxRTAvcndXakRrNkxSZnJOTHdZNXVScUpUWTdMM0lDOXFKR29lc09MelIw?=
 =?utf-8?B?WGtPSVExOTFnMm1hbHBUeDBXL0N1TDNramE2YWkraDIyd2ZTd1ErRTdmTzBE?=
 =?utf-8?B?N3hiWVF1K2FOcXRKbmdEZ2VLVUNQNk1jRFZ2Rk9nVG5LK0NkT3hLb2Y4LzNQ?=
 =?utf-8?B?RDNCd0Y5OTFVYnQwcFJIK2VNNjl4NHZkQmdmSkVmUDdPUy9KQm10ZE9yYTNm?=
 =?utf-8?B?VHRvTC9IZUlGcTZMbzdqMlFjMlN1bFZMZ2RUbVB1V3JlbE9Bd2ZPTjNaOWFa?=
 =?utf-8?B?d3dRdGVmandKM3dLd0FaK1pOY0lCbmlXWTFIaE90NXVXUVdzbFFZeWdIZllL?=
 =?utf-8?B?c3VwNkZTOW9wQ0FMRGJ4RURZeEdvT2VrU3VSNXFxK3ZrcFJNZlJFQTkyYUZw?=
 =?utf-8?B?TlhEdHlKc0tNOXV3cDJBamNha0QwbTR1VUYwOC9VZC9TenlLWnU2bmdtcGhT?=
 =?utf-8?B?aFlmVkcxdXYrbE84V3NleXZ2UHBSeGxjQlk3YlhBUWt4YjEwazZEMzNzeTVv?=
 =?utf-8?B?VkNQY1MvenVKV1hsaXM2dk5YUGw3azZiWHdqOFFFeEhkSy9KMkREMEtObHMx?=
 =?utf-8?B?aC9EbGdyYllGL0dCNWhyN3FxYUw0SVhhUWxabE90OEw5RjNUQXlXZzloT3lo?=
 =?utf-8?Q?aFxoSO6lG+jWxvtJHMTp1Zu1J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6402476b-6aa1-4303-15f0-08dd30cb3ed5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:32:44.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndle2jmRrzTNEUgR1Yl8hwMnrEWLTM3pz5i/9vV0HMyAvQjscn9B3DWY3xa9PHdYkqvSt85se+UWY3+3Qo4Cfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace *profile_get and *profile_set members with a general *ops
> member.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c               |  6 ++---
>   .../surface/surface_platform_profile.c        |  8 +++++--
>   drivers/platform/x86/acer-wmi.c               | 11 +++++----
>   drivers/platform/x86/amd/pmf/sps.c            |  8 +++++--
>   drivers/platform/x86/asus-wmi.c               |  8 +++++--
>   drivers/platform/x86/dell/alienware-wmi.c     |  8 +++++--
>   drivers/platform/x86/dell/dell-pc.c           |  8 +++++--
>   drivers/platform/x86/hp/hp-wmi.c              | 24 ++++++++++++++-----
>   drivers/platform/x86/ideapad-laptop.c         |  8 +++++--
>   .../platform/x86/inspur_platform_profile.c    |  8 +++++--
>   drivers/platform/x86/thinkpad_acpi.c          |  8 +++++--
>   include/linux/platform_profile.h              | 14 +++++++----
>   12 files changed, 86 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 4c4200a0b1a6..39a22e27acc5 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -64,7 +64,7 @@ static int _store_class_profile(struct device *dev, void *data)
>   	if (!test_bit(*bit, handler->choices))
>   		return -EOPNOTSUPP;
>   
> -	return handler->profile_set(handler, *bit);
> +	return handler->ops->profile_set(handler, *bit);
>   }
>   
>   /**
> @@ -101,7 +101,7 @@ static int get_class_profile(struct device *dev,
>   
>   	lockdep_assert_held(&profile_lock);
>   	handler = dev_get_drvdata(dev);
> -	err = handler->profile_get(handler, &val);
> +	err = handler->ops->profile_get(handler, &val);
>   	if (err) {
>   		pr_err("Failed to get profile for handler %s\n", handler->name);
>   		return err;
> @@ -465,7 +465,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   
>   	/* Sanity check the profile handler */
>   	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
> -	    !pprof->profile_set || !pprof->profile_get) {
> +	    !pprof->ops->profile_set || !pprof->ops->profile_get) {
>   		pr_err("platform_profile: handler is invalid\n");
>   		return -EINVAL;
>   	}
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 6c87e982bfc8..2a9716372d56 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -201,6 +201,11 @@ static int ssam_platform_profile_set(struct platform_profile_handler *pprof,
>   	return tp;
>   }
>   
> +static const struct platform_profile_ops ssam_platform_profile_ops = {
> +	.profile_get = ssam_platform_profile_get,
> +	.profile_set = ssam_platform_profile_set,
> +};
> +
>   static int surface_platform_profile_probe(struct ssam_device *sdev)
>   {
>   	struct ssam_platform_profile_device *tpd;
> @@ -214,8 +219,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->handler.name = "Surface Platform Profile";
>   	tpd->handler.dev = &sdev->dev;
> -	tpd->handler.profile_get = ssam_platform_profile_get;
> -	tpd->handler.profile_set = ssam_platform_profile_set;
> +	tpd->handler.ops = &ssam_platform_profile_ops;
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index b3043d78a7b3..ac7b3ab8fd2a 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1900,6 +1900,11 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops acer_predator_v4_platform_profile_ops = {
> +	.profile_get = acer_predator_v4_platform_profile_get,
> +	.profile_set = acer_predator_v4_platform_profile_set,
> +};
> +
>   static int acer_platform_profile_setup(struct platform_device *device)
>   {
>   	if (quirks->predator_v4) {
> @@ -1907,10 +1912,8 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   
>   		platform_profile_handler.name = "acer-wmi";
>   		platform_profile_handler.dev = &device->dev;
> -		platform_profile_handler.profile_get =
> -			acer_predator_v4_platform_profile_get;
> -		platform_profile_handler.profile_set =
> -			acer_predator_v4_platform_profile_set;
> +		platform_profile_handler.ops =
> +			&acer_predator_v4_platform_profile_ops;
>   
>   		set_bit(PLATFORM_PROFILE_PERFORMANCE,
>   			platform_profile_handler.choices);
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index bd2bd6cfc39a..7c8391ac4dbb 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -387,6 +387,11 @@ static int amd_pmf_profile_set(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops amd_pmf_profile_ops = {
> +	.profile_get = amd_pmf_profile_get,
> +	.profile_set = amd_pmf_profile_set,
> +};
> +
>   int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   {
>   	int err;
> @@ -407,8 +412,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>   
>   	dev->pprof.name = "amd-pmf";
>   	dev->pprof.dev = dev->dev;
> -	dev->pprof.profile_get = amd_pmf_profile_get;
> -	dev->pprof.profile_set = amd_pmf_profile_set;
> +	dev->pprof.ops = &amd_pmf_profile_ops;
>   
>   	/* Setup supported modes */
>   	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index fdeebab96fc0..ef4129d91656 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3852,6 +3852,11 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>   	return throttle_thermal_policy_write(asus);
>   }
>   
> +static const struct platform_profile_ops asus_wmi_platform_profile_ops = {
> +	.profile_get = asus_wmi_platform_profile_get,
> +	.profile_set = asus_wmi_platform_profile_set,
> +};
> +
>   static int platform_profile_setup(struct asus_wmi *asus)
>   {
>   	struct device *dev = &asus->platform_device->dev;
> @@ -3878,8 +3883,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
>   
>   	asus->platform_profile_handler.name = "asus-wmi";
>   	asus->platform_profile_handler.dev = dev;
> -	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
> -	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
> +	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
>   
>   	set_bit(PLATFORM_PROFILE_QUIET, asus->platform_profile_handler.choices);
>   	set_bit(PLATFORM_PROFILE_BALANCED,
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index 7b3ee2d6a23d..c824414565b6 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1108,6 +1108,11 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
>   	return wmax_thermal_control(supported_thermal_profiles[profile]);
>   }
>   
> +static const struct platform_profile_ops awcc_platform_profile_ops = {
> +	.profile_get = thermal_profile_get,
> +	.profile_set = thermal_profile_set,
> +};
> +
>   static int create_thermal_profile(struct platform_device *platform_device)
>   {
>   	u32 out_data;
> @@ -1154,10 +1159,9 @@ static int create_thermal_profile(struct platform_device *platform_device)
>   		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
>   	}
>   
> -	pp_handler.profile_get = thermal_profile_get;
> -	pp_handler.profile_set = thermal_profile_set;
>   	pp_handler.name = "alienware-wmi";
>   	pp_handler.dev = &platform_device->dev;
> +	pp_handler.ops = &awcc_platform_profile_ops;
>   
>   	return devm_platform_profile_register(&pp_handler);
>   }
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
> index 3797a5721dbd..1751b7235031 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -231,6 +231,11 @@ static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops dell_pc_platform_profile_ops = {
> +	.profile_get = thermal_platform_profile_get,
> +	.profile_set = thermal_platform_profile_set,
> +};
> +
>   static int thermal_init(void)
>   {
>   	int ret;
> @@ -258,8 +263,7 @@ static int thermal_init(void)
>   	}
>   	thermal_handler->name = "dell-pc";
>   	thermal_handler->dev = &platform_device->dev;
> -	thermal_handler->profile_get = thermal_platform_profile_get;
> -	thermal_handler->profile_set = thermal_platform_profile_set;
> +	thermal_handler->ops = &dell_pc_platform_profile_ops;
>   
>   	if (supported_modes & DELL_QUIET)
>   		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 6d6e13a0c6e2..c37e44f7606c 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -1565,6 +1565,21 @@ static inline void omen_unregister_powersource_event_handler(void)
>   	unregister_acpi_notifier(&platform_power_source_nb);
>   }
>   
> +static const struct platform_profile_ops platform_profile_omen_ops = {
> +	.profile_get = platform_profile_omen_get,
> +	.profile_set = platform_profile_omen_set,
> +};
> +
> +static const struct platform_profile_ops platform_profile_victus_ops = {
> +	.profile_get = platform_profile_victus_get,
> +	.profile_set = platform_profile_victus_set,
> +};
> +
> +static const struct platform_profile_ops hp_wmi_platform_profile_ops = {
> +	.profile_get = hp_wmi_platform_profile_get,
> +	.profile_set = hp_wmi_platform_profile_set,
> +};
> +
>   static int thermal_profile_setup(struct platform_device *device)
>   {
>   	int err, tp;
> @@ -1582,8 +1597,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.profile_get = platform_profile_omen_get;
> -		platform_profile_handler.profile_set = platform_profile_omen_set;
> +		platform_profile_handler.ops = &platform_profile_omen_ops;
>   
>   		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>   	} else if (is_victus_thermal_profile()) {
> @@ -1599,8 +1613,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err < 0)
>   			return err;
>   
> -		platform_profile_handler.profile_get = platform_profile_victus_get;
> -		platform_profile_handler.profile_set = platform_profile_victus_set;
> +		platform_profile_handler.ops = &platform_profile_victus_ops;
>   
>   		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>   	} else {
> @@ -1617,8 +1630,7 @@ static int thermal_profile_setup(struct platform_device *device)
>   		if (err)
>   			return err;
>   
> -		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
> -		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
> +		platform_profile_handler.ops = &hp_wmi_platform_profile_ops;
>   
>   		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>   		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index dc98f862a06d..b49ee94f9bee 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1063,6 +1063,11 @@ static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>   	{}
>   };
>   
> +static const struct platform_profile_ops dytc_profile_ops = {
> +	.profile_get = dytc_profile_get,
> +	.profile_set = dytc_profile_set,
> +};
> +
>   static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   {
>   	int err, dytc_version;
> @@ -1105,8 +1110,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
>   	priv->dytc->pprof.name = "ideapad-laptop";
>   	priv->dytc->pprof.dev = &priv->platform_device->dev;
>   	priv->dytc->priv = priv;
> -	priv->dytc->pprof.profile_get = dytc_profile_get;
> -	priv->dytc->pprof.profile_set = dytc_profile_set;
> +	priv->dytc->pprof.ops = &dytc_profile_ops;
>   
>   	/* Setup supported modes */
>   	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->dytc->pprof.choices);
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 53af73a7fbf7..38d4745f6be1 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -166,6 +166,11 @@ static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
>   	return 0;
>   }
>   
> +static const struct platform_profile_ops inspur_platform_profile_ops = {
> +	.profile_get = inspur_platform_profile_get,
> +	.profile_set = inspur_platform_profile_set,
> +};
> +
>   static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   {
>   	struct inspur_wmi_priv *priv;
> @@ -179,8 +184,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
>   
>   	priv->handler.name = "inspur-wmi";
>   	priv->handler.dev = &wdev->dev;
> -	priv->handler.profile_get = inspur_platform_profile_get;
> -	priv->handler.profile_set = inspur_platform_profile_set;
> +	priv->handler.ops = &inspur_platform_profile_ops;
>   
>   	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
>   	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index f51662861738..04a292af2bfc 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10538,12 +10538,16 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>   	return err;
>   }
>   
> -static struct platform_profile_handler dytc_profile = {
> -	.name = "thinkpad-acpi",
> +static const struct platform_profile_ops dytc_profile_ops = {
>   	.profile_get = dytc_profile_get,
>   	.profile_set = dytc_profile_set,
>   };
>   
> +static struct platform_profile_handler dytc_profile = {
> +	.name = "thinkpad-acpi",
> +	.ops = &dytc_profile_ops,
> +};
> +
>   static void dytc_profile_refresh(void)
>   {
>   	enum platform_profile_option profile;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index f1cd4b65e351..a9db95bc360d 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -27,16 +27,22 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };
>   
> +struct platform_profile_handler;
> +
> +struct platform_profile_ops {
> +	int (*profile_get)(struct platform_profile_handler *pprof,
> +				enum platform_profile_option *profile);
> +	int (*profile_set)(struct platform_profile_handler *pprof,
> +				enum platform_profile_option profile);
> +};
> +
>   struct platform_profile_handler {
>   	const char *name;
>   	struct device *dev;
>   	struct device *class_dev;
>   	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> -	int (*profile_get)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option *profile);
> -	int (*profile_set)(struct platform_profile_handler *pprof,
> -				enum platform_profile_option profile);
> +	const struct platform_profile_ops *ops;
>   };
>   
>   int platform_profile_register(struct platform_profile_handler *pprof);


