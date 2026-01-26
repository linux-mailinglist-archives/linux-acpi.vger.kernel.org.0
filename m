Return-Path: <linux-acpi+bounces-20614-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eExgF5JPd2n0dwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20614-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 12:27:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B587A2C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 12:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DAEC301D6A5
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0B332EA3;
	Mon, 26 Jan 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UGKrNtOq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UGKrNtOq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6138330640;
	Mon, 26 Jan 2026 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426657; cv=fail; b=pLdFqeZy/3PZ/rJmGxRTxkXudvwOSODDebkd8+qZ4py5VGuHugiCi7JqdEcM+XjcKcBi41IHRKTeUX84aWgQ6SOhEw45i8/Ar3qx2mLsfnNfZch9pdwhUBTn92ictCHu6g2SOxm4DImumvGjDqA+eUlTSYa/oxdfl6x2KVxyh0M=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426657; c=relaxed/simple;
	bh=iD+XHKGkqu7aRG9+q8iCXPKzBvMABMXMo7kn2utyMHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtcd2r/9MFJ9zwoL6KFz7Mrd2OONmLs/P9/CGOp1A37ROtC2OWF3jlNcLUKCtdbQMCx9stLdYNdvZV2l/xsnGLvsyipGqEQdzsOjf6YWYFB+U9ckCqPfNC0Ebzj8VQMcp2BmbATKYzHS8fsWWh89LPGqchMQfd4y/2myU1e/YAo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UGKrNtOq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UGKrNtOq; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MQnPGofZfxq0Ej4OiOMM6Ac4oMCwMGvWGeM/U7I2eO7o4BhpaWZ4ijiDhHLzVv0n5HTyHPGZ9VE5JhGTRo4d0mjNFkvH7K8yVmPYC/aUQk3E51DJvWwrkSwCnzzrRqOkm3aMYXffKGBWdLcct7+7sFASsLAEVbGyDgYj/B20TKpKZYrJy/MX9UlPX3UrmrFemTR3nLXIHyWdkXwvLGf0+yhq89yY7Jl62qXYCwO620yKN+fbLM8kxkiNEhMpAG7f4VFkp3JYtWnpq4lSWwRtWJm6lHSICa5iMVlLbCm1I8G/xzKwk/vhfhk1+xP/Qtr66Dvt6aJbpaUwI/PAG3TILA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AknKRO5tlR2ODS253yU8QvaI2zV12uJT7cmqYxjitM=;
 b=ocubmvrngTVBiShrPhpmtqtcguvV6/kwgakjax5FMFl7zKSWT3vzAb6ktesbwyt4t5VDYgbzKvB0dneAD1wu5aszRXt4t5PNENyDp0Qlqf6tY5M6ZvZ7FNUMBWO13xyXwK6hCsBQqcQgPdIzKTciujeWGkk2kJMXgQH/ZW7MRniobu3ckxHA+J3p8UZijWbaeWjpWW8R2TYljaDNXQaCcPuy0uWA0bCgKSYEDSaFjk5Ivl5eVttZcLUSUQE6J2UtFK8xnmaWsAG0hfhZYtSOD8jtFlXrKCE2W4xIWPdHoeelNnf4M1Hu+aa0+b9RKjnGvzeapgPqeJD8lJGVkEMZLA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AknKRO5tlR2ODS253yU8QvaI2zV12uJT7cmqYxjitM=;
 b=UGKrNtOq7kNyLJjVIv7Uh8c/j4sij8u8EZFqF2qreBD81tpSzoG+XZw+RymcwqghxXDQNw9TrfXqSeGdahYG2O14XJ16MZcipEKL8eJahO1eCtv5TvK9lURs5Sg2zVxUxUd0CRf1hLDTxpttrygEJOKxxIX7nxHIMfxRIHRFXHk=
Received: from DB9PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:10:1da::35)
 by DB3PR08MB10334.eurprd08.prod.outlook.com (2603:10a6:10:43e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 11:24:07 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::1) by DB9PR05CA0030.outlook.office365.com
 (2603:10a6:10:1da::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 11:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Mon, 26 Jan 2026 11:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T28Ua0BAjdIXnrfQLmRUUtavSTtml6TfQ49Et9CZXkmfzPWo7Ecj8UAJOHupzhXKbkHgeaZbykxF7z3OURx2tQ2tus9vmxJIGvxRdt7JRoUKPd7BHz0wlMEeVKrKN47594OEMqknGBti9TUu6CV0wg6AK8kYw88U5JM+BJIstUEObgPiKWEvXPLavRFtcAV55nSV+CSibzKryuxOBYJSBUW7TWxakoOzMFF0vzpDE/CM4X3yMc0v+RrvnhIpttaXU2O/veCBokryBww9uksXc8nAXl3n/K2CICaH/FZLl4NuTKy8dNzAIwsIL4CMStaIdZXQaiKzUAEQaAVwbuKJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AknKRO5tlR2ODS253yU8QvaI2zV12uJT7cmqYxjitM=;
 b=OBRyIcaWLjLbTYVXLhYffj1PdxG+rA04SDN7Kon8WbLAEO/FM41GEBN3oyAvYxG2wIgwGbcZ/cPbBbZRAxkAB65hqIicF33WB2ixksJr15lxLGXf/6Lg2G1YweYquu7ivfCq73SBY0bgJsuLnik4V8pEAVw4V5JryDtcWk0yY/FMz8PsC+pp57IcLqp8Itqp2Hy0x4M1OwYbLYgVOwIH/JAr9wLssFuQP97B6izcA9KDpInLI7FbBYawTML38SwWBJ9OW/BV7e/WRbmA8a6LRfI22YKTEtKHZLDLj74F8ZTeUezp3D81P4Oe2oMoTaaV/j9g5SGuVqFj195/2r8Isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AknKRO5tlR2ODS253yU8QvaI2zV12uJT7cmqYxjitM=;
 b=UGKrNtOq7kNyLJjVIv7Uh8c/j4sij8u8EZFqF2qreBD81tpSzoG+XZw+RymcwqghxXDQNw9TrfXqSeGdahYG2O14XJ16MZcipEKL8eJahO1eCtv5TvK9lURs5Sg2zVxUxUd0CRf1hLDTxpttrygEJOKxxIX7nxHIMfxRIHRFXHk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PA4PR08MB5967.eurprd08.prod.outlook.com (2603:10a6:102:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 11:23:04 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:23:04 +0000
Message-ID: <4c76cbfc-2e7e-4937-a838-09c49440d3ad@arm.com>
Date: Mon, 26 Jan 2026 12:23:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-8-sumitg@nvidia.com>
 <e47509a2-c1fc-45b7-828b-b957b9f8ce1a@arm.com>
 <7d2ad4f1-7d04-4032-bff9-65eed15c7318@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <7d2ad4f1-7d04-4032-bff9-65eed15c7318@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::10) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PA4PR08MB5967:EE_|DB3PEPF0000885B:EE_|DB3PR08MB10334:EE_
X-MS-Office365-Filtering-Correlation-Id: f20d31d8-487e-47c7-24a6-08de5ccd6b81
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?LzRZMXJzVUVVR25YRnJKa3JvNFY2ekFVUTNiRjRpcjRaQkdEbStJdGFsemV5?=
 =?utf-8?B?RFk1cW1vNUJ5M3V5U0Jhalo4V1lvbjNuUEJnS2NkZ0xZd2wySGVSZ3VzYWN6?=
 =?utf-8?B?U1lNUGJNay9iQmFHcEx3bXloRUJFYThFZXlaTnljQlhldDBZMGdvb2c1ZFIw?=
 =?utf-8?B?YVFYSTJYYXBwaEE0WUtENS9oUGJxVDNCQzJvcnlhSnVnVnBwd0U1Tldnb09E?=
 =?utf-8?B?Y0huMXRYYW5qblQwTmgvSm9zMml4dUFtRE1xQ2FZUEtmZmhPTUI3TkcrNmQ5?=
 =?utf-8?B?KzBjMVUzdWdCRDdsaFo2L2diUlBrem5laFBXdG0rZGw4T2tzTWZhQXlEK3hn?=
 =?utf-8?B?U1F1MmQ4eGtBVkw0ekJJRFNkYW9Lenc3ZSttc2luc2lNTko3a2VYVnIxbFEr?=
 =?utf-8?B?QkJCQW1Pa0pqKzFhOXVQYmM4YnRZdWtMSWphMDZ5dlNiUmlMdlA4ckRtUWc3?=
 =?utf-8?B?TFVrRmMyNCtlRFJGVlJLZmJSaURaK3BHcDdnNVAxNEhVMnVuT1B2bmN6N3dP?=
 =?utf-8?B?cFcrMEVEOUNYcVNlOExHa0RObjN6eXBLUVpzR2tJRlZRWHBNTXNsT0lrRG5Q?=
 =?utf-8?B?ZUEzVkFUVkxQemZqV3FvSlp0anVYbTZvZzVXUzhVUThyOGVYb3B2NlpoWVFV?=
 =?utf-8?B?U3AyeEdGTzF6UjVsZHNmM01ETmpabkFFZDRCZlhhTXVRb2F3dzRLcTBvSzMz?=
 =?utf-8?B?MkR6dHVIbTZ5NDFRMGNvYUFDbFJoQ05jK2ZrZEhHQlV4UnROMnN3Z0hwMHZI?=
 =?utf-8?B?dDlLZHpORXdCTXZIM3YxdzZ6ZU5RbHQ4V2hpOUE1OUNackQzN1d1WWljQWpI?=
 =?utf-8?B?VVpsNG1OcWJERXdoR3VGdWUyMWcwL0hEb3hjVkNZT3ZDR1RkVTlHOGdKOXBi?=
 =?utf-8?B?Wi8wbW4vc2pSNXFnOWRlWkk3VTZLMC9mRGJ1ejdSelNPQXF4NmZmd2ozS3BK?=
 =?utf-8?B?ZGl4bngvaU1xdU9UblkyZDVQVmlwd3N0MHY4cEJDQ01WZ1ZoWGQrL0Mzc0FI?=
 =?utf-8?B?QWFUaW1qSUVQc215Z1EvR2xlQ3dCUkRDRGhzUHVESzdZT3QxTDFSSm9NYnEw?=
 =?utf-8?B?cjZVd24rZUc5c2tYSVpzUFV1SHlGMGpZUVY0S1d0NmpxRFM0NlJwT1RxM0I0?=
 =?utf-8?B?NHFpN3pOUmpQellDUCs5MWExMFk0QWo2a0EvYzMwN2JaMWRJRkV5Z293Q2Ft?=
 =?utf-8?B?aWFlRlhlSWNsOEs5b291ZEM4SlRNY25JS2tQZmV6SzZwMXlXVi9LWEpqaFpX?=
 =?utf-8?B?UEFSL0l4b09hQTRsR3NYbUZJblhvNXZBSlV1TExpWXl3MjkvdEpHSEdUd2pL?=
 =?utf-8?B?MkFtNGtHcXZrNk15RXFxRko0U05ibEd0d1dOQlFEYWZJY29xU3JYN0J4VTVr?=
 =?utf-8?B?eWVyNEY0TXp4V0tpb081eW9KM2JDU29BMG5wOXlKOUc3RmRXN0R5NXFCNzhu?=
 =?utf-8?B?R2tvVmdBTkJjbWI2aWJLbzBvWXRNSStmUEx1RGxWUW5GM1MxTHhvck1YeFhQ?=
 =?utf-8?B?eE1TTXpHa1JnMDFWRVFzeStwTmdaVFMyM25kYjNmbWNvQ0lsbTBGazhJWDFv?=
 =?utf-8?B?YUx6THdYbnNPL1UwMmpsSVFOcnRVd0k5eXJLY3BFdmlKY01DbEF0c2tvVWJS?=
 =?utf-8?B?VXV6TDMwcWhCRFlZTE9zM3lNQW04ZEFlc2lHZmdmRGl5MDY1TkMyb3JEQTI4?=
 =?utf-8?B?UEE1MlVFaWx6THJYamNVNll2a2E5Q0J2VXFUdGZGWWs3enFyTHBSMThzL05W?=
 =?utf-8?B?L0MxU1ZuQWFScWEyN0gydm50QWZlTHRkWFNISDc4bExXRGZXcHJ2UUNvRnNa?=
 =?utf-8?B?Yi94YWc0WnJJTDZDRXlDZnpCTGZYcmRvS3J5TGRlQTdoVzBIMnVzc3BuWHd5?=
 =?utf-8?B?N1pXL2FTZzkxdFlEU2ovTktFaUpkZ3NBTDdjcGlkSk5ubmJDWWFiTXAzV3Yw?=
 =?utf-8?B?VmpTcmFxR3FPMjVISHdKNEVQa050VlJhclVpN2tnQlFYblRVeW02Wmt4enBK?=
 =?utf-8?B?VjVsQ1NrTU9sSWdzUlJSUnhRWDN6VjRoNEtQeEJNRG5xdDIxT3E1aC85dFlD?=
 =?utf-8?B?dWlQTjEyamhySVZ0Nk4wUnBBQ2EwTU9tVXNVR250RHdKZVQ0QUF6b043U1hs?=
 =?utf-8?B?enlWTGRubE9NbmVqbHBmeFAweW1EeVh6Zk0wbzltdEFtd1BGTzdhRnoyNlU4?=
 =?utf-8?B?Vnc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5967
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	62329adf-b27a-458a-e507-08de5ccd4595
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|14060799003|35042699022|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHZoTk5pTjQyOS9ZQzdGcjBvTmszTWRBTDhQRFEwMWNWR081YzlqclVsM2JT?=
 =?utf-8?B?OEdBaFk0QkdxUDNvL0hiTWJpck8wWmo5ZkFBWWJ4NlhTV3psSkg2UnNQbWRm?=
 =?utf-8?B?d0dMdFVuOVJWNUhDWFZKMzlkWTNoQzlRUFZYOUlGeXVxaWtmMTY2NmVCclZk?=
 =?utf-8?B?VTNJY3RLUk0vR2QrZWRYKzM3cTQ5cDZOK1A4aktndUpvVTFCWW8wNDNjcFJa?=
 =?utf-8?B?SUJQa0NGdUlkRkZiMXN0dTNOcDIvMG5YRTFNUE5UYlUzbC90U3h2VkNqeXYy?=
 =?utf-8?B?ZWZubUF1dGV2SU9mbXlsSGhHdk1zUTMwak1ncDM4NTNxOExZMVlSa0JVRWV6?=
 =?utf-8?B?QmROYmIvWk8wcng3VHBibDZuc3cyeVMzYVgwL0p4N1ZJNVhadis4aVhONzF0?=
 =?utf-8?B?ZkdQV2VxdjhNZnh1cXhEOXQzb3dxNXBnZ3VWYkVUR0hpek1kYlNnSVFaWkpR?=
 =?utf-8?B?N1htbWZZM2RtT2IwYVNweWMya051TmMxaHhpekFod29jOURLZGdKT2xhdmsv?=
 =?utf-8?B?ZERGMkM1S0M4UTdlekRtRDBSOU8zZXdBN3VwdDg1Sk84UE94QTRiWDUzTWU5?=
 =?utf-8?B?ZWo3VVIrZlhRVE5ZbzhIMGkrQlY0ZDdMK25MR2U3SS95OGlyT1RzNjl2dnZG?=
 =?utf-8?B?NmpPTHZ2Unp4ZWdLNFJnaStSQllFQnFmLzhOR1o2ajlPQU1qRlBhNnJsQURS?=
 =?utf-8?B?ZG9HcTJXc2piWUFvYnpBK2xxMnl6MURCUXZmOEpoZFV2OWx6VHVNbTJRN0V3?=
 =?utf-8?B?TldJMWUzQXhvUm5pSnprQmZ6VzE0RHFWYmVtVnh0YUQyZ3E2dHUxNm1YZWx0?=
 =?utf-8?B?SkZxVGw4ajV5SFRoZDN0WURMa1R6R0ZnNVdXVFQ2ckNoVS9mcG9GTVU1bzJG?=
 =?utf-8?B?RUlKT3JjVVNaY3pBR1Z2emkraE1adzl5WG00T1lrbkpvVElaQnNqNjhSc2tW?=
 =?utf-8?B?UDRpV2hraUVXRjdBUVgrY2NPSi9jQ2VpbzVTWXpjRk90QmUxdTFPUGcwNWJU?=
 =?utf-8?B?Q3U5alIxZ3QyM05BUEtpL1FydWJ6RzhRTzBJcjUvM0d4ZmF1bWNXc0ptMVBE?=
 =?utf-8?B?NWxMdkpmbFpBQkFZMUxqNnNiZTRHREhqK2JZYnViY2FGWnFPQ0x3Ny9zSy9q?=
 =?utf-8?B?eXl1b2lwV0Rxa1M5NWdxK1F3NDJmdVh0VkhYeG5NVGhoRFYxSUhqR05raE9Z?=
 =?utf-8?B?blJ5cWZMdEdENFlFVllPcU1NM3VmRUszbXFLMzJ6UHo5RUxYZkJnVHlzVHpa?=
 =?utf-8?B?WG9ud1c1WVIreDVtUmQyWGJJanlFQ28wL2NmVGdNZnhZMThURUhhSzMrdVJF?=
 =?utf-8?B?RnpFRzFrUFVMMFNlUXBwdktEVkdQTDVyTHo1V3c1b3JmQVJlT3d0MjBwU1Rm?=
 =?utf-8?B?UHQ1UUxRMGR2ZC9zR2xiMDM2eGtadHJvRTYya2lNR0phZVhxWTRKbkh3SEpu?=
 =?utf-8?B?L1FmeWpCVjVzdjB4M0dLNWY1YmFET2pEelJEaGNiYlRwbTVZNGsvaTY4WmN3?=
 =?utf-8?B?UC82bE1TQ0UrQWZzYmxvcXR5SERwVzZUQnF4S1JpWnZlNytLTTJUUUdkNVA0?=
 =?utf-8?B?ZFR0ZWlHZXJ0eXM3S21VRXB6UFg1Tmc2NDk3RXZYdG51OGZ0dk0zemtoTFRl?=
 =?utf-8?B?ZTNHRWI5ZU16T1ViNGxhelU4K3pRZlFwTGJjazlNc3RzY2dZN2VZSjlueVR1?=
 =?utf-8?B?ei9qSVNuM0k5S3QxS0JxbEtXdTd5NWxkTXRtbU1sOVdvWG5PTnVPNW1ld1Fz?=
 =?utf-8?B?QVRrQzVEMUM3bEU0VFBzTXhuaTNINDltcmRtM2tuQ2tjcDZFNTExeklIQW1F?=
 =?utf-8?B?TFA4RE9tUlJMY3Judi9HQm1iaTBpa3AvOFVUSkZsSkhjaXVQdGRaUlY3YVZO?=
 =?utf-8?B?SVA0ckJyK04reWZkZnF2UlpiWXhORkViUVBaUEhKQnVNTUZPMjJjL3V2UG5q?=
 =?utf-8?B?VUNTeHRtUTlCOEU3RnF3N1FnTHZUMUl5YnM4NmhWbkZpeDJ0eUNaUlpzOHBS?=
 =?utf-8?B?UEpWSDUvZDMzbnlnVXdhOTAyMkNTUVVtcHc1ajIzZmx1cXROMUJ3MEVlM1Zx?=
 =?utf-8?B?bEZJOXc5MU1qVDNYRFl3YXpaeHh2NHJQRjZmUGxxV3lxSWNOb2VubjdiT2k1?=
 =?utf-8?B?WitWaENiUWZ1K1VjU0E3MkwxZEJDRnpZb3RWN1FIOElNcUpBcFVYd3FaRmRR?=
 =?utf-8?B?RDhhSFNFYzcwVG1YQkhsZ0JVOWUvMEpNdXprNzZRaDduZ2FtSlJWQXRCbzh2?=
 =?utf-8?Q?9M/uE8DBVMIlHwhrnBzZ2vzQlQxeqINUML2cuObL6E=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(14060799003)(35042699022)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:24:07.3730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f20d31d8-487e-47c7-24a6-08de5ccd6b81
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB10334
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20614-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B44B587A2C
X-Rspamd-Action: no action


On 1/24/26 22:04, Sumit Gupta wrote:
>
> On 22/01/26 17:21, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 1/20/26 15:56, Sumit Gupta wrote:
>>> Add sysfs interface to read/write the Performance Limited register.
>>>
>>> The Performance Limited register indicates to the OS that an
>>> unpredictable event (like thermal throttling) has limited processor
>>> performance. It contains two sticky bits set by the platform:
>>>    - Bit 0 (Desired_Excursion): Set when delivered performance is
>>>      constrained below desired performance. Not used when Autonomous
>>>      Selection is enabled.
>>>    - Bit 1 (Minimum_Excursion): Set when delivered performance is
>>>      constrained below minimum performance.
>>>
>>> These bits remain set until OSPM explicitly clears them. The write
>>> operation accepts a bitmask of bits to clear:
>>>    - Write 0x1 to clear bit 0
>>>    - Write 0x2 to clear bit 1
>>>    - Write 0x3 to clear both bits
>>>
>>> This enables users to detect if platform throttling impacted a 
>>> workload.
>>> Users clear the register before execution, run the workload, then check
>>> afterward - if set, hardware throttling occurred during that time 
>>> window.
>>>
>>> The interface is exposed as:
>>>    /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c       | 56 
>>> ++++++++++++++++++++++++++++++++++
>>>   drivers/cpufreq/cppc_cpufreq.c |  5 +++
>>>   include/acpi/cppc_acpi.h       | 15 +++++++++
>>>   3 files changed, 76 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 46bf45f8b0f3..b46f22f58f56 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1787,6 +1787,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
>>>   }
>>>   EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>>>
>>> +/**
>>> + * cppc_get_perf_limited - Get the Performance Limited register value.
>>> + * @cpu: CPU from which to get Performance Limited register.
>>> + * @perf_limited: Pointer to store the Performance Limited value.
>>> + *
>>> + * The returned value contains sticky status bits indicating 
>>> platform-imposed
>>> + * performance limitations.
>>> + *
>>> + * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not 
>>> supported.
>>> + */
>>> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>>> +{
>>> +     return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
>>> +
>>> +/**
>>> + * cppc_set_perf_limited() - Clear bits in the Performance Limited 
>>> register.
>>> + * @cpu: CPU on which to write register.
>>> + * @bits_to_clear: Bitmask of bits to clear in the perf_limited 
>>> register.
>>> + *
>>> + * The Performance Limited register contains two sticky bits set by 
>>> platform:
>>> + *   - Bit 0 (Desired_Excursion): Set when delivered performance is 
>>> constrained
>>> + *     below desired performance. Not used when Autonomous 
>>> Selection is enabled.
>>> + *   - Bit 1 (Minimum_Excursion): Set when delivered performance is 
>>> constrained
>>> + *     below minimum performance.
>>> + *
>>> + * These bits are sticky and remain set until OSPM explicitly 
>>> clears them.
>>> + * This function only allows clearing bits (the platform sets them).
>>> + *
>>> + * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
>>> + *         access failure, -EOPNOTSUPP if not supported.
>>> + */
>>> +int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
>>> +{
>>> +     u64 current_val, new_val;
>>> +     int ret;
>>> +
>>> +     /* Only bits 0 and 1 are valid */
>>> +     if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
>>> +             return -EINVAL;
>>> +
>>> +     if (!bits_to_clear)
>>> +             return 0;
>>> +
>>> +     ret = cppc_get_perf_limited(cpu, &current_val);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* Clear the specified bits */
>>> +     new_val = current_val & ~bits_to_clear;
>>> +
>>> +     return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
>>> +}
>>> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
>>> +
>>>   /**
>>>    * cppc_set_enable - Set to enable CPPC on the processor by 
>>> writing the
>>>    * Continuous Performance Control package EnableRegister field.
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 66e183b45fb0..afb2cdb67a2f 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -1071,12 +1071,16 @@ static ssize_t store_max_perf(struct 
>>> cpufreq_policy *policy, const char *buf,
>>>       return count;
>>>   }
>>>
>>> +CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
>>> +                      cppc_set_perf_limited)
>>> +
>>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>>   cpufreq_freq_attr_rw(auto_select);
>>>   cpufreq_freq_attr_rw(auto_act_window);
>>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>>   cpufreq_freq_attr_rw(min_perf);
>>>   cpufreq_freq_attr_rw(max_perf);
>>> +cpufreq_freq_attr_rw(perf_limited);
>>
>> If the OS wants to get regular feedback about whether the platform had
>> to limit
>> the perf. level, it will likely try to frequently probe the register.
>> In order to see new events, the register must be cleared. So:
>> - is it a good idea to allow users to write this register ?
>> - is it useful to expose this register if the OS frequently clears it ?
>>
>> I think the functions are useful, it might just be questionable to 
>> expose
>> the register in the sysfs.
>>
>
> Currently the kernel doesn't automatically poll or clear perf_limited,
> so sysfs exposure is for manual monitoring. I can make it read-only
> but then users can only observe throttling events and can't clear
> them (though bits stay sticky). So, better to expose as RW attribute.
>
Ok right



