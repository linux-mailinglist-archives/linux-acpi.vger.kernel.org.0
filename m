Return-Path: <linux-acpi+bounces-5941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F628CC524
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 18:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC9A1C21C17
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188831420BC;
	Wed, 22 May 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V3OiolpM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1171420C6;
	Wed, 22 May 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396654; cv=fail; b=t4D1C3nZEsc5uezjqDYv3We5BqYtfLhCYyO0XEFbe3b4E3aTetS3v5Xd/Y787VoG1EB8KkKImk3C7LhmesN0uyhYBruyr0g4r4QDrBSOD8HT/iCcX0AR4OvtFEsJYD8koUfsgiEExvildbpLXgShSVv6Na8sDdt9ln8UbwPYKlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396654; c=relaxed/simple;
	bh=VW5wUvU6eUEfTnKJnL6pdHMrQbjRtPKvwjrYvNjjiRY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2KLETob0KTM7mt77ErCFWm5vojauj5mGv+JP/QPOwjyx3zahCP+MHzmi6dNZM5ft3xVVnnSvovCBY8Tl03CAxvfxrpl4O6gvjz6zWaU2qmewHbhEgngSDxMZ/jUSJIPc79PO31zlzOS83Y0Ledu83du+VbkGCN7VMKt1WzDx6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V3OiolpM; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+EM3jdsF6yFzNClnvp+7JXTPz2jIqjnJ8lG8a+y+yQSPXu0atMXFebmjgF9x9AjMU/xHm8Bn6th8i3V21Rc1imtGtpgl4C4x9RnP4zNLXRtmAe9F0Db7f4O+Qh3ClfstEDSilGqdb45baCsNbUVG+n8LrYB4u8WiuxQBMlZ1tjzKywOXHsoS+wof1ETa4yhoO4VaWyK2QPOSu4JHCYX3iUOwZBaSLlRXdHJQtlej3fUo5Io8d6KIVeK3Zm9QQ1DV+MhEtwH0uwfHps4onNTNcZcsCp+ugllZ3EMkIyt8U5iF3IQjyAYtATWcNpohb16fOfL0abBpGMF7ibiKESJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELZJM94d+zIlBa6PIVUv9ZrFzVydTMUT7wyZzQDdQlg=;
 b=kPZEhPBUOwoRfrF8Tsu+uAHBfH4fpvfzDxhnIhG7O+jo2ukewJt2S/zMHMuAyJs3Ji4vTb5hZEbheqCFk1tK20Tn7seAgTU62BAsqS7aB3hIZFj5lJuNFF2VJXgS7Qggqle9swnCrw/rbmLGHAkpcxx5SF4+46MM6Z/O/aJs2EgmR3di2seHjktx92Cf5n7IkYrz1Yq9tCLzPegpgoYNqr5lopSInWjj09iZZc2D+444RwPRBgjmaQpdrSzTOGoQq1g8uFr/xFKFiWx0rnUuyM5BrLTzfscYxYsPDcaQD8PuK2U3G7tKW28ku3fSRXzZQgJM6cuU2oOhukfmDfrd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELZJM94d+zIlBa6PIVUv9ZrFzVydTMUT7wyZzQDdQlg=;
 b=V3OiolpMykcy+QatDy4WQQtrwOxa9kcjd9/w6XZ4H/akJa6HaoungvRHgUsyoIlUuIYbaoD3qujVhj2RD/WxAGDLdDfqULzCtdxpk//3+Kw7LYjVS2Gc+HwMKeLe/fes2WIMCh1SIERCXK5SbCSM9ckrhFaB27QFHCOenncm5II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:50:45 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619%5]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 16:50:45 +0000
Message-ID: <e58a144a-c4f6-4d20-9ef9-56ee225c31db@amd.com>
Date: Wed, 22 May 2024 11:50:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/8] ACPI: APEI: EINJ: Enable the discovery of
 EINJv2 capabilities
To: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
 lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
 robert.moore@intel.com, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
 u.kleine-koenig@pengutronix.de, john.allen@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
 <20240521211036.227674-5-zaidal@os.amperecomputing.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240521211036.227674-5-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 492b8d3b-f355-4e2f-517d-08dc7a7f5347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjhWVHpyUXk1S3hKL2ovQ3ZwNmpaaXlZdlcrTjJvS0R6YlBRb3cwa1d6ekh4?=
 =?utf-8?B?TjdPSkdPY3ZEMXVZZ3ZkZUFrSTAxcVRhY01RL0ppTURVeWJQTGdXTVlsc3B0?=
 =?utf-8?B?azJDNnZuUmdIeEpGVWxtM2hzZnpTOGlyR2loaFI5YStteCt3bzVjMjRqOUdW?=
 =?utf-8?B?cXh0MHJKSittK2pWbVUwbU9waGxzZGRNTksvVEtEZGRTVy9JdS9kUFhDVHNj?=
 =?utf-8?B?UFpoazFSZ29oY0NYYytqalV6UlRhV0ltbzVJbVBNNGUyb05hV0FEY2k3VnZp?=
 =?utf-8?B?MUZNNkE4OVE2c3dQdjk5NjBmU09ZNmtQQm5ldWszZDROamJlTlJ4MFNDVDVl?=
 =?utf-8?B?a1NaWGdvKzdIRjNhWWlBU3BtajhwMHBNMW96elJ5c0tJdmpnclZ4eFZzVVcy?=
 =?utf-8?B?QloxeG0xVzNlMHF1M3kwN2RYV2diVVBHRDVrT2FNK0ZkK215bXo4Y2V4R1Fu?=
 =?utf-8?B?cVc0SDJNM0pPK3M1OWN5QXc4MVduVmFkY1hJbFJTZ0hDbUlkOU95ZzZZOTZF?=
 =?utf-8?B?WE9KMHBCaGVkVGJEd3ZhVnhPTGExUytoQlR0bGxoQ04vaGl2ODlybWVWa1BF?=
 =?utf-8?B?ZHlPd3hmb21PYWVDKzRUb2dBK2JrZDJmRnNXVzJwSVo5RzhoTGpTa2sxcWZ0?=
 =?utf-8?B?TUVjTURCYXNUMmtFTmsxdWJHQkF0cFFOQ1ZRUDFxOXNOOG9PdmNSdDBtRTRD?=
 =?utf-8?B?NzE3T01ZS0tpWFVGeVlmUzBXcEsxN1ZFMHRCTm9NZTVKZzR2N3ZzRWlpRmx3?=
 =?utf-8?B?azRZWTM2alFJcDJ4a0VHZ0R6Y013VUV2LzV0RFRpWkEySDlKUVpvbVRQMEVw?=
 =?utf-8?B?MWFxTU9VNHI1VnJsQnZwUzRXS1JRVGFmTnhpTHZFUm1IYTN3SnpNQVlTWjhN?=
 =?utf-8?B?ZzdHUjZFeWhjN3ZXcUxuRTFrVFlGVmpMU1QwR2tmSml3NlJ1ZVJ6UzA4LzZp?=
 =?utf-8?B?Rmtjc2IxdTNNdzcwTjRjb0I1SmoyMnp0N0FIZDFhWHFxUmRZM1V0NVY4VjEw?=
 =?utf-8?B?SWFBY3hTY0RtUW95am5QUUFUaG1xUWpKUWFQMXhCRHNMTTJQd0RIUjVhdjM1?=
 =?utf-8?B?WWdMei9DMzZKVFk0UVdoVE9mbzZITUdTejg1UjNvL0h2RXFXQkc4a0oxaEc5?=
 =?utf-8?B?Rjc3OTR4UTV3aXVLNkxlYzd1M2paaExTZVJ1R25ZUDJSbHJ1YlBQeUpnRVph?=
 =?utf-8?B?cWIwU1J2OXk3VCtYS0c0WUtCSWgzbGtKK3hXaWR5d3RyK3V0ZjlJbjNVU3BE?=
 =?utf-8?B?STc2REtSYXJpZFEzZlF3c280V1BtaktNYnZ1NlloS3pQcUE3enlyRFdhZFIz?=
 =?utf-8?B?RFg4bWpKcHV6MTFBYmdZUW5zb09NOExWWGNNaVJuT08xZDdRZG85ODJ4RGFa?=
 =?utf-8?B?cnZpYktaK3A0dUlqM0tSeWkvQndKTmV1UzgrYkg0dmtHeTUrNjNQM2hFRndW?=
 =?utf-8?B?TEVSZ3V5ZzlxNS94R0pHdEhzYWdWRlpOTWYyMjJUc1Ara0RUVVpEQTlERU9I?=
 =?utf-8?B?Z1MreU5iQy9MdlduZ3ZBd1lLejBaZHBvT2hPSFc4S3B5T0cxSGcyS3ppZ3ZH?=
 =?utf-8?B?a3g4OExvVm1BcXlSV3ppVEtQMmpVc3ZsTHovUFdMYUxiNG9EaTNUTGt0Y3RG?=
 =?utf-8?B?SVRSYmxNd21jN2FWVXhXbUk3ckI3dU90b2g5YVV6am43S3FvWlZza3NYNm9I?=
 =?utf-8?B?YXhNdnlUQnU3dGJ5bHBYSFJoWVg1eERpVExmMzVzV1FIQU9xTHhzbnNoRDRX?=
 =?utf-8?Q?3WSyi5m8zNiJ5VyTOLNZ/sc3zw7JabIB+yEP3oP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2RiQVlSbHRuc0ZhYVVUdXZYaXNYSWJkSFF0YnhKaVloRVptMUV4bkJkdm03?=
 =?utf-8?B?QVczRkg5Ny9EK3dpbWZ3TDR3NlloOTZTYmJUK1BQVG9BUm0vTTNYYjJEU0dB?=
 =?utf-8?B?YXNRUEljYUg4QUc2T2NiQlZXV3UxS3U1ZUhhZEs0ZkJJOGNqK0Y1NkJDRmts?=
 =?utf-8?B?QXJ2S3lXSFBGRHFwNEljRVNiSTdMeDRFZEVlQnA3b2JLeEVsRlZOSTk4Qmg2?=
 =?utf-8?B?cmxadTg4N1NyWXlxL0dsR3ZuRzB5VmF6TWY5VWFySVIvTlR4dG14TXFEMmVI?=
 =?utf-8?B?L2NobWJQTjJrZEI0MGx1cUlWaC9QVEUwNjJkdVZNNWV6cDE2UG1DNG1kZFhY?=
 =?utf-8?B?aGFiQWdraUJUbktyV3JFSTluMWdxU2g3cHJxR3NNQ01zVk9LWnRCUHBRRTM5?=
 =?utf-8?B?KzFDdERSNEpUTWcweWdZNHRKQUFOSStWem9CZFBONWdLTGZINWkzUFZwYnhG?=
 =?utf-8?B?NlRkNjVPZ3QwTlhFK3hnWXRjZzgycUxhdnhlenk2OFJrVHYxN1NVMTFFUCtH?=
 =?utf-8?B?NVlaZ3NyZjRLTmdSSHVaYjhhL0hzQ0hZa1Ezd1VMcVNBZXFnSlJqWHl0MTl6?=
 =?utf-8?B?YW4xM21GbmpUbDAvMmIvUytHTVNVQzZ4WUs4aENPWEdhcno2a1NNUkxHQmk1?=
 =?utf-8?B?S1QyTmdjODZHMEJxZEFDWTNIOE1SWWZFUWdXWmcxOVdzWHQ3NFQ1UmRKb2NF?=
 =?utf-8?B?ZnpNaVRVd0QyUm90WlpRR1UxZUhCSFo0OU5KWk8vWktxUmVUVkM3emZQclRL?=
 =?utf-8?B?V2htd0NEamFZYzBtWERlbXFhNDFQSlp0bjdYUWVGd1hSMXp5SHdvZm1EdFd3?=
 =?utf-8?B?Y1cwTnppbkVtY210djVhZGRCa1BHdHhXZFovNDRUc05la3ZUN3pKT1dVUEIz?=
 =?utf-8?B?cE9FOW1XT25tejNxeldpYmMwbDltc2JnT2x3NmdmSzVwazg4STU0SXQ1aXVX?=
 =?utf-8?B?U3dpK2ptcjVWclBIWEZtUUZmc1dkc1pmL1l1dldyQW1SQXVNZHBuSEVTT3hF?=
 =?utf-8?B?TzFIV0ljRHp2RjMxMlQrNFc1MDdtUU9IR2lOTU9uVjVNeFF3UHFkZ3Z5NXBX?=
 =?utf-8?B?dE5zMkYxaGNpaXVKakJpTVlMdHU0cjJqQWR6QnZ6Q0IrVWQ5ZFUzdmZXRUU3?=
 =?utf-8?B?Rzd3UStmYjFrWXpnK3VHRjNnZTZUYmdxUnRMYlJ1eWszWUJsTHFRN3NJazgx?=
 =?utf-8?B?RFZnU1ZKVTZ2eEFiQmFBSi9pZ1k3VDNLNm83M252MEM1c1ZTOVRJN1A3aG9K?=
 =?utf-8?B?ZGFTRUR1bDhxUHcxUzc0TDNGVkt0RzlmZitjTUluc052VUZ5aC9CeVM5N0ti?=
 =?utf-8?B?RE11VVNMTDVtamhWTHZvaGFGTkthZWN5c2dEUGo3K3dPQXZaT2dKdUdWMVVX?=
 =?utf-8?B?NUp6OGRNSi9HRnpoc1FaTnlDS2JxdktxMy9CNnphVEZJVmtRWnZId09qMktB?=
 =?utf-8?B?aDhHcEM2TndsN014djM4Z3pHOVNDc3EyczhPcXU5SVJIRnJkaHZCdUloSWMv?=
 =?utf-8?B?UXVmelVsYmhTSEJKNUVTQmQ3clMxZktpRGptbUsyNmovY05tRXFVTW1GNWN1?=
 =?utf-8?B?b21pRnFYcWplRDlrRzFtUFVVMDc3V29WeEowamsrLy92MTFMblpsRlR4Unlq?=
 =?utf-8?B?bVcwa1NUZ3VjazZmNW5wQ3RyOFN2bmsvSjlRWFN0SlRjQjczbjhDNDBYdU4z?=
 =?utf-8?B?UjVxckRUYlNWQ3dOdlBlUHZPSERFVFA4VTA1L0I3UlIxTTBNZWUzMm5MdTFt?=
 =?utf-8?B?Vk5QUUh2TVc0aGNFOW5mMThiTUpuS0RWZnNzNzFINElYZ0R2MUhHQXh2bU9X?=
 =?utf-8?B?ZTRiMzdtRWo4dzcrTFIySWR3eGpPVnE3d1N2VVRLNVJ4NVdESzdEaFdVSlFn?=
 =?utf-8?B?Q2l5a0EyclY0QndHcGV3VTRqbUU3WmllYXE2T3drZGdzQzNOZjIvVTgvUVBz?=
 =?utf-8?B?d2NqMzdoRytqS0RqeHlQM05OOUVEMVhRZ2IvWURzZkhoUVV5VTlWajg3TDEr?=
 =?utf-8?B?RE9vWS9YSVNDelFwM1N5c3cxUmRCTlRheGtUcE0yRmFwRldYRVIveVJ5T2JI?=
 =?utf-8?B?SXdUZTZUR1AzZm1JQmFacXRhNkc3Y2NUOTQ2U3h1NEhLTjZRNW5oeXNaWGdT?=
 =?utf-8?Q?Cca7n7ta6aRw8gUIVPfvH5iCt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492b8d3b-f355-4e2f-517d-08dc7a7f5347
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 16:50:45.7799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZDeOJIacpvtnn7gqkKKdlsVM2zXjFAKKOiWZLdP6DfseDwFnfbqbrA0aHYYV2KQIagO3Lo9uDGouWpcgsqCag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

Hi Zaid,

I've got comments inline with a couple (mostly little) concerns, but this looks really good so far!

On 5/21/24 4:10 PM, Zaid Alali wrote:
> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/apei-internal.h |  2 +-
>  drivers/acpi/apei/einj-core.c     | 35 ++++++++++++++++++++++++-------
>  drivers/acpi/apei/einj-cxl.c      |  2 +-
>  3 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index cd2766c69d78..9a3dbaeed39a 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  
>  int apei_osc_setup(void);
>  
> -int einj_get_available_error_type(u32 *type);
> +int einj_get_available_error_type(u32 *type, int version);
>  int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  		      u64 param4);
>  int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index b1bbbee9c664..cc5ad1f45ea4 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -33,6 +33,7 @@
>  #define SLEEP_UNIT_MAX		5000			/* 5ms */
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
> +#define ACPI65_EINJV2_SUPP	BIT(30)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> @@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>  
>  static u32 available_error_type;
> +static u32 available_error_type_v2;
>  
>  /*
>   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
> @@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
>  }
>  
> -static int __einj_get_available_error_type(u32 *type)
> +static int __einj_get_available_error_type(u32 *type, int version)
>  {
>  	struct apei_exec_context ctx;
>  	int rc;
>  
>  	einj_exec_ctx_init(&ctx);
> -	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
> +	rc = apei_exec_run(&ctx, version);
>  	if (rc)
>  		return rc;
>  	*type = apei_exec_ctx_get_output(&ctx);
> @@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type, int version)
>  {
>  	int rc;
>  
>  	mutex_lock(&einj_mutex);
> -	rc = __einj_get_available_error_type(type);
> +	rc = __einj_get_available_error_type(type, version);
>  	mutex_unlock(&einj_mutex);
>  
>  	return rc;
> @@ -647,15 +649,27 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(11), "Platform Uncorrectable fatal"},
>  	{ BIT(31), "Vendor Defined Error Types" },
>  };
> +static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
> +	{ BIT(0), "EINJV2 Processor Error" },
> +	{ BIT(1), "EINJV2 Memory Error" },
> +	{ BIT(2), "EINJV2 PCI Express Error" },
> +};
>  
>  static int available_error_type_show(struct seq_file *m, void *v)
>  {
>  
> +	seq_printf(m, "EINJ error types:\n");
>  	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
>  		if (available_error_type & einj_error_type_string[pos].mask)
>  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
> -				   einj_error_type_string[pos].str);
> -
> +					   einj_error_type_string[pos].str);
> +	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +		seq_printf(m, "EINJv2 error types:\n");

I think this print and the added one above are not needed since the EINJv2 error type
strings have EINJV2 in them already.

> +		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
> +			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
> +				seq_printf(m, "0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
> +						   einjv2_error_type_string[pos].str);
> +	}
>  	return 0;
>  }
>  
> @@ -692,7 +706,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type | available_error_type_v2)))
>  			return -EINVAL;

I don't think this will work? Take the following scenario:

available_error_type = 0x2
available_error_type_v2 = 0x1

If I specify an error type of 0x1 and then inject a EINJv1 error I will have
injected an invalid error type, but still have passed the validation check.
I think you can just get rid of the check for the EINJv2 type here since you also
check it before the actual injection in patch 7/8.

>  
>  	return 0;
> @@ -769,9 +783,14 @@ static int __init einj_probe(struct platform_device *pdev)
>  		goto err_put_table;
>  	}
>  
> -	rc = einj_get_available_error_type(&available_error_type);
> +	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
> +	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +		rc = einj_get_available_error_type(&available_error_type_v2, ACPI_EINJV2_GET_ERROR_TYPE);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	rc = -ENOMEM;
>  	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index 8b8be0c90709..25adc9b03d18 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  	int cxl_err, rc;
>  	u32 available_error_type = 0;
>  
> -	rc = einj_get_available_error_type(&available_error_type);
> +	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
>  

