Return-Path: <linux-acpi+bounces-21142-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP61JKQwnmk/UAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21142-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 00:13:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52A18E1BF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 00:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 771D13035BD1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 23:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66934DB60;
	Tue, 24 Feb 2026 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Qdma0wyH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021102.outbound.protection.outlook.com [40.93.194.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D234D382;
	Tue, 24 Feb 2026 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974816; cv=fail; b=RtwI3LApka5sUYwG+/Bb69YoJqyuA+8YGJpcFpEJO7K07huXSusxbsRsdsTQIb4EX2XGcJvl2OX3jGx0Zj+/fAef1t6jFfTnL1FESANh3zWm3dCvf04Qv65TN5mluckmr0I/2qAJfRRgN2CS/2whi9wUAhzCrXDUtZtSWp5yTZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974816; c=relaxed/simple;
	bh=dFdMC1AOsnRUtSnHh8WQbbKUVKC26bzZP3x7c2QxyKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3B1TBkA0f78/8Bj1eyGdnr7HaVc6HcqO1q9clj5FSIUywwaH2H/jKecq588so+/rvm/D6g8AM0iXntcRL224wb93XYfz2zwbUG5o4D6gE45aA11ewk1kaWYEl/JIML+GnmGZhIG2pC+ts00D1GJg4+7CzSJiSoBDXV25KDVowk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Qdma0wyH reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.194.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCGJBibv0HRUKQ7iuA5TktpCRnqs1XPuph+3/0V6AIpACKK6T8JdrRThSiphKPWDVsczTIz0wN3ghdCHfWLfACVjBzUyP2fPL88CqTA8fHM1CLxSL5qkT1tvfXxlxFY7M7hCnZjX+CuN9vHkYELJdAgq2OnG6IxUE2/Ity1M+Nd5hShvpo90jPfAEZBEGTX1FlnHp0JwWVxRiQ/7tj7RCk5XlweyNQix6qN2+ipn1snqaBBwcx45NCUqIcedS4YqhtxzRXfszuij3CrwQNie/aVRxMwEb5iZG/XbK6j1BUenR322ZiTv3TGUiwU2FtmQ/1kmOSsh1z4BG4giUhiuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPCAJ8iqDNjUUrZYetNlrXxUUG27grGIYUzos0mD9c8=;
 b=p3ldkJ0bDhD7m5f2NRdxYI6ba9MFE2tdOdrW/zNrUdHivuwVN0PEiiO1ZtRBe8/HwayPQwE1MbsNrzlhuDa8/z5U210Lhi6CKfSej/fNdo6z61/EhXVzbhGkQQqAg7qr4PYC7qphu+63VuttCbwJT/0AkXqEYALKMS05exk7SYUCjxYDWz+7+WjtVnYPxC1pEIFJoAOJ0g7Po6LCfVmf69Aum8XBBUXXHVFqBHr5TTon3wzFpsmbhFLYxB87Ps5VMUZPaCauyuDQxCAVfQT1B1Oe5Gtn1gSsQiJitkmRb3Jg7VwBE4fCYt5CDmMsY33oxZQl7dlq1UEsMlIGGPEWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPCAJ8iqDNjUUrZYetNlrXxUUG27grGIYUzos0mD9c8=;
 b=Qdma0wyH/1hgp/cq6QFpNG2y0Xjh0fHym8ibTZ4gYb9pGKfVXuKHHK4tZ7nu/SncmKu5e5153Tb+HJB9TyeT+pRE6A2f/MkR+tZKuzc3DJ9nUmdqOu2v9VeKeA99mlVIDcuFg+DcQtyATxpS49O1hyzEsi0FtnxvsJ5w/oPLEwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8567.prod.exchangelabs.com (2603:10b6:930:c2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 23:13:31 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 23:13:31 +0000
Message-ID: <13256ebc-f1e8-4a85-82c4-b7dbd08eb41c@amperemail.onmicrosoft.com>
Date: Tue, 24 Feb 2026 18:13:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation and
 interrupt handling
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>
 <aWUnZJ83_AKQDagu@bogus>
 <f30ff47e-2bcf-4239-9f56-c624f4978307@amperemail.onmicrosoft.com>
 <aXiFlkKAuV8QSgcM@bogus>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <aXiFlkKAuV8QSgcM@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:930:cd::10) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: fb11edc1-878d-41c9-5bde-08de73fa5333
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkZHVFpYSDhYYTBIRmFJbEdkRU00MndHNTdmL05zU0FHcHF1RysvZzIyVjRM?=
 =?utf-8?B?NFFrWUpkNUxOTXhzNGcwQmRlanhVc21Nb1dLRFVyaUNDUHFPMzh2dVYyNFJr?=
 =?utf-8?B?ZGx1RmVmK1JyQmlXWEpDTUtnOVVCMUZpWGhWcll6NnhScEoxa1RmdURrU250?=
 =?utf-8?B?UitqR0RHcXdXM21zbzVrVmdxK0NBRVVpRDBGK3o0dDF3c2dqY0VITjN2d2lM?=
 =?utf-8?B?UTBDQVBKbHZ6b0dCSkNJV01heityVVliblZGUklSUjJGMHU1QW5ET3ptUExD?=
 =?utf-8?B?Z09hcW1xenZCcnJkZkVzYW9qdXlkanR4Ly9LZytpOHJLTmZkZnh2Nm90R0xK?=
 =?utf-8?B?VUFDM25mQWcyN1l1NTFGQmxTQ1djYjlUdFhvdjZHVkVYelBFTjhXSSthVjZV?=
 =?utf-8?B?RTRWRHVXZFRwTmlDbjFQeWJXZ1A1OWxpeTRST0x6clVSVVhWSGZwd2VONEV2?=
 =?utf-8?B?aUNZaU1MREhnWFpYYVFwUmpISDFFRGhVbVpBUEZBUFNyajlDbUJUNmF1c1ps?=
 =?utf-8?B?ZVZjTVJRSmV1VURwd0ZsWjF3ZSs2MzE1eHVITHNuWmdkdUovVkJ4Y2dMOHB1?=
 =?utf-8?B?dWtvYzFOaXNhZk9zcmhSRzhEcmIwc0VrQmMvWFpmeWI0STJXak1WaHlMZ2lj?=
 =?utf-8?B?VFA3a28rcjg0aDlMQUlUcDBDeUhuaTlQZjBseVFiR0ZQTEZKemY3M0k3cmpu?=
 =?utf-8?B?cytWMWUyYnhFUGpxMjArb05jMitsMnFUc0VlNFZZUUFhQkk3aHQvS2xVSGIw?=
 =?utf-8?B?ck5teGlXNDY1UDNNQ1JOS2FKTGJBa0l3N016M1JPNTRzZFBoVkN3KzJnYUlt?=
 =?utf-8?B?VmE2NjNlL2liaEV3d1Ewa1RYOVQwZE5UTnhIMlQxbURoZURCaGQ1S01Gdk9w?=
 =?utf-8?B?NVo3eVgwaWJVR0RtbUNISG9EbWRLWmtjZ3loSER2eFZDcnZvMFJ3SkhYaWkw?=
 =?utf-8?B?akJDRWFWY2VSRXYvRXA5NHZOVmt1Q0dwYVFuWGt1TEQrQlZkNWYxTWhlMkxF?=
 =?utf-8?B?eTVhOEZvbFdENlZtekVpbGNOK2RwRWFoNnZVTEVKZFhDZVhKem9oSyttbTkx?=
 =?utf-8?B?UXJkQnV6QnpTSEYvaVJFYWVMcnVEZGlnNURHQzZtc1JETHNRQVdRMDVCbjBG?=
 =?utf-8?B?Q2tDYWZSK2UwMjBkR016YllWcE1NVnJuQUV5U0srSEIyd1BmYlJOMm1uUjF6?=
 =?utf-8?B?eDBFTlNmdHNLaGF5Vm1sSEp1eXRlMU9tZ2pCbEVEeHRkWG5DdGFnMVlMNGJ5?=
 =?utf-8?B?ZFBxMlRqaXhUbVhvOWVlZ0RKQjZ3eXhQdk9rL3VZTWowd1NNSDJkVkpzOTdB?=
 =?utf-8?B?RTRkOXhJdVNpU2JDSFJCZGs2ZUNmUXFLWUIzdG5uUFhFS0FvVzNIR0Q2blVr?=
 =?utf-8?B?YjRyM0JwN3dIeVh4dTZ5ZEtoV2RDV09pbnhSK3h3U3A5VXZ5RDBrRkExSC9I?=
 =?utf-8?B?WCtHS2xNUFZSWDJsUWJNRzN6TWUxTFBJWTY3WW1xZi8wMEVjUU9vUHdtTVdQ?=
 =?utf-8?B?cEFOVFJMQmpzMmN0T3NzNzd5U2FuUFRWV0dKOHVQYWt0YnhHaUszck5oRFpU?=
 =?utf-8?B?VW1RNmxSU2lWdlhKS0tmcDFzdjFIWUE5amRvWHdtRVlKa3dFVTFuV2VabUtl?=
 =?utf-8?B?N3JKanBHT3RxakFDcktwU0dHOGF2OEEyaEJOUkVKT1l0ZlFEakY1eERHSlU0?=
 =?utf-8?B?RWJvR3FEMmkxZGJuU1BPMDl3d3NVbVRFaXBFL3dIRmxPSnQyNTlPT25jamFQ?=
 =?utf-8?B?cm5PRmFBbXZPQkJrYkc1cVVNWnpQaE1ETmQvQkt5bG9Db2Y0cDZacHU2UGw0?=
 =?utf-8?B?amlVa1lKSFpMaVpuQ3o3bXl0QlJ5N3RvWnNhN21GWUgwcnhDQmhReU13UWxx?=
 =?utf-8?B?SW1jYlFOVUUvUldjL240QVlQbVA2NFBkbUlPYmFsZjBhQ3hxY2VnN3ZJWlJE?=
 =?utf-8?B?QlMxWC9MS0dUYWJ0ekhnY2tpcWd2SzRibWU0ejFEaTl5Tk5GTmFaaHpLeXU5?=
 =?utf-8?B?bU9pbElrMllFaUJ5QU1uUUZZb0dqN2w0bTFZYnMrcVdUL3JhRnlqUkdVZEtS?=
 =?utf-8?B?dnMzalBkaE9GcDRMOUhTejBKblJYZTBScVo4TFBmckd3dmJ3MUlPcjFmdkkw?=
 =?utf-8?Q?n+yo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmUrMGllNGRaQWxHdFN6RHlOQXU0dWJyZWhnSGszbmRVcDJQNnVBTldIRHJ3?=
 =?utf-8?B?VndCclZrSXhGVFByZEw0TlFKa25VVjE0T3hoWWNTaVlaeG1qZy8zS1dPbkZW?=
 =?utf-8?B?Z3QxaVh6OXAxd1dieGQ2cWYzTUpMcDlpdnQ1ZlRoeGdDU05FSnFvVkt3TXVo?=
 =?utf-8?B?cmNPMXhnM3FUelZHSURFY1EvNXJJK2RGSUpKOERXbFpLZ2kwbklENGpZeXR4?=
 =?utf-8?B?VldTQm9TV0pYa05DYUtxZVRjOGlUNzZ0eXdINTNwVzRhNmdwRmRXMVZkQk12?=
 =?utf-8?B?R3RpSGpobll0UERsblhXeUhSaE9QYzlZNTYzU1F2NnErQlp3czUyMGlOaFFa?=
 =?utf-8?B?MFQyYkpHT3RJL3lQNUp1MFZFNkViNFI4OVYzOFFjWms2MWUrL2JjcVhmUUhh?=
 =?utf-8?B?WFk3OW1zZUdPSElKSnNGdXFnWEU5VFFOTE9iSVNGQlJDTWJMUCtJbFkyMGt5?=
 =?utf-8?B?R0l4azZLTFdnbHVOOWZwL3NzU2YyMXhHTyt6K1JLY0w5d1EwVzdtTTJiTlRZ?=
 =?utf-8?B?Z2NRSDhhSXhtelNwditwS3VMN1JVdHZQUXBxamhnZExscnFxakNpWW1ndElv?=
 =?utf-8?B?cDluZVFJS1NOUnRmK0o2d2J0amdUOE1FemtqSXRFOUJUZUUyNTVmWEJVR3l2?=
 =?utf-8?B?czRsZXM0byt2bG5teU15ZlhkbUh2b1hvVDhiVm05cmhXUE1vNVQvUnkra3dG?=
 =?utf-8?B?R212UkN5UHNXTitvb0ExWWNYaEE0a29wZ3pEKzZUaXdweDI2TWtUTW5aN05t?=
 =?utf-8?B?ZDBvS2NCR3V1d0V6SS81eTZmbUJSRjdvNE82UENjejdVQ2JaN1RtS3QxNTkv?=
 =?utf-8?B?WHA3ekNDYm1adFlCYm8vbU1YVHBacFZGazZ3VXovVlZRWFIyb1FoZTZUUHBu?=
 =?utf-8?B?NFBkUjBJQmZ5SmxqSzZNZWVxM242c09wUWZJRjZNZkFlUWtsN0hEcVg2Qklw?=
 =?utf-8?B?SzdkYkkwYUJLVEN4aEVlNVlOa2NxMzdZNmZJQlgxaURHdGhvQ3B1K3psaVRr?=
 =?utf-8?B?SGNFNkptRnNQSlFNTm5CcG5rbERRS1VyUGJVT2pHdVVDUGFlY2FnaUx3dFZp?=
 =?utf-8?B?dHVMemJwd2dMc2hTUktyYlhTTXhaVmE1R09zY2c1cmF4cWlpMSt0QWNMYnJ0?=
 =?utf-8?B?bmxJZXpGbW5zTXpIbmVqWk55V21wbDhUK20yMFg5NEU3UjBYMjZHZmZHZjI0?=
 =?utf-8?B?dnVkUm9XU2JNaWp3eXZzc0RNK2R0WjZ6YzVuY0pOUzRVMHdaZWMyejVhR1Vu?=
 =?utf-8?B?OWtyUFA4WGtKanQvSVdRc1hielpsbmJOZlNMNFpIUUtCbHVkdnh0YjNKbE5C?=
 =?utf-8?B?cWR0QjJ1bmVRdkV4eTZRNElJZjhBdkZQRllGRGVUZUs3UHZ4c0lJeUNIQnF1?=
 =?utf-8?B?YnFpWnhZcVVreHdScU5XMysvZUJsTzFqRmFnbUdDQWpGbzVDNzdDWER6N09O?=
 =?utf-8?B?ZzhaTzdPcjZvYkMvKzllV09OYklFY1J3YUFiUDdtclhxRlBrcjVTSUVEN1RS?=
 =?utf-8?B?N1dzdmZ5QVFaQ1hUSWh4R0c3NFJDVHBnTUZ4R3J6N0FGL1B5Tm1qVVpCV1RI?=
 =?utf-8?B?dHExV3QvTk5jaHphT3FSNnZTODY0eWxYYUJRbVRuYWw1UlZYdStKbUF1ZmRR?=
 =?utf-8?B?TzBjRVpnUHNaVnpBOGkrakZhWDYrMVB5d0N4OXkxOC96bGxrbnZtNFAxb3Vv?=
 =?utf-8?B?TjJyUHBOemlrZ0greVVMdDl6eSs2Nm11eEdLK1N6STVoYVJvOFFtWFM1Qkk3?=
 =?utf-8?B?a1FWUW80Y3JJNWwzODF0ZEtUNi9BblBFSEh5MlU2ZXNjLzhpYkpsanpFMk15?=
 =?utf-8?B?ZDBaMElQWjNGRzFZNExIbVBsdktKL0h5NEh2dXRSVUozQm1VMHA3UmdBanBo?=
 =?utf-8?B?OXF4b1NrdHNFVXhGU3BPaElGTnNiTnVKNE15S0V0TmQyWEJEVG5pT1JnU0l0?=
 =?utf-8?B?bEpMZytWclR5SUJWQVZLaWRnQVlIT1ZwemZXb29xejdTbDhQcUVOUmFablVG?=
 =?utf-8?B?RUlvVFF6OGp4OGdDRWNsWGlmSk5OQktLSSt4dmNVcWhmWFJoeGllTWp3RnF5?=
 =?utf-8?B?VlVWN09DbVVTa0FUZCtaUFdJakphRWpNbGJZVDVLNHFXVUgxL0drYk9RUXBz?=
 =?utf-8?B?Y2VDcEF4RzM5eS9HWk11WFc0U1BWQU9sRktTQlEvb0dEL28rNlBmaG5qc3h1?=
 =?utf-8?B?d0VTNWxJOWIrSk5XZVhqUWd3cXdhMDRqd1pucDNQY1U0ZVFoVG5pa1JoYkZW?=
 =?utf-8?B?TG5aN0o3SFRBWUUxclpJellUSG9pYXpZdGNFZVRiVXBySmcvL1ZrMm4zU3Bu?=
 =?utf-8?B?cVRqVDhMVnNzTURUZUlvK3dUZ2x6QVVzOFVOelBsQlNUVGNFZGNFdXROMS9F?=
 =?utf-8?Q?xrFE7uGw9KDnTOs2NmrQWZBaXGlzyzYE+bpgNYqeGmsr/?=
X-MS-Exchange-AntiSpam-MessageData-1:
	G+1gmJzcnrsFEKuqRYF9G+/bUeeYl5yKHSXEQhA21O2/sOpzM/b9IuBp
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb11edc1-878d-41c9-5bde-08de73fa5333
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 23:13:31.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqQNq7yAsQEcneDwoL/MpRnKcjwOnWLZchly7sqxn4v2ymrq+PyypwOnUvChmDJM764Tz1/vf545rXDcB4KkGBfciOJcc+PxBaEdH2fbJYIeK4uGwUawT3q/ZMMsDIpT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21142-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,os.amperecomputing.com,xsightlabs.com,huawei.com,arm.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.641];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amperemail.onmicrosoft.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C52A18E1BF
X-Rspamd-Action: no action


On 1/27/26 04:29, Sudeep Holla wrote:
> On Mon, Jan 26, 2026 at 12:07:26PM -0500, Adam Young wrote:
>>
>> On 1/12/26 11:55, Sudeep Holla wrote:
>>> On Thu, Nov 27, 2025 at 02:40:56PM +0000, Sudeep Holla wrote:
>>>> Hi Jassi,
>>>>
>>>> On Thu, Oct 16, 2025 at 08:08:14PM +0100, Sudeep Holla wrote:
>>>>> This series refines and stabilizes the PCC mailbox driver to improve
>>>>> initialisation order, interrupt handling, and completion signaling.
>>>>>
>>>> Are you happy to pull these patches directly from the list or do you
>>>> prefer me to send you pull request or do you want me to direct this via
>>>> ACPI/Rafael's tree. Please advice.
>>>>
>>> Hi Jassi,
>>>
>>> Sorry for the nag. I did see these patches in -next as well as your
>>> v6.19 merge window pull request which didn't make it to Linus tree.
>>> However I don't see it -next any longer. Please advice if you want
>>> anything from my side so that this can be merged for v6.20/v7.0
>>>
>> I thought you had an approach you wanted to implement for the functions that
>> provided access to the Mailbox internals: you wanted to do them inline but
>> hadn't gotten to them yet.  Is that still the case?  I will resubmit mine as
>> is with -next if that is acceptable.
>>
> Honestly, it has been a while and I have lost the context. Please post what
> you have or thinking of on top of linux-next or jassi's -next and we can start
> the discussion fresh.

The updated patch is posted.  It has a title of

[net-next v31 1/2] mailbox: pcc: functions for reading and writing PCC 
extended data




