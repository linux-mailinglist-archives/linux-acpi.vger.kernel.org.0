Return-Path: <linux-acpi+bounces-20794-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UkRADZoKfmkrVAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20794-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 14:58:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4CC2189
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 14:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191593007C92
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5C3542EC;
	Sat, 31 Jan 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8QVUsD4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAA343D9D;
	Sat, 31 Jan 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769867927; cv=fail; b=VMvh1qAGr92rr/DOG6EdpwrgFx0YyUNIylQPeB0DCkr2V977HNwB7ApQSm1eUqBP9hCbq25dxuegQYlHjZXUeeGc/g/JagsdwHGRB/pzBrmPWf6sVgmI33IIwSofMTn+jRbsIp4zeRB1vAaY2FTdwwU+KOvuEXZDY+Kvvvnipp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769867927; c=relaxed/simple;
	bh=IWe6g+O3OORWZF5yBeOUPSxV45hePwsj0G8XHSOmTM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J4O9Z2mrLGzxBKaP7x50DsgoGXd/DBQ9Zaf2yHZe5YmY0AlxSTxPbQrMqE2lGlCKS/429ii6lWkGe1aEbrW3VCWHl9Omh1KQvyFTwgx1jFCOXF52Yf1ghzYVDrvwh8Z5PGOs/EAU0JdiCtOb6TY7CO/OS59VNN6MkKjpeQHLxEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8QVUsD4; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4XomHXhpcy6d3BOV77ykUcAJEHabNM0F6RZUm/T3Zt7G9/LBAdyY2zA11tlLXft5Nl0cHy4cXPUePn27+tfNJaZcf6YQ2/FWJnaZ01uBSWply+6XpNaIezVzvRK4LSy0UA9Ml+6sUdhrN7/qtdiJgb+CLOHLWf0cQKxHCH6PRzBZSYNSbuMi/fcJsIN/4LvDlsFO4TwSvSzLS5aUK/AeA7c7WLoC+Z2nIBwY/laS9QPD1uP4RcaJv3byapU9pchnfD4vY5HGcLIhZFCRGEivOsiAZkazEcHsDs79JKs8/bi3FUlNy38RcrjsMyUdZKmFt/TI8JF2kDjRsSE+27MAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toBr/iy64AGRkHu312gIej0WuMvFifCnazsrT1jbZNY=;
 b=DgC1hdQn4chF+5n2uSZrQHiBAr1mT1EYBbtKsXAKlFbqFysCWYZjqUEapJD6sMT1K6juVA6DOhBwGvSJW5eE6SbQdyPEcSz/3Is0XKWfaYq4ZEljqyr93w+HaSmxTSYzo+L0uKaFYBW0xYvGZCOMFHuRPl34lGr1EGcGGEh87HXDwn5GOncHjbcc/Ggv5sXZmPNt3WZ6WmmN/3V6GXN41uva/PJyt5PKTgzx/7EtllqCbgiI/P7Rcvpp6XRkjVBvQbY+0TSpkMANF8IusBuzlmBbSXzcf8eUIXuJm7WKlH3C+ztIeuxFMfE/PNBEZGg25hlvUXpKAr1MlxNVpabAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toBr/iy64AGRkHu312gIej0WuMvFifCnazsrT1jbZNY=;
 b=f8QVUsD4rEy09WUX+62Q850fRgl9LKVpzQhK9D0W36Y1j1yEzTUOSAdDR69MuojQG7b9/EZzYviqN7ALbFMAEisTz7lNF32+rtodqH8vmjjn7Q1lgG9rUjj+qM4GuejfFXgqj9YryxdaDY9HghLd4vI9g4gOlbB5mkOkQvYbh5pIIkxz4b+LnnbbKEJAIBQqcNpB5Ja2jJ4BH1i6CP8La7M+Ln7gZkxSCWGOSNIGexTBdeorHUwa3KjIU2R0xwa1KjBTpYELGHPuafcqUWtD3z0OLQk8ztsjqaK5oQ04+oK3GntZStY+sjRngM8pFK9Sperj2RdStETRnL8YI4sQpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Sat, 31 Jan
 2026 13:58:41 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 13:58:41 +0000
Message-ID: <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
Date: Sat, 31 Jan 2026 19:28:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, pierre.gondois@arm.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0272.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: d2623a9a-2372-4dc1-0a76-08de60d0d6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjVBejJjSVZqTENZM1NBNitOck12MHhXTnpUcjRzYUFydEtZYzZJTmRaRXIw?=
 =?utf-8?B?L1JJNUl0akxhb0sxRmRLbWF1cmt5Y1c0Mk5Qanp0OTc0UWs4RUpRNlEyV20z?=
 =?utf-8?B?MktRQ3lWZ25OeU5zeWVqTFJUbWZaMjB4WnY2N0VPSG8xWHdheWtCWGU1eVdO?=
 =?utf-8?B?NHBxTGJCWnZ4MEpTdEhYa2sxVmZSeCtsTThtRm5neStESk9XemJ1QWt4cyta?=
 =?utf-8?B?VExKdzZtd2pvbXJJT284eVZlZWRxUWJjRVdLMnlpOFpnTlp1SWRBeVhBQ0Fs?=
 =?utf-8?B?ejYrRkxJNFNsTW1nOWNxYmVKSE1tcm45QUJIb05jbG45eFNKc1Z6UDYxK3ZG?=
 =?utf-8?B?Y2g3RTVLY1JEeWU3cGZ3aklZWmRROHJCZDFsMnN3a2dVajlnUlNxdGJuL1Bu?=
 =?utf-8?B?UlFmVGt1QlVMN2hwWTFQN2ltMU9Eai9WS2lHY3JJNk45VkRBbHM4azRoUm5x?=
 =?utf-8?B?TW90bUZnZ1BscXF2NENZdlNvQnZGOHIwa2lyTEMyN0RJMlVkS3hMK2d6elM5?=
 =?utf-8?B?bkJEKzkrdnMvNEQ2ZkdjaDRFdTVTN0JSQ2lwTHNIeUZ3cUdLdDFHdTUrRVFF?=
 =?utf-8?B?UThZTHJpTWl4SHJSYWdKODJlM21CMzFJVituNERtOWRuamxxQitzcldFdmV3?=
 =?utf-8?B?UU9FelgydHJpNkFBYStKUGRpYlY3YWo5M200aTdiN0tuTERLdFQvRTBFRUYv?=
 =?utf-8?B?V2xCV1BZdXFLVVdSWUNQTXNrdWZDdFNnMUxBNDI0NGdCN2d6Y2xOV0ljSUs4?=
 =?utf-8?B?bytSajIrTmhONEduWkJVL3haVnFFbTR5djJ1d2ZIYmJPc3VqK1d4VEhpNk5Q?=
 =?utf-8?B?anp4QVpidXE2UTBIWGVsdHVkT2FEZURScW94VkxIY05uYTFmclRLb3JUU2FG?=
 =?utf-8?B?bjR3ckRIcnlVVWNQb3ZkejZpa0pVSWFZSU1TRmNtSis1WTNrLzBWaHNLb1hL?=
 =?utf-8?B?VDdReTh4R1VYT3E0bjdPS3FOai9RNjFQU3ZoQWljMkpmYnorVkJ4ejlXQnlm?=
 =?utf-8?B?MlFkejcyWm05NmtpRVlleU5XMlY3NmEzSENOelZ1QTI2TVpEV3c1ZlV1VWNS?=
 =?utf-8?B?MktsNStWc2wrVlNGWWdRajlienhMUlVUeTBWdzhPUm1Idm5YZ0xxMm9VSTN1?=
 =?utf-8?B?amxRSkNZS3g2dklnNnRBZmRVbHUxMGp0aW9DZ1VKWkZWbXh4Wm84bDdZWUxq?=
 =?utf-8?B?VUViQ1grb3RueG8zcVlTWDNyZlVzS09JbjV3NklIV09qWUdTaENMSE8zMDg1?=
 =?utf-8?B?UDJGUk5RcEY0VFM0dnp0UzZTZWFGMmxDSk1jbTIyQ1htVUxyZVJyRU5YekMw?=
 =?utf-8?B?dkVkaXljbUlId2JpeGdtQUZseHlHSTJodmhQZUZXT1pOYzJ5cjZXZ2hrUEpa?=
 =?utf-8?B?UlpXVlAwOHhDWDhlZGdPamxxelJHNDVrYmhKRGlmSnlySUpEcEdGakFidmIw?=
 =?utf-8?B?OVZpR3U2ZEQ3U2RqUTRlZFVQRnh5eDVnbWlyRXVlcFlCTUJnSEhTM2NUdkFG?=
 =?utf-8?B?TUlQTVZxbXRlMzRVVnl0L0N2YnI2VFdTRG1yb3JYTGFVajVBbzV3MFMwaW4v?=
 =?utf-8?B?dkFVbWVsdWk2QUdWRnRyQVprcklKU0VBQmlxdGJLRXJiRE5zdVprNmdyMzk3?=
 =?utf-8?B?SzBmbi9aM1p6U1RVNzNvUFVKQksyQitjNXVBZjd6MDNjSWhtaVlkMkQweWZ1?=
 =?utf-8?B?RkdQUTh6emRzVGI3TTFaRG9iMW9vaVFxZldYMTlSOHVtc0JiTnFqQzlWNkEy?=
 =?utf-8?B?eUFmRHM2cktHQmxURDBkdkdQWmNkaEp4VGx0alcvN05sSzhTWWVCSkFvYmVB?=
 =?utf-8?B?ZlppNW1kNUJMRTlYWnA5UUVHS242bHJRZUJEdUI3bDVLNEJMcVFwdlJ5ZmRn?=
 =?utf-8?B?eEpnRGdGZmxINlNKSXM5Zm5kY0JhZVdHbnlqMng0K01Bdml6NzhDS2FLS0U5?=
 =?utf-8?B?RGFWL2VoOGNCNmFRUU96ZHhUVU1xNWNGbUtvTmFucU9yVGdvZFRwL3ord3NX?=
 =?utf-8?B?ZFJVMEVrQVBVQWcrUit4VkFXNlI1SjFBcXZ1WWMzazNUbUZiSVdYZWJ2aFo3?=
 =?utf-8?B?YnlYRElyNVhIODA2ajgyOGVsSUVKbjFicnpTSjI5UkNyVDgvUi9TSTFsbDhE?=
 =?utf-8?Q?AnG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWI2bXd3WHBrVm1sRVo3ekJheVRjdGtnaC9LKzV4Mzc3NDJEbUtMSkl2M1Fz?=
 =?utf-8?B?aVhETE4wWVpTMjdrR1dkRVNlSHNCUTJQdDl4cFU1d3p0ZUwwNjFqMXQyNnFV?=
 =?utf-8?B?UFdwRGFTZUZaWnJTckt5T09qMis2b0grUkdZMXBZQ2hHUm14WnJtMERZWjVB?=
 =?utf-8?B?Z211ZlRHVjA2SWlYT2dTRXd0RTBqUWJrMER4aVpOeDJzVnZGd2haK3hBVlhP?=
 =?utf-8?B?UkNHbGNMb2hGZkp1c3BGYmFLUGdHaHFUQkkwMUlPbVdlTEJCQnpzaVRPa2RC?=
 =?utf-8?B?WVlBL1RRR3luakxjL3dXOEVvL3RCOG1jNVI5TGZTSlQwak1sMUpsM2k0RjJl?=
 =?utf-8?B?djNyNzBESzdQTnlUZlNzNUp0bXN3NmRBSHlWWitsajl0alpHNEZqc0NDdDAr?=
 =?utf-8?B?WGdoRGlnekRKNlhzQkdKbXBNakprUGMrcm9nU2RlNWxQZGxZbXpmakZOZVpy?=
 =?utf-8?B?QzhZcFN6RXdGZDhKczgyd3c2NUpoT0JZUkk5dDhIUjM4ODhuMkdGK1MxZXpX?=
 =?utf-8?B?UEVPVUtjdmxNamJxZElXQlBzdmZCRXlZcDVWZ1BlQlRURUgvNXV0RzhWRTlp?=
 =?utf-8?B?Zlh3czVXQ054VEs3a25uY0xsZGM3TjdMc2x2K3dxMWJuMlE5dkx5MkplVVZO?=
 =?utf-8?B?azliZXhhOFdvMHhJeWJsb1dGb080cWFsVTV5UGRQZnFkTWZ0dzlwWkVnSSsv?=
 =?utf-8?B?b3hmVzZ4WVQ4aFIrdEJVelJNNWU5cE4vNTJwQVJhZTlndmpRZTVKZkczS2dw?=
 =?utf-8?B?dU5MUXowMTl5MHEvWi9vMHhGNG5Wa1Bid0JKU3lDcnFpejYwNlRpTkRBa1Zq?=
 =?utf-8?B?QkJXcFhXVHhrODZleFJ6NCtRSDNTL2VUVnVuNjJXN1Z4TEg1RU5NNWVxbnUw?=
 =?utf-8?B?MXNPeStyMDNOY0FhRldXVDg3SUVaTzZ4SllEUXpZQklvNnNpNVRpMzlwTUl3?=
 =?utf-8?B?T1gzcjdsYVN5SkFmZ0N5K091d1duWldSWHZKNW1MKzZoNnM2RUR1YW9LL3BX?=
 =?utf-8?B?R3dDWHc3STcxU0Y0QUw2QXFrVldKU3I0YzdmMnBKOGJVTG9IVStQUnJXK2NE?=
 =?utf-8?B?NnYreEMxRks4VlZHSDJ4ZEhweTZtRktnZzFlVUErUzdHdDdVQk9oNjdZYkJX?=
 =?utf-8?B?THF4VnZLYmNqTGpWN1d1aFlYN1hQSEhuTTIzdlE4dVp2MFRwR1hZKzNrL0d1?=
 =?utf-8?B?TzJ5Z05Wd0pkTy9aMHZjQ2lXNllFcTJqcDRocW5sZmp2c0I5N2l2UU0yejBv?=
 =?utf-8?B?aVpzT3BwQnRpWFpKZE5yLzZNZ1FkZjFLOG41blhtL0VtYlY1SVdPelVnWVRR?=
 =?utf-8?B?dElZNEZIM3o4YlhNZVhuZk1VZWV4YithbjVsUUpOUXhGMDFXdXUvSmUyVjRZ?=
 =?utf-8?B?WDBJSngzN3RlazM2WmxVdFp5VHdSTnhDZVJubUw4TlRBZ1UvQ3RXcmdnUHU0?=
 =?utf-8?B?SjVPbUtOaFpXUWV4ejduRjRrajZUV1RKNVdzYU1rdmxVNUM1aVNIb0JQbDhM?=
 =?utf-8?B?a3JZaUtYdmtGL3hmRkVBaUJGa3EwNURJNHFxU1crNnIwSjk2czdRckdPZHdw?=
 =?utf-8?B?TkNDdkZsSHEzeVpQYXJzaGE1K0ZzZG4vN0V0VW9kV0VyNDVWR0VEMkxRMG9R?=
 =?utf-8?B?eGhDbjZoeDgrN25NMFRuN3hEemQ2eXhlZ1pzN0VBcmpKbTBxZk9kQVdzWlQ1?=
 =?utf-8?B?blFMOGM1TW56OWJrZk5wVWVWNmNMK3BXUW9KSDA2QTczZUhCaFZGL0pWK1BS?=
 =?utf-8?B?SUZGVmY1UUZOZ0wvNy9lc1k2MlU1VFA4WlBZZkY0NzdEZGcxUmppQW9nUFU0?=
 =?utf-8?B?bzNoSGJ5TkN0VnhuZ3hqNXRNVmNxWk92TDFQSktOYmFJY3pHRXJMaDljNkl1?=
 =?utf-8?B?WThzL2R2elpnTHlzYlpDczhsWUUzVlMvdWY1Q0J4ZWRsOFVReHN3b3RvTm9y?=
 =?utf-8?B?RVJoWHh1RlJFUXBXRWNJT0cxT0pZbjk0bFFveWhHeGdzaDdEMXJyQ2E0ZE56?=
 =?utf-8?B?WXdhNHBPZ21vb051Ukx4eGJ5RHBZLzE2cDZPL3pEVTl3OFZLK2ptT3BHMDAv?=
 =?utf-8?B?VjBUcnpvaFlzV3ovK01xNENYVjlQWjBCeUFGM09ZbVdoVmpMOG0vTFlwWWZU?=
 =?utf-8?B?cTBKQkhnN1JiWGRscnVQc0R6OGE2TWNmSXh6dURtT1NVOHFUeWJtaTlBcjZ1?=
 =?utf-8?B?dVl0QXhLaWQrZTB1ZmZobXY2dW5IZ3c3VVRhWGxVWlI4ZE9qTkhJM0RTN3JU?=
 =?utf-8?B?NVN5UUhTWW9GWkZFWDM1NDdqeFZMZlREekkvOEQ4OC9PcEJ5dWFjZGg5cmU2?=
 =?utf-8?Q?R412e1NgpCqYKZm8MQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2623a9a-2372-4dc1-0a76-08de60d0d6ff
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 13:58:41.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1o6ri7mtPouDeah57ZEdM6oufr8UAjGbcVHMob2buec2JlAyb5NIcNTyyBocnTo/ji9mp3DJ2iC2x1y1x3s9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20794-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 7CD4CC2189
X-Rspamd-Action: no action


On 31/01/26 09:36, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sumit,
>
> I am thinking that maybe it is better to call these two sysfs interface
> 'min_freq' and 'max_freq' as users read and write khz instead of raw value.

Thanks for the suggestion.
Kept min_perf/max_perf to match the CPPC register names
(MIN_PERF/MAX_PERF), making it clear to users familiar with
CPPC what's being controlled.
The kHz unit is documented in the ABI.

Thank you,
Sumit Gupta


>
> On 2026/1/29 18:48, Sumit Gupta wrote:
>> Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
>> write the MIN_PERF and MAX_PERF registers.
>>
>> Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
>> to expose these controls to userspace. The sysfs values are in frequency
>> (kHz) for consistency with other cpufreq sysfs files.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       |  44 +++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 165 +++++++++++++++++++++++++++++++++
>>   include/acpi/cppc_acpi.h       |  20 ++++
>>   3 files changed, 229 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 08e62b58eb83..b2b8daab69ed 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1753,6 +1753,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>>
>> +/**
>> + * cppc_get_min_perf - Read minimum performance register.
>> + * @cpu: CPU from which to read register.
>> + * @min_perf: Return address.
>> + */
>> +int cppc_get_min_perf(int cpu, u64 *min_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
>> +
>> +/**
>> + * cppc_set_min_perf - Write minimum performance register.
>> + * @cpu: CPU to which to write register.
>> + * @min_perf: the desired minimum performance value to be updated.
>> + */
>> +int cppc_set_min_perf(int cpu, u32 min_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
>> +
>> +/**
>> + * cppc_get_max_perf - Read maximum performance register.
>> + * @cpu: CPU from which to read register.
>> + * @max_perf: Return address.
>> + */
>> +int cppc_get_max_perf(int cpu, u64 *max_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
>> +
>> +/**
>> + * cppc_set_max_perf - Write maximum performance register.
>> + * @cpu: CPU to which to write register.
>> + * @max_perf: the desired maximum performance value to be updated.
>> + */
>> +int cppc_set_max_perf(int cpu, u32 max_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>> +
>>   /**
>>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>>    * Continuous Performance Control package EnableRegister field.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 1421f30e87e4..8787185cd8b0 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -570,6 +570,35 @@ static void populate_efficiency_class(void)
>>   }
>>   #endif
>>
>> +/* Set min/max performance HW register and cache the value */
>> +static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
>> +                                   u64 val, bool is_min)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     unsigned int cpu = policy->cpu;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     perf = clamp(val, caps->lowest_perf, caps->highest_perf);
>> +
>> +     ret = is_min ? cppc_set_min_perf(cpu, perf) :
>> +                    cppc_set_max_perf(cpu, perf);
>> +     if (ret) {
>> +             if (ret != -EOPNOTSUPP)
>> +                     pr_warn("CPU%d: set %s_perf=%u failed (%d)\n",
>> +                             cpu, is_min ? "min" : "max", perf, ret);
>> +             return ret;
>> +     }
>> +
>> +     if (is_min)
>> +             cpu_data->perf_ctrls.min_perf = perf;
>> +     else
>> +             cpu_data->perf_ctrls.max_perf = perf;
>> +
>> +     return 0;
>> +}
>> +
>>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>   {
>>        struct cppc_cpudata *cpu_data;
>> @@ -919,16 +948,152 @@ CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
>>   CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
>>                         cppc_get_epp_perf, cppc_set_epp)
>>
>> +/**
>> + * show_min_perf - Show minimum performance as frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>> + *
>> + * Reads the MIN_PERF register and converts the performance value to
>> + * frequency (kHz).
>> + */
>> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = cppc_get_min_perf(policy->cpu, &perf);
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Use lowest_perf if register is uninitialized or out of range */
>> +     if (perf == 0 || perf < caps->lowest_perf)
>> +             perf = caps->lowest_perf;
>> +
>> +     /* Convert performance to frequency (kHz) for user */
>> +     return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
>> +}
>> +
>> +/**
>> + * store_min_perf - Set minimum performance from frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer containing the frequency value
>> + * @count: size of @buf
>> + *
>> + * Converts the user-provided frequency (kHz) to a performance value
>> + * and writes it to the MIN_PERF register.
>> + */
>> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
>> +                           size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Convert frequency (kHz) to performance value */
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +     /*
>> +      * min_perf must be less than or equal to max_perf.
>> +      * Skip check if max_perf is 0 (uninitialized).
>> +      */
>> +     if (cpu_data->perf_ctrls.max_perf &&
>> +         perf > cpu_data->perf_ctrls.max_perf)
>> +             return -EINVAL;
>> +
>> +     ret = cppc_cpufreq_set_mperf_reg(policy, perf, true);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>> +/**
>> + * show_max_perf - Show maximum performance as frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer to write the frequency value to
>> + *
>> + * Reads the MAX_PERF register and converts the performance value to
>> + * frequency (kHz).
>> + */
>> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = cppc_get_max_perf(policy->cpu, &perf);
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Use highest_perf if register is uninitialized or out of range */
>> +     if (perf == 0 || perf > caps->highest_perf)
>> +             perf = caps->highest_perf;
>> +
>> +     /* Convert performance to frequency (kHz) for user */
>> +     return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
>> +}
>> +
>> +/**
>> + * store_max_perf - Set maximum performance from frequency (kHz)
>> + * @policy: cpufreq policy
>> + * @buf: buffer containing the frequency value
>> + * @count: size of @buf
>> + *
>> + * Converts the user-provided frequency (kHz) to a performance value
>> + * and writes it to the MAX_PERF register.
>> + */
>> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>> +                           size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Convert frequency (kHz) to performance value */
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +     /* max_perf must be greater than or equal to min_perf */
>> +     if (perf < cpu_data->perf_ctrls.min_perf)
>> +             return -EINVAL;
>> +
>> +     ret = cppc_cpufreq_set_mperf_reg(policy, perf, false);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>> +cpufreq_freq_attr_rw(min_perf);
>> +cpufreq_freq_attr_rw(max_perf);
>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>        &freqdomain_cpus,
>>        &auto_select,
>>        &auto_act_window,
>>        &energy_performance_preference_val,
>> +     &min_perf,
>> +     &max_perf,
>>        NULL,
>>   };
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 3fc796c0d902..b358440cd0e2 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -174,6 +174,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>>   extern int cppc_set_auto_sel(int cpu, bool enable);
>> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>> +extern int cppc_set_min_perf(int cpu, u32 min_perf);
>> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>> +extern int cppc_set_max_perf(int cpu, u32 max_perf);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>>   extern int amd_detect_prefcore(bool *detected);
>> @@ -270,6 +274,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
>>   {
>>        return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_min_perf(int cpu, u32 min_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_set_max_perf(int cpu, u32 max_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>>   {
>>        return -ENODEV;

