Return-Path: <linux-acpi+bounces-20630-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KvMKLagd2kCjQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20630-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 18:13:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208B8B584
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1F9E3012C71
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709A7349B11;
	Mon, 26 Jan 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="ENG8Nb2m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020117.outbound.protection.outlook.com [52.101.193.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BF349AF9;
	Mon, 26 Jan 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447333; cv=fail; b=ortKOHSUFfCvmmCKg2OhLInaQwDYSMqNVOUPk0hLmXUBaytQuYqQ5vkhWgSF9UpCSCuQX26aF9VdB0XGsWlVRfwR9gsAOauhDVjK6nN7yva+S25hLA9XKD2MZBKHZyv+oUoZuAK06nQEOYqsoDfw3aBYp/NRIG/+H4DIsajlQsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447333; c=relaxed/simple;
	bh=LXoUrSNykTpMwAOOkXY1V6qdVvq5PpM257AbUJ8qKK0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GneZyj9uWm44ZOBwSHMgoSvTpNlhJ+vNqor5jCYnVOkaCohQVcDJ3nCHRLNrA9YrEva7HmUI1Mo+rIN+H7qA6UT7qxaJ2M4/QrVmT6nOpzcRuKRF4/1Fx6d8iG+koNRUHKRNxtWTTe7nUt96IeNxWTSDpsb312IpxGdM7/PuOaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=ENG8Nb2m reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.193.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAdS21BtUJ4GfcIsmsifCgZA+KherRnf9PF6g54Q7VjESzH8jNq4g2zt1KJZiX7QJlJYr0axqc44D5l84FmZ9cUI0jMJ8C+rFLP1DnMe6bCu+iP9c48vABAYeDufVDH3GCLorNaFI8nfIJwJ1aMoYEp7/cmbWX6PaxvcHLK1bkt3QKnzFtd9N7bKr/1JpOCkM8JYq2TRkZs0El7/ntOpWVxWvCC5twMS2JAgsTtzYR51B700Kn5Jzrxy+uOviyPAD61xNn3Hw6ZqnHLelyKF7XXIPaS6GJYg8F/kkr+p2UiGeHP2kfDXxhRSSeAPrCGCwM1gmwlbGVXRTZf5Q9WU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HypME+ahKADwFR3eb6ItUSg+M3yb2xhRKbTbWlVQ2ms=;
 b=zEObTgmHw1T5tY37P5EWixPzH7/jbFkD3pIp4q7mBF/4J+rxLL5ZGn2zxctk3yf8JydPM3RfR9Cp6paQja3/RUh3erKMTIH0iBWbe326an9sgXXNQwslcVcRUxOeBCimy97cd1NsL8uVF568xHAjfzqSWGd5XF9JgjXrF1p0/xZb0BWYo7q6fxONQUlRVvRmJC4jLf03fFhsTn3Jc3K/Q/VUVGReMMbTHWg3ro5rb1VlYywlPGUWmj4W7mCO2E4CQC9NYRUDDYQ7l3awJuYT3CnobxlgY/dTN4iThF0oexl/biCNRzCibkrrAv8kv/34UDuCWcLuDawAshY0n1pYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HypME+ahKADwFR3eb6ItUSg+M3yb2xhRKbTbWlVQ2ms=;
 b=ENG8Nb2mvoQcgkB/ESYwRKHr6pazzLinyqMQUQO2ZXZKvNqRo+/qPh1E8ohyebv0q1po9xNvJIROjMtlH474ZMuX/EJiNgvupgjt4FHzdeO3BKbUHYaVfvsMjOXfTK09oJQQ+SzOwIGgBTSKRM1+fW2MbsrhQymemta0gJE7Xug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB8191.prod.exchangelabs.com (2603:10b6:510:290::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 17:08:50 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 17:08:49 +0000
Message-ID: <1313947b-dfe6-480c-bc6c-8d39a4dc88f5@amperemail.onmicrosoft.com>
Date: Mon, 26 Jan 2026 12:08:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation and
 interrupt handling
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251127-ancient-baboon-of-opportunity-5f773d@sudeepholla>
 <aWUnZJ83_AKQDagu@bogus>
 <f30ff47e-2bcf-4239-9f56-c624f4978307@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <f30ff47e-2bcf-4239-9f56-c624f4978307@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:930:4c::19) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: a42de07d-048c-41bd-88d9-08de5cfd92fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjQvZUMrVXVQRVJzM21FYjNCS1RvL3pvWmxTcHdxdkIwYm9HKzVxb0JVYVJI?=
 =?utf-8?B?cU5wTzR6MXRWM2hXTzd3YUhVcUpmaUNNZ0dIMndMdDZZbWw4dTNRRGlGNTBL?=
 =?utf-8?B?RTZEdkV2QWhRa0N1RWtXNUhFaVdxU3NvSTd0OExsMFRwWGpudVlDYXp4ZkY1?=
 =?utf-8?B?OWNpakthSDkwK21FK2xydXVTWmlOZ3M0YWlnSE9KYVlnOFlDQUZLRlVVVjFn?=
 =?utf-8?B?Mm9iSmVGSk9nNWJTWFNUNnJlUndjOXFyYjgzZ25zNzl3Ti9aVVVuOTl3Mkxw?=
 =?utf-8?B?L0lmQXVMcSt5em9hWHgzYWVZUjU1STdNdzdpWFZ5OHZ3ZkJWb29LdCtNNTVJ?=
 =?utf-8?B?OVRYRWJtQWI4cVdSSFI5SWtRQWcvT0g3T1JNQkFqdGZJS01ocmg2aGFIcU94?=
 =?utf-8?B?TkVKQzR6cWlPclJlVllScUowR1FpQm5pY1M2UnE4NWpRVUdDNkIvR0kwUkJ2?=
 =?utf-8?B?TkJaQmt2a1QzMW5PYVJFK0FSS3FYYWZYZVNGczJhR21aWDN2aWhlK1JpTjlD?=
 =?utf-8?B?YTk3MnJGdnZyMGZwV1Mxb0Y3Rnk2VG0yOXJFMk1KU2MwS2VyZjFmVWErY0lz?=
 =?utf-8?B?ZTdDazZRSVVSU2J6RFJXZjd6RkRPaXVWSkFvb3FYaWJlZnVoalhUcCtJWUxr?=
 =?utf-8?B?by9TU3NpOFB2Z3I5RGJESG40RVp0RDhZOHY1a1k4UnB1b21UTkFMZCtKYWY4?=
 =?utf-8?B?a080WWROdFBPSTlDMUNaQTlSaVVqUTZDV1N6elFGcTRsOTJTbDcvVTVJU2t5?=
 =?utf-8?B?UUtqS2tnMXZsSk9VRUNrSjFHQ2N1M0FETTBZUkFEa3J0dlVKMjVHVERKWG14?=
 =?utf-8?B?WEpvTTRJQldiMDVlby9ienN2V3FoWWRqMldMQndlTklsMHdtVVhnb25sWHQx?=
 =?utf-8?B?MVd6Sm83NWREYXZldS9BTnRhaE0rQ2c3c003WUtrL2wyNDVyb3l2UlYrTVdQ?=
 =?utf-8?B?WC9CcXJCUXdwQWZIcFRJcFdmL003ek1jUC9hbmpuNVlvSXBaQmc4OFgyODdh?=
 =?utf-8?B?aDhCZHAyUXNSMytpazZHSnAxMkh4a2VtYkRQTTY0RmtURjJwU0xFcVhuaGZY?=
 =?utf-8?B?MmNYaklzRzRKamRLVzNsc2FFMVZpL3M1ck1xaU4zN1JGb0NFNCtMNUlMdEhz?=
 =?utf-8?B?eDVsRDNUZFZ0OHJZSE5wY2RKSm45dkZXOWhveVBrK3VQbGlzcnlWbDJOcHJw?=
 =?utf-8?B?SkVpV0RxN0oybG1hZGN3UW80SFVNYXpOTnBkWDVnNGRSSVlFUXU4TEJ2eG9G?=
 =?utf-8?B?blhNT2x1LzJTQXdLSUxCc3dtd1JRSlVXTGVnNmUxTnREUlNNK1dZRG13Q1hW?=
 =?utf-8?B?dnNqUXo0cTBuUDlYSVRBU0NRUHNvS3BGeFJGVXdqMW12eTA1Rms4Q3RZRmFK?=
 =?utf-8?B?TUZsZXV6MStkZC84Qzl4Y3dxbEU2OWhkNXNIUyt0VzUvU3MweFdOeVhRclJK?=
 =?utf-8?B?NWN0YTA1Njlqd3BaOGtaTlArYWFsU2w0Y2ljWGU4cGVkU2Y4VkdNYnBURE9i?=
 =?utf-8?B?Y1huVWdSbXhiay93THY3Nks0MUg2bGZNTkR6Qnh0VkJSV1locVZHNDhjaWxI?=
 =?utf-8?B?aVdsbDJUb003S3h5ZHNJSGFBV01kMzhkUGlXVi80M0hnY2lCV2R0L3E4bWlJ?=
 =?utf-8?B?WEFROHFVNW1FK3VXdU1tNHE4amk3OG9MbjRXdWJEUGhUYXJtbFJBNGdTMXJ6?=
 =?utf-8?B?QXNqaW1SQXVrZlAyYVJ5VkF2YmRlRlpiU2pvaVJGUnF4ZnlxUUpuZTFhMDJr?=
 =?utf-8?B?dmlPb3VOMGpaYkd3amwxZW1UWjRnalZFaUZ3d2lmVTQxK21JWHNOYXVWTHRv?=
 =?utf-8?B?TXJpWldid29GclVaakxvT29UMG42eWxuMlZ3eEZUOEdKL1lNbmJWSHdNb2VL?=
 =?utf-8?B?aGJBK3NYeE5Rc0RXMGt4NERkNU05UTdEa1V6MllsQWlhT2lKUk5STFJuT2Ev?=
 =?utf-8?B?cHkyaW9DT1c0YlFSNTZEUnc4V2tPanRlbkZ5Tlp2QlRkZ1JXaWx4dG5wZnll?=
 =?utf-8?B?K01uWnZ2SmliamxhaVcyYS8zVjhhSmJZVXlVZzdmTWY4RlpaMnIweUtUdDRB?=
 =?utf-8?B?RDQwcHFyaGx5cGV2VTdvaDdjN2wyTklMMDZ1Um1sRTVRby9nNzY0cnRJZml0?=
 =?utf-8?Q?Y02c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tSdExodFFSQ1cwREorZ0dQcDdWU1ZrRE84VWlSUHBHdDdDQm9RVmhPdEVp?=
 =?utf-8?B?ZTQxeHM2WUl3dkJNTmhrRWU0eFdRcHFBUlNMSjRWQVhXYXY4V0RvMXhSK1My?=
 =?utf-8?B?aTVwTVh5Sk4xZVpSYUlOTFA1alJEanBBY3VmNUxVZVU2T2xPUWw5cTVMS1I0?=
 =?utf-8?B?ZFp3RjVXZGtpdHZjbzl5b1RiMTgrNHZPNktrN3pMZkdnNllIL2VuRy9NUVhy?=
 =?utf-8?B?NTY4aElmeTdWblBoYmc4S2dpcGxXZmtxSmRBdGtndjVyV0hXZUxRNWRyMUph?=
 =?utf-8?B?V293eWd4YlA5QjN2eTBQSXY2VFk2WTFYakRGSjB1aXZNK1VxSURQOVVqWmNB?=
 =?utf-8?B?cktPN2xMaERTV2dtekZaVXhhSG5ZcVVuMVYzcWJLZnI5NUhlaXJsSW1mMFQv?=
 =?utf-8?B?T1NlOUR5TWF5eUdsbWdOMUhzZUF0aEk2OUlUL2ZYeGNjNVJzV0lvd0oydm5P?=
 =?utf-8?B?R3R1QjR6WHo2MDBpSmlhQm9QazBnQjh2akc4V2wrTkloV0QzSUVoNjVldDBn?=
 =?utf-8?B?WjdYcVQxSnVlMkREWnY3MTE1bkxJd002NWJTcVMrcHVicVN3cE9aUmgzaE96?=
 =?utf-8?B?NXVVcEV4REh0OXNNVjJ4SS9saWJ0VkVUbU1LeHBkSXJSaURxQ2JHeHVKNWFX?=
 =?utf-8?B?L25LeFVVeVNxYjdmVDF6U0FMaFZlV1g2NXBwTitBZTFoQlN6b3JoQ3FXOUlS?=
 =?utf-8?B?QWc2M3dBNjV5a253VjVRQW1qZmlvSzRTelhNbUR1czd2ZXpnNGNkZHNRdEtW?=
 =?utf-8?B?Y0xpUXVrdU9mblhtUDhoOVFrSUZhV2lHdjV0WXpPcDFtWUlCNm1TWUhzbU1B?=
 =?utf-8?B?cVovNzdzenE1Uyt0czgxZU1XT0dCTEdNRTM3aE5qMTNuQVp0eTA2MFlRdHhi?=
 =?utf-8?B?WE8zc3JrMC9GVzhLTDhxVlhYVXpIRnhPTHVtcXMyV3hTMnJTaUY1ai80dEtI?=
 =?utf-8?B?RGdsM2xCTmlEbFZqakFUYktvcGZncDM0WTc1dU9Mc2RvQ285R0Exb1lrL3lq?=
 =?utf-8?B?Qy8rZG9xc0NMZUh4aFlpaHZPamlUejJlY0wvdDhFSWtCUC9ZNnZ3eFdUenJ1?=
 =?utf-8?B?OXJNeFV0NExTOVdHalhpMWxkWkhSSjdvQXpBRFMreEJTbnRPUUtkdzQ5Snpr?=
 =?utf-8?B?WjFNTTJHMkF0ZUZ4cHlXcCtWaG4wUzI1YWhFK05MREFkTWFrNk5FaXZ5c2po?=
 =?utf-8?B?bklWeTJ5b04wajJSWDN0UVNhWUVLOU1YZGhKZ0xoT3crWlNUdzdWS0QyMERX?=
 =?utf-8?B?VDhxZVI3ZFR1ektha0tBOE9xSnNaa2N2S3c5NjFINEhRYlpmNEV4N1NjTDZp?=
 =?utf-8?B?TTR2cmhFWDl3YUlHTTBBV0U4dytpOUc0dVN4YUc3dnRKbjFsZEc5VjlsSnlW?=
 =?utf-8?B?QW50QnlueVJUMHhvTGxqNGxhZjJRVUNqZEtmVllwb2NyT0FIVUlHSTA5eEtB?=
 =?utf-8?B?amNRdW5STHd3UWlOWmk1S0dQWVRnK1ROanBmcmtCT2NxTFc4QXBhT1h5V29X?=
 =?utf-8?B?TFNJcEx3dFUwbmNnOWQ0WWZoRGpkN1M1MEFvQzJJNU1WZ1k3dkNFMUxweXFB?=
 =?utf-8?B?MFBmekdxUTNSR0YxOEVDZ21NbmV6MHNwWWpWeWtvUWpqV2tjdHh2N3M1QnNn?=
 =?utf-8?B?Q1VETituSzgwTUpyOWdwamozOHZXL2tlZGI2R2lFZGo3OTJtK2RPOHNtelFw?=
 =?utf-8?B?YlBSNUJxbUFpVkpML0FhZGU3Kzh2a3FEbi9OUEFWTXI0b1k1Z2tDZm96Ynow?=
 =?utf-8?B?b2YrcWRpbjVTUDk3RkZiVEVKck5TV09xNGpHbkd0MG9HSmNidlhvR3BCdVJl?=
 =?utf-8?B?VzN1TVo1L1FaUkV3Ri9OMzl4cGRXNUkvUHhCbk9obi91T3hFajRXYzNvZHZF?=
 =?utf-8?B?M0tsTTdLbUNpWnNYeWZYdVNSOVdvZUdFZHA5cVBLaXBDdzVyUFIvVXZPWE4x?=
 =?utf-8?B?VS9IaERwVHc3ZUU2TUZRYlJzZ05QR24veDdibE1ocnBGelBhVVVWZjFJaXhm?=
 =?utf-8?B?MXF6dWp6NEE3SnIrakN0ZURJbGdxQU9ra3dLaDd6VHgydnlvMzlEVENUZkY0?=
 =?utf-8?B?ditIRjRzMjVRckhvc21nelVBN0dTUXRrQU5ZSlN0NEV3a2NvcG1XSFlyNG1o?=
 =?utf-8?B?djVpbGdZYVFZOW5kRkZ4MU1aa2swODMvZVVPbnIraG5YZzE0c1VTNUhvQk44?=
 =?utf-8?B?UUhSNG1qWnpRakU3TktIekxaZG56Rld5QzBhRzBUNlhMbXBKYzVIZ2FMVkJ2?=
 =?utf-8?B?K3pTeC9YKzBzS2wyVzJpM0M4bjhNRThrdjRnUVlZaWVob0VBTU01WklGZ0RS?=
 =?utf-8?B?NVR0ZGxZOEpQaE9aT0ZjdHFwL2VtZE5PeitHUmlXNEFDZVNBcnllQzNrZ2xt?=
 =?utf-8?Q?mRvqH/6CzsTWBfJcC6RDVThe2HFcPKmcrqP29fW61smPB?=
X-MS-Exchange-AntiSpam-MessageData-1:
	HpRU3xl9GqLOpzzZ0HBjXbRCcHLNPw+4tugeb6L7acoWmvVi3jtYM2kk
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42de07d-048c-41bd-88d9-08de5cfd92fe
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:08:49.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OC2B0wHTvvKhCvtwc1Qx1+8D1A3oxmXnukOqZqc3Lr0NF2DsUjtSFqHXr+OgZJ5YEFZrmmLuudhN8Sm1p3An4LXjVJo6/hAgXcxz6XLhq/bBxu816A75kgUmylsL3PPx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8191
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20630-lists,linux-acpi=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	FREEMAIL_TO(0.00)[arm.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amperemail.onmicrosoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1208B8B584
X-Rspamd-Action: no action


On 1/26/26 12:07, Adam Young wrote:
>
>
> On 1/12/26 11:55, Sudeep Holla wrote:
>> On Thu, Nov 27, 2025 at 02:40:56PM +0000, Sudeep Holla wrote:
>>> Hi Jassi,
>>>
>>> On Thu, Oct 16, 2025 at 08:08:14PM +0100, Sudeep Holla wrote:
>>>> This series refines and stabilizes the PCC mailbox driver to improve
>>>> initialisation order, interrupt handling, and completion signaling.
>>>>
>>> Are you happy to pull these patches directly from the list or do you
>>> prefer me to send you pull request or do you want me to direct this via
>>> ACPI/Rafael's tree. Please advice.
>>>
>> Hi Jassi,
>>
>> Sorry for the nag. I did see these patches in -next as well as your
>> v6.19 merge window pull request which didn't make it to Linus tree.
>> However I don't see it -next any longer. Please advice if you want
>> anything from my side so that this can be merged for v6.20/v7.0
>>
>
> I thought you had an approach you wanted to implement for the 
> functions that provided access to the Mailbox internals: you wanted to 
> do them inline but hadn't gotten to them yet.  Is that still the 
> case?  I will resubmit mine as is with -next if that is acceptable.
>
Apologies, I realize now that this was about the previous set of 
patches, and not the ones that Sudeep and I were discussing that depend 
on them.

