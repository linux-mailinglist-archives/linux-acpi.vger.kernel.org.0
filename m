Return-Path: <linux-acpi+bounces-14406-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC4ADC2DF
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 09:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76B5188DE41
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BC28C5A3;
	Tue, 17 Jun 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="BrTNm6MC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF62BF017;
	Tue, 17 Jun 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144283; cv=fail; b=kh2daBKtDU04KTHWrmH0vn/GfV5Pi7XzrmSpC1jdPBDtKJ2f6nM7xo8vOD5USijttTxnucasb7jdoAltyJsuvuoXy8W5zQrLBCzlSerRUvVvsxrwY6oVWsCRzBioqLxTVJUJ22JWW7Xtq+/rIfln3raYzkv7eZOTAIQAVM/yn7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144283; c=relaxed/simple;
	bh=bgHO7+MoUuQGPB9SwffZNir+EMhJxe/Wd3BLJKao3K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IfgCGzi941GdaaNWa6EJIdT/GERsaKOidwOkig9s9ZXj88erJ1hwoulfSu9zgMOLzFyVj6LhefHL+kgWk4Y72IX1EtYU/rUxT7YpKBz/TfEZu84EZLOv8l+6tyRgrYK76x+Whxphh9h/uBySNMglnqhGtPLGOamfuv0lucoON7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=BrTNm6MC; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCvWbAh1FCCkOjpRHlIIsrP6gwz/ZDnbEYv2wTBgx+ElWptUllzGNJjcn7lnJG15kWehPWfotbluM58IRKqAtcEbqjsUPzq8s/26zucmFcf/z4ZpmnxzOldt5zrhAplBXAfSTKWwKpwikA2Pmmycdz5vBXlKuubsMyJri8XOldDGUt3NRqH3fHx3KY3AE27yx0kCZIWYndO5PGZj3I0aC9AZwPkdDmmXEDAUT3i4BqLOZqWbJcR8TJ1eY9EGt+TawTkmJ1wK7mQlylPgUIw8q4iZ7DVd1XMuP+ZqipHBR0TeFMGltHKfiYReYL73wY2jbzAJxniw8+jPPv3ODvexlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUHE7ZUqgb9wyTiXP7suOSz1xQnHPf7kR4TsQmCvW3k=;
 b=VXP6MZrTcTDJ9NsENTu/P3fCurF79A0CZIGN1AQNs5pTXcm+JY4Zb3SH3e8W2q67na7mQ7FCmxT1t3xYg/vK0Ekkm+gkKxrq3HgkH0b5wnfVOKxQdxCZeIyHt8uTjrkqo9WcVOYuEuWBPoFidz1doAI7Ep1QAlz3mKSwSHp847DoD7761cqQn9dquRPd9yVOu8Sk88gUz5r3w7d0QDKukiCwxpVVJRj5IJ5ls3NvCrVGCFjNLvwO9gzPW22wh/n6+/QwgbXMQSXrjFFYDASN6xqFIbNIZT6xqpH7KM0c3kG33hYiqMred0zIn1REbyeYhl8DBb0izond7n12N+TKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUHE7ZUqgb9wyTiXP7suOSz1xQnHPf7kR4TsQmCvW3k=;
 b=BrTNm6MCQfZk5rsZSzAuIXx5ieSgYrs3sKSVk4kEGejDoqfpyfePoUnOLfQjKPxLHuiJ6aifr4PS0Etec0LZVHe4vYJ1Zt2e3KWZVkM74RfNuDtS7LBYHEGAWe8pnvqNPYwj2ETflWJ/4Sk2JrjPFrn138JQixwgEPz7Ap/FWTu3yBO2z/lylcoyC/Tr4OuKImspBJcejL2U+Cfh98XbIf9cKXYCGJkaFAA5u6wEKsGekgUh/mnsCNE5xLDrY50CyBTM4U9rbxiHgn+vQl0L5HdErvM4vy1GtZ7Epmvr3BiMT9yJzYkX2xGOps8dANSMA4fQ6oBglc9zpnC8vnwn9g==
Received: from AS4P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::12)
 by AS4PR10MB5799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:506::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 07:11:13 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::37) by AS4P251CA0025.outlook.office365.com
 (2603:10a6:20b:5d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.29 via Frontend Transport; Tue,
 17 Jun 2025 07:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 07:11:13 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 17 Jun
 2025 09:10:58 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 17 Jun 2025 09:10:57 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Tue, 17 Jun
 2025 09:10:45 +0200
Message-ID: <d59f8392-c4ca-4f39-a57f-83c669e3efb2@de.bosch.com>
Date: Tue, 17 Jun 2025 09:10:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] samples: rust: platform: don't call as_ref()
 repeatedly
To: Danilo Krummrich <dakr@kernel.org>, <igor.korotin.linux@gmail.com>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>
CC: <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250613135407.1233005-1-igor.korotin.linux@gmail.com>
 <20250616194439.68775-1-dakr@kernel.org>
 <20250616194439.68775-2-dakr@kernel.org>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250616194439.68775-2-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|AS4PR10MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bd1d6c-5fef-42cf-6d63-08ddad6e24e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHFjVVpEdG5wZGdiem16Q1BKYVFNK0luM1NvMkphUURVektqaFc1RkVRVDdz?=
 =?utf-8?B?NHFMQmpHY1BWY0dacFBLTGVCT2R2Rm92OFhxNm9vZG1YbVNsSm0zbXp4aTVF?=
 =?utf-8?B?QmdtU2VaamhrKzdXQm1vRnpBTE5HK04zRURTLzBUaXZYN2djWHNXYjBGZkVs?=
 =?utf-8?B?c0dldXlSRTJ1N0lLaXlzeDEvZ1RzMmgxbjV5STdVSmgrSlJ3ejlOSGVGM0t1?=
 =?utf-8?B?VGJuZE1UbUFOMmU0RitPckkwa1l1RGZ6Q2dLby9oS2dmYm8xZ1ZxZFRicThu?=
 =?utf-8?B?VFl6aktubVNVSGE2U1hVNUJKeHNQakdvM3VPdWlMZGxSWnZURFNhemFacHdP?=
 =?utf-8?B?K0V4dkpHK3JKQ2MvTVh4UlZjak10V09iYnIrU0UvTXFRWUozeFhOYm9sMG8r?=
 =?utf-8?B?K1YwYzN1U3N3Vzg5NktIVGNTYnhMSmpnWk1wM2JLeTZDTk9lbzRxTm5lcXBl?=
 =?utf-8?B?aW9xL2FZVVpobG5DdzVDTEJBNTVkeUxRTDAzeFZxQTRpcGFMc1NBdmp2b0E4?=
 =?utf-8?B?SExkRGtERHYvZU9DMjJrQS9kSXJZN2dvVHQybG81amNxTUFWOTZ1ZWU2R0FN?=
 =?utf-8?B?M2tyUTJ0dDJYdWkxU2NjWm1weWJja2ViYTBaOHJqUDZPUXQ5aTUzdDhkN0JI?=
 =?utf-8?B?aGorcWVPRVkxOFNUeG9hK0V3QTZPOTV0alNKbDNad3BZcERTZDRuZ3NVNVlx?=
 =?utf-8?B?enJwNFZFak50eWgwdHV1RFNmVEtMMnhqWkR1S1ZwRDc4TXBKcU9wS0pyV2tu?=
 =?utf-8?B?VlcwWEVLeDlrT3FhLzFXZHhlbzREd2o5MVlrblZyTGpkczd5ejl0cmthbi9w?=
 =?utf-8?B?eDhkb3BFU2NtdmxtcjFkSWI1cWcwZ1BrSjlCTEtIMmhpODdqT1plMkJKaWw3?=
 =?utf-8?B?ZjFhTE1UemtDZm4rWG5FOVNzdFd1NklCWnJMWmZ1MWRKeFk5SUx3aUFHaDV6?=
 =?utf-8?B?SjhkZTdOTGJaQXhwRVhDcExMSUdEVVFLeDNjcHZhMFZaMGMyMHU4akhDUGtF?=
 =?utf-8?B?NU9iQUszM0s2L2t2WGpacFNPZzYyQUNra0t1Q2RFNzdrNmNpN1R1RmM3cmMr?=
 =?utf-8?B?VGoySDNXSG53WnlEdXRiOXU0R1VITHpwVGJHSnVDaUVQUGVBK2VMRVl6ekcz?=
 =?utf-8?B?ZGtIOU5XYkM2Nit0LzNsYWJnWm95M0Z1RlZzTnRzcVRhOEpPcnhjYVJuZ3VO?=
 =?utf-8?B?WFRieHVhUnpBWHJ2MFNyU0pzUjJFWFZNdEMxZ3lKdDVBd203NTk3SHhKSDc3?=
 =?utf-8?B?TllwT1IxeEJiRWw1dE1pNFJyU2V4bTduMWVpZGhDNUpvM2pCbDJjVU9ZUFNU?=
 =?utf-8?B?SFUvcm9jVHlsZkNreXRGY1czQjA4Ym5qYUR2YytJaVZoN2JnTUJEcTlVSi9h?=
 =?utf-8?B?WGh0NmFzc1N0ZjBZZXVOQzg4K2dQeHdaV3BMTVhvTVJVeEFoMFlpMzhuczAv?=
 =?utf-8?B?bzlXTW9ST2l5bGJMNjg5V1k0V25nNFUyMVdiWnZpdWNyM0JkbUhnT0dSRGlX?=
 =?utf-8?B?NmJuSjYxMlpBY21XVHFhSW9zUDdqeStzVTNmT3h0WWYvbWpYTVdYRDdXRHhG?=
 =?utf-8?B?WEpkdlBoY1hCL3U4eVAxRUFVZWY5cFVyTlZVeDF0OVV3T0xIT29UZ25RaFMz?=
 =?utf-8?B?UHlvOTFtcjhvYXJzR3VxWFFXQTh2bm04YXZuNWRYcm1NTXFNRnFNQXBXMEdH?=
 =?utf-8?B?ZkFTeTFLa3J5TXlPOUd0aEsydWxONXVYbHora3pnRlZJK1pKVzZiakZPVlBD?=
 =?utf-8?B?OExNbGZGM2Z3Q0NQc0UrdDNGN3NNOWNvSjNBT3ZIK0hhdWp3MmZUR2I2Y3lU?=
 =?utf-8?B?T2lBYnpDSHBXMXl5aXVoK3VYQjRDOTVnOVQvYlVNNVh4VmFhejBzNElmcTJL?=
 =?utf-8?B?Q284Z2ZtQXNoN3JkVVpvd3FCTlVPZGtPQzVIVTZCOGhqY1lwbjlsSlRjdi9I?=
 =?utf-8?B?VlUwUkpRSFEzbXVZT2VtVDhqelZGaUQ1aGdtODZURjNaT0FlUnp2U21HVW1y?=
 =?utf-8?B?QXMyV1VHWnRTdXFPdmFScDdRcmhkRVVhN2t4NUJUSU9Na1hRN2JCNWhnRlh0?=
 =?utf-8?B?Z3JLMjlTNEZMNEs4ZS9pTVhTeStTcysxQ2ZIUT09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 07:11:13.2717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bd1d6c-5fef-42cf-6d63-08ddad6e24e3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5799

On 16/06/2025 21:40, Danilo Krummrich wrote:
> In SampleDriver::probe() don't call pdev.as_ref() repeatedly, instead
> introduce a dedicated &Device.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  samples/rust/rust_driver_platform.rs | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> index c0abf78d0683..000bb915af60 100644
> --- a/samples/rust/rust_driver_platform.rs
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -32,13 +32,15 @@ fn probe(
>          pdev: &platform::Device<Core>,
>          info: Option<&Self::IdInfo>,
>      ) -> Result<Pin<KBox<Self>>> {
> -        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> +        let dev = pdev.as_ref();
> +
> +        dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
>  
>          if let Some(info) = info {
> -            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
> +            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
>          }
>  
> -        Self::properties_parse(pdev.as_ref())?;
> +        Self::properties_parse(dev)?;
>  
>          let drvdata = KBox::new(Self { pdev: pdev.into() }, GFP_KERNEL)?;

Yes!

Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks,

Dirk

