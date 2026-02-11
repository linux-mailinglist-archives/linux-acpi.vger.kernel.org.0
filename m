Return-Path: <linux-acpi+bounces-20941-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INxdMj/rjGmtvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20941-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 21:49:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 413CB12787A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 21:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 413773015D01
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5032E092D;
	Wed, 11 Feb 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tx7/nHhO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4D7262F;
	Wed, 11 Feb 2026 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842941; cv=fail; b=tgmxR4tkKZjycE4O7HeFLPxH9GgmJqRAk3/1Vir6FEH1V2gE8XGeqaX9w9amEFjSaBUDYiFq5H5JGCvFB/WLnjlLLHq/YinLTuzLNg/lzryDA4vMDjp+sD3kOYI7ih+isYpZVNjLSbldXyTUOVxvfjcCf57PAQJqZN8vcGf1cOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842941; c=relaxed/simple;
	bh=G0PKob9iusZnaul4K9ipXp/prmJACboGA0UvupKdQEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XaQ4GK/pnPQwurg3JQN20dJt3lT4gP9rdzJAmxBeBi1l7WgcFlBrt+kJusEM3rhfJ29OFIk3cR/jU1KCdAJvHbEwpOvLEEmHC738AAVGSYIrtY6haJDrPTvfiC+sEkmoLD7UZ0bqpWUDn0MlcJoH3JiIpdXK60LIqAQiXWKe1DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tx7/nHhO; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viHCNOuEnEPKjMYEHaFhlFyBm6Cn3DxQ0T6eBgFXgLmHCjVsO2p+da0b7NiGLFMIDY9+Z6cnVTIkTXEPjV8sdwCclWsB2SFa9qxOmSCr/dRQeD233l2Z4vuViiONEBFVYqx4wxFOU7SpEyAnfA0ThT1PJ5xhOCxa/AF+djv4fH9X8w1gKo/A5CDvJYiuFAChUM8KrAKzXiMyecIYvaPdcNpRBnW4ECPngHRT0KffF1/lQti32urlRXg+YXKSZFI6M5un75nNIukQCm5I0P20jX2fo9ha6Oi8JaTud3leBEpWgjHWNtNeR6W3ro4Akm1gBVTVuBlCo6A2m9SClJXDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKuEF0cn1dQcjBFTtIa6P02NR/g3NPF5UBpenFKeZds=;
 b=jXwBXgSl83/MWYpSEie3IB6zKvNL6av/bNvKxjZIWtvhxn/do/aaAvZBcZyHYpob/RFX+nMDRrUvuMV/zIFgoTyyxUnKI9CkQs16lOq+Uho10T2LOzcaMeY4CDzOKQxTUopDeRvqyq2fnA3TFIkZFE09QY/8l1e59Lk14yBa3dMlWR08LmSmx53bt+/Q7752ZnByaWCdom8BpqjAvN1vetKoJC8tBg/N2vG7HtrUOaWwaRmSoaysxY0b8OhRoRnry1lELpsYU0R3nYhICsEyjGYulIXfKTG6JBjR34136AC5IfdCR5SWxaANqTm0/GvZVQtSAjzBStHkKDGwLVT3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKuEF0cn1dQcjBFTtIa6P02NR/g3NPF5UBpenFKeZds=;
 b=Tx7/nHhOZAvxV7jdYnDT0Du9MJhMkCZVI8Eyte3W3TdRV1JNAPRNbc5w/Son2J4FmzE7tQwl621bvNuckqAmS7k4d5KOjpToomqqiucta3HGdSh+5C/Jv/a6BAxgiLQfV5AQ7wcjYIMjUw7siaDDb4X0M4vUZavgrZd2CVMUF7K3XQI7fXNP6xLxvOeYxtk35/3P0aD0i/SD3unGtZg8BK6h2hB/O1N8p/8tg6bWLn9R4Hn4VdWlxDKgj9ko7h61Xx7rU5tPU6rfcSAkFY0OaVfpUxxgzqzLsIlj1sn3cUGfxIiDduZc1H9l9IQfWfCuYzYdCyjcFIbooEwIWbtgmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 20:48:41 +0000
Received: from CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790]) by CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790%2]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 20:48:41 +0000
From: Sean V Kelley <skelley@nvidia.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	pprakash@codeaurora.org,
	gautham.shenoy@amd.com,
	jamien@nvidia.com,
	mochs@nvidia.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean V Kelley <skelley@nvidia.com>
Subject: [PATCH] ACPI: CPPC: Fix acpi_get_psd_map() to iterate only online CPUs
Date: Wed, 11 Feb 2026 20:48:38 +0000
Message-ID: <20260211204838.21269-1-skelley@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To CY1PR12MB9674.namprd12.prod.outlook.com
 (2603:10b6:930:106::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9674:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: ef03929b-ca68-4315-bc99-08de69aef02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ypg0e7Q4i197o6wF/eRG30KI+5AKR2h5XbAhCN75uHKRJEkbKHJInmeVjVW?=
 =?us-ascii?Q?Lv3FdAbgVcRLJQCwi8PecGbEyj+W50sHA9SWU8ccunNx5QOHBijBYW3o3Itw?=
 =?us-ascii?Q?q3txApa6sTW+iJg7w/iXYitroHnmFuajd2BLhx39WZ6b9irBPWfpjW9skSIr?=
 =?us-ascii?Q?9Xanci/7hZln14SFV+FJmy8J+1UqjHqUM+FwHzpXTOXg/B9UwoLSlLH1p4fw?=
 =?us-ascii?Q?0M8fK4unnTlCfnPodRKDzY7DTceypDwe5do+Yhz9kDzgu81hviOVqIQ85rHN?=
 =?us-ascii?Q?6ZDx8pm4fhL6zDCVO5I++DSxQdl22rLqlc26C0rSYRPR1rl5r0J+fRx0cPeb?=
 =?us-ascii?Q?mhRCB3aQCpaO53FxNbejspxDO04B0ps+TJeasBWOC9B0RaQbTnKU9gtmb6iH?=
 =?us-ascii?Q?YhXykpDb+l47xlE1zlQOaG8q5g4F+Lfiu/K2cMCqmtraV5VeSf0rhTah4376?=
 =?us-ascii?Q?T2NsyO+EkR3J0w9MCMv58V8+kjMyvw5PCrXN4Ogj0+8sPSuyNTKvdKoKS90c?=
 =?us-ascii?Q?687npb7QDtQNU/DkG0Im1QIgVckWb+s6xFaYpXt0eKjkPNkp4xnnYCeAM+UQ?=
 =?us-ascii?Q?nD0rohEvem4jY6xyVsBqFYc1mG2FY8hN4+V/GLqO5s/Hwwthz5aKcdJllybo?=
 =?us-ascii?Q?45q9/94VJUN0fyP75UTculLe2hnErPeg/B15sWBjGJoEf8ytbTDL8pGHoEtj?=
 =?us-ascii?Q?WYtxyP2Ocng7JykXLzUJ9NRht78T224ktJnJqxYS6jxf6Mvtmv8l5tjZNTDW?=
 =?us-ascii?Q?kTKz1BKdyDbtNd3Uhb35pF7NiLH7HaCNrv0enKsq0Gbg2yRwL5uCSTzXtv87?=
 =?us-ascii?Q?MGL1MMEU1gEZ2+btmR7C2e+J+jrWVyr5yn3krpdDE8eP4k5CJJaGEoXzf+gI?=
 =?us-ascii?Q?WgMkjY/SOav2l+0zZYidb7DvDje0oR0FSGud3YhcGwn/yPbc/f5TSzwAev0h?=
 =?us-ascii?Q?+EXVk5YdtYGKbeeTtk6dfdMyrhEseXXAzfdo5AZDEWVe547a96aTtl9g3a5j?=
 =?us-ascii?Q?ahikMxFCZTQdTauO0ZLBnYYC4qK1BYlmIqpZxnPmRd4Kr5tSula2Yg3tUlCL?=
 =?us-ascii?Q?jBaJfmBSPlCdbiRgKAMsp3GTGHTWgsFIENnyoDPrVW+HyuctrJh3/IMkfjFs?=
 =?us-ascii?Q?J8gIXoNoAWd3WriDvs+B3JPnKc0lgiGEwgS5/tsskv61rA3SbBJg+PvGJIMr?=
 =?us-ascii?Q?CC8uZjuUZZTUnSqBeACZbzeVPYK32f09n1qK/BwgNDg22ak8NNf1V2YXlxPY?=
 =?us-ascii?Q?NHs6S7f7qu6+BIRlNtRmG8faAlpXvOHyZQMMgfP6hYD6wlR9uHQ5CP4CKH3D?=
 =?us-ascii?Q?tFEOPxLmQQhNBJRH1FuibavOVfnBy5YB4XO7Fv15o3aGmQ8YL/Z9eIMSPBb+?=
 =?us-ascii?Q?xQCwZK3wHkNu6HvOlieoy0YAO31jq21OiYC/zu7xopd9Yp2pnVejVFEwG9+b?=
 =?us-ascii?Q?j02Bi1o0jIBZ7cveLlFQpuhyr93wG5jiFz3aizzUFCwKVnCyfT2dxPT/uJ1t?=
 =?us-ascii?Q?BAql2HH3OttpYGKs/Jc+vuv7oNBfhBNd8yju2X1WZM/jIDcXkG7stG1y2ue6?=
 =?us-ascii?Q?ZCY9Kbfp68YkzfhxJA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnQ2dPFmQZztBgDp3A5AkUd4p6UJUcoepEfP5qoY2TCoO9HQjUN/svhLnFks?=
 =?us-ascii?Q?LyCM6KVS+dkfQs3IEz/8VbsQqQCNWDLwERhZ6HSnxINtL1Z+ePUIJ7y7urRp?=
 =?us-ascii?Q?Wz3qdm2Zccf/oAZEtHupK06xppeJNl3otN2JnJxf0icdMFhsksqfJZm2TIc5?=
 =?us-ascii?Q?bTVleCOPfOu4+jLZM25pmTqB1MgWSFS1z+jxWHgd4HCa2CRspsEOlUtT4t8f?=
 =?us-ascii?Q?pqXLZiMrzx/NpqBMCufyPniSJJ34ndmZf8rbEhto/IAqYu5fJlsnD8iNJvNB?=
 =?us-ascii?Q?BM4a2bDRZ1nyzEiL1bWh7fESun+pxpcw+sjnokYZp7ivRPdzTHmPZWK3VaOm?=
 =?us-ascii?Q?FX7xuMcCPEx2w/M0sKPGz0C+eAR+hxcoCxFFuED2LuraW76rYO69ruau12u2?=
 =?us-ascii?Q?LxBIj63KfosHEF9bCf7VPGEZKr+3vAyjr2YGK9UpMG1P6M7ji5tjVhkk9T+2?=
 =?us-ascii?Q?RP/3eVi2AkCWOCrVmsmldx/VwqvdKyzrEzmcD+ZRhf7BxO7dy/ZXbjzXFGU5?=
 =?us-ascii?Q?rBJLk+XmvQTQ2X9stjRuxQETO6WwgKP2Y7B6B1qHy++Z7yzPDh1mBmjXpUx/?=
 =?us-ascii?Q?V0zRdh/X+gJFR5r5VTZTrHRye99C7Q80A2EJVzevdiPdofLSy7pkR21h9Yih?=
 =?us-ascii?Q?uUaYPasj/Ra1/ZEmOCLTjLziuKchN4UOwchLkUD+8KIyLQkGtdCI53RtbyKi?=
 =?us-ascii?Q?Au35ExchESy0nco5ZqJZLzxmt46auaMN3UijF6lEfifOxBmR03+YGWj6iXO3?=
 =?us-ascii?Q?ff7Lhw++z7uT7j/cjs5SWqsEACS7Z6DFo4qW7DzgnTCJbUxhjyh5FOP/hcKQ?=
 =?us-ascii?Q?gijAvfL/C4xKOh6lDrtXSJfGFzTurLIsuCMbUwgOXEOEnBGWOsWZix3JP469?=
 =?us-ascii?Q?xJcDZ4wlZ/kz0QsmXl3F/9B3Lrj9EWebxicAPZB+nEiAt+1k18LzNc2wwX2e?=
 =?us-ascii?Q?a93JKdbEs2YeKzBbeLkGBcVr7hpOyCyPeKxeueS89GKeLGHk5gzeFpfhSJVx?=
 =?us-ascii?Q?x27g+mHq+G5wiiMrOIYSJV2fPCH4mmdkQ6awgGJvZfieBcQ/hltmSWsTQr6R?=
 =?us-ascii?Q?qbubJzgBpNaenTjwtqLAaNUTqBrwFohGaL2uo6YTXeme5Fx2li6RYJ3SrnVL?=
 =?us-ascii?Q?21ILwQGuLOEBd8qaqaYvMaFX3y1jGkTPAbjBIvjHdaQtmRENt8GPoqUXI2Ua?=
 =?us-ascii?Q?xiNEs3+AE8lDYchBmQjH3AtQYov6Ed+ryIJFjlF4xMXA/RGVavktEzFaN/9d?=
 =?us-ascii?Q?u7OTFSKQyRF0CESiGW/2mE6QhzaQiLKZakhHxaxOaDN3zCrQSXaLGWYJhNOr?=
 =?us-ascii?Q?avozkariEpP/UmDDKUoDIo/i8jkc7+Lo6CT3tXhs7KFlcNUYexZFFPaZGuQY?=
 =?us-ascii?Q?aRVgLoROVgGeOPQ14l8jFgfBJV9QBs2FqRlHQ5GRSdJFtQGnZAY1jHbt/QXQ?=
 =?us-ascii?Q?CZtd/+iv0AXDwZxT7JRe3H1hghecMszdDCqlMKlFkgtn4AR18xRKPxK57Tv2?=
 =?us-ascii?Q?SM6y3PGX4JjftmBNAvVj4EH9hauZQweAcchQM4Q69EZnz9AanDIWHN8KZd8V?=
 =?us-ascii?Q?ROngxXn1tDR6V65OtbJK4eDZ0HNeL2TiMgOEv12iTzzzMN3HyaonMcncg8WA?=
 =?us-ascii?Q?f1DkNi2ikIF0Mzh/64D6c40UmEjbxKfH6GzbBSpkuR+/n3bSh41/9cBe6XgV?=
 =?us-ascii?Q?Hj0F6IGqZAm0enHrbCrvyMmPcSJjGAYdOY8nT+rH1Kz9kKvv2mU9uzQPERsD?=
 =?us-ascii?Q?4ZnPO5n4xw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef03929b-ca68-4315-bc99-08de69aef02f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:48:40.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQeIkXJexdO/ocmChOyXgTnmR4R0ln6hwa0SdCiGfSUfm/RNmChSvjsUuATagHOLNxP7dx5IsRwjZ+lLNN6+Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20941-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skelley@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 413CB12787A
X-Rspamd-Action: no action

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPUs via acpi_soft_cpu_online() -> __acpi_processor_start() ->
acpi_cppc_processor_probe().

However the function acpi_get_psd_map() iterates over all possible CPUs
when building the P-state domain map. When it encounters an offline CPU,
it returns -EFAULT, causing cppc_cpufreq initialization to fail.

This breaks systems booted with "nosmt" or "nosmt=force".

Fix by using for_each_online_cpu() so that only CPUs with valid CPC
descriptors are considered.

Fixes: 80b8286aeec0 ("ACPI / CPPC: support for batching CPPC requests")
Signed-off-by: Sean V Kelley <skelley@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a09bdabaa804..e7cfd4cf029a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
 	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
 		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 
-	for_each_possible_cpu(i) {
+	for_each_online_cpu(i) {
 		if (i == cpu)
 			continue;
 
-- 
2.43.0


