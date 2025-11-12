Return-Path: <linux-acpi+bounces-18797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D6C510AC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 09:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF7E189D3D8
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3D2D0628;
	Wed, 12 Nov 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aQUtFd6m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010028.outbound.protection.outlook.com [52.101.229.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F66283FEE;
	Wed, 12 Nov 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934611; cv=fail; b=f/lr1UDc3BIWdfDp93OP6jPOx/hCohZm5esdgyCRxiMVCNlZExytQNp7Neiy7Z9YTzwjhNipO32N/Hjz1tXS0iCAXyJkaRJcoYfxnnddVSp05CmTttUpKsFQcV+V9iZt94QdiVqPRIavuFj8tkAQatCPDUEWyrl2wb8fNMjTTtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934611; c=relaxed/simple;
	bh=NknS/ex1/kQ3dwPCG5VjmpUAKzBy9Ee/pvkm71Txa48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSueV7sS9UIUv3yZ8jIeKAiyWsV+YpxOs12jcAx3STar1biSDLCII2wl9YnRU7atUp6+AVRSbAztp+rDZvYhV0LrAfU7fexwR1zvDJV0orYMXCSd8plC1VzU+KixubJhWhFk93e4ZMhkuBp97OTq1YGcgBXW9/G6fc3eOdtoGr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aQUtFd6m; arc=fail smtp.client-ip=52.101.229.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlcuTjMAYPA5qQ00bOQhZmn9Mz73PwOehqwYnPDFRhl00DAS/7+I6+EQDNSU7bGUPlLVzp2qa0lNpAFOgtbR30ZysFkfw1dPfrUwROtPTJUpE9D4zvlE01b5O9CBnqJqZ3W8C2+2UPN+u/6LOPR2J0L8P8i3NQb/WND8T0AMYSj8b39j4siWUccgVy2WYzMnYBr/MBbgj1CRHZtpqxMLFC8WQ0CfqVVp1/mpQoHrSPrdhRSBSW4NWirA9EL6ZMX/4gcAv0Tk/lfRlJO/O1piCPcROkFvEUGAiSMVq6YUDE4QoIKChBo4owQAEn0l5NR2C0ycswb7bssVtT6IQE05wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NknS/ex1/kQ3dwPCG5VjmpUAKzBy9Ee/pvkm71Txa48=;
 b=bb1exvdfT8wyIJHPgxFLeQT0ba1q8GxvWanTXqPHG3b1N7U4ylAcpw1dPkvlCPzSbYnZnCWAVQRwFCtUqZwQslbxL3AaxDWLmhsNquwQtdxjyVtuTV+3TIBGwP5Dj1krTIAorTNprB/qxisxOklI/MCCyqbFpW2UonrCfI3VW40hRFhuDc5wzAI2MTM2ywuyyxJ5Vsq8KI1uRprmCE1Yd53VdDj8jqyKHVde6+/Z7JLeUN7H5Fxf9tOb2+WRjWyvpSKCVx0iiP98aa13kVRXLRuN/YRtzxi3zO36LFotHQBZUOhSUt828MWPhdvgLTPuZgc9a9FChdY3svUH4+c5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NknS/ex1/kQ3dwPCG5VjmpUAKzBy9Ee/pvkm71Txa48=;
 b=aQUtFd6mA+9fYmdQhpRqWu+kQS1HOClCrN/TyWrxUXC9/UvlOiN29rY0V74VsevCvi1PLzMHfWzZir0LubOXMKGBjCaCo09RrvPqR900cXjj1JvlG7ZMC0mCZi7IGQPvZDZmmF/ykZgnNGC1yX0CehUvPgs/637yNzX43lgA9gYP84wKDcJaPDXLR4znTtXhK0AWHzVbkG0Y+uD4Qm/3CxiBYxdLL12zHbxk1YQ9llXkAgTjEwpKEcJBoxGbGa/I4xz9VqjjfqaTboddy4Uijyas/6UoGZk9lFD3/ecV+clwA4Y8IzxT20PcPz52MxrVJHceyVEYBy2MHgPLjG6aaw==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYWPR01MB8395.jpnprd01.prod.outlook.com (2603:1096:400:160::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.14; Wed, 12 Nov
 2025 08:03:26 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:03:26 +0000
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
Subject: RE: [PATCH 15/33] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
Thread-Topic: [PATCH 15/33] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
Thread-Index: AQHcT+MzS/6DbKGQ5kmM71eddLD3HrTuta8Q
Date: Wed, 12 Nov 2025 08:03:26 +0000
Message-ID:
 <OSZPR01MB8798D32C112B7A05B97C12C88BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-16-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-16-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=9f792262-9d8e-4870-8850-0610ac005327;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T08:02:46Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYWPR01MB8395:EE_
x-ms-office365-filtering-correlation-id: 3730a884-1376-49f2-bb54-08de21c1f5a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?UU8xZTFacE1iaWlNcFpZR3M5TjZQVCtRNVJNenFROXFuRmhib3dsYXJU?=
 =?iso-2022-jp?B?RUtrUzJLSkpFY2JZdm1GTWdLRlZaNEVubWEyd2U2U05xVTdrN0YzbjJj?=
 =?iso-2022-jp?B?NnBnc0phWDhYdktYSnZwK1gzYS9GQkNqQVY1cGVxNkFKQVN5dDJnTGlY?=
 =?iso-2022-jp?B?UW1iN2pRZ0w4ZG1hUE0zd1IwUytSQ202MkVPTVpiWVg5bEo1MWUxWWpT?=
 =?iso-2022-jp?B?eGxpa1lESmJFU1JtSGx6WXpReURVcFdqVFpkSzhnaTVZK1VmaUk5OVNt?=
 =?iso-2022-jp?B?SlVCYWZ0cmExWDBaR1Q1dm1MT0xKTE9TeTBpc3hWWDQzNzlOYWlOUEpv?=
 =?iso-2022-jp?B?MDc3U2xBMXB4ZlZiT0paR2JHK3gvZ1J0cG5GRlkwWFFGeG5ud3lzOSt0?=
 =?iso-2022-jp?B?d0tka1ZuYkE1eVpUa3BKcTJkZDk1dG4xY0VIdVAxYUdnSGJDMnl2RWJk?=
 =?iso-2022-jp?B?VGc1cGtEY2JVVzFWMStxU1o0ZDFTcllmekF5SWZUajNuTnQ1QWRyZVJq?=
 =?iso-2022-jp?B?YVZwdm1zQXVkRE5FRU0wb3JqWXpxVzEzUXAxRHVhaGVJK3pPdjVJM0t4?=
 =?iso-2022-jp?B?bmN4OWJDTWhCQWdTM2lYSG9icjZ5Ty9mVFhpMElWQzJSVlVEQ0htaks5?=
 =?iso-2022-jp?B?TEVBeVRCN3JVK3R2TWtZVGRTT2E0dG1NZUNVR3k4d1MwaEIyblRoWHUw?=
 =?iso-2022-jp?B?d2o4Ymc0dTF0UHIvSURwYVFnVUJjTXFma2hSVDlUdWRxUE9rRWMvSjN4?=
 =?iso-2022-jp?B?eXJueGJTZVhXQ2xFelEzc2M1SytBN3Nubnk5TUpPN1IrL0VGZDluaCtI?=
 =?iso-2022-jp?B?THpwTFY0b0ZDcVROT3FlTzhnaEd6QU53d1VCcUFYWFk1c3Z4akY4aUR5?=
 =?iso-2022-jp?B?N2xlSVhrV2RJVGF5VkNaazNXUXM4akNBejYyS1pnTUNDRVl5SW9Uc24r?=
 =?iso-2022-jp?B?ZXNFeVpwa2pCelFrWEZuNXFBeU5FazlwUitDenNQL01tMmlvblNYOEs3?=
 =?iso-2022-jp?B?TFEvOXFYcFdWd2Znci9pRHRFMGI2dDMvNWluVk5KVWFrV2E5YUpyb3Ix?=
 =?iso-2022-jp?B?WGRCVkMxWkVlVVlPaE1VejVkQUNlMGkydjU3RDQwVGEyaWpVZnM5ZEdx?=
 =?iso-2022-jp?B?aVk0UEpRYnQ1RHhSYkpPSEs3cllwNElOLzVENEsrbm13Q1NVS3VmYW9v?=
 =?iso-2022-jp?B?WEFXdWppV2lOZG1OdkptOWkydXVYNUppbVlydnpXdDY5aXVFbUFvSmVH?=
 =?iso-2022-jp?B?NjdiMEFMWHFiVXQ3NDNtZ2RwdmVpN1lLU2xVL0ZnTEtWVUJQL2NOalNq?=
 =?iso-2022-jp?B?dWliY3BJc3F0ZExLVFp2amU1d0Rtbm5nU3NtSWxRMXl3Qk5rRk4wVzBM?=
 =?iso-2022-jp?B?ZENpMitHb3lkWUxYemI3bVFYNlprekZEZG4vc1ZmZ3hxUHk0cE1DYkdv?=
 =?iso-2022-jp?B?YkwrYnBOS29JM2pzQ05Nckw4NHFxRFV3cG5kcmRSS0dOYUE5WEJwL2RC?=
 =?iso-2022-jp?B?L3Y3WHl4Q0FlTmZQVWttQmFUMzJQZ08vQ0ZSL2tMTkgzSU1YLzB4eHVo?=
 =?iso-2022-jp?B?Nk02aDJNYWdSSlBnTUkzME0rTkdsYzVxbi8wUitQWWRnZDV0dXpEcFZ4?=
 =?iso-2022-jp?B?UWM1eGZhbzFvRTY5eVIwOFdQYnRRRzZtcStqRldIVllqLzZkTThSblBT?=
 =?iso-2022-jp?B?WkplMW1WZUpaR1dVb2hwUzM3TjU5YmVhVFhITXUzQ0pFV2hiSk45aU5a?=
 =?iso-2022-jp?B?eWh0RUlNb29pNys0ZU5RdG5vWkZDRHVlLzFlTWlLVjlhYjVTVXJmd0pk?=
 =?iso-2022-jp?B?MGl1R3FSbkZPMnUvWXVmNGxUVDczTkRacUVaOFpOeVNtZW9JZndWQlNw?=
 =?iso-2022-jp?B?Sm50UDdWdURQZWxtcFlsbFJMY2dkYTg2YlFNSmg1c1pGdFMzOXZTRkdi?=
 =?iso-2022-jp?B?UnlIenRxN2huNmdWMWkzaUNDOEFTYVkwQnpEREQxZ29xMGs3MWQ0dXhM?=
 =?iso-2022-jp?B?RGxRUk5rZDJ5MlNtVGhzV3RFb3hpeWNlRytwdmVhNDJtMis1MjVDK21T?=
 =?iso-2022-jp?B?MEpHUzZ6Y1B6UVdTK3NtckNPN2FlZkYvR2MzUTRZMnBhR3JORk83T3F1?=
 =?iso-2022-jp?B?WjFLdlJyZ0t3Ry8yTDZTQk1mNnZ5citUbHp0VStmU3hwMEFTQ0ljWnBQ?=
 =?iso-2022-jp?B?RU0rVWhrU29paEd5N1V1QVZKZUtsK1g0Y1VxeXdTbENlQzd5TEtJbmMr?=
 =?iso-2022-jp?B?bE8rQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TEFLTnlXTVppQ1BnUEZ1M0JUL2xqV1ZzQUc3c0RDT3c4ZDhIcUNCY3NR?=
 =?iso-2022-jp?B?bUVrNVlsZ1p3TmdNOUkvN1FXOEd0TUE3aHBIR0RkZWswVTJ3NExnWjht?=
 =?iso-2022-jp?B?SUJiZXIwT3QyRU5SQ09PcWpSMGhyc3NmUERoQ29QYTVXNnllUlNCZ1lq?=
 =?iso-2022-jp?B?T0dhMTBIbnBFUm1vSlZycHVBODU4WmI1QWpob2Q1SGhoWEFNYkl2THh0?=
 =?iso-2022-jp?B?Zy9vc3NCWTk0WWVOSmFsR2VCU0NUSUQ2Z1RIU3lyeE91UkFxN1NXTUJv?=
 =?iso-2022-jp?B?WlF0aEFodUdINHZYOVNHczN4K3daekZOQ09nQjJZSmQ0UGNSbGtLWWZw?=
 =?iso-2022-jp?B?enBRRWZyZVFpaDgvMGY2TURQSVhxSUNaNE1ZQzg0SURSMXZ1MEZaSm01?=
 =?iso-2022-jp?B?Uk9KdldMNXpNQUZlZXBBeVFraEUzRlUveXVWTW52VFI4RDBFQ1c0amMv?=
 =?iso-2022-jp?B?SHcyRXFoVXlNTDhwMWJFU1Z4VGMxeXNGSDFlUkJIQStROXoxbkhqaVBS?=
 =?iso-2022-jp?B?ZXpoRDBkY2RHRzRHTkptMnJoUytncGI2aDBuQS9zckV2S2paUG03TmFH?=
 =?iso-2022-jp?B?Rk9Mdzc4b1VqU284U3pHREthbjhPbktmNTBvR2VEZDh1Z2JBREJZWGVu?=
 =?iso-2022-jp?B?YmFSUk9EY0NYK2crOHh3UnpPTW1iY21qMVljSnlZeXJ3TVhkYmNDaWVS?=
 =?iso-2022-jp?B?KzJpNVZaVkpFQnhSQnlHck10UVFSVEZRcTNtMDVmL1pmcCtsRnIzcExu?=
 =?iso-2022-jp?B?UlRHOUN5dWxHbkUraW1heHFCalhDa2NCdHh3Zmx0Y1l1WXRJSDQrbUJq?=
 =?iso-2022-jp?B?RnJHUG8reW0rSloyVUxFY29HQUNZZUFVUFhlSExvK1cxSWtaU09Valcy?=
 =?iso-2022-jp?B?d3Bzbm1JOTBQS2pjK01JS0luVnIrNmt0VkVLbU9lRWJGYW00dGg1YmJG?=
 =?iso-2022-jp?B?U2dCTHlOeTE1cTJwUDJHVkc2ZnRrVjFZcGhjQXZhVjlrL2dVbE5pdXpP?=
 =?iso-2022-jp?B?WU5Tc1I0VWpGcVo0dEFqWnN0Q29PRFp5ZzVXZGJ3K1dQWkJUN3pXU3FR?=
 =?iso-2022-jp?B?N2NHbmR2bkY5TzN5bFNHZ3BINmhYb21UeEsxdVd1UUcreC80Wno3N241?=
 =?iso-2022-jp?B?dGZaT0prcVMrSzZmU244bFZsT21lWE9WRFVGdmFCaStaZXNRWi9rRnJ2?=
 =?iso-2022-jp?B?V0NNK01ta2VuQm8rMUI3VlZlb1RQQXltR3BBUE1yM05rdXUyODZHaGVB?=
 =?iso-2022-jp?B?T2l2SThGYVk3UWgzV2w3ZE9VV1RFWEJGaFFtZW11cXRuM1c2UmtUMUlR?=
 =?iso-2022-jp?B?SkV2bi9sblhGL0dkb1o2Q0hHcHorUXRvQUZybzc2WENIc2xoU2Rkdms5?=
 =?iso-2022-jp?B?NmI5NnJ6R0Z0enFxbmFjWitTaURlOElQclBMQ25Kd0ZOakE1Q1pYK3NO?=
 =?iso-2022-jp?B?T0FGVWJqVnZTTEJZeDRZb1VYWkJLK3V2RUNqTjNTcjZFa0MvUHlRMk1l?=
 =?iso-2022-jp?B?RUpkblg4VHdkYjlWV3Q5cWFJUDVaVE95MFgxUE1FQmIwNnFONTVUR0gr?=
 =?iso-2022-jp?B?MVM3ZVpkcWZlbkcweVRsb1RBZk1WcEJyMDZUbmRqVENsbFRTMG1hZWxR?=
 =?iso-2022-jp?B?cmp2ZFFzQVZzaUhBQkp1Qm1ybTJZdk9uanJMUXpnQ2I4SUFvS1UxT0Rs?=
 =?iso-2022-jp?B?TnlHSVVmNUhVbFErakNuVUdON2sxenVwZXdTZnJPd0RLSUJRZTNsNXdk?=
 =?iso-2022-jp?B?SUxnSlRJUkhNNzhTcXdoNHVZaWlIUVNNa3FkcnhlZE10cUErSmNRbm1S?=
 =?iso-2022-jp?B?Q0daZG1ORWVYdkJYWkM2UGMrMTVvdmdYdGdhMStudXZBMDI4d2V0Z0Vp?=
 =?iso-2022-jp?B?bGJWMlZaNHYxRk5rc1hlM044NTExYVVNanEvM1Bvb2hHMThJVTZwMTI0?=
 =?iso-2022-jp?B?VlZqbWpER2NBZkRFdklUR294U2RURExzOEpBWHRzRStWOThvU1VmMU51?=
 =?iso-2022-jp?B?WEtVQUllSUR3SDVidUFlSC9xMFR1VkdQUDNuUEQvck5jQmgwNjRXekRN?=
 =?iso-2022-jp?B?S3U2akl1S1ZXYkhIeFlkNGd6bFdZYjhrR2c3MWEvTGQ3L05sb1ZzNlQz?=
 =?iso-2022-jp?B?UTR2YkFCN3Z4aWhacmJnM1BPTkZZelBGamZJclhNaTN5SS9Xemw3TURM?=
 =?iso-2022-jp?B?Ym52U0hTMlhHWFVVVHZPbDc2TXphZFlQcEJNWDRMRC9ubDBKVkxhZnlJ?=
 =?iso-2022-jp?B?Qko5V2ltdXV1TjVGOCtyRVFhSFVKY2VBZE56OVdodnNqQkVwY2RBMTRG?=
 =?iso-2022-jp?B?N3VScnVtNTdkdUhva3BneFdCKy84S3JUZnc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3730a884-1376-49f2-bb54-08de21c1f5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:03:26.6847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laXtp/tPZ9GRT4EUL8eP90bfb8db7ft5F88nQmMKnRyuhrsi7qwDFTIi564PUv5wDg+1+kFp6C8EfRExYBcmEILy7znB6G7mrGC39NvOJQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8395


> From: James Morse <james.morse@arm.com>
>=20
> The MSC MON_SEL register needs to be accessed from hardirq for the overfl=
ow
> interrupt, and when taking an IPI to access these registers on platforms =
where
> MSC are not accessible from every CPU. This makes an irqsave spinlock the
> obvious lock to protect these registers. On systems with SCMI or PCC
> mailboxes it must be able to sleep, meaning a mutex must be used.
> The SCMI or PCC platforms can't support an overflow interrupt, and can't
> access the registers from hardirq context.
>=20
> Clearly these two can't exist for one MSC at the same time.
>=20
> Add helpers for the MON_SEL locking. For now, use a irqsave spinlock and =
only
> support 'real' MMIO platforms.
>=20
> In the future this lock will be split in two allowing SCMI/PCC platforms =
to take
> a mutex. Because there are contexts where the SCMI/PCC platforms can't
> make an access, mpam_mon_sel_lock() needs to be able to fail. Do this now=
,
> so that all the error handling on these paths is present. This allows the=
 relevant
> paths to fail if they are needed on a platform where this isn't possible,=
 instead
> of having to make explicit checks of the interface type.
>=20
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

