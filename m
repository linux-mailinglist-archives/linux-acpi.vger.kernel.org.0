Return-Path: <linux-acpi+bounces-18792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44CC50DD8
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D40FE4EB268
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 07:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330D284894;
	Wed, 12 Nov 2025 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kzuUlV2o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011054.outbound.protection.outlook.com [52.101.125.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BD262815;
	Wed, 12 Nov 2025 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930886; cv=fail; b=XOHa8cJIsHMOwF+Sxh+LbfMdwmCI+sBh4LyFhhRSwERFjGu+mjAljubPsZK4og+q+lkZPhPVd49UmhGt0haY/lqbxAjdRkTj0brK9LmH4TsYY6dtI9Qv0Q1ae/s7DOaTnd7qSFVoQ/HSvCVCeSp4ybFCOKUfM6RzwpXk942/9uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930886; c=relaxed/simple;
	bh=i2NGPFYu6I1Ckuy6uzzYabldwyHi6J/sMGTba4FEeec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t8KlKRd4jdO9eqeFecf+lGxt4BHeJ3UvzA4ocu80+VmCuoDHv+G/Y3piCbxoy6u6leQOJPG8JvDq7TbyYrx60K0TPugGWqN1O5g6TAh9dS73yC1+xXBa3TD7QlwYoWyLv+uImbSunRxyXLVKhb1tOOrj5TgMHGfl9Rfy/T6EOwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kzuUlV2o; arc=fail smtp.client-ip=52.101.125.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjVRYqutFlPqfTpWzylovv65GG5mfZ5vMOnEQ4zBBK5o9WB/JoZh6rCIHjE7srPsmNnNI87edaq1L9vpftinrUcOcaeq7dHlWuByilvb9ZlJ9uKtpGeiahGFsP/b/u307WeOBf0M646gqnpb64BIf/vD9smKJZnaLLs3FpnzZYx9CjvrdMUcgY/rHBYgWOXsKuVqoJOu1LsKCaQIiGhmZ1hvTrVihfKheSbpQsPLd20yCxdVjgIlP0Vq/hvZV36nZKz0jJQcn6HXgx1Rtk94tcPN/KPdillM+ECWDY3KGo/qcbStsDC1lpLIrRuAOhUC6UKdI0bfYlAjCv5seMuyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlJs4k9eGjfZ2FAOPJm2ZeNE+MN8UAQPbTSq5j79/OE=;
 b=vs9uK3UuX0J1pEtZYYbnxiXsQpV9CK2TjUYDD94bRC6vlrMpHdEW+Od0/KhL1YNCUT9wO1NGFOg71lUWqE+MmjCnLKpc2E3h5hTs8PFKQIGST+nl8GPcEMng4pDxm8lmLnrbM23bTLBUUWxO23DDZ9MSgZWn4iUYXGvV6mKpEz2zHBDRmmhW+XY27J/DbDQeK+ex8MNJIg9rllmbPcv6WgmjI+jSM5jJyFpGz7yN7UTThQZugyqJ28SQcEUcx1JWzrwta4PLbKcIclQA8SFGNxoc8sGr2Wt15TYpy40xogOIV94yFandaNoA5CE9PmiT+jdbJzEFGDSQR+CLS1p8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlJs4k9eGjfZ2FAOPJm2ZeNE+MN8UAQPbTSq5j79/OE=;
 b=kzuUlV2oOKKjfMGYEaxLLkxxm6EA+sSl9vTGMkbWio/Z9m91hofSbrDpgLfDagGcu9XjcbPXR6gF0yG479V3zgzH0fwuuPA4nGoWhSwGyo37mVoPe/cbpaKOkYHJrnxc54ltf3vaGhubdN2VkNnCebgVdMXWIMRGebCNbwg2zT2XEjVxpRFUlsRuF8hNodybQlTEUu7XcmbsNr2do9hCqwprGfg5KBxvWkJA5QAC+Yq3oMSKuUwNrHx5BstdHgQW325xCSnikOGevSsZeYfdlPX5Yw4Bw+eAbyhpfy8JdouWENFvXigtLQGxbboRMYYBlHuv7gqGdBgqf2Byg5cmuA==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYRPR01MB15054.jpnprd01.prod.outlook.com (2603:1096:405:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:01:14 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:01:14 +0000
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
	<xhao@linux.alibaba.com>
Subject: RE: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
Thread-Topic: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
Thread-Index: AQHcT+MhHXa6PT4Q5kOFjYV3PkjsNLTuoGIA
Date: Wed, 12 Nov 2025 07:01:14 +0000
Message-ID:
 <OSZPR01MB8798996B4D879FF695AE216C8BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-10-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-10-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=fe865e5b-fb8e-4356-a0ca-9df5ec035365;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T06:46:31Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYRPR01MB15054:EE_
x-ms-office365-filtering-correlation-id: 5876ff8e-8531-4df9-4ef5-08de21b9451a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?M1J6elFpNmRmcnQrZDJPeTkweFlDUVBNYnlhcUFBbUVHNXlRUVhWR2F3?=
 =?iso-2022-jp?B?ME5SU1FoM2NDeCsyZFU3RndycU5RRXd5dTNyT1R4SE9hNlRqQ2kwc3R5?=
 =?iso-2022-jp?B?V0dGaDVLVWRmV2hzdkZjOTJsRWNaNWtpM1d1U3ZZMDZOb0ZRVWJtTDY0?=
 =?iso-2022-jp?B?ZCs1QlAzZ2tWUExIYUhQbkhONDR4QnczazVLK3cvUnF4RlVtWG04RFlF?=
 =?iso-2022-jp?B?VnZuVEFzdEROSTVhNVBQOUtXdmJ5K1NQOFRpei9QNWg3TS9pbnRpcysy?=
 =?iso-2022-jp?B?Mzk5S29DbzlyTm9UOUIyZkVzNnVNaEs1TmdhUkNjTDN1VTBKWDNwaVF1?=
 =?iso-2022-jp?B?WmladDJRSVJ1dE90bDQzVVlieCt4U2lxMjlwanJySVJzOG9hYkMyRUNN?=
 =?iso-2022-jp?B?aEllM2xqTWZkeUFKMHFOd0NaNmFhNzJUVmxDSmZBSFA2dC9iVGJMRUNQ?=
 =?iso-2022-jp?B?bUx5TnRtekQ4MmJNTjNIcFhpR0Y0cVBhaEFqZjRLdVN3cnBIcTh2WCt3?=
 =?iso-2022-jp?B?MnNvUHJiMnJSRlFJZHlWTTh5QXUvU1Arc3VrMCtKM0cwNjVoMWNYNk9i?=
 =?iso-2022-jp?B?Z3ZVTHNLdUtPb2tmN21mTGlWVUhwYk1lQk5NOXBWc1BhV3VScEdnYUpJ?=
 =?iso-2022-jp?B?VDRqT2hJVUZjbmNWQUFSSVlNKy9Md24yY3dJcStCb2U2QTRXUGxUTHdi?=
 =?iso-2022-jp?B?aHJ3VnNRZXhqT3E4L1djdGlPNnMyRStUZFJMWnR3WTNBaVZiUXh4Vnl2?=
 =?iso-2022-jp?B?RnA1NE5ubmV1dlpnb1dETjg2Y2cyNER4eGdIUTMyamlIaSsxTEwxeHNU?=
 =?iso-2022-jp?B?OGVoOWQ0UVZMMTBLZEYyRXhZQ0RXM2lkTlV5YWk3c3JQZjBObmx3cVF3?=
 =?iso-2022-jp?B?S2JBTi9jZFVWSHBPR212SEdOYjc4VTlqbFBUK0MrWjcrUGtGNEEvZ1Jj?=
 =?iso-2022-jp?B?WEhtNTBaL00zcWhKM0d4b0x0TmxvZHJPd2NKTWYrR0dYUS9mOWxaZk1t?=
 =?iso-2022-jp?B?VlgxRFN1UXU3Z0ZuNXBRdHBBT1A4ekdRM244YjUwbHErMnl6dFNsQlZu?=
 =?iso-2022-jp?B?R083THFwdXRQS3FTY0ZYS2VZZzNGVG42dS9KbHdrV1RoQktXOXhNWE5i?=
 =?iso-2022-jp?B?TnVHL2hXdDhqK01Zc0lVVjF6VTZTcXF4N1ZycG5UcmNvWitlZ3lKaXZH?=
 =?iso-2022-jp?B?MGdvOWhGcEZQRTJicFMvMkdVN21qOFV0YmJpU1dUbVcweDdMNkR2VFBL?=
 =?iso-2022-jp?B?aFNST1hsOHRNZzNvVzRFL3k5aU1qRUlCaGVsQko0OFRSeUZ4cXZtbTR0?=
 =?iso-2022-jp?B?Y3dQL0o2TDJzaUlMazUwNk1ucFM4bXR0OVBjOHRmWEZqR2ppMEVHdExi?=
 =?iso-2022-jp?B?SUhES1Jxa0dOb1J3TEtXTGYxQXJKY085MWp4MkhqNmdRTk0yZUI0aUpj?=
 =?iso-2022-jp?B?Z3pmTXpmZks3cjJUZVlua2ZmRDQyUnZiYVVEN3MvZGdGeFd2U290TmFp?=
 =?iso-2022-jp?B?THUydXE3NmVoeEhaa1lkMWxvb2lCaWZCdlZCNjYrUHJyNm5va0pkaGpF?=
 =?iso-2022-jp?B?VW1uekRNMnlmZEh4S3RvTzN6akNzRnFZME5kaDNaZnR3eUdQYkRlUkJa?=
 =?iso-2022-jp?B?M2JWWHpJRkNWbXhoQ1ZZclB1YjVzalZyMC9oMTJ0Mk0vTjkwbTVjYlA5?=
 =?iso-2022-jp?B?bUR6OTUrSDQraDhkcVlnVzJLSHE4QkxXQndGVlNLcEEyYUFIclhFa3NC?=
 =?iso-2022-jp?B?ZXA1MEFVQ00xbUZHTU5zZmZtcjNHemlGZVppNVRTdU1qNUVxL082T29u?=
 =?iso-2022-jp?B?V2s2MHBuRmhOcjNtSkJzd293U2xzQWIwYll3cFlqWFJKYXpJRm1Sb1pV?=
 =?iso-2022-jp?B?Qm1mamJwWjVFVUxITVNJN0JXTXVvK3NvRTZwU3d3cDBldXVvMTB3MW1V?=
 =?iso-2022-jp?B?K2tpN05GaU1Da1dubzB2bGVxblJZVmYxbVhTS1JDUWZHT3hnWG9IcXY0?=
 =?iso-2022-jp?B?OW5wMFQyUm5DcEdzc0RnS2VnZ0N2TVFZRUx6NWwwaXRFN2p4MDk5aXNj?=
 =?iso-2022-jp?B?cDl4cldkc3hzZzBDZGtMTDI0SmZwTVVMeHpiZjlpczBVNnNQNERPMU5p?=
 =?iso-2022-jp?B?QjUvUXVhVU0waFpBY3F4L1JwUHBMSER0ZldrVi8xWFJONWN5L3hwNGNJ?=
 =?iso-2022-jp?B?TGZ1a053bzlzdUZ1Q2lEaUNGcWpwbVdKdVd5Z0h6K3JSVU1Bd3hud1Rj?=
 =?iso-2022-jp?B?NVNLUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SnlCUXVvVFM1WlhzNDdzaWtsZGp0NGdkbVo4TnoyMEppUkVLaXJZOFUw?=
 =?iso-2022-jp?B?dzdIV0ZTblU1R3pWWjFLdDJwZVFHM2JvMFlERG50VndmTXFGT1lyTXN2?=
 =?iso-2022-jp?B?b1FHVnh0UXU0K2ltT1hVTUtnWDZJa0tlZDNJbnZyWDNBZ3pOOThSK0ho?=
 =?iso-2022-jp?B?YmUwYkhrYStRSFA3OTV2dmllaUsyUSt1cWx1S0piQTNuZUNDR05WOXBF?=
 =?iso-2022-jp?B?anpwWDU1RnM5YUFwNE0rRFpEV2VqSDZoaW1TUFUrMHEwUGkrRXRtZkdp?=
 =?iso-2022-jp?B?eEgxV1E3dWJ0UkNBc0xFc3YzeElBcjdCdld3NG12a2doV3hNLzJMM0xu?=
 =?iso-2022-jp?B?SmRUc1lTNERyNFl2NTBrV1BreEtnZ25JVC9hU2VBVWhHSXdSUVJ1Snk2?=
 =?iso-2022-jp?B?dVBjQmE2WlR4Z2ZtbXY4YVVsd281VEh2YklsaS91c3Z4emtEQTBGanlr?=
 =?iso-2022-jp?B?Ly9WcVk0SnhXMFhLZ0czdFMzMzAvdWtOYjBzV1lnOVEvbWpST2x5N0VT?=
 =?iso-2022-jp?B?cGdXZHRKK21GQzBGVTZpNEEydlo2cWZjejQ5Vmhvck5Na0JkSGxWcmto?=
 =?iso-2022-jp?B?U3hGakRkenJER2xDeSttY3J5aEtpVEo3a3d2cVZhV2ttdnpWaXovcXZQ?=
 =?iso-2022-jp?B?ZDdiazJaTWMyZGk5Y3ZoNDFGeE42ampwTDZ1dEsrTTR1bVVFU21HL0lK?=
 =?iso-2022-jp?B?cUVuNTV0L0JpL2xVLzNFOVJLWDFGdmR6UDJsR2pZbTg4dm9FODFXdHBo?=
 =?iso-2022-jp?B?ZVZXWTk3V1pMUnNpQUhZa1hjaXBaZzdOTkhDQ3hCOE5WakI2WSt4M1hV?=
 =?iso-2022-jp?B?b25VY1hYZzdSYWptSW44SGQyaEhPdnZOTkpacFBkZytIaVNqQzI5WWNQ?=
 =?iso-2022-jp?B?cHBIL2ZTN0t6RS9lWDFKYU0yTnlOMHRSNWZZdmxEa0dwVmxvaDhIRzZR?=
 =?iso-2022-jp?B?bUY4SENtTGxkOGZFWUNoOTJDVUhsVnY3SUd0amwvU2Rvdm1WRmQ0QUQv?=
 =?iso-2022-jp?B?MU9QQUFUU0FhTWNROWsyU0FydERyQ3Q5RTI2Y05pbXQyMnYzUzRMekpw?=
 =?iso-2022-jp?B?eXVFV0FwMkxFNXRGQzNhOE93L2NIaHVlRWN3Vmp3R20zcjd4K2RRNEZr?=
 =?iso-2022-jp?B?eWY1VGdhS08vUkNBQXEvTWRHRzFMRzBxVWxqNDRaSVJzSjRDRm5peE01?=
 =?iso-2022-jp?B?cDJ0WlZ1cm8vSFpwKythZFdDWGV3N2J5OGdsa1B5aE5LZk5rUXYzSzJ3?=
 =?iso-2022-jp?B?UWxxVVBCOHBrcDVGTk5qRG5Ub0ZvS3FaNXhYKzNGS0xBUTRGMVpMMGZj?=
 =?iso-2022-jp?B?QnhQQUZzdlFUcERhcTAwSmdyZnVHNkMxdjZCVzJ5ZmpwNmlNbW1lMU5i?=
 =?iso-2022-jp?B?dVhzNHpBMi84Q2FHOVN2R2RLK1l6djd2WCttTTJ3eWwyVFVEM3VaS1Fw?=
 =?iso-2022-jp?B?MjBEQ0VQS2lrQTFrNnViU1dUTEJKTTQ4dGpnZTh0c3F5RE43UzVzeSty?=
 =?iso-2022-jp?B?cGFDZkNCRDFOMDc3WlZFZHl3WFVEcXpkcm55RVZQOGNDVlBudDZGWUFU?=
 =?iso-2022-jp?B?M3A4ZHF1RENSUjFIZ2NDM3RhejJVWkxmN21VUHA1NlI2SURIZDFKeVhY?=
 =?iso-2022-jp?B?NUN3aGU5bnM5Qmp1enhvbUtKd29KMStSNFFUK2p4dzlWNG5yYlRoWUYx?=
 =?iso-2022-jp?B?NWFtaElmVWxuME5hNExRY2RCM2F1dmI2OUt6a0djODhhNEpDWTFlRXlN?=
 =?iso-2022-jp?B?WVNlREx2Y0NrYVQvbExHSlFqckFFRDVRcVVCYzFIaWRlYms2RzdlTlhI?=
 =?iso-2022-jp?B?NHR1ekRsdmY5cEdmZ3ZtZkI5b1lMZi9CdWd1aHRMWUYxVFdYOU43OHlL?=
 =?iso-2022-jp?B?WnlzVUlqZzYwTjdiT0hDS05MZ3EwbUZtVUd0dVJrWEtLRVFHUGRwRjlt?=
 =?iso-2022-jp?B?S1pGT1hGQWxjZG1pVTBrVExEcUZ2Z3IxNUYwTERVTUtpMnZoLzJrSzVP?=
 =?iso-2022-jp?B?ZkhKdkxSZTArZ3c1RWE1OGhNa2xHMWp5WXY0RmYwVlRHYnpMUWE3bmxw?=
 =?iso-2022-jp?B?R0FQQllHYzNWV0JBVlA0Y2N0N2QrUUpVbXQ3WjRya1dsVnhaZUg1S0ts?=
 =?iso-2022-jp?B?MVdWSnpFOGNiNlVUL2pJVGNUUUhoOVRZcnhGUDlJMlZKYjdFKzFwOStx?=
 =?iso-2022-jp?B?U3B5cjQweTdIclhBWDg2MVVJUnJzSVZNaGQyTmhqTmJkVHFJS1p4WFVH?=
 =?iso-2022-jp?B?bkt4LzFYSTdGVGE1Sk9JQ3ZsVkZaUGRFcXVRZFFkaXNERHp2REVaZnlW?=
 =?iso-2022-jp?B?azI2K1R3Sll5c3ZyN1RqMEVaMGZpQVk0cXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5876ff8e-8531-4df9-4ef5-08de21b9451a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:01:14.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQxd0UtBFH8NyiMOp51KagiJerPdOE9MZJVO8Pr0hF+XcxmDr0mgXo9JAprDUFqDFfJVk53SgAHDayPQblUXKaXk5+92sQz3DjIszKO9Q8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15054

Hello Ben,

> From: James Morse <james.morse@arm.com>
>=20
> Add code to parse the arm64 specific MPAM table, looking up the cache lev=
el
> from the PPTT and feeding the end result into the MPAM driver.
>=20
> This happens in two stages. Platform devices are created first for the MS=
C
> devices. Once the driver probes it calls acpi_mpam_parse_resources() to
> discover the RIS entries the MSC contains.
>=20
> For now the MPAM hook mpam_ris_create() is stubbed out, but will update t=
he
> MPAM driver with optional discovered data about the RIS entries.
>=20
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=3Den
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> return irq from acpi_mpam_register_irq (Jonathan) err -> len rename
> (Jonathan) Move table initialisation after checking (Jonathan) Add sanity
> checking in acpi_mpam_count_msc() (Jonathan)
> ---
>  arch/arm64/Kconfig          |   1 +
>  drivers/acpi/arm64/Kconfig  |   3 +
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/mpam.c   | 403
> ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c       |   2 +-
>  include/linux/arm_mpam.h    |  47 +++++
>  6 files changed, 456 insertions(+), 1 deletion(-)  create mode 100644
> drivers/acpi/arm64/mpam.c  create mode 100644
> include/linux/arm_mpam.h
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> 67015d51f7b5..c5e66d5d72cd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2025,6 +2025,7 @@ config ARM64_TLB_RANGE
>=20
>  config ARM64_MPAM
>  	bool "Enable support for MPAM"
> +	select ACPI_MPAM if ACPI
>  	help
>  	  Memory System Resource Partitioning and Monitoring (MPAM) is an
>  	  optional extension to the Arm architecture that allows each diff --gi=
t
> a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig index
> b3ed6212244c..f2fd79f22e7d 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,6 @@ config ACPI_AGDI
>=20
>  config ACPI_APMT
>  	bool
> +
> +config ACPI_MPAM
> +	bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile in=
dex
> 05ecde9eaabe..9390b57cb564 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ACPI_APMT) 	+=3D apmt.o
>  obj-$(CONFIG_ACPI_FFH)		+=3D ffh.o
>  obj-$(CONFIG_ACPI_GTDT) 	+=3D gtdt.o
>  obj-$(CONFIG_ACPI_IORT) 	+=3D iort.o
> +obj-$(CONFIG_ACPI_MPAM) 	+=3D mpam.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE) +=3D cpuidle.o
>  obj-$(CONFIG_ARM_AMBA)		+=3D amba.o
>  obj-y				+=3D dma.o init.o
> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c new
> file mode 100644 index 000000000000..c199944862ed
> --- /dev/null
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Arm Ltd.
> +
> +/* Parse the MPAM ACPI table feeding the discovered nodes into the
> +driver */
> +
> +#define pr_fmt(fmt) "ACPI MPAM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/arm_mpam.h>
> +#include <linux/bits.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/platform_device.h>
> +
> +#include <acpi/processor.h>
> +
> +/*
> + * Flags for acpi_table_mpam_msc.*_interrupt_flags.
> + * See 2.1.1 Interrupt Flags, Table 5, of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IRQ_MODE
> BIT(0)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_MASK
> GENMASK(2, 1)
> +#define ACPI_MPAM_MSC_IRQ_TYPE_WIRED                        0
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK
> BIT(3)
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR           0
> +#define
> ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER 1
> +#define ACPI_MPAM_MSC_IRQ_AFFINITY_VALID
> BIT(4)
> +
> +/*
> + * Encodings for the MSC node body interface type field.
> + * See 2.1 MPAM MSC node, Table 4 of DEN0065B_MPAM_ACPI_3.0-bet.
> + */
> +#define ACPI_MPAM_MSC_IFACE_MMIO   0x00
> +#define ACPI_MPAM_MSC_IFACE_PCC    0x0a
> +
> +static bool _is_ppi_partition(u32 flags) {
> +	u32 aff_type, is_ppi;
> +	bool ret;
> +
> +	is_ppi =3D FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_VALID,
> flags);
> +	if (!is_ppi)
> +		return false;
> +
> +	aff_type =3D
> FIELD_GET(ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_MASK, flags);
> +	ret =3D (aff_type =3D=3D
> ACPI_MPAM_MSC_IRQ_AFFINITY_TYPE_PROCESSOR_CONTAINER);
> +	if (ret)
> +		pr_err_once("Partitioned interrupts not supported\n");
> +
> +	return ret;
> +}
> +
> +static int acpi_mpam_register_irq(struct platform_device *pdev,
> +				  int intid, u32 flags)
> +{
> +	int irq;
> +	u32 int_type;
> +	int trigger;
> +
> +	if (!intid)
> +		return -EINVAL;
> +
> +	if (_is_ppi_partition(flags))
> +		return -EINVAL;
> +
> +	trigger =3D FIELD_GET(ACPI_MPAM_MSC_IRQ_MODE, flags);
> +	int_type =3D FIELD_GET(ACPI_MPAM_MSC_IRQ_TYPE_MASK, flags);
> +	if (int_type !=3D ACPI_MPAM_MSC_IRQ_TYPE_WIRED)
> +		return -EINVAL;
> +
> +	irq =3D acpi_register_gsi(&pdev->dev, intid, trigger,
> ACPI_ACTIVE_HIGH);
> +	if (irq <=3D 0)
> +		pr_err_once("Failed to register interrupt 0x%x with ACPI\n",
> intid);
> +
> +	return irq;
> +}
> +
> +static void acpi_mpam_parse_irqs(struct platform_device *pdev,
> +				 struct acpi_mpam_msc_node *tbl_msc,
> +				 struct resource *res, int *res_idx) {
> +	u32 flags, intid;
> +	int irq;
> +
> +	intid =3D tbl_msc->overflow_interrupt;
> +	flags =3D tbl_msc->overflow_interrupt_flags;
> +	irq =3D acpi_mpam_register_irq(pdev, intid, flags);
> +	if (irq > 0)
> +		res[(*res_idx)++] =3D DEFINE_RES_IRQ_NAMED(irq,
> "overflow");
> +
> +	intid =3D tbl_msc->error_interrupt;
> +	flags =3D tbl_msc->error_interrupt_flags;
> +	irq =3D acpi_mpam_register_irq(pdev, intid, flags);
> +	if (irq > 0)
> +		res[(*res_idx)++] =3D DEFINE_RES_IRQ_NAMED(irq, "error"); }
> +
> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
> +				    struct acpi_mpam_resource_node *res) {
> +	int level, nid;
> +	u32 cache_id;
> +
> +	switch (res->locator_type) {
> +	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
> +		cache_id =3D res->locator.cache_locator.cache_reference;
> +		level =3D find_acpi_cache_level_from_id(cache_id);
> +		if (level <=3D 0) {
> +			pr_err_once("Bad level (%d) for cache with id %u\n",
> level, cache_id);
> +			return -EINVAL;
> +		}
> +		return mpam_ris_create(msc, res->ris_index,
> MPAM_CLASS_CACHE,
> +				       level, cache_id);
> +	case ACPI_MPAM_LOCATION_TYPE_MEMORY:
> +		nid =3D
> pxm_to_node(res->locator.memory_locator.proximity_domain);
> +		if (nid =3D=3D NUMA_NO_NODE) {
> +			pr_debug("Bad proxmity domain %lld, using node 0
> instead\n",
> +
> res->locator.memory_locator.proximity_domain);
> +			nid =3D 0;
> +		}
> +		return mpam_ris_create(msc, res->ris_index,
> MPAM_CLASS_MEMORY,
> +				       255, nid);
> +	default:
> +		/* These get discovered later and are treated as unknown */
> +		return 0;
> +	}
> +}
> +
> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc) {
> +	int i, err;
> +	char *ptr, *table_end;
> +	struct acpi_mpam_resource_node *resource;
> +
> +	ptr =3D (char *)(tbl_msc + 1);
> +	table_end =3D ptr + tbl_msc->length;
> +	for (i =3D 0; i < tbl_msc->num_resource_nodes; i++) {
> +		u64 max_deps, remaining_table;
> +
> +		if (ptr + sizeof(*resource) > table_end)
> +			return -EINVAL;
> +
> +		resource =3D (struct acpi_mpam_resource_node *)ptr;
> +
> +		remaining_table =3D table_end - ptr;
> +		max_deps =3D remaining_table / sizeof(struct
> acpi_mpam_func_deps);
> +		if (resource->num_functional_deps > max_deps) {
> +			pr_debug("MSC has impossible number of functional
> dependencies\n");
> +			return -EINVAL;
> +		}
> +
> +		err =3D acpi_mpam_parse_resource(msc, resource);
> +		if (err)
> +			return err;
> +
> +		ptr +=3D sizeof(*resource);
> +		ptr +=3D resource->num_functional_deps * sizeof(struct
> acpi_mpam_func_deps);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Creates the device power management link and returns true if the
> + * acpi id is valid and usable for cpu affinity.  This is the case
> + * when the linked device is a processor or a processor container.
> + */
> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node
> *tbl_msc,
> +				     struct platform_device *pdev,
> +				     u32 *acpi_id)
> +{
> +	char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1] =3D { 0 };
> +	bool acpi_id_valid =3D false;
> +	struct acpi_device *buddy;
> +	char uid[11];
> +	int len;
> +
> +	memcpy(hid, &tbl_msc->hardware_id_linked_device,
> +	       sizeof(tbl_msc->hardware_id_linked_device));
> +
> +	if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
> +		*acpi_id =3D tbl_msc->instance_id_linked_device;
> +		acpi_id_valid =3D true;
> +	}
> +
> +	len =3D snprintf(uid, sizeof(uid), "%u",
> +		       tbl_msc->instance_id_linked_device);
> +	if (len >=3D sizeof(uid)) {
> +		pr_debug("Failed to convert uid of device for power
> management.");
> +		return acpi_id_valid;
> +	}
> +
> +	buddy =3D acpi_dev_get_first_match_dev(hid, uid, -1);
> +	if (buddy)
> +		device_link_add(&pdev->dev, &buddy->dev,
> DL_FLAG_STATELESS);
> +
> +	return acpi_id_valid;
> +}
> +
> +static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
> +				 enum mpam_msc_iface *iface)
> +{
> +	switch (tbl_msc->interface_type) {
> +	case ACPI_MPAM_MSC_IFACE_MMIO:
> +		*iface =3D MPAM_IFACE_MMIO;
> +		return 0;
> +	case ACPI_MPAM_MSC_IFACE_PCC:
> +		*iface =3D MPAM_IFACE_PCC;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static struct platform_device * __init acpi_mpam_parse_msc(struct
> +acpi_mpam_msc_node *tbl_msc) {
> +	struct platform_device *pdev __free(platform_device_put) =3D
> +		platform_device_alloc("mpam_msc", tbl_msc->identifier);
> +	int next_res =3D 0, next_prop =3D 0, err;
> +	/* pcc, nrdy, affinity and a sentinel */
> +	struct property_entry props[4] =3D { 0 };
> +	/* mmio, 2xirq, no sentinel. */
> +	struct resource res[3] =3D { 0 };
> +	struct acpi_device *companion;
> +	enum mpam_msc_iface iface;
> +	char uid[16];
> +	u32 acpi_id;
> +
> +	if (!pdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Some power management is described in the namespace: */
> +	err =3D snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);

It's a bit strange to store the uid length in the variable err.
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

> +	if (err > 0 && err < sizeof(uid)) {
> +		companion =3D acpi_dev_get_first_match_dev("ARMHAA5C",
> uid, -1);
> +		if (companion)
> +			ACPI_COMPANION_SET(&pdev->dev, companion);
> +		else
> +			pr_debug("MSC.%u: missing namespace entry\n",
> +				 tbl_msc->identifier);
> +	}
> +
> +	if (decode_interface_type(tbl_msc, &iface)) {
> +		pr_debug("MSC.%u: unknown interface type\n",
> tbl_msc->identifier);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (iface =3D=3D MPAM_IFACE_MMIO)
> +		res[next_res++] =3D
> DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
> +
> tbl_msc->mmio_size,
> +						       "MPAM:MSC");
> +	else if (iface =3D=3D MPAM_IFACE_PCC)
> +		props[next_prop++] =3D
> PROPERTY_ENTRY_U32("pcc-channel",
> +
> 	tbl_msc->base_address);
> +
> +	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
> +
> +	WARN_ON_ONCE(next_res > ARRAY_SIZE(res));
> +	err =3D platform_device_add_resources(pdev, res, next_res);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	props[next_prop++] =3D PROPERTY_ENTRY_U32("arm,not-ready-us",
> +						tbl_msc->max_nrdy_usec);
> +
> +	/*
> +	 * The MSC's CPU affinity is described via its linked power
> +	 * management device, but only if it points at a Processor or
> +	 * Processor Container.
> +	 */
> +	if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id))
> +		props[next_prop++] =3D
> PROPERTY_ENTRY_U32("cpu_affinity", acpi_id);
> +
> +	WARN_ON_ONCE(next_prop > ARRAY_SIZE(props));
> +	err =3D device_create_managed_software_node(&pdev->dev, props,
> NULL);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	/*
> +	 * Stash the table entry for acpi_mpam_parse_resources() to discover
> +	 * what this MSC controls.
> +	 */
> +	err =3D platform_device_add_data(pdev, tbl_msc, tbl_msc->length);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	err =3D platform_device_add(pdev);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return_ptr(pdev);
> +}
> +
> +static int __init acpi_mpam_parse(void) {
> +	char *table_end, *table_offset;
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	struct platform_device *pdev;
> +
> +	if (acpi_disabled || !system_supports_mpam())
> +		return 0;
> +
> +	struct acpi_table_header *table __free(acpi_put_table) =3D
> +		acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +
> +	if (IS_ERR(table))
> +		return 0;
> +
> +	if (table->revision < 1)
> +		return 0;
> +
> +	table_offset =3D (char *)(table + 1);
> +	table_end =3D (char *)table + table->length;
> +
> +	while (table_offset < table_end) {
> +		tbl_msc =3D (struct acpi_mpam_msc_node *)table_offset;
> +		table_offset +=3D tbl_msc->length;
> +
> +		if (table_offset > table_end) {
> +			pr_err("MSC entry overlaps end of ACPI table\n");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * If any of the reserved fields are set, make no attempt to
> +		 * parse the MSC structure. This MSC will still be counted by
> +		 * acpi_mpam_count_msc(), meaning the MPAM driver can't
> probe
> +		 * against all MSC, and will never be enabled. There is no way
> +		 * to enable it safely, because we cannot determine safe
> +		 * system-wide partid and pmg ranges in this situation.
> +		 */
> +		if (tbl_msc->reserved || tbl_msc->reserved1 ||
> tbl_msc->reserved2) {
> +			pr_err_once("Unrecognised MSC, MPAM not
> usable\n");
> +			pr_debug("MSC.%u: reserved field set\n",
> tbl_msc->identifier);
> +			continue;
> +		}
> +
> +		if (!tbl_msc->mmio_size) {
> +			pr_debug("MSC.%u: marked as disabled\n",
> tbl_msc->identifier);
> +			continue;
> +		}
> +
> +		pdev =3D acpi_mpam_parse_msc(tbl_msc);
> +		if (IS_ERR(pdev))
> +			return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * acpi_mpam_count_msc() - Count the number of MSC described by
> firmware.
> + *
> + * Returns the number of MSC, or zero for an error.
> + *
> + * This can be called before or in parallel with acpi_mpam_parse().
> + */
> +int acpi_mpam_count_msc(void)
> +{
> +	char *table_end, *table_offset;
> +	struct acpi_mpam_msc_node *tbl_msc;
> +	int count =3D 0;
> +
> +	if (acpi_disabled || !system_supports_mpam())
> +		return 0;
> +
> +	struct acpi_table_header *table __free(acpi_put_table) =3D
> +		acpi_get_table_ret(ACPI_SIG_MPAM, 0);
> +
> +	if (IS_ERR(table))
> +		return 0;
> +
> +	if (table->revision < 1)
> +		return 0;
> +
> +	table_offset =3D (char *)(table + 1);
> +	table_end =3D (char *)table + table->length;
> +
> +	while (table_offset < table_end) {
> +		tbl_msc =3D (struct acpi_mpam_msc_node *)table_offset;
> +
> +		if (tbl_msc->length < sizeof(*tbl_msc))
> +			return -EINVAL;
> +		if (tbl_msc->length > table_end - table_offset)
> +			return -EINVAL;
> +		table_offset +=3D tbl_msc->length;
> +
> +		if (!tbl_msc->mmio_size)
> +			continue;
> +
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
> +/*
> + * Call after ACPI devices have been created, which happens behind
> +acpi_scan_init()
> + * called from subsys_initcall(). PCC requires the mailbox driver,
> +which is
> + * initialised from postcore_initcall().
> + */
> +subsys_initcall_sync(acpi_mpam_parse);
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index
> 57fc8bc56166..4286e4af1092 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE]
> __nonstring_array __initconst
>  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>  	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> -	ACPI_SIG_NBFT, ACPI_SIG_SWFT};
> +	ACPI_SIG_NBFT, ACPI_SIG_SWFT, ACPI_SIG_MPAM};
>=20
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>=20
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h new file
> mode 100644 index 000000000000..a3828ef91aee
> --- /dev/null
> +++ b/include/linux/arm_mpam.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2025 Arm Ltd. */
> +
> +#ifndef __LINUX_ARM_MPAM_H
> +#define __LINUX_ARM_MPAM_H
> +
> +#include <linux/acpi.h>
> +#include <linux/types.h>
> +
> +#define GLOBAL_AFFINITY		~0
> +
> +struct mpam_msc;
> +
> +enum mpam_msc_iface {
> +	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
> +	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
> +};
> +
> +enum mpam_class_types {
> +	MPAM_CLASS_CACHE,       /* Caches, e.g. L2, L3 */
> +	MPAM_CLASS_MEMORY,      /* Main memory */
> +	MPAM_CLASS_UNKNOWN,     /* Everything else, e.g. SMMU */
> +};
> +
> +#ifdef CONFIG_ACPI_MPAM
> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +			      struct acpi_mpam_msc_node *tbl_msc);
> +
> +int acpi_mpam_count_msc(void);
> +#else
> +static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
> +					    struct acpi_mpam_msc_node
> *tbl_msc) {
> +	return -EINVAL;
> +}
> +
> +static inline int acpi_mpam_count_msc(void) { return -EINVAL; } #endif
> +
> +static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8
> class_id,
> +				  int component_id)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif /* __LINUX_ARM_MPAM_H */
> --
> 2.43.0


