Return-Path: <linux-acpi+bounces-13677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B26AB2CC6
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 03:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A2E7AB346
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A931E1E1C;
	Mon, 12 May 2025 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pszGdl8w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01E27456;
	Mon, 12 May 2025 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013264; cv=fail; b=Da8tMVh9dsyr7+kxr9ZmpyMuCvhI/4xnFJIZyJF0+pnHogzOh/zsASG+GT/We+imEJTn61901fO3pmKEuyvmyuabKVOKe8i7n2ZEf5nFsl/Wu7ZoTNEw/xgtMl9H4jtfqGG5jWxlU+rYPC524vtpAGvKFk7lKAw6udOlpKMrzWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013264; c=relaxed/simple;
	bh=8hdOdeK1MHvJ9TN8x4gJSItkXMMqgBBXv4ysIqDv0Jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5VPOdRhHyDeVy9YvEuHcpxE2+TrXxOA8OlsHNvve3IBiSritnOiwM8dVE7eTgSktHcRIVuq8HdhrSOQVFsiYx+p8DZ9tBiqGIeFc1gSJpebqWlMHyEyHDLK0GvgtM+Jcuan6ZrnQNAEDZV/ZjJRdngol/Kkkf4l5/a4jOFw9rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pszGdl8w; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITMNvcpjfLpftQ3eM9rG91WKZUMNaUxLT0nA/cNZF42CfZNnNP9Y6dBQTsWapTT24q8F5BGE++i9G+7hRbc1PSuP9ueQAPCJQ7fxEV4j9wwSMDhpXkT+TGDUYxxnODjqWrOFDrb5jyQjYvkTLSIXZlAy4CeGRKZXf6FYOPv0Vp2P6xQPFs0YUzSavSiHEGg2GG789BdEwFM+tyhfReSdOQwelE6UYArslvoKl9m5va7uzWJpg2e4jX91IU9FT4Nn2Jp2Oqg8kIw8lOJqae+ER0ZW6MAuUCJsTjNMPvcu/bWNpEoJdzRpjgaVn68ItX1G6adQQspLwMjz5U9caXec2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hdOdeK1MHvJ9TN8x4gJSItkXMMqgBBXv4ysIqDv0Jo=;
 b=qZ66+i/0v2px97G1WUZw6rVFVAfVMzuaNq6Ex7EmvV6tKeeSLmmLIDoaLNuvmIxwtaF9+Rb9ZjjmNzuB3phvFTo388SzJXp6nLn8ucX5wzEVOJJwDufWdzntCrBnKp1Wwm3Vk4RxMSeE5ZlZnnkgyeodZBZbB/MyhW30bb2rDT0sWhcViu5lQr5SCeMsNVlVOWSQ3N49nagmWLZnHSOG/5b9FQPGYoYZBFR19ArpOuGWZYDyfFojgFzhBC5D4/5ved+3gfzVTDmGKAg2rqw4JKuJJqJ+sxF9EQyQxwstkQ+cFrAuyo55n39DC8PZio7qduKIeqn+/RfEMMu9DPuw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hdOdeK1MHvJ9TN8x4gJSItkXMMqgBBXv4ysIqDv0Jo=;
 b=pszGdl8wM+6UlbycXnErbyxSymuXEM8IFCjNqo/8R+i9rMYzc28x7o4l26XcAcy9PWRIWDALTTSmWmEGrAHAGEVh9d0ENcacqqZa+c5+KhireRHO/6Z/gGSS8IcN1nzlHNIcahIDXI/b3QWrffghx7hIge5L6EimssWkN0CM8Cg=
Received: from PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 01:27:40 +0000
Received: from PH0PR12MB8149.namprd12.prod.outlook.com
 ([fe80::69f8:a590:dd5f:5296]) by PH0PR12MB8149.namprd12.prod.outlook.com
 ([fe80::69f8:a590:dd5f:5296%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 01:27:39 +0000
From: "Zhu, Qiyu" <Qiyu.Zhu@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFDUEk6UFJNOiBSZWR1Y2UgdW5uZWNlc3Nhcnkg?=
 =?utf-8?Q?printing_to_avoid_the_worries_of_regular_users?=
Thread-Topic: [PATCH] ACPI:PRM: Reduce unnecessary printing to avoid the
 worries of regular users
Thread-Index: AQHbt0mG+5Z7224nZUOfTUGCKBvvm7PKtjKAgAOVEYA=
Date: Mon, 12 May 2025 01:27:39 +0000
Message-ID:
 <PH0PR12MB81497231A93F8C62BA5DAC0E8097A@PH0PR12MB8149.namprd12.prod.outlook.com>
References: <20250427075317.42687-1-qiyuzhu2@amd.com>
 <CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOBu0r7L5TzJWgddtsKA@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOBu0r7L5TzJWgddtsKA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f1895bc0-a1e5-43cc-b657-de6f17709e19;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-12T01:26:43Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB8149:EE_|SJ2PR12MB8184:EE_
x-ms-office365-filtering-correlation-id: f1f3c8f8-7113-48fe-1d47-08dd90f42f68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q28zdnFOemQyenpFNm9XMVJjZmZIK2s4TnhaUzREbkpQTXR3WGpkcENReXRU?=
 =?utf-8?B?eWJocWVBN0JTTTJQcEU1dmE1ellxTUphK21ZODRHZ3I1M0NQMGdGQ0dIcWdX?=
 =?utf-8?B?MnhXL284eXF5STlqVFhXVDh1YXlGbjVhR3pFRktKakk2Q0pwY2p1UEpLbU5r?=
 =?utf-8?B?azdWM1p6b1BSc1dhY1pkUHV4bWl0WHZKRmc4R0xFQlhLeS9QVHFJelphQTAw?=
 =?utf-8?B?N29aRnFlQW4zR1RGeUxzbVZBUm5DZVFnRnB4WU5OSjRYRDhGZmJoZEZHTnFS?=
 =?utf-8?B?c1NPdGl4SUZKMjRRMk1xaEUwVkRoUXRoUERCVHpEMkdJdi90RnFCbjRwOFJX?=
 =?utf-8?B?dnBMRlZhc2pYYUYyZU9tL0RmYll3RUZnNktETmovclVQU0hwM3lEc1JGVHk3?=
 =?utf-8?B?YVFSdno3eWdnV1VQTTdYeGZPc3hLOVBXdzg2UjduejA3TythV2FaODFTKzc5?=
 =?utf-8?B?dmJrTW1uNVNOY2ZBaHJZQTk5NTc3cWlxWmFuMXpURGJMWkk2RktWN2ZDTGtX?=
 =?utf-8?B?NGhTWEYrTXMyb1JuWEx0OUJQOFdvMzlyN3daaU9SQkl1ampDYXRxQTh0M2Ni?=
 =?utf-8?B?eVBuQUtjWHBPZ2xvbmpWUjJFa0lTQ2pxbXBKM2hOamxyOGNKWmd5MHlMOFB4?=
 =?utf-8?B?d1hUWGdENDFGTzl6OTVjcGFXTXpNQ3ZYOWJTWnlxcFVQMktQTkx2ZkR0dE0w?=
 =?utf-8?B?b3JEQmtWWE13VUs1ODVzbWhHWUYzSWs4RW9oallWRzhrNjFqSFFJSndHWW9G?=
 =?utf-8?B?a0NudWhqYkt4Skc5d1dGNkRjYm1maVFvWWNKc0Z3TU1HazY4NjMwanIvUjM2?=
 =?utf-8?B?OFRaT2NRd1NFSDFPczJFaFRIQ1NWMWppemlvc2FYM1BDRkppaUdpQU5IWTdR?=
 =?utf-8?B?ZzJ3UjI0dTZHejlIa2JqN3FrS2xoQW1QQkxyUXVlN0N1Ky8xcUFWcVFrd1Ra?=
 =?utf-8?B?NjQ2czRQSFBQZjVwZm82dUplUGFmS3duTk93K2RBVy92bktjeFRtZ1dvNWg5?=
 =?utf-8?B?SHNIWitET2psT09EaUVJZXBxTTFIc0Q5eTVkWkxlNGVCVENGeThsRTd1N0Fo?=
 =?utf-8?B?L1FsUVN0VlR2TExXLzNVUzJEZlZJekZ5VndIQVVWNGMzRFhkTno4OUgwVXF0?=
 =?utf-8?B?Ymk0dFhuaW9lM1dCQWwzanVCWTh1TTRCREJVckRUTmF6MDMweElEbHJEd3Jr?=
 =?utf-8?B?UDlvU1F2Zk1GamxVam5vL2JqcDRaaVU4R3YxWEd2Q0UxRVAwbkpoWHpNU0F3?=
 =?utf-8?B?elI4QS9tTzYrWmZ3RS9HSTdnQjRrSU5ZRXBzVGthS0VqLzduVjl5Snl0b1py?=
 =?utf-8?B?dHU0MEV3LzRsVnZ0MndTS0MxOVlqTEZ3OE5iMlJVYzh6OUFnL2NZK2lTTkpo?=
 =?utf-8?B?MFJDVGl0eXl2QTJCUXgrdEExVmVXd0dGS01xRS9PL0tNcERnSjRxU0FGZFgz?=
 =?utf-8?B?Y255aHZpYzU5RkpmUXo5Nkc1Vng1WjNaVkpBS1IyUEl6d1FCNDJjT2JnZHhh?=
 =?utf-8?B?aU9nOXFnTWFxNGdVTU5BV2FEU3d3ZytzTEZCNWVuYnk3am9XSStlSWRPUURT?=
 =?utf-8?B?ZzFVMUgrSzNZcFcyZit0WHNUbGN1S1lsM0p3SHhsUnRiY09DOHVKaDZ2UUdJ?=
 =?utf-8?B?TUZaUXd3UVVaV3Q2VVpNTm5DZ2dDT3hkQUhXN1pqU29hTk9uWHNqNVM3UEhQ?=
 =?utf-8?B?U2dHTVJ3Vi95T3VkaDhKZlNqVzNyY2JMZHU4eklqTHRhampGVWdGdDlBYWFs?=
 =?utf-8?B?bzNzYnlmNWoraXZIbnFXeVJPVHVSTnlOUzdDUVhBOXpPTkpFbGlBTTJEK3Fn?=
 =?utf-8?B?QTFWSEZpajVaREIyZU9jU1Fkai9qZFJCc2NQeS9YNi9ZVDNZb2FEdXdRTHJH?=
 =?utf-8?B?aG5jQ0l5UXJIVmNoTlA3VkRwS2g4VHB5T1VYazBidHlsYWVNZ3pYbFkwTTZY?=
 =?utf-8?Q?cbB8Wpyl6of6i49sL0MbB2V+IHeUX4Qh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8149.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHFMNVh5VmUxTkNNV1pSRnc0cGFIaC96SllOa0taM3Z0YjJUMkpDc1FvQ2tt?=
 =?utf-8?B?aDhmV2ZXMmNMa2NpaVJoMmZZSDNLd0Z2SEZQT0JscDBNSVJVTHlla1gzOURn?=
 =?utf-8?B?aFdtdVp4TFVyVVVYT3RJRFBvTWxqcjRqV2Q4Z3JXT3luT3BHdno2dWV2UVc3?=
 =?utf-8?B?K0Q2MVIvUGhTbEhzeHNpWDIzVEpSL3pqYnVDYVhNYmlaU0hsU2g3V0pqa1hH?=
 =?utf-8?B?OTZkd0VZSEorVlY3QTJsY0pXTE1DdDhBMFVsd0tyUXg2WVEvSHAranA0TkNh?=
 =?utf-8?B?VUpjK2JZNHJ6MGxBSEpwT2oxQWVaTGFqK3hxTlorWEI4cmRMOHBUdDgySWhS?=
 =?utf-8?B?d0NObXJWVWx6QkpLL0ZVQUljT3l2NEg5cUNxMkNrOEJGUGJ1c2ZkdmxHSTB1?=
 =?utf-8?B?Z1pvYVdWczJmOXR6ZHBYWTNpdWFOWVY1dXBoSzgwUlVHZGZEZWtqdXBySDNv?=
 =?utf-8?B?cEZCQWJ0YkhuQ0tWYVVRT3lPVVNWUEM1STd0ZTJOSGw0QUMxaU9qWnBZRUIz?=
 =?utf-8?B?clRyNk9QZnlwU0w2RE9HTHlqL08yK1BUT3dVRkdkMGpzYXhaclV0d3ZCTk11?=
 =?utf-8?B?TzJaRjFta2JmUXB4MTBkY1pMQW9FNVR2bTNVeitDT25VdVBDR3lkRFVzVm91?=
 =?utf-8?B?MENLcmtUVmxHYUFYSmdNaTRzTi9VSVJva1YwZHVzTFd1UFQ4Y3FEVG5PUmx4?=
 =?utf-8?B?cEpCRmZiVGJ2b3NMRWZXNW15N2VTc093UEpJdEY4c2J2ZXU2Sncyc2RrQUh2?=
 =?utf-8?B?bC9jUWpDV3FmS0dnZlpTV3lHTkRVTXl2aS9KYURTRkVaNkc0K0J2Y2NxKzFw?=
 =?utf-8?B?ZW8xNkEwaWZuWmt2TnMxWlN5dEFmSzlMMXh3eFRMMDdoUW9NR0NYS01KK1Bp?=
 =?utf-8?B?L01GOFRIUFk1N283dlZLUVVQNjlxc1VSekErUk5EbmNVdjZ4MkNtT3ZmNHhC?=
 =?utf-8?B?bzRiZGlGb29BK3RDbVdxWE9QUGRVOUlJWE0vclN4cExzaTY5Y3I5ZGpJNlZw?=
 =?utf-8?B?cCtiQXQ2VzZORWV2ODZ1MEJyMldraEMxUW9BWUN3bTlUU0x5enN6VlM4NGhq?=
 =?utf-8?B?blV5QVBqeEh6NElCKzBMYTF4blB5bytqT21OZ3lVR04zYWY0MnJheXRKeWV4?=
 =?utf-8?B?K1F1U0IzT1lKd1d5M1o4dU1kWktuOGhxdW95RFA2U1BuQmtPWFA2MXhOS015?=
 =?utf-8?B?amEvV0ZUcnVBVVV4Qll1VGFzUTdqeDEzck9HbHlDR1dxV3F3STVjTXBuRjVl?=
 =?utf-8?B?ZDRETkwvaWZ3UDBDaDVJNzFKbHpyNFM1aU40dzYrTVlNMHhaOXQ3dGZJRE9G?=
 =?utf-8?B?QjJlYWkvZDB0UlNQcmxKTWIrV0p2RFpOUmE1NUdsRVIxdFNVK2F2aGx2QW9M?=
 =?utf-8?B?VWZ1bzg3RHpza3lYK25sSWFGK2RqUHZlMkVHc1FDKzFZbmJBcEZyN001Y0F6?=
 =?utf-8?B?eDNTOWhwTEJCRHBqYk1iMFdtRFpBdmZmQzdNL1hZc01xSnJVcUNrM1doOWZ3?=
 =?utf-8?B?WkdtcmF4SEhtaWtUWm9JdTVRLzczRndjSVMwN1cxZ3IvSFJ1TVdocGFYcHJn?=
 =?utf-8?B?V2czZXNScWgyaDY5cHZDS0tCNXBjYk5lKzBlV01BdWlyUXJ6NWhhTzRuaXU4?=
 =?utf-8?B?b2YwQmJ0V3g3TlpzZ2VYM2kxeWNRU1kzWTE3K3Ayd012aWtkUXdiQ0FaWW9k?=
 =?utf-8?B?UUJhT3lycFQ1N0xIdng1eVREUjhtU2RHWXU4N2JEZVc5QzBzWGo4cHQ3dnNG?=
 =?utf-8?B?OHFpOXZacUQrNjVvc3c4RXZzR2ZyckRDMGozVHlhc0hZK0I3QmEvY21yalRY?=
 =?utf-8?B?ZGQzM09vT2J3cU5YMGljc1ZidG4xMkZ0Z1RYakRVVDlGeW0reXdiWks4dnVr?=
 =?utf-8?B?OXRGT0dPQ0U5SU44bGRlQTZhZEJlOG01NUxPQUtNTi9JaTRMODF2cGNUTHNl?=
 =?utf-8?B?bkdwY1RKeE8yL0FuRURleTUwZWVrYVZMUytvSXM0U0FkbWVVVjZYbk9QVlFz?=
 =?utf-8?B?aWZQZlRnQ2o4ekZObTNmWmJaNW4vbTJvSHVZUUtjUzdERHh3a21Kc0E2bkFo?=
 =?utf-8?B?bTk3MnpvdExocXpnLzdUTEpVNjh3L1hPRU1ucldFSzhiSGdRbVN3djRVR3M1?=
 =?utf-8?Q?59BA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f3c8f8-7113-48fe-1d47-08dd90f42f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 01:27:39.7919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV9P1hPJISG0i7TkOJAUNUvo6BnUjjSv/VKllUjIEC0ZrTjXzpd7j1FUOj9jZul8+u9MavklC3c+0u7MDeOHYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgUmFmYWVsLA0KDQogIFRoYW5rcyBmb3IgdGhlIGFkdmljZSwgSSB0aGluayB5b3VyIHBy
b3Bvc2VkIGNoYW5nZXMgYXJlIGFsc28gcmVhc29uYWJsZS4NCiAgUGF0Y2ggdjMgaGFzIGJlZW4g
c2VudCwgcGxlYXNlIHJldmlldy4NCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYWNw
aS8yMDI1MDUxMjAxMTgzMy4xNDIyMDQtMS1xaXl1emh1MkBhbWQuY29tLw0KDQpCUnMNClpodSBR
aXl1DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0K5Y+R6YCB5pe26Ze0OiAyMDI15bm0NeaciDEw5pelIDI6
NDQNCuaUtuS7tuS6ujogWmh1LCBRaXl1IDxRaXl1LlpodUBhbWQuY29tPg0K5oqE6YCBOiByYWZh
ZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K5Li76aKYOiBSZTogW1BBVENIXSBBQ1BJ
OlBSTTogUmVkdWNlIHVubmVjZXNzYXJ5IHByaW50aW5nIHRvIGF2b2lkIHRoZSB3b3JyaWVzIG9m
IHJlZ3VsYXIgdXNlcnMNCg0KQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBh
biBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNo
bWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KDQoNCk9uIFN1biwgQXByIDI3
LCAyMDI1IGF0IDk6NTTigK9BTSBaaHUgUWl5dSA8cWl5dXpodTJAYW1kLmNvbT4gd3JvdGU6DQo+
DQo+IENvbW1pdCAwODg5ODRjOGQ1NGMgKCJBQ1BJOiBQUk06IEZpbmQgRUZJX01FTU9SWV9SVU5U
SU1FIGJsb2NrIGZvciBQUk0NCj4gaGFuZGxlciBhbmQgY29udGV4dCIpIGludHJvZHVjZXMgbm9u
LWVzc2VudGlhbCBwcmludGluZyAiRmFpbGVkIHRvDQo+IGZpbmQgVkEgZm9yIEdVSUQ6IDc2MjZD
NkFFLUY5NzMtNDI5Qy1BOTFDLTEwN0Q3QkUyOThCMCwgUEE6IDB4MCINCj4gd2hpY2ggY2F1c2Vz
IHVubmVjZXNzYXJ5IHdvcnJ5IGZvciByZWd1bGFyIHVzZXJzLg0KPg0KPiBSZWZlciB0byBQUk0g
U3BlYyBTZWN0aW9uIDQuMS4yWzFdLCBib3RoIHN0YXRpYyBkYXRhIGJ1ZmZlciBhZGRyZXNzDQo+
IGFuZCBBQ1BJIHBhcmFtZXRlciBidWZmZXIgYWRkcmVzcyBtYXkgYmUgTlVMTCBpZiB0aGV5IGFy
ZSBub3QgbmVlZGVkLg0KPiBTbyB0aGVyZSBpcyBubyBuZWVkIHRvIHByaW50IG91dCAiRmFpbGVk
IHRvIGZpbmQgVkEgLi4uICIgdG8NCj4gaW50aW1pZGF0ZSByZWd1bGFyIHVzZXJzLg0KPg0KPiBM
aW5rOg0KPiBodHRwczovL3VlZmkub3JnL3NpdGVzL2RlZmF1bHQvZmlsZXMvcmVzb3VyY2VzL1Bs
YXRmb3JtJTIwUnVudGltZSUyME1lDQo+IGNoYW5pc20lMjAtJTIwd2l0aCUyMGxlZ2FsJTIwbm90
aWNlLnBkZiAjIFsxXQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgUWl5dSA8cWl5dXpodTJAYW1k
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2FjcGkvcHJtdC5jIHwgMzEgKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJtdC5jIGIvZHJp
dmVycy9hY3BpL3BybXQuYyBpbmRleA0KPiBlNTQ5OTE0YTYzNmMuLmZjZDcyMTU1OWViNSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9hY3BpL3BybXQuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvcHJt
dC5jDQo+IEBAIC03Miw3ICs3MiwyMCBAQCBzdHJ1Y3QgcHJtX21vZHVsZV9pbmZvIHsNCj4gICAg
ICAgICBzdHJ1Y3QgcHJtX2hhbmRsZXJfaW5mbyBoYW5kbGVyc1tdDQo+IF9fY291bnRlZF9ieSho
YW5kbGVyX2NvdW50KTsgIH07DQo+DQo+IC1zdGF0aWMgdTY0IGVmaV9wYV92YV9sb29rdXAoZWZp
X2d1aWRfdCAqZ3VpZCwgdTY0IHBhKQ0KPiArZW51bSBwcm1fYWRkcl90eXBlIHsNCj4gKyAgICAg
ICBQUk1fSEFORExFUl9BRERSLA0KPiArICAgICAgIFBSTV9TVEFUSUNfREFUQV9CVUZGRVJfQURE
UiwNCj4gKyAgICAgICBQUk1fQUNQSV9QQVJBTV9CVUZGRVJfQUREUiwNCj4gKyAgICAgICBQUk1f
QUREX1RZUEVfTUFYLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNoYXIgKnBybV9hZGRyX3R5cGVf
bmFtZVtQUk1fQUREX1RZUEVfTUFYXSA9IHsNCj4gKyAgICAgICAiaGFuZGxlciIsDQo+ICsgICAg
ICAgInN0YXRpYyBkYXRhIGJ1ZmZlciIsDQo+ICsgICAgICAgImFjcGkgcGFyYW0gYnVmZmVyIiwN
Cj4gK307DQo+ICsNCj4gK3N0YXRpYyB1NjQgZWZpX3BhX3ZhX2xvb2t1cChlZmlfZ3VpZF90ICpn
dWlkLCB1NjQgcGEsIGVudW0NCj4gK3BybV9hZGRyX3R5cGUgdHlwZSkNCj4gIHsNCj4gICAgICAg
ICBlZmlfbWVtb3J5X2Rlc2NfdCAqbWQ7DQo+ICAgICAgICAgdTY0IHBhX29mZnNldCA9IHBhICYg
flBBR0VfTUFTSzsgQEAgLTg1LDcgKzk4LDEyIEBAIHN0YXRpYyB1NjQNCj4gZWZpX3BhX3ZhX2xv
b2t1cChlZmlfZ3VpZF90ICpndWlkLCB1NjQgcGEpDQo+ICAgICAgICAgICAgICAgICB9DQo+ICAg
ICAgICAgfQ0KPg0KPiAtICAgICAgIHByX3dhcm4oIkZhaWxlZCB0byBmaW5kIFZBIGZvciBHVUlE
OiAlcFVMLCBQQTogMHglbGx4IiwgZ3VpZCwgcGEpOw0KDQpXZWxsLCBtYXliZSBqdXN0IGNoYW5n
ZSB0aGUgbGluZSBhYm92ZSB0byBzb21ldGhpbmcgbGlrZToNCg0KICBwcl9pbmZvKCJWQSBmb3Ig
R1VJRDogJXBVTCwgUEE6IDB4JWxseCBub3QgZm91bmRcbiIsIGd1aWQsIHBhKTsNCg0Kd2hpY2gg
c2hvdWxkIGxvb2sgbGVzcyBpbnRpbWlkYXRpbmc/DQoNCj4gKyAgICAgICBpZiAodHlwZSA9PSBQ
Uk1fSEFORExFUl9BRERSKQ0KPiArICAgICAgICAgICAgICAgcHJfd2FybigiRmFpbGVkIHRvIGZp
bmQgJXMgVkEgZm9yIEdVSUQ6ICVwVUwsIFBBOiAweCVsbHgiLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBwcm1fYWRkcl90eXBlX25hbWVbdHlwZV0sIGd1aWQsIHBhKTsNCj4gKyAgICAgICBl
bHNlDQo+ICsgICAgICAgICAgICAgICBwcl9kZWJ1ZygiRmFpbGVkIHRvIGZpbmQgJXMgVkEgZm9y
IEdVSUQ6ICVwVUwsIFBBOiAweCVsbHgiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBwcm1f
YWRkcl90eXBlX25hbWVbdHlwZV0sIGd1aWQsIHBhKTsNCj4NCj4gICAgICAgICByZXR1cm4gMDsN
Cj4gIH0NCj4gQEAgLTE1MywxMyArMTcxLDE2IEBAIGFjcGlfcGFyc2VfcHJtdCh1bmlvbiBhY3Bp
X3N1YnRhYmxlX2hlYWRlcnMNCj4gKmhlYWRlciwgY29uc3QgdW5zaWduZWQgbG9uZyBlbmQpDQo+
DQo+ICAgICAgICAgICAgICAgICBndWlkX2NvcHkoJnRoLT5ndWlkLCAoZ3VpZF90ICopaGFuZGxl
cl9pbmZvLT5oYW5kbGVyX2d1aWQpOw0KPiAgICAgICAgICAgICAgICAgdGgtPmhhbmRsZXJfYWRk
ciA9DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICh2b2lkICopZWZpX3BhX3ZhX2xvb2t1cCgm
dGgtPmd1aWQsIGhhbmRsZXJfaW5mby0+aGFuZGxlcl9hZGRyZXNzKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgKHZvaWQgKillZmlfcGFfdmFfbG9va3VwKCZ0aC0+Z3VpZCwgaGFuZGxlcl9p
bmZvLT5oYW5kbGVyX2FkZHJlc3MsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBQUk1fSEFORExFUl9BRERSKTsNCj4NCj4gICAgICAgICAgICAgICAgIHRoLT5zdGF0
aWNfZGF0YV9idWZmZXJfYWRkciA9DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGVmaV9wYV92
YV9sb29rdXAoJnRoLT5ndWlkLCBoYW5kbGVyX2luZm8tPnN0YXRpY19kYXRhX2J1ZmZlcl9hZGRy
ZXNzKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZWZpX3BhX3ZhX2xvb2t1cCgmdGgtPmd1
aWQsIGhhbmRsZXJfaW5mby0+c3RhdGljX2RhdGFfYnVmZmVyX2FkZHJlc3MsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQUk1fU1RBVElDX0RBVEFfQlVGRkVSX0FE
RFIpOw0KPg0KPiAgICAgICAgICAgICAgICAgdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHIgPQ0K
PiAtICAgICAgICAgICAgICAgICAgICAgICBlZmlfcGFfdmFfbG9va3VwKCZ0aC0+Z3VpZCwgaGFu
ZGxlcl9pbmZvLT5hY3BpX3BhcmFtX2J1ZmZlcl9hZGRyZXNzKTsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZWZpX3BhX3ZhX2xvb2t1cCgmdGgtPmd1aWQsIGhhbmRsZXJfaW5mby0+YWNwaV9w
YXJhbV9idWZmZXJfYWRkcmVzcywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFBSTV9BQ1BJX1BBUkFNX0JVRkZFUl9BRERSKTsNCj4NCj4gICAgICAgICB9IHdoaWxl
ICgrK2N1cl9oYW5kbGVyIDwgdG0tPmhhbmRsZXJfY291bnQgJiYgKGhhbmRsZXJfaW5mbyA9DQo+
IGdldF9uZXh0X2hhbmRsZXIoaGFuZGxlcl9pbmZvKSkpOw0KPg0KPg0KPiBiYXNlLWNvbW1pdDog
OWQ3YTA1NzdjOWRiMzVjNGNjNTJkYjkwYmM0MTVlYTI0ODQ0NjQ3Mg0KPiAtLQ0KPiAyLjM0LjEN
Cj4NCg==

