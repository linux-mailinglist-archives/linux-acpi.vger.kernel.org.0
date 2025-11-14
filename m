Return-Path: <linux-acpi+bounces-18892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3111C5BAEF
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 08:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 160B04EE521
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 07:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67752BE024;
	Fri, 14 Nov 2025 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="R0//JAm0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1027F4CE;
	Fri, 14 Nov 2025 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103855; cv=fail; b=IV1mXaG+5isLZ618qvVdqs3dERSU6edQXo129JCWxNMvQaFMCWa5McJp1Gi3t/mhm9H0F45hSJbDB6gfIfSX6iBpJLvdN8m3zMiXJO0qdr3fi+cL6dw1WGrC8edBuDITYSr4hw5qcU1W1/IWwJuFnJ0O3VNgI8HAphNjstWxgZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103855; c=relaxed/simple;
	bh=bsI6lIlPrac7ZN9HMdCq45GkPhm2Jp+I5EwQQm1Gclg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bd+g4X8hB4jLP+nnMaSeDUHD0n4sF2a6shU6bDAe+A23KIujoRtoFlgzwgOITWUoxEUM0z6kbQGu/yXLj9vSLnHkoC1J6QevO2uOLE6iIXf+lpDkf+SWSYxhjuaRJTRzfVq6Jl89VGXAZ7I+4uNlbZyQDl4Iz6a8zrOscWkok64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=R0//JAm0; arc=fail smtp.client-ip=52.101.125.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9F4QoMoZ75wUhXePS2GDNB6/wOyXcZJzMbiRlUM8L/y9gKN+V4IQu4L4gfMImcbnLdiGIF7FpYTvmYCf+tyukqlmrktinLaipU+u8WPVkb35W3Gk27J7YTAMgfX71k2XBeQCAgYWf7942jgwBSjze3+JzjCaweS01BJ0hWD541yicFOI3P7/nVRIf6kSshjDzOyAmLV6+Fif4fZCqs3o1Xrh+lAQ/F0Re4cLCtm0kAxCIzq7Acmu6/a9RRfRTtAU2tEPs321gyovodIRkU4FwFLi/dfN28gYYH6CFngaUk68f8Z3oyiseMpa7vWmrqHSTM86nwKF18P0SrqCgO5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsI6lIlPrac7ZN9HMdCq45GkPhm2Jp+I5EwQQm1Gclg=;
 b=Ijr7uij/s5cjt+9TxFwUnstDNjeNvcu1tySogygnMocHfeAknomo4B+y2S75XyMR3HijEQl2U5Dg1z97le3uUgtvikzmtfynjwlTodoe+coQBPy8lLysXTa0A8I8PLm9VHvI+ctzlWxOI82yiD4Kv9Ijgni7tRA6/yTlUBOeeNNskLUIpu7aN/HXNftGrpETn7Ez3WWN7X98JPukswusIf5SiCiPeFX/G8vU/iQ61HLAC+noNJqRFck/IOnD+UEVZG2ibcX43QyxPY2KnYq3kGoHoD/ZrMpuCC8AQ2/RPsSy4qV/6GUnILIbPCNySufj4P4FTPqK8JKINd7tHs92iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsI6lIlPrac7ZN9HMdCq45GkPhm2Jp+I5EwQQm1Gclg=;
 b=R0//JAm0zizxPPdzA5jiKImsB95rgtlMBOozhhUCbtg/Kc1SlvTk1ngzYWzZhDv6nF08JNAQADvSKcBrALN6JoiXqi5PEtQlN6Jei0dEVPfYCUxfXU6k5dLw4msb5ytVTRL9PJNNYaRu9h0U7JxAVhHjg49bxXCT9WZZou1OseqX9cOPQ5jP020o87mjzIICQnii2AB7PVVztMfbNCV6TMskRqzYF1aILjOJYzDUBtuqJuGfATmcL9B/vWEdpkUBDEjgyp9OBIcEs5ywgr1ErBjjs3Jr1JevMOdXsP+DHIOGlT1Rcoan7Zx9tjO7N8GrHzfMPqWx7lRZqbEJh+OP9A==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB8913.jpnprd01.prod.outlook.com (2603:1096:400:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:04:09 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 07:04:09 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Ben Horgan' <ben.horgan@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>
CC: "amitsinght@marvell.com" <amitsinght@marvell.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dakr@kernel.org"
	<dakr@kernel.org>, "dave.martin@arm.com" <dave.martin@arm.com>,
	"david@redhat.com" <david@redhat.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gshan@redhat.com"
	<gshan@redhat.com>, "guohanjun@huawei.com" <guohanjun@huawei.com>,
	"jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"kobak@nvidia.com" <kobak@nvidia.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "peternewman@google.com" <peternewman@google.com>,
	"quic_jiles@quicinc.com" <quic_jiles@quicinc.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rohit.mathew@arm.com" <rohit.mathew@arm.com>, "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>, "sdonthineni@nvidia.com"
	<sdonthineni@nvidia.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"will@kernel.org" <will@kernel.org>, "xhao@linux.alibaba.com"
	<xhao@linux.alibaba.com>, Rohit Mathew <Rohit.Mathew@arm.com>, Zeng Heng
	<zengheng4@huawei.com>, Dave Martin <Dave.Martin@arm.com>
Subject: RE: [PATCH 24/33] arm_mpam: Probe and reset the rest of the features
Thread-Topic: [PATCH 24/33] arm_mpam: Probe and reset the rest of the features
Thread-Index: AQHcT+NQJ3ci5dMEwEGOj5ITpXEf6LTxycnA
Date: Fri, 14 Nov 2025 07:04:09 +0000
Message-ID:
 <OSZPR01MB87986ED6A7B94A06C488F9DC8BCAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-25-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-25-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=3a763e2f-c950-4192-addc-12a0fed43338;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-14T07:03:29Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB8913:EE_
x-ms-office365-filtering-correlation-id: 9ce75f91-142f-49ac-f68d-08de234c021e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ckFnaFZLd2FzNHY1SHlZU1FRY2FjajdacVM3RkRaVlJNL0F3MlN2cWpR?=
 =?iso-2022-jp?B?ZlZHa3JHTjJka3dzL3JtTnlxUEk2WU5hQmd6SmpobXhuOXJXVEkyY2Iw?=
 =?iso-2022-jp?B?UkU2Ym00ZXFzWExvUjA5YVk4czlSbFNWdklHdVNHR1ZZcS92aWV1dThC?=
 =?iso-2022-jp?B?U0t6RUozUyszeE51cHhDbmhxeXpRejFwMVdHaFZQYVVXUHlOOW1iN2JM?=
 =?iso-2022-jp?B?SEZXd3BlSlNjTVZIb3ptUHFkdmZhMzZaOC9CbG9odjNrejVTbnlyZVpI?=
 =?iso-2022-jp?B?KzZKR0tlTmE2SGoxSEFtTTVRYUpNYWU3ekpScFk0V3FldlV3eUFuZ0Qr?=
 =?iso-2022-jp?B?d1NmRFk5Mk5WVE5HOE1UK3Rndjg0cnc2VWNFTTkyeFluWmM2ZHBQOTd2?=
 =?iso-2022-jp?B?OE1hcDhWenJmZlFGVmRwcEp3dFZDdUpwVlRINjQxV2pZTWNMQSt4ejJs?=
 =?iso-2022-jp?B?QUxUb2d6VDg4bm0yRXZCc3RQMEZ6TWZST2VUSitHZnRMSVJLZGZGOFJ5?=
 =?iso-2022-jp?B?UWd4Z01BdGgyckgvZHBSeStIRFBCVmhscWNpUThoYTAwYW9XUitPMktF?=
 =?iso-2022-jp?B?dWlhaW5OejZBN2h6M1EwYnpBb2xIRDRtSmlYK1pZQVdFeWhZTU9HS1Ew?=
 =?iso-2022-jp?B?Q2o1OHdPdFROWVNmS0lnWDVHbFhTcWxHTUpvdzhsV2MyV0tsOXg5K01L?=
 =?iso-2022-jp?B?UFFHVUlKdW5RR1NIdVdaS1ZTR2tCdWczamF3OGNWTEtGdG40eTd2SHRB?=
 =?iso-2022-jp?B?YVhPR3ViV0xDZ0dVNnV5ZkRtd0FzbE8zYkVrTFQxc3EyYjJWQlZpSTRv?=
 =?iso-2022-jp?B?VHR5MlplaEdkM2ZTTFo0QXJBN1lWZWRpdGlDTGlkUC8yeUlqZTBBaHdQ?=
 =?iso-2022-jp?B?YmpVNG5hazNrWHFzaWp2NXVEUE04VC81RWpMQkVnYi9qOXRya29Da0l2?=
 =?iso-2022-jp?B?emVOem91SENWS1RPekh1ZkU2MWVMNWFBR3JqdkVxcHRwMi8vUk01eFhG?=
 =?iso-2022-jp?B?WXlxczNSSEVIb0xyRFNnVm9VR0lTb1RNZXdvQXEvTUxsZVhrMDRqTEQy?=
 =?iso-2022-jp?B?TXdaZU41TW5kdDhxbVRNU0R4S1BpNGdVNEhoNFJTc0xBSnpXV0tKQW5z?=
 =?iso-2022-jp?B?S043ZitmMzZVNm5mWThXb3Q1Z0YrSlRzOWw4TEl4S3hUbko4MUM3cUx6?=
 =?iso-2022-jp?B?NEJ2azVsMDhDSUd0NmJQWWVVSUdDa3FPRHdSVVVEcjhibE5maDN2bEtU?=
 =?iso-2022-jp?B?K0tYTUpmNWpLRFE2ckJYZ2MzRURnR0hJN0RDN2tUcXZMUE9pZStqdXFH?=
 =?iso-2022-jp?B?Ny9nQjFaUjdLa3FXOVdZRmZIcGVyVkQ1eXJJUDdybUc2YU9QeXcvMURR?=
 =?iso-2022-jp?B?N1F6aVQzemNtN0duUmVuVU9PR1ZFY1lJZm9lZ1VtengrbmdvVnl5MTBy?=
 =?iso-2022-jp?B?YVg5a2svRUdDTklnMU1DWGNEbFdTQkh6M0prZFJwakJMbWV0V2tJYlB3?=
 =?iso-2022-jp?B?MTZmVHhjR2tJMFdHS2prR3dsOUxrb3UwbE1BR0VRRGNUYWV1RjU2RkdN?=
 =?iso-2022-jp?B?TWg2Q1pUbExjSzExT1YrVTRoUHduVTVZSnpkK2h6VkFUVFl0SkNIdkxU?=
 =?iso-2022-jp?B?SlVoWXc4amU0Ri9CVDRqUC9PdEhoNkJPZTlKV0k5N3p4VVdUSUJTcmEx?=
 =?iso-2022-jp?B?QzlObnM1SFVoT2ZGb09pTU5JMzVNeUR4NnNvblFsczRuWW9aS3EwckZU?=
 =?iso-2022-jp?B?clZrbWh4Mk5Yd0Eyejc0MjZJWDJMZ3Y0ajQvSEphWDhlbDh2NmVhelp2?=
 =?iso-2022-jp?B?SENrS1pQTE45VmlWR0xJa2tiVWk3cFlDeGlHZk5Lci96dER3Zy9qQmw4?=
 =?iso-2022-jp?B?NkF0dGk4WENnR3NrN3c3TTc2eUphd3VvVEpzOVVKMnhBNFE4eUlzZWZD?=
 =?iso-2022-jp?B?bGI3Tk93Z1lIbW5oNXZHcHJ5ZXlnTVFBUFh5K1JZU3AzNXFRZGluV09O?=
 =?iso-2022-jp?B?S2tlVmRtellBVzNsTmo1R1ByalIrZHY1N3UxNDQ3bDJIL1NqK1JUU2FS?=
 =?iso-2022-jp?B?dWt5ck1rKy8ySkFMVlZGdklUc055d215aExLZjZjTkg4NklIay81Y0xS?=
 =?iso-2022-jp?B?RXlCMDdSQm5sTmVIQlZ2Q0FIbDdFTjU4SGVNRnFXcHJLTHNNS29xakti?=
 =?iso-2022-jp?B?b0xFcXpTaW15Mkx1bVZxaHpxenZXS3VRckJVQUdDOUhINSswdFBvbVd5?=
 =?iso-2022-jp?B?U05IQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZXFRL0hpRGVvS3R5K09tWjJ4YVhaRVZnTnlFQ3VLYXdwQ0k1VlFTblY4?=
 =?iso-2022-jp?B?a3hvV0xSejV4QnBQQVhDeTFCUkZCZXIzd1dERThNcUd5aTVQVWxkdkhX?=
 =?iso-2022-jp?B?dUxLZCs3NysvQmY5MHVoMTNuMGEyajFUMlFKamo3UzdQUVNLR0trQldt?=
 =?iso-2022-jp?B?N3kzZ041Y2tIVVl0NGtqajIrcGdIQmJvaW03V2FncEtRV1Y0a2o0MjlP?=
 =?iso-2022-jp?B?OG56b1hlRGZpczl2ZXVQTzJSOW1XdHFKRXh3OGNLNUFCT2NJakNZZlc3?=
 =?iso-2022-jp?B?VVJTbkd4UWEzdWsrTDJaUjhoN3lGT2dtV0xFZXNhTUxaOGRXa2xLOERt?=
 =?iso-2022-jp?B?Vk5tZEdHTlFHNE5Jc25kN2QvNWVxYnJpTnNjMEh6VWN1cGxMSVY5K3lj?=
 =?iso-2022-jp?B?MmRaZWxhTDNPM2ZuZmRaekNWb2JNSEoycml1aUlTTzAvOFpxRldSeEF6?=
 =?iso-2022-jp?B?cE5ZckVKZVQ0RWEvYU9EVEhNWWNRSUo5aU5qdHRIZVNjcUszRms4THJW?=
 =?iso-2022-jp?B?RUxQbVpveHF4RCt3dlJmNk1maVZuQ3d6YzAyZ09oendWUUFzSVlSbmth?=
 =?iso-2022-jp?B?Zks1Qm5nam9JVU5aMU1KSHFsVHQrZnQ4d0VCT0Vkc0czUkk2QTBlZ3gz?=
 =?iso-2022-jp?B?Tkg3UkgzT3VjS0tZZ0w2b1lzcnAxeWZsRTlFMXluR2FXaCsvQk8yeUtj?=
 =?iso-2022-jp?B?cXVQMUpBZ0NIN09FSXNKaE5IcWpUV1BGQTc2a00xYUc5L1N5V3RsVnNs?=
 =?iso-2022-jp?B?TlFaSzdkakJEd3FQRWtaZEQ1alljMDk5TjhiK3I3WUhDY3ZESlNUZVp0?=
 =?iso-2022-jp?B?NmNCUUtPNjcvaHV1YWVXRXlWYUlVdWxtVEtZVnlUQktsVDlGT1BnUTdQ?=
 =?iso-2022-jp?B?di94RkE1bktud20xRkJTOUVuWVlYMm5JNkViSTNSL3VFZ00vSUh6SHpT?=
 =?iso-2022-jp?B?M1dqWWd6ZTJvZmlld1g0NFYwNlpuNkZpa0Y3VFQ3UktXeHErY2RYaEph?=
 =?iso-2022-jp?B?b3pXQ3NWZUNXNHkrVmdTcURrOUlOdStQU0hVVm9qNHlhSGFvRWVPN21z?=
 =?iso-2022-jp?B?L1QrYTZiRGpsbEYvZ3Qzdy9aZVM2bHgrQ0tGZmVwVFRkQkQ0UnFOM2pZ?=
 =?iso-2022-jp?B?RWZ0YXNSWVJZT2hab2c1SG9jMGJ1TzNGTzd4Ni9RQXQ0UU5aZHFmY1Q1?=
 =?iso-2022-jp?B?SHNPbXFVNWdFWXd4YlhMTDZEWVhwL0l5cXpqdit3d3lzNnR3SWV0N3BD?=
 =?iso-2022-jp?B?bnFydnRMa1NyUHFzRnhFNDJuUEpldHQ4KzRqTTZLOEt4M2ZPZ0lRMkpW?=
 =?iso-2022-jp?B?cEZ2QzZUNFlXRGxCZXd4L1ZsZXBCbWZ2T3VPNkdVc09STjRFeENwL3pn?=
 =?iso-2022-jp?B?eXhyS2lKUW5RdEQ5aU1WSnMweHo0WEwrTXRrZldHdFN4TmJtdEh4aFQ4?=
 =?iso-2022-jp?B?RkxGZ29IaTkxa3IzZy8xanE2MXM3M2h5NjFIelNZWDd2MjFZOTZNZWpI?=
 =?iso-2022-jp?B?aGRLWUZZbWhCOEJ0Rm0wYW1hVjNFNEx3bjU3dEoyTm1laDNTakNYemJC?=
 =?iso-2022-jp?B?QWZOTXB3cDhFSUNZbTUxZTY2WGE2QkNCUjI4REV1VXFlU0RscjdURnZM?=
 =?iso-2022-jp?B?L1orc3ZaY3VDWlJ0U0JLczY0YlB2MXFMNTgwcVBBc0dLcDQzeWFzRFB2?=
 =?iso-2022-jp?B?MmhtbTlSUzhKOHhQbjloQm4wTG8wUGhTVHBlRW1zTDhyS3NUZU91WXFG?=
 =?iso-2022-jp?B?ZWNWL0tlVXllOXVBMGNIWWcxdE9qVVB4c2pTZnI5WjFGdDdrV29HcGpE?=
 =?iso-2022-jp?B?a1UzQXZDWTVLc0s2TGRPTU9hS2NOSWFhTytPV3ZVbEhERUYzNmZ6N3hG?=
 =?iso-2022-jp?B?ekhkSk8yVmtqTmlvdDBSWDRwSHZSMnZQR2J1aXpReTdPY0NlNkpob0dX?=
 =?iso-2022-jp?B?Q1MvajcrSlYxODllbkxSN29XSHorWHpQVGgwYVFJbVJsc3lBd0tkcFFq?=
 =?iso-2022-jp?B?K1Rybm02WU4wdXN4NWhZNHdxR3hvUnJrSU1panBCbFg2aW9zUTJvMFZC?=
 =?iso-2022-jp?B?YjR1NGhSWDM5Vkh2RktFRFcwVmQyUWh2c1VQR1BBM2xQNUU4ODhyV0Vn?=
 =?iso-2022-jp?B?RkVad3lQZVlpNnR6UksyZk90dkpHWWhQRjdobHE5UldGbS9lc2dhekVh?=
 =?iso-2022-jp?B?ZW0zVk1JQStYdnJ6YXJKOWRUNCt2cHZWTWwrRHY5MkE4c1FHRVJZSWYx?=
 =?iso-2022-jp?B?RWlvQ292MGxGbG8xM0NqSzU5MThWS0dYblpLNmNpSndPcjc4RFBONUg1?=
 =?iso-2022-jp?B?dS9tNFRubnQ1dnYwUHRYbjhyVi9wM0hMNmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce75f91-142f-49ac-f68d-08de234c021e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 07:04:09.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2CI6upkDs3ZyrukkmINP/9RQs8z59NYNBZC58BWlnL0Nj+ME6Z/H8zUfib2NOsatEZgksw5RQtkaAEk5jYIMEQK8QW1K9733YRAAZE43l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8913

> From: James Morse <james.morse@arm.com>
>=20
> MPAM supports more features than are going to be exposed to resctrl.
> For partid other than 0, the reset values of these controls isn't known.
>=20
> Discover the rest of the features so they can be reset to avoid any side =
effects
> when resctrl is in use.
>=20
> PARTID narrowing allows MSC/RIS to support less configuration space than =
is
> usable. If this feature is found on a class of device we are likely to us=
e, then
> reduce the partid_max to make it usable. This allows us to map a PARTID t=
o
> itself.
>=20
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> CC: Zeng Heng <zengheng4@huawei.com>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

