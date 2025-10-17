Return-Path: <linux-acpi+bounces-17881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE7DBEAFB2
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2224B6E7760
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300902EC086;
	Fri, 17 Oct 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Vjb9vFUa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022125.outbound.protection.outlook.com [52.101.53.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3C2EB878;
	Fri, 17 Oct 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720109; cv=fail; b=pjkKtSg22iDe9FZ4PMYy9tMGsQCYAdGTcE6SYuAWTM2pe0cm6DpLYqcCxkTp2Ozi/xqqlk+9uBEnPBrDTtc2I+tlsn5o+7FXunNGMwrJpdYJpOoGmxby/Qdn3VLI/o+Gf4gYbkVXzqG8lYXyDof6UAc/ZTr0fRb3zBTCpVmUqv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720109; c=relaxed/simple;
	bh=qUObrPCZLE4ghkfrkn7ejAINRD11yGStqRMSolrS3lw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Big1lQSxahPyMVvhFr3mgbDiiP/QtLed3NILpZn43ADPjNEfPpQVuUTQyyYm1TxRmR+uXbOsCFHO/lgX6AKo5yGQdVh6HmXN/Qjhs66hdjK3E1IPFhqFrADIDspfkMbUrY7M8i1IhNWazj494fMxS0IYmjV9lPyay/TQ3wBiYRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=Vjb9vFUa reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.53.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alpAm7kpyDPRPvIGEKw1yvfMIqY1oZ8Y+qQ1Z8abhyctWQEoX8IKcsgQhT5yhue47Qwch0SQ8rQFB5KmQANOi1riYj3QWIzf8UotlLaaNiewr1dGDpoZ/YhJoLN/u8fJd1kvpV1qfe0EQS15tyGWsSEKLiw08cqhE+dYnga5wyPIN7cwJt8Vk/NfWZF3J54zB/Jw/bcMpXccKSXkZn9vnBcfZJBIUuC/eM0RMYWnn9uGCjNu7yPO7LAYqqbfRkVYOSuoiMkZmPx+aSdjTSUW2qLHlv5FRZL6AuvbfxCTvSvi2OPeUss3Frk7Mx+jItHH3nWEmsIFTAMM4K33gZDdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJqk+YRZoI8V/54IbVXfm8c/bCOizX2MZHh15rKh/QY=;
 b=HbN9xBbmoUz6hTk9vX7A47TURYvew0ZhsIf3dC4CYoes67aJTC0F6keW/o6bp2j4AUm51iZLDzWDcB4SWIzZd5a9yKEs5Ov3GkOm64pnqENEMjxzxUJwiZQYq787dr8N/GjOzcPuQutBexRa0h44RXaB/h5ucDYtJrrCzW8WcSRosikuVvnV0XQra5qo2P3B2T1GWexocIERaJWlNKSJtnbSfrxySuyWl+WVRCDkgUL7Pk6Tf/8HU4RIk6pI8TjV6gCsLxilhlulPvZkYWIEsd7Z7ZdO1WNB1SbFYOseh1sjw6SLNltCFjCKetaR6+ytYWka9DAtbVhFgqTDNjSYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJqk+YRZoI8V/54IbVXfm8c/bCOizX2MZHh15rKh/QY=;
 b=Vjb9vFUa3BN+UjyqrCKKPkkQ5nd819/Tp+v7X+N1Nfg46cRvij0fks6qwIqJV88U67XvolY5vdQY113mFqsuhHoXmogCfq8CKRI+TSFmcfLPeSDqDR8Szz7w6wEsVtAIi359fA8/Pcl5rwJjHeSgWiEQO5AAVTv9NR2Vxps8eA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB8621.prod.exchangelabs.com (2603:10b6:806:375::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 16:55:02 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:55:02 +0000
Message-ID: <8d7274bd-7ec6-4521-938a-a8ae47ccf619@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:54:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] Revert "mailbox/pcc: support mailbox management of
 the shared buffer"
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-1-0fba69616f69@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-1-0fba69616f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:930:cf::28) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d8bc77-3dfe-4f46-fee5-08de0d9dea17
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFRwYzdyamUxU3hzeksrYmJ0VUlCU3ZZeklrMG5KWVRJbHplRkJLazA3U0ZT?=
 =?utf-8?B?NUNwNExuSjdzWXp2dXVKaVhSUWNMbjlVRi9QV0pQNW91cDlkaFl2K0tpOUti?=
 =?utf-8?B?QlQ4T2JuanRlMzlRdGJqZXZuMmZXdllpbWU1WE4rYVpXdXlsMXFveG82TVJx?=
 =?utf-8?B?RS9kUGhqVm43bWVzT2d3blBZZ0d3TEdwNzQrUHpraFBpTmQ4b3lDNzJpNVQ5?=
 =?utf-8?B?blVyWVZSZ2NRVDdOTGw3N2N3QTdzYmhiT3ZiT3Z1blB3ays3T0tEazFQRjU5?=
 =?utf-8?B?bVNHVi9YNjlpY0o0V0RvbWpKWXJlUVZqYXQ4dHQvd1U5UnFoTDNYTFJ3RkZv?=
 =?utf-8?B?KzhuNm0zaDk1OXZYdzFkekV1c3kxR3FrQlNuTWMxdkw4SjlTaFVJb29ZeUxN?=
 =?utf-8?B?OW1wbmgzSCtmUHg1aWJFeUZyY09Ud0xNdUg3ckQwTUd6WHBuUytVcXg0ZWc1?=
 =?utf-8?B?Z21jekpuNTBYK3dYQ3d1Qk5LR3czL3dHNW95ejB2cGRySTRhbmYxemx2OFlM?=
 =?utf-8?B?K3dFNklYK1RCSTA1dWs2UTdXdEcxZnRyVTVsY1NuUklzN3hlcm5NTDlHYXRJ?=
 =?utf-8?B?cEdkWEJoc0FuUW9lRXUwaERQbk5jYXkzMXdQKzV3NlB3THNGRmdGU3B6OXZ5?=
 =?utf-8?B?cjdIWDQvRHNBVlZaQzhrQ1h1eDdVSC9EbnJGeFU4aG1EaTRnTktaUlVqTkNx?=
 =?utf-8?B?ZTFIT0ZNTDJCUUJXVkU4NVRwUkxSTm5CUjBpVGV4NVhqaUZ6MVA4N05lMlZN?=
 =?utf-8?B?SW9aVUU4M2trL0hzQmpFMlI4ejlKR0ZpK0MwdTdXY0hjUlE0Um5GR05CNDFE?=
 =?utf-8?B?TEZPZHVrbSs1Yi9yNmpvNWhiQUpKd0duckNKWDA3MjRETmxYa0RqQjl4Rlpp?=
 =?utf-8?B?ek5xRGgwaHpFbng4R0FnMVFzOUdQU1NGMGJzSlBWQ0RTd3RDWERQWWg0OWhk?=
 =?utf-8?B?cXRSVG1KeDQzRDkyajE5OG53Vll2dlEydUh4djVJTW9VWkhuWEFhOHRQRy9O?=
 =?utf-8?B?M0F5emNITGtnTFFHamlOOEg5RVJjMFVDTVlQT3dScFc5Y2ZjMGNpN3VwU3ZG?=
 =?utf-8?B?eDVQeEJqWCtaYXZCNkJVcy82US9ueWhoc3ZLTWJ4MlRCQk05MkdvSE5vL2lm?=
 =?utf-8?B?N0lRRFdEZFdscXRqNHNCeFRlb0w0eWJvTjgzOHExSHcrRVJvT3dCOUxSVHRY?=
 =?utf-8?B?VXdJMGxhWWlMc0hZR25KZGpjQlFOY0RIbjZ5am9idUN4Rm1LZkNKOHZyZFN4?=
 =?utf-8?B?c0U5V0ZZQ0gzd2RoQzcwT0JOTW42MjFxbURicnZVMEovRWJpb25QMGRXbktM?=
 =?utf-8?B?VjB2em5sM0p6cy9qNW9aRnZSd3hySllJY2hVOFlobUp6T1VMRTlnaGdtaUNu?=
 =?utf-8?B?WXMram42d3ppRnlHWUpITjJwTk11Z0kxSXJVNmdDZVBpL0p5aEtsME9OYW1Y?=
 =?utf-8?B?VG1Pa2FNQ0pldXBndTBFVTBaWnBaQ0VwMVhoazN4ZktqS3l4ZlFaM243MHY1?=
 =?utf-8?B?bEpPRzdWUFN3ZkhnaFFFMFNnU2hlWTlIamVLM25UaW5XQU1wanFRQ3N3VFlD?=
 =?utf-8?B?SXhNWkdFOEN3a2NtaGVucjJ2RFpXMFYxcWlqVUxrOW1ka3RHZ1dSZ0hFQ2JK?=
 =?utf-8?B?eU9tVlJwUU5sL0p3algwV2I3NkZ2VzRuOGR6Ynd3WDZzTm5uWDFzUjhrNzZy?=
 =?utf-8?B?R2N5NFhBY0ErekUwcGVubVQ3bHpUeDF1Y0xuOTFQNXBRZktCL2drbmlIVGlK?=
 =?utf-8?B?QnNFenFtUlF3YnVHdmwyM2YwSWx2Zk9Jd3FVOWhCckx1MmhjeG1mazBwQlFY?=
 =?utf-8?B?Ym5DdzlneGxxcFI3dC9TUUJUMEhFM3BQem51YzZhc2FSWVNuTWlaZS9XM2xk?=
 =?utf-8?B?N1B2bEg4RGM3UHpHKytDS2pmU01Id1BiQ0psTFNrMTUzWFV6Mmt6NFM3dUhQ?=
 =?utf-8?Q?yhBpNhUlkAB+J3Nn+G0z7CMJZ/WiwZxK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2NWaVR3aWdRcmtjcmhBaE5zODd2TGNuenBkZnR5RFZjeUR2VWRNeHVKN3J2?=
 =?utf-8?B?YjJNTW1jb0Zvam0yZVBRWHBTTHRFbVBpaDMxL01oQmJRaVVhTTdKK1BHUXBm?=
 =?utf-8?B?allEUlFHaGlqMHFraThIeWVNQmVsZnUzMktKRTdMRUFVRTZaM1Bic0pXZGJw?=
 =?utf-8?B?VzdTeVhmMjZ0dHI0VnZBc2xzSGRNcG9LUXJHSmlibjl4NjMxYmRzekhrMGtt?=
 =?utf-8?B?ZUZmWDVCK0cwVUxTbzlBYUJoUTZqUmhQUmo2TWF4R3BrUXlSVFFtTXhpQ3lq?=
 =?utf-8?B?UFp0ZEFiZTZQc0U2VjEyci9ZdE1aWE51eGxJTlJ6WkxYZk1qb3lhM2d3MnF6?=
 =?utf-8?B?eHVoWGFUUmlvbktmYWFjMGFMRFYxc2wyNmJwOFNtQzhMVFFqTWtOa3FBNGN1?=
 =?utf-8?B?Q0IvcEIwYVZSUzFLQm93T2I4UCtNdU1uYjVUcnpldFdPY25SeDJmY1NpRXdy?=
 =?utf-8?B?b2VjaFB3SDBWejkrQTVzOVVIUW1sNDJpUUJIV3FFcDNTV3FrbjB6eklKT0w2?=
 =?utf-8?B?cXByc2VRSFgyMEFGUUI3YWhJYkdGZkVXdm85SkVLelo3dzFSK2pEdmJGbHRX?=
 =?utf-8?B?NkFLUUpVMWhvVkdQNTB5OXdaVk5HZVhUR2VHTlBuN3YxK1YvaklzS0xJRk4v?=
 =?utf-8?B?Q2xLcm8vaHJvWnRhNUZ3ejl1blBqS0NCMmRGRnQ5cXZ3cDRmdHRsVldlZkI3?=
 =?utf-8?B?ZVVMaFpucDc3KzMrdjlUVGF1WHBOZEoxTmk5elpJZ05pZE5BZGNkYXA5ZXZI?=
 =?utf-8?B?OGNGYkRwL0pwTElKd0tBa2RKNzVDazRiMW9TNDNzRmxoOW5reUZpMEkzWkQy?=
 =?utf-8?B?RE9GR2N2VUttUC8rS1lZL3NnVlE3bDR6SkpQRmhaMC9BYmVIZCs1NzdUTXor?=
 =?utf-8?B?SlRQSEtFVERaQWwyNnZxekdHWW9URGV3RWZQR2xzUjBSMFBCUDBkVzJ6VUVY?=
 =?utf-8?B?MUVPbEpMcVBuZm50b2cyMUp3Y0ZMNmhNTW9IRkRiY1RtZEZFNlk3citaMVN1?=
 =?utf-8?B?MnZaRlo4UVBTazdZK3pTMDc5QWpVR1plZUp0eXhPVlpPczVyLzlLaXNFRmxB?=
 =?utf-8?B?a0M2TXFKQzBEYnVycHdWM0Q2MHd3MENJMjlPUVRSdVhhY3FUTWxkM3pubjRB?=
 =?utf-8?B?VjA4Z3RLMmpQN1pIZ0RJcDdDcXFHVFJJSTczd0ptL3d2R0FlR0Yyazhvcy9j?=
 =?utf-8?B?SDc3V3AweDQvT0Z4Mlo4QU5mWGVISXZKZWtFS01MK1NrdzJJVzJZdHpqbGps?=
 =?utf-8?B?TTFGSmIrSitEL0E1d0wwOC9vNFNTWlg5SW9JZHFwVGZGZlg2Z3JucEk3SVBl?=
 =?utf-8?B?cmE4UWpHQmZ6alQ4cytzZWpYbm82VlIxcllMdXVuMFpaaWVDa1BVM3JGbFBM?=
 =?utf-8?B?RW1YaVZUWE5mK1dDUTM1NXJDcDZWc2t6amQydzhqR0NCY29jQVhoVGxRazZB?=
 =?utf-8?B?VGYxTVo3UkowR3ZXMnRtWEErYzNPTkdpQzBSWjdyR1dlSmYrUkVOL1lUWWJV?=
 =?utf-8?B?L3h1Wm5BWCttZWwwZ3Evem4wZ3VPY1R5cnZEcjd0UVNOMU42ZDc0U2ZHMG84?=
 =?utf-8?B?NGlwTkVIMHRmNkNqdFV6enl5eUlVc3JDT1A5NnU0UHJrazFRRU4zQkNOcUQ0?=
 =?utf-8?B?SUdTS0g3ZGsxMnc0N0RuQWdCWUJmQnQ0ejRiRWdQb0ZMajhYTUlnV1psNFc1?=
 =?utf-8?B?S1Q0VWZleFNZK3FsN1NXZjlwR2RPU2hrSmU0WUJ4c09HOVYvYTRKK2lmMzBw?=
 =?utf-8?B?S3dqQWZydFlZUW94ZlR5eXpETDZiZllzQ2Zudm9mcmxjN0xENTI5ZHFoYlpr?=
 =?utf-8?B?WTQxNVExUlNhTDZFdG9SY1NQMnpjek1VdlZkMU1XYjBkSkFmQWdCVUxWeVEr?=
 =?utf-8?B?ZlRjRm9aVDNTM2YzV1c5b1pqdGtlLy9odENwVXhwUmNqTmRITEtqWXBYRTFs?=
 =?utf-8?B?L1RmUzMrelRucm9OQm80T0tXTU1VdUFpZ01RaFpZNk0xa1ZucU5EdC9HMjZN?=
 =?utf-8?B?aWhjTlBHbVdrcmh3K1JObGphNlYyMDVST0JqV0dlNTAraGpQLyt3NFlZNk9x?=
 =?utf-8?B?ZmkrYkhTTXpqeDExaGJ2OEFNb0tkdnFyUTFHQVJMU3JFUW9wQ2JybEFSWDZl?=
 =?utf-8?B?QysxZ2RkZzE2Nk9jd1VLZVp4ZStoV3d3aVk2Z3kralNXN0RFVmVPUHBVVU5U?=
 =?utf-8?B?NDFCbEpQRFBIdFZrdGE2N3ZST3JOVVNSYmJOTm04ZUNaUHBsSmU0cjhLNWVD?=
 =?utf-8?Q?X11wg6GHHRSFAps2PAOkOsP/z81yjXB2dhiszrak7Y=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d8bc77-3dfe-4f46-fee5-08de0d9dea17
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:55:02.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj7hd5eDDO3gNe9029gfoHoOtXJJtz2+BccvbL9GoILHK3imm+hwhWmB5KgxKadJwvJSmgkHSZmWp7cY/UfxPWe0rkykPEqTV1ektr8svepgmGmfIabkjdztHEb/G24G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8621

Tested-by: Adam Young <admiyo@os.amperecomputing.com>

On 10/16/25 15:08, Sudeep Holla wrote:
> This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.
>
> Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
> attempted to introduce generic helpers for managing the PCC shared memory,
> but it largely duplicates functionality already provided by the mailbox
> core and leaves gaps:
>
> 1. TX preparation: The mailbox framework already supports this via
>    ->tx_prepare callback for mailbox clients. The patch adds
>    pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
>    but no drivers set manage_writes, so pcc_write_to_buffer() has no users.
>
> 2. RX handling: Data reception is already delivered through
>     mbox_chan_received_data() and client ->rx_callback. The patch adds an
>     optional pchan->chan.rx_alloc, which again has no users and duplicates
>     the existing path.
>
> 3. Completion handling: While adding last_tx_done is directionally useful,
>     the implementation only covers Type 3/4 and fails to handle the absence
>     of a command_complete register, so it is incomplete for other types.
>
> Given the duplication and incomplete coverage, revert this change. Any new
> requirements should be addressed in focused follow-ups rather than bundling
> multiple behavioral changes together.
>
> Fixes: 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 102 ++------------------------------------------------
>   include/acpi/pcc.h    |  29 --------------
>   2 files changed, 4 insertions(+), 127 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 0a00719b2482..f6714c233f5a 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -306,22 +306,6 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>   		pcc_chan_reg_read_modify_write(&pchan->db);
>   }
>   
> -static void *write_response(struct pcc_chan_info *pchan)
> -{
> -	struct pcc_header pcc_header;
> -	void *buffer;
> -	int data_len;
> -
> -	memcpy_fromio(&pcc_header, pchan->chan.shmem,
> -		      sizeof(pcc_header));
> -	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
> -
> -	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
> -	if (buffer != NULL)
> -		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
> -	return buffer;
> -}
> -
>   /**
>    * pcc_mbox_irq - PCC mailbox interrupt handler
>    * @irq:	interrupt number
> @@ -333,8 +317,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   {
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan = p;
> -	struct pcc_header *pcc_header = chan->active_req;
> -	void *handle = NULL;
>   
>   	pchan = chan->con_priv;
>   
> @@ -358,17 +340,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	 * required to avoid any possible race in updatation of this flag.
>   	 */
>   	pchan->chan_in_use = false;
> -
> -	if (pchan->chan.rx_alloc)
> -		handle = write_response(pchan);
> -
> -	if (chan->active_req) {
> -		pcc_header = chan->active_req;
> -		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
> -			mbox_chan_txdone(chan, 0);
> -	}
> -
> -	mbox_chan_received_data(chan, handle);
> +	mbox_chan_received_data(chan, NULL);
>   
>   	pcc_chan_acknowledge(pchan);
>   
> @@ -412,24 +384,9 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	pcc_mchan = &pchan->chan;
>   	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
>   					   pcc_mchan->shmem_size);
> -	if (!pcc_mchan->shmem)
> -		goto err;
> -
> -	pcc_mchan->manage_writes = false;
> -
> -	/* This indicates that the channel is ready to accept messages.
> -	 * This needs to happen after the channel has registered
> -	 * its callback. There is no access point to do that in
> -	 * the mailbox API. That implies that the mailbox client must
> -	 * have set the allocate callback function prior to
> -	 * sending any messages.
> -	 */
> -	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> -
> -	return pcc_mchan;
> +	if (pcc_mchan->shmem)
> +		return pcc_mchan;
>   
> -err:
>   	mbox_free_channel(chan);
>   	return ERR_PTR(-ENXIO);
>   }
> @@ -460,38 +417,8 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
> -static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
> -{
> -	struct pcc_chan_info *pchan = chan->con_priv;
> -	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
> -	struct pcc_header *pcc_header = data;
> -
> -	if (!pchan->chan.manage_writes)
> -		return 0;
> -
> -	/* The PCC header length includes the command field
> -	 * but not the other values from the header.
> -	 */
> -	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
> -	u64 val;
> -
> -	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> -	if (!val) {
> -		pr_info("%s pchan->cmd_complete not set", __func__);
> -		return -1;
> -	}
> -	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
> -	return 0;
> -}
> -
> -
>   /**
> - * pcc_send_data - Called from Mailbox Controller code. If
> - *		pchan->chan.rx_alloc is set, then the command complete
> - *		flag is checked and the data is written to the shared
> - *		buffer io memory.
> - *
> - *		If pchan->chan.rx_alloc is not set, then it is used
> + * pcc_send_data - Called from Mailbox Controller code. Used
>    *		here only to ring the channel doorbell. The PCC client
>    *		specific read/write is done in the client driver in
>    *		order to maintain atomicity over PCC channel once
> @@ -507,37 +434,17 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	int ret;
>   	struct pcc_chan_info *pchan = chan->con_priv;
>   
> -	ret = pcc_write_to_buffer(chan, data);
> -	if (ret)
> -		return ret;
> -
>   	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>   	if (ret)
>   		return ret;
>   
>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> -
>   	if (!ret && pchan->plat_irq > 0)
>   		pchan->chan_in_use = true;
>   
>   	return ret;
>   }
>   
> -
> -static bool pcc_last_tx_done(struct mbox_chan *chan)
> -{
> -	struct pcc_chan_info *pchan = chan->con_priv;
> -	u64 val;
> -
> -	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> -	if (!val)
> -		return false;
> -	else
> -		return true;
> -}
> -
> -
> -
>   /**
>    * pcc_startup - Called from Mailbox Controller code. Used here
>    *		to request the interrupt.
> @@ -583,7 +490,6 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>   	.send_data = pcc_send_data,
>   	.startup = pcc_startup,
>   	.shutdown = pcc_shutdown,
> -	.last_tx_done = pcc_last_tx_done,
>   };
>   
>   /**
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 9af3b502f839..840bfc95bae3 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -17,35 +17,6 @@ struct pcc_mbox_chan {
>   	u32 latency;
>   	u32 max_access_rate;
>   	u16 min_turnaround_time;
> -
> -	/* Set to true to indicate that the mailbox should manage
> -	 * writing the dat to the shared buffer. This differs from
> -	 * the case where the drivesr are writing to the buffer and
> -	 * using send_data only to  ring the doorbell.  If this flag
> -	 * is set, then the void * data parameter of send_data must
> -	 * point to a kernel-memory buffer formatted in accordance with
> -	 * the PCC specification.
> -	 *
> -	 * The active buffer management will include reading the
> -	 * notify_on_completion flag, and will then
> -	 * call mbox_chan_txdone when the acknowledgment interrupt is
> -	 * received.
> -	 */
> -	bool manage_writes;
> -
> -	/* Optional callback that allows the driver
> -	 * to allocate the memory used for receiving
> -	 * messages.  The return value is the location
> -	 * inside the buffer where the mailbox should write the data.
> -	 */
> -	void *(*rx_alloc)(struct mbox_client *cl,  int size);
> -};
> -
> -struct pcc_header {
> -	u32 signature;
> -	u32 flags;
> -	u32 length;
> -	u32 command;
>   };
>   
>   /* Generic Communications Channel Shared Memory Region */
>

