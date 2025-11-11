Return-Path: <linux-acpi+bounces-18767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B895C4C121
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 08:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF4094F358D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 07:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22295347BB6;
	Tue, 11 Nov 2025 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gg0poONt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010052.outbound.protection.outlook.com [52.101.229.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9562135AD;
	Tue, 11 Nov 2025 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844945; cv=fail; b=EcCWz8YlyfbEet0zI/6Cm4h5SSBl43Yi0wuIybeQukUgnEGsygkHRea5qX/IkOd1uWzvduot1t2J1lZAAGfAQf0y5NatoRSIURSMRfRc0l6BvFpV/eAsI+xq9zRm7N1kFG63xAT0/akwdMzHSDRlkflPp/ge1Faw0PGGT7TUGkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844945; c=relaxed/simple;
	bh=BZOHoPrNULM/W8ddJcHBUfc83STBceE+V01PcQvk6TE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GNp8MHFftNvmUi8KWGvAOkMi5Bwn4qKZmADjBsbtEK5cASjL6RszcjO46EL2iDpn7sIZzPbphTMFmYRoTpnCYHKk+YfSr2KoYDJSGVMEd/Z98zN/gT6kJoCglBjA64n1AMknRQLAueipUM5h6XSbB7Hi8kNjlUawbvWL3qlhfcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gg0poONt; arc=fail smtp.client-ip=52.101.229.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adDM+FjbJheiaVhsjZI2IA3KjQYnFtRG8UERLzX10a9u0ma3yw+HlrN6zOWNmhCkoEftwRncYg/JwsE/JZ3Nv1oN9K9FJcOF3i7vYmCRC3hAp9uq53/J3GPkrw5givzJ7WHLK9CBYB15Q2RbMp29eqGfrOtsszVNrbwTB36HLS6u7pfhLj1GacaG6KrjN/SSf6zlVvujoSdlsF00gydAJXPpLHL+xDqrScD2Y5B9QIgyKqHikJm1CzJN0Xo6dfRwiLvQ56EPO7zm3gF8yXzBEiOFPf/m43KPxSLmE38e5kMIoz2dIYjtgr0m5GH20K/eiwZrD8gfJdVXMl41YCwHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZOHoPrNULM/W8ddJcHBUfc83STBceE+V01PcQvk6TE=;
 b=qHFtEvfHPpWLITH8kFWaUnyn8bW6fyC1mNctyZMhuKdggh8ZgFOpeoMYMp/87hqDKUiZIV0tO7GWBua7EP530kHiNl4MENTRPHhfRJ9UtcO9KO6B+ALGwY0Q0+D6Fa5pEgegLaFerT7WpoUIPRJgjDbzZGZbB1ObJnYZEwPDjdM/dhtLWO5Vw3t66hMLjtWQW49rhnrW1mEShzK0opjPn19jIQ+JZrQi1cbDfn8Jvv//eUqSthkVwRf9E/fU4W03HYl02HoNBzQkHuKPw9mFYUzmQo3F1Rx4g7AIu/B2iNOQMZvZqRACP1i/dZzowTKi5W7MzaNL1zWHqfnPsz1u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZOHoPrNULM/W8ddJcHBUfc83STBceE+V01PcQvk6TE=;
 b=gg0poONtIXQ557dbOJirPQAMp1wb5paOym5a+4g7zqYUq9FqCK2mFpjqiABGnDKIAPcNfJWe/1CClyQ4IoyGTgwb+9mB0L8XIKKVbQii8bubdVpIvhV9dfEMcm44sK1ds72gFxFDcsaquAK6Pk5b6z2yDLqEzb6nZNOzPk+62o2u3rMcn3CoBKheY7l7IDVDVqc0nC8MntLIfBq5U3BPzFOJ2u1YNWCjE2rSH/1xsIO07KKbE98L/ubEvu5AjUnQfNef1ELfSuprXBew5tNT0OfGwXNDXApIJeG9XlpyCZnDm8yuuLeZlYTHiGPgBngI+G/1YVsWYoSC41UY6bciYQ==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OS7PR01MB13753.jpnprd01.prod.outlook.com (2603:1096:604:368::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 07:09:00 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 07:09:00 +0000
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
Subject: RE: [PATCH 00/33] arm_mpam: Add basic mpam driver
Thread-Topic: [PATCH 00/33] arm_mpam: Add basic mpam driver
Thread-Index: AQHcT+MGF4t0IeLioEKNPmrDDAJlv7TsF1WAgAD2q2A=
Date: Tue, 11 Nov 2025 07:09:00 +0000
Message-ID:
 <OSZPR01MB8798EA67926F2FCBA97A1C918BCFA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <29bb9d3c-cc78-46f2-b3dd-dbe12c59b2a9@arm.com>
In-Reply-To: <29bb9d3c-cc78-46f2-b3dd-dbe12c59b2a9@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OGIyZjA2YzctMTkwZi00N2MxLTk2NzYtNDFhNjYyYWIy?=
 =?utf-8?B?ODRhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMTEtMTFUMDY6NDY6MjBaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OS7PR01MB13753:EE_
x-ms-office365-filtering-correlation-id: 96cc737e-90e4-4f86-ec36-08de20f13050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkRpUCs0VVpFSzVJSkdxWDYrZ0VhL0lBMWdCVFJDUzRlT2NudHhLNGJScUxv?=
 =?utf-8?B?anZPb2h6TmF6Rm44bk5RbUVpZFVrQ1NDdTJzYW4zdXhqU21TeCtaSHdpZ1cr?=
 =?utf-8?B?ZExKdnFpS3RuTGU3Z3RkNEw0ZWZFaTZTU0NqMlVMNENZSHdyL0NIM0Z4c3Rm?=
 =?utf-8?B?YUlHTnduVVMzeUlyY1dPZ2tqUFFrQkI3UDFseDhjWXF1VUdJTjlxMVl6bm9o?=
 =?utf-8?B?ejMvTzlFOG1FZUFlUGZkbExrYWVNQ1hCQm80MmtxeHpndU1UeDhUNkhsSlRK?=
 =?utf-8?B?SmQxU3ZVS1BuTEVXTDNuRXJYNHo3ZGMvRE9NeTBUY2E4NklBTThrS29UU2tN?=
 =?utf-8?B?ZGk3NnR5YU82QXE1WjVKdTVESmFlQ2FsODBzOHRBSHZYNU5OdUZQZ1Nuazhi?=
 =?utf-8?B?eTYwSzR6a0I5akZ5TVUxdDNKVW5RZE1SNGpUdVRrYVVTZ09LaWU3YlJWRU15?=
 =?utf-8?B?bjkveCtJUGhGSWhZQXlJYjJzUjBUQ25Bc1F3YWdYVzRxQStiWHRmQWdiQWNP?=
 =?utf-8?B?aDM5QVRQOFJ2WDE3eVJNL200dm14d2VrZm1hZ3dNSEJBaEQ3N0Ixd3EzK3V6?=
 =?utf-8?B?ZDEyeTBCeHpzWE1QNjA1bGZ2NVdPajFRSS9HSXdPWHAyVHlZTXpmK1ZRamtJ?=
 =?utf-8?B?Wm5LTmVtdGhlOXA5QVprUWxpMmNpRy9wRDNIL0txMmJpZFF0L1c1UmNtTW0r?=
 =?utf-8?B?NFIzMG9GeHhwUDljaDRtZ3d3ZXRvUkZuSTVFL2cwQXNLbmlYNVk4RTAzeU1i?=
 =?utf-8?B?ZjhFM0FBR0l5eWZuWHU5RnpyQ3k1alY0emh5TjZBTmJQeEhSMDFBSE5UbzV5?=
 =?utf-8?B?WWNXZ2VLbER1KzJiUFRnZHFJTjJlM1BBUXZtcUMxWGZnWFBkTVRycjVvNmJQ?=
 =?utf-8?B?ZnZZUDdmSGt1cEYyb2JCUHhERFNWOE1mQ0s4MTRBU0o1ZEY2WGlwbkg4ZlFx?=
 =?utf-8?B?dk0rakExL1BoY0xSMlQ0Y1pIYkFQSFFzcTNvVFJ5Z2tnVEdqSFlZYWd6bDY1?=
 =?utf-8?B?eWRrUUorYjFmVnY5TFJqRWR3SXBXdGVSajZSOUMzSXovNWZ0QUl1TmhOTzVh?=
 =?utf-8?B?WHFtMVVTUk9XUkMrQjBNa3l5eHpoazJwd1U4UTYwdnVmUG0xeDJDQ0F4ME1N?=
 =?utf-8?B?Um80a1lqSkEzL2dIRXF1YlRXTEtGOS8vMDlmUG8xY1ZZT2JlNDBWVWFTaUxZ?=
 =?utf-8?B?YjltUXZMakwvY1dmUy9xSHMxVGFXd3ByZUJ1RVRpV0ZudHlON0xKYXM2WjI2?=
 =?utf-8?B?Z21jTlBKTitzUDFNUmZwb2F5aUhKeHRYTkhCbHhlR3Y2VkloRVU3bDFrK2h2?=
 =?utf-8?B?WHl5NlJUZDcxZCtYT1dQRnFGd0pQc0ZGQlJJbzc4MnRBSnlRM0h3UGtTNU9N?=
 =?utf-8?B?MnpOTEdPck1vbzJvMTRQZnFoVVk5eHZEbjZBM2V6OFZmb01hRlNaTXNJaDE4?=
 =?utf-8?B?VG5rcEc3YlgyUVoxTGtNSHRLVm12WG12bE0yVlIwSWxqZFRSbTVKdjh6ZFlS?=
 =?utf-8?B?V3ZDbkNxV29mREtQVVB2QitWczdUN2s1MVozYlAvbWFJTE9raDRZK1c4Q2dO?=
 =?utf-8?B?Yzkxc3JZK2NFb3JMZjRZZGx0cGZ1emhFRXJkem9wNlRJVDFwdXJwVk1xUzAx?=
 =?utf-8?B?TU5BTkpDRkd2emh4U29sVDZNVGhEM1U2b0lhdzNuSHJwT3dsbm9hRnlmZFNO?=
 =?utf-8?B?NFdiRU9iT1VGMTh2d0ZUYVZHc0ZJNzZydUxXMG1RT3QwMTlSME1SczZUQ0xo?=
 =?utf-8?B?ZVR3dkt3K25sNFU0SldyY3pJU0d1Q3dXRnkzNVlnMzRDMytrN25sVVdyRGhL?=
 =?utf-8?B?MlRKRm1TWTR3TkExUjFZMjRsb3RoVnNISjdYWGNRQzMyeHk4b1lsTFJmeXFH?=
 =?utf-8?B?NVFmUFB6cUUzQnY0cGdsU0FqTUgyemJ0NzlWTTZJdE9tOXhHMnRzS0x2bVN6?=
 =?utf-8?B?NFpwWVJIN2FXY21IMFFBSFBNY2JkVnB4aGZnKy82eUZRMGNrclhmWnh2d2Fz?=
 =?utf-8?B?Y1NielRncHZqREx1bSthN3N1cm4xdmZkQmN2VkxkUURQZ2xzb01oemhPTWkr?=
 =?utf-8?B?amtpMXoyZnc3V1lpVDN1WE9WeDdETmJwT090L3Z5VmNzbHUxODlGVzNtV2o2?=
 =?utf-8?Q?NTD4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGRKZmVsOWVjc1NmTXk4dVVFQTRFd3E0QzF5Q1NmaitpbTVra0dpM1pmNW4w?=
 =?utf-8?B?bUNwVFFLMUkrcXlmSWNzRDdtZHZlNXo0dGtiRGVDTjI3Mm82QW9YczZvdlpK?=
 =?utf-8?B?UkpuLzNidlplRStGZ3gvVjhlUTJGbFVZaUppT2ZOZWw1MFdBVndsVyszL0N5?=
 =?utf-8?B?d2gyL3l2RnRmVCtPdnJlMERQb0FvYUh5SExIYW1BajF3ZzJMZEIrbWtuRWZK?=
 =?utf-8?B?SDdGSmV3T0FOaTRreW1tNFp6ZjFqcHlnM2FISnpoKzdMTzdwaG1zcmREeDc5?=
 =?utf-8?B?M3JtNkhaRk1ibmhJRitRTjRJeXhmeTZDRG54MDR1bzhBUDBaK28walhHV0hS?=
 =?utf-8?B?ajlmRitScC9IWi9OaVQ1MFMwL1BXK1hycjVQMGVjdkdxMFNiR2wzZTRFbU5k?=
 =?utf-8?B?b2UwNS96MHZObk1DS28rcUZxQ2dQVyt1OGZyUWc2SVNIa2NoSTZFVHgrYXNw?=
 =?utf-8?B?OVpmczFrQkhnQzk3TDQvSnV2ZVRqMU41YVJYNzRkK01ncU9scGlKZmJZUUl3?=
 =?utf-8?B?YlJBTFRzMmExczYvd0dqbmVwS1hVWlZzLzM4Z1BiT0VGK2FKZEU3S0VDenJU?=
 =?utf-8?B?OFZOb3RmQklJOW9nQ2JwZEM1eFovSlpOZW1ONFpvYjRMZVdGRFZYMjlmdjFT?=
 =?utf-8?B?NmF0c2ZRVU8wM1poRE1QRVN0QlhraWxDMm9mbUZCWEt5U2F2dU5mdmdQWXF2?=
 =?utf-8?B?RGxBakxWUCtscWhZZVpwMzNaRC95SzVOM2xIcXk3OVlKR3NqRk1Pc3pNVXJr?=
 =?utf-8?B?amw4TlFiMDhIOG9oamlpd2o2UXVuL2VWTU5xdE5yMmFhMW5JdC91cjBlUk8x?=
 =?utf-8?B?OXJwMEt5b2J3ZG1IeUxnWHdlSHdDU1AxSjJDNkVLaVpyeHJmb0xwa3lXVU1r?=
 =?utf-8?B?RFN2bjdSN3RwSjBaNTNhMmd6RVpSS1YzdzdFZHJDdWNQclBCUERZc2xJck1s?=
 =?utf-8?B?SitCMzN0c3VneGhtRW9FckJEUmFodXppME50QlVoaC9jYXlLSG9nd0V3VXZo?=
 =?utf-8?B?clp3VVFvYVFqa29TMjBJc2ljcGU1aVUveFlTQnlwTHNqeElabTRnWSswNi95?=
 =?utf-8?B?Y1FvUHBuOVFaWFV2TDhYdjFIQkVaREg0OGtaZEFtb0hNeXpjWm1uL3dnNjkz?=
 =?utf-8?B?Qi9WWCswZHJxTnNWdWU1Smhya1B0RXZudjEyMENabUhSak1DbFBIaW4vQllv?=
 =?utf-8?B?aXZhcFdDNm5mN2J0SlRVbDVQd0NpZEtqWjdrbXRFZytLWGlDQWJrT3IvZ3F4?=
 =?utf-8?B?bVZYZkxlSkE3SzQxeGJETnpndnRjSkhXR0NhcjlMb3VhRU9tMDRMMVhrajJP?=
 =?utf-8?B?MlpzdmpIb2U0ZEc0UStqZW1pNXQvRU5ycU1ET3Jsc0xDWFU2RnN5ZE9neU10?=
 =?utf-8?B?Q0hsRXFPNGR2TUZLNHJaSzFhaG4vU1p0cjB4ZXFKNHd5eGx6aW9obEJ2ZlBp?=
 =?utf-8?B?U1VXc1JCQngxRUFOVmZ1RVJGUHo3NGVIUmxqZytOZ01DTUpvTlBqZlBxczc5?=
 =?utf-8?B?WElXVTVZQkNOYzdhaS9hYzRPcW54OGVORzhvcUVyYkhxMTJmdVpKRGZjZUxy?=
 =?utf-8?B?VjRzWG9jNDZXVjYwT2VzSVlZSVE1Y2Y0eFQvSVdkZlg2SGhKUHRwSjE0OVl6?=
 =?utf-8?B?TjBFYWJvSzBDSlMyR1dJaTZIYkl5L3ZCMjJsZ0JtcG04NnVBS0RIc2MzRWJk?=
 =?utf-8?B?KytSZFF5SEFLQWYyaUpYVE9IYTNSeGd2bnMyN1hNL2EvbDZsVGVkUnRvd2wx?=
 =?utf-8?B?bGw5RmRkMy9qK05FWVFsdTZIY0FvQ3YzT29uWXgyT09HUnk0dThOSnVzV3pZ?=
 =?utf-8?B?eXlzeTZyUnMySWlwNFc5dzNQN3lFd0JZdHJMN0h4R0FTZHZIaDBla3NHNlNZ?=
 =?utf-8?B?V2p6a3p1bjBhZnBKSGc3alRWcFVzS3RwS0QvY0dWc1IwcVpod3JUMi9NZVRo?=
 =?utf-8?B?NzhoRlFkdm1yRkFydHYyTTFXOHA3d2RsaG0vNDFmYUV3S24ySGp2YXVqdUZT?=
 =?utf-8?B?QlV1T2p0cXBPNnpIelhEYTEycmk4ZVpWd25KUXZVZDFzamR1cnd3ZEV0SXhC?=
 =?utf-8?B?cnBFeVFMbEJ6ODhWU0JHeFl5cGRyZm5ZdFo4ZWhTakF3MzZzQnFNZGRjV1BT?=
 =?utf-8?B?SEthdExibzJvWVkrV0xxc3dxb2NVR2xBYmxSSzBSbkRMQ2VoK2svLzlUKzg0?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cc737e-90e4-4f86-ec36-08de20f13050
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 07:09:00.2923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohjzmfIZZtkl6k3dAICfESRMuVbYMvXTlYnl3FpN5qfLvg0uSa1n2GVLYtnO0EKtziGqn6xzcj14NgK4Kcs7LMcJUfo0cvBOQm0vL5KLcjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13753

SGVsbG8gQmVuLA0KDQo+IEhpIGFsbCwNCj4gDQo+IE9uIDExLzcvMjUgMTI6MzQsIEJlbiBIb3Jn
YW4gd3JvdGU6DQo+IA0KPiA+DQo+ID4gVGhlIHJlc3Qgb2YgdGhlIGRyaXZlciBjYW4gYmUgZm91
bmQgaGVyZTogKG5vIHVwZGF0ZWQgdmVyc2lvbiAtIGJhc2VkDQo+ID4gb24gdjMpIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21vcnNlL2xpbnV4LmdpdA0K
PiA+IG1wYW0vc25hcHNob3QvdjYuMTgtcmMxDQoNCkkgcmFuIEt1bml0IHRlc3RzIG9uIE5WSURJ
QSdzIGdyYWNlIG1hY2hpbmUuIEl0IHNlZW1zIG5vIHByb2JsZW0uDQoNCj4gSmFtZXMgaGFzIGtp
bmRseSBob3N0ZWQgYSBicmFuY2ggd2l0aCBteSByZWJhc2Ugb2YgdGhlIHJlc3Qgb2YgdGhlIGRy
aXZlciBoZXJlLg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9tb3JzZS9saW51eC5naXQvbG9nLz9oPW1wYQ0KPiBtL3NuYXBzaG90L3Y2LjE4LXJjNA0K
DQpJIHZlcmlmaWVkIHRoZSBjYWNoZSBhbGxvY2F0aW9uIGFuZCBtb25pdG9yaW5nIG9uIE5WSURJ
QSdzIGdyYWNlIG1hY2hpbmUuIEl0IGFsc28gc2VlbXMgdG8gYmUgZmluZS4NCg0KVGVzdGVkLWJ5
OiBTaGFvcGVuZyBUYW4gPHRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCg0KQmVzdCByZWdh
cmRzLA0KU2hhb3BlbmcgVEFODQoNCg==

