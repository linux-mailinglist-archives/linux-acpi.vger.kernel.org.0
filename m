Return-Path: <linux-acpi+bounces-16008-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D129B338AF
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73D33AC953
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D329BDA2;
	Mon, 25 Aug 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lU2Yg2M8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4C29B8EF;
	Mon, 25 Aug 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110280; cv=fail; b=Y5P6g3h8w4Ecj7aylCJoZ8eOw44cwcQKmbpTwvcnfDSLKxDkdJqS8kl8oP2Vx9nhrIxT1SDdmXfMsyl5CK1FL0nA5aCYNPS3ioiMagUuxZpB9QEVFJDWL7z7bjcA8Nsq4Ook785v5nTODEYj82tp1G+KGJrzX/J0BDSwvohw2Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110280; c=relaxed/simple;
	bh=304oIk4/UM8BKCdzG5THKLyeB3sIpn3psVIn38yYmmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6K+SBmeKqlR7crF9xvRqMMHLu9w+SuNb7DtFl+kORiVFOsa5ShueAE/EjXlsppKtXZxTEkQ1jE/kR6COqB4f5lRg4Y1WQDhJRzYfBiudTLIGQZl4hmPtNjsuCKOfVVHnmJXtxWN2BNI/OOyhPT2MdVRLi7yZv2ybWPyJwhsPgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lU2Yg2M8; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756110277; x=1787646277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=304oIk4/UM8BKCdzG5THKLyeB3sIpn3psVIn38yYmmo=;
  b=lU2Yg2M8QSRI9r9RaxoDyadaGgQ0JF9L2fBPSqLhUTU9S2/CqOdWkm7F
   EiXxMAZ64qgbc6g0z0xOePUqexpN6wK0Kvd7feLhE3OQ3kHL0TogVCwnG
   t7vSmxne82Ybu3sVa8lOTzI3c5QkQ8nHpkQwRvZL0/wfxwVAmpf0692kX
   SDNyKG6fXk8+oNlWRBHz01KEc/EbLUnsfva6l95nhejaMSirXv45cL4wG
   i1wDf2XpOnUsqaQqnhb74AtfNjyWHB4k5jHNZ/e1Z3js6DFByNAKwd2ga
   fGtBJEkv8CJHW2YXrg78+iuFf3Sb103nQjg+3yRLR/eSrwOWmG/2O5Cw5
   A==;
X-CSE-ConnectionGUID: 8Ep9yJTPTDeXQTa35VKylA==
X-CSE-MsgGUID: NYo2BD76TGCW+22exTptbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="78633282"
X-IronPort-AV: E=Sophos;i="6.17,312,1747666800"; 
   d="scan'208";a="78633282"
Received: from mail-japanwestazon11010057.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 17:23:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urMsqY2NXh47AJ67WweHOw7j2+PbVyiYgqufW+IZJ/iDXM3CdH7CuzcHlKeJTuPfADiPJbkhy2kLczxSoarKKK1d8bOUF7ZQI66IY+eBh+GEE06Lhm5Chc4GiryASbfQFtSz7H886XWKrnTvETlhs6J9H6XSSs4989B+kdCsUfr5+5kXrYk7WwFoHcLsewktUVM7i0Ppad70Vkx4VsYxMRmr2tNo4tuOi1zlarkTSrj3O2VWBR2cdyb7JlkOel5SzhchbdYWbgUUWU390csoGV+oZ4XEJGuKHJL07Zk5qlARvi9Tb1ayC8QtOritgQUJcrgdCtFny7njvf3qvgrxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bPlObf4lGW0EatBYJa5BcSO3me/Wd4Dehzbj4aJqEg=;
 b=rIaYyXickGDq/+kB7TGuM03L6vGbNfOw/ukJ7gM4dFoCB/xhzmk+/PDq31wspSFrzfzRcT0E9LmLtSfgBfwTt0XHeIDBqwEM/R6MzxTslu6TdLibkZoGlwSk2AkhrjtyEAptJj2vVjm23Ls1xdvUgtWu3vP+1x0X6i42eHNpkyvjVVcl4Osg2yHHpfoG1P2xQlQy1CZqeVmRfWfWth3qp8Her7P5flgIVQPFZMl19BVyRTJQIr9n45ggtwJNjoRh/nKnClfnQOxEEP2dwDR9uczM3kOERIMcaw9Wn/ULUcpRCZLXNK8UM5YKh8jx8XiD/6ODaiD7juuwMlRtWysVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com (2603:1096:400:1dc::6)
 by OSZPR01MB6987.jpnprd01.prod.outlook.com (2603:1096:604:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 08:23:13 +0000
Received: from TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1]) by TY3PR01MB9983.jpnprd01.prod.outlook.com
 ([fe80::f8a:4f35:cc76:bdc1%6]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 08:23:13 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Ilkka Koskinen' <ilkka@os.amperecomputing.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcEA0DtJrppafZxEO8iry1iSQK/rRsfZgAgAaRt8A=
Date: Mon, 25 Aug 2025 08:23:13 +0000
Message-ID:
 <TY3PR01MB99836E78DE9E1C685A94D504D53EA@TY3PR01MB9983.jpnprd01.prod.outlook.com>
References: <20250818065437.85905-1-fj1078ii@aa.jp.fujitsu.com>
 <a6d5d830-b1f2-c14b-7753-82f35baec8b4@os.amperecomputing.com>
In-Reply-To: <a6d5d830-b1f2-c14b-7753-82f35baec8b4@os.amperecomputing.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=2750fbb2-2fc7-4b75-b048-776b60751dbe;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-08-25T08:13:56Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9983:EE_|OSZPR01MB6987:EE_
x-ms-office365-filtering-correlation-id: 15ec62a2-ea3b-4631-139d-08dde3b0a293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?WUFkNW4vbkw1cUE1Z0VWZGRyWjFPYTN3eE1MTHFBL2hNWExiOHpYY2Ex?=
 =?iso-2022-jp?B?N0wzN0NwYTFPVThpSjhCTTVkalZSUkxCM1BQeGI0U0Ezazg0aHdGWDV5?=
 =?iso-2022-jp?B?VTc5RHFMQWhaVEZta21sZjhOUFkwK1B2WldIek4wMWxoRHhSRXRQNzU0?=
 =?iso-2022-jp?B?a1ZoZkVrOTMvT0tISTJwaTB0eXVoOEdFMURVNTM3N3drQytvRmV4NFh2?=
 =?iso-2022-jp?B?TXJoMnREWTBSV0pqRmV2UjdRUjljOGw4dUV2ZWlsdjJ2UFg1VzZ0a2lF?=
 =?iso-2022-jp?B?aURVVVhHa0o2NUVwU3g3T3A2eGJFQ29wckhqVnU2T0JVbVJGZmplemZR?=
 =?iso-2022-jp?B?V0F6Zm1ldUZnRjBSTUJRMmVUcXlrVXYxc0JSNTNJdkhCdnRMNE1lTjJr?=
 =?iso-2022-jp?B?bTMzNnE4aW9Ra1VVYlU2aVFkd0tDTFN0d1lhR25nRmxYSmNBZnNtMWdr?=
 =?iso-2022-jp?B?QlUxeTdyMXhyNVhISjlabXlJL29ONHZhRlZzSmJBNFJEb3dnNmJCcE0x?=
 =?iso-2022-jp?B?djY0RFRpYWxoeU94dnU0YndSVHY2TTRpOEV1Sk0xeEpKNGRMcjV3OUpC?=
 =?iso-2022-jp?B?UnJDVUlVVEVhZVk5eVE1R3cvYmdjRUpjeTNzR1pZRFd6Q1VPdGNBd0hr?=
 =?iso-2022-jp?B?ZFozL2lPUzY5Z0tEWUkvTk5UbWNyeE56eU9BcDVUOXBJcTNCd3FjYkY0?=
 =?iso-2022-jp?B?M3NOalUvamM4QkZDcUtHNXlvdUcrUkRySmhKdjZkKzBYN014SWJMUDV0?=
 =?iso-2022-jp?B?ODNqeHc4ZkNXbEp6TjRGTEl1eHBVZ0ViNUV5ZmwyMVNpdE1MblppSkVL?=
 =?iso-2022-jp?B?NTRibUtNaXR3VU9pMU9hMkQ2MHU4UnJ5OHJKaGpzRTF0OFJtTmxuZDhJ?=
 =?iso-2022-jp?B?MmRiZ01YazAzOFdpalMwUmdmNmFPVDR2VmQraXF3MnA0a0RYLzg2SU14?=
 =?iso-2022-jp?B?d29hQ2dEcXV4UGN1L1ZqcEh0K3YwVEU3TDBxaWF3K2tVVWt1SmNadDg1?=
 =?iso-2022-jp?B?Qng2N1I2eGNDUEZidXkwVERIaGw1Zm80ejBkRllrelZlUHRMc0RRRXZm?=
 =?iso-2022-jp?B?OTZxRFJzd2JHWE9DdTJmRFZ2d3V2Snh3NEZNSVYrR0FweDRVZCs5WXBw?=
 =?iso-2022-jp?B?TnpjQ21Zdyt2VGVDbkFHSGNDbElxRUcyOVJYUjV0djB2Q2RqT3ZVa2o3?=
 =?iso-2022-jp?B?cXBoTzFRbWdkSHhBZ0dBWGZ0TjJRZHAvc2ptMUhRczJPbWhCeVJvVTA0?=
 =?iso-2022-jp?B?ZW8rWFlxTjJzK2ZEaGxqTFV1YTF6dXU4Vkk4dTNFVitIWFVEMEpCSUw2?=
 =?iso-2022-jp?B?eDUxZ2d2RTdFL2RKMTQvSWtWdGFPdUFpaU9UYlZRRWdHSDJvTDY5ME0r?=
 =?iso-2022-jp?B?V0svL2VWZTdnb3U1cUlONW45ZXY3b1RLemNxdWU5SWVZM0M1amlXVC8v?=
 =?iso-2022-jp?B?Qk51VXBNcVFkVmJCcHAwN1VXNXNqZ0pYYlJ1OW55TE9YVHdKZ3VNdHNZ?=
 =?iso-2022-jp?B?VmRRV3VGd2hic09GTFNjOUpJQXhZYis2Z0FvY0ZLbEdaOStIUndkaTJm?=
 =?iso-2022-jp?B?anEyZUtsVml6ZlQ5V2d5dkFVWWJ4ODVxekNBSi9mMXpIT2NibEwrZUlI?=
 =?iso-2022-jp?B?bTYxZGhqQnROTEVJaFRueHlsVk0yUVBWMnhqRlFPZ0d6VTVKV0hTZk9V?=
 =?iso-2022-jp?B?bDBiVmdFUEJsSCtGVm5KOFU1S05EaWFqZTRRTmhOVWQ2OU04WHFFMVhE?=
 =?iso-2022-jp?B?K3dPMUNuamFrSDhsRjVLNFhQa2FsVmxTZld5K0pPd0ZrWUNWcjhDWVdV?=
 =?iso-2022-jp?B?Um9KM0JKODNyUUdMOVo2amJTb1R2cVVBK1IzNFZGM0RSS2Z2K2VwTU1y?=
 =?iso-2022-jp?B?WjIwdk01N3pLLzI2TDBWNGVRdk9UMGxuWnlONFk2Y2VTYml5SFpreDFN?=
 =?iso-2022-jp?B?ejdzVmNjS3lpT24rbm5ncHJVcnhJVkVBQU9WU2VaRGlZVGszS3BBVnZS?=
 =?iso-2022-jp?B?Ym9qYy9sZ29rN0JHcUhmcTRyZWZ3VEN3WmpOYnNhSmJYdFJMTjlucVBl?=
 =?iso-2022-jp?B?RDFaeTlYeE4xV3Z4dXUwTFBNN1pqb2hWVG9LZkdUM0IwVUJVbW9SbnBK?=
 =?iso-2022-jp?B?cXltU3RaQUlYUzArRDFxcXl3N3dRazBiVmZCWDNZTXkrL1lZdUxKaFNT?=
 =?iso-2022-jp?B?K0Nnb1ptQTRjODJKSDRlMzBUeGhjMHZK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WWR6ajhkQVg2WWF4SFFuR0UyNWdPdThtWTBFWXN6ZVVHMngvR0FnaTNK?=
 =?iso-2022-jp?B?QmQzSWhoTlJqQmg3bVFZcUZPSG9lRm1LNE5YUEpEMUllT0RFb0J1L0hN?=
 =?iso-2022-jp?B?QlhQcDlJbVJlYjFVMnVoNE5NbmpUdWVLMFlqOTRJSGM3UU9zVzB5b1NX?=
 =?iso-2022-jp?B?dC83cDJRSjhaWkFyQSt6OWNibG15YkdLL2hQRzBXemFkajlPNUVCQzhx?=
 =?iso-2022-jp?B?U2FaVjN5T2hVTmRXdGRHaENXVmFYcGtQbzUwZVpVdktEbnhXV2xuRXlp?=
 =?iso-2022-jp?B?cTJTQWhnbHIzd1BSaThWV0Y0cU9JUUo5VS8zV2dGUFR6VDNxWHdOcEM2?=
 =?iso-2022-jp?B?djBHQyszUzMwQXI1dU44SnFXa256T200ck1zZm9ubVRFZUk2S2NjVkJ6?=
 =?iso-2022-jp?B?Yk9ZK3JuYXZacTVWd2R1VFl1cHgySkRuNnczR3o4a05Ka0dBVXdCc1BK?=
 =?iso-2022-jp?B?czJWM1pLRXpDcGYrR09XMEpHYW1PdTMrbCtUSGY5T3EvOEtMaUJERnRx?=
 =?iso-2022-jp?B?MWxLemFtb1JqV3o2akRSMTl0RU9UY2xGSWxNS3ErNytQaUNTNnJoUWhv?=
 =?iso-2022-jp?B?VitYMm1YNmF2SHNsN2JqZmY5cEx0UmFYSi9paHhaNytCK0FaNkI1VS9h?=
 =?iso-2022-jp?B?Sm1DVzdySTVVRzR2Vmp3eGp1UkNIUGFPOEl1Y3hSbnE2MFpmV3J6eVdU?=
 =?iso-2022-jp?B?ektQQWdpZVVpaWFIZHZXS3NyRW53Q05mbi9oYTlhcWxWbThiWlhKK3B1?=
 =?iso-2022-jp?B?M3lWR3lnOEs3ZHNmT3UxZUR5em1Vb2lrWlNHbDdJVEk0U3c1RkNmTHBx?=
 =?iso-2022-jp?B?OE00K3ZPWTlEaVRQNG1yNm9weklrQlRDQ2htY3pneXlVQmxjY2p3VCsx?=
 =?iso-2022-jp?B?NjREeHJCNUI5QXkyK2krUUswQzhsSXFnUVM0c1RjTjZQdDNzMVQ1cm80?=
 =?iso-2022-jp?B?YUtPT0t5cHA3aWRMSmxENkphU0huQlRac3U0SVVKZ1ZhM1h3b1FRUmxs?=
 =?iso-2022-jp?B?RVBkY2tTaElPakZYWDhZa096alBqMkEzSjRPRGpSNnU0SW00QVppbmpl?=
 =?iso-2022-jp?B?Z0NEbkUrdHVBY2JYRnIrb0JqaktvdUl1Z1BXSUY0aFM5dXZwSDZlUnZs?=
 =?iso-2022-jp?B?eVVVZzR1aWVXekg3U0lKL3Z0TVRidHJYZXdZZ3U2d2tmUlYyRTlCYW1n?=
 =?iso-2022-jp?B?ZElKMGRraHNkanRVTWFkMGRGS2x2aVpnMXBtZVpLVFpCUkszLzYzRVlI?=
 =?iso-2022-jp?B?RnY2K2hTZ0MzdXozSjM2YnlmT0lMWVdTajdaTDlsaU15aVJjWXhHMzBl?=
 =?iso-2022-jp?B?Zk5ySkN0K2grM3JPdDdrOStXK1BQcWgzWVpPWEk4M1hwcUdQVnZQYmpQ?=
 =?iso-2022-jp?B?V0dQbHRacDFXalcxT1RVMDR0YWFEQ3BOM1FZR2tnVWFaalZMSmo5SVJh?=
 =?iso-2022-jp?B?QkhBZnZvbVVTUVZPeERGc2hmTkhtRHRaK1Q5WTEwakdTZEJBL0VSYXds?=
 =?iso-2022-jp?B?em9MekVIRS85YVRqS1Rrc3hOU2Z6bnVac294Nnl3V0Y4S0FBcDdROFNp?=
 =?iso-2022-jp?B?d3Nya3V6b2w0U1FBWE9vUlVLWnBXSVlpV1BEaWY3Z2ZFNkdrU25BUkQ3?=
 =?iso-2022-jp?B?RVlVaWR2dkt4WGhSN2JPd09ERHp0L3ltVm0yU1dUdU1jWE1UQXUweFhy?=
 =?iso-2022-jp?B?YktDNjdVMG4zTzYwcS9JQ0Z3RWJHM1Jyc1Nud3RKRndxbUs5VDhqTURI?=
 =?iso-2022-jp?B?NGlSRnhlelNZNXBxWU54aGszbEN0ZXIwQVJjWm1PbFZpVEcwbHdFbTlm?=
 =?iso-2022-jp?B?dzlUbE1ucjdaUVFIdHQ1TWlRU1BxbTduYmNCZ3o1YkVHYzd3WEcvaFkv?=
 =?iso-2022-jp?B?Z1BBbWpjaVlnTTR4dkc1REwvVXBIb095SmczQkNCcEY1RUFSSXp2clhv?=
 =?iso-2022-jp?B?U2RyTkJZOFZVN1pITEJBRGRuTmEvakxrdnNCVVlwYndmUW9NU3FsMVNU?=
 =?iso-2022-jp?B?eU1xZnRObWkxQmhtbVlIT1FmUzRnTXdDdjBHODVpQUx6TGxQQlNHU3pP?=
 =?iso-2022-jp?B?OVYwK3IrbXQvUzhUM0JWdWV0cEhIM0FVdVEwUmZZVG5pYnFkQjcvNWVJ?=
 =?iso-2022-jp?B?WHV4MDNYVmdObTE4a0hhakZVd0FrMHA3bmh5UGM0WUc2bXdXRUFiK0Er?=
 =?iso-2022-jp?B?ckFWTU5hS29rWjNUenZHa3Qzc1V2YXlya0dhaTlsRlBXaTdLTDFPTXNh?=
 =?iso-2022-jp?B?MUp6UmtBTVNIS1pweFZYWHdyTHZrUUE5d2FmU3NTd1pGaHdWa01GRi9F?=
 =?iso-2022-jp?B?eFBVc1VNaWU0QnM5MlpZL1I5VU9uazJ4SWc9PQ==?=
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
	nC+xAKGwJcx1yZ8kzzZPoAxmqKWDqdGZQRconG4ZRZ0alV16sdBi9iQQNotdOzSZeGOJdcAFE0F+wBHA6KYeIkB+iFiBDpxq1zG0IFNITjXJdOBj4DWUpFlsDWHQAtN/rx6Fd3ZjkNURvZky9yKNYnwZkBh8huXxZ3Mrsn1pfVIklXgIG5Cdsry5ytdoVAWdNbd1cQl5emfGx/XEdhxWI9GdCSgTEkn8CX2xUnzIy9QB+quVb6b8RkY7iJFdTfAPeFKjvhmSNmC7xkkwbn8MUX8rHbcGXqhgUXkAD857qtJopZWCbmIgS5rHRYQ6qOYhcg+j3oRv0/lIFgm2K+9l874hE2HQqLkH9PEmb8qoybqZPCT5uGVkVE3m1A/Dwk+Nho7nSn8F8aHpw34mHryhRf1KZHCGdIyXkcHMTe2RBMhg0w3gwqz9yaYhkvEiV8FCxbgJNWI6cCPLJcV163TP+I50ZZ/Umhwqiml2Og5kPNLxI4PfMKUEkQ8wnawVo0z+TJtIc9kdm2JJsx7TcWyRJtPJuEWxxYiS/d8ZNyzoPp09lW8J8ADVKuwZkUl4i8MdJdyRRPA7V0SqtUpiF4M/8N+59Lu8esCp6JF5Y2uP8P3APNmN0uK0MCAFHBCT7DAp
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ec62a2-ea3b-4631-139d-08dde3b0a293
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:23:13.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvrYaGG7DeH9elPKXsx2zdPPu9xRacJvfiJJe2ZKM5fGdHC5SLcAu5sdrtQ0BQbzLNDMzf3Kq1kbshX/BE2TVa6gCP6XEd3LrtEDmclCER4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6987

Hi, Ilkka

> Hi Kazuhiro
>=20
> On Mon, 18 Aug 2025, Kazuhiro Abe wrote:
> > AGDI has two types of signaling modes: SDEI and interrupt.
> > Currently, the AGDI driver only supports SDEI.
> > Therefore, add support for interrupt singaling mode The interrupt
> > vector is retrieved from the AGDI table, and call panic function when
> > an interrupt occurs.
> > SDEI & Interrupt mode is not supported.
> >
> > Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> > ---
> > drivers/acpi/arm64/agdi.c | 114
> +++++++++++++++++++++++++++++++++++---
> > include/acpi/actbl2.h     |   4 +-
> > 2 files changed, 110 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> > index e0df3daa4abf0..c514bb874c5d3 100644
> > --- a/drivers/acpi/arm64/agdi.c
> > +++ b/drivers/acpi/arm64/agdi.c
> > @@ -16,7 +16,11 @@
> > #include "init.h"
> >
> > struct agdi_data {
> > +	unsigned char flags;
> > 	int sdei_event;
> > +	unsigned int gsiv;
> > +	bool use_nmi;
> > +	int irq;
> > };
> >
> > static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs,
> > void *arg) @@ -48,6 +52,55 @@ static int agdi_sdei_probe(struct
> platform_device *pdev,
> > 	return 0;
> > }
> >
> > +static irqreturn_t agdi_interrupt_handler_nmi(int irq, void *dev_id)
> > +{
> > +	nmi_panic(NULL, "Arm Generic Diagnostic Dump and Reset NMI
> Interrupt event issued\n");
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t agdi_interrupt_handler_irq(int irq, void *dev_id)
> > +{
> > +	panic("Arm Generic Diagnostic Dump and Reset Interrupt event
> issued\n");
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int agdi_interrupt_probe(struct platform_device *pdev,
> > +				struct agdi_data *adata)
> > +{
> > +	unsigned long irq_flags;
> > +	int ret;
> > +	int irq;
> > +
> > +	irq =3D acpi_register_gsi(NULL, adata->gsiv, ACPI_EDGE_SENSITIVE,
> ACPI_ACTIVE_HIGH);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "cannot register GSI#%d (%d)\n",
> adata->gsiv, irq);
> > +		return irq;
> > +	}
> > +
> > +	irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
> > +		    IRQF_NO_THREAD;
> > +	/* try NMI first */
> > +	ret =3D request_nmi(irq, &agdi_interrupt_handler_nmi, irq_flags,
> > +			  "agdi_interrupt_nmi", NULL);
> > +	if (ret) {
> > +		ret =3D request_irq(irq, &agdi_interrupt_handler_irq,
> > +				  irq_flags, "agdi_interrupt_irq", NULL);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "cannot register IRQ %d\n", ret);
> > +			acpi_unregister_gsi(adata->gsiv);
> > +			return ret;
> > +		}
> > +		enable_irq(irq);
> > +		adata->irq =3D irq;
> > +	} else {
> > +		enable_nmi(irq);
> > +		adata->irq =3D irq;
> > +		adata->use_nmi =3D true;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > static int agdi_probe(struct platform_device *pdev) {
> > 	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev); @@ -55,12
> > +108,20 @@ static int agdi_probe(struct platform_device *pdev)
> > 	if (!adata)
> > 		return -EINVAL;
> >
> > -	return agdi_sdei_probe(pdev, adata);
> > +	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> > +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> > +		return agdi_sdei_probe(pdev, adata);
> > +
> > +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> > +		return agdi_interrupt_probe(pdev, adata);
> > +	}
> > +
> > +	return 0;
> > }
> >
> > -static void agdi_remove(struct platform_device *pdev)
> > +static void agdi_sdei_remove(struct platform_device *pdev,
> > +			     struct agdi_data *adata)
> > {
> > -	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > 	int err, i;
> >
> > 	err =3D sdei_event_disable(adata->sdei_event);
> > @@ -83,6 +144,34 @@ static void agdi_remove(struct platform_device *pde=
v)
> > 			adata->sdei_event, ERR_PTR(err));
> > }
> >
> > +static void agdi_interrupt_remove(struct platform_device *pdev,
> > +				  struct agdi_data *adata)
> > +{
> > +	if (adata->irq !=3D -1) {
> > +		if (adata->use_nmi)
> > +			free_nmi(adata->irq, NULL);
> > +		else
> > +			free_irq(adata->irq, NULL);
> > +
> > +		acpi_unregister_gsi(adata->gsiv);
> > +	}
> > +}
> > +
> > +static void agdi_remove(struct platform_device *pdev) {
> > +	struct agdi_data *adata =3D dev_get_platdata(&pdev->dev);
> > +
> > +	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> > +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> > +		agdi_sdei_remove(pdev, adata);
> > +		break;
> > +
> > +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> > +		agdi_interrupt_remove(pdev, adata);
> > +		break;
> > +	}
> > +}
> > +
> > static struct platform_driver agdi_driver =3D {
> > 	.driver =3D {
> > 		.name =3D "agdi",
> > @@ -94,7 +183,7 @@ static struct platform_driver agdi_driver =3D { void
> > __init acpi_agdi_init(void) {
> > 	struct acpi_table_agdi *agdi_table;
> > -	struct agdi_data pdata;
> > +	struct agdi_data pdata =3D {0};
> > 	struct platform_device *pdev;
> > 	acpi_status status;
> >
> > @@ -103,12 +192,23 @@ void __init acpi_agdi_init(void)
> > 	if (ACPI_FAILURE(status))
> > 		return;
> >
> > -	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
> > -		pr_warn("Interrupt signaling is not supported");
> > +	switch (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
> > +	case ACPI_AGDI_SIGNALING_MODE_SDEI:
> > +		pdata.sdei_event =3D agdi_table->sdei_event;
> > +		break;
> > +
> > +	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
> > +		pdata.gsiv =3D agdi_table->gsiv;
> > +		break;
> > +
> > +	default:
> > +		pr_warn("Signaling mode(%d) is not supported",
> > +			agdi_table->flags &
> ACPI_AGDI_SIGNALING_MODE_MASK);
> > 		goto err_put_table;
> > 	}
> >
> > -	pdata.sdei_event =3D agdi_table->sdei_event;
> > +	pdata.irq =3D -1;
> > +	pdata.flags =3D agdi_table->flags;
> >
> > 	pdev =3D platform_device_register_data(NULL, "agdi", 0, &pdata,
> sizeof(pdata));
> > 	if (IS_ERR(pdev))
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > 048f5f47f8b88..9ddbdd772f139 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -339,7 +339,9 @@ struct acpi_table_agdi {
> >
> > /* Mask for Flags field above */
> >
> > -#define ACPI_AGDI_SIGNALING_MODE (1)
> > +#define ACPI_AGDI_SIGNALING_MODE_MASK (3) #define
> > +ACPI_AGDI_SIGNALING_MODE_SDEI (0) #define
> > +ACPI_AGDI_SIGNALING_MODE_INTERRUPT (1)
> >
> > /*********************************************************************
> > **********
> >  *
>=20
> Like Hanjun mentioned, these should go through ACPICA project. When you d=
o
> that could you also add the SDEI flag to the other places, which are need=
ed for iasl
> to be able to decode AGDI tables. You can find them if you take a look at=
 my patch
> in ACPICA project.

Thanks for your comment. I found your patch.
I will send a patch to ACPICA first. Once it is merged, I will send v2.

Best Regards,
Kazuhiro Abe

>=20
> Cheers, Ilkka
>=20
> > --
> > 2.43.0
> >
> >
> >

