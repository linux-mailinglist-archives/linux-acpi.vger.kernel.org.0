Return-Path: <linux-acpi+bounces-6241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1848FF4FC
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A6B1C21D6E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007494DA14;
	Thu,  6 Jun 2024 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="bj3wOM0f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C96E5FD;
	Thu,  6 Jun 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699956; cv=fail; b=Q5DmTO4b497UXoT3E4M6dWoyrFJHhx8f3EohrZJhs+v5ZS+W8WJ+IPjqBrOLjvau/lqn3CLMUNJHSBVPnN4+Y09ANW38KSgKkrrc4dVvong+QQzzUIrbtkZnlkBY83L6s0yjo3WRKkQ3Y/eJsjopGnP5D6uDbyyxpTMmBHrMyac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699956; c=relaxed/simple;
	bh=n4KKwIXQYnYZPsuKroP7hvxdKZVKfGEhqJGZlBFbGzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cOzcvJ7L44FOT/fvys+/bl0RZ6WN3qcN3WMB1IC27vqaNXQ3OXQBMCWzgRyn2vww6/T19qkh+iG4eZCY/3rvjXUPsP74bkCUmGZ5OiVEUP2owvpKYWPLwalSZB457hX+cKnnXhEKMXpPRcwHl5Rd2YNMRBJT9YYADQe5+oknuXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=bj3wOM0f; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456C3xCs004623;
	Thu, 6 Jun 2024 11:52:11 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ykcsqt1t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 11:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8d4gQk7vN7r5OH8YBOJrS1+UNsg8D6wMLuA90ITBU52MaLyQZv/E+KYmlUAZyCJipV1W8EjPXAQW6fqy6UGMWw9AFY+tr7F4NvLHAKjhohF4Wh1BeNj6Bq907YeGxfgG2NMzjBAu8UaMLBQflie51eQMbCo42E1XmuTneeobW6cIFXxTRykGeJQpC9d3H3qtCLctCYbT1REstS9hjF75UUG0L/UJ7TGww7TAmxe8y8jaf+8baA5kVRpV4JX+S6A/bs/p/8INlc1wstEcCueXoQSEeIgGqIWfNyphSC5G0RT7dTdMFJ/TKCeRB9wNiOIpuCLCjKHA4YUsddhHvPg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNlsuP/1tA583mi16k7nsNRGc1iiiU1Rt8FK0+RJJ7M=;
 b=aXeSApBYL5f0Uv1ujA6gB4V/i7urObUjSXxTjWhz+6f4k7DgAVkdnas5CoQnphyHscomE5X/bkShSAOUI7XcT4gMh9wzPqg22OYfATulKeUtcfRsMdFJnwTaJJNoKVc6skfHUwZL4cFXx1oe9tIuwS4vfPIErz7CpNF3XzZIpzzgOc5hhw3UzoXiKg7K1R7uwFLq1CY8xXIBiHrDEC0kA0NKy6kG2C3F8+NNFN26hHjDfZ6TXerchv0074gOnTPY7BlitwID3iiHJ15EAHKyptCJ6iDHnwQM2TjhFqyWbWwaEpSzoOlYPFXPHkgKMMnIsVjlEndENyYR60VOs0eFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNlsuP/1tA583mi16k7nsNRGc1iiiU1Rt8FK0+RJJ7M=;
 b=bj3wOM0fi0bBlWAqU8Z7QsR2Pu6EIl23oU84Bx5R7pYcjN+jf3clsjoHrHupPy1Qu/ZSQ95r8151KjEdmkw956C794GP8VCqHN4HceOWnnAZ+X1UcBirpYXka7iaqvjWfyUn9jU47aw9euWUmEf1ytHaBmu+yDmTyoa/PqDKu30=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SA3PR18MB5370.namprd18.prod.outlook.com (2603:10b6:806:301::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 6 Jun
 2024 18:52:03 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7633.018; Thu, 6 Jun 2024
 18:52:03 +0000
Message-ID: <f901fd06-3b6b-4444-a3da-2b75c59059d3@marvell.com>
Date: Fri, 7 Jun 2024 00:21:54 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linux.dev
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240606094238.757649-1-lpieralisi@kernel.org>
 <20240606094238.757649-2-lpieralisi@kernel.org>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240606094238.757649-2-lpieralisi@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0250.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::15) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SA3PR18MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 150362c8-61d8-42ae-68d6-08dc8659c184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q2JpS0QwSjVQSnVnK3F2YnUwZC9nTFFPYlM4WkI5aVlZYm9hay9VcEpIT3hx?=
 =?utf-8?B?R2wyTDI2L2pJRW5wNWpTSElyOHdhREhqbFhmZlNXUWhjaDM3ZnVIOXEzMHND?=
 =?utf-8?B?RXNMSzVjVnpVb1NPd0xsNXZ3UTdvU1dFSWRreDZ5dVRVTHZTOWxUTWhHRlFa?=
 =?utf-8?B?Q29oTkhaeWlFQnZ0aDBHNzg5ZkJNdm55Ulc0ZDYxRGtaclFsRG9KRy80ZEh3?=
 =?utf-8?B?RFFFRVlVK2VrZldRSjVOM08vdEdaakZuSDZZMjk0WHhaUmlERFc4SFVtaVdr?=
 =?utf-8?B?YVpTZS9yRnd5b3ptc2xrZDNPblhaNUFkWFhEMkZHQ1BlbWNDVStCbUJPYzg0?=
 =?utf-8?B?bFZ4VmNoWU9Fbk1CS0lueDZCZFd1TkhlUXBWb05hd25Ma09HNWFZVWJFeS8x?=
 =?utf-8?B?UmV5cDFUNnB3c0VxZW1ZK1B3bGpJa0w1ajFwdGRpak05cmh2V25aMXlTRWJT?=
 =?utf-8?B?bVppbXJ1NUpkVkpPMUxYTDg4NUhUUWhpMTRVYXRyR1JYSCtKc1hTdFZFanlI?=
 =?utf-8?B?ZkxiZTlNNUtVdkp5OExZNW1xSzIvV0lZdnppOW00MTNCRFN4RWEyWnZLTEh1?=
 =?utf-8?B?Q3ViQVJCWGRoNUVPczBmNVpQbTRERjIwM213UVUzdGQvS1llbWNXWkFFVDdu?=
 =?utf-8?B?enJvRHJEeGlBeVNtOGhVM3RKTU5ta1JCYkk5Qm5Ub3REZXNJaDUwelJLcnYy?=
 =?utf-8?B?RjBFYWV1SUFJSU03M01uTkNmOHJwVG1ySHMxSzVSZkJDRWg3RllFMWQ3TEY4?=
 =?utf-8?B?SjRQb3czQTJxQnAzNi9zK3NzcmNBWXArNUtoOVBJY1g4blJxdkpVVU1id1ZJ?=
 =?utf-8?B?cVhVMzRYUTc2a2FoOFdtR1AxM09rbWtXRTNRdFVOUDNLSjZ6Yzl0RFlKNGF0?=
 =?utf-8?B?aUR0NHNNVUNvbFVRY0xqMXJTdjRXcExXY2FOTHFiR1RHZGRSdXM1YVkrT0pn?=
 =?utf-8?B?cGdUU2VXK2YyamdOY3VpK05ubExWTkpQUnAyNWg4dWVKQW8zeU5DcVlWMmxr?=
 =?utf-8?B?WHpoU2JkZi9LbHRwQzVYOHFzSmI2SXdrSFlreVpxc1dNWVJVWGduclZ1NFg4?=
 =?utf-8?B?TlFpTHZ6azF0blhCVi9SWkVXNHR2K2RRUGpmaENLcTMra084a1lpc24yVUhL?=
 =?utf-8?B?MWF4dlJtbW9sa2xZTXpyY283QTdFRkhaTEQvMThoemZOdWIwU3FJRkw5TmZt?=
 =?utf-8?B?L3hOOVcwOGxrVk83RmhZTjJLQllVRENNRzZ4T2pkM0Rpbnk3USs5eEwxY0Nm?=
 =?utf-8?B?TEFqT29JaEVEelVGdDBETzVnVks2VjRxd3l0TjJUMWZOZXlaSU9Cc3RVSmFx?=
 =?utf-8?B?Y1JQK3V4aVhxb3k1RWFMY2FQRjhNWWhmSFZRYzRiR0g2WHFtNWlDOWJHcXpG?=
 =?utf-8?B?Tk9FYkhIT2dNQnUzUGs2NGViaXIrNllDelZnYzhqRTJ4VC9uczBWdW5BK041?=
 =?utf-8?B?VzhNWVk0RWhwWVp5eDY4WTZmaDYzVThROTJ5bDYyM3Q0d0Z3NEZHQzhHWm5q?=
 =?utf-8?B?dFh4c2p6R2tTbFVWVXRjTHJ4alVqcjBtQXkvc003N2Y5VUdZOE9IQmlIZGlL?=
 =?utf-8?B?djFhaDRFUlJkbkZCL1VxcHdINEQya2JFNkFtQkwzTEQrVGJQbXB5Z1d0UlE3?=
 =?utf-8?B?K3Nadnl0L3U2b2dQWjJPOXROSWdLRVlQWkFrazRlU3NneGp2blljTlVTSDBu?=
 =?utf-8?B?SS9uSzFaZzFaK0oxR1RzbzZpUVYvWXhUVW9qbmtKdjRocS9mRHFKT3hxNVY2?=
 =?utf-8?Q?jDdG5ku/JmeyR4rbHuHXTPY0SP8tGuMQD7OXdFc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWtFeTRkeVNWVndpei8yR2NvNk9BVVlYVDNWaWZPRnp6TGl4dHVXb1M5K1Fs?=
 =?utf-8?B?Qnd3RWc1SGJKU1JGV0wzNW5lVmFvL1RkSTZBcldsdjRJQW1jWUIvRjMycEs5?=
 =?utf-8?B?QzhDUGh2eUF5NTlyeFFoTUswZUJRalpEejdyMnF6b2RNZFFtRzlKSzhDNWZZ?=
 =?utf-8?B?ZTF4K05ndk1SdGZOS3VBNjlJREl2VmxKM2xJODc2WUtPZUsrNDkyMWMxaTRq?=
 =?utf-8?B?ZXVkKzhYRVRHQmdHU203U0h0d2ZyV05CWWtaU2dPUS8xR3JMR0FHbEFLVjVx?=
 =?utf-8?B?K3R5ZHFVR0hWNjBUR1VkeWxITERrZ3RGMlRLbUhoWjM5OXg2MW55VHpiSFdt?=
 =?utf-8?B?dEEyV3F6Yk8ybkRWdDhXS2dCRHlaekZMMFA3Q2Vkd3hBK1RQblgzT25OeVds?=
 =?utf-8?B?cEp5VmxWeTZCMDl5aFJCZjRMZk1lV0RuTFpGa0hFdmdmTTNiL3hvQ0tVYmht?=
 =?utf-8?B?UGdpZzMrUWpHTFJYUStGM2NuNGU5a0E1TnZkVGRwVE9pZGpIc1RqTFRRY3pF?=
 =?utf-8?B?aFBoc0pOSCtXQW5nN0E1aWNPT1JIVmM2R3ZPVyt0amVad0k0NXVTdWJzT0hD?=
 =?utf-8?B?OUhCM0dPeVVyUlhmdkwrR0JUd3pmdUVsQnRUUDFYZ2Y4N2VMcVR2L3l5Vnk0?=
 =?utf-8?B?ajBTTDFlOG5Ucmp0bzBJT1Q5YmJ0c0RVd2hMY2M1OVliZlQwbkFiUHlPM05F?=
 =?utf-8?B?YkVxUG8wbHFBUWpla29vM1RWVHJGOE55SVZGOXM0MEFOZUNXcmxrayt4R3Mz?=
 =?utf-8?B?dHN4dk5wQ3VZSkFMNmtKaUd0Q2VRd1BycjdUZ3AyVjQxWURibGh0L3YwOGFp?=
 =?utf-8?B?Mk5nM292WVBwdDN6QnZNcEFreVlKMWhWajc4RTFJTlF0anpxZDhSSldwem9Q?=
 =?utf-8?B?L25tRHQxOEhmNUlzS2JVZlpIcXlocUFORE1MVEdVVkdRN1VobjIwQThDTzc4?=
 =?utf-8?B?SldaZnVMdVdzbkVnT0twNG5tY2F4eWRuTitlSTRjMDhVS2xnbjNyTmVvalVF?=
 =?utf-8?B?d0FONmxGd1BGbS9CZ3ZyMlR2NTAvMC9QaEUyMTJoOThXbmlaUDBDaFZFdVRw?=
 =?utf-8?B?ME9zRG9FV0lqSUdiblNTQWxia3l4TjZGZHlpRDA1MjFyQ1NPa29FbzloWTdS?=
 =?utf-8?B?dWR1ZklKNmVNYXdnVDZWZHhxaVhOVFQ3ZkQwbExmTktXL1duZGNNNyt5SmRk?=
 =?utf-8?B?UDNrc3BjTVJBc1dpZ3ZXWEtXUTdQa281UjJ3Rmg1eTFSWDJKbFVvekhHZkZy?=
 =?utf-8?B?cGpuUXBGVEVqOVJoUExsN3NjZ1FPYjcyYzZaeUE4bDlBcWVYOVdrbGVENnc5?=
 =?utf-8?B?QzVlTnZUZVhJWXNPYVRxSUkrSG03VDZxWFdTSkFhRHJDcGVXQURkRmpFQzI1?=
 =?utf-8?B?L0g1c2g5dExFWTBtbkc2QzNWRTVrZlk0UXROLzFHV0RkVDk1bVIwSU9GajV0?=
 =?utf-8?B?bHBWRWtzYzdNMFVyWnVmcDBZcGUzOTVxTFZ3ZlRiYzQ0eE5TNERCY0pIRVZo?=
 =?utf-8?B?U0phbWs4VVZ0UHBCNWQzM2d2ZGNLWGlFWlpoZkpjYWZheDVRTDZZbTBKNlJE?=
 =?utf-8?B?OVY1Qlcyc3BHNkRjT1YyeGlQZ0tnZHNaTXBpWUhMMTYxaE1zQWhEa2VRSGtZ?=
 =?utf-8?B?dmxndDAwb0dCdDZpaXR2QmpJVDNNMjNzWHBFK2dQdXhkRVVFa2pPNS9GRnFH?=
 =?utf-8?B?YVBaS3J3RTJKdDJYRC8yQTdCdUQ2NUJqb28rL2ozblVuSk1yakRMTVljVXlN?=
 =?utf-8?B?NjFqczM4UDVHVWxNUGljRmo4YUtvZnFUaERJK0tYTEFBU0dXYmtsSWEzOXpF?=
 =?utf-8?B?M3I1OXVuRzYwK2JDc1VvL08wR0hsRTkwSXBWVFhpU3lrcTU2VUJEL0RiRnE2?=
 =?utf-8?B?aksrbHBzcURCOVk0WnFobmdRK09IbXNTeGlXSElQNS9xUnRUODlxRjY3dndR?=
 =?utf-8?B?eTNUOGRCODlwbGlMS2JFaWxOeU5LNndOdDh3T2UwZGp2UGRZa2c4Q01qaWo2?=
 =?utf-8?B?SWFEaWw3UkhZSWsvaDVUOFJJKzRmRXpwQlVZT3Foa0NOZ1lQU3FKeGl0K3hR?=
 =?utf-8?B?RHp0Y1dreWRzZE5ZdFZCdzVUSDZ5eHMxckgxMWs4clhqci9WdkFqMm03bUUv?=
 =?utf-8?Q?7zg4yVYyY1ogLLpBJ0lFDYHF6?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150362c8-61d8-42ae-68d6-08dc8659c184
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:52:03.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAdds2HKnZI/MsT+JDWJx15WbUGTzXVYCEaKL9yW5gB6ZY7zqmk0+mUNB9q3urPVOLzXNq+hfn+4fD8NYPr/aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5370
X-Proofpoint-GUID: _dfNb5NE8MjCU4jiS6GRg72zmDcgUzNy
X-Proofpoint-ORIG-GUID: _dfNb5NE8MjCU4jiS6GRg72zmDcgUzNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_15,2024-06-06_02,2024-05-17_01

> ----------------------------------------------------------------------
> The GIC architecture specification defines a set of registers for
> redistributors and ITSes that control the sharebility and cacheability
> attributes of redistributors/ITSes initiator ports on the interconnect
> (GICR_[V]PROPBASER, GICR_[V]PENDBASER, GITS_BASER<n>).
> 
> Architecturally the GIC provides a means to drive shareability and
> cacheability attributes signals but it is not mandatory for designs to
> wire up the corresponding interconnect signals that control the
> cacheability/shareability of transactions.
> 
> Redistributors and ITSes interconnect ports can be connected to
> non-coherent interconnects that are not able to manage the
> shareability/cacheability attributes; this implicitly makes the
> redistributors and ITSes non-coherent observers.
> 
> To enable non-coherent GIC designs on ACPI based systems, parse the MADT
> GICC/GICR/ITS subtables non-coherent flags to determine whether the
> respective components are non-coherent observers and force the
> shareability attributes to be programmed into the redistributors and
> ITSes registers.
> 
> An ACPI global function (acpi_get_madt_revision()) is added to retrieve
> the MADT revision, in that it is essential to check the MADT revision
> before checking for flags that were added with MADT revision 7 so that
> if the kernel is booted with an ACPI MADT table with revision < 7 it
> skips parsing the newly added flags (that should be zeroed reserved
> values for MADT versions < 7 but they could turn out to be buggy and
> should be ignored).
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/acpi/processor_core.c    | 15 +++++++++++++++
>   drivers/irqchip/irq-gic-v3-its.c |  4 ++++
>   drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
>   include/linux/acpi.h             |  3 +++
>   4 files changed, 31 insertions(+)
> 
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index b203cfe28550..915713c0e9b7 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
>   	return rv;
>   }
>   
> +int __init acpi_get_madt_revision(void)

Wondering, if we can have a generic function (acpi_get_tbl_revision) to 
obtain the revision number for any ACPI table, not just specific to MADT?

> +{
> +	struct acpi_table_header *madt = NULL;
> +	int revision;
> +
> +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0, &madt)))
> +		return -EINVAL;
> +
> +	revision = madt->revision;
> +
> +	acpi_put_table(madt);
> +
> +	return revision;
> +}
> +
>   static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>   {
>   	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 40ebf1726393..af5297ef2293 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5600,6 +5600,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
>   		goto node_err;
>   	}
>   
> +	if (acpi_get_madt_revision() >= 7 &&
> +	    (its_entry->flags & ACPI_MADT_ITS_NON_COHERENT))
> +		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
> +
>   	err = its_probe_one(its);
>   	if (!err)
>   		return 0;
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 6fb276504bcc..e4bc5f04226e 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2349,6 +2349,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
>   		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
>   		return -ENOMEM;
>   	}
> +
> +	if (acpi_get_madt_revision() >= 7 &&
> +	    (redist->flags & ACPI_MADT_GICR_NON_COHERENT))
> +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +
>   	gic_request_region(redist->base_address, redist->length, "GICR");
>   
>   	gic_acpi_register_redist(redist->base_address, redist_base);
> @@ -2373,6 +2378,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>   		return -ENOMEM;
>   	gic_request_region(gicc->gicr_base_address, size, "GICR");
>   
> +	if (acpi_get_madt_revision() >= 7 &&
> +	    (gicc->flags & ACPI_MADT_GICC_NON_COHERENT))
> +		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
> +
>   	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
>   	return 0;
>   }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 28c3fb2bef0d..000d339e1596 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -279,6 +279,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
>   	return phys_id == PHYS_CPUID_INVALID;
>   }
>   
> +
> +int __init acpi_get_madt_revision(void);
> +
>   /* Validate the processor object's proc_id */
>   bool acpi_duplicate_processor_id(int proc_id);
>   /* Processor _CTS control */


