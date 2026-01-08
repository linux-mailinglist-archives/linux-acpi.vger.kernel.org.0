Return-Path: <linux-acpi+bounces-20084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3AD05FBE
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D65300ACCB
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EA32A3FB;
	Thu,  8 Jan 2026 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fSbyOtGi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020085.outbound.protection.outlook.com [52.101.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BB328B43;
	Thu,  8 Jan 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902779; cv=fail; b=rtzTQUZ3YQwupRH43RKhZrR9aLWFjnCy7Uqdzia2Q9KhmUx9aMGvePv7bIxI9H+K+jM+uiMSIIe0+qSnmi8fKRBE8GCVU42VWzaj3zn7hYh1M4bm1GQG60Qx4dvCQR71hz4rdqgcCAJbNTNVAh0SjKdMu3gyrM1yLdwSfhUcWK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902779; c=relaxed/simple;
	bh=s+2UN9UYiOCOFk9sEthkmdUrvbZEjkrH+yI0mvm1kGM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FaBiOLf507F1i8MSzG3v19mAyYZ78NwxW1f4V47CC+ED9V2p0G2boGkdHmf7bE4slMI0STutpyI0LPB8BBDQ9m7woprdnXJwB9hyiI3ZbModHHBPTmO/yloy5P1yNBB4AXK9MpfT5tykE+x249l0DjqLtnDUYC6M5CpYRa7kk9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fSbyOtGi; arc=fail smtp.client-ip=52.101.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/KFtPKVbXyOeLu4sTX3r1OguD3dl3WZwMTqskNrevhX0CU2GambLa/bsOCLNoYc2RKtTIFjan0aDHJKzVEDof1bqWcVaP4Qn4Xrc7Rr5CTSiyo1mDy3lLJ0bab7J8XD7Elt+N+ExuP76KBEwOd3/FQg5z8fxevKLdo1hq+QnR9cUp0bnH8K/jS6aYS+i9ofMrDvof3lyphJq04FAyi6FLSDWnnFGwWyGQKKwC3KJNdsvcXyNxGskI9ZWWq6MRaELxDjaemV2BI5aYq85Dx7UVZjkrZlj0K/J1rgH2NmiajwUZTFs71QzLvHOSu3MnCqGuURHi4QCE1Vmsiy2b1dtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLfnFupHE3z1MShcAxamOZjNN7/24QDHpiJFYlEoNWk=;
 b=xr3DsauTtHSi7nV9wRTrQqakXPwrIwePE2R+9eZq7XzsHtKt5zxtDVgY6hgQ1v7D5ANVyMGAFT24WuyiCLwufy5DoTvAIgEw6BfptxMraP3rXbEMg3+UJZlw4eWbopeqXfAGrtoooOZ2ewhDDuo7ZNzEDhBCeIhZMxpnCX6tNsTvgLEt7zvJBWBF4UPJlJH6tcKzN+S75Xwt1d35436HYxumovsuay1rKGWYvpRmy4wRB+zHOdvYkhiWjRF/HHBiyGtomlJE4Dgb+s5oRkDm8Q2JUzDPGsZbCrk1vdqQ6eJwLoIDMmNVAALkrE1EYh5T5F0hhEKlNELXTtpzH+paHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLfnFupHE3z1MShcAxamOZjNN7/24QDHpiJFYlEoNWk=;
 b=fSbyOtGi/CwCl9O+eZuh6TCc4C9wm4/K9+2qhFKq8ubwS8XRucm+MxV8BREirp7COEc/PreGJK/NcvUHhDjfsbR+yKYqehQE0zBmAt/BsN7S+qw5LFpiVIkwTVMWvbsia+k9SUBP26i17Yx2oEBPBtgeDM7a2U19Y7VIeO2RoNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8454.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 20:06:13 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 20:06:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 20:06:12 +0000
Message-Id: <DFJH89UGFFHB.318N5A8X42JOB@garyguo.net>
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Tamir Duberstein" <tamird@gmail.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: implement wrapper for acpi_object
From: "Gary Guo" <gary@garyguo.net>
To: "Gladyshev Ilya" <foxido@foxido.dev>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <cover.1767818037.git.foxido@foxido.dev>
 <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
 <20260108132141.6cce4827.gary@garyguo.net>
 <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
In-Reply-To: <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
X-ClientProxiedBy: LO3P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 125c05e2-8d91-4a21-89af-08de4ef15feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDRpU0lTMDR0QUdXZmlmdmFhditlMjlsb0RDR3lkeXMwbm9yVjZzTjRXeEdt?=
 =?utf-8?B?V0N1cVBkQ0toZlhtcXlsdkZTUCtYcER1d2RJdnRvZHBDb2xPcjZIOXNHSmE5?=
 =?utf-8?B?UGV0TzdmbzhERUlUWUdzYlBrRTNQZ2RwKzNsUFY1UTJ5T2FlbjZRV3BXQlBx?=
 =?utf-8?B?dWVRWVdicGtWenBPamRqNXhOVHR3UkZhRUNlalRveEdYZGtSSVdrV0FqVDVh?=
 =?utf-8?B?ZGhjWElLUzdWTENYOTk2QWlUZ2pZSWRVbUFGUXBvaXAydUtHTzh1T09ObnBL?=
 =?utf-8?B?WVA4WnUxem1VeEU1YmYwUDZ4TDNoQkpIdnZQUzdqUGxEZ3ZzcVFsUjB6UndE?=
 =?utf-8?B?d05QcmhmbjIyODNpcVpIeFhyT3NoOGRvR0lUQi9WNlR1OHU4SkxqU0VJeC9j?=
 =?utf-8?B?dkxTRy9rMjg0b0FpTUxHK01MZS82Q0dudVNHc0o1YnBuOEp1T2JhaWRtNG9w?=
 =?utf-8?B?VzUvcTYyZU9ZdE8vWG1wQTNYSjAzS3I3N1Z3MDBVLzY4OWRRdHQwNHZ2bXNN?=
 =?utf-8?B?R0QxOWZKUnNJR0xnVnNnQXY1VkIzak1xRVFaYzlwemR6OHNBMGljN28xbm1n?=
 =?utf-8?B?d0ZmVGliU2FzZDJ0MldUUzd1WWJXL0dKUTltWWtrUzVSOVQzemJUeWlMRktP?=
 =?utf-8?B?cVFhZ296QkNPdUJER3IzbnVJYWJ6NkZycmQ0TEgrRjA1TDVuWHBPYzd5elo2?=
 =?utf-8?B?S05RTXJXVEtOQzIxVXJsbnk3L0VUdEw5dlA1dGxiVkkvUzRTdC9Xd3U3VWVO?=
 =?utf-8?B?bHM4WWpaWmw4SFEwQmQ5ek14aVdJT05mN2xLcVpVS3A4dlNjTExtOFJ1V1gx?=
 =?utf-8?B?dlg3NjV6L2lnb3ZMeFRXNnNTaUI5T3dtUDY0WW9EQUFpNmFRZHdVR3JtUUYx?=
 =?utf-8?B?bW5iLzRMRVJPZ1UxQzBJbSthT3c1QVhiRHNkbW9pRE91YmFleklaaGc3Nzly?=
 =?utf-8?B?bHJkZ0ltYWwzUUtvVHFTbnBNcWZWRVY4L0lETnZKY09KMEg5c2phR0s5NnpX?=
 =?utf-8?B?VktqQmNOa0JIWGo2WUpOWXFTK1lVNGxaQnVLaktTL3lZb2VYU2szS3JvVTJR?=
 =?utf-8?B?R2hubmhBQjNqS1duMU0xZ2dNZ1kzZVEyVzBBLzI1aEkrMUVxWmJDMzFOWnpH?=
 =?utf-8?B?UUhqcy85QWNsV0JlUWRrVVFPaWJVVmxKMkM2aXdaeTA4clh6SE1Xa3Avckh2?=
 =?utf-8?B?MTEvTnE2QlFVNW5vK2RkZDlRS3BDV2MzcUI5NnczYlZBV2dvZ3Jhait2SmFT?=
 =?utf-8?B?RXUvOXJBSy83YmtBWDd6aEw5YVcwTDdZcVR6TDJtVnloc0F1bXJ0cW9kc3kv?=
 =?utf-8?B?bC9ZazlqMjluVlUyV0FZMlc3ekthNFMxdmlDYjNMc2s4TmNmd2FFSkVhMTRJ?=
 =?utf-8?B?ZTQxYkRlbGp1MGNJcjhxMzVNUlJrc1M1Q05EUFB3MDN0RUxFYlFzeHJKWkJL?=
 =?utf-8?B?YzgyM216dFdVQytXM1UwK2dKU2g4d0lVbmFndUJjOUdMVEcxWUt3UUtLcURH?=
 =?utf-8?B?aVlDVVpQa2o4Q3ZGY3duaU96ckx5NFNTMDBkYlB3NE1NUWZjTW5nMVArc3lz?=
 =?utf-8?B?YTByZDljOVRwSUVDVFlQS25HREhKOUxhNENxUEZRYjNqTm9aWDRWVmVOVDJM?=
 =?utf-8?B?UGRqMHZwQmRFQ2tkTGp2bjhRbmJCU0dsMUJ5M25tN01xQkJUSU1qQlpzK1dp?=
 =?utf-8?B?eWx2b0NFQlNzZWgwcitRMjg0c0Jrd1ptdDJhWS82OWhKRFcya0JyS0FmZ250?=
 =?utf-8?B?UFBLSExmVW9ReTRyYzJYa1pDUDkzMVhPR0t6NjlxU3hxL0pvelFFa3BlMlVu?=
 =?utf-8?B?RXZPaEtNcEIrUndCNkRMdW9UNm9XQXVDZHJMR2s0WU9vZmROSzhFYXhmeWlo?=
 =?utf-8?B?QUxVQ0RWOGEyM0swdlV4RkNWVE5DbDdKRS85NmFQQ1hIUDlrTmtYT2Jia01L?=
 =?utf-8?Q?mjLSRtVq0qaa1s564Pj+BJDJtNCaCOZE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1dTamJNZ3dja2t4TGswK2VwRWRPUktKUUxsZW9NTUFURnp1Wk9rL0RhSUND?=
 =?utf-8?B?bjI5b2N2SHVNaE05a1ZER0cvNDh6eHBpTEhsNTJyeWFuZ092VGY5Sy9KSGhu?=
 =?utf-8?B?TWlMN3ZNbXQ4OGh0Q2M1Mm13VEZQeVhRelRHeTVINGpMS2NHZGRaNDE0ZU5p?=
 =?utf-8?B?UlBjdEF5OVJVQUpQS3NyV0ZpTmlYblhNNytmVTdHYWcyVlp4M1F3bjgzTWlo?=
 =?utf-8?B?ZWtvbjFiTVFNMlFBNlRXbzJlRGxQVTAzRVpyNzJmVDV4SXVwNkZJMmZ4cVdn?=
 =?utf-8?B?ZUR1SWIwTlJqemJ4TGZqSUo3T0txcjcrYzRNZlU0MUptd0NUWUZmNXB0RWQx?=
 =?utf-8?B?R3dRM255aHpmY3F1cWZvNTRXNzRQWjQ0dzV1VG56R0htUWN6Y3pOUkJhbTY3?=
 =?utf-8?B?NGl5R0plTXo4TEhDbyt2V0djaFgyZmZXZk1DaWNWRkt4MU9LWWZJaEhydC9N?=
 =?utf-8?B?NFUzZFR0YldRSUFYK0tud1ZwOGUwOVg1NnhOYmp5UjhoTEFRbk4rNVN1WGRx?=
 =?utf-8?B?bnRPM3laUHNBci96M1piS3NvL3UrNTJBZ1VQZElRNHVIbmpiMXVYcHVaM2Nw?=
 =?utf-8?B?d2NTOWR0d2NvZ2lLN2dFMnJEN0JGUWdKamFYMnpGTFhNSzc0UVlteWhqNVJ6?=
 =?utf-8?B?VlhlL2cyaGVGT2p6a0hLS2MrcjgzSm9DWTY0bVZ3THBGeVFxNDM5M1VQaVA3?=
 =?utf-8?B?OHNVMWczdXZaVUJ4LzZZRWZmMFZoMFRmVjJNbFJ6SHoraEVDbmNlZXBUd3lO?=
 =?utf-8?B?cHluNGVFY2NFL243WitoMzZpMGFHVzFWMmo0dEVGYVQzaE5tRFo4NUd5dElp?=
 =?utf-8?B?RjdvN1Zqdjd1eGt1d2xEVW1pc250OEM0QS8zNDFUUU4xYW5QYzQxYVpUM0xa?=
 =?utf-8?B?dW9tekZmVmRMSUk3blAzSmtRNys5ai9Fdm5LVVZsZGRRTXpWaWZMQlVNYzRF?=
 =?utf-8?B?VFlnajZvdEdJYVhSa1RRSUJBQk4xVHMxTnE4c1QxNXFSdHdNd1N4UWxpS2tX?=
 =?utf-8?B?bGZlM1hqMlhmOUFWVGp0SzVZZThheEgvdDIxLzQyWjFOa0JzMnMxYURWZENE?=
 =?utf-8?B?TS8rcGlIRTQvc2V1UTJjZEwxMmZXWnArS1Vodkl6eWJuREdlSWVJbGErVC9K?=
 =?utf-8?B?bzVMQlZrcHdFNWhTN09rZHFDeVRBUkV3bFhaMFV2Z0lxUWtEZ05zWkp0Y0Rq?=
 =?utf-8?B?VzNpQzBab0lFclQ5RWtlNDM4L2tCQ0IwQjQvQnFRWlpFcHVETzdrTTBjK0xY?=
 =?utf-8?B?ZFdIT0MycUZsMm9yRUNoakJvcmFZRzVTSExhWldtcU5FMVYvVUtyZldsZVVu?=
 =?utf-8?B?cVhkUW04aUtYd3FxTGlwY1UrcE9uTXVPT2Yzdnd2My84L3dSSXJnVnBKaS9s?=
 =?utf-8?B?UHBzdUNPbllMc3ZmZXZrWk50eXJJUU8yZEdMYUorbm1SWkllenluSnJldG1W?=
 =?utf-8?B?TVBWWWZMUXROYmp4WFpsUUxmK29naDk5ZnBMcFhzTnlqNFArV0Z3M0U1T3U3?=
 =?utf-8?B?TWp5bWpFUFFQdGw5OGZRQ0drMFVIMlZ5MVhCODBXVXYwZnpLT0tiQ3NkWEE5?=
 =?utf-8?B?aENQQWxvc3ZsWmdUWEdwMStZbklLaHI4VVkyYzNrVzI2cXlYdTZxUTU3RHRi?=
 =?utf-8?B?VG9Nb1hUbUNGVmdzYUpEdWdzT2ZmVGRmZ3Zsdmxka2tSZFB0dm1GL1JOVjZP?=
 =?utf-8?B?M1U5UyswcWxHYWNpMlVZMm4zMmNTYThPc1dzaFJNOC9xdmdEb2ttd0NQamVs?=
 =?utf-8?B?a0dRUDB0ellxUkNGQm5zZFZOZVhSc0dDN0t5ZU5vbWZ4OVRrVXpLa01QNFJ4?=
 =?utf-8?B?WVlCUENhN0tRU3RYYjJYeVhyb1JncGRadlFoOXlhSEVPYjdVeDVOYmRQWHor?=
 =?utf-8?B?TW9KbzU0ekxwWU55UmhKVlYwWGJoTFdRVlovcUp2Q2t6S1FEWmNZY21OSmtp?=
 =?utf-8?B?eVMrUEVMNHovbnVKRjliOXRuZWJlSUxwM1FOaW1MNG1GaWs3YlJwZ2U5YXhW?=
 =?utf-8?B?aHl5QVM5NjE0MG92THQ2ZExEcmxNVVgvMXVseWJaWExiVEVnbFRnRjZrUzNw?=
 =?utf-8?B?d2M3UDVQTHdORDVkQzltVDlnS0haVDFVWUNKc0R5aWlUeXRUK05DMElLUEI5?=
 =?utf-8?B?S2FGVGN2ZzBNZ3ZYeHliRksrTHpzL3p0VjU5VTRYUWFmSlVZblA2dXA0bytv?=
 =?utf-8?B?cUNWc1pETUVNNGZNY2lBbUFlV09ucStIRUtyMXdjTnFGOU1NWEE5RDJEZXky?=
 =?utf-8?B?YnhTdXhmRGUyVElPVi9xOVB3NXhlWDdTVWtBMndBT2tXeHAxNDcyT0tXbHhE?=
 =?utf-8?B?RFp2T2RTcUt5a05zL2x3b0NDTEFFYjl2K0M0NUJuaWpWUkJXcnpBUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 125c05e2-8d91-4a21-89af-08de4ef15feb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 20:06:13.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGXT1yNsNr1ZFZW6LHTp47dVHobGuldXv+6C9CixxDYKlsr7YNeV/DuagUVDpmm7JcB+t4BfnbivXIuuy+kRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8454

On Thu Jan 8, 2026 at 5:11 PM GMT, Gladyshev Ilya wrote:
> On 1/8/26 16:21, Gary Guo wrote:
>> On Wed,  7 Jan 2026 23:35:32 +0300
>> Gladyshev Ilya <foxido@foxido.dev> wrote:
>>=20
>>> ACPI Object is represented via union on C-side. On Rust side, this unio=
n
>>> is transparently wrapped for each ACPI Type, with individual methods an=
d
>>> Defer implementation to represented type (integer, string, buffer, etc)=
.
>>>
>>> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
>>=20
>>=20
>> Hi Gladyshev,
>>=20
>> I've checked the `acpi_object` implementation on the C side and it appea=
rs
>> that the buffer is not owned by the object (however managed externally,
>> could either be resting in ACPI tables directly or be allocated).
> Hm, I looked through ACPI_FREE() call sites and acpi_evaluate_object()=20
> implementation, and it seems to me that the acpi_object's lifetime is=20
> the same as its internal buffer.

No, it's not the same. acpi_object's lifetime needs to be shorter than
the internal buffer.

In Rust this is a typical case where you'd put lifetime on the struct
where you write

struct AcpiObject<'a> { ... }

> Overall, it is indeed managed=20
> externally, but acpi_object and acpi_object::buffer->pointer live=20
> together. I=E2=80=99m not an ACPI expert, though, so maybe I=E2=80=99m mi=
ssing something.
>
> Anyway, the current Rust setup seems fine for now:
> 0. AcpiObject validity is guaranteed by whoever constructed/passed it (C=
=20
> side for WMI abstractions, for example)

When you construct a `AcpiObject`; it becomes incorrect: the constructed
`AcpiObject` now can outlive the internal buffer, which is broken.

Your code indeed works fine today, but the reason is that nobody can
construct a `AcpiObject`. They can only ever receive a reference, which
makes the issue disappear, as the lifetime gets "absorbed" by the
lifetime on the reference. In essense, whenever `&'a AcpiObject` appears
in your code, it's actually meant to be `&'a AcpiObject<'a>`.

If someone were to add a Rust-side constructor for `AcpiObject`, then
the lifetime becomes broken.

So it works today, but I think it gives the wrong impression to the user
that the buffer is managed by `AcpiObject`.

Best,
Gary

> 1. You can only convert &AcpiObject to &AcpiSubType (reference to=20
> reference), so AcpiSubType can't outlive AcpiObject
> 2. You can't steal the data pointer from &AcpiSubType either, because=20
> the Deref impl is "logically safe" and only gives you a reference to the=
=20
> inner data, which can't outlive AcpiSubType's reference -> can't outlive=
=20
> AcpiObject.
>
> So for now until AcpiObject lives _less_ than it's inner data,=20
> everything is OK.
>
>> Therefore, you might want to carry a lifetime to represent the lifetime =
of
>> underlying buffers?


