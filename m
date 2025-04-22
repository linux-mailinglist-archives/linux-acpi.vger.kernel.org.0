Return-Path: <linux-acpi+bounces-13188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60702A97444
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B2A189DBAE
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5382973A0;
	Tue, 22 Apr 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lSPOTvNq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="urEJ36lk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAEA29617D;
	Tue, 22 Apr 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345453; cv=fail; b=m4cIl9D8CV4VIm9wVS8dynKRYSW9+MIhCt+cNqeylQ6I0hjPgou0WowbjVcjP9WPxDfEEU/RIJ9x0g59eJ5nNBUQdnv/OBGrqoxhe5H0382iq7NN322Ebw+c8sYrbViGzxqvPRj4zGebSGt8Ubheir2r8v8DoR/OzT3QV1dSo00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345453; c=relaxed/simple;
	bh=UptbG7li2fPzzY9oxt7NRoTWQsC4fskilTJCrTZbBNM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=FArxZ70MX8t5t6/2p0j5pDCBuq/0ioIpmkMSf2Wx12BLqZIS+4Ig2V298dVgz4KYKFidBbseMFMdxiu6e1T+lSCJMRZVVTnEdhDCJKQr88InpVUVEfWMG9OtiYpRiM+4T1bA11hnLW5OY42EFK2+LeDQBImbzYhJQFdeXqJP4cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lSPOTvNq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=urEJ36lk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MFsvxd007849;
	Tue, 22 Apr 2025 18:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=wq9OgfzDuYZqfmGa
	UW+42N8lgeR477bOC5L/4gaidVs=; b=lSPOTvNqZ2v0QnBbkhFJZMOE1GRzovyb
	J4ISbWp9UhVaWEy8IgmcRVDv9m4uYr6nJylGmD2C/AvKqwY8cVWcuUx5SuthhSE1
	9fvBr1lj/0uhTsjVT4TVtKRbPTvmDdu6DTnuQcLFiv3XjwnEZeKfkuPRx9XLSEme
	7CKWMHuiLoa6Ha5f1UOLJeeLY+Stg0J+WrCN4k0eFBubQS3fLH3pRIuBHUAeWvBF
	4wXz+Z7F4bZ7EnAG0rbEya3GSbVpQVoxOZf5H6OyfJB3yQPddXVP+hnkmj1CcqDY
	l5TQf+T539uYoKwtQ23QNHYcS7VRA+IpH0cM+RQ7am3JeHN4gWJQWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644csw6v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 18:10:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MHvB5O002853;
	Tue, 22 Apr 2025 18:10:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464299rnkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 18:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjAfo6PpkG7mwtAy2ee/f3lpi60UTPZvVdozVNc6XzhYgzgCqMcg+rc3kbT/ZmrZgMx4NY21qq+RCrJt9DCA/Db9P23YhRBLaqVnMGBl6LGCCmaye95U8LO2Nd1S/gXw86c+Er+PR0R4CxzDv0cDXIVY+zNYnvZzU9lLsyg2kFCoVG+gsG2YlEeVJLWhxYqvQdxqBenIFcOo2bu8XzNcwoHOo7kSwXd6NJeSoczjpmEoAGEToUgq9ltKfPXpVEHv3EE200XOwOeqlzMLFSTwm6JZd2hvUTLbmhWYtVaPFxvz1UE/+qAugW9ovDpfG1S2KIOCSp4cqWe2ZP8DS2KG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq9OgfzDuYZqfmGaUW+42N8lgeR477bOC5L/4gaidVs=;
 b=lWQ+kchsDMyI+ihaLJ6oL4q2qkjbN+RZ6cGuwHfA2jfC+ySz4Sct4yGgsBOAFv/2NF7C+wK237eFOJ+O5XXG+ja+Z3mBrPdESC29Ppl1spyFNQfZS+qbV2aiUO4kTuBmLglnHLC44RUfaO66yCzLWUjx6R8w1MizHQ71iA9907nTS0uLEtUyq2a9bethFUQopcYoJd6KMqLLfVKKyAL4uEagDv8mAa/aKxqZ5IuBr2+BU3LPx8nfMNfZJl4+g0iw0NJJyQYQz7GLAWl8AwmnW0mCz4yYI4pgXuzxNKMGBrG8C3dJpHYhrNTRqzjLmw1jKsmjYrvXcljKUevKkZhIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq9OgfzDuYZqfmGaUW+42N8lgeR477bOC5L/4gaidVs=;
 b=urEJ36lkrLmvVqNoLhOsM+wSDpk7tII0Bs7O5Veowt3vROBdF1OEWwv+agTKhPBe8iAU3aHeIAyVLle4kG07i0KZ4aWHofZ4KAOxBqlIqM+VWhNWBYhVKj9DwLS7nhr7w//j3GKvJxJw0DjMFmx3vPnwXn3/MleM4lsY3cqsNPA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6511.namprd10.prod.outlook.com (2603:10b6:303:225::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 18:10:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 18:10:45 +0000
Message-ID: <a3c81bdf-29dc-4d57-8cc7-138cd16e9d5c@oracle.com>
Date: Tue, 22 Apr 2025 14:10:37 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org
From: Chuck Lever <chuck.lever@oracle.com>
Subject: 4b4bd8c50f48 ("gcc-15: acpi: sprinkle random '__nonstring' crumbles
 around")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:610:4e::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cce7a86-c031-4fbf-fe9a-08dd81c9007f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmRsNVBEWmFhMHpOOVRrY0NYdzlyV2JrQTdmMG9PL21zZXM3dDJsWkIzK3RH?=
 =?utf-8?B?MUJCQ2FLSm9YNlZ1T2dXaDZVMWVCM0ZGQmd2QUZhSEJUT3F3ajY2ZExQeWhE?=
 =?utf-8?B?TDY5aEZkaUpuN0RKT3BIVTZkenRJZXNpL2F5aG1yZGhCQ0g3VkRzbmlYRDlP?=
 =?utf-8?B?czlhdUNBaHR2cmRTdHBKbXQ0M0kxSlZzejdnbnJEYldBaDFPcWQrTXJvUURm?=
 =?utf-8?B?MG9ocC9TdVYwNUY4c3IzVkxUT3VBd3RXNzBNQUcwUHhySEZlcFY4ZEFEeUl0?=
 =?utf-8?B?YnpnNSs3UlBaTUpEUnRETmx2V1ZUbHpkdkVqU0psOTFUamNLOVJnang4UFhZ?=
 =?utf-8?B?Y011TmJOdXZVUWlYZGVnWS9YN0lPSnpodW9yTGIzRnNNc21McDc3YmozV0Y2?=
 =?utf-8?B?ZkVQbkxPS2N6aTVwb05DWGhyZU55azZKcG51SDJsUTdpSXZidmtsVGxjSXRI?=
 =?utf-8?B?UWtvTEhjdzhLZnVzOWR5bUpsVmNPUTZLdStmVitFbFZsMVEvdzZhUmVpQytV?=
 =?utf-8?B?QnhTZ0kxU0d5NDR0TXNJcit0N2hqeTNmb2N0M1BodGxCQjh3L2tia2M3MkJk?=
 =?utf-8?B?Q1dsR0JRSFFkS3I3aFlldkNrNysyU0swdmdvSWNrdkNEbER4WHAzN25mSEwy?=
 =?utf-8?B?UmZad3haUFRsR1BrdTF6UG1ZbTFCa1o5TmhYM01rUGZyMjh6NjMxSytDR1lF?=
 =?utf-8?B?OGQxOW5JT1hYa3c5STZoMEFCYjNqVW85WSs3RHVjNnJQWkZid20zOEJNenNV?=
 =?utf-8?B?bXorQlNxa1FkMWd3bmdpUnJ1QXBpT3VDQ2c3WnpzVFRpQXZnYWhRcHN4Z2hj?=
 =?utf-8?B?RXRFcUI2WXRIVjQ4MW41bUk4NkRML2wyY1huMEJQcGovZGI4anl3aCtrdmRJ?=
 =?utf-8?B?OWtDbVhZbk10S0h6QklmZ2d2NTRoVC9MSUp1U1gzU2FqQlV0WmN0dFBQUzl2?=
 =?utf-8?B?NTUrUXAxTDVobVZRRW9jWHcvMzAwNFJibGxFaFZkZEZWL1lSUi9TYkNPbW9Q?=
 =?utf-8?B?Q2VVSU9pQUR2bjJQcUlOUkdIMmtHczhOOERURG1yNlUzV1hranFsVXRnOXpB?=
 =?utf-8?B?Ty9ENFMySitzYitDQkpHODcwQ0d6VUk3SEYxR2swM0xJRFRpcll1NHluMWYw?=
 =?utf-8?B?WUlyRXhQalQ0SkNKcEEwUkFwVnY0SFI0bHVobkgyRUozcXM5dW1OcWxzSjBa?=
 =?utf-8?B?WnppbFNqTHY3WERZdUlWMk9TNzdJa0dGKzFyZms1MEtSRE5yZ3VseHJFYVhR?=
 =?utf-8?B?WFg2dkJIMTdSbkwrMDBEa0lvVUpMSys1T3NOM0ZTZWRCQTJ1VlQ2dmpQYUFx?=
 =?utf-8?B?cVBmM3AyNnZDSGcyZjZnYW5kWFFJSnRDT0xFNi80WWtyMlV2L3NyenRoaFlj?=
 =?utf-8?B?ejl4NnpzUUhIMXFHSFUyaC9wN1U1Z3diR2xYak5nRnBxc2xOYklWdi8wK0VE?=
 =?utf-8?B?Z1pYRmFRdDNwdXVPWlRPQ3NRVytBYVRvdm4wMzJ1RTY0NUxIMXVzOWkxTDlv?=
 =?utf-8?B?NnNBb0IyRVZ5MkcvWFFiL1lJUDc2ZE1WZmdUckVJTjZRRFIrR2UrQksxdERS?=
 =?utf-8?B?NEErR09VZmpodWQvbkRGcWJJMkp6dXdSSG5lQTZLMkZkWk02aURteTlGZWZ4?=
 =?utf-8?B?N01IenlsUWNaeGNnTFUzV0o0Y1ZrSnhYaUl5U3ZPUFUyYVBpVXNTK1N1TGNo?=
 =?utf-8?B?SlBVdG41RUVxVTNleng3RFlNVjNFQlNPYlhUTWVSNWZuT0dCSkkwK3NWci9p?=
 =?utf-8?B?bjBtMVk3V1BOeDE3cFdxT2dLc1QxV1hlSEVwSTJ0M2RJNDJoY3p5NE1BU2RK?=
 =?utf-8?B?alMvbUtoWFVjcS95OGJ1TDRrNFI2K0hYb3JDMnJsc1h3NUErR3AzaERsWDN2?=
 =?utf-8?B?bWpLWjJwOTgvelh2ZUN4cmlGVUczQXFQTFhTNGJacC9qb0JGaXE1REpYcmcx?=
 =?utf-8?Q?PDxYjdughXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWZQTnRnQ2w4b29VVW03SThGYjJGbzNBS1F1aXFNUjFENUV5eUM5RGNZaEI1?=
 =?utf-8?B?Z1BQaTlLUTdNWTBFdjQrOCsxOGZ2cUFyMDFlckYvMzlnTEhTalpjK3JJVHQx?=
 =?utf-8?B?c24wZ3RkdDVVVWxvSDlLL29PemlQNzZLbXZuU0FFNnJnUTcwVmFxcEh4Kzlv?=
 =?utf-8?B?UlhvazBHczFpRlRyQ3J0TVRLVUhFY2kzRUduRlppRkhYV3JnRWo5bElvbVJB?=
 =?utf-8?B?VUFhVUdwODZyVzBnam1Db3BiQ3BYVUF3RFVDY0tRYXlPR0ZIekRDdldRcUJ3?=
 =?utf-8?B?Y2ZXaldKT2tQbE90U2ptU0ZjQUlpbytob3FvcENBS05BN2wyVThMc1pXN3Vi?=
 =?utf-8?B?a0hyUEt1UVBKYVJwMnFZbGVoU01QVG9ML1R2Y3JNcGRRKy9yZktva2QxN2VP?=
 =?utf-8?B?b21uS2haK3BNdm9BcEJ5dnhHd1pNTHdiaE5qWFlQd3F6WFladHdydTVQL1lm?=
 =?utf-8?B?c2dsRkI5UUJoR2JTbjRDTHJybG40WEExTnNSa1RaSWM4QTVDaVdlSHJVWjdl?=
 =?utf-8?B?NkNJdU5LVEJ1OTRXQ1kzZ0g4SllFdEJHSlNTajhOcHc5WW1IeWVhcEpKWnFZ?=
 =?utf-8?B?VlRtcHpXQVprMTJ1OWZobjk2U1hidlU4QTRERmo0b1d0T1NrVzY4ZFNMNUZz?=
 =?utf-8?B?MWlXcGxONE13OXVoS05ORW5tWjJud0JkUWkwQ05BVTllNkZ5dUg4MWVqS2pW?=
 =?utf-8?B?WHc3NUU5SUxWY0VFTGo5NmdrU2lwSmRpaFlSSnhXVHlXTjBhNkhXT2JaaTQr?=
 =?utf-8?B?WmpuVFhUdXBpQjJrZnVQSGxURVFrWUNTWGZKZ1NHTk9DNU9GTUptUmZKeXVh?=
 =?utf-8?B?MEJFWWpJaFFQZUJnMEgzbEJ4VmdQQzFKUHc0cEZTcWJoYUFLWnBnUE5zbnNU?=
 =?utf-8?B?dmI4R0NPc1RJbFd5NEVNR0ZFOHlScE5FZkxiK0p6TGdrcDZJQXpoQUpJZGhR?=
 =?utf-8?B?UlBPOG00R0V4N0ZQaWNIZkxKUHRUZmliaDRyY0VHandCYVEyNDlVUTUxY3Iy?=
 =?utf-8?B?WVFYQ3RHTW10NWJzQnNBUFd6S2tFY2RSVkhRbHorWG9wcU84ZWJCN3pWOGZ1?=
 =?utf-8?B?ais0V0R4SjF0VEZNT3dhb2NLYzA2QmNPbWs3MlozVnpubzA2QVdyQWEzeVo4?=
 =?utf-8?B?blJ0c0p2OXUvcVlaSTZmZkhNbGFVeVRnbWxMemVHT0p6MVBZN25GWndtR2E1?=
 =?utf-8?B?QVFNa3FuRUk2OEU4Z3BnTHNJMHczNnI4Y3crbHRFQS9iSlJtUHFQMjNmQWs3?=
 =?utf-8?B?MFFnWDloNkd6a1Y4UDhrV2lqa1VpTng2RFZ1K2lOTmFnaWxWNFNrVndGVTFR?=
 =?utf-8?B?VUhIL0Z6dDJwU05FVks0YXJOZDUwRUR0VWQyZ1N4TWFPN3RIVVpWNHpzOFZl?=
 =?utf-8?B?bDVtendJbkljaXFNcm13ZjFxcFludFNXSkgwR3FUeWhhOTRXa0hJczFvZlN2?=
 =?utf-8?B?UldVcTc0MXdrclNlMHlwQTFiUVhjK1VpY0J5UFlwZTBBeENpazNHdGlnV1hU?=
 =?utf-8?B?cysrd0ZlSXJKTlc3T3BpMEhCQnVpTDhjbVRnM1pHS3cwWE9ibHpzK2kxT1lv?=
 =?utf-8?B?a0tPcjBoVjBTYUpkTm1lYmZhRXN4UUdkdlErbU9rT2paOGhRQ2gzUjVFTWw4?=
 =?utf-8?B?VDZkbXplSFFZVVRpYkxUOTFMbThFcE1vVmdLR2pkc2k4QklCUzJEMnRDVGY5?=
 =?utf-8?B?YUovNWM1U1E5V3JXdGJienphcjF4M1liUFBxNlpCbzV6R3RKWFJiQU9sK3NE?=
 =?utf-8?B?UjB2UXhsR0p3S3hBakRZQVNBMWIyaCtIbm5mazhQNFJ0RlpsRmtKQTdLZzl1?=
 =?utf-8?B?NjdxZzcvWFc2dWppQXVEcEk1emZQYjhYbS9DY29ROE9xeU9MU2tNaURwYWE2?=
 =?utf-8?B?aSs2WlpkdklXbE5JUDJuSzc1elNXNC9oNS9KQjJnR080REc5ZjJ4Snc1S1NN?=
 =?utf-8?B?a0RFK2cvQmNHT21aQXdvVkwwVnEzRzVudHhiQlZvb3FuN1F6UURURkJUMHBw?=
 =?utf-8?B?ejNOYk5Uek1MdnJaNUg3emw4Qjkra1dWWEl4dWlaZ1UwcUFDUU9aczNsTVhk?=
 =?utf-8?B?cStOSmQxa0pZeWcwZUNFZFVsV0Q0dFhNRWE5N3VpZzQ0NWhIb3BhbVEwbVND?=
 =?utf-8?Q?jD0ubnot5Rjgu5dpchE6on1tb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7kfBqhyTdghoKT6M50ebuyLRfXDDGQCdEEL9U8M3LIMN99T7etxjDUix3eArqBwIIppKGDPvpDyFHfzcGgnubwnA3f4YImqTGp0VzRoRPW5L7VJbIBvEuxHD+gYIjNDQnNvZEAoiQGf0wCI8kp479JQYYpDoiNlPjbFW0IX0tuikNJ5X4M54RzDmIr4Zdlg6Y/DC90HGNZ2Ka2y6jra6XcTppK5lYmLPw+HUMtULnpCujV8L5SE77iqk42k1HyCH7sT93wFKUs6aoyFtuggAhUwyk1qVPzdnTuqIFkqqJ3kcnf5UW/2v25eaPh6T9JyPobihoyLOhAldPfOuwPSnZB6GA9+7Itve2ckrRcRTHaWeHtrSggS1iXR1W/mxSB57JGAxhWkCI8cxvE2umfhGW5Q9joQTYVJPWHhiovC9WG4nw+yaCewuvJSfzaIQvzwc4kRfRk10oE6p7kmDvx+617mdaCi8BSCKDZAoTBzQz1LVlRITW/NyB+9UGfUFTZQ1m9hsicMfvobhZto+EApzhTd5W7yHHGI9s8oF/58DY6QwgZf8GkhXL3kxUr3GcW9rYR1U2mVwRTNCzQEnbhUAQugEr54ugZjpzFYIfVnaTWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cce7a86-c031-4fbf-fe9a-08dd81c9007f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 18:10:45.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLnTXZXb6jrUTBiGJEPthWVNgmTlDPy5Wd7fNuTBiXemYsrjK1sZNuPlkWVU5PWNrWO0lWELyKdymVPjB0CeNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_08,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=565
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220136
X-Proofpoint-ORIG-GUID: OgPKleDD_OMwBymcVuB7QkmZ7NF-fwM9
X-Proofpoint-GUID: OgPKleDD_OMwBymcVuB7QkmZ7NF-fwM9

Hi -

I'm seeing this new warning fire with v6.15-rc3:

/home/cel/src/linux/server-development/drivers/acpi/tables.c:399:1:
warning: ‘nonstring’ attribute ignored on objects of type ‘const
char[][4]’ [-Wattributes]
  399 | static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst
__nonstring = {
      | ^~~~~~

$ gcc --version
gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$


-- 
Chuck Lever


