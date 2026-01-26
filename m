Return-Path: <linux-acpi+bounces-20620-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKdtEU9pd2nCfQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20620-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:17:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E354288B31
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 275C7303CE30
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805F30E858;
	Mon, 26 Jan 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NWcKz17u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022128.outbound.protection.outlook.com [52.101.101.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873037494;
	Mon, 26 Jan 2026 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433357; cv=fail; b=kvnCFNE/xdG5jCufmSnVrZ2ZABd1/CVG/mAsHvGaiBZK5TYCsAprACFgZZ0Dym+2GEXuEa9haDzQTLByBtOTEAvGeVPcVeU70np8ksHUbqNTSwIX4u3AiX4J+YXBHlD17OlGNfTzX+dFCMeK76P8Sd+OZM3ScA9/suyGpqFlFgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433357; c=relaxed/simple;
	bh=9x72rftbb8KDCAPlWmmBpnswXuHZcCuGOZLjOV3P4po=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=r/7c+BJJLxytzTH78y5cq/ecDFACmcRWvBTAkAl0N/KijVPeV9lBTg6fP7uAqRO0KjzxYzretMNgxuS1KUqkMOh3GY0fCz0o+scPSxWmAOKmwiu8bAFuEs7qmNtsoJJFmMS9amght2ZwmAnsPHVkQFW7mTzxsE5pRiPi2ra4JNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NWcKz17u; arc=fail smtp.client-ip=52.101.101.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kd2w2i3mYjVEEQm9qXuKhGuh+saKKp/8gOBum5l/XtSUTyFIKji6gS9+1dk/J756txy5+eI+EKm55VTQBR8fJXbIMxwArO5Do5X5gGPA/hybAvyXHnOlvrz53ZkIMvIbv2OPUIbFqSPFvYc20xJaLkr5GCma3kIN48/6g10O+qEKrTkFAOMOw7S5DBj2k9QhFbx0qYmYZ1V+YnbKZ6BdEpvmUMKg5F5fg5vDyfYlQF+rWc35orXCrrjtppR2xQbyX3wgpeMJdTbnSR1BLd4LQllkcbi9luGV2cIbh7IV1NumRiS946H2XIttnZldPDYK7J+SliU+/FOjNNUaj4BBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSSGK9vmG9KV0pj9oWvqv7PIZwqY0n2dEvaMB1E/ANo=;
 b=MdRC+O2WJ7/QO7wvtRs4tE4/Il6ncZjWxm+NLXyhD2GMIzjs0QDv3ekwJ53ZX6gJbPjN+F3/8+Iqf/UI8rxT2KW46tkC0UTxkPtSPq6jLS9qSJHDnm6BfREKLt6e7LhUeQS3Cgdrinku6SeFBFADMMI/JMzStkoyTXhIwlNRg756s/4CvplScOhS4IRQOzqmNWAnz6yS69Gne9f0+bqEWpaffPk8BAIQWeSH0kb3b0iJBhfdbwJfH9vdC2Q2iBFjwPMBpjoVGudEwfFDuPtE0NJsplO3TLXPgGcnHn5zEcWcTW9cdNJwR46UCHtWeGb3sBSKBBTSg3T5n+ORn/i6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSSGK9vmG9KV0pj9oWvqv7PIZwqY0n2dEvaMB1E/ANo=;
 b=NWcKz17u6NWmMckmpnN7ooxZYvVxtkIqwr5D28pUJJlW7wqj9aki6QQoAt8AmMXZbImW7mYQBAwQtytcXDPLe907wPGlko5+8hjBJGUP+RiOxUiZNe+vMd9E3wkSAGcLT1ulyaPMwdLdETgUVLIemt85NxfXU53k+zg6nBoWyj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2022.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 13:15:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 13:15:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 13:15:53 +0000
Message-Id: <DFYJRWUHCOMQ.3L6ZVLOJTNDNO@garyguo.net>
Subject: Re: [PATCH 0/4] Re-export Zeroable and zeroed() from ffi module
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Igor Korotin" <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Len Brown" <lenb@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
In-Reply-To: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
X-ClientProxiedBy: LO4P123CA0629.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efd7376-3ec6-4e12-f189-08de5cdd08d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXI0THFlSytoV0NZekFEaHhhWXlwUzNxbHJURW1iakxxWitLblF6M21kWElH?=
 =?utf-8?B?WlpTaGZ3cjJUb2s4ZlF5TEtQaG5OSStiM3pQUkViLzBCOGpwcHJzL2FMT25w?=
 =?utf-8?B?MDdraWJxWXNaSVVES1BUZjBrRlVXbkxxQWF0b3JtbmJERTNmWGZXVUo5ZzFH?=
 =?utf-8?B?ek1kWTNQSElpamFtYjBZMHFUY1FKTjZGUHo1aDZvVUNlZjhIVW1yTExFZTBH?=
 =?utf-8?B?YlYrOHd4dCtINVlobTF1RDVoYjNKQmZIaTg2bktRbVR5MzdVeHo2U3Vwb3pS?=
 =?utf-8?B?VU8zOHNSQUNnVXNhaVVvYnlwWDRWbWJLeGRnVnNhZ0IvVTlsdjFmRkVEbFg1?=
 =?utf-8?B?THFsaU5lUFZYMjlRVkJ2c0R0NkUvMGNYNlY4SUVIRDYvcjBrNFVVbWRKalMz?=
 =?utf-8?B?aWVkZTh0ZEZkeUJGSUlhRk01cEtKS0ltcVoyM0Q2N21ZUG1ha1A5TER5eFRR?=
 =?utf-8?B?ckRuY2FvOGRsbm9nZG40Q0g0WHRmOTY3L0pUenczdFQwOHd2RTQ2REVqWWZR?=
 =?utf-8?B?Qlc1dDJibUNlcUxxclk1dC9DV2c2Mkk5YitGZDRWNVNuT3pmcFowRk1wV25S?=
 =?utf-8?B?V1VDR1haYTYvYVlXVjBXUkQwV0cxdXZob0E5dkdTSWxuZU5KTGluRGU5aThn?=
 =?utf-8?B?YUZMMlpMaXdmOXk3QjYwUnkrWElaTk5KTytpbEZES0dCTjNYVjRUOEpmOG5Y?=
 =?utf-8?B?S3NWcXgzWVVQdktaTTgrWGFpUzI4aFN1T2dzS0dCbHVVQ3V2dk41TkJadGUz?=
 =?utf-8?B?ZnVETnVrZ0hsemhMT2xTL1o4ckRuQUk2VTZRbkYzeUZVc3JLZEFVUUNGNVNZ?=
 =?utf-8?B?S0F5bjlVbk9MUGp6NXc4cGdXYVhtZzBBY3BzZUFud0tKdjdQZmcrZmNsMTVw?=
 =?utf-8?B?OHdRekh6aXRiMGl5bkU0dVRib01PWXlpZVNQd2wyVzYrOHNGWGpnVzl6S2ZX?=
 =?utf-8?B?RnNRY2x0U2pHUEtEMUpabFIyQVdDVUgvOU5DRFQyd2JXVG8yVWdFaGNndEpi?=
 =?utf-8?B?WURYNlpNM0E1SzQwdlFPeTVIdDhrL2lZOFJrTTREaFFNNTJ6ZkR5cytLZmdZ?=
 =?utf-8?B?RE9weVkwd0N4YVZWN05YRkpzeE5BR1ZuTGZVQVlDczRsOTZmOWJ5aHFlcXpt?=
 =?utf-8?B?SWhKbE9LUnZ3bHFoZm1HL2E5RUFZSGwxUGY5KzJkMm5GVzM1Q1UzSlh0T3hH?=
 =?utf-8?B?TWNld0hqZnV0MWlUNU9oK3ZIK0FpNXc3RTlocndRVkhNS2Rzb0h3eEpTRkJK?=
 =?utf-8?B?V0drUGtINGhSeW1uTGNrYXNvODVFL1FEQmZ2aW1KMzU5K25RMURZY3QxNHhi?=
 =?utf-8?B?SWJiVnlLNkFrVGhPenhaNTRtSytwazMxbWdYU1BLYUxYQW5TU3VFYTA1dzF1?=
 =?utf-8?B?Q2UvQ1UwT2ZSY2EwTHpScFVhRW1BT3I0bGdkMlEwUDB2WHdMaDMvcUF6SG1w?=
 =?utf-8?B?NWt6dU5JNlJGcCswNWdNaG9YVFN0M2NBTmc0cGxEVzZ4Sk93YmRqbUNWTTAy?=
 =?utf-8?B?Z2RxaFVOeDNXL3FpMmUxS3phREpHSmpIUEpyVzQzNC9udE84dlkwMDJuUHAr?=
 =?utf-8?B?WHVHSFVSeUVIS1h1MTl1RTlqUll5bEZMT09JYTlCdzlsMkxIY21hSTI2amI2?=
 =?utf-8?B?R09WM1FWbHhHR0V2S1BPZFF3aUZxOEhURC9OMUYyN2lZajBqeDFwaUxVOXlV?=
 =?utf-8?B?bld3K05KSTlybXRUZ2NISTFiWnBvTTArSzNuV3lOanNhTkRmbU0vRHowUWlj?=
 =?utf-8?B?VXp4N1RLaGlwTWZsZElSeWsvK1lzYXpSOGZONGtlNFZLUGx6bDJvaTdNVFA5?=
 =?utf-8?B?Rm0rNzZ5RnM4OXg0OTBqZjlLWjhNNUFYUDI3T1ZrQTBsZGYraEt0djROamlz?=
 =?utf-8?B?UlhTY3A4OUFzeUxtaWhIZFF4dU9CTk9HdTZTdGpzRnd3aDhhT3FJN2xscUV3?=
 =?utf-8?B?UW5uNzJiYm50S0tMamliZUtBeUs5Z0Y1MkpwZlZkOVJqSTczdWdGdHpycnNr?=
 =?utf-8?B?ZlcyK1Rsb21SVGxQd09rRXkyNVFlK0RnN3g3QU1VU0N2TVNGOUowMVZFL0VJ?=
 =?utf-8?B?N3YxOENVSzIvSXBtNEhtR2ZXWGZUdW8rMVA3Qk5EMHJoaFhDL2dJK1YxV1Z4?=
 =?utf-8?B?KzB5VERPOUQ4ZiswcVlWUTAxK1U4QnpVV1NLbUNzK2tZdkdHSXVzQXpMSWRt?=
 =?utf-8?B?dlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V09ydXNJcmZlZmxVcDJzWWlOK2RXVG9TTktZdGljNG1kVHpEbU4xZitWSWNz?=
 =?utf-8?B?YStIVDNBQTlMY1R1NXR2cHBVMGYwU0NZRXF2VWYvdW55RFhYNU1iSC96bE13?=
 =?utf-8?B?MVJjVnlFY1dVM1JiZm9WMUFseXRwMGVVR3BHdFFiVnQzZzZHVEt0cW5mQzZj?=
 =?utf-8?B?aUxMUVJ3aTVxbUhmZlV5RUg2MWlzV3oyZnFEa0VvSC9TVEZhVzBubXlCK1dX?=
 =?utf-8?B?NWhZYzk4a0Iwcm1SdWxQQ1hGR1JDRmtzemJLdEVoWmNQWnd2Q21RM3g0RVA1?=
 =?utf-8?B?RVRhSkJ4Q1BMdE4rbnhtZWZNYlFNOUJ1VFBxZEplVXJCNnFuT3pwVlNzcXFs?=
 =?utf-8?B?Vnc5RlRVZkt5c3dLTTByMnVlVlRhZnJLQWRtUHVGMUNleUVONHRQTXFsVWJE?=
 =?utf-8?B?QlVFZmszSFdiSE43ek1NaVVmbCt2bnc2N2E4TU1IZDNKK2h3WXlQS1Z5TDdu?=
 =?utf-8?B?Z0ZNSFlXSVBiRTlGTGMydVhuVHZWVWNRR3BHVmhxdTU2MmJLZnBjKzgrUnlY?=
 =?utf-8?B?Sm1nQzZPUkhPV2k5Y2ViZXRoR0NQUFVoNm9JVWNmaHo4c1VZaTJXS2o1Y3M4?=
 =?utf-8?B?N2E5RHo4YzEzRmR0NDd2UWd4aHc3Z2pObmEyNUYzNXFwR1plMnNLTEd3N0xW?=
 =?utf-8?B?d0p2V2VVTStHeUNPSVBlQ1hBVS96NDFtNklUTGV3RlVtWnFzL1kxYkVXamNI?=
 =?utf-8?B?RkdVTUZFU1JtNnFUc0dyak1OdGFvS01WUWh1Vnh0QWM4STV5VEk4d2FOaXoy?=
 =?utf-8?B?czd0VkhhM0FaYzZWUFRTdURPN2p1c3ZGMjFaV0lVN3hRa1ZlY0RjVEkrbVkz?=
 =?utf-8?B?SkFFRkJJNExrRVE5Y1lqQkREMFM4WUZKejhSVDhmSHUvRlEwUGYwTlpySk1P?=
 =?utf-8?B?WXBwODNndVdJbmRMQVVZTGs3RXpBakU0L3BHbktYdWlVYkNhNmZiVTVjZUZX?=
 =?utf-8?B?MmxraVRNN0N4WnJoMC9CbnA4aVN6dzNRNzRHVTJlTi9WdmNxaE9DQVF6K2RO?=
 =?utf-8?B?Q0pKS0FIUUptY0l4RThOc01aUWtUSWRVdFpqTElKdE9NeVVDOWlwRkZMVkJv?=
 =?utf-8?B?azRXYjFzdm0wSWQxaWVENEZxeVNhSVdNUzRFa1U5cEVwWVRvbnEyRzJEQUpk?=
 =?utf-8?B?Nko5MGg4SVkzNjZZNDl5VGFpQjdJYUN2b3B5MTF3bDMzaHZuR0RaR0h5ZW84?=
 =?utf-8?B?VTBvWXByODVLUzBObEYzdTdLZGlNbC9RRWcwYXlvMHNxTXZxUzdRaStWd2Y3?=
 =?utf-8?B?SjNlSFhWN0h4THVtMWFXTEx3Wjd4VVQ5bENkTFdGNkN6ekRDVTRidXNadkhB?=
 =?utf-8?B?ZFFHeE8vOWRwelB2UzRYTGl4V1BIcHVQRkpTVU1DaUdwWWtQQThvV0NteGs4?=
 =?utf-8?B?OUM2TG1iUWNhczlzZ1ViWXJmaS9iNWtEU25abW1uNGc2MWVSbnhNNkZITTVi?=
 =?utf-8?B?Ynd6WUJpV2xYQUc3aDVMVHM2QlAyeTR1U29ROTVxMHhpQm82QzB1UUREQW5r?=
 =?utf-8?B?ckt6NE4xaTYrM21tTUIyS0psdmovUnkzWmo1MUxlK2pLa2NXK0p3OHQzQ3Nh?=
 =?utf-8?B?ZDlxc1VCK096S3RlcGdkK21mUWE2d28vMlhWN1pid3U0K3JydTk0RFFldVJY?=
 =?utf-8?B?TzY0WVVQeCtmQ1VDR0pGdGVKSmlRVStzVS9HWC9vY0xocndlNjJ6TzJXT01v?=
 =?utf-8?B?U2FndkRjcHo4UWkvNXJaVjByV1oyVmRhUHl3OFNWLzBEUkU4STBKRHpLRHNG?=
 =?utf-8?B?ZkliM0swdDRnQTVBZzFmc2orbzdMN3pPTlVwcEc5RGJBOWJIRnp0MktqTDk0?=
 =?utf-8?B?TWhqMCtUU04ybkRScDlJT3FNa0toSkM2d1hydGdWemhYejVteHpyL0NYckNP?=
 =?utf-8?B?UGwrNTVVbm9FL01QSEw1NU43all0eGJ0b3J0amtGa3lHT3hKdE00MEE3SFc3?=
 =?utf-8?B?alVMTnd4RVU3VE8zVzlxV0ZyMyszT29ST2VsZlVYNjBqNEJhT3g0MDZWNXBs?=
 =?utf-8?B?bHBmSUpLZ1JFcitkN2c1ZU42QzE5RlJjbUVpZ0NLVjJLOExqWWo2SGsvdWxZ?=
 =?utf-8?B?RnZlQVBVdDZLblZrWmxvb0FDYWRadEdTdnRQbGdGdUtpWGgxbjBOUW9iUkg0?=
 =?utf-8?B?T3lXeEtGaEJ0TksrOW1GenNzd3AweGdYaFpGbit3cDh3RVBxaDI1RDh3aGFI?=
 =?utf-8?B?TTl2Z3dFUXlqTE1nOE5EemJXbXJqODBnNjZ0TWNrOFMxTmVZb3JsWEtJVjVu?=
 =?utf-8?B?MXBLQXV4RnJNR3JPQyt3ZzVKU3NhdEtIcVNjcUdkQ0hsL0djdjA0MENLcC9Y?=
 =?utf-8?Q?lxeoDs5PVftsbI7FWi?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efd7376-3ec6-4e12-f189-08de5cdd08d3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 13:15:53.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/iBQ1divkar4tlPYeRJoPMFowdm3X50eVSxSNiVeFlPanlp9AZYRZEPUJVUsUqkpBSrc77Wdnlit/BbjrYO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20620-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,linaro.org,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E354288B31
X-Rspamd-Action: no action

On Mon Jan 26, 2026 at 1:05 PM GMT, Alice Ryhl wrote:
> Currently, the Zeroable trait is defined by pin-init because pin-init
> happens to use the trait. However, zeroed types are useful for many
> purposes other than pin-init. Also, we wish to implement Zeroable for
> types generated by bindgen. For both of these reasons, re-export
> Zeroable from the ffi crate, which is a already dependency of the crates
> with bindgen output.

I don't see a benefit of re-exporting these from the `ffi` crate? Especiall=
y
that we re-export `ffi` crate from kernel crate anyway, and `Zeroable` is
already in the kernel prelude.

We already derive `Zeroable` for bindgen via `MaybeZeroable` derive in
rust/bindgen_parameters.

Best,
Gary

>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (4):
>       rust: ffi: reexport Zeroable and related items
>       rust: cpufreq: import pin_init::zeroed() from ffi
>       rust: i2c: import pin_init::zeroed() from ffi
>       rust: acpi: import pin_init::zeroed() from ffi
>
>  rust/Makefile          | 9 ++++++---
>  rust/ffi.rs            | 7 +++++++
>  rust/kernel/acpi.rs    | 2 +-
>  rust/kernel/cpufreq.rs | 2 +-
>  rust/kernel/i2c.rs     | 4 ++--
>  5 files changed, 17 insertions(+), 7 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251202-zeroable-ffi-2beb542376c3
>
> Best regards,


