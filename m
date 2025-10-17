Return-Path: <linux-acpi+bounces-17878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0455BEAE79
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E75204EED6E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C22E3B11;
	Fri, 17 Oct 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="/OYwCKg8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020132.outbound.protection.outlook.com [52.101.46.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDC2E22A7;
	Fri, 17 Oct 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719723; cv=fail; b=a6yPmt7PYhcLiCaEblpbc7LkkVmzcqn3c8hTpgEGd0+BbtM+EDjhVuI18sB+1eHzJn6eVpiIhMQgOrd80HBswN0XXGlt31hcWTlxqBIUEb0vpwCMAz8uO9PpoWJawR5J6qAIr4JRxSAGnN++qa+cZQVsUUDoWPOkk7Qu0WP+Jm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719723; c=relaxed/simple;
	bh=cTtLvIO+5gdvJOeNSTRemS71J5bacW49fbD+lL46FHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g3Q3/coOJ+kVxRTBgnt9EXqx3Dwwk3eeoljSRhN8VUowqxcM2vyMggIpkA9PGAEMBTIUtBGlZQMpnw/iFbbzEqY5jtXt34XjHLSRgLB6PIpMU139Cho4tc57gWTIFbQw8Xh8YfHJXOhD/9KotMfuLvviB4aKZWAuJv72YfZxooY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=/OYwCKg8 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.46.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXVIi8sWMKMpDFODl5+6heamlaJHHNimm5SZip/x/wLMYUFE9g2HWmSiYN7bQv7cDLYOB7O6N3qKappVxeTSNpJLOsYN4rasrMcQdx/4MxsPe0IhNJob48hgGN2x4DBosujmPue7H9PsciR6h9PmzZXJpBZnW438Sa9Td3ZWbfmeD6lPrtXoSMgr2CmIwgn0HzsC7efzBYHDzjRqCqLwxP7dBR00vzHjzZkjF4TEmfAqi0p201qza9q/CYkH+EgZqeRDeSAoAAENbPpTWi4nzi+Lvjd8dcNr/Pty0BaI3mhwD76dNNT5+9ET7hCwEjjC3et3pfvOIjzJFD2wC62lfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eVUnxUnn8GCFpt66eWvQ6BLfhg5deCIxnT8MJTlIFk=;
 b=GiflzDx9oX+0+kYlXqgTirGodBGYMzz80Hz3S1f1faph6yHApCyWIE7NzTirAjyGlcyLcvfT960Tt9WwIhx8qKc4neeU2ZIfPkajAs2bPQxTZdH1J6699Cq9SZ70yKGWLslQCjGLhv20Bog0ULNtksIyddEzgMvswKFEZj5aBM3WyTPPOXzC4oHFz8TB7kydFZgmjLbQEDdCbXauL19yZ1jixJqSpklw/MC56G+TXM4AOsFpfUDbmIBmnRk1ioKitytIpSQnD1OBFkb2/4EXS0VaHnFuJwO4lFiYI6gkbeeS0TZekdIQMHXXYP1b9UZ4A44kVUSZ5fZ1LjOZ8B0LaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eVUnxUnn8GCFpt66eWvQ6BLfhg5deCIxnT8MJTlIFk=;
 b=/OYwCKg80Wm/uhSfT705m9+ZRh7JAcmpffNEJaYx9GoqhxdEYtFZ31OFLIQI1HnfkW72F5IsvzAX751Y0VVPlz0N9vSC7p6ERmKXuPgj2NCK8QNnTmPK6DbLmxF7eI1HIt98kWs59SYDIJavia8ZKTE75n4tIO3soD3b7xcGEVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV3PR01MB8439.prod.exchangelabs.com (2603:10b6:408:1a2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 16:48:38 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:48:38 +0000
Message-ID: <81929a1d-6730-4ae3-9c91-c4cbfba44a7c@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:48:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mailbox: pcc: Wire up ->last_tx_done() for PCC
 channels
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-2-0fba69616f69@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-2-0fba69616f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0143.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV3PR01MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 146c2336-c6f3-446b-3209-08de0d9d0521
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlBURFdsYnhEcnJZNjJjYkVSNXpOQUQvclBhekhhL09iRElqYW5lbkZGaHV6?=
 =?utf-8?B?dmJuVyt4ekdMb0lURU9QR0V6cElNN1d6aUgxQmdFL1ZMSWhJSFBkNkowZC9H?=
 =?utf-8?B?eWYydHI0TGMwSmJLRWtaUjM5bHR0alBwWGhIZFFHSFRPVkNTcy9iZWRVUlFS?=
 =?utf-8?B?d0NtYUpuNUVNV1BLSHBlaFg4cWlGZXNOQzN2SnI0QTdwL1ZXMnJQQjAzZ1Vr?=
 =?utf-8?B?Y3VyT01PWDdEeDZXTlVCcGZ0ci84bHMvc0U0OUJqZjJ1UDZGenJIYlQyOVNH?=
 =?utf-8?B?Q2JwSVFlcEJTaXp3SHN1RmdKaTFwQ09KZmhIVTlnVUt1R2dYN3FmU1NNTnlp?=
 =?utf-8?B?SjNOaUxQQ2YrQjNmRDdWcjVhNS9PTUJWVFBvSTZZTGZzVEwwNXU5RXFoTmlr?=
 =?utf-8?B?TGRld3dvU3h4d1hqTnpXVEJuaHZ3R3RIOXo1K0ZQVjJUYXJtRFBOS2kxNXJ0?=
 =?utf-8?B?dUtqVThXME5Ic2NDODJza0dXcWhyWjZxbFhnS0dIcGN6dFcvNW5MZ0lpM0Ey?=
 =?utf-8?B?by9OcnRVbWx3SjF4QmpUYXA0bFZYemhFMkxQQ2NRMXZjd1VhTjN4dll5c3Bl?=
 =?utf-8?B?WWpRWnc5RWV0VmFaOGR1cnNjU3RQSFN1Z0lHcUpibENYSW9ObzdpWlFaeFJZ?=
 =?utf-8?B?NG11L2t4SCsvNDI4VlZzM3MwRkdQaDRQNmhUc25nVGtZY21TV0QwQkhGRytm?=
 =?utf-8?B?ekZiQ0MyZ3lvNFhNUFYxZFdRNWJkbHR2ajJ4RFhsNGRTaEVTSTJENUpERTdR?=
 =?utf-8?B?UCtHUC9tSVkwT25ZZXYzMDQ5ek9aZzZSY3pueVVvaWJoTjNiMEg4Tjh3WnRK?=
 =?utf-8?B?V2hPOC91blEydHV6d3Z4dm1yMGRoSGRxV25NSk9WbTJObHFqVGNCb2E0czVj?=
 =?utf-8?B?R2l2Y05EUjI4VDU4bUcwR2kyK051MytyYVhzSUt5WkZ5RHRDK3NMc0dKRDlk?=
 =?utf-8?B?czUrNVVlb1BpTTR1S3o0TVFkYWlxWjRRZDEvOHRTTVZRam5nZFNqdGgxUHFi?=
 =?utf-8?B?WkZWcWVHT3p4dk9lQzR4em1NMnlpVThSTXBobDMyekRyT3NYNWwyZmN4Q2E5?=
 =?utf-8?B?UUJvZzIzT2swTUJQSW9HT0ZpV2hkdWUvT044U1JIK29QQkJnNE1YKzhscGls?=
 =?utf-8?B?S0dYd1FlSG9DNitkTmFOMm1aMStWdlZVQjhsTExacWc0VEJvMENoV0lTS3p6?=
 =?utf-8?B?MVhjZXFzTGU5ekJ4UjNJVHI0dnA1RW9KaDBJWGRiSEI4OEk0VGNuYS82c0dQ?=
 =?utf-8?B?TlFEaFU0MXpYeW1IcjhpTGphYXhQQ1dOS1BXT0Mxcy83WDFSR1VQMkszWkZ0?=
 =?utf-8?B?cDg0Y3VxRy9nVkxlbjZjbS91dzFFcG8yR0d4ZDZHVXNzaTRpK1U0T1FDc0lK?=
 =?utf-8?B?WkpnN0pZZE5LSUVyTGdYc3V1bEtBZ2o2aWxBLzZ6K1Bpc3ZSUmFLUEd0QytH?=
 =?utf-8?B?Q1hqTXpUcDIyeFBSaGRGMzRmV1I4TEkwVWY1OFJJZDd6bG9LOGd4cis4VW1G?=
 =?utf-8?B?bDBaL0VDUXdIb0ZndWtZTCtKeHFDYllwcmdXdGcwdzM2ay8rWkNLUnJhSGdE?=
 =?utf-8?B?MnlHOTF0ajJRelgrVFdCQmNwQzh1YVNBWXJYYkprZnUwZWtkMTlCVmdYWjVU?=
 =?utf-8?B?OEJvcmpMMnNsVXU0akdvcFRpWmNVQkE3OGh6Sk9qcTZtc1dXZ3lyNUlkSUc2?=
 =?utf-8?B?TEtjeDJ6ZEprOHFuZnczQTlwWEZEbHFEa2pGMzEzd2ovL2lxYjVlMkhTUVcy?=
 =?utf-8?B?bGlCN1ZPci9ZV2RlNjBwZDlBSW15cHQ0NFJDTDFmYWZ1OXdmTW9XbVl3Rnlp?=
 =?utf-8?B?NEs3T2VlSDlXQ0NYMko5UFdmVzgxa1Fuc2NUVUhRWG93ZFZCa1dQZi9vZEpI?=
 =?utf-8?B?YklUUEZuMS9FOHhINk5tWGZmTmtwK2VwVGNhNS9abjlwMVJUcUdTc2JxS21u?=
 =?utf-8?Q?PkxtTKVZZg0DTZshbQH6HS6gYy9RSbZF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXVvSCtzbFN4TzJyMVAxenNBTGdYZFlhQnRpZnlzcENVRWFGc1Q1L1BnQzIr?=
 =?utf-8?B?N25HOXAzQ1V0cFVLc1JnRlRBNUtlMnV3ckJQYnk3a1JxRkxTUHNhc2pjdDJO?=
 =?utf-8?B?ZVlUaGlWWWlPdG84TDB1RDd2K1lqMTYvMy9Qa256aXlkVDdrRG5WdmpBTmc2?=
 =?utf-8?B?Z0dUekE3Nnk2akt6NkZtclJmbUNJT3lUcCtlQlQ0TzVHT0RZWDF3QzNHNVI1?=
 =?utf-8?B?VUcyRzFMVHFHam5oS0pOVzluSkJuSDlod1VkckZEU3c4WlpTeDZEdHc1MDBl?=
 =?utf-8?B?WDd4ZVhQVGcyazF5eWYvTmVkOXVlalFFYnhpVWJOWnNJRk1keTFxbHpOTkFm?=
 =?utf-8?B?QlRpam5rMVRqVjlSa0RIcDBYdWJnTHRCVUQvOWdoQW9MRTc0R0hUZjd2cG8v?=
 =?utf-8?B?d2liQUpDRGwyWEVIM1BYVS9UUURIZGpzcU5Wc2xKZDcxc3VYYkFVK2laeVJL?=
 =?utf-8?B?V0Q1NTczVU1ReWQwMlpuaTVzckdBaDJDbDA3Q1B4K1BtSlNhK1BmUGQrMzZN?=
 =?utf-8?B?K2pOeXNRaUJZVnVtN3JnRUUxZjFMeG4yMjlxOTI5UFVxb0FQd3NEeFMwZTNm?=
 =?utf-8?B?Rkl1d3Y2VVdhcjRoWmNiZ3RwdG50T2dxUWcvUVl2MzQrMFdsNmU5OXFhRlNv?=
 =?utf-8?B?Z1JjNmt3N0loeFFWcVpmbUZnSjB3S0FURExmL21hUFFnTzZUaFpQdjVpWDND?=
 =?utf-8?B?RDZNc0pJeUxpYS80Q01xOWtwemZCcDNxTUJUd2hjY1NJN0JoY29mNlMxMEJr?=
 =?utf-8?B?YzBJSjhRTzVhRjBOVmZYTVFSdHMzSTR3aDdjRGNxZmdFM1lCNzFacUdvcWs1?=
 =?utf-8?B?WlVmZ0dzVXA1Qlk2ZUkvOWc5VWtId2xmL0hGNTFYbzZibFJVYUpIenQ1UlNJ?=
 =?utf-8?B?VnBhRjN5Nk9ZUlVYeG5ad082R2Fsb0dGeEF3R2xxNlU3M3NYR01XUzJDM1JB?=
 =?utf-8?B?Mlp5OXd2RFpoM0JFQXJQMU5KVkMrODJ2dHFneloxZXcvVFlhYkpzY3M1Vkxh?=
 =?utf-8?B?SjhoMkhETG8yNmtveUsyNHZaWXdUemNTRERRc25yaVl0NkVpbTdlVmEzcFpK?=
 =?utf-8?B?aHk1MGNnZlMzYk44T1VZN3U4MTZxUTBEMmlRK1JSOUE4ZHZWVUltWDQydkt2?=
 =?utf-8?B?UWpDUHdlZ3NhVDlGeWZPYlV6WlQvQUZxSHVWY3JVY1ZlWkwvVkozY21sbUd6?=
 =?utf-8?B?cGZsak9xRE1YVTN4TmpXZ2NEM1o2MGcydXA1MDZkWnJxQ25hNFNaUGx2MHZs?=
 =?utf-8?B?RHVYWGZaWldnRFU5MVA1M2FINmMxS1dBTGZlYnEvaXRlRkY0dCtjWVc2ZHUz?=
 =?utf-8?B?ekF2Qnk5TmNSQ0pRV1UwMDhadWV1ZDZDV25zR1lpSDRGMXFWaU83M0pvT21r?=
 =?utf-8?B?K3dJN1EwWWVNWUhLMG5sK25lWU5ESkJHZXNwM2Z0UTd5K1BWUll6R3VlMnY0?=
 =?utf-8?B?RkJ1NWlZSFA5b2VSbVhicTlYQzQ5ZzJzUUxMUXMyMmMvUmRlV3NSWGxvSmtC?=
 =?utf-8?B?VGE0ZDA2b2c4cmlWYjgwUVJPcGZVNkJIdkR3K2xSV2p0M2c0cW45c2EveVdH?=
 =?utf-8?B?SjdlamphMDZ2aVp5NWkzQVkvRXl1L1JGeldkaE9OcldoSEN2dTFWZnFwZnBL?=
 =?utf-8?B?S241SHNueTlCM3ppUmYraGtCTU1FZGZmaWw4Uk1ORkhQZjUyWFdZbFpoTCtT?=
 =?utf-8?B?SlN6YWZJMlhMckVBWnNITTF3eGVwQWlLMXVWeUhNVHMyRmNPWmx0UStSbHN6?=
 =?utf-8?B?ZDRUTDYxNFpHWVZybHV2ODNYa1dEWGVtTGM3S0ZQYnpnbzdNaHFPYjh4SDRn?=
 =?utf-8?B?OE9pV3c2dDZMc2ZIcmtVUnBqVzZORjlpb3JndjlDQ3B3c0pEOXF1ZnZRbmIx?=
 =?utf-8?B?cUkxZjBnT2k3alVjUVFudlloMW9rVkdBd0FxbStIWExRWWg4dWVac3RiSEhq?=
 =?utf-8?B?VkVCclNSTk5IL0phMXdaRTYyNm1ramRlb3NOOTUwb1VPbHcwVjVybytQWVFa?=
 =?utf-8?B?QWZOOHI1aTlqV0ZQb05BelNWT1l4UXhkUFVrbnBNZmkzK2ZDaE1Wekdad2dC?=
 =?utf-8?B?a3VteHpSNER2UEZnYnNtUXZMT2ZNbEdGV25yRjNGUWxVM0lsSldEc2FXT2Qy?=
 =?utf-8?B?dlVWMmU3SkJsSEZiL1M3cUpmcFFXRHNtUWtWdTd1TGI0Y052OGUwcjB2SGVO?=
 =?utf-8?B?WWI5UnI1bk9jZm1QM1JZVjFrZHhvSkx5R011emNicVdFSXBsYW93YmdlNng3?=
 =?utf-8?Q?BSn2jw3+ujSdcGNA1TAfreGZgEhEbjSG7d9o1NJwAo=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146c2336-c6f3-446b-3209-08de0d9d0521
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:48:38.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGaten9DudPRkhVIEWvmrQwv4rlJwrAdPsoPtXQAY5WbgqKcoW0Tcfh6eVUv4V5sCu9kxYLUoLXiuhbffxjXFcp79pqmY/VUBpprls0rU6Ny2e5qmUCX84ihCHc3QqxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8439

Tested-by: Adam Young <admiyo@os.amperecompuing.com>

On 10/16/25 15:08, Sudeep Holla wrote:
> Some PCC users poll for completion between transfers and benefit from
> the knowledge of previous Tx completion check through the mailbox
> framework's ->last_tx_done() op.
>
> Hook up the last_tx_done callback in the PCC mailbox driver so the mailbox
> framework can correctly query the completion status of the last transmitted
> message. This aligns PCC with other controllers that already implement such
> last_tx_done status query.
>
> No functional change unless callers use ->last_tx_done(). Normal Tx and
> IRQ paths are unchanged. This change just improves synchronization and
> avoids unnecessary timeouts for non-interrupt driven channels by ensuring
> correct completion detection for PCC channels that don’t rely on interrupts.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f6714c233f5a..2b690c268cf0 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -445,6 +445,13 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	return ret;
>   }
>   
> +static bool pcc_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct pcc_chan_info *pchan = chan->con_priv;
> +
> +	return pcc_mbox_cmd_complete_check(pchan);
> +}
> +
>   /**
>    * pcc_startup - Called from Mailbox Controller code. Used here
>    *		to request the interrupt.
> @@ -490,6 +497,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>   	.send_data = pcc_send_data,
>   	.startup = pcc_startup,
>   	.shutdown = pcc_shutdown,
> +	.last_tx_done = pcc_last_tx_done,
>   };
>   
>   /**
>

