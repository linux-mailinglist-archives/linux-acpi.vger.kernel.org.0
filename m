Return-Path: <linux-acpi+bounces-17879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1669BEAF15
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C497F7C38B3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91E2E5D17;
	Fri, 17 Oct 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="bo9GZ66b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020085.outbound.protection.outlook.com [52.101.85.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67152D027E;
	Fri, 17 Oct 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719808; cv=fail; b=nl0T0s6B7GQtta47MV3dGkVSrCNZX5O5IjD2n7lmCZg6QjFu9BMIC2y5nx+qquSFRvhzIxtTJr5ri1ev5ZlVp6x6ZtO+0zeHBKte/Sa+U+GfbNrLdi/t0Mw0m1yyMwk6OVFVndg7TIUbmFmmI+ddxz/jbxJKQBaScAG4bZOLZZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719808; c=relaxed/simple;
	bh=q3dUPsWAWTqDFDOIFEPZevSrH4vWaIPiizIQsxvIbvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fGNid8oqSN2M460IQsfLHIyYO2bxcneUAmZwM6/Y/Klrv4ucOUXKD1+HIStIVC6oRIR0Jwnb1pnJYrriPMnPvdUEoAvmt1nHqGcbETp/zJrJhsHD2cmIw+YcalxLBayE5hCZxNGdnPzIqxsIbI0lD0BowSnJl/NkLQWRmGT6hMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=bo9GZ66b reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.85.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKey9Q3FaRsp4nXnmmA7z9yuYYF0X/hZR7SGeOW8MFqBpx6qJJHbtaBdQJZz/C0iq9QQeu2uEj896bIoUBIfrCSclPtGflfFHM4auKmbHYECrA1qGcO2DNRjCQ/SHIvqeAyQymFTqivZriD6AteufU6Knsp8KcyxYpiKdKx2I5aWOgT1Bw8Jyg3FlDkwyXE1RF5ZA5AwrQHDA5Lx119aMCKk8OPRgQUfGPUZbCiPhFMj2iyosrvu/ibPz/Xb6VgC3nsTMR6R3JAXm+STW3qwmePoCAWMG/Nok6Yvc9V95NnWjJ/JGbGiWMgdWE2Iv/Ewek70dSHtvBHs2/VifOPryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XLIDsRS9XFjgb/3r3Ab0tvtx7x2UISmHQM3O2YNB5E=;
 b=kvvR1myaaBzxgOnKlnjvPRazw5K1C4YttVXjqeyhyfryYrN3jgafJUGSBKiwbmFoneHPaGYAwJCTV+jLYma65DWEK5EidOB5qV+wGyHf3XwomfKUkCYRfXD5xaqzyhkgGtSF2rfzSQ0EOQA5eZYX2zpFPQD8FNJ9cj9yBR2BtqA1YwfILgrodapG9E3KrhvqP4GvI8BsxMlVSflhixrmtRr3wLXQfr8BB76KJjh5Tp02gjsez91TYuNPCSjjkTZSQiaqMxEvD1LyIBEAb34cEua2X6ye8UgNzsPl6UxcnrPWdLlVL0aQ83v9grxT+B/8oy8+hQmI7iS1ZmQmfEFk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XLIDsRS9XFjgb/3r3Ab0tvtx7x2UISmHQM3O2YNB5E=;
 b=bo9GZ66bIkZBrMlClGo9ncQMBsbT/Eyqzh/o4oQRq77gXiRkNjuJ4OIsLnVCl51dY1SEjwMBzKMnw+BY9D91SjKTE926u3G6+tG6jomLiWkcn3CY4V2rIJyoco6l3eDxn4T41tcAmDn3RQ2V0RMorDM6yDimRt52+UJcD94E3ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH0PR01MB6809.prod.exchangelabs.com (2603:10b6:610:ec::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 16:50:00 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:49:59 +0000
Message-ID: <8a7aa313-568b-4ee8-a575-4a62933eb289@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:49:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mailbox: pcc: Refactor and improve initialisation and
 interrupt handling
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0150.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::35) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH0PR01MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: f301643f-d283-4148-e00a-08de0d9d35d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QldGWGw0cUpha3dNeVo4bHZ4MmQrb3BpWkhUZXMza3Frb0NhUDZ5RUcrKy9m?=
 =?utf-8?B?REtLSTJJckxFM2IwbS8zRnovZjRlaE5NTzlTbVRXZHoveE05ZW00Z2UxS0Ra?=
 =?utf-8?B?UElERWlqL0JqM1h1YUdha2twM2xXUmtFQ3ZKRE9UaFBuZ1pyeE84MEJ5OEt1?=
 =?utf-8?B?RG5mOVppVDd1TzY4Q2Q1QUpDakV0QVNXL0FVNzY3aUlJazdIdlZmVldLa1dP?=
 =?utf-8?B?SEVhdGo5b2pIT2pJYUhqODRmaktqeng1eEZ4cmlpbndncXpiVzRzV1hWaFMw?=
 =?utf-8?B?Q0hGenF5UW9vZUljRnFtSlBRRGJBVVpFZXlhdlF4QWd1cWdnWEhCSnlEL09O?=
 =?utf-8?B?NXBjaDVjSGNlWXIvQyt1WmJ5M25rUkIzSE41eEo1OWRsQm5mWmpBRHREVWFt?=
 =?utf-8?B?d0FlQzV2em5yZ056eUNNMlJ2bWVWVGE3MXBoZ1RROElKOExTTW10d1lwNTFH?=
 =?utf-8?B?T2QrWUZ4MEY3ME1nVEMxVFVKQ01GeG1UKzZqeXdiT0ZmcWZ0VXl3MW5hU3ZC?=
 =?utf-8?B?dzRDWVlVUmlPQW9OWmo1a2FteGVHQlZxY1dFU1lxd2ovUVVrTXliWU14NnRr?=
 =?utf-8?B?czBYWGNEK2ZtM2gyRHY1SDdsTVo2ZXhxSGtUcXZVelFPMWh3T1k4cmVqcG5R?=
 =?utf-8?B?TDMvL29wU0hkMTYyUHhiWHJlQUl3aEtERWM4bzB6SmhPR0Yyc3pwWjVyVERL?=
 =?utf-8?B?OWIxNzZnck50eHV5MW5kTzRUV01mdXk1NlowTytLM1BvTEk2bjNQbk51UTg2?=
 =?utf-8?B?NlpBeS91SEtzclgzT1Q1L2hrcC9KaHFSUDkwbE4yNGRDTitDMlRkZWpIZDVY?=
 =?utf-8?B?UWoxMGZUQXJ3VVgzODU4U2o4Z1AwdEh5ZFhWVGdvUlRzVEZIajlIZUVLc2p3?=
 =?utf-8?B?a3kzVDBkcnNSZ0JZMTRWUlVKY0I1WVNFODFaVFFjdU9wT01YbGpZdVVXYWty?=
 =?utf-8?B?aEFLWlZiczJsZWg0aVFHdTBOWFBPRjNCK3lkaXd3WG1NeVg1NW9lTTh4VUJG?=
 =?utf-8?B?T2NRdXFvU3FoTWRkUW5qZXBtNFdaSmxHT3VJRUVrVXQ5Vk5tYUwxVEtEQytT?=
 =?utf-8?B?VHE4a1dHR05GRnlmNFA3NFdQTzg3dnNOQkM0eFMxSWoyN09OWEQrRlRJWnVP?=
 =?utf-8?B?c3BJQW8rZm1MSjI5Qmx6cmthTGFndmhQZGxUdkQ1Uk5UYzhiWHh3Q0h5RGJE?=
 =?utf-8?B?Y2tNbmRRNGpBL1JkeDV0Y3RqRG52TkRqSWVVempCUWJIZVNicTN3OHBtcFU5?=
 =?utf-8?B?bEErWitvMTZQZk9LRHpKbGR6VHBOekMzbXhOaHZteTNISm10dmMyc1hYWk1q?=
 =?utf-8?B?ZEJtakRSbkFRNHR3a0hzTUhJUWRDVTJYVHdmbFRRTHJnYjY1Sm8wckhzYnh2?=
 =?utf-8?B?Uzl5WGwxNlRRckhsQzV5VVlTSDBjYUtCdkZNajk3OHdiYlZBUisxbUxsZUps?=
 =?utf-8?B?SEx4STcyUkZzZStxcGI4S0pHaHplZUpsNk0xVnk5Rk9hakJKK1BaZlJNWldt?=
 =?utf-8?B?cC9iZ3BMbjgzZFVNRVBiSjd6a0FCc0Q2RWdUQ2x5NEg2SVErN2V6bVlUNFUv?=
 =?utf-8?B?aHRoYmNQcWYybmtkaVM1cVlqV1RvQjVXdzVLSnJMZFJtTTBFZ21HcWEyMi9S?=
 =?utf-8?B?QXRLM0dZTEJDTDdkeXYyR0dmMWpJOVk4TTBIL096SnJlYllJcjVMWVh0V0d5?=
 =?utf-8?B?YmNDakdVWEpQZWd0YmZLdzViOVZYdzVxN2x6aFBpaGlPaVZ1QldwYy9jZ1VH?=
 =?utf-8?B?dHBkb2syT1hjVjZpNTlQMkFSb0Vxa0Y5eDFCOVdIUmVPVGEzMm50SG55UURk?=
 =?utf-8?B?bXlkaHlGNTJvb0hPclh3MFpDSDdpK3FsSG44b0VpMW41Z2pldWI4OXFIc1FC?=
 =?utf-8?B?T3JhSVZxMDQrbXprMFVWWXZidm5FMDFpRnFoQWVSNjcwdjF4eXZLWjVtcW5W?=
 =?utf-8?Q?DhL2xo2Vfef79HcghI0r5jb1LhFO0X7S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWRNUzY0dSsxWGlCemFmRWpkVWNDUmo2VFVkTUZwSUFFTE8vbGIzU0dtZFpW?=
 =?utf-8?B?VGxDb3UwZnRrd0h5WHAxUkx4dEpGeFVXVEdMT3AzYWh3U3A0QmJERThsbmtF?=
 =?utf-8?B?S2dBNTZvalJ2SEpQZFRiem1wV1RybWdRdldXdHlhWElpb2pDaW8zbW9IYS9z?=
 =?utf-8?B?R0puWEdvbGRuUUNLbEc1T3VXRWJIOUwzT1NjeVZNb1JUZDFHaW9nay83TDhu?=
 =?utf-8?B?Q2ZBeEZNRHB3TGg1eGwwVFVmSjFwWjVPRlNaUy96NTNmcHdXWks3bXBCdEEx?=
 =?utf-8?B?LzNLWmN0eE1uNUtBYzFXc0VzbjJBbzNhdEJzekhKYTAwTEgyY1ZrN0srTDJm?=
 =?utf-8?B?QUhGUW1OSkZibnlqaFVyaU1qZ1ZOUXJoM0ZWcVZadmo1bTF3R2k1T0cyOFZm?=
 =?utf-8?B?YUMrMGFUVVNxeU1XM1c3WWgzUzU5UWdkaGNFWGloTk9TSzRUaWErSGdLN0JY?=
 =?utf-8?B?cE5ZMlZPSEFGby9pVWVmT2lPc1I1WHJtR2J0MEZXNFpETm5nQm81OGxYWVQw?=
 =?utf-8?B?VndmalRXWDFGUTFDRThPNWFPV1JUNXpqa2I5Z1paVGhSeFUzWDRuK2JlSUcy?=
 =?utf-8?B?YXZZeVVEZGdhUkNlM0JSRCtveW9CUXM2NlBWTXNkMXJQRDJQcS9HQ1FWQVVK?=
 =?utf-8?B?ZkQzMU1hc2dQWjNVZjV3K3JTRkdvdUlPa2RGR21CMG51VElMVElsTG1vVGZE?=
 =?utf-8?B?YXRsOWZnMmRUVTZXeUV2RStWVWxtS05vN0N0aVRHb0dSNUdsNi9TR0dlbEdk?=
 =?utf-8?B?RlE5T0t0WmJ5N1pRUVJNMFpoZS9xQzJ5enNhTW5ld0UrODJBWU5GU0dld0tu?=
 =?utf-8?B?WmFteHIrYmlyZjF4aWlFa0dFcjJvdUZyZmxINjZsRGFETWhoVE53NFNNS2lu?=
 =?utf-8?B?SEdnUWNsbXJwRGpsUWNZYjVKS2E2VGFFRVR6ZERiSjJyZ3F4RG5XQ2x2OXgy?=
 =?utf-8?B?bHd1emhSbWFrdUYwT2pzQzMycTNSZHNiVHNwajVaYTdSZXhxT21hbkxkZXVI?=
 =?utf-8?B?TWkxdkNMT21RaU9wWHMvc1dNVEVBZkF6WTFZV3Z5Vzd2b3VZczlUaGxuTDFz?=
 =?utf-8?B?UENHWkN2NjRzQmVScGdaNjhEdmxpTCtNdmhDVmFvdUttaTdHSlViMGVkbkdI?=
 =?utf-8?B?UGs2d1VydDJ0TzJiQVM2MlJTOElvWmwzemF2RmtiNW40WFpGU05EY0h4cFBs?=
 =?utf-8?B?Zm5GRXVTQ0JjZ1N1RmNMNVFRclN6bHc1ZlcxYkZFT3ZFcXBnRUQyR25hV0pw?=
 =?utf-8?B?K2NlSXJzRmtKNFlTMy9ORHF1Y3RieXZDTyt5MlltQ1NxVCtHYjFPUktTNng0?=
 =?utf-8?B?b0d6UFI3cGdVeUlTaE5lT1FVZ3diNUZrdHBaZkpwYzBPaGU2R2ZZUk5XT2pv?=
 =?utf-8?B?enl3KzBCdU5yWnc2bW9GMVdIWm82b2w4QU1oRkdockdXL3pQQ1ExdXNmcXlC?=
 =?utf-8?B?YVJZenFTZzI2QVR5RjNHSUt1RjluRGpzelVvZml0RzlwRi9rOEk1MWJwUk1J?=
 =?utf-8?B?SzhHdkd0cXc4ZGdYZjFpN29ocGpZeUJZMDJ0bHZiSGdrMlpwYWxlZGFlVjlC?=
 =?utf-8?B?U1k4bzB5RGZqTDM5ZmZ1a0htMVJlVENVTENsZEMxMmJtcnRRdEF1cjEwNm91?=
 =?utf-8?B?K0Y2OVNsQk05Ykh0S2FYTzErSjhuMGMxYUZIWFBCa2xYaTZZcmsxamhGOHhv?=
 =?utf-8?B?QmZyS043eUlISWxYamgrZWRyc0E2Uk8vUWFDOFZTK0xFSlZ0blVyUzBsa3BV?=
 =?utf-8?B?KzhRVHloNzNGdXozZDcyYU9YbFJLQmFjdEM5SE5PWTd4VWVDTElrS3lqSXFa?=
 =?utf-8?B?cFpGSFN6Ykh3NW5kM1lmc0Y3N1dKOHo4ckxkWlVRNGdMZHhuM3dYV0g2amlJ?=
 =?utf-8?B?NDdsaUI2clcwSVRWc0l0ck96N1c0eDJwR0dROStBMWl2b3BQMVpIRGQ0KzYz?=
 =?utf-8?B?R2EvdHlhUWhGUGNMakVMNG5tVG82a2RZOGFFTWszbW9VNzJBemVWaEVacnhw?=
 =?utf-8?B?Y3BnbkZOS2JkVG9rallNZjZ6YSsrMGJRV3k3SnpHQStPR2h0bGM3dUs3QVl3?=
 =?utf-8?B?UkVFZ0hzYlF1Tm5JZmRTVExEMEc2a0VLNDdjKzJwUjRac0gwSm9JT0F2VElM?=
 =?utf-8?B?N2dDRTgyUW9TMExWczZFNEJzMkZQdmsyaG8zWEhzVHQyZnVJZHIvNjRoTmxn?=
 =?utf-8?B?Rmc1MkdTbWNlYkhhZ1k5UUovSmk3b0lnYkEvNFR6aDRIb3l3WGJEUHNvTS8z?=
 =?utf-8?Q?gG9Ecg2HjMunpfFcRkBY6pCSf0Ey8LtriqbxPbK/tA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f301643f-d283-4148-e00a-08de0d9d35d6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:49:59.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0USFWYpMI6NUTfqk7B2XBWo8o8CWWgOn2Y2qc72W5EbS5rc9NPYPIyaFZvWHuUPFrrZOh6nQTgetreWbhBHNRg/5vfQ/tSRSkjk5CyxhbkZ/WILFUMw2NsvFaln8gd2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6809

Tested-by: Adam Young <admiyo@os.amperecompuitng.com>

On 10/16/25 15:08, Sudeep Holla wrote:
> This series refines and stabilizes the PCC mailbox driver to improve
> initialisation order, interrupt handling, and completion signaling.
>
> It begins by reverting a previous patch that introduced redundant shared
> buffer management, simplifying the driver and restoring consistency with the
> mailbox core framework. It is essential to have a proper baseline for the
> main changes in the series.
>
> Subsequent patches add proper completion reporting, clarify completion mode
> selection, and fix subtle sequencing and interrupt issues to ensure
> predictable, robust operation across ACPI-based PCC implementations.
>
> Specifically, the series:
>
> 1. Removes redundant shared buffer logic, reverting an earlier change that
>     duplicated existing mailbox core features and caused maintenance overhead.
>
> 2. Adds ->last_tx_done() support to allow polling clients to verify
>     transmission completion without relying on interrupts.
>
> 3. Explicitly configures completion modes (txdone_irq or txdone_poll) based
>     on ACPI PCCT doorbell capability flag, ensuring the correct completion
>     mechanism is chosen for each platform.
>
> 4. Marks transmit completion in the IRQ handler by invoking mbox_chan_txdone(),
>     preventing timeouts and ensuring proper synchronization for interrupt-driven
>     transfers.
>
> 5. Initializes the shared memory region (SHMEM) before binding clients,
>     preventing race conditions where clients could access uninitialized memory.
>
> 6. Clears any pending responder interrupts before enabling IRQs, avoiding
>     spurious or false interrupts during startup.
>
> Together, these updates make the PCC mailbox driver cleaner, more reliable,
> and fully aligned with the mailbox framework's expectations, improving
> determinism and robustness across different hardware platforms.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Sudeep Holla (6):
>        Revert "mailbox/pcc: support mailbox management of the shared buffer"
>        mailbox: pcc: Wire up ->last_tx_done() for PCC channels
>        mailbox: pcc: Set txdone_irq/txdone_poll based on PCCT flags
>        mailbox: pcc: Mark Tx as complete in PCC IRQ handler
>        mailbox: pcc: Initialize SHMEM before binding the channel with the client
>        mailbox: pcc: Clear any pending responder interrupts before enabling it
>
>   drivers/mailbox/pcc.c | 118 ++++++++++----------------------------------------
>   include/acpi/pcc.h    |  29 -------------
>   2 files changed, 23 insertions(+), 124 deletions(-)
> ---
> base-commit: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
> change-id: 20251016-pcc_mb_updates-d9d428985400
>
>

