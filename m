Return-Path: <linux-acpi+bounces-20636-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBtMOQTzd2npmgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20636-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 00:04:36 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8208E22D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 00:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C4AC301B718
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1348430BF60;
	Mon, 26 Jan 2026 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VFABrH+5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6E2E62D1;
	Mon, 26 Jan 2026 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468607; cv=fail; b=CL+JX2dvRC6jz658gaXR3aPfAEmxeMRjwkgYnjYxeuxapFOrzOUbIn9DUeoAEwyfPVe5j7og7u5K7B8jVlOblR85FGfdLXll+cVn5JVotl+03mEspnNdHItOm7ahNMmLSI9AoqkLWr4hvZcgY4HDUFngwJevBcej0qNXp8RLI3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468607; c=relaxed/simple;
	bh=GyoNOR+4uFnHI0CdjAPOQ5ux2AOxPiGq9fMzlo36VOI=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=KmChWWAQGL7wsm3eStM0KMLCbktuj2Qsw6gdDg6YN8ubT+YRR/xAu75rjt0wg4blmOfV2D0T+elsf1jh/ymy4xHOuh08j3Z9VGNPxewf8EMJMk3n5U2kD383JrpBrjC+NS7+pGi4PLlPdLoomkGWj8MXZye7rU9utdQQJeYiDU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VFABrH+5; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEaYABMBuKaJFIFpeKS+OsCydr44dl7jOC9GzcMNSb3LfWkbBMeLIIOKGj1Qjf++2INg+ODyqowSZwtHy3one9vuyNMgLy/T19LZjxbHACjFFPsb2k1KLkAaIiUu+FIaqUG2Kq/jg3r2SkAuA6A82wSvc45pbH3+o2sA2ujNTBP8V25H4bP6wV8Ztfzu4e/oqxlKu3Zfir4tpwdZqcIwl8pjLJ9mlPqKWU6Z1q1eF/yUtCA9BOJTve7MouRu2PfnpuOGmNGWjwfJ/BQEJ1SwcofdQaJ/boI6ReUo445ZaGs/KKiIcdm07VjloYiVu7G+JpicN3ge6462U4LAR4n0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99rg1+Jk8bDZ1nuNbT76CYorV+g58E/4jjia05S4kTs=;
 b=tZhzWy2bREjy2d7O2w9ifABpxvud6eMVXf5/OWFr/+unL6jtsfFHQO68OktyQiBYCTOQYAvZ9HUei/cvQOpqzCVnkbjeZlUQldUWgzGvidcL+a10jq3P8/Grkbv4477KLunmeNKFIRTUhGyJcXy57ik3IdURLFIC7x/hu6eHRAtXhLFk1K6USZ1dZFOaAcgtY8CuLmVzpjsx5PBnXvgnzjFvZgztNUFevptECtiST8ihLKBDp+SsjSVBHSDTtQXcMdNdm3/xpDL6eKZ0VXeO4fWQ0B8xiXxRXp6uJE7jyTS/b+V4jiBIctS5OYkUOuSK6/0o1lj08CB5HDpM1LkXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99rg1+Jk8bDZ1nuNbT76CYorV+g58E/4jjia05S4kTs=;
 b=VFABrH+5tndOZZ1maG9ZEsK7Rpxm3WRr74didzK//TObQ/cw9+w2R7fubhJJtCoHs64xdIGbgWRUSCodb0mHLRCDyJ06qaKChEXDkEDsk34d7I1v9qgHQ/ka7svsTFJ5dILiktTQUId0KomBu1VmUMsGvAxznNAq7fzW3NE33OZr0Lh46V1D8o0OKNOn7Zi5jmvTn+B+Fata0uCqXTLbe90aYrNgs/8vUCKQGlBRpND47C9k4dYVDxx6N+BAi+GcynsDr5YlDK/s66pqZljyx6IWZ+muyqhNxhWj6s7n+4988dyWNQprTqJaUOidY4mnQ6cYQwUn+UGsC6gEXDqRLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 23:03:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 23:03:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 27 Jan 2026 07:02:53 +0800
Subject: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com>
X-B4-Tracking: v=1; b=H4sIAJzyd2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNz3dzEzJyk/ArdMkNdQxMzw+QUI0tT07RUJaCGgqLUtMwKsGHRsbW
 1ALN9u5NcAAAA
X-Change-ID: 20260127-mailbox-v1-1461cd2955fe
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>, 
 Yuntao Dai <d1581209858@live.com>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, mailbox@lists.linux.dev, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: da43cec6-da50-4b70-c133-08de5d2f1aaa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2I2cFlLNzdWREFmKzhYRTNMcHg4Uld2Y2UwM1J0Z2Iyei84OFFTNmxKUUQ3?=
 =?utf-8?B?ZmxaR01nVHRpQW8vSXByczJLaCtsUEpDWkp1WUtDNi9qbktRWWZRN1ZRWjhT?=
 =?utf-8?B?MFRoV016aGNaT1UydVlQZ29lbG5rNkhSNXFMdFJxeTUvR0VsRGhHMjVsdXg0?=
 =?utf-8?B?RDF4cWplMXkxVVlOZVRVb01WVktNYVVhWEpWQWg5ZXE1VmlnZktodTczQlor?=
 =?utf-8?B?OVJPNWlUcXhNcmQya29sRVpqaG9BTG05NFkrQm5wOGg5dWNXOG9FZ0lNYkts?=
 =?utf-8?B?bGFLZ1dmMDVWdjdFR0lXSFdiYTVyV3dsSlM2ZGtiK3BnQjVwVHlFWmN5WnA2?=
 =?utf-8?B?MzljbHhObTRLMjc2T21FNC9CSzJYc2pvaDNsR2ZBNXZrb0oybnJFMjJmMFFi?=
 =?utf-8?B?SW94S1JIVktvM3BaelNma3BhbEV6U0gwcmcvb2tnbEx0K3BxUkhjWlMvZUJO?=
 =?utf-8?B?MFQ3Z0hydFdVTGs1RDlMNTBUY2YzaHRTRDRFMEtjZHFUbk5JM2wxWC9YNjN1?=
 =?utf-8?B?MzRwTCtVK2c3Q1J1cU9jRmEzZGhwcjl2VFMxRCs3bi9VZzZxaFcvZjlvYVQ1?=
 =?utf-8?B?a2V0MUg4R1QyNHJBajFLTjlhQkRjK1g4c1JYWDhkbjcvYnR2eFFBajJQMnJM?=
 =?utf-8?B?MUlyQTJMQWNacE5FU1hmMHFvRkNDZFVyR2ZacDViUmxvSTVOdlhDbGlCbWdI?=
 =?utf-8?B?bmJPSU96Wk5LN1FKWWUzZFVSbEYvOXAwNytRZExKNHpIUDh0SW5ranJjN1Fm?=
 =?utf-8?B?aDBZbzAvNUZ6bmx5dnJGaFo1TFZzMW92bkR3MGR1aEN0eHZveW5aeEdIOVQy?=
 =?utf-8?B?c1pLUW5FbS9RR3pBc1NiSFcyTEovMHBVcnZFTVp5RFZmZ0VMczdsNE01bmVo?=
 =?utf-8?B?Qm1zN0NjMG1SM0NJZlNsOTNBajBWSGRnc0JNY3o1RWczalBXNERwd0ROdHZ5?=
 =?utf-8?B?eFlRWjFJeG03YXJ6bU5FMFlkT09NWFQ0Qkp4UEp6R25FK0ZqTE41aU5IaktQ?=
 =?utf-8?B?R0xCZkc0djJ3MzlDQStnZ2kvRDJ4M2JjZmRYNi9RRVYySzFKZjdLbEdTVUJl?=
 =?utf-8?B?TGtITFlzQ2VpN1hVVmIxTEdNTGRtT1pVRXBwQ2t5VmtyUmxqai9jaWFlcXB4?=
 =?utf-8?B?YU41YU0ySWhUTlBLOVlKUnFhYnVyLzdJbWNDM1FYcE9Zak8rVmxmaGorYWVw?=
 =?utf-8?B?U2JqbTBpbzRFUDNOTjBSWUgxdlJUR2pCczNpWEcxYjFzQVFjMytKdURJVWZl?=
 =?utf-8?B?Y1Joa0Z2RTNxZWNjNFhVekVsVXR1R0ZpaStrbk9UL3F2LzF4bXRPOFVTc1cr?=
 =?utf-8?B?RU5DZGozOEkxVDRWMmczVTNkM3I1eThhRU4yYkNJbXY5c29NRjMvUGRZVUlm?=
 =?utf-8?B?cXpzTXlyMVYyK0c3bVNQcklQNlFoRWZJbjFXTG9INzVtaXB4RW5KNW9wRUxR?=
 =?utf-8?B?d0ZvWFJEdzl5YVFSSTJ5emc3aVpmZVpQdVA3WmM5T3pYR2ZFc2xGdlZQWTlM?=
 =?utf-8?B?K21DajArbElRRUdJeXN3N2J0cFRGSXhWejl5VUhyclJTSjFKelI3MXhqdmp3?=
 =?utf-8?B?VEpLc1hWUEhiSVEyYjhZcFVHU0sycExFeGc2UEdTRVpxR1NnMFNhTVZRcjFm?=
 =?utf-8?B?bWFPVDFaWDh0Q2ZVZFRsQTBoTVA0dlpLVHN6b2JrVXJPSG80ZE5iZEVGL1pD?=
 =?utf-8?B?MndudERNcXRuTEU4NXpROWFYZGhISGEyMUNXVHRubzVNZmJ1eEZKYnBCaVdp?=
 =?utf-8?B?Z1VabWpmMUFOdGQxMTZOUHF6dGZGVVhBeUdweVFKWDIyMUpQa3FiVEZ0RkhY?=
 =?utf-8?B?aHJkcWFxTGM3bkJxNXJEaFNOUEJXNFFpdUZiR1JqNUFUYStQRmI1UmRVcUNL?=
 =?utf-8?B?ZWlwOFBFcU82ekxKSGJsUDZ2VWhxQ0xtSTJLYktYSHpmYVBRSDdZd3MwUFRY?=
 =?utf-8?B?ZkFIZVk2RlJTajdoNjlLUWJ1QjVpTGlra3pzUEQwK2VJbmllQWlUeGhsR2Mr?=
 =?utf-8?B?MDNsRWYxQkJqemlOeFFSN0dtSEhoZDQyVXhIRExpNjdybU9iNFcvOUE4Qmow?=
 =?utf-8?B?TEg3Qjc0aVF1cFladkU2UDdkZGNhKzNZMTFNQ3dMbjlYUGdFUnpITlB4NitP?=
 =?utf-8?B?Y2ozTEFQME05N05VOFRHVmFINDRzWTFpZU5TNVFOSFM1NkFuRURncHRZaFlz?=
 =?utf-8?Q?LcHlvs6pYkkmEe8X8K0r0os=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlTOHFNK3JDMU9BeWxmalduVCtoaWhVVXc2MUc5Y01EWUZjWlRtVXVOcy9I?=
 =?utf-8?B?Q1ZDZy90LzY4aDhOUXFTQ055cTIxZVkzSVdKUzIyWXNEeUthT21vWlhXVG53?=
 =?utf-8?B?aVpqTXVpdVRrRUFNT0g3SzhHMVVTZDRXaW9TT3RKdzMrem52dlVITFhHOGVv?=
 =?utf-8?B?L1NsZWtCN0NjWjlpa3hCVlh2NU01MkMyUkNkWldwV3ovMHZEZTlDckhCd0tZ?=
 =?utf-8?B?UXhDUVIyYzU4RkQ5aDYya3AxVXZkZ0RQcXVuV3lYdXhEMjMvd1VSNUVQYTY2?=
 =?utf-8?B?bWduR1BTV2pYRkNNbExUVXhleXQrNFUvUHdiVFhrZGw2ZjdBS04vYlRUajNS?=
 =?utf-8?B?cVpmSWZnL1habzZ0a0NxeGVhUlA5a0w0Ti9YcGhNcnFrWmVyRWZRbCtXa0N3?=
 =?utf-8?B?MHkya0dwRVlJeEM3bVRFYXg4L2pBU00yMVczMVlsTjBSS0JGZUdBRjE1eFo5?=
 =?utf-8?B?aE55UFlVdGllbUhZN05FZXEyeTd5UkdPWElzcTF4dFZMZXE4WVFiZjdlakJF?=
 =?utf-8?B?alZZWU9IRlpRRXZsM2RSWU95dlBBVEpjWUhuVTI2clVMb1JRUG1xMXhBY1pB?=
 =?utf-8?B?L1BZR08vRll2WWhad3NlVjhqS2JXdjhKTm53azZtTTMrM2RqU0hISkhqMHpN?=
 =?utf-8?B?STZTRFlmaFJzMXZKYzI2bHUrYVBPR0p4c01lNVJxYUpQcGZ3YWJFQm4weDcv?=
 =?utf-8?B?TElHUWVEcGZ0MDZZWndiRGZ4RHFESHBhc0ovczlKQUY5TU9BVEVwa1YvOEtH?=
 =?utf-8?B?VGdFK3IrbGx5aStFSFEyZGdKUTI4YUkzWHB2d1poeEJjS2pkamJSSXZISXl3?=
 =?utf-8?B?alp6dk1lWkxNeEtSMTEyVlF0RFpxN3BsM1diMGNLczJkYkFUZEFHN0czRDhY?=
 =?utf-8?B?S3d3VTZOL1N4cWJpVE1pQjJ2Z0E1cXhPOHp3SXEzTmxwbzZHZnJZVm1Vei93?=
 =?utf-8?B?d1FvWGxaNTZoejdkMjA4eXBvY0JLRm9QOExvK3JaU25nZVNPL1pxclU3MFNY?=
 =?utf-8?B?T29mdWVMUWkvK3JlclJkSWZhaGVrUjB1TXpMVWJuZWVqWXl1Ry9NMHdhNFgr?=
 =?utf-8?B?M3Jxb1ZhV2ZBZWZsQXk3Ukl4UDZmbHJpU2w4UlNER0pVeWEyZWhKWDNMQVFk?=
 =?utf-8?B?OG1uaG1aOHR2L2VUY0NrTTl3NERHbUJJUVJQTnQ4VDFKOVZyclhmY3JQM3pv?=
 =?utf-8?B?YXZnTiswOWJDR0FxTjVHSHVPT0NJb01iRnVHbjRHSXZ1RmhYdGRpeEhKYy9X?=
 =?utf-8?B?WG5hd3czeXlZMkRPeEhtRitjUkF3bDYxZ3JoUEllZElTenRkdlEvWWl2dmw3?=
 =?utf-8?B?NXpOaXhPcHZVMWF1bk9rMkEyWHV3Ykl4ekVLOTJYWXBzR2JRWG5hZ0ZiV2Uy?=
 =?utf-8?B?L0ROWW0wL0h4bTNkc3NVL2tZaWk5VERGcW5HcnVqdTlLTDhIUGltVTErc242?=
 =?utf-8?B?TDdrWjZ3NGpNYUV0alZrckdMeExSTTdMdjZXZ2lrVFQwdmFGajNXN1R5TnBK?=
 =?utf-8?B?S1JQWHNJWVVpaUJNL09SSVZjOWpOUTgzWUp5S3JoOVVkRnR3TW1Kd1BQUFBr?=
 =?utf-8?B?V291ZVFUWU9BVjcxdTc0aGoyR2ZKZGgvUFgvb0pKZVEwWVFLZURFRXFXYVRX?=
 =?utf-8?B?ZjBhZEdJNkFlS0VZQlpDc3VqdFJwNXBlM2JoZlIyTmJPVVZUT2tMWThNMzB3?=
 =?utf-8?B?cnFrTW81MEFYU1ViWWEwN28rU2Y0dFVVZk94TkhjUzlwZVUxUWZqN1ZmVml3?=
 =?utf-8?B?VXNyV2hPb3ZSdFludTdUd21TM0tjQTVzYnZXc0phL0dOMTRzT0pxY2tjekZ5?=
 =?utf-8?B?OUQ3bVpibFpMUnA0TEVMNE1GZ2h2MnhmdlVnTERZN2RNeXhqYlpPVGpZU2lH?=
 =?utf-8?B?eldROERaY1E3VFp5WGd3Tml4S3Zka0R1OExDSVRXVXhlY1JaRUp1UWlqa29z?=
 =?utf-8?B?S1NEc3dhc1ZjNExGNUVLV25KaEptZFVGbWYyZ1laSzhrVDA2UmhGbHI3ZXQy?=
 =?utf-8?B?Vmd6RHJTSHczRDZ1dGNjRE53ZEl4YVdWZ3V1OE5XN0M1eGVtNUlSZTNSZlM5?=
 =?utf-8?B?VHQ5YkkxTFlWaWV1cEZtanlDRWhtTU43NDI5Nk5NbWpWejBGQkRTYWJ6blk1?=
 =?utf-8?B?ZWNMeTVRQkEvM3BvWHBRdFMwVExmRndiMDQ1TS96TWRGT1dYTldRVjUrTzVB?=
 =?utf-8?B?WGtvQjgwK1BEWWFEeWZyalE2ZkQzUHdML2NvVDB2L1p3eVNXSitvQmtHRFpn?=
 =?utf-8?B?WkN1SnpxYmszVXp2Zk9NbWxNdzRUR0NrSmxBOTN5TVFJUDJ0WWcxRGFDdS9Z?=
 =?utf-8?B?b0tlK0w2Q0Z3WUxsN29naW1nTW9HV0hUUFpqQlYzV2FMZ01uMVJuZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da43cec6-da50-4b70-c133-08de5d2f1aaa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 23:03:22.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYXemu9pRx9mEf/sjpwwCpolUeItSZNeNQsOvWNukUT8Ki+Mf9m6NiZclQTUWSNoVgBKbbxxNAaPTfWNlzgJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20636-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,arm.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,live.com,vger.kernel.org,lists.linux.dev,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 3D8208E22D
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

mailbox_client.h is should be used by consumer drivers, not mailbox
provider.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
 drivers/mailbox/cv1800-mailbox.c     | 1 -
 drivers/mailbox/omap-mailbox.c       | 1 -
 drivers/mailbox/pcc.c                | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 41f79e51d9e5a92089a3fd798e848d837fb2775a..5d278bb5a4c0635dfc46b4a6dc3addf0b3b5d1be 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
-#include <linux/mailbox_client.h>
 #include <linux/mailbox/brcm-message.h>
 #include <linux/module.h>
 #include <linux/msi.h>
diff --git a/drivers/mailbox/cv1800-mailbox.c b/drivers/mailbox/cv1800-mailbox.c
index 4761191acf782654c1724df2c9cc619e1d7c985c..4bca9d8be4ba2c8debf6e48a5ddc2873f14b64fd 100644
--- a/drivers/mailbox/cv1800-mailbox.c
+++ b/drivers/mailbox/cv1800-mailbox.c
@@ -11,7 +11,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kfifo.h>
-#include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 17fe6545875d01606b80e678fca82bf44f6eaffa..d9f100c18895224cf323b073db93ce94d7e16d18 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -21,7 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/mailbox_controller.h>
-#include <linux/mailbox_client.h>
 
 #include "mailbox.h"
 
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 22e70af1ae5d14e6e8c684fe032c2864f6ae4d6c..6ca84596e7637114f66d32a95d12c863e942b756 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -55,7 +55,6 @@
 #include <linux/log2.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
-#include <linux/mailbox_client.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <acpi/pcc.h>
 

---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260127-mailbox-v1-1461cd2955fe

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


