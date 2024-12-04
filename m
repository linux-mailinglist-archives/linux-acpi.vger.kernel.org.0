Return-Path: <linux-acpi+bounces-9910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE19E31A1
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 03:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C317B29DB4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 02:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507D13A271;
	Wed,  4 Dec 2024 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sQMgzktD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F77868B
	for <linux-acpi@vger.kernel.org>; Wed,  4 Dec 2024 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280700; cv=fail; b=IUfouH0V9sPhswFq9DUF3JY8qT/asJsbfMqPwzo6qNg1l0u5vaix8m0eDdRxtXdwfnc2s4jQaG1APv7fohYmY3QI4pXvmMRtw68Xq4ShnLZ75qVTeQWEpXQ1xGijCP87aMUDitgCTKPcOqmYFNr2BVDAz/dq8z/i82hlhJf/Vb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280700; c=relaxed/simple;
	bh=zgMl06jBTHBRfJYuvzqbxj7IOQ4ajd9s3xuQikgH/Is=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tzytzrnqo1KBVsk0bf7OAXllbTYQvFwbHWITfJudDLb5hifL7kB103JMUAKYQhwXB6nlVCNlWj9HhtABL6zNBrXq7+Xma3BRLX1mg+2D2ZHbb9tp+MKYKnBF8xz4OKfYL8QG35vwZMsRZP7ikuQaIf3depjYjscsWPa58/xMmt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sQMgzktD; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqMYKpB0+AxUvobEHxD+S9MmowQI+bAy+K4E5cz7aS+pFQPfyMBiPqr11yiWetzU/UoZqUT6j3a3U5VX6rFyaPKQFLrQd+hVrS/lohieC5s+bfrCcBbKnu4sryBPpppiLlem99vi+S7Nltwi0IOQ3MWXt2UJpMvExgzkKYhCdBjs/JrmbwTSqwZGwYrVMrMg++ZQP3IIxQRR3eGul0SHDc2Wpc52rhzoDwEeDvv4A0fBKF2Ts7iXOOrxqzNjCwr8unihEJj9rIf7mbAQcmd4j7Coe1AoVyjt1jNS252oe/umXFt+eNYq+NwQctCL5gybrFlACOx0RK6mnoSAHTP0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgctVcWoKyP/u40pe+eqz2EYfi+NjKutMn+RkFlr8/E=;
 b=uVuJUEns4ndZfsXJoef3aj25uIAlDshn1AKZFFyQv/IbI+oAVz0GMiCKjPUhHsrE6TWFqtr6XdA6YWMhCQPpqR783a3+/9WbnGjixiyhf/m2ta/s54rhVQ5GxqER+HxR7RJLVna8L5fhhxA5ruorNue5k4BS3fs5nRCPcOd17ww4NSdEuMcmvteQ15tllTbUAb1IP/9V7o27g2tQps/zhDiSguntng7gfO8lBep73K+bbGfNHFcHNbd2C+TA4jEenphlywznCm7WbGFkLgDFyO8lDGKMvw8H5mUDGRGTeOGO6tf6+Ubqwszp1na2OzAyFFD3UQmHFGizZV9I59jeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgctVcWoKyP/u40pe+eqz2EYfi+NjKutMn+RkFlr8/E=;
 b=sQMgzktDei4pLlG60pp2YkC9NFFv7SoPEpjtVO6YQSWGKC/XKF5th6odfuxiD16RhqFxObWfLyZP/eClEW4eoZchv1LSmVnCXPjymbi+h8vAPfDDlqMj25jt3MzLTDQWJEWQ2DjAESExzI/wvuuqc587uhygBdcET58P8x3xCP0TIcHM09Fk8iqM06DptWUiUhzEI8cWW1VvRYYFieNNGux6kTsSityIx+RaWVaR7XFDZ6Mv2dWO5QXpIeYZWONFccZzgTU9Uq6aE/vOp7QK6RWyVh9ys6RXaTgaDm6b8kSWezNewkxCTga+/tDwFbRKxnlHzCkzkjzkFW5Luc+GOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Wed, 4 Dec
 2024 02:51:36 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 02:51:35 +0000
Message-ID: <c2c5a70b-8b8c-414b-813a-f0a82562f718@nvidia.com>
Date: Wed, 4 Dec 2024 10:51:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/HMAT: Move HMAT messages to pr_debug()
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Priya Autee <priya.v.autee@intel.com>, linux-acpi@vger.kernel.org
References: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
 <CAJZ5v0gTc_FzwkSxPEa7izbDYz6BWqx72TzEXxHGd3MRR8EUFQ@mail.gmail.com>
 <0ca3dbc4-e791-404c-8058-2b2c24051f5e@nvidia.com>
 <48ee2dde-de1b-4af4-91c8-eebb4e15e191@nvidia.com>
Content-Language: en-US
In-Reply-To: <48ee2dde-de1b-4af4-91c8-eebb4e15e191@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:404:a6::14) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d7217f-5eab-4452-0fa4-08dd140e9147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWdPTGlQVzNrbFdMOHY0dG1ybHI1dTVIcGk2T01XbmRrMmNVV1E3cTNicy9z?=
 =?utf-8?B?NG4vVmIzV2t0WHhvb0U2SmVGOVVKU1RsallpdTMwenZVeUM1VnV6RVZZZTN2?=
 =?utf-8?B?OHN3cTl3d2JvaGNmR0FMTHUxK2xwTGUwWXkzNC9kWE9RMFB4d1R0V0NBRkdE?=
 =?utf-8?B?N0dqeWlvVWN2WjZrQU5NK2VQRFd0UXZERzR3cEJ1aGdGUGFibldzQjRncFds?=
 =?utf-8?B?QXloUExmVlZxSDE1UVlZRXRab0ZKcElvWEhTY3lhaGFxbTg4SWwrbjlhRVNC?=
 =?utf-8?B?VjYvV1d6bXJRY3p4UWZwd2FWMm1KWG9aWjJlMDRPN2NscjhpMDZ1YlA5R255?=
 =?utf-8?B?MytNTDJOd29TZU9vdlNXMG9BNVJTSUR2Y1JxRnlzM01hV1FsaGFNVTRSa3B0?=
 =?utf-8?B?eDc0VU9HQlNzWXYxc25GWlZiUGE1bXQ4YVhtRkt4bGZqNmNiOEJpVDcwWjgy?=
 =?utf-8?B?NmhOcDVBakl3SWhoL2Z5ZUlDSGJrSGtxVjdlRDBkdzdrZFVaZ0JrOE1KT3Rr?=
 =?utf-8?B?TkpuZ3pMc2hKR1BHWUNUSml4dnYxZStVNDM5dHRWUGlkU2gzK05hWlp2TkMr?=
 =?utf-8?B?YzdTSVM2RXpmYkkyd2k4SGlYNytUTkRTV0xPZlJaYkdGWTNsSC9Gc25pVEtF?=
 =?utf-8?B?TGNGTTh0Ym1xckpEcWl1Uk4rZGdWTkoxcHZ3dU1nVkplbnlEdW9rdzZ1czM2?=
 =?utf-8?B?SHZWcGxiSjNOOFo1MER4VEIyR0UrSVhLWXVDVU5WelNUN0lYUUFnRkZqMVo2?=
 =?utf-8?B?RDE3SWVPNTJSWmROKzF5UDY3Rm5VaHBtNHZEdjM0OEhRSUlPcG8xOGVLUHN3?=
 =?utf-8?B?RTRpbm02ZUpUNGlQS2NsZnRFcHY3S0VXbFZvWVhYQ2tMbjlCeDB0c2Z2OHl4?=
 =?utf-8?B?SW9pSUJUQkFkZTJNQVNJMUg4RHpQMmhaSnB0ZW96ckVjYm9DTllxZEZYcXJx?=
 =?utf-8?B?MzdxZTJldGh1eWZRenZpMjNoS01Pem1HelZVVlpnR0NTRVA5b0JSZ1pzSUY0?=
 =?utf-8?B?R2Y0cGdRRXpDeGV6UTFSMGVsWlYxMjBuazdqQ1ErbTBTdEl6Z0F0NXhtZGFn?=
 =?utf-8?B?VFd5TGYwLzFRZStLQ3lsUDlRTVhsd2NZeXFhTTRTdEhLUk9GZ3FvZE00bG9I?=
 =?utf-8?B?WGpTaTc3YW9iUHFac09BZUdtYVl0dGVTZVJGdXdFVHBWZWV0em9zNTRpV3Yz?=
 =?utf-8?B?U1pHUnNEclJRQ1VyTDF5SjNUMEVJSHR4RkZVYmp5Y2E4L08xT0o4alFzZDR5?=
 =?utf-8?B?bkR5SzdtSDJPR29XYVpmUDIzcVlPc092SmJaK3EvVUQwUmZZa0hORFJFejg2?=
 =?utf-8?B?d1FRcWxNMUwyWWFjRHNvUGhybEJkVWlvbC9LZmRWRmZjT1MrNTNlTzJmZ1Vz?=
 =?utf-8?B?WTJIL1E4K3R0MVpscGtkOS9kclg3OW1FNWJQY3JNRUxXd0owUEI0TXdXU2Jt?=
 =?utf-8?B?WlFsK0NiNDZSdm94TXFsb250RzJHNUZzT1FmUkxRYlFMOVhHNGJGM3BrazJt?=
 =?utf-8?B?ZTFhRXpiV1QwTlNobTdOcWZDM2RXRmQ3WGNDME1XanFYNHJJaTBXWStVdkFk?=
 =?utf-8?B?M0dBRmViQUN3ekRJK0VETDhCWjQ1alIxejl0OXJqRmUzaG41cHE0MXI2cnZ3?=
 =?utf-8?B?UGNkUmlHbHVyVWNRUmNNaGsvSS9hc0RYbWZTR0xlbU03TTVNNGN4YW9OUjFX?=
 =?utf-8?B?Qmo2NFFqNjBUNzQ5VGdBaGpxeTNEMERPc1oyT3ZIRjhjQ0xWQ2x4UVNRUzJ4?=
 =?utf-8?B?OTVWNC94NTJpZUJNUXZtemFCUFZHcGV3TC9FaTBNZkkxZktjTjhkK2JLODYx?=
 =?utf-8?B?YkdPNDdyWUpLemNBU2tSZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJ6ekprcDFDSVI3KytXUVZ4cW00bVlhVmtxR0J0NXhpaDdmNkxGc3dzN0tM?=
 =?utf-8?B?Y21KRUQzWDdZKzlXV0ZTRW11eW5GZ1JVbFFidnlDOWluRGNMZ01ZY2ZiV2ZN?=
 =?utf-8?B?aHBiYk9NT1NmTmRTQkFSZ2FkVlN0aDRKRXJEK2ppbHhQdkxWUXFrZ0hzeFNq?=
 =?utf-8?B?djU2ZlJ6TzV5QWx4cUdSYkVCdjFHeFVnSFczdy96ZEZKSnV3NDVzQTJ5RTZh?=
 =?utf-8?B?USszRGpEazBUM3FjSm5PVXFIem9IMmVkSEkvK1RvSzVMVWg3THlVSHpzTUF5?=
 =?utf-8?B?UVRmMHUreC9wVi9jaDNuNEs3WjZYUEE3aVhyTjhuK2VMVjk3c1h2RC82dnI4?=
 =?utf-8?B?Nkx6WnJqTEUxRFNtN09MM20rdmNHbExFRDJLUHNiY2EwbTdkZEJaWEx4VFha?=
 =?utf-8?B?UFlBUXUxNlZBUzVHcVNBWjJoMkxraUVWRk83OEhMU2tzUzZlV3dmMSswWDhF?=
 =?utf-8?B?OUxNK2dZbEN3R1RXQnpDK21XZGR5a1lZRm9RU1R4TkJZSU5HU0tnbkY1MlJy?=
 =?utf-8?B?eW1tRnRFd2k1dkVaNElkb1E0cTdObWFaWk5nd05BVkxBQ3dkNUlSODJtNmZP?=
 =?utf-8?B?ME1vdWQ4Q0NFaUZZYlBqU0orOWU1NkUwUXNrRTJVbGZjbCtvNTFpQWFVT0FT?=
 =?utf-8?B?WDg3NUtmOTlwOC8rU3N5d0NPQ1lOeGZNWkMweSthdEJIb3E4YnJVSzBGTE0z?=
 =?utf-8?B?a1ZycEpobVU3ZWdBZ0ZsSDZFUjVMbXM2QkgraFF3TlBuK3ZSL3hxS2c4QWRt?=
 =?utf-8?B?R0EvZm1IUlBpSVM0bjM1V1pVTDRpWkZIVGNpNW1BaFUwM042WTlxL3BXeDlP?=
 =?utf-8?B?UkVPYXk5QUFYUzdrd2dhQkVyS1NNQVMvTFROMWV6dGlJVjR5ZzJ6Z2FUczFn?=
 =?utf-8?B?SFlLNS9UcmRZaVNyOCttTzhmZHQ4VWt0a0tUQzNqODNxTVFsOE9vZUphY3c3?=
 =?utf-8?B?bUtaWWM0OEtLckFqMzU4cW5BM2RCbW1kSExSS1dPNHJGY0paRWJsWDBXMnY3?=
 =?utf-8?B?VCtCcERTOEZpQ3JYRUwySlhYMGlYNmdxV1orUW4wUFJ3NzJVRU5HVmdzOG5V?=
 =?utf-8?B?QitzTUQrVGhhdVp1VmZQMGRHbnlPa2lxNlg0ejlKMmpweTBONFJnNEtoekJ1?=
 =?utf-8?B?N1FMVGpTeFdVSHE4MFhnc3E5S3JpWWp1b0NzZDBRUzVGeWp4TVJUMFBhTGkx?=
 =?utf-8?B?TythOW1lY09vT3UzNldGekRGUThqVzU4ZDRIdVoyVWpFei9ERzI5b05SV0Fl?=
 =?utf-8?B?L1UwZDgreTV6VFM4cTdpQ1dlWlJtT3VXa0FKamdwMjk0Rm01WTN6MmRCd3Ax?=
 =?utf-8?B?VTI0bjAwUHVzMDdMeTkxUHNxbmRCdFJJbGFXTFVkeGlRS3JZdERvWVVOTkN3?=
 =?utf-8?B?LzlrVThTcitsYUk4VUR0bFUvby9wM1RHb2w2TVNBMFRQSWEvM1IxTFZ3OEJD?=
 =?utf-8?B?ekcxKzlDSSs0TlZLSTZsZkE3Q3lYNnAyaC8wTWc3U0ROMSt5eHRkbVJVVTQ5?=
 =?utf-8?B?QndiSUQ1TDYrenhocDAyYlRtTllJbnpoMHRXdzNRbVJlNnltS0s4WVNxZ0Vj?=
 =?utf-8?B?Q2RpU2dVV00rNkNqUk9SQWhHQkt6L3ovQXBxbEF5djZmUnd2emo3bUtmamZq?=
 =?utf-8?B?OHEvbzliODltaDVUblNqTlk3Yno4dm45QWI3eGN4bzl5Ym96clhTd003Zm01?=
 =?utf-8?B?THFLRXNVTXZOTmZ1MWdIaFNNQ01TL3JoMndNRGpPbCtOQktYZWh6SnJzYWNK?=
 =?utf-8?B?ZW5ZTm40MjMvZDVVbnZzZVVIZTFRb042RTM1ME9JcWh3eTlqTmloRURkelVK?=
 =?utf-8?B?Z25ja1JPbXlMOTQ4SnVzQ1RhakliSzB4cWFBZWpCRHBmRFA2bVp3QjAwRVBR?=
 =?utf-8?B?L3YzMzh1WEFKVVRqSE9VN2szQlVrQUlCUkgyWXJ1cEtLMnk2SjFEMlM0aXhr?=
 =?utf-8?B?d1lGbXNXeVdENEo1NFJEdzk1SlB5aE5BSURnL08waXdRVkp4Q0prWjRPNitI?=
 =?utf-8?B?dCt4eXZoeUplditLYkZodkpUbFg1RHppOFRtNnFzOFZ0NHZvSVhoNkhRMWpI?=
 =?utf-8?B?N1dNRldqZGxpdFBMRGZDRHB1c3A4NnBWZG0yaTNXNGxrNlVCZS9oRWZycmU4?=
 =?utf-8?Q?XFlM9TCannn/2S2RwOOSejVa/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d7217f-5eab-4452-0fa4-08dd140e9147
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 02:51:35.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziOXzIa4a0ts+Xas/L1/1n0NosWldMYxdohHvEiwfE3TOMnVmz+FKD3tPKZWDM976WiPDP8GeFr/CY4+LtM/Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088



On 2024/10/23 10:02 AM, Kai-Heng Feng wrote:
> 
> 
> On 2024/10/7 11:03 AM, Kai-Heng Feng wrote:
>> Hi Rafael,
>>
>> On 2024/1/31 7:54 PM, Rafael J. Wysocki wrote:
>>> On Wed, Jan 31, 2024 at 9:30 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>>>
>>>> The HMAT messages printed at boot, beyond being noisy, can also print
>>>> details for nodes that are not yet enabled. The primary method to
>>>> consume HMAT details is via sysfs, and the sysfs interface gates what is
>>>> emitted by whether the node is online or not. Hide the messages by
>>>> default by moving them from "info" to "debug" log level.
>>>>
>>>> Otherwise, these prints are just a pretty-print way to dump the ACPI
>>>> HMAT table. It has always been the case that post-analysis was required
>>>> for these messages to map proximity-domains to Linux NUMA nodes, and as
>>>> Priya points out that analysis also needs to consider whether the
>>>> proximity domain is marked "enabled" in the SRAT.
>>>>
>>>> Reported-by: Priya Autee <priya.v.autee@intel.com>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> This patch doesn't seem to be included in the tree.
>>
>> Is it possible to pick this up in the your tree? Thanks!
> 
> A gentle ping...

Another gentle ping...

> 
>>
>> Kai-Heng
>>
>>>
>>>> ---
>>>>   drivers/acpi/numa/hmat.c |   24 ++++++++++++------------
>>>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>>>> index d6b85f0f6082..5331abc7c956 100644
>>>> --- a/drivers/acpi/numa/hmat.c
>>>> +++ b/drivers/acpi/numa/hmat.c
>>>> @@ -409,9 +409,9 @@ static __init int hmat_parse_locality(union 
>>>> acpi_subtable_headers *header,
>>>>                  return -EINVAL;
>>>>          }
>>>>
>>>> -       pr_info("Locality: Flags:%02x Type:%s Initiator Domains:%u Target 
>>>> Domains:%u Base:%lld\n",
>>>> -               hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>>>> -               hmat_loc->entry_base_unit);
>>>> +       pr_debug("Locality: Flags:%02x Type:%s Initiator Domains:%u Target 
>>>> Domains:%u Base:%lld\n",
>>>> +                hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>>>> +                hmat_loc->entry_base_unit);
>>>>
>>>>          inits = (u32 *)(hmat_loc + 1);
>>>>          targs = inits + ipds;
>>>> @@ -422,9 +422,9 @@ static __init int hmat_parse_locality(union 
>>>> acpi_subtable_headers *header,
>>>>                          value = hmat_normalize(entries[init * tpds + targ],
>>>>                                                 hmat_loc->entry_base_unit,
>>>>                                                 type);
>>>> -                       pr_info("  Initiator-Target[%u-%u]:%u%s\n",
>>>> -                               inits[init], targs[targ], value,
>>>> -                               hmat_data_type_suffix(type));
>>>> +                       pr_debug("  Initiator-Target[%u-%u]:%u%s\n",
>>>> +                                inits[init], targs[targ], value,
>>>> +                                hmat_data_type_suffix(type));
>>>>
>>>>                          hmat_update_target(targs[targ], inits[init],
>>>>                                             mem_hier, type, value);
>>>> @@ -452,9 +452,9 @@ static __init int hmat_parse_cache(union 
>>>> acpi_subtable_headers *header,
>>>>          }
>>>>
>>>>          attrs = cache->cache_attributes;
>>>> -       pr_info("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>>>> -               cache->memory_PD, cache->cache_size, attrs,
>>>> -               cache->number_of_SMBIOShandles);
>>>> +       pr_debug("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>>>> +                cache->memory_PD, cache->cache_size, attrs,
>>>> +                cache->number_of_SMBIOShandles);
>>>>
>>>>          target = find_mem_target(cache->memory_PD);
>>>>          if (!target)
>>>> @@ -513,9 +513,9 @@ static int __init hmat_parse_proximity_domain(union 
>>>> acpi_subtable_headers *heade
>>>>          }
>>>>
>>>>          if (hmat_revision == 1)
>>>> -               pr_info("Memory (%#llx length %#llx) Flags:%04x Processor 
>>>> Domain:%u Memory Domain:%u\n",
>>>> -                       p->reserved3, p->reserved4, p->flags, p->processor_PD,
>>>> -                       p->memory_PD);
>>>> +               pr_debug("Memory (%#llx length %#llx) Flags:%04x Processor 
>>>> Domain:%u Memory Domain:%u\n",
>>>> +                        p->reserved3, p->reserved4, p->flags, p->processor_PD,
>>>> +                        p->memory_PD);
>>>>          else
>>>>                  pr_info("Memory Flags:%04x Processor Domain:%u Memory 
>>>> Domain:%u\n",
>>>>                          p->flags, p->processor_PD, p->memory_PD);
>>>>
>>
> 


