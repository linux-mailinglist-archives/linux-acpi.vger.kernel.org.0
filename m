Return-Path: <linux-acpi+bounces-21569-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BTtKJksr2kLPQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21569-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 21:24:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D1240CF6
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 21:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277F9302E7A9
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB9D3EB7EC;
	Mon,  9 Mar 2026 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pdAqYO42"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598036A003;
	Mon,  9 Mar 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087894; cv=fail; b=kkHWZrTwxF/ml8HUysEGwzcaFENJlJaNMAggwnIwZH9K1RTaQP1qz1wTM0KR2/jIBsIR7SWC7z9jHY7UMxA86Sm4hcxE+QIAH8zNJeXVk03C+649BP0mMfvnprMhvx41aCAeDvmlfVyP4GcsbJiIDW8QGKe/XLCz5/qX7iNnpwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087894; c=relaxed/simple;
	bh=nC30OCLEnNugxC4ljOzMW+TQhzhj15K/YBXbAaS7OnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fn9niY4uMJclpIdktCb1BTaUKFsYGXdPLbeTc8+W6cg9wxMm77sFPlVSxAq9vtQXq9yNgcrdCV68Z+IuDZF2ScGw8t2DkNxfX8GAOOdjqSWSAlKRqli5ZiYzubQijvBcfMn0yQnefqowwGC0CPm6KyF/9WLsQMCG55fiQ8xJd7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pdAqYO42; arc=fail smtp.client-ip=52.101.85.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7Modnz08b7F1Pwy7QqrefN0410oonEaNtVlUlLMRvjmcQQJT5rEH7AfAyDSy2zDek8xSYtnCjN6OH1NQ6JJ4TYCSQME8uN2S+HDlUsd/EMN3De7oLDdgdJQ9Mr0BAJu5qZG+C81CSDEsj+Y1KGzVKv1j4Z4YnKsdkO7L0bDDcTGUbFcM7dCYjNDeTQMNdzRiIOwJfgyqMv+/rBNI5OaIaC00NetbPfWMI/gYMvUG+N8ri8CaH5IuJ4tJm1NZldPaKokOWm/371smQcJCWvskGHKuEE4Qg84JcLZ9VbCkihFlvSjtSTnVNPGSFznNEv1w60Df9k9rHOpPMCoIjukCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/z//uVwx89XLsXiHSR1HHzVglmrHTM50DIiopZjRnY=;
 b=gmU4k3B3ANA4xNw78dMVwys0rOt/VQ6V83OKTh0ajFVwaNaa4ili6K7vMsAw9jCO2iJgJSGa50+qzC4rPsluiSKiEuWkqsDd2YIcOJUG/LGGEiuFtFh+gf1/5hoftJOQoRUhF+/K1gBeRYzxJWWKYfl9a9sN11nrB/G+6izuQ5QzK/kCxgcl1r9FlR9CVt4SWouZjVbjZtLk+teFtUXxvqmcpwACwJ+5ttYE8t6TmooMwiqjklgTgT6o55FOmOW+fhbgAxK0ZQumAgCS7YuKgeVVVPMjHABruKFYdMITme7zW18JYfqAAeN7Pg5dOjkqX4imTJeKUrLLC+X7mVNtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/z//uVwx89XLsXiHSR1HHzVglmrHTM50DIiopZjRnY=;
 b=pdAqYO42eOTh9M+KDHbEhJ/rSilKuh9rqhs1+JfxF5FpKV2G1MUrCipXmAB2a43Hph5Oj9redCvT0qe6kj7rbZG52xHhjoQOqYlQ9MiA7yoM/h6neyxdt1Yy6a1WK0VLsoTcZezyiZ4CaFonP8Q4/6dXjLDRxMIpe0WDSpWNPFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 20:24:47 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 20:24:47 +0000
Message-ID: <a0211005-30d1-4faa-83b8-b2526b4e7dea@amd.com>
Date: Mon, 9 Mar 2026 16:24:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Switch over to auxiliary bus type
Content-Language: en-GB
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Du, Bin" <bin.du@amd.com>, Mario Limonciello <superm1@kernel.org>,
 W_Armin@gmx.de, benjamin.chan@amd.com, king.li@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
 <CAJZ5v0iNdTFExoupRmwJmdykdRJa1QUJXzsb+j4M1cpn1qALig@mail.gmail.com>
 <CAJZ5v0gR+-Y=XqNXoBrUpd9HtSRqGk2cSXBgXsp5YJRsdCTMTg@mail.gmail.com>
 <5982633.DvuYhMxLoT@rafael.j.wysocki>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <5982633.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0292.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::11) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9188efff-04f2-485b-ce8e-08de7e19e89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	9RJvHlsuRPMY7yswetBuSt9yG2DageC3YzYGTqdjk+piXzLE7AX5+aOJRZ7LjjuyV4mM5nK5Wj5Nw2Tdnoqa0MFEq0FgJz2jkEtYQ8PResF3g6FFaptGymI/GJRkJrNacLGJDAi8hot80EAqqZOkBBqQRg8Kit5OQLPJkmTAS7BQhRJLeX6nPhKjBkzNwuepdDBesrl+yRhiaOUjVIR5Tno4vfH2pdzlnOIjZc+ZTWq/4THnDu4Sw5YvkYQtrgL5sPiXsbVm7vbyw/PpJkmNpz06G0THz33frFC3JmKQ8m6fXYHEmt/CsAuzwdEiieYIwWJInFJckF9ssWPMOk+ZbIQq1Qf0C0SSwzPPzg+7CDRplE5zE2PykW5ONbcF+ONG6VtxpP1JYgjZVXzv4fns6tjUq4uunKr8b3zdP/Ex4WOg9iERd330gjBqcQsVgq4UsJmIyfllfyR5bx/VUqZ1hrI2l03YIqenTvBAMD/JuMMiIcp8p84MgIB5W9ck2kJXbfKSNWVTHotKgGJ1d61mmHF8u9BlOXr4oJ+OHcixQbi+UlvSnW4gbBX1CbQAfV6eWYs/FyMJrGkmg14S4gKusYzDnzmN4ciifbYGLDzGErJdjixoWOFKrEtR8bEYr5b67bRW9pHi4MtWbnkrbai7KeuAg72ZpXgEbdIxCrzXaJgIrnLkbiJXsgAorjltDuN4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1lqVEoxM1U4UGpTVHowWFluMWFSaXo1SmV5WEcxVFFFT0xzeVMxVWJ3V0F0?=
 =?utf-8?B?ZlB2ai8zMjkyV0hQU3k0N1phZE9xSEpVa0liQVNrNDZlMUplZ1dGUWttbnJr?=
 =?utf-8?B?YTQrUG1RT2xadS9aOXRDQTBVQnorc3JGMkg4SG9KZzd1Z3JQekJDY21TZFJv?=
 =?utf-8?B?aFFGeE9zYURJcnVLbDJqSFhmR0xUVFZFRGhLUDBJNUJBMGxkalZYdVlTYWUz?=
 =?utf-8?B?NUFFQVFwWjh6cDFwQ0JxSExVemhrNDVVcE14bXl4MUxRVlNUN0V2WjY3dFEv?=
 =?utf-8?B?UXY5eURvUksxb0xhMzFldDhubTFLVzRKYjlkMDNLYmxzeVpncDd6aWZtc0tU?=
 =?utf-8?B?REpMa0lRa3NpeWVIWVh4QklPTml4ZkEvQWRwblRaQnhyUUhNUDI0elN2RnRW?=
 =?utf-8?B?RXVmdTZDWWh2aWt3T3VVNnQ1ME1ZbFRrT2J2aW53c0QyeTdJMEM0R3dLZEll?=
 =?utf-8?B?OFJYRzgrRGN0K3lBRFVudkxmdDlrbE41aUJrQjh6UHNoWjlGYXlnVWpZZ0pJ?=
 =?utf-8?B?blljVUtwTTUxREoyQjJyak9xQWh3QndqcG90NDJtMUJjeTFCRTZveEJCWDZv?=
 =?utf-8?B?TnRaL1h5U1dWcVhUYWhFRDVvbTFGdjI1SXJlS2xLdFZtNnFqZnovZHBia2JP?=
 =?utf-8?B?ZjN4dXhzTXR4dnVpTlYxd0FNcW5HSHBQNXZ1a0RTWVp1RkVrQUoyTXVYczVM?=
 =?utf-8?B?UndQMzRPU2VVVC9Ga3RnU3VWYUJSbVZtckxiaDJVdmtUejN1cytkVmhIaEd6?=
 =?utf-8?B?WFExUUYrbVdySHF3dTFEcFFQT1NsajFjVU9yaGxmOUpRbVk0b3NxeDI5VTV0?=
 =?utf-8?B?TkYyK1JHZ0xJRnNhd01MK3hkQ3ZHcEQwS2s2SWo0bDdCOVFITkU1Y3hrdEtl?=
 =?utf-8?B?ZTFvamtVM3pnZi8wb1pabDl2Qm1kY2JoOUp4dlo5a2ZOT1RVbHlGblBGTlVC?=
 =?utf-8?B?NDdzL0o3K3NqVFBHa2JPSWd1OWw2emhkL0xQa2hDWnVCU0FkS0o0a0U5YWdn?=
 =?utf-8?B?S1Z5S3JTUzN2bnJuNUhDS1V1SEZNQTBPeVh3MHRsa3hsbkJGZ04vUUZ4ZndR?=
 =?utf-8?B?Kzh5blVWNFQrNnZsVVdpWitFTmY3NmpkSERhOG95YXJ4Mk41Nk9Cdml4SzVU?=
 =?utf-8?B?YUkwbmlJRCt2ZmREN1dqWkh5YnFtYkdPeStMSlhJa1o1RjA4TEc3cGwvUVhQ?=
 =?utf-8?B?aFd5czZsNnJpSGFtUG9qT01qanlGa0EybHhyaVd0TzhsV3NyM243OXhtQk15?=
 =?utf-8?B?ekphUWNEbHNOb3g0NWlaZE9TcFdDcWRFeUZWNlhUUk82cTR6KzNqMW40SDZx?=
 =?utf-8?B?RFFob3J1VnppR1ptRHF0Z285ZDNjK1pNZS9zWVUwLzJjS3VtdTl0cW1DeWp1?=
 =?utf-8?B?alcyZ1N4ZG9wK2liWlV3MkNKR2M4STNoWFNMMUFOdHNNTG1WcW90K2FNSnlO?=
 =?utf-8?B?NmtRb1RQRGVoaWo5ZjFTTW9JbHJTUW40MlFNNEx6K1hqWTY5b2dtbzhFZW5J?=
 =?utf-8?B?K1kvZzhTZnBhMVNLeE1FSzBwV3JLaDBld1g2c1phN3NYZWFQVGtZNk43SFJJ?=
 =?utf-8?B?NVNxTTcxZFBWRVMwRllwNnZIM3o1ckhOemxtdWVEWW8xc2sweDJJbGFjRVNv?=
 =?utf-8?B?SGdPL3RtbW5ZbGFXMDJZQk5FK1Qvak5MNkhFS3BhMVdnV2pqVFVQZ2hSMk44?=
 =?utf-8?B?a3crZ2svYllmZC9TMEVtMEM0OXlud1p2bld4Ry9QRi9TQzltbEZPTHJEbGRC?=
 =?utf-8?B?d1pGb2RvdkNJbjladVlHZFd4QTVoQmNRTklQb05xZHBic0dDRit1ZEczeDAy?=
 =?utf-8?B?dmRDTzVLblVOOUZwbHdjZGQyam1JWXVOZGRnVlZzVUJobWsrK0VsNm45VHdY?=
 =?utf-8?B?bXhuU2w2c0RtVWhDZytreTBob3FsTGJvRUEzL0JMdWhpMERsMW5nS1FxWDNt?=
 =?utf-8?B?bzJaU05rN2lQajRoeU9IU25TbC9GSmNEUFpEN1JHM1ZFZHVVa3NwRS95aFNz?=
 =?utf-8?B?ZGo2d3RSM0ZWaXVJb3ZUUEY4enNtR1p2UmN3Y1Mrc25EQ3Y2M2pMZHpuNVFT?=
 =?utf-8?B?cnA3eSsyU0YycCtwakQ4SjJJS0ZLSzVLMWpTand1K0d3VHAydWIvT1htbUdE?=
 =?utf-8?B?bUxUSFVQYUlFejJ2M1BOODRtSk5WK0t5ckd2M1VweFMzWll2amlmYjVHK2oy?=
 =?utf-8?B?OXlzM2ZmL0lpN2Q4ZmUzbmRzYktiVHhwUk5BVTBCdE1WNHNNNGY0TTRHOTh2?=
 =?utf-8?B?cDlaZjNYYnAzbUxGQTF6eDVnbEpUODNaVkJEL1R5RHdZc1E4SmlEZkVYbWZL?=
 =?utf-8?B?aVh1L2pNOVIxYmtuNzcwMTBEU3ZHZjRndTlKcFZZWXVlNllVcjMvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9188efff-04f2-485b-ce8e-08de7e19e89f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:24:47.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqfpRI4/ehA07z7JLr1ce+jnkyb1//WkEfkcFbwZiogO1tF68xQgdtOXnQ5d6lJM9gVBMvlsWtk7MnwmA5EwjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
X-Rspamd-Queue-Id: 0C0D1240CF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmx.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-21569-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pnirujog@amd.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action



On 3/9/2026 12:01 PM, Rafael J. Wysocki wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Monday, March 9, 2026 1:23:35 PM CET Rafael J. Wysocki wrote:
>> On Mon, Mar 9, 2026 at 12:58 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Mon, Mar 9, 2026 at 9:11 AM Du, Bin <bin.du@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/9/2026 11:52 AM, Nirujogi, Pratap wrote:
>>>>>
>>>>>
>>>>> On 3/6/2026 7:45 AM, Mario Limonciello wrote:
>>>>>> Caution: This message originated from an External Source. Use proper
>>>>>> caution when opening attachments, clicking links, or responding.
>>>>>>
>>>>>>
>>>>>> On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
>>>>>>> On Fri, Mar 6, 2026 at 1:35 AM Mario Limonciello (AMD) (kernel.org)
>>>>>>> <superm1@kernel.org> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
>>>>>>>>> Hi Rafael,
>>>>>>>>>
>>>>>>>>> In kernel version 7.0-rc2, the AMDISP device reports the following
>>>>>>>>> errors when created via mfd_add_hotplug_devices.
>>>>>>>>>
>>>>>>>>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
>>>>>>>>> no  post: no)
>>>>>>>>> [    5.236744] input: Video Bus as /devices/
>>>>>>>>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/
>>>>>>>>> input21
>>>>>>>>> [    5.236779] acpi device:14: Error installing notify handler
>>>>>>>>> [    5.236782] acpi device:15: Error installing notify handler
>>>>>>>>> [    5.236783] acpi device:16: Error installing notify handler
>>>>>>>>> [    5.236784] acpi device:17: Error installing notify handler
>>>>>>>>> [    5.236785] acpi device:18: Error installing notify handler
>>>>>>>>> [    5.236786] acpi device:19: Error installing notify handler
>>>>>>>>> [    5.236786] acpi device:1a: Error installing notify handler
>>>>>>>>> [    5.236787] acpi device:1b: Error installing notify handler
>>>>>>>>> [    5.236788] acpi device:1c: Error installing notify handler
>>>>>>>>>
>>>>>>>>> These failures indicate AMDISP device is incorrectly detected as ACPI
>>>>>>>>> Video device while it is not.
>>>>>>>>>
>>>>>>>>> The seems like a regression caused by the change that converts the
>>>>>>>>> ACPI
>>>>>>>>> video device to a platform device (commit: 02c057ddefef5).
>>>>>>>>>
>>>>>>>>> Issue is not observed in 6.19-rc6, and also when this change is
>>>>>>>>> reverted
>>>>>>>>> in 7.0-rc2.
>>>>>>>>>
>>>>>>>>> I really appreciate your inputs on addressing this issue and
>>>>>>>>> helping us
>>>>>>>>> make progress on 7.0 rc2.
>>>>>>>>>
>>>>>>>>> Steps followed to reproduce the issue:
>>>>>>>>>
>>>>>>>>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
>>>>>>>>> 2. Add NULL check for “dev->type” in isp_genpd_add_device() [2] (to
>>>>>>>>> avoid kernel panic found in v7.0-rc2)
>>>>>>>>> 3. Build kernel with:
>>>>>>>>>        - CONFIG_AMD_ISP_PLATFORM=y
>>>>>>>>>        - CONFIG_VIDEO_AMD_ISP4_CAPTURE=m
>>>>>>>>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
>>>>>>>>> 5. Boot system to see the failures
>>>>>>>>>
>>>>>>>>> [1] https://lore.kernel.org/all/20260302073020.148277-1-
>>>>>>>>> Bin.Du@amd.com/
>>>>>>>>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/
>>>>>>>>> amdgpu/isp_v4_1_1.c#L132
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Pratap
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> It's a bit weird to see it even probe in this path in the first place.
>>>>>>>> acpi_video_bus_probe() getting called with the mfd device doesn't seem
>>>>>>>> right to me.
>>>>>>>>
>>>>>>>> I wonder if it's because ISP is an MFD device of GPU (and thus LNXVIDEO
>>>>>>>> ends up matching).
>>>>>>>>
>>>>>>>> Would a sensible solution be to reject mfd device types in
>>>>>>>> acpi_video_bus_probe()?
>>>>>>>
>>>>>>> Every platform device with LNXVIDEO in the device ID list will be
>>>>>>> matched and so probed.
>>>>>>>
>>>>>>> I'm wondering how those devices get that ID though.
>>>>>>
>>>>>> Yeah me too.  I was surprised an MFD device got it.
>>>>>>
>>>>>> Pratap - can you figure this out before we go too far in this path?
>>>>>>
>>>>> yes, MFD child devices in this case have the device ID as that of parent
>>>>> (GPU) i.e. LNXVIDEO. Its because when no acpi_match is specified, the
>>>>> MFD child devices are inheriting the parent's ACPI companion device and
>>>>> this is resulting in having the same parent's ACPI device ID.
>>>>>
>>>>> device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
>>>>> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L91
>>>>>
>>>>>> If they really shouldn't have LNXVIDEO fixing that may be a better
>>>>>> solution.
>>>>>>
>>>>> AMD ISP related MFD devices are using the same LNXVIDEO device ID even
>>>>> on 6.19-rc4, no issues observed earlier. I can confirm automatic AMD ISP
>>>>> device probe works and also camera works on 7.0-rc2 if I avoid
>>>>> inheriting ACPI companion of the parent (GPU) in the mfd-core.c
>>>>>
>>>>> // device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
>>>>> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L91
>>>>>
>>>>> But why this is an issue on 7.0-rc2 while it works on 6.19-rc4 needs to
>>>>> be root caused.
>>>>>
>>>>
>>>> Possible cause may be.
>>>> 1. On 6.x (without commit 02c057ddefef5), the ACPI video driver was
>>>> registered as an acpi_driver (static struct acpi_driver acpi_video_bus)
>>>> ,  it lives on the ACPI bus (acpi_bus_type). It only binds to struct
>>>> acpi_device objects in the ACPI namespace. MFD children of GFX
>>>> (amd_isp_capture, amd_isp_i2c_designware, amdisp-pinctrl) are platform
>>>> devices on the platform bus, they are completely invisible to
>>>> acpi_driver, so there is no chance of the ACPI video driver matching an
>>>> MFD child.
>>>> 2. On 7.0 (with commit 02c057ddefef5), the ACPI video driver was
>>>> converted to a platform_driver (static struct platform_driver
>>>> acpi_video_bus), it lives on the platform bus. When the kernel registers
>>>> a new platform device, it checks ALL registered platform drivers to see
>>>> if any match. The matching logic for acpi_match_table works like this:
>>>> - Get the platform device's ACPI companion (ACPI_COMPANION(dev))
>>>> - Check if the companion's HID/CID matches any entry in acpi_match_table
>>>> - If yes, the driver probes the device
>>>
>>> It does, but then the probe fails.  This is the problem that has been
>>> reported to start with.
>>
>> I guess I know what's going on.
>>
>> Every device that shares an ACPI companion with the ACPI video bus
>> device advertises itself as "LNXVIDEO", so udev looks for a module
>> matching that device ID and since the ACPI video driver is loaded, it
>> will not attempt to load anything else.
>>
>> It may be viable to use an auxiliary device for ACPI video bus device
>> representation, let me have a look at that.
> 
> So appended is a patch that works for me.
> 
> Please test it and let me know if it helps.
> 
Thanks Rafael. With your latest patch, acpi_video_bus_probe() is no 
longer called for ISP MFD child devices, which is good.

Tested-by: pratap.nirujogi@amd.com

However, automatic modprobe of ISP MFD devices is still an issue. This 
requires additional changes outside acpi driver (either in amdgpu or 
mfd-core) to fix it. We'll submit a separate patch to address this issue.

Thanks,
Pratap

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] ACPI: video: Switch over to auxiliary bus type
> 
> Commit 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> switched over the ACPI video bus driver from an ACPI driver to a platform
> driver, but that change introduced an unwanted and unexpected side effect.
> Namely, on some systems, the ACPI device object of the ACPI video bus
> device is an ACPI companion of multiple platform devices and, after
> adding video_device_ids[] as an acpi_match_table to the acpi_video_bus
> platform driver, all of those devices started to match that driver and
> its probe callback is invoked for all of them (it fails, but it leaves
> confusing message in the log).  Moreover, the MODULE_DEVICE_TABLE()
> of the ACPI video driver module matches all of the devices sharing the
> ACPI companion with the ACPI video bus device, so registering them does
> not cause any other modules to be loaded, so they are only probed
> against the ACPI video bus platform driver.
> 
> To address this, make the core ACPI device enumeration code create an
> auxiliary device for the ACPI video bus device object instead of a
> platform device and switch over the ACPI video bus driver (once again)
> to an auxiliary driver.
> 
> Auxiliary driver generally is a better match for ACPI video bus than
> platform driver, among other things because the ACPI video bus device
> does not require any resources to be allocated for it during
> enumeration.  It also allows the ACPI video bus driver to stop abusing
> device matching based on ACPI device IDs and it allows a special case
> to be dropped from acpi_create_platform_device() because that function
> need not worry about the ACPI video bus device any more.
> 
> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/acpi_platform.c |    2 -
>   drivers/acpi/acpi_video.c    |   45 ++++++++++++++++++++---------------------
>   drivers/acpi/scan.c          |   47 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 70 insertions(+), 24 deletions(-)
> 
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -135,7 +135,7 @@ struct platform_device *acpi_create_plat
>                  }
>          }
> 
> -       if (adev->device_type == ACPI_BUS_TYPE_DEVICE && !adev->pnp.type.backlight) {
> +       if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
>                  LIST_HEAD(resource_list);
> 
>                  count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -9,6 +9,7 @@
> 
>   #define pr_fmt(fmt) "ACPI: video: " fmt
> 
> +#include <linux/auxiliary_bus.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/init.h>
> @@ -21,7 +22,6 @@
>   #include <linux/sort.h>
>   #include <linux/pci.h>
>   #include <linux/pci_ids.h>
> -#include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/dmi.h>
>   #include <linux/suspend.h>
> @@ -77,8 +77,9 @@ static int register_count;
>   static DEFINE_MUTEX(register_count_mutex);
>   static DEFINE_MUTEX(video_list_lock);
>   static LIST_HEAD(video_bus_head);
> -static int acpi_video_bus_probe(struct platform_device *pdev);
> -static void acpi_video_bus_remove(struct platform_device *pdev);
> +static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
> +                               const struct auxiliary_device_id *id);
> +static void acpi_video_bus_remove(struct auxiliary_device *aux);
>   static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
> 
>   /*
> @@ -93,19 +94,16 @@ enum acpi_video_level_idx {
>          ACPI_VIDEO_FIRST_LEVEL,         /* actual supported levels begin here */
>   };
> 
> -static const struct acpi_device_id video_device_ids[] = {
> -       {ACPI_VIDEO_HID, 0},
> -       {"", 0},
> +static const struct auxiliary_device_id video_bus_auxiliary_id_table[] = {
> +       { .name = "acpi.video_bus" },
> +       {},
>   };
> -MODULE_DEVICE_TABLE(acpi, video_device_ids);
> +MODULE_DEVICE_TABLE(auxiliary, video_bus_auxiliary_id_table);
> 
> -static struct platform_driver acpi_video_bus = {
> +static struct auxiliary_driver acpi_video_bus = {
>          .probe = acpi_video_bus_probe,
>          .remove = acpi_video_bus_remove,
> -       .driver = {
> -               .name = "acpi-video",
> -               .acpi_match_table = video_device_ids,
> -       },
> +       .id_table = video_bus_auxiliary_id_table,
>   };
> 
>   struct acpi_video_bus_flags {
> @@ -1885,7 +1883,7 @@ static void acpi_video_dev_add_notify_ha
>   }
> 
>   static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video,
> -                                            struct platform_device *pdev)
> +                                            struct device *parent)
>   {
>          struct input_dev *input;
>          struct acpi_video_device *dev;
> @@ -1908,7 +1906,7 @@ static int acpi_video_bus_add_notify_han
>          input->phys = video->phys;
>          input->id.bustype = BUS_HOST;
>          input->id.product = 0x06;
> -       input->dev.parent = &pdev->dev;
> +       input->dev.parent = parent;
>          input->evbit[0] = BIT(EV_KEY);
>          set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
>          set_bit(KEY_VIDEO_NEXT, input->keybit);
> @@ -1980,9 +1978,10 @@ static int acpi_video_bus_put_devices(st
> 
>   static int instance;
> 
> -static int acpi_video_bus_probe(struct platform_device *pdev)
> +static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
> +                               const struct auxiliary_device_id *id_unused)
>   {
> -       struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +       struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
>          struct acpi_video_bus *video;
>          bool auto_detect;
>          int error;
> @@ -2019,7 +2018,7 @@ static int acpi_video_bus_probe(struct p
>                  instance++;
>          }
> 
> -       platform_set_drvdata(pdev, video);
> +       auxiliary_set_drvdata(aux_dev, video);
> 
>          video->device = device;
>          strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> @@ -2068,7 +2067,7 @@ static int acpi_video_bus_probe(struct p
>              !auto_detect)
>                  acpi_video_bus_register_backlight(video);
> 
> -       error = acpi_video_bus_add_notify_handler(video, pdev);
> +       error = acpi_video_bus_add_notify_handler(video, &aux_dev->dev);
>          if (error)
>                  goto err_del;
> 
> @@ -2096,10 +2095,10 @@ err_free_video:
>          return error;
>   }
> 
> -static void acpi_video_bus_remove(struct platform_device *pdev)
> +static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
>   {
> -       struct acpi_video_bus *video = platform_get_drvdata(pdev);
> -       struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +       struct acpi_video_bus *video = auxiliary_get_drvdata(aux_dev);
> +       struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
> 
>          acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
>                                         acpi_video_bus_notify);
> @@ -2163,7 +2162,7 @@ int acpi_video_register(void)
> 
>          dmi_check_system(video_dmi_table);
> 
> -       ret = platform_driver_register(&acpi_video_bus);
> +       ret = auxiliary_driver_register(&acpi_video_bus);
>          if (ret)
>                  goto leave;
> 
> @@ -2183,7 +2182,7 @@ void acpi_video_unregister(void)
>   {
>          mutex_lock(&register_count_mutex);
>          if (register_count) {
> -               platform_driver_unregister(&acpi_video_bus);
> +               auxiliary_driver_unregister(&acpi_video_bus);
>                  register_count = 0;
>                  may_report_brightness_keys = false;
>          }
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -6,6 +6,7 @@
>   #define pr_fmt(fmt) "ACPI: " fmt
> 
>   #include <linux/async.h>
> +#include <linux/auxiliary_bus.h>
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/slab.h>
> @@ -2192,6 +2193,46 @@ static acpi_status acpi_bus_check_add_2(
>          return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
>   }
> 
> +static void acpi_video_bus_device_release(struct device *dev)
> +{
> +       struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
> +
> +       kfree(aux_dev);
> +}
> +
> +static void acpi_create_video_bus_device(struct acpi_device *adev,
> +                                        struct acpi_device *parent)
> +{
> +       struct auxiliary_device *aux_dev;
> +       static unsigned int aux_dev_id;
> +
> +       aux_dev = kzalloc_obj(*aux_dev);
> +       if (!aux_dev)
> +               return;
> +
> +       aux_dev->id = aux_dev_id++;
> +       aux_dev->name = "video_bus";
> +       aux_dev->dev.parent = acpi_get_first_physical_node(parent);
> +       if (!aux_dev->dev.parent)
> +               goto err;
> +
> +       aux_dev->dev.release = acpi_video_bus_device_release;
> +
> +       if (auxiliary_device_init(aux_dev))
> +               goto err;
> +
> +       ACPI_COMPANION_SET(&aux_dev->dev, adev);
> +       if (__auxiliary_device_add(aux_dev, "acpi")) {
> +               auxiliary_device_uninit(aux_dev);
> +               goto err;
> +       }
> +
> +       return;
> +
> +err:
> +       kfree(aux_dev);
> +}
> +
>   struct acpi_scan_system_dev {
>          struct list_head node;
>          struct acpi_device *adev;
> @@ -2229,6 +2270,12 @@ static void acpi_default_enumeration(str
>                          sd->adev = device;
>                          list_add_tail(&sd->node, &acpi_scan_system_dev_list);
>                  }
> +       } else if (device->pnp.type.backlight) {
> +               struct acpi_device *parent;
> +
> +               parent = acpi_dev_parent(device);
> +               if (parent)
> +                       acpi_create_video_bus_device(device, parent);
>          } else {
>                  /* For a regular device object, create a platform device. */
>                  acpi_create_platform_device(device, NULL);
> 
> 
> 
> 


