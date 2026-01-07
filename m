Return-Path: <linux-acpi+bounces-19985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804FCFBC88
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 03:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0CF301AD0F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 02:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7E246BD5;
	Wed,  7 Jan 2026 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PS8VATYn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011012.outbound.protection.outlook.com [52.101.125.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC141A704B;
	Wed,  7 Jan 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754358; cv=fail; b=H2Buy75XBrEUaqZB5cXWU6u2qblj9TkxmboT21J7qFQGztH58ajo2Efn+BamZRx4ZLdbiHW/ObwvnoVUzm6IBlSHr9aEMzQuD2tI3yxS6LkE9TbaGM93N6O3VidR8GWguzI5aGcCS/j6ly4ROC7smMU7WErrF56MTz3QQEXfqSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754358; c=relaxed/simple;
	bh=oGQPNBHGGYdjfgaPWgmbaarGfUTvwfqeQFBVJaavrHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZc1C6BB+6MwckEJ4z6b4c5g4J5kDwlzZZGYQ8mPz3HsoS91R9uBJVnBjkLtyg/pWRP3uvNlYFuTQvHqvNyOq5CK2YgUadt3Z1oycKnQhr+PjSUEa2AR+vjgl+zYHp3pOtvdQdhtLiaq09Ky0bOsww8ACZVtI/+E7/Q0FjuzMXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PS8VATYn; arc=fail smtp.client-ip=52.101.125.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYhwQ/ATXNZEyZKzBFB3KH7+7JHn2I6lekzOka3UrrfH7V++wK5RmpbhncwuGea8EQMfBcpWtBgrjizS2X1r4Q6BS21dl6oM3ms3AZB6WTNuRwcLuvSPFKRNTvO62GmZPdQR9XIwh7z/znM1NkhzOrJCTuyjOpKqhreicfJrG6sXe8Vsuag2YSJ8th3WWZRBdOtVKB0ApMm6HRnULRncjTNpVv+itvPHk3H3bk+U1mqwzXLV7NZ8tMNbW39sgHW/UmX9zh7xyOayns0S+HV9Ou3AeoRqa61y8lSBBSnODPTOVcPxU8nbh4s4Bdva/G4RskfDMKAZ6bJiTM1jufEuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lVqs3EvNFpeseTl+9jk0QAByensczTBirE++lQLTKc=;
 b=qqhUArpMJq9Wp9mHDcGagj8JsYkxZxviYfCnk2LfuHaTF4VFV0rxvj0Nf23R0J/lQznswnEmiRlTgHor5jrrf53n5p0PmTxn92gA8uo4HA+BvMjX+FimEwWqSvLFlVXmHLLOsQKXjVa0f4a9k/oOiNHBQd/Qf24Q8z4g2Qt5TZZDgaXhu8+/wWnbcUnvM895f/E+NWdBryn0K+WN63gMboLVFPW/ID8yQHhBLZHidWAuXQT2ricxJnG7CqaNWyH9mWtXZsP3YTQUZxdPEuwbnN91zkr2bLKCaVNCdiZnnmgHw+NJqf7JrVcS8lnd2qG6sxfHcrNdpZtxloofcYyj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lVqs3EvNFpeseTl+9jk0QAByensczTBirE++lQLTKc=;
 b=PS8VATYnuLL7phQHsXGkusx/ZuoesqH4Kvch/qExJmhGCUfWU3Q/QZHOo2zSlJTgVimz5pkSbEmaGq/vFJfXtQ9XLmT11oBnXl4UlDzGAiPqKil7XX6EgB2w40ila0PR4V24UhxqEcgw+z+aLOPdOueakjHeNTy+ni5Mr+XSIKdPfKfaF44aXuQ4x1DV95l12gRwjcUkzR6wX6GyvO9ocb/4uToCSfZ8xOjo2bYGktITKxYwajbA0blXH4RMn/1UmjCIvpCaWsCM+juyTX0HiYH7h4AC7boepdejHopI5MuZmKewGGmKo9eks/ior+dVS5HGHo2i3PaYQNBsCludnw==
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com (2603:1096:604:3f2::7)
 by OSZPR01MB8292.jpnprd01.prod.outlook.com (2603:1096:604:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 02:52:33 +0000
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a]) by OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 02:52:33 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Will Deacon' <will@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Koichi Okuno (Fujitsu)"
	<fj2767dz@fujitsu.com>, "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [PATCH v5] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v5] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHccw/MoUAWv391kEu2DGiF5vAvULVER3OAgACMRdCAAGnMgIAA226Q
Date: Wed, 7 Jan 2026 02:52:33 +0000
Message-ID:
 <OSCPR01MB16310A6CF68901C55C6490F58D584A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
References: <20251222065359.27330-1-fj1078ii@aa.jp.fujitsu.com>
 <176764598538.1443384.12447831892240359560.b4-ty@kernel.org>
 <OSCPR01MB16310961C8744194C94C51CAED587A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
 <aV0Qd3k-MXVJXlP5@willie-the-truck>
In-Reply-To: <aV0Qd3k-MXVJXlP5@willie-the-truck>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=d48bb331-724d-411a-ac0a-09e0044bb97f;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2026-01-07T02:52:12Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB16310:EE_|OSZPR01MB8292:EE_
x-ms-office365-filtering-correlation-id: ba40e8ea-c4d4-4207-f4fd-08de4d97ceb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZFFPTWZRVWdaUnhoeThublduM3hwdUoxS3VUWlQva0ppMUpmdEZLN2Ix?=
 =?iso-2022-jp?B?d1VXZUw0eDY4L2pYMUdXVzRHdlVzS09lKzgzbWZUSFk4dXFNYVpIb1ZP?=
 =?iso-2022-jp?B?ZTBmdk1aUHpHemlZbmJwUFVvbWVmQkRxWjI3Z2RkWXVSY2NWWEREeXdu?=
 =?iso-2022-jp?B?eVBkcDF0ODJZM0hadFBwRGVLa2xPMXZiMi9RTklHeEVuY3NDT3NPR0JH?=
 =?iso-2022-jp?B?cjcxUWxMS2E0ZE1kODRxZ1hZWGZlZW9ub2tDWHh3RTA4ZVdrRFVVejY3?=
 =?iso-2022-jp?B?K0NJcjFYdVZoeHgrYitUWWtnTHp2U1BPaU5tTTBBVlNSQVE4R2Nqb3Jy?=
 =?iso-2022-jp?B?cmdWUjBZM2dsR2k1Y2RGTUJpT3M0NmZwbEgwa2NUS3FCWGxQZGVsS0Fn?=
 =?iso-2022-jp?B?T0tnQTZ0Z0M0TjVUUytFU25FZVVwUXlDWW9OZWhKYnVRa0ZrNTVodEVo?=
 =?iso-2022-jp?B?ODlUWDVoam1naEFTMGVuQ2VhZWZZTW4rUE52OXhXUUk4citZNmVFM1lw?=
 =?iso-2022-jp?B?a0M5M0ovZFVKVUhGRGVpWXBOSjcyQ3ZpOTNoc1J1OC9PNUJvWFpVUStS?=
 =?iso-2022-jp?B?cjZ5UEtNUnZBMW5ZT01lb1ZXQSt0Q0VHN0lYUjFSYXJoOGltdGJqTDRP?=
 =?iso-2022-jp?B?Y1pNdWNvV1FObWlVNW1GbjJDaktXeVp3S2xySjJhcFJaWExuUHRsTkww?=
 =?iso-2022-jp?B?Z0lzekFyTGtDd3RPYlRMWG9xTVZIeC9YRVpENEN1aG5oajJ4djJsNDFE?=
 =?iso-2022-jp?B?a0VMQnNwWHZBY0htZ3gzd1I5SlFXb2d5OGlyV2w4eU9GblZyNGpLM01T?=
 =?iso-2022-jp?B?UkhGeVlRbEJ2SzZBMkRWbmVNbjJNbGhsSEZ6dEZReThWZDJOanYvVjAx?=
 =?iso-2022-jp?B?YjlLMThkeDA1ekl1Vlo0T2V6amd1czJMenFZdG51TGdPYkQxbXVDcjZG?=
 =?iso-2022-jp?B?Rkh6Tzd0cmdMNWl5SWN0RXNnbnE4RnluVmplbzhDQWR2V0tmdGRQbThl?=
 =?iso-2022-jp?B?SXg3c0JkR3NTZE1UQmQ1Ulk4Zk9vbnJBVncwODduT1A5VVduU3ZaQWZZ?=
 =?iso-2022-jp?B?L042YXpLWFc0Zk5HZGZmQ1VBTUJVNmdlSzE3dyt6dDNySlNiazVkeCtC?=
 =?iso-2022-jp?B?RDA2K3NSWGt4VVltdWRDQkNTUnAxaXhUTGFRd25nZlk0S1ErSG9HWmlj?=
 =?iso-2022-jp?B?NmN4VXRmT1BiKzVXYThDNlB2SVBnMVc1MDJnaXJ1TXFTczF3RVVXMXJ3?=
 =?iso-2022-jp?B?aXlSaklpU29PVXRMVnphT0VnVDlDRmtkb0ZwYWlERGcxem1BQSsvZGJl?=
 =?iso-2022-jp?B?Qm53SmtqY09YOUgyV3plemNvYlVvalJxKzNLL0xpY1hVcVZoUG1nM2lW?=
 =?iso-2022-jp?B?Y2FUcFVodDRRd1psWEVDczNvTTdqVnpLdjlzdHlnT3h5MFpvdkp5dkYv?=
 =?iso-2022-jp?B?dExJdFJNWEppU0gvT3E1YkJuaEFJNUxGZkVCejFQR2JwMjExdkdNcWNL?=
 =?iso-2022-jp?B?SUJyMTZOTEQ4ZGNtMnZzMHBZckwzVXh4N2VPeWxINFRCTHFPT3cvTkdC?=
 =?iso-2022-jp?B?SmVrQlR0QnZ1cDdSV29qYXZEV3dFQU1rMGpkV0dva09kNnF2RmJIWHdN?=
 =?iso-2022-jp?B?MGpOeFdQRWdudG40R2JBeC9wTG43Q2dXbXV4OEZoaGJlT29pT3NiaVpp?=
 =?iso-2022-jp?B?S29BTE5qM2R5WlJnZmJGdUNxN0VneDgrNUw0dTFCVmw0azVMeUNGQ0I3?=
 =?iso-2022-jp?B?YkZwcjNmbWdBVXVyaVUxNlJlNHA4N1ZxWG5lQUI0MmhnbzQxd3ZOK3BU?=
 =?iso-2022-jp?B?eU1qZk5iWFUyM2JNUjBZajBQeUs5VkFWNnU3aXl0RTRSSHM3QVhKMjRP?=
 =?iso-2022-jp?B?bG4zb0xONFVEVVlBcExuekYyTHdZdlFoVkRKcHFmekZvQ3V6VDhVWS9n?=
 =?iso-2022-jp?B?K3VhcUc4cVhhWUFhR0d5bGkyVUVvL0Fob0RTRmhRbHZLN3ZnYThtN2Vk?=
 =?iso-2022-jp?B?NzZud2N5WVFINWtQaTJRaVdKNzR0Q216NWFxcHhIUGVnV2NnN2U5bkd1?=
 =?iso-2022-jp?B?cHJCZzkyMXhEOUZUK2lLQTNFS3dHNEd6NWY0SVFnZFlPRTZoUjZETnkx?=
 =?iso-2022-jp?B?VHh2dVRkZGhyN2p5c2FCdXVtU1ZaV0NlTHFGYXRsL05EbGN3SnZpYXpH?=
 =?iso-2022-jp?B?Q0RXQmtqaGNvWGo5cWlXK3NrTnpveFZZc05uYmZaVDYwWVlkMCtLc2ZD?=
 =?iso-2022-jp?B?dXliRk5WYzdrVmNSZ2FrMXZiSU95Y3lJST0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB16310.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MTYrRTgrcVhDS01BaDFPeFlwbVlOYmxwVW9aR3g1c1g4dTBTZFcxbGpu?=
 =?iso-2022-jp?B?aHp0d21JY1BaanJxenVlTlpLOVlHT2Q4ZWdNcktaK3U4ZHhERlRwS3F1?=
 =?iso-2022-jp?B?MVUrSW9wdjJFd2JqK2hGWFRJcmtwTGVaV1cxTVR6QVN1SHpydTdCb1RN?=
 =?iso-2022-jp?B?aXBKZUZ4aW82RTBwRytiZDlHa0IrVHh3RzVuUzBQNk5IQ2kzSTJ5cXB0?=
 =?iso-2022-jp?B?cFRlZDZTNnQyRERpRWJhaU9FbkRVRHVsUnMxK3dQT1ZOVGhpQmRzUWVH?=
 =?iso-2022-jp?B?dTYwempseTFpQ1VFUkVoVFlxT0N5WUlaZTdnNGF1VVZNMGFod05COUx5?=
 =?iso-2022-jp?B?ZElzZFZ5dGtmcmNmWHc0R0NONDBGa2hURSs0cGRMbk92ZjFycnEyVVFz?=
 =?iso-2022-jp?B?OUMzemd5MnV4aDV5OUkrbmtsYjMzaTB4SFBKTlpnbWpoTFhqTk5VMlhN?=
 =?iso-2022-jp?B?OGwrWEZEdE5wVUlmYXlvcjNSc0dHL2lIMnUrQnNScEFSd3JDdU0yT25L?=
 =?iso-2022-jp?B?bzJpNDJyU1BVSkxRVXFCYWwrYkcrL3I5OTlqbVJYVVdzQlZYRWJpYkNt?=
 =?iso-2022-jp?B?blRsd211WklNRHhpbmtrcUU4QjNweFZROXpueVdMbG1TWXFqSVFIRUlN?=
 =?iso-2022-jp?B?cWlmZ0xHRTdEdFI4WU1xWU44ckR4eGJMKzZWM1dXaTNVZkVsRVVOd0ZN?=
 =?iso-2022-jp?B?Z2lnY2RmZVlrM1lzUXNwVUZFSTFYQ1lPVWFkYWRKb1FwSDNJWDFtQmpl?=
 =?iso-2022-jp?B?bGNTRG9rYkpMTnBZRGVVMDNBbHdORTlnNVVDMUcvdW1Dc1ZlUmpTZHBm?=
 =?iso-2022-jp?B?bk1LS1Z4NGx4bTFNZ016MnIrTzVYZjdURnhORUc2VDhtL2xtK0lXcTlj?=
 =?iso-2022-jp?B?VjlyRTNON1luWVpFRWRJdFVpZ1JUUlFWbmt6VDNnbUMvV1h5V1Btd3Y1?=
 =?iso-2022-jp?B?MWx1ZFkxNmYzUVZ5UVl0MGI0a0ppQlBIVVBoZW5BY2xQTEFTUURMdlhE?=
 =?iso-2022-jp?B?OWFOWG9nenQ1dFVUTytZamF3ekp5Z2xnWnFCcVVQUDk1amJiV2k3WlBi?=
 =?iso-2022-jp?B?RnZ5aWd6TEJqalB1Nkg4WTZiNFFKYTZEM2dKckVxbmlEYjBTMXp5d0JB?=
 =?iso-2022-jp?B?Z3ltTnRoRWliN09IempEclNQeVk1bUs5dGlaeHBzelUxclozUndyRHBY?=
 =?iso-2022-jp?B?YStON21aRi9mUmhOMmlQVUJ3cndtK0F0Q2gzd3dDYjl3VkdIY284d2hT?=
 =?iso-2022-jp?B?U3RWTG5peWlCSitZOTFONUg3U1Z0d1U0WmpveDh2aTZDajZtRTZhMk5z?=
 =?iso-2022-jp?B?VzAzdjczQnJXOWJBeGllT21XT1ZrNU9lUnQwU1NtaGdya0xzUFhXR3ph?=
 =?iso-2022-jp?B?ajBZVkRuNlZVdFNhYVM5M0haQU05b2daYXg0bFpLY2s3SFhjZ2ZxaGkr?=
 =?iso-2022-jp?B?cit6bEM5ai84QUoveHNPMkROamtQNDQwbC9mZXhIRFQ4YmZMSkMwNmxO?=
 =?iso-2022-jp?B?UThGcDkwbnVFd2NCYnV1MmRqenBQMktpQmxZbTd5Z2dkTU5xUHUyeFRV?=
 =?iso-2022-jp?B?bUVGWDJrSEs4d1R6NGNvS0FlWVc2K2lJaU41cElNUFVMYURLeVk4SnVQ?=
 =?iso-2022-jp?B?anhuV3RtbXZqcDh4UkJ6dDZtaU9raGFDZWY2bk5KZGhyOVUzTm9RQ1Z5?=
 =?iso-2022-jp?B?RkVTYld5ZDFVQ0o4Ynl0MEg3Szc5aTZNckRRemJGb2JPZ0Y0ZzZTemw3?=
 =?iso-2022-jp?B?d2ViZ0lXQ080ZGdzUTlhRjh1cG5LZWxIV2o4bjUzNDVZcmFqdWd4R1FC?=
 =?iso-2022-jp?B?aFMzRk0yNFk1ZXdJVGl4R0Nnekd6Z1RZcGJGNnlMOGk3akVjVldtbGkx?=
 =?iso-2022-jp?B?ZVplb040eHVDWEw5WmpSOVdrbndtME54SXVoY1h4c2x1cGlVWFNiQzk3?=
 =?iso-2022-jp?B?VzhlYmtvOVhZcTVNWGVGMy9McWRjYXpkK1ppUGJnd2R6Umk0c0tEbWxl?=
 =?iso-2022-jp?B?ZVN5WFJSbHd5OVc1aENyMlVmejBSQ285NnJieWxFWjNnSEVpZCtaMjBN?=
 =?iso-2022-jp?B?Tm4rYkY2bWZzQXNtNVZ6TFArZWdLZElxNk4vejJXUnZDNlhzeHB6RWhm?=
 =?iso-2022-jp?B?bU1nTXFjUU9uRGxqUFBKVHU1N2dWTS9HUmpzY25ZcXk3VG91dUVTTU9u?=
 =?iso-2022-jp?B?VGduU0xMaTdIRWxWRG5mbDRnQlhNYzJqbDhkczJaeEU4NGJoREU0Nys5?=
 =?iso-2022-jp?B?RmpYa3BtQi9xdjJPLzBIQVowcElhNWN1aEdBN05CbTZMZEJBeFhoUTVG?=
 =?iso-2022-jp?B?dy8yZzFkc3VXMzRRQml3UnRDbURMRWJnVmdiRm5uK0VadHErdWxncm1y?=
 =?iso-2022-jp?B?RmIyKzh0RWJ4QVlwc1phbWxLR2Z5K3JHM1VTT3pSSWVSbHluVlZIOTZY?=
 =?iso-2022-jp?B?NXRaNkpLZzl1THBxbHZaTTVQd2RMZWY4dGp2azNUWGFRckFtR3dSRm54?=
 =?iso-2022-jp?B?cnRVckc4Nk5lOWRlZWlaTFc2VkszcThOTFUvZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB16310.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba40e8ea-c4d4-4207-f4fd-08de4d97ceb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 02:52:33.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWgmIRi4V2e9im83xHvUitkXLTn584Kvzt2idYzzI1MwmUyhBe4sCBSkeOaevVK9PDWYv3YO8r0ItYTCFNaMeNyLy0nCIUW1pnxGewqLlmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8292

Hi Will,

> > > > AGDI has two types of signaling modes: SDEI and interrupt.
> > > > Currently, the AGDI driver only supports SDEI.
> > > > Therefore, add support for interrupt signaling mode.
> > > > The interrupt vector is retrieved from the AGDI table, and call
> > > > panic function when an interrupt occurs.
> > > >
> > > >
> > > > [...]
> > >
> > > Applied to arm64 (for-next/acpi), thanks!
> > >
> > > [1/1] ACPI: AGDI: Add interrupt signaling mode support
> > >       https://git.kernel.org/arm64/c/9296d4fd190f
> >
> > Thank you for applying the patch.
> >
> > I apologize, but there was a mistake in the v5 patch I submitted.
> > I mistakenly sent an older version (v1) instead of the intended v4.
> >
> > Could you please revert commit "9296d4fd190f in for-next/acpi" ?
> > I will properly prepare and resubmit the correct v6 patch, which
> > contains the intended changes from v4, as soon as possible.
> >
> > Thank you for your understanding and cooperation.
>=20
> Not at all, thanks for letting me know. I can just rewind HEAD on for-nex=
t/acpi. I
> look forward to v6!

Thanks so much, Will!
I'll send v6 once it's ready.

Best Regards,
Kazuhiro Abe
>=20
> Will

