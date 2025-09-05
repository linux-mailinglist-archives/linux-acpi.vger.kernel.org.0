Return-Path: <linux-acpi+bounces-16430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BCBB463C6
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 21:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B7D7B6C4D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 19:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1A27BF80;
	Fri,  5 Sep 2025 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DU4YSaY4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D6HrjWZ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25A221577
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101191; cv=fail; b=SxaFZb0Dwa2Jro5sALbA+fGoj67Zv6owX9yVVspljlPIuaEiY9ZLJ4ZJ9sCMxTLtJ7ri3XfmY8t6w9xsFoQOFkH4Ylo/ZNyHRnWweiXx+iDAyQVbddf+HsWeHm3GZKwOxxm7GIwHcjKDNMyHWmKy25hLD61sv50hmPs8BwuM4GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101191; c=relaxed/simple;
	bh=wCtgKh0m3q6Y8Tql7TBPSqiLQfE5OsAVJllBZBC91gE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WFSc9EJzNalv7BvzkNBhhh7oTag0O+/DWm8Keo1Z8mWyktO09Cek2PrKtN0mtN5jt0fj34nVlV+tucdwomZXxduY1DzmT2Tm/1KXFtRgKuY4ZHpQ1reBjRK1pIAQ4x9hPcwpM0m51iH5a6baGGuPwiAuBenO3BxkEd2M1NZurSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DU4YSaY4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D6HrjWZ5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585HsnWB004127;
	Fri, 5 Sep 2025 19:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W4kfmOxThhUxJ9BS6ZtYaeyV09u0+mAnJ1oOKaOD6bs=; b=
	DU4YSaY4N3BYjixNUMsYgTwOWpFQWzRFlGxuu73kUlNs3DKFaLKqmXKW5j8K/e/t
	WdMjxOLtcggo/2Yz7QmQ2eKWLA1VC8CThj+DOlSlX5m+/3wNLCXpxw3xBL8zF62f
	Rll2mO2KFgH2BsKkRqHWHUtNAWZOm1PbFYwqemjzlzv7lEWpklSWKZ1cTuJ2jNm0
	5ny+PUtydoU0QRSRHpoHvQAIr8HieujBVaIeifA4bKmvILxZoc2OuzknsxmfJVOI
	6KcsbYMHxLlra0Lu4SeTBaRMLMTZPPTlzrjmzULFf24au8A8G4JkZoC/9nxwN+1a
	gBJQBwLtjADMf5tJrNKpyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4904p406b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 19:39:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585JE1Fq031814;
	Fri, 5 Sep 2025 19:39:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrknc4y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 19:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqOUk3JCSj323RnyP3dyJn7NL1rbESOj77NA3fAkX3597t6dDJZCUh8a0LDTP86uqyl7LZmVcj2HmxacNUNEtkgi1LQ5X0ed39SRtacLCK+qjU8X3xJJXOUrAhZVrGMCc+2jY8rydvdl01lucDm4C+3lwhzfvYgKvKKlO4RARslYGV+yQKcBFcKr9nPxaT1R8EhlURjgKQaqvymEKTFHvpWyDnMJ+KrSdK3yQzmUrPmTKPzMW8lKWY9p6iwtuBm5OytujrK+bzuVs8hdsip6TkPOPwJtj64kG00XvzBaf7CYI8Q99eCXSaqhVhksDXFows130UQtOkpap4q/WgHCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4kfmOxThhUxJ9BS6ZtYaeyV09u0+mAnJ1oOKaOD6bs=;
 b=jvAw7sNzfD8Uk0O9f9FROs3aWGA0h9Q4R1+PHcqvslGTxpVujlts/HX4qZeTwZeL34DUo1p0EQJE0y8Fmhm5GaS/chIhb6HWpMwChOM2O536V86W2Pq0S1Y+Kjh2Le/lYfL6ZNdXYWk3bFpe2u1PRSvUb0huE25ynBod6dOvC3VNNo0nN2wSB5IXU7vGvD1cpKWrqYmg335qMCnW/LwrhTsXtVivkAwJ36NrXRlUErbAeUNJWsi0XKALQzWNqKX/ppoRFxoNtmaQ8OI57PPYzAPjWAhVsSMQkO4yhN4n77CI3sG0g7iSDWOzsD+8uMV/MGwQre49JFNHkEhSqdBeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4kfmOxThhUxJ9BS6ZtYaeyV09u0+mAnJ1oOKaOD6bs=;
 b=D6HrjWZ5dSPU57xH/zz7QftTwQipPT1CtRm3+0U889QYhzxYu/6D34sboD6+wlVp79IFom2218M8t93bzy35Bp7vvNOrCqSWfMsIm0xXMzaRZqIMOl/vBmOR+UK7/YzK9F//Ek9oV78OD2ZJfQxz+EYdfymPWFMAbIZfOD3egqc=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Fri, 5 Sep 2025 19:39:11 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 19:39:11 +0000
Message-ID: <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
Date: Fri, 5 Sep 2025 12:39:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
To: "Luck, Tony" <tony.luck@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, surenb@google.com,
        "Anderson, Russ" <russ.anderson@hpe.com>, rppt@kernel.org,
        osalvador@suse.de, nao.horiguchi@gmail.com, mhocko@suse.com,
        lorenzo.stoakes@oracle.com, linmiaohe@huawei.com, jiaqiyan@google.com,
        david@redhat.com, bp@alien8.de, "Meyer, Kyle" <kyle.meyer@hpe.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
        linux-acpi@vger.kernel.org, Shawn Fan <shawn.fan@intel.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <aLspJ5Tpqp4qRDk2@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::10) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DS7PR10MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 815419c7-db33-44b1-0caf-08ddecb3e314
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OUpOK00yc2Q5cWdEWjNwWkN0WXhuTk9rYnBSeVRTTG5wRW1WQjhoZ0d3ekln?=
 =?utf-8?B?bGQyaTBybkM1TWxHaHhoY1hSZ01MZ1RLS3k3KzBSYS9TSkY5aXNDRHo5clJ6?=
 =?utf-8?B?bUkyTTd6MENZV2FKNFJaMUpzUEtPck9BWWhvT3NPejNUSWk2cks2ejFxeC9v?=
 =?utf-8?B?N2pYcnZxVlgxN25xWjIrV29iZldYMmt5MkcwVU9LaW9NV201cVVBbEI5bnNm?=
 =?utf-8?B?MkxaaHFkL2xDekdxVkF1eWRRQnNUb1hBWE1uSkg0MkkxQjN0Y1hteXFOWGdw?=
 =?utf-8?B?bXlkU29mM0tEcEVnVXJUOHI2d3VPQ3JYRVJzdm85ak5xSHNRNnRlQ3dDNllk?=
 =?utf-8?B?MHc1TTE3YlRsQnFjOXd1MVNXTlo4UTUyUkVCNzkydmhkK0FIbXJBRUNzejZ3?=
 =?utf-8?B?MlRpRi9vQ1U2b2tZVVVGOEhYdEtodzNQd1JtL25lNEplcWgrTlV1ak9vQTFW?=
 =?utf-8?B?N1k4bElXaCtsNWtxMm5YSitnU0VrZXNMZzhwcFVscENiTk9GTjRzZmIyd0Nx?=
 =?utf-8?B?dnVnWXV1bWgrWVVGWUlhTmlMdi9hVmpxeXRCbmthVEQyOWlPa0NtVTA5ZFdQ?=
 =?utf-8?B?SE1lLytpeVVWTmR6Z090Uk5zTnF5S2ZFV05oSEtUNjl1REgvMC9TdE9maHVE?=
 =?utf-8?B?RWkwRTBoS1QzTDEzSzdXMzhMemRERyt6elhManFjTUx0SmJKRnU5M2FlaGhn?=
 =?utf-8?B?NlRxWStYcHFkelFJbEFCMHJKWVA1YnNzekVrUzh6TFUwcUk4VzhBMGZjcGJt?=
 =?utf-8?B?Nk8reU41TmM1L0I3WWdWZWVLU3RmMUxkTndHeDFEWStaa1B1b0RHQTR0K1BR?=
 =?utf-8?B?ckhIMzRwb0lBY2FydGwyRlh0WXRweVNUekZaWlhTRGRKTDEwQWI0WGxBam0w?=
 =?utf-8?B?RVZBb1pJbU1HKzQ2SkFCYitnRi9OZ2diZWVaOFhwN2QwUDVHNTAxSitlZnkz?=
 =?utf-8?B?WGFKMlhoclRlYW9qTUF5cWx3aVF3dnBRZUNyeUNUdnpPYmQ4WjZITVdRSDVq?=
 =?utf-8?B?TDg4K1VSaEtidGV6VUgwcFV1SmFtMU9tNnU1MzJLUG4zQ2lLcHIyeXk1c2ZN?=
 =?utf-8?B?dlhTc1lVRDZaYTB0cXo2MEc4RFdUV2xIYnp3MDF4dkx3YmdFN2dNY0tUNEc3?=
 =?utf-8?B?N1VRVjZUN0lDODVuNTY3OGFQaW9Pa1Z2cllPZTVjb09RVmJoVGE4RjEyYmlT?=
 =?utf-8?B?V3lNbUpkWlAzZjlrOXNaYUd4bmkraUpsMlJvR0dkeXVPS0hIYmhBbFNOU01y?=
 =?utf-8?B?dStGbmx3NkpUNWZDdXdmMFlQOHg0cC9YRzRvaE1qNSsxYlMyaXd4SituOFRR?=
 =?utf-8?B?c1N3TTJKZDN2VXA4ZGxuVlduMlVSY3B3azhNM0V3bkNzM0laVll0ajFJSHlY?=
 =?utf-8?B?dDlJZ3JGT0FBQzlqWGoxTDZXYTlZUTN1ekpVWVBuMHU0MlhPSzJkYjV1WHEz?=
 =?utf-8?B?aE5iWEwvbUh4bHNaeDIzVCtyZUhjQmc4a3hnQnRwd3ZpNW52dDYydEhFbnUy?=
 =?utf-8?B?SzdiMWFXeTlXZ3JyallERjNGTi8zbjk4VDlRY1doaHNsQzZyVGZTaDUyTmtp?=
 =?utf-8?B?Rlk3cVRLSCt5eGlMalplbXlEcThGaEVtZlpoaFY5b2RVUDB6MlJkVndtQ0ZG?=
 =?utf-8?B?OGk1ZThndERLWFp0cnd6WEFUNkhqU056TWpLWWRzVWxQcXRhTnBCUHNPYWk1?=
 =?utf-8?B?Qm4rTWhyekFCSjZQUXpPY2ZEa0k4RERnZnB4OEJob0pMeWFCSlJvbUdIbDRk?=
 =?utf-8?B?akk1bGlIQ25DaWtrdFVycUMvQ21tYlI3NDcwNHhVODF0UU9uelJ1QUM3Yncz?=
 =?utf-8?B?Y1Evd2pJWXJhbi9FNEsrVlRLZzJaZW1BMFNJYWxFaDdQY09TOWRuN2N6VEJP?=
 =?utf-8?B?SkUzS0xyTWRaMnA5NklVMTFabzdTZFRhUGRiK2hXR1U2NXR1OTIycUFHWWJG?=
 =?utf-8?B?SHI1TjFaLzVteFgzSEdER1d0RTdmSHRZenY1RnFaVEJhVTlBQlNiTnBzejVu?=
 =?utf-8?B?RjQ1NUt3djNRPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MEFvTERrbjY0OVAvQTRQN1BVV3RrRXZQaUU4YlpOVktsTiswc3Q3L2dxK3Rp?=
 =?utf-8?B?S2o5bDJTdURlZFpiUGx4MVRHbGNmKzluSUd2NzlGSExQZlQrS2V0UnZMMjRE?=
 =?utf-8?B?S0l4RGJJVXVBckdhK3VuN3B6NkUxM1Vrd294OGMzNitOV0NkS0NTYUwvTzR4?=
 =?utf-8?B?OENCMWYzbXM3Z3hRYWx1SzNzd3hJaXZSbXdoWFVRbHpiOUVLNkxDcDBPUER6?=
 =?utf-8?B?eGVlRnNVN202SVp2M0V4V2JkOExSWWtKdVFVRERDdXllNENBdjVGSlk4WFp5?=
 =?utf-8?B?TzRyRFdsS2FsdXlXQ25rSVlsaUFlRm02cFpnRDBhMnFtUkJKOEN0aHhnWitM?=
 =?utf-8?B?d1huaEpMTUdwYnFza1RwVUxCMkZtRkF2UDg2LzR6RVNyY1VyRloxOFNiWFUx?=
 =?utf-8?B?dmxxVVFrMWpkemxvOWxqbnlQN1hsN21ERFFQdG1BNUFSUVRSd3ZGbzV2bHl5?=
 =?utf-8?B?UktMR1NQYzBsczRRM0VMdTN2bHRXbHBsSzFCWFRYV1NZbGlMNUpmOWxUNnYz?=
 =?utf-8?B?NkFNcmtGNWpRRlNtbnVrNG5RU0htNGRuUzJYSGRoTG1qaDJlWGRYSjdQeGNu?=
 =?utf-8?B?bDBZSTBuZFc4alBxNFU3eHlNbXBXOUx2YWc1TEFIUkpScnJBWHozK1ZqaFZI?=
 =?utf-8?B?TVMrZ2pCbHNsUEY2SEJYOFR6dDV6eVlXc0ozNVhBSUpKTlBJMi9jaXd5aHZT?=
 =?utf-8?B?a1grVE1Kbm1Jam4yYUt1QVJueVdsUUtOZlMyWWtVc2xMdzNkcWR0dUlSY3hn?=
 =?utf-8?B?VU9ObkdtNkFLc05reXcxTGRuUUZQZXRtR0J3dUhseUpXOTRUOEsySG10ODBN?=
 =?utf-8?B?ZDZiNjUrNUc4cHZsYm9BQmZZYzFidWVkSDVJK2VYcERjZEdlcEVtVURvTWRh?=
 =?utf-8?B?MmFRdTN2MVdTS3l0VVFSekdtbC9zbDdSaFZYais2cDdwNC9CRWVYNzRlVVlw?=
 =?utf-8?B?QS93UlJqZEttUVVpWXB1Ynl4U3l0azJnaFJGN3JHRGFwNHpkUUhJNmdmWmQ4?=
 =?utf-8?B?NHFPVGY1S203UXJtRjREaGwzdkdFd3krc1E5bU1uMWI4bVRrMnowZnZ0aU1p?=
 =?utf-8?B?ZWU1aW1EejgxNGlQeWw2N054NTNXWHNNVVh6UTR4WnA5ckdOd0VMTXJXaTVF?=
 =?utf-8?B?V1Y2YWhMSVhQRnQ0UDlJRjFiMFZYYVEzVjVjRWtvV0JVcG1qWW9qWFI0NEcr?=
 =?utf-8?B?MWxQZ01oOG5NL1FHOE9SalVLbmdKekgvcEtudE1RQmhERHJ6a1hvYnd1QnBr?=
 =?utf-8?B?blUwS2RuL0NwMnVKT1l4Mlo3WHVJUHRjVTIvTUdmUmg4Qmg3MFQwN2l1QWpS?=
 =?utf-8?B?N01OZ0RuRFd3K0VmSWJPcWZQRjh1TGlLQ01adFRUUnJWcTBKQyt5SmRJMTVk?=
 =?utf-8?B?ZmpGZTZvU1k1N1hWZFRoL0ZqSWw4cEQzSmdQU2tidjZlUzRMUUNXdmcyNXVh?=
 =?utf-8?B?RThldmJLVFczYU9XZmZ2clRSVVJsQ2ViRmx1Qm5FcXpkVmdVcXkwL1hrNi8r?=
 =?utf-8?B?bUQ0NjdGd3cySGhqd3g5dkF1Tmh5VnVTMVJnRVhqN3RpL0loeWZqL25lMndv?=
 =?utf-8?B?d0JCVHdWdTh0MDZLZzFyR2s0RFRrTmlFNEhtSnVpdEZTRWw1dTBxMGxLNm1y?=
 =?utf-8?B?MlhoLzVFVk5nL0J0N2ZNdXgwa2VnUitYT1Z6VkpwWkFJNHViQVArVWxNNWVy?=
 =?utf-8?B?Zm5CZlF4cnRmbGhBbnFPeWRDY2FzSkR5d0tLUFZtTkk2NWpWTU9wK25xNW1Y?=
 =?utf-8?B?ZFRaNUV5NmFTRldmTnEzK3Q2V0tmaGpVek1aTlVVT1NVMnA4STR2ZVVTOVo1?=
 =?utf-8?B?cm5QVkxXRUxIMm1HaWFBWjJSdjY1QnIzQzluWVZMQTdHeU5PWWljYzVWMHNq?=
 =?utf-8?B?dGppbE1DVUVETGVya0hVaTFuZCtGSnN0ZVpwci9zVm5NSFJocUFoUGZOK2tk?=
 =?utf-8?B?aDFBakZrWmQvbzV3ZU93Nno0Y3BVVEtFcGZSNE5IMUluLy9QME9UcXNtR25o?=
 =?utf-8?B?ZHNicG5palFsRnZmd0VaMklUZzVOYWkxdFlVNUpFa0NOL2ROY3JkVjE1d0tR?=
 =?utf-8?B?emcwTzJlbUxHa1dNNVBnSjhjK2pnSkhQSFJvS1IwdmZZSjdId3ZDK2cyaVFz?=
 =?utf-8?Q?YPIENSGxcV3r2YfZJ78LvbCpz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	65QfLtSjeB2qKFMG8kTmx39aD9ry00KmlTlzaKJ/gYg522ciqav1biLrWhwsuyhoI75dlMrWyvzhmNaCQl+v4+2UTNWWWG9Ae/avhohqtUeckbZ8daISH5P+UerzpQVn2scdSEn6ufikdHWDjF5Xpa+aI+AlcTymDKPBey76xrUKGBRa/xb/x7ZJr+fEnSpka/DqnMQw6cda9hd515Q8kr6Typt3i10/+9ChNyU9en2y/wr/7BloWRiElCcwNGrVRRpMqeAu6ojuiJ7kMH2nGfLyOA7Bf2rdU4LLkeu6clUGVBhZDls1siQ2PpMbNltE5+yMmVgw7aHWirrnPOC6Hsgmozi0qmyS8RatPiQLMhiRfy3Iz8BRDLki5gDPDQ3US17NZVHiFiTAQgb4dK4emPmka3i/mEdWxpNZXbmfKSeVUUtzQUYYIcEXBVYOEGGWMXGRBoS3TjR58+Lumy+lP13bi5vRgeVIuncejoUH5VZ6gtDy9xL325OCjKX1YfyZuDzefcUppLOhDhWJjdQFrkt6EYyTghMnE1tT6jMM39OxKWYGSwEmIvCovNae8vqwHovzZTY8UJWlL1S+0kbC7IFJTVfu9dJVVVFpGE0KcDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815419c7-db33-44b1-0caf-08ddecb3e314
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 19:39:11.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/4Dgxdw/jJ+1ieUpDIY+LY0vLIujUPe918pnH3osyfntxWW/Nz6yAhJeJuoKGT9Eb1LBS9bQvM910P2rL0eZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050193
X-Proofpoint-GUID: LqjBadFgHS77bIg0Ad3KKS_F7OfXjFTU
X-Proofpoint-ORIG-GUID: LqjBadFgHS77bIg0Ad3KKS_F7OfXjFTU
X-Authority-Analysis: v=2.4 cv=GOQIEvNK c=1 sm=1 tr=0 ts=68bb3c65 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=xKbicANotOj2iLSBrWsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE3NSBTYWx0ZWRfX7dMWLAZ4j3QU
 xEra9oTJPIveiim+vLIMLGcqwF0q1FPwkZqFDw+QiQsN7trPTMbUhqkptouoKZ3PtQlO2NyFBlR
 xuwL0noXEju05SlHoMFFcqoVWEPBzJIuv2gp8hXq1bCh14DMfw5IiJChHX2yBJf25v+tXgUTna7
 X56oFGgv+5T7hTQIdtof6dV9EYOait8qo7Qm1stRRQeSyh+hx6p9klLpfj+m8/wxlKFomlk0pL4
 kSg0f6R+OQmm18WdQPlnVyVhcFBaHhbZ/daDPTHoIv4dA0GSaqjOfZuBSlmyrkBVxUh8Lks5gfM
 cwQzMsWpxoL59iA/ZiYYlAn4FteS9Mj2EzXeeEqxOFxdUuBGPRepPcZRJa8e4nrtipnHf8Nogn5
 2KyZ3cNfvR2R8PKk9Fjas5rgf2ZnHA==


On 9/5/2025 11:17 AM, Luck, Tony wrote:
> BIOS can supply a GHES error record that reports that the corrected
> error threshold has been exceeded. Linux will attempt to soft offline
> the page in response.
> 
> But "exceeded threshold" has many interpretations. Some BIOS versions
> accumulate error counts per-rank, and then report threshold exceeded
> when the number of errors crosses a threshold for the rank. Taking
> a page offline in this case is unlikely to solve any problems. But
> losing a 4KB page will have little impact on the overall system.
> 
> On the other hand, taking a huge page offline will have significant
> impact (and still not solve any problems).
> 
> Check if the GHES record refers to a huge page. Skip the offline
> process if the page is huge.
> 
> Reported-by: Shawn Fan <shawn.fan@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Change since v2:
> 
> Me: Add sanity check on the address (pfn) that BIOS provided. It might
> be in some reserved area that doesn't have a "struct page" which would
> likely result in an OOPs if fed to pfn_folio().
> 
> The original code relied on sanity check of the pfn received from the
> BIOS when this eventually feeds into memory_failure(). That used to
> result in:
> 	pr_err("%#lx: memory outside kernel control\n", pfn);
> which won't happen with this change, since memory_failure is not
> called. Was that a useful message? A Google search mostly shows
> references to the code. There are few instances of people reporting
> they saw this message.
> 
> 
>   drivers/acpi/apei/ghes.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a0d54993edb3..c2fc1196438c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -540,8 +540,17 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>   
>   	/* iff following two events can be handled properly by now */
>   	if (sec_sev == GHES_SEV_CORRECTED &&
> -	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> -		flags = MF_SOFT_OFFLINE;
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
> +		unsigned long pfn = PHYS_PFN(mem_err->physical_addr);
> +
> +		if (pfn_valid(pfn)) {
> +			struct folio *folio = pfn_folio(pfn);
> +
> +			/* Only try to offline non-huge pages */
> +			if (!folio_test_hugetlb(folio))
> +				flags = MF_SOFT_OFFLINE;
> +		}
> +	}
>   	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>   		flags = sync ? MF_ACTION_REQUIRED : 0;
>   

So the issue is the result of inaccurate MCA record about per rank CE 
threshold being crossed. If OS offline the indicted page, it might be 
signaled to offline another 4K page in the same rank upon access.

Both MCA and offline-op are performance hitter, and as argued by this 
patch, offline doesn't help except loosing a already corrected page.

Here we choose to bypass hugetlb page simply because it's huge.  Is it 
possible to argue that because the page is huge, it's less likely to get 
another MCA on another page from the same rank?

A while back this patch
56374430c5dfc mm/memory-failure: userspace controls soft-offlining pages
has provided userspace control over whether to soft offline, could it be 
a more preferable option?

I don't know, the patch itself is fine, it's the issue that it has 
exposed that is more concerning.

thanks,
-jane





