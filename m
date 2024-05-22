Return-Path: <linux-acpi+bounces-5942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FB8CC526
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2F72832E8
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B47141987;
	Wed, 22 May 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FTWfeKe2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F81420B6;
	Wed, 22 May 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396655; cv=fail; b=sSzRJT9ppFVBeJ3W0hgSfcN7MI9ITuzAX0RG0feSYZTWEHHeLjx63dCEsZzZsgUgRbqPgjX6TxkooTHVLWyGI5gNCn6SF0D824/h9j/SaT+bdIB8EDufPLB+IlEXCYMKUjp66Dw9QA5RO/Ll83ksk9xrATgEY2Rgr2QT9+McKmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396655; c=relaxed/simple;
	bh=KmDw9/BL6cRq91PTEAS8VTLhw9wxf9PDnXRUKQp/WwA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RSDN507HXUoBAjl42+AlZNBK3BVc8CIVvHceD/5NIzGfzSJ9oxVtjxigWO8cBWq2z/K9hmKC+RI0mpThhZOdHiZYKdJNfHZBdH6EZhGyp4o5bdBYSYHTK4EjbiQtiaYZSXdJ0HdF5u/biog6s3l4IQYHCjIcCGEhj2nMBLjo3PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FTWfeKe2; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qcl/UeaiFEdkYu88hBPGe1ug+LzlFHunn46qHfUFJXdMbd/HQBJCM9skkx86kykDEPxyaNXS0Dw64Galea9/NPZ/m8NdXh7R9cwO8B94WJJR1BS6RTt5mx//pD66KElIeQuPX6PvFr6q9baZmNGkQn8NdbEFvzGAFJTbBJBD6dAB2WFPE1q6VpRBp+N3uQTLFZeFRa3YxjB0Z8yEGOjyovW+kC8sPTochvqdajwF6C6pdP2LWXcJOtBJRwKl09xiFcNPYq4iuQqsat7Bz7apzx+xqqAxIeP7aZ52hVaRRGkJt8E2kLa6KSLDd0K0+nZHYmw2RvZdbWOf5WGxUa5/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzKRJtdHCEvIZprO8RbvMAwJNWb3FWArCj0XE4rw6MQ=;
 b=e3tGXZD8QQ+t3krHSK8L9meBed31zkdwuDaoRnw8wu9fVRh5cD+84qLHSNHmbOY4FnCrx6fuYNaaZoIqcbQsZmsO7DJXn0V1SQLKsDjTbY1A12YxvHbWPZYUhHe4b+j+dh9oJd/eERSOpxqU9v5KxDlC63KwXO/PFoyOMUA/u6cAqcQ7Ckg7wLPdG2hqSy58eSqD1ztZpIVuzYZimKzD9SQQynGOoCuIdbZKA/lQxglLaGvxsXRx7xMrGPTcx5h2A7y3Jv1VRfSthNLK4nLtvFbL1tm5Vz0YCGYSrikg6SbBIi+BeZH5CxFyHLwrs38yBEJPvZiM0+EaO9Z/vsXkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzKRJtdHCEvIZprO8RbvMAwJNWb3FWArCj0XE4rw6MQ=;
 b=FTWfeKe2q2znaggmGKEssp7oTUdLpVqUNfr/RGVdaBm8sMsQJi0hqWmFI6glHgu7H1wvHHYPqzF6uk6V4+I18GLkAe7QJ8D0e03oRW75CTK2C4z2jV6wEIkSDkCLyk2q4SFHt8A+0ll3yZ1UiQhofi2di1OPPeHRCt/6vdvU7Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:50:48 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619%5]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 16:50:48 +0000
Message-ID: <3cf3bbaf-8bc5-4ea6-aa9a-926075a1ac86@amd.com>
Date: Wed, 22 May 2024 11:50:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/8] ACPI: APEI: EINJ: Add einjv2 extension struct
To: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
 lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
 robert.moore@intel.com, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
 u.kleine-koenig@pengutronix.de, john.allen@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
 <20240521211036.227674-6-zaidal@os.amperecomputing.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240521211036.227674-6-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0906.namprd03.prod.outlook.com
 (2603:10b6:408:107::11) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 85706df6-2b34-4fd5-1b41-08dc7a7f549f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YllUUUphUGRTZlMxOEQ2QllTZ0J2SUs5ZW9pZS9WbFZwdDVxOVpHNlRGenZT?=
 =?utf-8?B?eDMyRWw0N01hK1VWWFE2ajJ6YzBzcmhKbEdXMW12N0UyM3J1bktFMVlhQWIx?=
 =?utf-8?B?V3dvS0RuZStNMHFuTmZhcVpUaE13Q0NmZ1U5UExFYzVXZm91NmYwa3RMelBu?=
 =?utf-8?B?M0ZDdFJTVzVXWEF0UFNoVDkwcnl0MFhXYUZrRnk1QW9NNTl1THlYZFByNk15?=
 =?utf-8?B?UkQ3QVFaY0JFNHUyT3JST01lSnR6Uy9CWEZCWjVwVytONS9KbGowVGdYcG93?=
 =?utf-8?B?dzlqTHRJeEcrK1NlbkQzS0l2SXloU0EwOTdYWm81Rm1OK3F3Y1dZTnpQVWZz?=
 =?utf-8?B?ZzhhQ3MvS0t1YURpMElWQnRvKzlzbC9qUDg4anUwdW50UmN4V0RtSHZHdnJk?=
 =?utf-8?B?V1FQSlBzNGQrWE9MUlBLcTgySjVqS2J4YVlldzBlOExTZnFCOWpWaWdieCtL?=
 =?utf-8?B?Y1RVWFdrNGt0UG5qQmIwekhRTXpHem95Z09OeEtQdWRjZndZRHZJRW9xdGVN?=
 =?utf-8?B?dlVRRkxUajI5NzB1YzhnWWlPSHVYaGxqamR5VjdFNUtzVmRkSnRoRjdjYzhk?=
 =?utf-8?B?ZVdzaDdHWTJOV1ZDalZBMEd2R2dSZHVMdzZ6cmsxcUFFdFRlajZGL1pST0I5?=
 =?utf-8?B?bW9rbjlHWEN1T2NKWlJIODBQNzZraEoxM1NEZXdhcWU1cm1TZ1lXOEhCMkFs?=
 =?utf-8?B?eW9hWVluMDhaZDk0RU5SOS9WSmlOYStHRUVSTFUvRVJpd0JsajVZU1NsN3hO?=
 =?utf-8?B?QTJiYkM1Szl6a2FiZnNKdVpnTG8zTWNMaTNReERTQUhBYjhVcExPQURxbERU?=
 =?utf-8?B?NmJjTm9kYTA1NlRnVWhGL1R0RVh3SlZQVnNRRFNITitlK252YlJCbUplNFdK?=
 =?utf-8?B?Rnd6ZkpCNkhJUmx1MnpLMFA0YlJOSFdzMGJ1SzdpM1Bia1dNbkVONXJ1cy9r?=
 =?utf-8?B?U3pTcHpOdHZ5VW0zM2Q5ZHJTUjdlaFpIM1VuNjE3aVRMSnF0ekZudEJObDJY?=
 =?utf-8?B?T3FPanZLTzMyTU96S08wa3o4Wk1tNmFrSkxkR29kQ1lFb005MDlkN1hqSHd0?=
 =?utf-8?B?TnBPVjljcFg0ZVh2UG1nSUZtNVFrUjd5dzRQV1J2empPUWdrWFFLWXEzMDBE?=
 =?utf-8?B?UFVxYUV5WENXSHdJaHVSMnNvSHZkY2VlWkZiWW1NbTBBdEtmaVdabEpCQ3pN?=
 =?utf-8?B?aU9CWVdKd0kzczl6TjQvRzlyNzZxOUVMT3Q2d0hZcVF3T0VOWE5IRXEvMEs0?=
 =?utf-8?B?YktSc29LcXArOFRzVVNxcWRSNHVtd3M2UHcxdGtLY3ZTOFZSd3FRdDFQWldC?=
 =?utf-8?B?RzVzOTM3NFVqMDZENm96RGdpS3RLRzJ5WGJmTWxaOEJEdnM3Y0RSYTBuM2c0?=
 =?utf-8?B?b0VlMHdGa3IwZG9Ea3hlSWRPazB2R1JmaGd0bTR0UTlEa0pQcytnL2dqRWYw?=
 =?utf-8?B?dERzcndzK1JGOU5UdmdzVkE2OVdPRTVldk1iejhoVHpaeENCTFFIUFJpbU5P?=
 =?utf-8?B?dElMTktUZDZJSU9FVEtNbkRMMyt1Ujd5TDNodEhDOFl1d0RlalB1aWJRYnY4?=
 =?utf-8?B?OHdaNjNzM1BFR29SVzh4eVhVLzVEUUJmN0lJZmM1TWZjYjdCeDBiRE13eGYr?=
 =?utf-8?B?Z3ZmaHYrT2JEdWdQaEZEbzhjdXRJM2FMTWthRm9CTjQzNVFWT282UmV1Wncw?=
 =?utf-8?B?K1V6QStHOFVDZDFDREJUV1FkSGpQKzQwZVVwNFVjcFFBMVBqeUlYMW5vbm9j?=
 =?utf-8?Q?GRZdgJIJovPF4gAOXCyb2cnv3Hwv2CgfM6jX68G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlFYQi9tVGhEMGwvOFBlakpYQzFuOG02ZUtrUFg4ckU0RERKSDM4Y2l0czdl?=
 =?utf-8?B?L2JrZzdvTzJqNVp3QVNYandiT3hTdnAyVkJ0Q1Z2WjN3Y1grS1ZiaGtaeUlQ?=
 =?utf-8?B?VGJvQVBGRlhCTjA4bk8vMjJONGtDaWFuU3RXeTVUSGVMRktxLzRoR0pjbFNW?=
 =?utf-8?B?eTB2Umk0d3gzT0ZsSEpyNk4zVUYzaEQ1OTBKNm81OXRPc1B6LzluM2Q3dFNI?=
 =?utf-8?B?UGxFd1V3eXl4NTlDWnpZeEtjMjBJdTJINlZ2OUw5aW5rRExCdGx2OGhSbVMv?=
 =?utf-8?B?emxEYnNuL2pkZ25JTHkxUGFrZnVRbzZPdXVYVUFvbzRaNXNieEhEL2l1NGtl?=
 =?utf-8?B?Sm5CN3kwRnhYN1NMVkpsNWxMTTVjNGhXZ0F3UlZGbWlrR0lVQVZ1RThFL3Av?=
 =?utf-8?B?eFJNUXdSZmRBN2kvb241c2d6YjlEYXFia2hNUVFrK0pEanVMaThoR1FaOTRt?=
 =?utf-8?B?aGlkcE9SWGhlQTJGeTRaVDZZTlF5MnljTTF1WVp3aldxb2c4ZGltMFR2UGVD?=
 =?utf-8?B?Zll5TlF5aWFtMXBFVmZtUTJJNGJQRk45b21jbVdqZU03R244eEVuMU9zRFV5?=
 =?utf-8?B?RkUzMGQ2N1UwbFQyVFpVMzlPeVZqMXZBYjFKaGtwWVJLOW9LREhGNk9kWXFW?=
 =?utf-8?B?UGVHc3lHVWQvTVQ4TjVKQkxLNmJCR0RGL280cEhFb2oyaUFid3JyUkZnS0ov?=
 =?utf-8?B?QnpucDRjWTJIRDh5Um1lWHJ6bWtSS0ZLem9ObXF0bDRmb1IwU1dDL3cwWk13?=
 =?utf-8?B?cXdzVUVkY01VUVRSYnJwOHc5T0VSNVg4R0NmUUxpM0VWN3ZnZ3ZmcFJzc1Y4?=
 =?utf-8?B?TnRCUWZkN2dGTFhQVHhJMFlzTzVmSGkxRlc2ZHBsZ3VTWDNGUmFLd3NkUmdu?=
 =?utf-8?B?NjhsbmFBWGZsUExndHlnUFptTGpBTUFCVk5qM1FuUjhDaGQ2VFNha08xNi9u?=
 =?utf-8?B?bThJeVZpbWFyRHBZTExoUXo5eE9CVXdUWlhZb3VWUnhTY2VvNUszVk5FcmpM?=
 =?utf-8?B?cWhkTno5cnVjbktMb0s5TVZ1YmFmeXBUTUk4SmJUS2V5MDNkSmR5dTh4U1Fy?=
 =?utf-8?B?SFBhdk1UYmx2WG16Ymd1TEJtcHNMQXo0bmF4a2RBMlA0Z0h4WFJpTW04WUx4?=
 =?utf-8?B?eHRnKzZrRGJFSDJPWVBaT05CTk9NdHpLcHUrZXBUMm95UVRuTFE4b3YydFNG?=
 =?utf-8?B?K1FQRC8zRGdnUFNPcVA4dUREbVV2REZCeDYxajNUUXhCN0xuNnNKWlZVTkRx?=
 =?utf-8?B?SCtnRTdCRG85Q2VydkxtUTU5TnJrc2FOZ21EYmZubEVsbzNndTVHTlp6RkhP?=
 =?utf-8?B?a09Nbk8ycWV4L1lYUnFwdmJqMTVhN0tOc0NUaUFVZnZEaGNKT1NtVXBRTDdX?=
 =?utf-8?B?QWtBanhlZVk3VG9pcE1KQ20vSDhTM1IreVY3dXlqc0tjTUFtb1Z0cTNWYjZX?=
 =?utf-8?B?dkY1TSttYzRKMkxvcHNkOEk2WUtLaS9MelU3U2kxaUFrbTd6eXI3bTQrY1Fp?=
 =?utf-8?B?WmNNWW4xbnFERTdrVHRXTS9KSWlaNXVaRy9uY3BTWElOZFpnMkZIb3cvNHNa?=
 =?utf-8?B?bmYyL1E4M05HNy9WNmdDWlJoZTQxcE5XcDVocjk3b2xpM0pQajVhMzkvSUtT?=
 =?utf-8?B?Wm53Ym9TL2kxWENxcTBsTC9LeXg0L3pZa1B1NGk0WFZiNXNDMGVHTTZpek11?=
 =?utf-8?B?Mng2YUJjWmZYY3psMUh5cEN0L3BLT2VwQVB4LzJkck50WUc4bE5KeE9zdENQ?=
 =?utf-8?B?cEVDWjZUZjdTTVk1bW5jQzVqUko0MkJDK2pVcDFTaU0rZ1dRemQvS1dzVmRZ?=
 =?utf-8?B?dDlQN3J6M0l4cHdwTExPcXRaYnZqT251ekEzOG51aEM4U2JaN0lxQlNtMS85?=
 =?utf-8?B?OG9Iem5QZi9yM0o2dmZJNmdmQzVVVkZ2Y1JWZXZZd0hBRTI3Ry9DSmNWdzhL?=
 =?utf-8?B?RUp1blpHTWtXWnVZZzdNODJoQjRHTUlYcXBRMWdwcmZSZmgyc2lDdVBKTWJI?=
 =?utf-8?B?UkNlMi95bUthTXk1OC8vTW1HUVJLVVhib0lBL043T0JDUGh5YytYNWlabDdX?=
 =?utf-8?B?dmYvTU80U0hoVGhxa1ZSbkJ2bW1xUGprejFPMHdzdjRjWk1GKzdtRUZVRTdK?=
 =?utf-8?Q?8hHgX/yJFQX4ogHY4VOm22hcc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85706df6-2b34-4fd5-1b41-08dc7a7f549f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:50:48.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7ln/iUhgucWFmRcwr5anGWnqsmg42x7aSmwIidZcgN7T6oLn3+Y9vD3x+MMfOnUCB4vmWsm7KLyx/60fNzKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

On 5/21/24 4:10 PM, Zaid Alali wrote:
> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications(1) enables
> EINJv2 by extending set_error_type_with_address strcut.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index cc5ad1f45ea4..2021bea02996 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -50,6 +50,28 @@
>   */
>  static int acpi5;
>  
> +struct syndrome_array {
> +	union {
> +		u32	acpi_id;
> +		u32	device_id;
> +		u32	pcie_sbdf;
> +		u8	fru_id[16];

I would rename fru_id to vendor_id since this isn't necessarily a FRU id. It also has the
added benefit of matching the naming of the vendor field in comp_synd as well.

> +	} comp_id;
> +	union {
> +		u32	proc_synd;
> +		u32	mem_synd;
> +		u32	pcie_synd;
> +		u8	vendor_synd[16];
> +	} comp_synd;
> +};
> +
> +struct einjv2_extension_struct {
> +	u32 length;
> +	u16 revision;
> +	u16 component_arr_count;
> +	struct syndrome_array component_arr[];
> +};
> +
>  struct set_error_type_with_address {
>  	u32	type;
>  	u32	vendor_extension;
> @@ -58,6 +80,7 @@ struct set_error_type_with_address {
>  	u64	memory_address;
>  	u64	memory_address_range;
>  	u32	pcie_sbdf;
> +	struct einjv2_extension_struct einjv2_struct;
>  };
>  enum {
>  	SETWA_FLAGS_APICID = 1,

