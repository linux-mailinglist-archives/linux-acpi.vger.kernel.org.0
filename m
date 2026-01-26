Return-Path: <linux-acpi+bounces-20611-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOSgG3RId2ledwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20611-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 11:56:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F7B875DA
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8E0330120FB
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137A3330B39;
	Mon, 26 Jan 2026 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NTJVMMmC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NTJVMMmC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854C32BF44;
	Mon, 26 Jan 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424779; cv=fail; b=nKqoEmWi8daYm/9k8ZdrlKPt/lDCkt65ewtXnHcWdGrzxyKY53KbL2VClviz6i2XMp6lKWHjql8SRAQ0g0DSQ8GtsmZYcjbR9Y6cRoa/ocLedTcXJKSLZaA/FmznuXWtixo6XwjqahH7PpBp39FbmkPcqiIDw4f3UyW5/gh2ZLI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424779; c=relaxed/simple;
	bh=eC9pNWo65u0n0aZOl7BTqxu4BT75Ppp9WpnFI+C2yKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGuq7GzQxb58cVAFaQ5HB8wNly1Fl4EG93jkBVgL9ccUfgpvGupsywPZUzvGEt3RkTf9a3Dkuni7xJVL/MJ1yzRjATiCeY0hqLkwvNNRGeE7+qA9VgJDfQVpe6jL4R3e7s4/Hj+hF1kE8CaGeZJMvhsR+OXSorULrBlv+VAobqQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NTJVMMmC; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NTJVMMmC; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O6JoXbGS7TMnzhh5pk4s6IqVXkqXxiRC1HEfviWVupNgYg3sPADMRIsZgGvCVUEoBhDiNynHi+TRj7AOfkSHMayVwBx2C720umoXH978MPItXu3n8S8d3szZtvSgTM3GfAai5BfQrZwfijhaBSm/ax2qsXrJogeBK/Laej1tN0ykFD40Wcr755y6s0z6stsLNikjHUxt8eaYkphPyK2ep1Ffu5Mf4+/PlrxVBbzawF5eawXi4QmcGgj26OzFj0bxBcTmg5Tqvq31xJzDpFXrjLyCeA1462azUw9D0qflPfIN0Hn6GAsxlipA/TMbq+iF4bVLZ1XYDZMDWNQa8KN7wQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhv7+GCZpKB2ofKCLrYjqhfS1PRYobUdaKBegT74WmQ=;
 b=MYvZP48kuhv7REhCN11ZAPuLVtZLifg5bbnR+K1Ko3lbACTZV4YMTk/CzLn7Q26hnzimoj/Tv+JWcMvMGL7XFJIKv8GNFwx6Z0cwplwYNqNXcO4aV9/GhIInbKOvwYJ191C49JQQi/iWrQJyuZ+Mfr+l4d4Pw7xyLyeza7zHAOqLalVgIvHJFDFHbIgTwVVlpqaPzo9zhpxk2pfbLiOEIVX3HzO5NEjFl2+RfWNrXgzBiq6q7jfhfjrsXwe92gL1Wd3bm7XKbDwZ3rEgEp5QJB5Y8qKB3IrPHV64Fr9+HpHKGtJ1iRudU3rKsh/0NNo6dobdWlGGpmWejBzc/lHOMA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhv7+GCZpKB2ofKCLrYjqhfS1PRYobUdaKBegT74WmQ=;
 b=NTJVMMmCVcDk+Fq67Fl2QLvQQ2Z4nX1fkfoEMuJAKdRQ/UAxj9ogllE1eXrlHLGji4ItXZFIx24dA1qzAaRrAiuPF+UsIlHg9yBR5UUgKKvrtCoenHpKPDolH1dlNFSfhBB8tl0Bu8TDaWrf+Gro/W4oHSzfeKravJI5cLEFazw=
Received: from DU6P191CA0044.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::24)
 by AS8PR08MB8945.eurprd08.prod.outlook.com (2603:10a6:20b:5b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 10:52:47 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::cd) by DU6P191CA0044.outlook.office365.com
 (2603:10a6:10:53f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Mon,
 26 Jan 2026 10:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Mon, 26 Jan 2026 10:52:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wejMayfbL+ap40soGq2bJYhX6lssLIeXCcE2oeO4LZK6QO0bmvFtAfH2gyAuPeZvuLot8CzdBzJT+KYmy3W2iTWyTliaRkNwoL2SAwKoRM0+tBnNoTJ4lrBhnqD+rAZIacQwZARRgEcGf5cLfY8EyHJcm90s56+hUavJidjdK7gGDe7w/a1EJOZgTzaY/JfCUGR8uQ/FVbvZqwCanyzSEZNV21ic9gJqT2ueFPWl2+0TwStuBYSZXLuWeguutqrhAnai7jJqNYso2oDMEARTc9DCzmlyzixmd1R2RTr9VzFaWvZHI0dh+ie3eJHzAoCzrQUpgE8vkMY3mhRJEfoW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhv7+GCZpKB2ofKCLrYjqhfS1PRYobUdaKBegT74WmQ=;
 b=IhyhSZRgYR/4llgdf71rNm9gii5GlZq+AywML6EBVcVIUebZj2Is5/rUZV6bYuC0nMdwXjl4RdLU47cjAXnMdyujZchvIlQ9FnKlZ2crRpZqP5yFu8vAimWF3+sgXKLd8WdAnYxK/LviVFwBRFa/TsigWsVkMZn54LOrEZ+gawTg/48rytEcw0P99vmkT1GiZKTY0tp4MhN2MnDlOEfazp4MRqaAcumfcb9wbGLaY4xHW595BJc/V06PanfHHYiahFFVAZTMO6RNV7xMWuJW0yinJ4Hh/n+bKKLcF71RRpm1X4JCdePCypoSMD+fwn4xyXixemfptAtZH0xqHeCGng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhv7+GCZpKB2ofKCLrYjqhfS1PRYobUdaKBegT74WmQ=;
 b=NTJVMMmCVcDk+Fq67Fl2QLvQQ2Z4nX1fkfoEMuJAKdRQ/UAxj9ogllE1eXrlHLGji4ItXZFIx24dA1qzAaRrAiuPF+UsIlHg9yBR5UUgKKvrtCoenHpKPDolH1dlNFSfhBB8tl0Bu8TDaWrf+Gro/W4oHSzfeKravJI5cLEFazw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB9PR08MB9802.eurprd08.prod.outlook.com (2603:10a6:10:45d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 26 Jan
 2026 10:51:42 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:51:39 +0000
Message-ID: <1d75dd4f-0eaa-447f-99b1-4c6c9d39a87d@arm.com>
Date: Mon, 26 Jan 2026 11:51:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-7-sumitg@nvidia.com>
 <b68a4273-ad39-4d3e-a556-1b409b50944d@arm.com>
 <2ce31807-bf89-4c79-82d0-31a5cda2a6a5@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <2ce31807-bf89-4c79-82d0-31a5cda2a6a5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB9PR08MB9802:EE_|DB1PEPF000509F9:EE_|AS8PR08MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 878641b9-17cf-4940-64b0-08de5cc90abe
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?OVhPOW12bXhhNTFKTEJ1M2YvWk1TMElKTlhDaThxeHRHZHlhY1dFcVZrb2xr?=
 =?utf-8?B?cjBuNVkwb1A5bE1YbEVkZUttdHRRN0NRV0NmOEFxQ2RObGJVbHA2bytuczFt?=
 =?utf-8?B?dlV2QjY1elVkaFdwdU9RYnN1a3czNGwvRHVPRnB5eVdOd3UxNlI5Z0xCaWl5?=
 =?utf-8?B?a0FidFlMWjF1d1EwNG0xNXJJeTR0OUU4M3NkUTBEcGdOSS85OTc0QTlNQWZu?=
 =?utf-8?B?ZlNzbkdhN2ZrK3NJYTBYVEY4eEhseUI1NXdqbDZxajU2TzJrSnlCWU5valRz?=
 =?utf-8?B?ekkxT0M4ajVwRzMzSGJYaTk4QkIxRTU4Q1dhQTRiY1VRZllMWmxHNXpDS01h?=
 =?utf-8?B?bUxtOHZ2UjJkT0g5dXFFSEFiLzJod0pjNFdMWVF0ZE1zREtLdE1ZOXgyQ083?=
 =?utf-8?B?andRdUhCR2RVWVZuVXptb3RjZnV4aG1jSlY2bE05dy9YaDhUaHJQelR6MmN1?=
 =?utf-8?B?Z3BUay95MzAxSERGNUQyblV0bU9KZU5HVVh2UFdHSytVSWxiODh6RW51Nmkx?=
 =?utf-8?B?a0hwNnZPcFMzblJneUtMUk5JOG90ZlRMZERRUWFZQ21lS2dCZjloOHFHTStn?=
 =?utf-8?B?OE5HY0NhWnZ5N1UxcHJhYy9tZk9BV3JHMkY0Njh4RGtwQnp3YzlkSnhrcTcv?=
 =?utf-8?B?TDJQTUR5SU1XZm5Yamh2WFVacWhLRkZaQW96cWZtSGllTVN3TGkwbFcxS3F6?=
 =?utf-8?B?RWlTZHhiZjQvaG43R0JHRk5Qck1ZMmV4ZGVWU3c2NEZ1QkJKMXNGZFFTNGVH?=
 =?utf-8?B?YWFCczZRQnJqbWRFbXNjbXRUdVZNMFhVUFFCdFNKRndkcERYa2RHNFJ4cG5H?=
 =?utf-8?B?R1MwcEJjUnd5S2FDcHp3YThQMnhRZFMzZytBZVVlS29HRWFub2dGSytCSnh0?=
 =?utf-8?B?TENCblJqZ3lmYzFxTXpJSkx1Y1dqdFBjUEh5UlkxM3dwam5RN3VKZ0FSZk1l?=
 =?utf-8?B?Nm02dEttV0l0d0NrNmEwM2luRFBPQzBwMzhKTThzaUFrdHNvMFNJQUVlOHAz?=
 =?utf-8?B?eEhFTnc3Y3YvZkw0TzlVejV5Y0NHcC8xZFlpYTZsdHVFaTY2WFFhVVFaQ2FY?=
 =?utf-8?B?NWZkVHkwSFlJRHNkNTZPWTdremlZakNFSURmYWYrclEvSy9WTTk3eXVRYjhW?=
 =?utf-8?B?NVNjeFJWZHljSTlRVTBoelU0Zll6dHY0NHFVcVVZVStUWEVyVThBQTQrbGth?=
 =?utf-8?B?b0YxWTY4YWQ3WlZ3RnF2SVhyWHUzYjVIT3JNbnU3RVhNNzgxVjJEVS9KRzRs?=
 =?utf-8?B?ZzNKS2l3cTFtT0QwSHA5TWhab1hpQ2NydFdCN1FEOVVjQTdMUHNxdCtiVTFq?=
 =?utf-8?B?a2wvZXB4dEhjamU1aVQyeCtIUUtjM245REVMKys2N3ZmeVhtM3krZmtjWVJG?=
 =?utf-8?B?VCtzL0JCOGVvbFZseWN6cjRxeUtXdThaZ01kSVEza2VMNVN5TTNNVzRDRW5W?=
 =?utf-8?B?Qk5TZUNSdENLRVdWOHhEbHlhZjRYaVBJN0hpdmlyY3hLb1hKNFBlNmlVZU80?=
 =?utf-8?B?SHQwNVNPVWduTzE5SytJNk50NE5PN1c0cXNQZWxNa3FSd0JsenFWZFFIMkpk?=
 =?utf-8?B?ZlJpdTdOcHhkd2FURnFybXJzUnZBdlZPaEgvZ0o3c3JDUEdIRzdpbVZ4aVJE?=
 =?utf-8?B?MkRBUytiUDZzTEE1OWl3Rmh0eEhydmJVRnZjcUVES3QxVWVObzhIeHVIbjBz?=
 =?utf-8?B?anNDY2c3YjFGVkVNM0dQeDZLMGxtL2h3cFZFKzd6RUxsTEpOMDdjeWRXRERr?=
 =?utf-8?B?RnZGZzc4Z29FSS9rVHh6UG43RXNKTFB6TWRhTmpsSFhNU05Lc2tUQjRPR3NK?=
 =?utf-8?B?KzlWQXc5K3ExL2xNVU1wVERkZ1l6VnhwOXllcytmcXVUMlB3blhVOEZwQWdv?=
 =?utf-8?B?WERvMDU3eENMSHpUNGNlRHd3cVhjOE1jV3FYeDVpSHV1d0JxbEE0VW5ZOFNw?=
 =?utf-8?B?RFJjUVY5NllCUVo4V3o2bFNRWDNtVGJXZEVzQ2Q5QWZWWEFlUVRmVEJWN2RL?=
 =?utf-8?B?TkhOdFFMMkFQRktQR0NWRmJnT1dEbDRZS1NZMUd1MTN4MXFkeHlWVnlEUnRx?=
 =?utf-8?B?VFdvZ0hqZ0tDdGtqVzBiMjhKNE9aZlBZVjQya1ZpVERnUnRsT09VSnJXeGtJ?=
 =?utf-8?B?S1U5blF1YjQwS2hxWHkzNUNVSGcrUHk5amxweFZ1VElWTzNic0xaQzVUMldL?=
 =?utf-8?B?U1E9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9802
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	88953c63-de5d-4e24-ce66-08de5cc8e224
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|82310400026|376014|7416014|1800799024|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnA0aUJZQzlHT0tMWFpuNVNtaGlKdzZERThNUWlhbVFTdWtlVTZNbzdERmJn?=
 =?utf-8?B?UHlRWm1lZlMrVkZjUVBNaGU0a0tqTVVkVWl2N21jdkFCU2w2M2kxdDRreG5H?=
 =?utf-8?B?UlNKM2wxU3E2SlBabGxQOGQ4UlpiYm9jZ28vYXozZXFFQjhKbzJrNUZEZ2Iw?=
 =?utf-8?B?UFR3UGpucG0veE5DUDNnOGVPSkpVSitWQ2kwTEJ4OTVDRUVYNU5TNkNVbG1r?=
 =?utf-8?B?WWl2cllEaWw3SE1vL0RYbm1PcC9TNkhUU1hvSTNOZkxzZjArbjBtcUtXUGV6?=
 =?utf-8?B?UUw2Z3hNUW5OdDVCbVp3TVFMYWd4aHdKbmhZV0ZPT05UV05qL05SQ05WaFVj?=
 =?utf-8?B?OFF2emIyVE0rbXB4ZFQ2VkZuVm11SFQwTTN3SGl4OTdvZE9zKzhFK3pTSlYz?=
 =?utf-8?B?b1czNy9YOC9EdCsyZGJXRTlJOWtUeWNZUXNpWVR6ckxSa0pnVDRVR2h5UjRp?=
 =?utf-8?B?ZC95ekNQcGRyeTJxMjEveTB0VldKM1I4bmhqUnFWYzRuN0REVDJGdG5vYU5U?=
 =?utf-8?B?TnZ2RkdpVWRSMW5iZ3grRUxmaHNjbldGRXExMDloZ1IveEFvVVM0cTRrOUZL?=
 =?utf-8?B?cjdienhvR1d1MzBkTzZYK3EraWNRYUx3QWtzaHJzbnNGajNmcEdURTZCdm8z?=
 =?utf-8?B?NStiS1d6M2R0WlJjNW85QkRTRmpGdktKdGRtWmR2S1FWNldxTGVpbW1BdzU4?=
 =?utf-8?B?OHMvNTU2ODBVcUZxb2ZlNFhQeXBWWDZWMmVoOW9LODU4Z1AwU2RXUTZUdytU?=
 =?utf-8?B?Y3UvdVZ5R25LbGpIUHFoenAxRVVkbEk0WW1xUHRPLy9lbzV5dXJ6cmpURHQ4?=
 =?utf-8?B?eGJVUUpqc2pMQnFWbzJ4S0g4R0VhVHV1ck9uUHhJSGtla0VyUGUxR1hNeE8y?=
 =?utf-8?B?bjBaUUcvTE16RDdCWFE5Mk9NYnJIejlwdG90REVTYjAxaWUwQ1RXTHlqczhi?=
 =?utf-8?B?WlNuN0tqZThVbnk1OTNxdGYyVUp4bTlXZTBDTVMyM05ZbjhEakpmKzY1SzN1?=
 =?utf-8?B?NjRxNnpoU0ZydzdWNkRYOENiUjZvZGJOTU9jSHhwY1dIN0hic2lLRllBMnZH?=
 =?utf-8?B?eUJPNWhRZE5jR0pNbUR1SmZCRU0rRnBxZnpKVDZsN1hLaTFPYXdXK3NuWi9N?=
 =?utf-8?B?aTNpekd2bndmNjdkY0VhQlp6a0xmS09CelUyNDRBUEFKbnBLU0JZc2x5b2tt?=
 =?utf-8?B?QzVtK3lhODRnNzZ5dTlLbXdYUlZNQlI3c2FaZFJTbTR4ZW9Ia3JiQUZhVGda?=
 =?utf-8?B?ZWpYSTg3eG9SQzRzYmplcmorQU56SnFBOFdEZUozaUhuYjVFVm1aWG44UGxy?=
 =?utf-8?B?ODJ1cFNTQm96RHZ1OGh4SW9ibDhNRlRXZWtnMnJpOXdiSkNtT0g5enhUUGt4?=
 =?utf-8?B?Q3ZrTVJ2bWp2SDZpeFo4U2JUTnJFbm9mTVFaU0RuNG93M0VLUkFSYXloU293?=
 =?utf-8?B?ekpoY1FLUWtJTlRNYitCK0JWUkhVWnFCZjlIL1JXZXBJTmNDU0YyY3B6cXQ1?=
 =?utf-8?B?TG50QXlKUkZkRkxCWXVjUm0vMHhpZ3poMTdmcU8xbTl6ZnpPdFZCME4ycDlx?=
 =?utf-8?B?SFVHUGlxN09MaGJMN1BsQ3RVeXpDWVREYno3NjZEaDlWQ2xJVmJWWGhua3RB?=
 =?utf-8?B?dC9nMkVxZ1VxcXl5eFJydE94blNXTjZmdW1FR3pXZzF2U3UvMHBzZXNoUzUr?=
 =?utf-8?B?aGJJcnlqNTlEb1VKaVFZTHgyOUpaTFp6TGpzeHRLZEdqenlkRHVmSDRHaDJu?=
 =?utf-8?B?MWhkRDd6Z3dRbkJibjhFTWxvdnFNNkd6MDlnZFBEK2VlWDdoZGV6SnlidkhC?=
 =?utf-8?B?QUtXVFNyZElQeThIOHpBR3ZOWGFqNHpqV0pHZ1daNU1wT0F5TVdxS0JzTGNv?=
 =?utf-8?B?VmxXOW14aUVjVElzTzU1OXRKS2hBOXdpS1AvVVgyNmNFSmFNRjZYMERGMlB5?=
 =?utf-8?B?WFo0aDVubnRwd3pyUWZWNmJraFViVmZuQm5vMWF3VkZJTW1Mb09uY1lRM1Fi?=
 =?utf-8?B?OVYyaHhuMmxMK2VveWZEMXRRaHQ3VVBOMjhnRG42aWlNRFFodURVektxb2oz?=
 =?utf-8?B?K091SHJLeEZtbUVsOEFrWEc2ZkpIa3ZBSHM0WXQ1bXR4dmRWamIxb3hNYVBN?=
 =?utf-8?B?Q1drU2Z4VjRqS3pKZ3Zpb1l2Znp4QlpoZWdmSFluWDNXR0NtaTVSdk9odzFU?=
 =?utf-8?B?WlE4NmpwQU1DZWNVUlBZUWljUlYvSUZKVldDVklBY3RzSWt4bjFuaG90SlpG?=
 =?utf-8?Q?KJSoLXq7ocNY17pv9Bdzarui6FAsgzqbu08AXp+Oj0=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:52:47.0480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878641b9-17cf-4940-64b0-08de5cc90abe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8945
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20611-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,arm.com:mid,arm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 22F7B875DA
X-Rspamd-Action: no action


On 1/24/26 21:32, Sumit Gupta wrote:
>
> On 22/01/26 17:06, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 1/20/26 15:56, Sumit Gupta wrote:
>>> Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read 
>>> and
>>> write the MIN_PERF and MAX_PERF registers.
>>>
>>> Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
>>> to expose these controls to userspace. The sysfs values are in 
>>> frequency
>>> (kHz) for consistency with other cpufreq sysfs files.
>>>
>>> A mutex is used to serialize sysfs store operations to ensure hardware
>>> register writes and perf_ctrls updates are atomic.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c       |  44 +++++++++
>>>   drivers/cpufreq/cppc_cpufreq.c | 157 
>>> +++++++++++++++++++++++++++++++++
>>>   include/acpi/cppc_acpi.h       |  20 +++++
>>>   3 files changed, 221 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 45c6bd6ec24b..46bf45f8b0f3 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1743,6 +1743,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>>>   }
>>>   EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>>>
>>> +/**
>>> + * cppc_get_min_perf - Read minimum performance register.
>>> + * @cpu: CPU from which to read register.
>>> + * @min_perf: Return address.
>>> + */
>>> +int cppc_get_min_perf(int cpu, u64 *min_perf)
>>> +{
>>> +     return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
>>> +
>>> +/**
>>> + * cppc_set_min_perf - Write minimum performance register.
>>> + * @cpu: CPU to which to write register.
>>> + * @min_perf: the desired minimum performance value to be updated.
>>> + */
>>> +int cppc_set_min_perf(int cpu, u32 min_perf)
>>> +{
>>> +     return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
>>> +
>>> +/**
>>> + * cppc_get_max_perf - Read maximum performance register.
>>> + * @cpu: CPU from which to read register.
>>> + * @max_perf: Return address.
>>> + */
>>> +int cppc_get_max_perf(int cpu, u64 *max_perf)
>>> +{
>>> +     return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
>>> +
>>> +/**
>>> + * cppc_set_max_perf - Write maximum performance register.
>>> + * @cpu: CPU to which to write register.
>>> + * @max_perf: the desired maximum performance value to be updated.
>>> + */
>>> +int cppc_set_max_perf(int cpu, u32 max_perf)
>>> +{
>>> +     return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>>> +
>>>   /**
>>>    * cppc_set_enable - Set to enable CPPC on the processor by 
>>> writing the
>>>    * Continuous Performance Control package EnableRegister field.
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 229880c4eedb..66e183b45fb0 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -28,6 +28,8 @@
>>>
>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>
>>> +static DEFINE_MUTEX(cppc_cpufreq_autonomous_lock);
>>> +
>>
>> Shouldn't concurrent access be handled by the policy->rwsem ?
>>
>> I think this can be checked using either:
>> - lockdep_assert_held_write(&policy->rwsem)
>> - lockdep_assert_held_read(&policy->rwsem)
>>
>> in store/show_max_perf() for instance.
>>
>
> You're right. The cpufreq sysfs already holds policy->rwsem for
> show/store callbacks. I'll remove the mutex and add lockdep
> assertions for the expected locking.

I think it's ok not to have lockde assertions.

It seems that it is a common assumption sysfs files cannot be modified

concurrently. None of the cpufreq driver seems to use lockdep assertion.


> --------
> File: drivers/cpufreq/cpufreq.c
>   static ssize_t store(struct kobject *kobj, struct attribute *attr,
>                      const char *buf, size_t count)
>   {
>       struct cpufreq_policy *policy = to_policy(kobj);
>       ....
>       guard(cpufreq_policy_write)(policy);
> --------
>
> Thank you,
> Sumit Gupta
>

