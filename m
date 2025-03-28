Return-Path: <linux-acpi+bounces-12527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B532AA74BB5
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368A91B65347
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC47621D3C9;
	Fri, 28 Mar 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qb3lgC8y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1821CC54;
	Fri, 28 Mar 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169367; cv=fail; b=ZggFJX66G88bRuY5PaJEk0FfDQky5Jfltt4jcyB0JpY0mITAGU/agV6ml6ptSgQdfmycWyPJ0W+K1K2X1hmCnhAuUNkmblOAOlCIjKlG8vFpMLRB96FMyfmoQjHYREIP6rrZyrpaX1xwWwQtV73zTEBMksEa9RBhI3rVmA6DF0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169367; c=relaxed/simple;
	bh=6urHq2KcZjo5xQWL7WtvzW8Dzh3hG9WSe/1DMxr+9To=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dRHRO4GqVFIDObtmuDpwYR8aiDCgwujk4jLoPRJAuMjH8lJdLp7+HKhexGuGr5tVKuxzrDs8RQwLcsCp7XIK2WlrmTEZgq1diXqt4+FM4RDpSlg4X7qjnSsuZ6C6po2wBHyaM+7s3nC9cJ7ywkvmEoVqVeyVi9ZgGIoYiJtyODo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qb3lgC8y; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCTC9P+M6q3Ds/trTejeJJHpQ7PhpxlwW6Zd21zurqVFxCMXGn76hUjMWaxr1Cpl7YHXAJPl5OghUlycBGOaGWvpaYFEeZwy0tDfTyqnS9yVS0Q645rRQ5expMaaiE545fCTLJ4Hq5fKDc4yo9VMoKRsKMPfZseexg4QoQwEszCOed/fgBybnhKA9hJ1RB4UbNeFdZUIrQwqt+xkqVvn76XRWJYz984ZAhHoRUSp+c/l+AvWY2fB1X/MgZ+oPzMP7Jn3wyUhCHZgxn+n/iYfMjCT7jdMRn78+WMJaoj4MIURO5NMejm5MtRsoTiJwrYVqiIMyW1jw8PNDqAhk4ZPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/YXDPKKMlxvxJjPPmisZ9qXvO2ESzscbDB7L+rxyAg=;
 b=yP8DFzzzwnqhQRlEWNMRg3tKjdstZDxl/DKBCr2LTqj+l8FqVNhwHegeT04hGX3NwUuNOLs3echwBgsmfMLqvCdvcvHpGGrZ78OLNe8CR4IdXqLb7h3gz4zN86LDHA98wRkaz0X7BHYpXrB3Gc2zUgFvrvQU4BawOuMHyt4Bb2rfP/5JtRIndMXxsP4ot2r3Rx3r+IEZ3gKoDSmMPtrRork5E9l2ohUWk2DUFKkc88D5yXi+T1ZFG3u0WdGx4HV6G/dPaZZL9I5xD+0dkwqHLtO1Ie342tYTqAC1kUldWu/DNuUcx9t48PZ0wQIP8N+G2ffF0zMp5UhC6NmrEPvNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/YXDPKKMlxvxJjPPmisZ9qXvO2ESzscbDB7L+rxyAg=;
 b=qb3lgC8ykE/EpX1t3FQRRPFTPiPtvwlYcF2Beuyt0wt+PJ119rpfcERnAsE4DaSSwF9DqIccmoar6tNGys9ZuzI0/CHogme2d+uLOM1OmVTs0g/8QXa66BHnbWHY2pqPuujblexUkI32oB0kLVnra1f9R6PQAi+jtuqB6O1LLC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 13:42:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:42:43 +0000
Message-ID: <efae4aa5-29e4-4811-a91a-3f6182ccbe65@amd.com>
Date: Fri, 28 Mar 2025 08:42:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: "Rafael J. Wysocki" <rafael@kernel.org>, Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Hung <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
 <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: a303eeb7-32ac-4f1e-c00a-08dd6dfe6a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0ROK04raVBSTWZpTFZNeEpvbXFTbEhyVWVUSExQdThXLzh5ZVhIVmpSNDdn?=
 =?utf-8?B?Y0tzbStoNjZFRUd2OWhQeWFpQStqSDlYZ0VsbERDSEZrUEVBVUpsZTVadWxo?=
 =?utf-8?B?NEhITXYrTVM4b2o0ZG9iUWtSamYrck0zam52MCtWSkNtTFpORnE5WGdMTDJG?=
 =?utf-8?B?UzBzZGoxYjFJN1RNbWozM2R6SjdteHFjT3NzellmQlNHaU1Bdkt6YXVwMDJW?=
 =?utf-8?B?SHNaZ2VwWlRlYlpPdkNqNVBpRkFCcU5kcUQwSUQ1cVN6UHlmRkVGRW5WTG1y?=
 =?utf-8?B?SDk5VUFkaSt2dnlXeDgvNmlnMDRueUF1SGxhVlZ0K1RTVEk1VHZ3eFIxbGVD?=
 =?utf-8?B?c1hobExzcTdnQlVUM0ZOemErVS9jc0pYb2lEZVhGYnlOZkZ3Vmx0TWtBSHFY?=
 =?utf-8?B?MUR2N0ZvWHJOT1BYK3VjZm91UzB5cHlsWjJKOXBMN0FYV21rbVlLdUkxTGxs?=
 =?utf-8?B?UFRsa1o1cDVJWWxjbWg1NU13WEluL1IybTNEdU1ZNlZKVFdXcldPa2dkMW9U?=
 =?utf-8?B?Znd0aUlnQVhyQ2FqTGo1Q0FsS1FPeC92MmtWMzdOWXpDRmZZZURWVXI5S0ZI?=
 =?utf-8?B?SVZvWTlVR1BPbmptZk5aRzZraFVsYkUwMmFqYzNXS3BwZkpTK3hYek1zUS9t?=
 =?utf-8?B?NkdQN3NTUnA3b1UxbmVmbHRENWRxbW52eEZjaTgwWnFoQVNicVB3VjVaakto?=
 =?utf-8?B?dnlqbjdLU2NuZFRKWUVSQUZMSTg2aVJWMUdqNmM0RzVoVS9PM29LVzdTeW1U?=
 =?utf-8?B?Tk03eHlNZVlQeTUxdkF2N2pYVlF4MkQrL2FZVkZRZERDa1hFTzhDdXMzbVVM?=
 =?utf-8?B?S05pSUxSR0w0ZThNVVRvdmwrK1BrM0MzdmhHTTIrUUdZcHVwdDJMelVzditj?=
 =?utf-8?B?WitKQWxRWU9vZFpEWWlwRVBjbUdFNkpqdmVVSUNXUk10OUZiTk4wbkZDb3hr?=
 =?utf-8?B?K0IrRTRNd1RacS9xNUJXbTRxV0pBWCs3Z3c3ZFdWOTh5cnVmY2cyMjNheDZB?=
 =?utf-8?B?SGNHcWZtVkFPcEt6STVCMm5TZ1l3MXlZZFZLMFV2L0h6SFA0aTRySUl5N1RW?=
 =?utf-8?B?RFlNeGNXdUppWGdqNElVNXlKVjRlbDRwdzRTTUF1Q3l1Y2RZc2RtaTg5Um9m?=
 =?utf-8?B?MFkrd3NUUmhRMDNvSU9XUmdnUG1TUisyN2RqeGorRUhxMjRsQ01QTWxTMEdh?=
 =?utf-8?B?b3JmY1FIelUzZTVUcFROVXVFUkpwNHF4SEdpYldZOWxPVGt4SWhGS3pPQXVs?=
 =?utf-8?B?NjVIMExZdUU0WEJLVFM2cmdZRE1MSGk0Mlc1eUtPWFZza3Zibzk3Tk85ZW9Q?=
 =?utf-8?B?V1F5UEhOSkJiWllySDZoSHdnNndxUmU0NDJrVXFxS0F2NnlITURKRFZaSGhW?=
 =?utf-8?B?Rnl2OC9QNktIa1FFVXRCN1BVYXB4Q1B0Yy9LbTNBaFBmd0l4d2V2VGlYUjNk?=
 =?utf-8?B?TVVRdnhiK0taNEZmVG1WbGZ0bFRGK25zOG9sa0RCQk9ORnM2bmY3bW1ldk40?=
 =?utf-8?B?ZU93ZkJXL1hrNXc1bE85bnA3Qy81NUtnQWwxaEh0bTNMeHBSVldicFdTdHpj?=
 =?utf-8?B?M1N5UEhDc1Vady9JQkU1WHVIOUhrSWRDS0UwNFVPOUR5YUhveC9tdWpYS3RS?=
 =?utf-8?B?M09zakpCRnlReXQwUXMzYkoySGdrSUNpMFdlQUNQUWptN1VkT2pRd2JUTkFF?=
 =?utf-8?B?d1BzbU5telpoTkdKWGxmQnhmb1hydHpqaXI1c3Z0RlJvdnMwd1JjOVJBQWxO?=
 =?utf-8?B?MCtGdkhZYVVpcTZnWlVrNk1ta2Vab3Y0MUlObEEvZ2M1YWNCbUVKbVA0MmFq?=
 =?utf-8?Q?5wovNAHXdSJzxmZQUhwAZDDzPsf/RsfJd3hv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE1ybHBxajRsMjBCaFdJT2F3WnFLTlZkUkdOVm90ZnJXMmVHMERveVB3NXFv?=
 =?utf-8?B?REFjSnI4amRUTEtzcFdxakJhMjY4UWo5bi9QbTBhUnFYN3p0aGh1S2RXNEdi?=
 =?utf-8?B?KzU1ZHFtNVBWK2h4VFZhbHZveGZlajlwK295eGczZXQ4MGJmR3JGbGFrWHdz?=
 =?utf-8?B?UG0wTHJEbnlHVWdmVmRIZW9RTjJEU0ExK01JeXZaZnBvQXJ3aWN0WDNPZjdz?=
 =?utf-8?B?ZTdudHIvNXl3ZXZvSFRmVkpOQnZmYlI0OE5WcjdiSy9La2M1dXdBL0crVFor?=
 =?utf-8?B?NVJLVkZsdUxGUFFYdUpZTVdXa0hiSVNhY1p0a3BDdEtJTmN2RWNwUm5sOG4z?=
 =?utf-8?B?RmJZYllzUExXWWFITGdkNmhYZjZMdUZiY3cwQVIveWVweDI3TVpFNUsvNHdO?=
 =?utf-8?B?MWRJWGl2d0dCN2Z6Y1hQOERXNytpM0VWT1VIVWVuVC9JQWhabHNVZkF2aW1P?=
 =?utf-8?B?VmFIU3ZtRXhDN05wOFJGOStrV3NsdUU5ZTNlaXBQbGtObnBFYkQzREN5WFFo?=
 =?utf-8?B?WXI0V3JScnhJamRQNTh5ZkZ1blNORXc2cGZwNGZSRXJsVGk1cklPNnp4ZEVu?=
 =?utf-8?B?R1Q5cS9Ga29mVG9wT2dWTnIrNFgrQlV2ZDhRRWpLZnRZMjdycGlIWmdacnpj?=
 =?utf-8?B?OUo0Qm1RKzFaUHNXK05YL0h1eE1UTmNOM3pDSEd5WnE1bU9qNTVvQTRMVFdm?=
 =?utf-8?B?dGJESkxzWFkrQnJhbGRGcnphWkljVzJHaGhoUUUrRlFMUDg3L3BrSDZUYk9H?=
 =?utf-8?B?ZENObHIwS2pKWXRsc2t3YmZ6NTJoRTE4VDc3SmYzNVVnSGZ4MkRxMTEycWVF?=
 =?utf-8?B?dWRxdktyVjJKdEhuRklRd0FPU2NTUlkzQ04yOThYc0o4SDVDeEJ5T3hrSDlr?=
 =?utf-8?B?UVEyVnVWZHdlemNlM0p3Z2p3b2gxQWJsU2pkL1BMOFVSaGppNGJRb2dqSU9W?=
 =?utf-8?B?S2R4T2hReG9YWC9neW5TZnpmZzFVUXJkOHp2eHpzMVV0SnEyTnI4WGh2ZWh3?=
 =?utf-8?B?MkhSOUpPd2R5OGptZGNOSXM2YS9SdCtFaUlFOVc1YXpTREU0cDd5dHRkZXph?=
 =?utf-8?B?cENKWHRlNnJrWThuVEtVZzdPaG9Ec3QvSnRmOXFuTHM0RmVZdlF1V3VLSFBq?=
 =?utf-8?B?NXBmbnZLOWxUM0dldGhpRnlERzJRaVVhd0tFbDFUWnRkeGZxY0l4ODFUUVho?=
 =?utf-8?B?VzZXdHVZbE53YVZFL0dFdVdpTE0yOE1iMCsxaTIrSEtqVGpCTDlsSWVsNDlV?=
 =?utf-8?B?bDNiNmpmc0tGRDVLUmU2VUFFZFZBeUhqN3BnOGpZSkVkL3p2OVcyT3JIU1NG?=
 =?utf-8?B?YlRKRXF5YXdRQW9RMmMva3ZkZ2pZZSt4QTRsLzhOaU9JVzg0M0NJUDhSc0FO?=
 =?utf-8?B?RlJ3QVJEOWxWSHlEYTRGdHRibFJHbWp2M3docG5MUHpWeVJJWURBSEFQVHlH?=
 =?utf-8?B?WTZsT0RKV29nVjlWb1VLUmZ4ZzZsb2NSRlEraHBhRm1vYmozM1IxY1Bjdm8y?=
 =?utf-8?B?SDR1ZU1LV0gwalVKa2E1NGdqNUdMUTFtdEpBQ3QyVmp5bzZjcWp1WWJydHlU?=
 =?utf-8?B?Mm5vWTZ1KytvMzJ4MTZSWlovUzV3UHoyR0NJbFEwL0Q5ckJtd2tNTStjUkVL?=
 =?utf-8?B?VS9aUEkrL0NuR0MvQUVhTDc2SDlXb3pDOGtERC8xcVM3WVB1SFBabGltemYr?=
 =?utf-8?B?TmNPRlhzTGFEMWFzU2p3cmV2QTVrak9UKzhqSUM0ZHYxVjdtcUpWZWVIenJ3?=
 =?utf-8?B?akRIbldzeHVTSndiKzQwaE9kYnNlS3B2UjdEZlhYbk5NMmJSL0VoQVBLdWVt?=
 =?utf-8?B?OEJubm94RlZJSGlXYi9CY1BlY25ua3JXNWNXL0xUNDEwRGRyNHJSUGhHaWg2?=
 =?utf-8?B?NGozbXRZVWx3NUVnTXVHYWQ0TERnd3dPS1dicjhqOG9lcDhZbk1JYzQzQmVL?=
 =?utf-8?B?amtsWnU3aTJ3VUUxcWl5alZyeVRjdzBUZmJWNlRyNHRCaGJDUWo0ekxUYWFJ?=
 =?utf-8?B?WjdCakkvZGdnNWVUTlNiYWFaMGFybHUrWis5eE5CZzlvMTR0WG00SG14UjZh?=
 =?utf-8?B?aG43OE9LYW1lbTlVcng5QVZ5U0lDTlhrSkthZnJLM29HYU5qam5KbVF0bWR5?=
 =?utf-8?Q?Pz7uPtTeNlhISfUN0X+IMtipf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a303eeb7-32ac-4f1e-c00a-08dd6dfe6a39
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:42:42.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMD4fLp7gs9A+Cwsu7P7S8WMOUXQ9UuKx1uO9PfvIENJluX1yxY7+yi/Xq8xC08/c6VGT37E4InsLPGHVIuDwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119

On 3/28/2025 06:12, Rafael J. Wysocki wrote:
> CC: Hans
> 
> On Fri, Mar 28, 2025 at 3:51 AM Gergo Koteles <soyer@irl.hu> wrote:
>>
>> Some Lenovo laptops incorrectly return EDID as
>> buffer in ACPI package (instead of just a buffer)
>> when calling _DDC.
>>
>> Calling _DDC generates this ACPI Warning:
>> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
>> found Package, expected Integer/Buffer (20240827/nspredef-254)
>>
>> Use the first element of the package to get the EDID buffer.
>>
>> The DSDT:
>>
>> Name (AUOP, Package (0x01)
>> {
>>          Buffer (0x80)
>>          {
>>          ...
>>          }
>> })
>>
>> ...
>>
>> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
>> {
>>          If ((PAID == AUID))
>>          {
>>                  Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
>>          }
>>          ElseIf ((PAID == IVID))
>>          {
>>                  Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
>>          }
>>          ElseIf ((PAID == BOID))
>>          {
>>                  Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
>>          }
>>          ElseIf ((PAID == SAID))
>>          {
>>                  Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
>>          }
>>
>>          Return (Zero)
>> }
>>
>> Cc: stable@vger.kernel.org
>> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>

FWIW the ACPI spec is clear that this /should/ be an ACPI buffer.

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device

That being said this is production firmware and in the wild, I don't 
personally see a problem with handling it this way.

Some other improvement suggestion though below.

>> ---
>>   drivers/acpi/acpi_video.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index efdadc74e3f4..65cf36796506 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -649,6 +649,9 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>
>>          obj = buffer.pointer;
>>
>> +       if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 1)
>> +               obj = &obj->package.elements[0];
>> +

As the ACPI spec indicates this should be a buffer, I think it's a good 
idea to emit a FW_BUG message here so that this can be detected by users 
and tools like FWTS and the firmware can be improved in the future.

Something like this:

if (condition) {
	pr_info(FW_BUG "EDID was found in ACPI package instead of ACPI buffer");
	obj = &obj->package.elements[0];
}

>>          if (obj && obj->type == ACPI_TYPE_BUFFER) {
>>                  *edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
>>                  ret = *edid ? obj->buffer.length : -ENOMEM;
>> @@ -658,7 +661,7 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>                  ret = -EFAULT;
>>          }
>>
>> -       kfree(obj);
>> +       kfree(buffer.pointer);

Any reason for this change?  obj is assigned to buffer.pointer already.

>>          return ret;
>>   }
>>
>> --
>> 2.49.0
>>


