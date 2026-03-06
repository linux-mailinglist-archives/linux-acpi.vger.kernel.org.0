Return-Path: <linux-acpi+bounces-21474-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L3jLX9EqmlxOQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21474-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 04:05:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0521AD9B
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 04:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D9353040FB3
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 03:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F581366069;
	Fri,  6 Mar 2026 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4JhB1KOh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6233C1B2
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766309; cv=fail; b=XqJVuVG992cB7LRb41VX6rqIOo/zBXlewJN4SFQ5eLhapx5tXc1fE8+YM1EfCkpnFxonFMsGwFS3uUmMlJU4IZKL2Hp+npS0/9rMKlo0BmM2QOao+5RdJ49snw8R1KbwXQD5mtYgLhTd1AnpTqWJd2J9VB4NfPNt8lnICE6WQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766309; c=relaxed/simple;
	bh=/7JNc9eM+5h2lpZoTMkuS5y3P7xNJ8L2Qk0W//ejA+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hbDLxyMu95gwSA0TInXnJ5lUpIRHfV6olMpXHFaL3SxNyJcGx3+WEto4S3g0xF0B6EoqlPB+0et4mFx7Kldjx0MtNiowaKs6b9GdDhtu2gtNf/5Pr61bLx5+Ma7LQB/AUGA1Tv/48k9mnmZFYnHszGehWOZEbti89+M20ivkZUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4JhB1KOh; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZoNPchPid+tQJ3smZH3QUXQxKgHZCJJ4scw0C1PV8Rbc05YQ8SD938kEwO1PIyrylmjtgLKv1m8zBLGCDrM3v8/VDnsle8hqu+F/P42gR2DVPWeyyHR0fUUor4fQ8RXsEz7oBLpyGM3db1zdVVzRusAg6V7/FmkZcnpQhdIuFK3egE0ALdZoJm50KkJs9hOp/xW4RtHTnKf7jcdoJ0Ls3OeHwcvtHijOkY4WTclFzxVBQlDN8TCHXP6CB11gc2EOfoY5Hd1VhlY6d6Svfxn2HOovOiA4N/AQnBg4g1VLHw8mc8E0gWyowKEqCP1LLX8bR+677NrtCTH5r4GW84Emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/klE+TwTRyPoLUMtdjgZKYyrHa/SMC0DqowIQzncibY=;
 b=CLJu77LFhA7WabywuJCwXBCDfJdujKlcKtTRrUP66SmKDwS/he7safi/B0e1QCFB+EIlSS5CFT2h+6zgmmbZaYR/f3QLsP8nL56C8URD1UYPYyvTCGFLmuUptwMxO0wtO6JAnfmeQvJcrDIKoR62AaSnftaM77pXyVT/NpUXgJNtRN11pQdBrGof17GL0aAHu6BePLfSIASwTnTjOp9xKFrgvYGZ1D7qgUuBtJsefmx977wJ0J+nw/5wjN+VzhDfjuNOVPaqLBBn/vq5c1q9m44BrEHRToiLdxs69rn1p93sRrqofWhmZdM/zKTio+4MwSXA6127G9TBoTOmxOu0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/klE+TwTRyPoLUMtdjgZKYyrHa/SMC0DqowIQzncibY=;
 b=4JhB1KOh1+ruhM87KY6zRvtyiqPvgWD4nOk3xMcRaIVcz4rKik8M/Hhyk0hzxc3q5Z2d/qasFyQFvo5GGDnV+G9bjx8RpE1SSrptX6qtL9FMtzgffTw6AD1kpfOaiqd0KpVKUNex1nvmt/c3CBSDe9bf/cbjYa5UZr7ZRFh5R6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:05:04 +0000
Received: from SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::a866:904d:73a1:d65d]) by SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::a866:904d:73a1:d65d%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:05:04 +0000
Message-ID: <4a2efab3-0419-4019-a43f-74fffab9aee4@amd.com>
Date: Thu, 5 Mar 2026 22:05:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Don't allow MFD devices to probe
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, W_Armin@gmx.de
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 Bin Du <bin.du@amd.com>, benjamin.chan@amd.com, king.li@amd.com
References: <20260306025144.604062-1-superm1@kernel.org>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <20260306025144.604062-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To SA1PR12MB9492.namprd12.prod.outlook.com
 (2603:10b6:806:459::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9492:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f552367-37fa-4085-7472-08de7b2d29db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	NDjXv8RJfhcrQLVuAWedsBPNAGM3/Vc4tCwBCeY8gPF+C0234o0XSh4Wj37y1iyM2Q+Ehigdo3WnGAEJyZvGhum+DiYt/2AQgDFhSmImQu8WKWcLefWNKuOgg+qk1t4qpI9o7KcYI0o9LjCTwTBuHgd0wLQaYulB0O5EA0EZ7ZN8FGfHzx0ibNse1wmvGg5BGW9uD7VPNMshbHXiU9QhObA67PfFQft+FC7md+6Wj8L1stRKdwvDVYVsX6LQvq8b/fQTU70cj/LBkmrEKXXPYPlx+VVy/j2cGVbvojIJQKgg40YVnYDC37yJAwAT4t8QOETvGA0Zk1T8+SyEk6cpLbLFdz11Icj0b0lZ1VDwGNHXijxevLV9VcPu88SHNI1ofJ3twe0wGNGEEhsj9RrJCrfiNR7oMBsc2rd2Wsb6LSah3A9wOHMv8rJVo0RHjEq1eR9ysF4BI0C/TufsaUNbvhxFRc/Bw8uMDperovg05bqbHaGwtCb7U6QpmtZ431bviJVbPODoXjSSmY323y3y7/jZHops3EI47zBRsyhBmb3dgAmvjyByicH86AlZLlyVTL16YMaA1KOTSHEcxsnZSRd0/TlnnENNQbvAXqVoBR2j8cQxP0NlNJucKVc3frNM+lUUVFDgZIfDfNBQ5FUMro4WZH5R6gFkmoFvI4Ju+X5YPIrq9ehw2cLkb41VNM7fSOYJ11Xj9XKt8nvgJ0cO9VvcwxgU94gzTGFbWZ17LD/zH0UYocb+g0JXrs+T5HMM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9492.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODB2dHBoWWwyNTQ1S094M1ZwUVJ3WjBWcGZ0a1l2bDZFbzc5OXh1bVI0YTNw?=
 =?utf-8?B?UkpDU3YyRDZ2VTRTMDMwRHdtQi8zQjB2WG0yTm1CQnZmSXVrelBxR0hRb05E?=
 =?utf-8?B?MlVnUmxnSTFVUXdQV3BrSmJXc1lDTUVxMnlLdC9RMGd2VlFjc3BNWlZ1di91?=
 =?utf-8?B?dDF4Z0JBWER6Mjg1YVdEeXdvWVdyMk5QMUNIbUdZdTJVY1pWMllIeVpaczRx?=
 =?utf-8?B?SmxJWWFhOGVpSGtHb0crdUY3RkYzMFpZMlg4RFVFank5Z2IrY0tQTXh5TUJE?=
 =?utf-8?B?RnV0c2R4cjNFa0dwQVhvUTNTTlozZUdKNWNuYjVvQkgvVXRpSjlXQWZjUVo1?=
 =?utf-8?B?R3VIa3UzN3c4SFBnUDAwcGZweXZMOGVSbzVNVmltdlJvb1U5VHBLYk1Xc1Js?=
 =?utf-8?B?Ulg4dU1oVVdvanRvbzBoSU9URDdpSnhaU1lOajdNMUw5WXhESk5UNFJENGlq?=
 =?utf-8?B?VmtNb0R3aGJsdzh4aWYrZHhFNTdTTDVLRENlUXRUdWdPeHJYMHBrMDRyKytB?=
 =?utf-8?B?VEFPbnlFMjNidjZSeElFQnpEbW1aZVNKL3JuUW9rOFJVZjgrYVVZTFl6R1da?=
 =?utf-8?B?NnQ2NUZMelNYbGtFQ0N2YzA1SGJhOTFTaEhNckprWEZNNzZtQmV2YVAvMmE5?=
 =?utf-8?B?Zi9mY3dwVnZIbnJrMFBNaFF2aFZleUt0bzF3KzZ1Z01Hc0YwVW1uYUw0RDk3?=
 =?utf-8?B?b1BtQmZBcGtpWkJMRnplOVFTdkMrQnZkTGxERm04UVVNUjh6Z0M1Q0d6eGY2?=
 =?utf-8?B?Y0VMbVovZnVIOFpFV1pXRHFKa05KOTNnaEt5Q2JFL0IxZ1JlaCtyeTVlQzJZ?=
 =?utf-8?B?RzEydzBDUHJLNVZYRUNtTk81bzByZURYRTlwYlFRZklXWjlOQWp1M1psSDk4?=
 =?utf-8?B?T2h1N3JVNk5xYWVtckpmb0NsQlU5b21KMm1zbkJ2L1lhRTZHRkg3M1JpZHVi?=
 =?utf-8?B?SHVCQmRuSkxINWNWQ2svSlZIcVBBOEV6dU9PaVJ5WkNBTWhiQ3ErKzJ0ZWdo?=
 =?utf-8?B?U0ZtRXdRZFNMZExoeXVjMjNFM2E4SkhORnBBcWJ6b1o3MXZyNUJ0TDcxV2ZU?=
 =?utf-8?B?MTJyeWFuT1QvUTNWQXRIKyt5cExXSnhvaTJHUGtTa3ZqYVpnZnBobTFkbHV2?=
 =?utf-8?B?S3FIbmdGMkc4cnhzcmk3Yk1YQVJZZW15b3N3ZGZFYXB3MERZSXRrSjlzVW14?=
 =?utf-8?B?QWt5TWF1b25mQWZrcERteTlFZWRIelJjMkJiMWd3aTJmNCs5T2Zwa0dkZjlF?=
 =?utf-8?B?bHBYRjBnVjZjRnBQWmNMS00zMjBSTTFjVjY4cmhrR3hjalROcktmU1ZlZlhN?=
 =?utf-8?B?cUkxVFpnL1NhQngzMkpYZGc0WEtZQlR4YktiSnFSRnVsU2hYWnhlYlJoWVRL?=
 =?utf-8?B?MUI0M2l5MGpPcFFJREFQeDdDY2tqeDJsYlN0N2pBSnI5cXc1MzNWb1dmL0Vu?=
 =?utf-8?B?K2JLcVFYQ005MzFOK2dzaytIWE9aTGR0UEJyd1J2UWVaU08xcGd3SEZROHI3?=
 =?utf-8?B?YVhEaWx0Tk5mUm8wWjNWMkw0Q2trc2Q0V09hWFJiNHppK0pQbXBjLzhEWDk1?=
 =?utf-8?B?b3RUUTJUQXhRNlN3dGtmQ1FXSCtZaCswMVdYRUE3N1c5RGF2V0prQWRqbkg2?=
 =?utf-8?B?dGFBLzNwT2ovbyswT2xCcm03Zjk4b2J1L0MweWZCYnhwUGNhMFdRVUd4MFpv?=
 =?utf-8?B?a2tVN2JXN0RaQkRRYjVpTy9NdEdXQWdlZUJJanZMZlc5K3RRYWo0M2NLRFNV?=
 =?utf-8?B?Yi9NNDUwMURhMHpQbCtsZzdUcGJ3TWFyVy82VktGVGo5amU3NmR5Q3MrVFMy?=
 =?utf-8?B?R0ZQZXBhR3lQVktwcHpQZ1RzdUxqUW52aG93UTlsMnVwN2JwbktIemN4TkhB?=
 =?utf-8?B?M2tXYk04cksybEtJTlZNVTFZVTNRcklrQTU5d0l4RGdZWGkwbkx0ODlTY29s?=
 =?utf-8?B?cWJleEJERGlkMDE2ZkVqT1d4cC9mNlBrbUYxdXJxeFVvdXVwYTgxVXh6aVlT?=
 =?utf-8?B?TWNaaHV3TEZIUzVwd052Q1lRTGMyWnkwQklmbm9wVlZHdXdvUTRiRE1kazgy?=
 =?utf-8?B?SzgxYXJPU3VHQmdmVXFmL09LTFBSUERIUXFEb0pmSmd3b3o2Q2N6bE5BM2Vl?=
 =?utf-8?B?SXpYZHFNNmVuRW56V1g3ZnVCMU9XYWFqRldJekhZdW1GRkpJSjB3ZzVJLzho?=
 =?utf-8?B?TnNDb2FiVHJBK3gxSkVKMkJ1RU1kZDI3NVVsUzZ1cWx4dlhzczg0V0gvekxQ?=
 =?utf-8?B?WS94cnUxVmFXbHJmL0dzUzVIbUdXNm1EVVc4QUdnU3E3clVtUE95clpqdzV2?=
 =?utf-8?B?NlNJekNBRnU3Zmkvb0syR1NyNzFwM01kei9ORWg2SUQwWGRTbWRadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f552367-37fa-4085-7472-08de7b2d29db
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9492.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:05:04.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2f+7QABTmDbU0xhbRx9UkJ0k/Kf5JEfozRE2p1WEiXVaPRAlsbDqZleRLge5gk59vlBsE4XagOzJUTWMmrMfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
X-Rspamd-Queue-Id: 3BD0521AD9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,amd.com,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21474-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pnirujog@amd.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

This patch resolves the regression issue observed with AMD ISP device in 
kernel version 7.0-rc2.

Tested-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Thanks,
Pratap

On 3/5/2026 9:51 PM, Mario Limonciello (AMD) wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> After ACPI video was converted into a platform device in
> commit 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
> other devices that are MFD children of LNXVIDEO are being probed.
> This isn't intended.
> 
> During probe detect MFD cells and reject them.
> 
> Fixes: 02c057ddefef5 ("ACPI: video: Convert the driver to a platform one")
> Reported-by: Pratap Nirujogi <pnirujog@amd.com>
> Closes: https://lore.kernel.org/regressions/007e3390-6b2b-457e-83c7-c794c5952018@amd.com/
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/acpi/acpi_video.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 3fa28f1abca38..2cb526775ac47 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -14,6 +14,7 @@
>   #include <linux/init.h>
>   #include <linux/types.h>
>   #include <linux/list.h>
> +#include <linux/mfd/core.h>
>   #include <linux/mutex.h>
>   #include <linux/input.h>
>   #include <linux/backlight.h>
> @@ -1988,6 +1989,9 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
>          int error;
>          acpi_status status;
> 
> +       if (mfd_get_cell(pdev))
> +               return -ENODEV;
> +
>          status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
>                                  acpi_dev_parent(device)->handle, 1,
>                                  acpi_video_bus_match, NULL,
> --
> 2.43.0
> 


