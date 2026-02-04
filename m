Return-Path: <linux-acpi+bounces-20856-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFkjK8W8g2kgtwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20856-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 22:40:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17BECCC5
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 22:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4FED3012CD5
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E041D395272;
	Wed,  4 Feb 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="kXLINmCT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020108.outbound.protection.outlook.com [52.101.46.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23E395D84;
	Wed,  4 Feb 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241215; cv=fail; b=Ti4C74v+bCCiAQSNX/JTztDbMzp6v5PGimPkxo+D0SNwpib/LclIlQGaHQEqwbFN+o6PeFPz2X6gZpXJYjvCu+TNswKftPEGUoLDe/Cp3BYmkPmjJ5utQpUM48Rv5aMdy6UI4sTB+05fEl9XiDeyNJAWR4DOfyTYZGHWmrx7Pak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241215; c=relaxed/simple;
	bh=xReps2Eu5CAcGrF+FDG7DdnCY2jqj785Ov3Koy4hpho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rmJ7W99U10UgKwBowPCzXXlg087Qxj/06SP5g8FdgxsUhK9ieLGePQwA0CcKpI0FGLEkCABvWiHuCQl0DYirYi71fvdvV32BFgnQLzPcO1OOezVxrmlDV0NaP1R7y6Rt8vC1EiyEC40obvCBXacVdOhTcx9la9Lg9dEnPIPChhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=kXLINmCT reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.46.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBHVqFd3268Ub26zY3EreXnDOpB4Nu8jOLgOeqFyWGntGVN1Bb0RvckEHxQ+/cEg58O6r+yS5uHqIRGyURUm7cMdH7xhgH6vX7Pk+SIC5VjandMSdozyr6tbYLQ3eKqkGbvfmucimREIUacKfJWVRVCG51nbH654pYV1a4FssOYUBNRrPe7tqPQNMKsMPG6JlYOQP+BerJrb8D5RosT+X9XVKK/I1deeQbflNzKmjCxWP2ZspunnYQOKHk//vpR4G33/bAmXEuH8guku/CKvkvi1VtuJcWKKnZz0L9Wp9DDUX3JYUlaAffLiWIAskJpf/cTVrFae/4UVqGT9uw42DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o60R4F/Pmc1l4IEJqZ1BcLB7gIodhsa3ZqOxIcp1Ifw=;
 b=zA/jvoAUdEFhl11EYsesgw6gp8yteahM++ID1HAoZAT6y7P+SDhjTM3+wPqjr2DjMQ0bWe5F6SISNcBt2KR1cEEzsV011a2+tZpK0X+R7Vc9f1EN+NUKzy5CkyNT4fJCXko+c2RRBOQ5RunCXvuAt38fWzGui4Xxoyn6WXcpjk6UUTpUnV29cRy5I/HsOwZ7fa9IL0uvpb+k3SaEMHBQ5u4+DAgeBXs9d1p//qJiJkJZ+s/du7JODXlPPx/b8ql9JmpfCpiTwFQBCgEU3tAQwpIGdLvoFJZt5oKmgd4QE9gepntKYucgv9MQGD9f50fB+4agjyz+F96CgLpvAt6GOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o60R4F/Pmc1l4IEJqZ1BcLB7gIodhsa3ZqOxIcp1Ifw=;
 b=kXLINmCT5GGB6YxNVVdQlJej2Tc5EFLd2ZXWvcscJYhlprmFAWnT8gzb6ch/y464Uvu1VNmRy9RNeklOl8TNqKYusZL2eb0y1Ep+I3Y2TffWvY/nPnSVf1etPjZ14qdMdc5KBHf62pp1P/s3fqLJ5NXlMOuS7n3PmCKssyo9v7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SN4PR01MB7408.prod.exchangelabs.com (2603:10b6:806:1eb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Wed, 4 Feb 2026 21:40:11 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 21:40:09 +0000
Message-ID: <cb6b0b57-c5b7-46c4-8909-e6955ceee401@amperemail.onmicrosoft.com>
Date: Wed, 4 Feb 2026 16:40:05 -0500
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
X-ClientProxiedBy: CY8PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:930:4a::25) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SN4PR01MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8448d09b-77db-441d-53f8-08de6435f807
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm9kVUh4WXlRS0xTV1JVUHV0THV5c1BDcGtYd2tWVzNseE5yWG5CTmZUZkpU?=
 =?utf-8?B?cHV5clVmenFnVWozWFNhTmw5ZVdWVlB3VzVSVFp5b2xPU1RLbjZWYk05TFlP?=
 =?utf-8?B?QU4zZlJJMmd0NmtraU9sRHJHMWJRWHJBRElZYkprTWJWS1RuaFNhUWRWc1Rp?=
 =?utf-8?B?SjUySmdrTHU3NElCakQ0OEJNZWhLSFR0bkNab04yb2l3bG81OW1pci9rM0M2?=
 =?utf-8?B?aWxIdlFRZFF2WkZ5dGE2NzM1dXZJM1JEYVhRdG5VY3g1U0YvblZmT1hvR2Iv?=
 =?utf-8?B?dnVENy95dU04emh0Ym9aNC9CdCtEQldPYVAzY2Q2Vk12QUFEajJha3o0Ujd0?=
 =?utf-8?B?cjBTQ0hnZk5OY2VablFwb1RsRDlubE5LWmtSQ0JlTjdDWDY5KzBScHRXR1lq?=
 =?utf-8?B?ZGdRUU1DbnZDMGZENmlpRWxJR21TbjNGT1VnT3ExZmgrcmpWQ3BWMWJpTks1?=
 =?utf-8?B?VzNNNkh4bmo4ZWRoYmtFNFFpbURjdzhSYUFHMWNDSWlLVDl4V3RLVjJwNDd0?=
 =?utf-8?B?bGtmdjdFLzR5UTBHTlpxVHFjalhaRzJkcy9MSW4ycUpsWlhCMVUwSzliNDhy?=
 =?utf-8?B?eVo5UXRYc2NIUzc5UzF1cFYxRGEzQjJYN1RlNW9tTTVPY3lXZDZJYlRWbkp3?=
 =?utf-8?B?TGJMdm1lb0g5cnFSUjdObzdoemVCNjZ6ZTdLMEdINXpNUmdzMm5WZnpWeEU3?=
 =?utf-8?B?ZVZ1dU9pN0VqWU4wd3Faek1ka3dxaC9Pei9VcEY0N2pHQ0NpZ2NNeUJWRkVo?=
 =?utf-8?B?OStkbkNTSUhOMXluK2lnT3dsdEFWYlZGV2xhVkNlUCtscENvbXkyUnJ3ZHVQ?=
 =?utf-8?B?M3p6Skh3RUpZcW82ZFpPL3RtNXNlK3hmZnBwdzhRWHA5UEZtdWNmZ0o2L1lC?=
 =?utf-8?B?Nkc1K3JldE9lWGUwUzFEbkJUU1NiL1RrL3ZhbU5mOWJFYm8vMkQyaHgvR2tI?=
 =?utf-8?B?ZTRFSzJZMnJXOHBjTm5lTTRGVU1kSFAzQjNqa21sT3hrRGhudUdCbXI1enR3?=
 =?utf-8?B?L2VsK2Q0SExVTUhsQjdiL1pXYjI5dkxBV09DekdEL0xvQURpM3FNNGVOOG9t?=
 =?utf-8?B?UVhUa1JDSmh4NUREUUNPemxPei9MY1d1V0d4NTBUaDg2VmhkWG1hUnpVcG5Q?=
 =?utf-8?B?dXRnbVdUalZESmx6Vzc5anEzeVdzb0xTVUZDSnVDd2szRGlDZ1ZCbDM4aHdi?=
 =?utf-8?B?Y2pFSjU2SHJ6SExrLzk2VklSR1ZqTVpNOERsRmN4TGZqUDU2L3M2emUwdGpB?=
 =?utf-8?B?R3F3aXhWT0EwVVpjSnArM2VuckNaakpnS3ZHYU5kVlJFaDlWV0I4YXBrV2pw?=
 =?utf-8?B?WWlrNGNBdFRmdXEvN1ljVkJBMUJBZzlYM3dDTXozOVc5VUYvd3AvUStqN2Yr?=
 =?utf-8?B?ZGc5aVQxcHNreUdnVVlqNVcyckxNQzJZTUlYTEFHdDRoQVpMbkZKYStEcTRw?=
 =?utf-8?B?MDUyQnlzaW1QMktqNDQ0bU55Yjd5VjNMc0t5WmVTQ2xIMjVlOW5pL0d6dk45?=
 =?utf-8?B?WkpkNExnbk15am9xNXBXdHptaVRlYmFtbXdkQXBiNitnTlYvT2htOGk3TlZo?=
 =?utf-8?B?dWlIVWlFUVdwUStEUWIreEZ3SHU3UVVYbitCOHlZUWFNVGdQUFpSa3h3RFMz?=
 =?utf-8?B?enZENWJuZENjNXhCbW5NSVVMcmQ0YjNpRkIwMDduS0txc0FQbTZpV0IveFRB?=
 =?utf-8?B?UFR3UXJHNkQveUE4YjVGNm4wVnFsUkdlYnJjSEY2d01Ia25qdTdFQmhBWUx1?=
 =?utf-8?B?aDl3RHo2dE5XZDVlRU9vWC9FeVZreWVOVXc1MWtUazNNR0F1QVU2L2ZWLzVV?=
 =?utf-8?B?RzJDcGgxeFdOcHY5UEtKdDJCQytmaTBZMnlBLzVjblVmUHBXKzlKSlhWY2ZM?=
 =?utf-8?B?djRTbmpvN2d2UjFNM0VFMUUxWklaWlk2SktIVXo4a2VtQ2VFak91K3RGSGVa?=
 =?utf-8?B?eitGSFI1QzV0QXlpMmpTRFJ0eGJKY1paM211bzU4OWdGUnlxQnhHUXZRQTF4?=
 =?utf-8?B?Qy85Q1ZtM1NIREFhRWNLYS9wTEc5bGhxUHg4ODZHMEx3S1gzRmh2WUo3QWFQ?=
 =?utf-8?B?c1dCREl5M1c5a3dTU1dsbW5PM1VGMXNFWThGdVBvN2NVeWRXNWI5YzdkN3hy?=
 =?utf-8?Q?F2F4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzlsK2F2QjZSUzB6RXk3Nm9lVHBob1BrUEFHb3NGYU1KUy9xSllObWVYREhQ?=
 =?utf-8?B?ZlR1bU45UWhGWlBpRDNVeW16REExZXRuQnBrOVRLbFJTelRidy9rcWlSRVNM?=
 =?utf-8?B?Vlhacm1XOHQ3VU90SURZTEFkNmFiWWtHOTRTbllTSWtBSGdUWHoycVhGV3BN?=
 =?utf-8?B?eHpYT2p0YWx0VjUvTlJEcGE3M1ZGL29KNXlhUGVjUTVhMXd6SDRSeEJkUjQz?=
 =?utf-8?B?RnpLOVFNcFR1ZVF0MnE4Y2VRZ3lDSkxnMkpqUWRCUnVubysxV2pGNUh2emFP?=
 =?utf-8?B?UzZTQ3ZUOFpPWWNEbnhQV1lET29Wek95Mnd2S01BOGVrVEwyLzZQaUZGV21w?=
 =?utf-8?B?NnZQVzJ3RGxMSTlscDNnUDQ5OTQrMFRpcVAxUnBMYi9GUGdFclU2TzdnRzkz?=
 =?utf-8?B?d1hrQjVaRkx4TlpiQjRTbC9nMmVWeTFWOTNTVllyMlI3R3lwdS9zZ1dLcnd0?=
 =?utf-8?B?Q2hoMjNHWXBvcWIydkRLRXpwZWdkR2FEYzBjTk1uL1QvZnJmdDkzSkV0azV3?=
 =?utf-8?B?WGdWUk9DcnA0ZERSSDI1NGlrM2xmQnNOZ0dOUURXYm9tTVJIdXZZSm5sRHkr?=
 =?utf-8?B?YkJDTHlDcDUrc2REQ05aTUhaYlp4aXBVR0pUc0IvSVVVVWxuTkJQQjlmQ0Vh?=
 =?utf-8?B?akgrZWN4QnlIVTlYa1RiQ21kV0tPR2xnbGVmV2pQSTZWaWFEenowc3QxZm1S?=
 =?utf-8?B?bW5YYzZJR1ZleElZcFM1WkVhdld0SHFYeGlKcXh6djBEbjZ1YkxuWlRFQ0Vw?=
 =?utf-8?B?SVhVN2llZlNnTFNQeHRuTXZ1Um1jbEFOTEEzRUsrcy9QUzBUMHB0TS9zL0N4?=
 =?utf-8?B?RUVzclZ0b0dneVRpQms3V3VHY01XbFNUSHl1RXBPZUIxcDZESXBQUmxETk05?=
 =?utf-8?B?bE9MVFNJMjJ2Vkw0enN4S1V5aDc5K2JqSmxQYnlVZXlxNDVJR0dDZGVIeDFp?=
 =?utf-8?B?UW9aMnFLNURUVXVJeEMwT2xhK3o1MXBHeWFZa0JySVNCWUFJY3VKMG8zSCs3?=
 =?utf-8?B?ZmhJVnZUZ2s2OFlIaWFBTVd6Y1JxYmNORVlWWGtnbVVUditqZnZKQlpOc1Js?=
 =?utf-8?B?c3BUTTZUVEJUdUFPYjYvRWJ5MTEvK251b1NnM1RGMXZzNDBJUzhodGV4TXNM?=
 =?utf-8?B?UXZ1Zm1kVXc0RTRibFpDc1NzSE80bk9DNjlCZGVPSUFCQXd2MEJrbk5UZHdn?=
 =?utf-8?B?NmIwYk50ZWNOM1M3QWNGcGY1ZHFCdHNyZFIwbVpmRjRUNFhyZzJ6SmFkQTJm?=
 =?utf-8?B?VkpGamNydWNjM1U4M2ZiTUh0cG9SUGNlN1hxWG96VGNhS0FIZzVIamxDZHJH?=
 =?utf-8?B?R2RhOERxc1pjR2Ivbkw4YklXK1BtMnpsbHZkOFlmYmdBbmluQ0VNNGpDdDln?=
 =?utf-8?B?WG9XVitSME9ZUGx5R2d4empHSUVVZ01uQ1h3d1NQd0JaWkV5VVdROUJJQUZV?=
 =?utf-8?B?YWVjQTlrb1ZHN1c0MnV5VjN2czdWWG5kSklPREh6MVg5azVYanZmdHV5dmtk?=
 =?utf-8?B?eEJBQXJpS3gxVkJWYjlGTFVQOFk1RDdPYmM5WnAzUmhnRjdERGEvY2FuQUZD?=
 =?utf-8?B?c3c3TTMrbkxJU2pqWWVQM0FVVGxOQUlzK000THM3Zk5lUlE4ZVFOZnVzVExG?=
 =?utf-8?B?TWVHVXYxYURER2NiWTZEdFlFNG9jaVFyanl4cjZRaytTRjNYS2VpdkNmcGRQ?=
 =?utf-8?B?RDNOOFpXb2ZKdTRyS2FEWVNSd01VQklLQzdtaEdZa3RCL0EzeTMwZVlMTnQw?=
 =?utf-8?B?RUQzdFRUV29oODlTSW1XNk45N1M1ZjRXSi9oc3kvNHJKRXN3TllXbTROdlQ1?=
 =?utf-8?B?b3F4emw1dm05cy9FV2RLQUh2RlhCcE5WMkdtQXU2cXp1c0g3OWVCSGNFdFA1?=
 =?utf-8?B?RDluWUZPcDlVRkZIdURTNjV4c2d1ZGViYXdjK2FMT2lNYTBzV2Rsbk1ZZjBJ?=
 =?utf-8?B?bEk0b2plZmc1Z01sc253cW5sV01Lci9xdFVuTUNZRy9EY3Y5Si9FRG04Qkkr?=
 =?utf-8?B?M25YeGlmcWViVDlONmttVWRFb0xJUzhCaEZ0MWhtVk5Ta3lqVEdkR0RsT1dC?=
 =?utf-8?B?SWEwZ1U5MkNOT0huQkZWbkdPTzBxamZySUt0L3RGb25KVDBDYW5sWUtRRWVv?=
 =?utf-8?B?QXRqZ3FxcGNaaGlmck9GY3IvaUk3SjkxZk0rTHpyKzdBZG81T1B1cVM0VDA2?=
 =?utf-8?B?aFNxNnNMQ29XeEs2Y3dGWGJsWFNlZzBxaGVIeDhjWUdrQmRveTV4eDhlRk5o?=
 =?utf-8?B?K2xCZWN0aGdoSjhjakszZjRCTHVrN290dVR4d0p0ejE0ZDgvQjVUL21jb3Bp?=
 =?utf-8?B?Njl6NS9wQTlDc1h2eExneU8yYVJRbGpkYU8xeVpJaU9hdWdxdFVjZTFKYmIz?=
 =?utf-8?Q?3EgJUUVd9YV2wSq5TqCT851mlT6V8cAk2HXToNmVZ+jeW?=
X-MS-Exchange-AntiSpam-MessageData-1:
	B7OdS2oJAPLjHERk25ejz2IWyRZBPAxlwpc3ex6UwvOizq41yNr69Hwz
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8448d09b-77db-441d-53f8-08de6435f807
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 21:40:09.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd2NbMPxrsxg0Dzn7ay5rUPXeXC+U6vKUVDrXCOXqzcUZiJ9ojQ2B8hxtqvDzV9U/567WflAi3fY+JeSPcD0dLcJtEaa2Y63mx/4lTxVRUMNPNahhT0QVn61Z9ES3YpZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7408
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20856-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,os.amperecomputing.com,xsightlabs.com,huawei.com,arm.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.922];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B17BECCC5
X-Rspamd-Action: no action

I was just looking at it.  I think reposting might cause too much churn, 
when the  crux of the matter is what to do with these three functions I 
added:

extern struct pcc_mbox_chan *
pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
extern
int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void 
*data);
extern
int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan);
extern
int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len,
                               void *data);

In my last patch I added them as EXPORT_SYMBOL_GPL.  You mentioned you 
wanted them as inline.

We can do that, but it does mean further exposing the ACPI header file.  
THe simplest is  pcc_mbox_query_bytes_available which I have posted 
below.  As you can see, it needs the struct 
acpi_pcct_ext_pcc_shared_memory  which comes from 
include/acpi/actbl2.h.  If you are OK with adding that to 
include/acpi/pcc.h  We can inline the functions in there.

These three functions are requied as a result of the direct access to 
the shared memory buffer.


int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
{
         struct acpi_pcct_ext_pcc_shared_memory pcc_header;
         struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
         int data_len;
         u64 val;

         pcc_chan_reg_read(&pinfo->cmd_complete, &val);
         if (val) {
                 pr_info("%s Buffer not enabled for reading", __func__);
                 return -1;
         }
         memcpy_fromio(&pcc_header, pchan->shmem,
                       sizeof(pcc_header));
         data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
         return data_len;
}




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
>

