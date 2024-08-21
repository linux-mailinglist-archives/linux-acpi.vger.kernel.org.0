Return-Path: <linux-acpi+bounces-7758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730A959546
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 09:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2540286082
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 07:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB394199FA7;
	Wed, 21 Aug 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIDly/sm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C55199FA0;
	Wed, 21 Aug 2024 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223823; cv=fail; b=sGLkTmiG5koRQ4qACrSGmHOQEKM867z2B9RCiOQULGqP3FAM0Cs2HvcmleA1hR/ZhbECS10C586tnPXqiFMXEUv1xPx1CDC/05bzht7YmdvBBo0nNjIAQ8O66sYt8FkYr4cUXtZ+npK7L/8+TSCcxt1y4u1O1Uza0J8vj92d0AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223823; c=relaxed/simple;
	bh=XktFoaSV+eTTN0tvqrNQLAw0nOIpTDdDi4Y7zTSqgco=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L7g/fdnZ/ocfYxtQjTksWu5aJZeWPFjt5RFuognzwHafzLU+t/8imYenVKT2s9XiL5ws2fOU/7heRU15vrAsX1H2iSolqXi6Oq5HR2lWNwhGjMx/PmD8NsPciKvv0dqE/95/IBDXYKFWg6HVYsbkkUfJfm8A3EDv3VWJrdWddUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIDly/sm; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+w/sjt54ROhW6aUw3hrDUD3tr3vokfAfTeDhW+bdFhJ/4pKA3Sc8+6/Jj8iA/QK+p0KPOZ14SEADHoNG2P1JcZQGwAlfJ6/lF+kTayiUcusOhPdPdLAEh9aX3djfuo61AxT9luK41iz9MaLVGRorBDgvTXBky3Pmkmd3zj4Bcmv2nEjTiRK099DE9vTwuvgRG313w4NL1RgWlOuR6uCZL7qDuYn7I374OU1A6XyD0yl8/fHD1FOF+9KQq+bVGUFBQ3BIpamp1a1VQ0JCxHNWtWoJB6D8QSl52i+INdaDSQei4J4iqaXlAip0FmAPhMX1M0lc6j7HdNBqYiNHq1IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XktFoaSV+eTTN0tvqrNQLAw0nOIpTDdDi4Y7zTSqgco=;
 b=LWKlQ5VEx9XtubWyJ59Z9gmT/ef7QH1vhL2caB+c5cPwiu6KwMWhjBYfpSrrOuGbOj0rEzd2Onbq2uYPSavfYqDrpzSlhOL2Et/NIMII+DCP4X+uw3D3F2U3jfyJT5XS5wYSqJsnC1fkU6v/DTFZxM3zwcX0y0B1zYOOx7JnK/XZY9r5TQtP3c1Wj/UK7bXL8durTK+004lZYoKz4Vtmey2aRN3eI57Ucg5wOoXNTgQqL0rcAuQPImmr4PwIkB8njM3HfVZPxkXztWIWBWdnOo8caY+oL1IEJNADsANyp3FPxlaOK8RdjYdRhOYX+uKEJ9OKhh9nnheE4UUDvkUIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XktFoaSV+eTTN0tvqrNQLAw0nOIpTDdDi4Y7zTSqgco=;
 b=aIDly/smqywJuJuy2/1HY1sY/09hUdSTCWn2wb6SODDqH1LulgsDW4u3F0AEMBhn4XxCKK/aF4mMvfI4eMjAYtRTLGwMdAmWzO3wxiCWv3GwqAwGUQiHp82gmKftA9B6oDOy3wHYRlEU0RJQ9cqhK0t5LxUilFm4EcV5zicnb16iM2Qp7vEOB3l1mOO9IcptEm80aol0vlsjO0QTcBEO5rX1wxEb9BjXJBCeMDEkZsyQdLeu1NK8se+frAHm8cZcdmRYn2dq2hx5X19KuJHQdTNTCPU2hstghZJl+y1MF7D/1aM2nduXj00WN9GkDPfWXlZUwBgCPdnp/fyzrV3+rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 07:03:39 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 07:03:39 +0000
Message-ID: <a5580488-afd1-4c2f-92e6-e42430d61ea2@nvidia.com>
Date: Wed, 21 Aug 2024 15:03:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/prmt: find block with specific type
To: "Zhang, Rui" <rui.zhang@intel.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240801014853.1594699-1-kobak@nvidia.com>
 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
 <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
 <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
 <f6e581e1-2d24-4587-a193-bfeaf1a3cb1a@nvidia.com>
 <4ea0db68415445e5aab405438bbd8ce4240d7ee4.camel@intel.com>
 <519e8e00-cd82-485f-8871-81fb703c7592@nvidia.com>
 <13f458859adcb75d0930f1a76d7c0e2f74f5e7d5.camel@intel.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <13f458859adcb75d0930f1a76d7c0e2f74f5e7d5.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eea36a7-793d-4cbb-9875-08dcc1af6261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2xuSTZiQldHOVgrNkNRRzY0ZDNudEpsQ0ZnZUpJYlVYNm9sQlFYNTVXNFFC?=
 =?utf-8?B?Y1Vwd2hROW42VW5haHJRdkljbC9oYWxwQ2gyYTdyNjg3bUNaYU43SjVFWERZ?=
 =?utf-8?B?WU5BS25vSUtqTlJESkRJbWtjaGhYN1Bvc0Rva1gzWXd3ZDgyaXRMRkI1RTJG?=
 =?utf-8?B?SkJScUFRdE9ZM3laclZZc2R5MkpDZWltd2xDeFk2Z0VFV2hqTVdLeDFUNE5t?=
 =?utf-8?B?NFVuMUplbTVGMXhQVkN4Z1B1MG5ndHo2UWx5NjRyWTRWTWRJdFBkbFlQbFRJ?=
 =?utf-8?B?RjJra1pJWm8vSXViakVTTTVTZlNJT2dVUXBOdGNrS2lXVU85UG1nL1BBMFhI?=
 =?utf-8?B?MHk1K05HK2hqc0FPQUhrS3ZFa2JsOCttVnU4TFlSWDNQeVJ2R2JpTCtkeXNM?=
 =?utf-8?B?QjNNd0JVbjA2T3VaMVU4R1VhNDl5OE5lZ21FUDIrb3UvU1RmRm5GOHl0MEdi?=
 =?utf-8?B?SXNuUTMxRVR5T1dIZDEzYlUyWUxWYnlQK3NSVXpVQUQvblB0YndNQm0wRWRT?=
 =?utf-8?B?bkhUWENLZHpKYUdLQ2pDam82QVk2WStTeDVCVmZJenhPdm5EVzcvU251YkRL?=
 =?utf-8?B?R3d6NEsyUkhoVFpSUXFXNGMxYThtVVZOZmRGQ1ZvVE1MTjhTRDhXYTdWRHRF?=
 =?utf-8?B?aDNSYnMvT0R0WmFUUldEZkc2akNReHQ5eTFhK3FzUHlzWW9SbmJoSlE5cStQ?=
 =?utf-8?B?MG1sRWlkSy8xdzFYRHljZFc4RWEyUncvVHFDTllRWG43eERGa0VROEhsYVVB?=
 =?utf-8?B?YmIyR3p5RlRsWTJ6OURMMkgwdUhGZnFwT1MzUmllWFJEVHpnYjhrdXNuNGRB?=
 =?utf-8?B?djlDOXpoc1E1aWVXSTNJZDdiajErNWRheFJFaTY0WS9qTWJsYlNtbXJxd1Ur?=
 =?utf-8?B?R3Z2bW9ISkNLUk9vd3VvTG1nUm9VS1l5aWFEcmxMUytQU2F1ZU9CKzk2UEYv?=
 =?utf-8?B?VlY1cURVbW1pajRXcVF0UEREOEJWRnNKM2dyazZGWWlUUXFaTFRkUy9jR2t6?=
 =?utf-8?B?L0lWaWVVT2xkRDNQK0QvZHY0N1JTWDVGYlRxd2FWWVQyWHBUcjJyeHJUUVdF?=
 =?utf-8?B?eCtWY1lHVHBCd09zOWJ6eVVpZUw5Z1pxRzZzS2JtRy84bUhEa09Ja1pFUWIw?=
 =?utf-8?B?NE8xUjZvWXVobmRRTXhqRGZRWEIxblFpeUpvdzFvMS9hOXAxazN0cjlBM1Iv?=
 =?utf-8?B?TlVVNWRxS3YwcmRhbkQ2YytQQUs4Nk5JRnd2QmRYTWpkOUQ0UmtvZ1ZKREV2?=
 =?utf-8?B?ak1vZlF3RStkUUZiTXhNMXZSQkFMQlNIaEgzR2JnNmx2VjJod3RHdU94cjRy?=
 =?utf-8?B?djE4aE96RTlDSmZENE5qcU9RN2R0elI1OVZ6VFVtcG01bVRjY1BCSjY1ZnU4?=
 =?utf-8?B?WWJhYklyT1RnbnJEeVpzV2tXYTJ3WUhYZitUM2lzRkg3bENOVmt2WFhqVmpW?=
 =?utf-8?B?ZVRRbEtMVEt5UUdkVXprcVpvZEh4OW9ldzVHTlRFRG1ZaUdMNnBKRXVxdWtO?=
 =?utf-8?B?d2VCbi9CeDZJVXIrN1JrckRHUHN2Qk5jU3k0QWdKMDJ3ZEVVbDRPUjBmdXNG?=
 =?utf-8?B?UUQ3dEhva1d1WFVCcDVyeDlaMnJhTnp1ZUpCRzBaUUc1VXRlQW1CN1NZVUVZ?=
 =?utf-8?B?S0V6RkR6UXFtZW5DZkcyQTZIbDc1WnRacXplU3ExeVpXRTBRTWZ1WGtQQ2tF?=
 =?utf-8?B?ejNBWTU3TXp0Q1VHclJtekVNaE1jNERudEVDYVVxVEFiTmYwSTRrNTBvT0dH?=
 =?utf-8?B?a1J1N0xURVZoQWhtVXdaTFd4VzVVR2dDbjVuUW1qUmpBNUNwczhzVEh6V3JJ?=
 =?utf-8?B?VHNyV1J2bjZSbHJ4Y0pndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3Z5d20vdlBkSFQveEI0ckpPWk56c1hYV1Z1eHE3Yzg0RDRlc2tlakhTVHRl?=
 =?utf-8?B?UmN2ZlRGc0llaS9BUStQT01OaS9yZjl2TldmQWtnZXhuWmNsMElZdkFBVDEz?=
 =?utf-8?B?SksrRy9vUFFoemxMZis0YzQwQ25Ebmw2K2c2VHU4M01mMVhMeExXajBKSzkv?=
 =?utf-8?B?Z2ZKeFBJNHNVQk5XZ2dYVUVyYzRvUW1POHF4bmdZaHVCYU1jVDFLa1hrNFpz?=
 =?utf-8?B?bGVid3lKN3NCVlpYVWlFaVVPUG0wOUZ5VzEyaGNtYW9maHVXN0pwenViM3ZV?=
 =?utf-8?B?VW9vbTRYdXM2Tkx6V2RaVXpTME9pcVpHYkJPWEF5Nms2NEs1R3ZEc2FBVHRD?=
 =?utf-8?B?QnNnbHpoS3V2SEpkcGo0dXFtS1VTZ2ZUNFpHTm91OTg5eG5UU2FxVlpIeEpG?=
 =?utf-8?B?a0VsTUk1QzAySTNMZG1VL0xKM0ZEU1ZCYmF0SWVsRC92a3pCYXdWQ2svQ2JX?=
 =?utf-8?B?R2tyZEJwSk9UZHg3VTJ0M0x2Z1ZhcnVvUnM0VEVCSHc1SXpVd2ZzRW05OWpw?=
 =?utf-8?B?ejIyb2FDQUM0WldiOEZnVys4T0JtY1ByZzhaOUVJR3dLa0pjOVBxWXhVNnpL?=
 =?utf-8?B?MWJOdWh0cE1kSWxRUUZodzhvWXNIZy92MVBSdk5oRG8yQXJXY3FCMUs4SkJx?=
 =?utf-8?B?VmxLTERtbTVkdXRHQlc1Y1Q0Q3FDRjhCbUJLTFAzbER0NUY0Mk9WOWdCaW8r?=
 =?utf-8?B?ZlFLN0tTNGhQdFc2TUpiLzZmakJGVEsxQ00wWmJZclpDTmFseW5YZGlRdXY1?=
 =?utf-8?B?dWVndmgrVVpaa0NJMXJpZTJwc2dXUFRDMEZwLy9ELzFPQkVOQ25JMGRPL2J0?=
 =?utf-8?B?a2RMQVFyNUxUZUFrblpFVzhMbGFHMlU1QjFuaGczTHJFWTNnR3VCekNsUzVT?=
 =?utf-8?B?U25QNEhLOEVzVVJrNXZXb3JNQ0MzVThROXZsYWkvUjlCZ2xMaE84U08wK1g1?=
 =?utf-8?B?RzBnVTVHTVdiZkt6RlcxaTBYSG9sWGt5L3pBMW1TUHIxMUo5bis1UHY4QWhB?=
 =?utf-8?B?d2xyeUtXMmNLOTh0bmNEdDl1YlpLNzJzRWZoajdJalMyU2haay94YmNtV2c1?=
 =?utf-8?B?OHJPVmJWQWpMY1Z6b3hxbU1UNUxVS0RBWitPVDlYWlFLanBDMXB6Z25GNDBQ?=
 =?utf-8?B?V0dpVzFkSk52NGpkMExSZFR4cm9iRUlSM0l1YnVLb2ZjcXp3QmJKbytNQVFC?=
 =?utf-8?B?WWpUdUNqVitKQTRyN3NaUzhUQUdGMVZ4Z0tzS29PeGF4bVR4RUkvMXIwbVc1?=
 =?utf-8?B?TTJtQnlYSnYzUk11MzkwZWk3Z0dvN2RQZGVzNFdoL2tiVkxBMzBKTUVPa0Z5?=
 =?utf-8?B?VHhZOFNzdE1KWm1abGx1dWtUT1VXMjVIVWxaMGg4NGJIRmFYckVZMmpqK1RS?=
 =?utf-8?B?VEErTEh6WW81cEwxQ1RDTHhaeEdtOURwS0xuSi90KzN3MTJEK3hTZmNmYTB1?=
 =?utf-8?B?TUlvdVlBUFhYMG9JOEpoUWdNZ2F1TnY1cE96eDVqaTl5SDVsTVFKOGJHQlJu?=
 =?utf-8?B?enVqU3FTQnAvSkRBamhXSU5lcE9STEVJUERYeXBybnBQYVhsZHR2VlJRVnVG?=
 =?utf-8?B?MGZTd2J5NlQrN3g5RHRQbVFLSGxaK3hxOG5jc3A2ekIrUTN0SGxBTUhMMmpu?=
 =?utf-8?B?RVJjcEFNVkkzemNRZG8wdmU3WUFWdjlwY3VHNUFjUU0xTDZrOGFLRHFLcE9E?=
 =?utf-8?B?YlZad2FlbkJRTnpaUVdGbkVZbFlvNko5TlRxYzllZnh1T25qM2J0cXg1Y3B1?=
 =?utf-8?B?dWxIaUExY0hicC9kSmRTVldhK3ZURkM2VWZlbS9NYjFqLzllMHl4ODU1QktZ?=
 =?utf-8?B?cEo3cXFLaWl6OFdsSWFwZkI1KzYvQ3FwYXJ2M1RuenRDeE5oWTk4U0g4VmdG?=
 =?utf-8?B?OEFoWG5EUlRLc050LzNZKzJaWjViTmtYUjh6K0EyUUIzbzFZcUZ6TVpld1Ry?=
 =?utf-8?B?dGhmSTYzcHU4d2tpSFB3eXlvNk4vNElhY0ZxTUdrQzRIaC9YYkdQb29RYzRj?=
 =?utf-8?B?Mk1UWHA5YjAwWnEyNC9VR3VOZ09VMUR1Z29GRVE5d0RYZHRrU1B6VnoxM2o0?=
 =?utf-8?B?RWFzZDJHbjl4WE13Z3VkQVlLU0FpNFY4TnZGVUtwMzNFRFFBdVQ1Sk9xZXFv?=
 =?utf-8?Q?c0aR0gEbjRfezq+rsx87CPhz/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eea36a7-793d-4cbb-9875-08dcc1af6261
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:03:39.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BElIpukbHIewipjoXKFFbBxSqJ7OWrYZjmnj+/hk/QP/KE+caRYA4ub9hXR7hbFmIqIQYbYgRDiVhWL6H6TJgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754


On 8/21/24 14:48, Zhang, Rui wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 2024-08-21 at 14:36 +0800, Koba Ko wrote:
>> On 8/21/24 14:33, Zhang, Rui wrote:
>>> Yeah, but I mean pr_err() may be overkill if the driver is still
>>> functional.
>> how about replace with pr_warn?
> when it fails,
> 1. the address space handler still returns AE_OK (is it right?)
> 2. I don't see how PRM_HANDLER_GUID_NOT_FOUND prm_status is handled
>
> So, if it is a critical error, we should fail the prmt probe
> immediately.
> If it is not, we can let space handler returns AE_OK like you do in
> this patch, and in this case, even a pr_info() is sufficient IMV.
>
> thanks,
> rui

Agree with you. it's worse to determine the failure on another place.
better way like yours, when get failure,
just complain and block the procedure in the scene.
also will modify in the v2.
thanks


