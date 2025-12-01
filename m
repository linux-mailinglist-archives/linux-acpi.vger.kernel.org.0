Return-Path: <linux-acpi+bounces-19367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA17C95A68
	for <lists+linux-acpi@lfdr.de>; Mon, 01 Dec 2025 04:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0182F4E0708
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Dec 2025 03:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FC1CDFCA;
	Mon,  1 Dec 2025 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Myl7eeug"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110091D5CFB;
	Mon,  1 Dec 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764560192; cv=fail; b=MXtBuNg/3QLwyg3l1fyGu4pWgt1w5cYtisOgCoErrDJZWu/LkAh3wfoHMxLrrnf9gXrKnxIAIMDSDPBCU/8UOLGg+TJefWsa8qWYTFY27/plOEGBzac8AksNs/nHMn6DFFtZrsmoR1dvCDnNt36UxAV/8t2P+v6QOXfzv/SLhU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764560192; c=relaxed/simple;
	bh=hkT+eJjsQqLsj/tYkeS6yRBuogf3G5P5fqWeVwAXKxk=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=qS9XNlClGxdtWLzUUGH2hdF+w+J8D0nz5v1StjtkSYDM2JmwoyAOlljzl2m+5UAoFait7IBQ9iWj4sgDdzjG8gAo586QenIcdbtHckfa7xYlX9EdhCjg/Zy9+2QcrXzhqW3H1zI5QyR0pj4nVR5I4NxWOh3EMjr4RLN2UagmAwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Myl7eeug; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQcGMbUiHJwvZoXDUaFnSoCnYKSQ7dbM0pJf2zK5R/kd6fPBWVWMPuLV0krC7h9b8C/HAg8Vf+5K7VGgNuuTMQJStKQVQ0n0n0uMpArFumlTEAsAdcGoTdt7vXi/dYQtpBGm+tFhst4kp4Q5eioY1W8xo3N9xKSyr8GjInhCGbWiov+A3rfyc0YwGRHrKPsSBKZ1D8ET+lWVLjutct1DZTPRVkr1ilaoJEQ8VfUN1iOr7LYtdKE1mk1nCA0dUFZFEmP1xGlwEb10pay/HZ2HQ+1ouyoTskf/Gsh2ZkSueklaEvTDYfOhLaSmmvw44WDQr0qVCFlkSkhq4DByHDqCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsNaIW7RbLmhiUK3ApNjPeV8/iOPPZPLI/AzxDmpTuc=;
 b=A037DJPR++EEDJR5cG++FwOiyTo6vH+6qV0CU3Z1DWj7Mnyy1mMz0LdRWT+MWCLgfU8Kigc1OzP0zrHvud56LtEGk9262C5fPYzPKD0D2OwEKRYiwAUKP1CR0BZ4Ar8HWNpPpNRSyVeyUAHUrRp1mU4dErFxCO1ccffNFmYDSf4o48Utz/0osh1EZQQ90u9nN1F7svF08KP5uE9KrR7dpF7QiTGDvJTrH1MkloFHiCHPdgRLgMaW7ySgP4msswZjpK8eEX1ofcVyNBFuIfSarjxHYrMN7eivAqYBscTv3BqRmyCynRmugTANdu2TdVd9OR0mSP/bl4tClmYTEX9YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsNaIW7RbLmhiUK3ApNjPeV8/iOPPZPLI/AzxDmpTuc=;
 b=Myl7eeugrqNslF/tYOdOY4UEnvTBg5T5wYv8kfb3lGqSJ+WXJks4dAwn3VZUGpoZnpLwckBICX9APuoab2EMGnV91srpXU6sBFDC42oaT0py+sQAGIj1eRyVOCPZVHHkNR99RYz72VDc5f73tqblpoHxP73FbCLQJ5IgHExzjToI3elrEcrbU26DvZAUgcj3skAPz0SJw5Y44x+d+5OBwXEfUdtYXB2RnuqHFKX8X2F48JzOKpM9KwB49r521h/Sm8bd7M92rc1/KrMrHJj30gylsFF8LUzcEN/vimIpvUvh+bSi5plzvwXi+GTNJ5gDMPmwZHMGT+svHCOOQUF+Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:36:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:36:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Dec 2025 12:36:22 +0900
Message-Id: <DEMKDP6SAN8X.2W77GYK34BQX0@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Atharv Dubey" <atharvd440@gmail.com>, <rafael@kernel.org>,
 <lenb@kernel.org>
Cc: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <linux-acpi@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: acpi: replace manual zero-initialization with
 `pin_init::zeroed()`
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251129122753.23022-1-atharvd440@gmail.com>
In-Reply-To: <20251129122753.23022-1-atharvd440@gmail.com>
X-ClientProxiedBy: TY4P301CA0119.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d92f17-370e-4770-74e4-08de308ace88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2JQc3dKZWJGM1V2Ly9sM1JqS01UK3JyTXNkTW5EbU5JZEx1MmNpL3dVam1Y?=
 =?utf-8?B?cmdHTjFSa0tzZzRHb3IwV2RodTA1YjM5M1RoZHJPNFJINzFXeHlKTWxCZ0JZ?=
 =?utf-8?B?U2FMYXdheWNLT2U4OGhHbTYxckwrYlNjWFlMblJCQUZVUTcwMFQxTmxTaUFy?=
 =?utf-8?B?VHRWZHNHdmgwY2FENlZNaUxFTlRwZ2ZsQmdiRG1XejhuL3J1RzVBT1huTFI0?=
 =?utf-8?B?MENaOGNDcHVrc1hKVzhQTWFBNHJJRHdPNjZZN0h1dm1tRUpELzZ0NEkxSjB1?=
 =?utf-8?B?aGZqL1JmOU03c3ZVbnVlZXd2NDRMVGlWcldJU3I2b1hmbldFcTMrM1hXL0Ix?=
 =?utf-8?B?cllsd3NvSzc4UmFrcDYzZTlsdkRZT3BzU2laN3NhcjNsWU5OcVV0bXRCTCs0?=
 =?utf-8?B?UWJkeVhzQ3dCRko5Tm1KY2J4a1NtMWV1SzZONWtsYTQ5VE1ab0dFaWVsTmgx?=
 =?utf-8?B?QVgrY2F3U0ZZYVJMYlBuOGVlVDFCZXoxblRlY0RnQkNwSC9UOG1FUkF4b3B4?=
 =?utf-8?B?Qnl3aWNETHFPU1NwdmFveGN2K05GdFNmLys5OW4yei9meGFnU1haRk9iSnNX?=
 =?utf-8?B?dVM0ekFjODNjcDdhdytyMnMyME9XdHZDcjFHd1orZkIzSHV4Q2FrZTV1dVZ0?=
 =?utf-8?B?VTFvR0ZVbHY2cVIybTZzSlo1TFlLYWZRakNvS3h4SzFCUHdVV3ZrVDI2N2wx?=
 =?utf-8?B?N05ueXlpbmV0cmhzVzJzaDFVblpHakZ4VUpoMVBQNlFEbW9vN1U5Z2lEaXZk?=
 =?utf-8?B?TGttVWhRUFlJSDcwR00wSW5PeWNZenlsZkZnR0NsU2IrOHZMemE1Z0pDUHU4?=
 =?utf-8?B?STF3YUhuQ1dJbzBDeDZpSVkrMUJqbndWNTB3U2d6QkM2VkJ3RDc5SVFNYS9m?=
 =?utf-8?B?eWtPWk01d3FpOC81a3hvRGNNT0R5c0MvZzdZK0VFdEU3VVBHdUx1R0J1d3Z5?=
 =?utf-8?B?VmxneHY1bFZQR3V5WnY1YWhaSzd6Q0swaW5kS0dVSDBDc01pQ0drYWRXUVh3?=
 =?utf-8?B?UVN1aERiQ25xMU9jY1NaeDQ2Z2ExOFdtMU5ZQzlYcG1BSTZNSmVKSWhzdkxU?=
 =?utf-8?B?VGNGL0FFeGxxSDJtbnZuM0w5dlpCMDZzM0ZFQnIwUHJIRm5XcTA5ZGJhcDhC?=
 =?utf-8?B?Umw3VWg1TStsRG5JdExaWnZPRkRRbnc4cE96ZUdLbEl0TUZqM3gvMWdGNlFE?=
 =?utf-8?B?VzhHdWdmT0xuMTJkb2o5ckdabkdWQnpWSWxRNjNhV0crQTZNeUxTRVYvMEI5?=
 =?utf-8?B?VVlJcWN1alpvbk04OWpQYWlLeHNnWm4wTGtMalg4RXBaTXptVjdIQy9FWXpW?=
 =?utf-8?B?d2I0SGp5WmMzeHZtNitFbmRtTmZLMHJjZEc5RXp4Z3JJb2JFbitiR3dNVlhO?=
 =?utf-8?B?bU1mQmhidWVqTzE1Nmd4Q1I5ODl1M2NnbVRJZndDS1B6WUZqOFU0NHZHcEhI?=
 =?utf-8?B?dExxVDFMWHlpN3MyZElDNzBvOGlUTEl1OFJHYXVLbmZWdjhKM3k4UGh3cTR2?=
 =?utf-8?B?QzRBU1d4QWhUVGZucnJxVXdRZHIzS29leGNDU1pDV29vZ1RUT09LcU55eGZC?=
 =?utf-8?B?NlJEbWlReDhHWXJYUURKTmFrNmpXUlBDUThidmtsRUUrOUgwU2wzc2oyMkNZ?=
 =?utf-8?B?NnQ5SDJubnN4U3VkQ05DUjdRM2ljeklrZGJjVkFyaTdlNy9sSnVhQVd5dE5x?=
 =?utf-8?B?dHYwNTdvdzBQbFRONDRKeGxhWXJCYUZ2RUJ1WEdWNmwvTjQvMUJ4MEVpYjIr?=
 =?utf-8?B?ZUFCRFdsVk1kQ3pVMUdhR0tJQzlPc0ltN3dMNDA1RDR0d1hobTFIdW1PSHcx?=
 =?utf-8?B?SnpRMzVYaVlnRU9hKzcvTVpCcVB0cHZwUCtLdUp0QkNGOG56WWdaTmRyL29q?=
 =?utf-8?B?elRLUGxDL2FKMGZLenpvYXBlTzg0SElGZThaTStYNzFLSjAxeFlCQ3lHdFMr?=
 =?utf-8?B?S2d2TjMzYkE5dzYyZUYzQ1N1WjdNTHlUajF3RmFDem5sVHZPTk14ZVgxV1pZ?=
 =?utf-8?B?TytOMEtNMExnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJCKy9GcTRaMS9hUk01SlpkMldDZEdoSFA1NGZVTk9OL2VEdTNtMGNxQXZY?=
 =?utf-8?B?ZFlKclVRVFRpUkVyREQrVFg4Y2NjbEJkZTBYZ1F5Q3VIcXNCU2VtS3lCaDlx?=
 =?utf-8?B?SjR5YWhZbkVNMFNYL0ZFazBSbkZhblVULzZKTkpONGxXaDRlR0dLUHpIc1lX?=
 =?utf-8?B?U2hFbStuTWRUekRlZWQ4S2p2d1VhMVIwRncxaDNFdWJ3RVBvT0k3K0VjRkor?=
 =?utf-8?B?bGJGeHhWdXdVN0pKYTAyY24yNUhHQjZVdWxLeFlpRC82Skp2cE5KaE9sanlY?=
 =?utf-8?B?Q2dXam5Candvck5XSnJEQ0ZxckV5dVBtdHREMVd0aDFiWVZpcVNSWnBMRzlj?=
 =?utf-8?B?RXB0VXpmdVdGbXpRTExTZHRWbzZaWEJZOE9uanpZMUVzV0hyb2hidHg3MDVD?=
 =?utf-8?B?aHh6ZHV1ZHNLb2p5Z1hMT2dtczBZY0s2WFA0T291c24zMlM4M1AreHBadlNs?=
 =?utf-8?B?S29CK09TUU1wQmNqY2xPMnhSQzZKU3lyeG1HODBuR0huVmdjZlVjcTgwUTV0?=
 =?utf-8?B?Qk50OHJqSC9wbHVUOCtvbWFPdnluNEFmVGc5ZE1jaXFJM2V0SkZsL0tVdVBI?=
 =?utf-8?B?Z2xjWUFnYTg4S1RPR3U0eXBCbGRtUkx0T3F3TURQTGtJL1pxS3Q0QU9mSEpQ?=
 =?utf-8?B?bExNeURXaFlhSGRIbVM2b29YclgyZng0KzJqcml6MkI3MWFhdGFhRTZMeFo1?=
 =?utf-8?B?Z2lWR2kvZ3dJUDcyZkwzZDA5UGVBV29rUTFlQUlxM1Nzd1d4TGpsQ2dLTC9N?=
 =?utf-8?B?ZlFENnNHNzhCVFVORStXb2VtK1FjVjhpRHBLczhoYzR6V3UxOHdkeHRkL0NL?=
 =?utf-8?B?Q3hOL3JLRVc0SzFaZFgwMmxaNjBuTHVOemJvK0tsQ1RoTHhORnc5QXdidXB5?=
 =?utf-8?B?NjN0VGNNY1pNWUw4Kzk5amxGUXliNnVqMDNpVDM5MU9VMHoxT2FiTGNiYXF6?=
 =?utf-8?B?SUUyUWpjTXNLVko2SWVvSU50QjZHQnBZMHVTRnQ1V0J2V0hsWm43K2hXTU9N?=
 =?utf-8?B?UENpcDhsMUYrS2FRbzJQSzNPM05EZWREVk1ZeDhvUW01Q0lIMVBVNGFQWW9x?=
 =?utf-8?B?eTYvaTdqY21YbzZIT01qbHpYSlpEb1JWT2EwR0hmYWQ4VWxzZGliVUw5MFUz?=
 =?utf-8?B?dTZFdFk3cHdKKzlDWUQxbjNKcUhDOFpWM2RiRXFxTUMreDZMM05Vb3o5VHdu?=
 =?utf-8?B?cjI1cVVEdE5CT01uUldCN0lvUWFXVG4wRWNraWd1T1ZVZHBLSUs5NnBjQlFZ?=
 =?utf-8?B?N0cydFZQSER2RVIxSFZiMkdtNmpDMEN5T2ZVZU5QRk9uR2ozRmszbXZ5TzVR?=
 =?utf-8?B?cjhCOTN4MjZxVXJ1SURDVlZ1dC8ydEQ3YldDSlZYSGF4MzFxQ29UcFBzRmFL?=
 =?utf-8?B?RGg5YmlCMzVyTEZWWUVuY2ZHc1YzZXFpTjhoZ1l0M1RNdDZzQnlrTEIzVkxa?=
 =?utf-8?B?YnJiRWJlN1BIR0JSb29MWS9tdUY1VWlPU3dMYThiR0RRcHpEVUFYSENpTHlX?=
 =?utf-8?B?NVByNy9qV0U0Tzg3cVBxOHV3VEtLVHo2T2EvdEVrVy9qNEJRTnd0T00rUVdE?=
 =?utf-8?B?Mk9VNGVGT0MzaE9uU2Y3cWViVTErQjhNa2d3Ky82Rlo4K2p0WHBFWWgyNHpE?=
 =?utf-8?B?SDNXenY4dEhRNnk0NDBBejJDUDFkQUx5bXdWaVM3b2hvUENvZEN2VUJPRnRO?=
 =?utf-8?B?N1ZuSVNjZnVwTDFHdHVyVFBGWlZUQUZ3eUN0RWRuVFl4TkNUSHJVNnVoZnVt?=
 =?utf-8?B?UzJZbGdFa2ErTUIwU1pYWnExUjhld3FKWnU1aVJuQlZGWEVvUkQ5THo2YUZl?=
 =?utf-8?B?SmtjeE5UbGpqMkZ6WjZlTzA4OHg0Nlo3QjZJWTZuNTJ3WTdZdi9mKzJsU05o?=
 =?utf-8?B?MHlwd3cvU3djVDNUN2pjeWdFN3pzZFZYb0dvcHVDOFJjSVhsL2dtS25acHhS?=
 =?utf-8?B?VWlndXExM01UMjV6YjV2a2NmT2h4K2xyYitJNC9VcG9Nd1ZlWGNmbndKRzFy?=
 =?utf-8?B?NnJDWWV3b0p0VmprRldKMGlESWtmMjhSVWc3SEZMSkJqMDFLYzZRY3djYk4x?=
 =?utf-8?B?ZnVmdEJoaXA0N2dnSTlKR3BoV08vbnFYeXpZNEZ0eWZkT3RHc0R5SE1YRnRj?=
 =?utf-8?B?RFBRRFdmd0pIR3dNZUtOQ3dWMGRydUIxU25DZ25sRXduanZwb2tURjkwbVd3?=
 =?utf-8?Q?SSUZDivcpvJP9vxdhYY0Tj/gUbSnuZ7SEglQ+PbPUYM/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d92f17-370e-4770-74e4-08de308ace88
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:36:26.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t/n47vji5Djc9sI8v4glt1Rbpdo86S1VaOh635T+rwmSWh3w/jNlifDpEZo6gy6rZUXVP958BC5MFAq88BkdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085

On Sat Nov 29, 2025 at 9:27 PM JST, Atharv Dubey wrote:
> Use `pin_init::zeroed()` instead of `core::mem::zeroed()` for initializin=
g
> `acpi_device_id`. This removes an explicit unsafe block and aligns ACPI
> initialization with the pin-init conversion used across the Rust tree.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
> ---
>  rust/kernel/acpi.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> index 37e1161c1298..9b8efa623130 100644
> --- a/rust/kernel/acpi.rs
> +++ b/rust/kernel/acpi.rs
> @@ -39,9 +39,7 @@ impl DeviceId {
>      pub const fn new(id: &'static CStr) -> Self {
>          let src =3D id.to_bytes_with_nul();
>          build_assert!(src.len() <=3D Self::ACPI_ID_LEN, "ID exceeds 16 b=
ytes");
> -        // Replace with `bindings::acpi_device_id::default()` once stabi=
lized for `const`.

Let's keep this comment as well.


