Return-Path: <linux-acpi+bounces-10847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA937A1DB17
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236B7166704
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B78150997;
	Mon, 27 Jan 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmEs5bq9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0741F95A;
	Mon, 27 Jan 2025 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998210; cv=fail; b=IPswvUv85L6AsL2UIzx5w0N9tySLp8ZFBBc86ejijkGrzoBEZPS0XymjMjVEo4g8qXauO/mSkSSp0wNVJMDWSDI9GZ4atF5I+fwzgkFRPQDAF1/T4Ru7LsHuJSoFGyVKkvM180Jvxwdxw8FH6AteM3KMOc2/CeipkG+pkrNUSDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998210; c=relaxed/simple;
	bh=mNtNhkE8sT3q+GSqxlJwSi55UmLwHn9HJyv8wIk1MjA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Jm3Ws/82u9kvMe1/icj659KGDtX1tSjr/EPbxlNVRrYSfaR1TLR9k8cKdJrfy78lPBJbOJ6j5vPqpKhgv+L2vDcCxgHRVW/Jgo6AZfNuL6e4afwbpLh3/kYkKD7UR1+9kn6eUSHrffuhjhW2IZM/k4N+SpQErVPZqKqf3fqdLtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BmEs5bq9; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD46f9Le3kKlyCtV3FIAFMyFEn/tSMf2ekjdmTtRO5ZuZYL0zBK/vgFR/p4InuOV1V5K9K4EoHgKlC4aHtAe1t3JuJjPlpfTwioFGjKUqiG8SyUuX5q43gvv+q8NKdwWzP21TpCY06RIWGdP5C+Rz5ywIHyEpsF7t0MzrsI2D7IpBsqFm6CwAqsGyIxlU0f+prHIgbXv1q/i1bkfvr8E4h/YHgkQj5lGNYRawGSz3WRwE8rhCBUEk0SRmF81R38GOnB7wJns5qTG7XxuQgpTTS3NMuVJ54py5bHORZ4rKuLt21Al8Fri/VlQV7Ir8FI93Pczas5/B6o0F62/qCMwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjB1CkZu4BTwUA4CspDMcI/BGEVy+mM0uNwtz6WPEJA=;
 b=Mo/mUN8mZ8YTBNAf/+8pw7J/sU2THw9ECg9SvxGv4Uwl0qBd+BUIhhj83pd4PGn9QNrGKermAV+EurbdHwJMpvQ3eKCO0hHOZzuO6OPcAYwoRAQRyVzbr9amyjVHoZLx8KVRt+CIy04/CxPfAQlnQaXCVDQIibqtIBAz0j2QH/BGEWiCH58ilttWxhGIOIh4wYkGTP70foaJocMbCVrVPwESpyVHmUsiodtkNtoF9UqCwV5zSprbFTt2Pd/maKQtGF8RicXtLd6yQgIcdRopYjzHVkY+W6qRWm9I0dLCzAe7zx6nfcIvRnkpDN1n9QnjX1z3I/c7XMoN29/8JgkoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjB1CkZu4BTwUA4CspDMcI/BGEVy+mM0uNwtz6WPEJA=;
 b=BmEs5bq9Mon7WNT15dbfn3y/E+1pk+SWES+JXMXQCn7TfPixg2NquNft16mzJ8Kb+9kjM1OQdurciUG48cNJiJFjbs8fajAaZn6kQ2oX69u1svV6WcT8i5+wj4EGvIA/9y5QESPo5QEEYUwUJYjkzuL8V63jXHr4C8qrbNGktVpy1M7qMdL1xp1GT9EXAU0zPyBgdKT5sKnBJofMeOrwKd6BqI7b7v5+vUGaSLodtYwTw/WrS1HGVW6tjCVJQuQai0Y9ZA0vFpCCvzGirKwAPUxB0BNbsMv0HxLe69bPO8pxG900y+9RCYTVq3OA3dVntkN70bDpbWPigPxmbuOWDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 17:16:45 +0000
Received: from MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b]) by MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 17:16:45 +0000
From: Bruno Faccini <bfaccini@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	jhubbard@nvidia.com,
	mrusiniak@nvidia.com,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	hyeonggon.yoo@sk.com,
	Bruno Faccini <bfaccini@nvidia.com>
Subject: [PATCH] mm/fake-numa: handle cases with no SRAT info
Date: Mon, 27 Jan 2025 09:16:23 -0800
Message-ID: <20250127171623.1523171-1-bfaccini@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:a03:333::19) To MW4PR12MB7261.namprd12.prod.outlook.com
 (2603:10b6:303:229::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7261:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c2a7c7-b2d7-48b9-ba92-08dd3ef66062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWVvTmQ3aEpObVl3TkVVL2Ftem5wY0txSG5zZFdDc3ZHM3VqaURVZVBlVmhm?=
 =?utf-8?B?cDdJeVRxUS9iMXhlOFFlK0dtUzY5SnA5aHh0c3VEdEpCVGRBWWVPUUNObmpp?=
 =?utf-8?B?Vk1WSGtrbDl3a25HSER4cFNkUzl5dnJyZjFicVlZa3dRK2djczA4MFRuelJW?=
 =?utf-8?B?dzdjdXRCKzlSWExBQlZWWEhLQlRONWZHT3V2VFVDdjBGUWo0TmJkaVpZK1Q4?=
 =?utf-8?B?UDNVZnpoMktObjVGY0xpemJXZXA0dkkxMUZ3UHoyWk5Rd2xnY1NWVzcrSWcv?=
 =?utf-8?B?WS9aa2JwZzk3dmZSOHd6WHl3bTJ3L3B4VzgxZkp6bVhvanhtcVZjYUdhclRl?=
 =?utf-8?B?SFp6NUt4TVFYanV1ckdhZm8vY0hqNENZTkN2eStZWmQvNzUyTlVGdTR3dXNC?=
 =?utf-8?B?YmpCZUhKdGtraG5Cb0FPL1hvNDdWSkxyV0lZTWV6WWtQZG9YYW5HQnFydldn?=
 =?utf-8?B?RkZwVy8vd04rdmxOdm9nbzY2eTNibGE0NjI3MC9HRXMvTUs3cDBFeE8wb3Nl?=
 =?utf-8?B?Uys5dnJBOURpS1g0ZHJqVjV3cUdKREZ2U0MwUWtyZkkxMzRqMnY4bFB5cWk1?=
 =?utf-8?B?eGVVRDhrYjZBUXF5MExORTRFVzUrSjdCbXgwN01yNFpWZU9IdEVhWGVZMXFX?=
 =?utf-8?B?N3RBS3NXRjFZZ0tCVURrT0ZjWkR4NDJzclJTNXdnN2J2K0xMdXhvK0FaK1ht?=
 =?utf-8?B?NEFMOWl2RS9PQXJvTU9oWWpZWnRpUFovWGlYNHZEOFpHS3JHbmRucVA1MG1p?=
 =?utf-8?B?WHZqYTdDSFA4b3dkTXZOeEl3SUhpMmY0UTlTYVNZSDhHU1hSRDBYTzRpOWI2?=
 =?utf-8?B?cG1uN29LU2xFaDVTZkpSOHRabFB2MEREdzJaWVBpTy9md3N3Wk1SL1pTaXVr?=
 =?utf-8?B?UkVXWjFOQ0xsdmtHQzhFdHBEekVmajE3c3YrQ1ZWcUdmKytoaWVCeTFQL2Zn?=
 =?utf-8?B?TEVtWkJHSjVkOU0vckVscVNyeWdESHp4V3ZpMVB3YXZxbmFGZTIwb3MwVVFN?=
 =?utf-8?B?dXZ5a2o1Mm9Uby9OV3BDM01hTy9XY1VseTQzc2VUeGZLclZsK28wb3JUODF2?=
 =?utf-8?B?UTROdEVpcUJJUVpla0x5VFBqSXRMczRrVEJoYlc0ekFlMzFtYzVrQmZyME9v?=
 =?utf-8?B?T1pOeVpWN1A4OTJhVHR5Um94MDFwdnE4NUs5Nmo5SzVzbnIyRWQ1SUN0T3Aw?=
 =?utf-8?B?OUJoNkRZOEc2QlB0S2lHL0tuQStQU2llUmxMWWxEOGhrK251ZVdBSE1WWjIy?=
 =?utf-8?B?c0VHU1puUmk0UEhpWlFKYUc1YlYvY3VMMjhIUkRnRVBaRWY4blZNZWFwRVRu?=
 =?utf-8?B?ZnZQM0gva0dtc21XeUJ6WU5zcVBtTldhMGNRd0srZ21NUHlTMlJ4S21HVk5Y?=
 =?utf-8?B?R1hnZ3dYbUpZTTJpbFlYcklDRC9CRithZmVtY2tMdVpnV1laRTBya203aVdk?=
 =?utf-8?B?aUlOdVZxbHlmblhvSXJLUE5RR2VBYkl2U0lXZFJUV1JNOVY4bXMwU2xWT2Jv?=
 =?utf-8?B?bkQySnJiRDJNTGlKV1phY0s2STQ1d2hBM3BsNklKSUNoWXZFdkpla1FYNkRy?=
 =?utf-8?B?YTg4UVJWK3dFRE5qaWZSTWxlV1laYnNtc3FZaVU2VXAxdExKajdNb0FWd2tB?=
 =?utf-8?B?L0lpNlBBU2RCOVNEbVozK092VW52TmRGa2RYcFFhSCtrWlZ5d0dONzFUZkh6?=
 =?utf-8?B?SlNxV0JvYXdPaWFSSFRrUytWemRHcXN4NHBkU2lmVjFlKzFRM3VXSFRyTmJQ?=
 =?utf-8?B?Uk5scVhxSFV2T2Q3cXY0WDQ3Zm1IWllzNTN6bVRUNVE0MkxReU5JZHRzaWww?=
 =?utf-8?B?VzRzSjg3Wi9Fb1FYc05uam4wSHFoL0RUL3hXQ0ppMTVNQTZ4bWpXMnlnV2pk?=
 =?utf-8?Q?fTvHV1Q4+dN2z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7261.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHZTYTRNaEQ2VVJXOHJrVC85Szk2b3Z4L2o3UjBpVlExemhWSEZtN3ZvUGJQ?=
 =?utf-8?B?aDJoVjdvRU5jZVlic3h0VUFoNEFHNGFNQzQ3dmZqUzMybDgrM2pNeExpODAw?=
 =?utf-8?B?c0plbXRIdnNzcU54cXdLczVkUFIzQmNiN21uTGZrL1o4a2V5L0YzYXY0TDAr?=
 =?utf-8?B?SzBXb0EvZ0tVNGFXZk5OOUg3VWdvbUZ0a08wVW5Vbm5GRTEwRC9NQ3FLSlNz?=
 =?utf-8?B?SVRtcVpnOHJMYThKYWNsMXZRSEJOZkVvRnltM2tnajVSdFgxUGUzSzFmTDlY?=
 =?utf-8?B?bFZCcy9NbjBCalJ4UVJFUUtzQ0ZNWVVsMXJ1SThRaFViUTlEYVlycGxzRDVT?=
 =?utf-8?B?NmZZS1NGTmNENzZLZ3J2amtDVC8yQ05mVUM1d0craGtWTnh5R1RXeUZMT0Fy?=
 =?utf-8?B?ZjRMdnRwQmM2NDJPYlRrM0ZUS0VreUtzMGI0UXFkYWF2emx2dzlkNnhBV2VF?=
 =?utf-8?B?YXQ1SHJEMUxhRno0VVU2NnEvNEcxN3RQL1dRMlBoSVJ1WWFhS1JFMVBYS2Uy?=
 =?utf-8?B?NDJPdEk1WEJjUEVqRC9FWk82dHBvYjN1c04ycWRxQVAwRDM2NTVITkhRMm5K?=
 =?utf-8?B?RUw3K1I1WGdYQWY2eFBRWDVUd3pLaUpzVzNNZVg2NGsvd215b3ljVWNzN3U4?=
 =?utf-8?B?L1RCYlFlTk5UWWF0QkJ1cnNMd1BtVEp1OEw1bkZlNjlQZk9Qa0JxQ0d3YjVD?=
 =?utf-8?B?NEYxa094QXJvN25BU2s1dU54cDRwcHd0clh2ZVBXbXBsdXFRak5MR2lQNXVz?=
 =?utf-8?B?YmJHZmhtTFdscGJOY3RQdVJkREhRUm90eUtTZGEzUDc1cnlRRG1FWUI4WTBT?=
 =?utf-8?B?elp4Nnp3VVYxOXN1MkRSMExlb1d1NUQremk5Vmt4Mk5HRFd2a1doTGJ6TE1Z?=
 =?utf-8?B?ZVhHakJTR2x3WVZORzJkWU9tMEs3VlpXUFJiK2ZscXZSU25kNStlK2RPRTdy?=
 =?utf-8?B?K2l5VXNsYnZkVkFEQ0xKRjRZaEJyMUU3K0VRNXNFZUtEU2dVTkswVXNjYkdw?=
 =?utf-8?B?MTBHR3JXNW0xUTZXSmpZRnRUTDBKeWovRjBNRXViWHV6YVJKSVdENXVsbU9S?=
 =?utf-8?B?QXZLNlNKRFlTNVN1Rlg0SklBaU1EQUw4Q3JhUXpuM0Q0dEpOT1lDTWNCSWJl?=
 =?utf-8?B?cGZZdmNpUnI1S0xLdEoyREJjV3oxNVQ0bFBSRDR5RGdlT3NTbmgvcVZEc3VS?=
 =?utf-8?B?RGVZaG15ZzRGMmpMM2ZkSllSNGtMUWRuTVV4c01sL1p1U1JEcWxWeGNNbnFF?=
 =?utf-8?B?a1BCZENNSEE4M2FZOXdFb0VNS2VRZzM4WlJlUXp4RTNkd3Y0NXF5ejZtVU00?=
 =?utf-8?B?aHlqbDJ2eDZrbW5weWwvRTczcFNCK2E1WExuVGJDbTJrZ2d3WHJXaFFabVNo?=
 =?utf-8?B?RGYrTEdQWGVxS1VkNUY0eTJWNTVpUjI1TlNDVXhKdHRxalVXbmNIaVNXQVFn?=
 =?utf-8?B?b0huV2lzcjJRTmZwZ21qNnhUYnFFMlpXOVBJVjVDanBsalBFWVVHVEVuWk9q?=
 =?utf-8?B?cjExbXFyWTQvcUQ0Sm0yUEtJUTdqYThsQ1RMRDRNdk1xU3RlTjhZU294RGdR?=
 =?utf-8?B?TWliZnI0dS9KMjArWTdGcWYyeGhmckFxWFF0VysxMWNxd3dhMlA2aEQ1V1RK?=
 =?utf-8?B?TGlrd08rMjdZRnByVnhPV1FrVktwSlVvcEt5UHlqWXRTdXVWbFY4ckpKUjlI?=
 =?utf-8?B?WG1nOGNzN1J4M2psd0xoRjlvODErbnIvZHZ3anZIclhMOUdzMkdtSk5GZkdq?=
 =?utf-8?B?YU9jemdwZW9CZHh6TzFnb0lYNldVT1ZxREdlZ1RkL1FyVkx1K2lQeExkb0lD?=
 =?utf-8?B?ZktEUlBseHNDSWdNRlVjaC9PL3lvdTlCZm1sVnRaZGp5T0x6QWlQNTlxWkxo?=
 =?utf-8?B?TStweERxazlVckFVU2RPeGdtdXR0RitTREhmRnZvTUhINExvM29HM3VOVjBl?=
 =?utf-8?B?ZmJYTnlmaEZKV2pkSnYzZXozelhZOWRGMXVXMExYQU1KZGJDOHBwQzRLRlFx?=
 =?utf-8?B?QktyQTBxc01lSHVBYkRCR0t6dkNVS3hTTXI4b05aZzlDM1JWcS9KeFdWNnli?=
 =?utf-8?B?RU51RmZ5M0h5L0ptaEZpNmtyUWl2THhjd0lGaW5ZYVRwQ2UvTytNZ1dZSkFo?=
 =?utf-8?Q?inAZYWu6c5PI69t/n/CXEPh/5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c2a7c7-b2d7-48b9-ba92-08dd3ef66062
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 17:16:45.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MITtBMCWtWZaiM8g3uvPu2zNNcdEzfHr1TeEQtifOScvXLLVPEqOWKTgPGvgh3pKCgQ6CdXgsw84VWLrLcxQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491

handle more gracefully cases where no SRAT information is available,
like in VMs with no Numa support, and allow fake-numa configuration
to complete successfully in these cases

Fixes: 63db8170bf34 (“mm/fake-numa: allow later numa node hotplug”)
Signed-off-by: Bruno Faccini <bfaccini@nvidia.com>
---
 drivers/acpi/numa/srat.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 59fffe34c9d0..00ac0d7bb8c9 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -95,9 +95,13 @@ int __init fix_pxm_node_maps(int max_nid)
 	int i, j, index = -1, count = 0;
 	nodemask_t nodes_to_enable;
 
-	if (numa_off || srat_disabled())
+	if (numa_off)
 		return -1;
 
+	/* no or incomplete node/PXM mapping set, nothing to do */
+	if (srat_disabled())
+		return 0;
+
 	/* find fake nodes PXM mapping */
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		if (node_to_pxm_map[i] != PXM_INVAL) {
@@ -117,6 +121,11 @@ int __init fix_pxm_node_maps(int max_nid)
 			}
 		}
 	}
+	if (index == -1) {
+		pr_debug("No node/PXM mapping has been set\n");
+		/* nothing more to be done */
+		return 0;
+	}
 	if (WARN(index != max_nid, "%d max nid  when expected %d\n",
 		      index, max_nid))
 		return -1;
-- 
2.43.0


