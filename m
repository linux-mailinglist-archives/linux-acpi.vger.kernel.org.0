Return-Path: <linux-acpi+bounces-20841-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDTwF5JagmlhSwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20841-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 21:29:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9488DE7F3
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 21:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CDFE308A5C6
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492C36D51E;
	Tue,  3 Feb 2026 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FBBRY7nu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD921CA13;
	Tue,  3 Feb 2026 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150541; cv=fail; b=TKbiLgrMYUSTmFnoX9WiDK5VVfNYkJJrRLdawn0DE38B+D9EZ6O9Kh35mpC4g6UrFOsuzPpO1hjgbG4waDhUrgPpcyRNxeY5ICvegzFbgUcMH9xhztfedVJ6IFnRceXFTUF9FBLGgsRP/giJhLlX2o3cY2+6s2ED5FwHAA3oBsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150541; c=relaxed/simple;
	bh=gixd/ljQW4LpdFN3Ex5IYRXoCqw3BftBgzrHd2P2eTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c43gUu+bXgikOVA9DSa/VCdAv4QKv9sgBq4oZ/Ubw/vlqPhcdcHBQxv37xj8hC+6Rkr6PRVp2XJxlyiF9XR5s3RHaMFY6oYYWOfQ/61N2D49SW47Ny1D8zoNRzZX63i8oB2Qeu4WQ9uRESY7cCGCPY2YJsUKpUXafRBB2pak6oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FBBRY7nu; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrWIFGb8ZvjpxOhPdfmc8uyrbVKAUInEcC85EY4dOWsP0i8ZlD3EDccBeD31cSpyUcmPUo9V4hNBm7G5i29I1sis4AihB9QPqT2s2IacVFD6UiUgFrc+EWbqhOk4pBCZOsxNrz8x/Hrouq0ssXANME9ECN4ZRjTcoplAQ3M3cmt8GcxZIwA+bfKU6glDC9GkxQ6BFtMaNZjizeVHTLVcDvw5cMASARzybbSQgh4HpW9ij0xDl6y9+VxDIL1YV8JjRw+KqJPmw/bc/rWHI2MPY9kt4G7ShjisRygpffeT/RYyII6SqeYBNjsZaEJmzagSCsq7TirKF+qtAOlyAsozhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic9e9hjVrtJc34Hc6AC2HkG4LY0LjbDTJk2lRwQ023k=;
 b=CbgWdFyT9xLvxnHxaPoY7j0JxCrKu8OEqdzxfpf/PNYalnx7TMfW4s4Edht6gL7PNv/oraUTUIrWPvnkoKiNvEYOxTT6y5YmYQeEcatPyX4fOTUR2O62QPcpKB/5yN/Ip1AwA4Bn9v9vXVjz0Tpl0WQ6T/ufYjI44USxTbPvdQuHxAFxFXaebLADq2fdtoU0AD5Eh63V9uU1vfkasz+irwV2OYPIJ9Y4hTfxV4s5D88nXNAwur730/6fZ3na2SgtTXbOWadx3kaU8NV5W3rqUHgYTIWtYuBeAtysmXdJslAkY67JIGLhkjMzrSXC1iQmgHgdZMYOL6BPMLZ8/rQpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic9e9hjVrtJc34Hc6AC2HkG4LY0LjbDTJk2lRwQ023k=;
 b=FBBRY7nuFS9bdhB+DIQMpIZc9wXul6IvGfz27mRAF7QZfRsOLn8XtYFyh9Jbtdb9WezasN8YUEu/58LcQcQx7zZksA1L7Mcj2E4fz3pXznL24rh+y+WW4ioYXsi6xm1cyPXBy3PE+SdD5sUUxgxlXlgjuYOZz4cWLToxwYfvB1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 20:28:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 20:28:54 +0000
Message-ID: <e7570bc3-5420-4743-8a75-8602559ca235@amd.com>
Date: Tue, 3 Feb 2026 14:28:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: Russell Haley <yumpusamongus@gmail.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>, pierre.gondois@arm.com,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 perry.yuan@amd.com, zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
 <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
 <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
 <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
 <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
 <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
 <211d9dfa-26e6-4fc3-b70b-f5fbca49e5fd@nvidia.com>
 <CAJZ5v0if=tMiyLB-efkzB67SniJS-2pCVv1-eN+vzZxqrdAM8Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0if=tMiyLB-efkzB67SniJS-2pCVv1-eN+vzZxqrdAM8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:806:24::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 856e6a57-6f30-4a4b-e537-08de6362d9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXhKc3duRTBqM0ZwbTc0Q3RKOFlEdGFTdjZCQ0ROc1VKQzZ4a2huaWZlMGhF?=
 =?utf-8?B?N3FRSXA2cm5CbmRhL1lUOUt0d2IrekdrNGxQNks0ZHptenJua2tVSTR3WXQw?=
 =?utf-8?B?dHZ5MnVRRlNJWU4rUVJ5VWFTZGZmRWJTNXNFZUhuWHdRVnViVHVKYjI0ZnBu?=
 =?utf-8?B?MHlxb2tvTWZYQnNtM3p4L1Vrb0w0OHV3ZFVWRUo0SnhINzRvZVJBY2VkL1Qy?=
 =?utf-8?B?YktxRUh4L3hSRnpRekhoM1d6czlnSE9BT1krdlFEMitJc1EyUERmOGZoUHJ1?=
 =?utf-8?B?U0E5K3ZPTFphTkkwRGordkxOUVE0bVJhUUVFdEVWZGZUWUhRTFVqTys1TDM2?=
 =?utf-8?B?Q2RRWXdJVUxSek5LMEIvdGV4SXAxNWhBNHBmZ0Q4ZC9vTUxTZStxMCtkQU16?=
 =?utf-8?B?cEZwbHBPd2R2bldicExrdjArQmcwZXVhaFU0ODF1cWdzY3JYQ3c3ekUxem54?=
 =?utf-8?B?T3ZpQVg1NlNwZUZuSGNabEhqMGhpK2pMaU1zTUpxa2kwRDVHbDFLak1yd2hI?=
 =?utf-8?B?RGcrRVJmZzQzWkdBbjM4ZU5UMkpwVk90WFYra0pKdGxIdTJQOS9pZTY1Ukxy?=
 =?utf-8?B?OGI0MEFHVVExMjl2K1hVZEhrS090NmFXeTh3Z0hBcW8xRk9tUFBhV3YrWWVD?=
 =?utf-8?B?V01KWWtVQVBsaThpUVlEMjhCb05ZQyt2NWl0VHhId0F3NUd6WnNhZDNVY0w1?=
 =?utf-8?B?elZ0YytQMjU1Q3RNNjBPeDZkdGhYK3BRMVRKZG03R3g1bk1BcW93SE9HTFZD?=
 =?utf-8?B?cUhEU3dBR1FzcS9uNFZMSjk1a0RTOGJvcnRHUVdpRFpJMENIc0V4NVBnQmRG?=
 =?utf-8?B?bFhjYzJwVW1iajdDTkNTNGF3T0N6UEIvRnZhSndTU0VJVXI4Vkxtd0tlWW9Q?=
 =?utf-8?B?akhIc1pUTE50N1o1ZnlyNDhzYlZCSFhBQk9uVVFKdW43cjR5MkM5V1lZVFAv?=
 =?utf-8?B?TXhjcHMzdllxR3FFaWtnek1yMXBPb0ltcmkwNGVvMmdxOHFCa2xYdFE3a0Rq?=
 =?utf-8?B?ekNZMXFFVlA0N205ZjUyVjdpY00zeFpycU5nQXZKTGFLcklGNEExaTZ4TFc1?=
 =?utf-8?B?cXpadFkzM1djRlBZRWMyV05jS09ETVlyMVl3YXdLTVNHTTV6YzRRMVd4U0JQ?=
 =?utf-8?B?RzQ1azlqOWFJb3p0a1dXRFR1Vzg5TVlGclIxVUhpQ3FZYUxSSFAzdXc3dWFt?=
 =?utf-8?B?dmprQ2s5bVVhd2x3WmhQLzVuUGJYd2FmZm01TGp4eGNMOWhqbTRjUm5BdUFV?=
 =?utf-8?B?UlFmaE5CTit1dXdFazdUZnJhaFN3WXliNjdFQjZHb3ViOWVRTngyZHFDdUMy?=
 =?utf-8?B?NzNpM29SdzZrdnV4T1FReFhOSUllZjlWZmw5Q2sxRy9rR25RdE0zRGU2Rnox?=
 =?utf-8?B?T3Y0YkUwMVFuZDZCV0NobFpMcXRTWXF1Q0F2bnBPTElJZU81UHNCNi96OEg2?=
 =?utf-8?B?UktsRVVrR3BuZzFGcjY4dXVWVFZrdXdiZFdjaXZyb3RmcnROOXlRUEdXblhz?=
 =?utf-8?B?RzY2QzhGdVh1S21JYzlDRDRZYkN6SjRNc0hwbjI0SkhMRnZpczA3YmNRTzZk?=
 =?utf-8?B?STMwZmtEYjRTS2VSTFZzWWJuU2F6Y0xGSlAwT2RPY0tWTmxtbmFoRXl2RGpn?=
 =?utf-8?B?WGIrM1VvdjZXZGExNDNId0MyN1VYcEpCdzVjRHpaUUhxRG1Edk1Mc01HTGU4?=
 =?utf-8?B?dnRybzRKcmNLTTIvTG9uSXVzSWZmR3lZNEdKcEhvR00yMkNhOTVWNnRhSVIz?=
 =?utf-8?B?bEZSbURMQTRHazhqOFlGcHJGYyt1aXE3QVNSd2VUeVprOHNjT3dBM25rQzhL?=
 =?utf-8?B?RnA5bndkSlkrblIzaXlzTTN4WmZsOU51MGtqdkZyUEFWK1F5OGdENUdsQzIy?=
 =?utf-8?B?RHBCczBLSm9lR1kwQW1PYVY2SGVWM2M1WnJmblVxNisyUy9PU3hIbEx1NGJG?=
 =?utf-8?B?c2hFYVJGVlBjZUFzc1pMR2ZyMUxLRnp2Ti9aZ1lMWmFBcVM0NitmUEJuRnRY?=
 =?utf-8?B?NnkyTUhiQnlzdHlJR2VaalR0M3gzd1RtaXYrSkE2QWNLaDJyNW9NMERXc0xr?=
 =?utf-8?B?c0EzcXl4OUw1MG0rR3BNKzhIdzRDN3hmMkVjbExFU05WK3AySndmbnREZE9L?=
 =?utf-8?Q?g1WGSQ8WmqQPyWwuiXdJRH9HK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFJhZkR6RXJ5OVc2ZW9ZNk9jTnptZExzTTNyMmYzdG9XUkVpZ0NXb29VYlF3?=
 =?utf-8?B?U1RZVVNyNThwRjJZTkVDWFhybEZSMjUvWWhhdG9RbTFCRHhkNnAvVWlQcG51?=
 =?utf-8?B?VWhqcW9NeHl2SVhWbWJ6S21xRm5CU3VkMlVQVWxyVHlJRGRGMTVRdVZlcHcy?=
 =?utf-8?B?U3gzK0JFQWpTMlRueUh2MUZMdkQ4cHZBREpJUkRKMktUbmNJeTNzWmZDd1R4?=
 =?utf-8?B?WURFbXRHdzFBSHladFdKUGFNQnJaNmxHSnBYNGpVaFg2QnZuY2NHcTRQb0l5?=
 =?utf-8?B?VENqQmJOL1NqOFlpQStBNWpVU244RHNmTW8xYmI3MW04aEhXWXJmQjJ1QVpS?=
 =?utf-8?B?WGR6M3E5cHA4ZUpoNjdwbkk1NlZjVGZ2M3pnVUFWaDMzZG0vUFdLZERJNGEr?=
 =?utf-8?B?Y0lKK1VDY2UyR0h6UkZvZlFKS1d1ck9mbmJlbk5TMTBhTm9SN1RBSHQ5Myt1?=
 =?utf-8?B?eWh6RytFeTdKeDlsVkJOejRiMEgzZEpvTmpMN1RLaFhWc3dLQnVkL0t6RVFL?=
 =?utf-8?B?Um41MThLbXYya3VyVGgwZmUrTktIcVJ2NVl1eXJocUxxQ0Q2OE1tK2ROd3lt?=
 =?utf-8?B?Uit3UDFYNjJld0krZTN2akVhbDBkbEw5bi9NUXEway9BMzkzSHRVajhUc0ts?=
 =?utf-8?B?YWcrb2NUSTZTSlJJVU9SQUxvVEdmS1NqaklJQ09yKzlOL2ZRZFYyS2pRY240?=
 =?utf-8?B?K0FKWkk4TTdySWhFQkV1WC9oSktiZExIQUd3RXBMSlY0T2ZPVytKTWIrSjhY?=
 =?utf-8?B?b2FCVE9lMnZKOCt2MU9rQW9OYmU0cCtKVUtKT2gxV2lJc1gxb3Zsbnd3MUdB?=
 =?utf-8?B?Q1hxMk54bWZMOGx2VStWQjlkUGdHYy8vbVg0d1dwaVhOaTdEUHRWOTFVd2s0?=
 =?utf-8?B?d0IzbGxEUmZibjJ5Z015ZDFuQWxlc2JESnFJQmppeXJMMDBCcGVBR0tRaUF1?=
 =?utf-8?B?ZmY0TjVJU0RFenM5MmYySDdLT1Y2aGx2L1hvUzRqWmR0Q3JIdlhwZHpOR3Ur?=
 =?utf-8?B?S1h2TEVwd1Rua0VnWmNGVk5jSEdGOTNjVWxjN2tHajkxbUJSR0FXYWxhUHhq?=
 =?utf-8?B?Ky9qUmNOaE9BME1SSi9BZkw4T1g5dlVvTitxVjU0U1dNb1VNVFdtMmdodmtB?=
 =?utf-8?B?VXUxUlc1SkZQWWNRZ1kxS2ZoUkZCZytNbkUwL0Z6dHUzVkkxQUdJRUJONWdG?=
 =?utf-8?B?SnlXNUwyTklmakVUSDdOYWpIeUJHb0RBWkFWYjRNajlLbnNvcHhxcjZDUzRK?=
 =?utf-8?B?RTZLQkVHb1RISUl0VUQxbzBtYVRFbHZjQ0drS0Y1cGVNck9VcGlPbHVzVzRQ?=
 =?utf-8?B?a0ZOZE1EVHhRcllkSHhsWDZDUll2QnRWV2VnWCs4QUw5UUZwaHN2dTNseENa?=
 =?utf-8?B?L1ZsK0xEYkhWZnVHTHRSWVU4c0NFQU40TGJUMU5VUjFiQ2xxWU52N2M2aFdm?=
 =?utf-8?B?anNKMHpjdGE4VXFlSkIyRWNQbFVkVys1aVF6UTZ4NVlwbk50V2NZb1lHOWhD?=
 =?utf-8?B?eWFFNEFZOXhxcXgrUVZDdUNieWFlVUNqMHVqam9aWDVIUThGOXBMMW1MSXNM?=
 =?utf-8?B?R1VTQlJiWWJwak5mZnVVVlhyTWVybnBhSVY4TzY4RHAxQ0U1RWNZZ0RzTFM0?=
 =?utf-8?B?aEg4dG53VnNZZVVlRVJJVEQrMnhOTmdUMGdJR2xMVVBUdTFEbFdmRHdzREFl?=
 =?utf-8?B?RlpRTXZpRkFGS1ozRUkyNmFGdWNqNGVnN2t6STJqZXhYQXNyaXVsRzdVSzND?=
 =?utf-8?B?c3NsY2p0dGpTbzZDTERtdThRbWtidXhaVThTNE1GdU5XZEFLOGhPRUNRQnl4?=
 =?utf-8?B?WjMyci9lNHBnTXZtWU5OTDJQMWJYRnh5YUlNYnF6RW9FUkRHaUw3NEEvT0Rw?=
 =?utf-8?B?WGgxMm1BMEkxNDJWSHVMcGlFQXE2bHpwdWFLbjFlbFZmS21zM2tOY2d6K2JU?=
 =?utf-8?B?ZFpGSHFJUW5TVU9rWjN6REtRT1crdW80WE5adFB5R2N0MGZjL3o4cjVyYUZt?=
 =?utf-8?B?Z2pMUHpjUk50YmloSEhKaGlxbmJNTlZUeWhENnZwZStNYVVraUZuWHZpQ094?=
 =?utf-8?B?ZTZaQ2ZpSnpNRnVsR2VhRWp4aERFZ29sUFBOb1hkS2M5UjZRR3ZYK1J0dW5Q?=
 =?utf-8?B?TG1VdkprSWVEazhnZXhQaVlWRll2WE8rMFAwS2tiM2ZaTUdET1MyaVNzQW1G?=
 =?utf-8?B?ODBlOFpud1pISWMrSkJuU2tiOUJUWWpUVldCVmtGWmJLczNEVmI0d3ZVak5J?=
 =?utf-8?B?WUFvai9mTDAwbnVGRk5kZWhnMjdNYXNnaGVIazM1d3JsYnNab1hkTGYvUCtN?=
 =?utf-8?Q?K2bh5Vt5HMv722K8jW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856e6a57-6f30-4a4b-e537-08de6362d9f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 20:28:54.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gyjIzUFhwnmohdA3PEkc7SYdrz6JvjJBmaHRyQHFX1NGYDYTZyJfnXXEs8dOiw9VHwuBqIJKcB0VcrC6HuxLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-20841-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,arm.com,linaro.org,lwn.net,infradead.org,amd.com,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9488DE7F3
X-Rspamd-Action: no action

On 2/3/26 2:24 PM, Rafael J. Wysocki wrote:
> On Tue, Feb 3, 2026 at 3:32 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>>
>> On 03/02/26 18:24, Rafael J. Wysocki wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Feb 3, 2026 at 1:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Tue, Feb 3, 2026 at 10:41 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>>>>>>>> Hi Sumit,
>>>>>>>>
>>>>>>>> I am thinking that maybe it is better to call these two sysfs interface
>>>>>>>> 'min_freq' and 'max_freq' as users read and write khz instead of raw
>>>>>>>> value.
>>>>>>> Thanks for the suggestion.
>>>>>>> Kept min_perf/max_perf to match the CPPC register names
>>>>>>> (MIN_PERF/MAX_PERF), making it clear to users familiar with
>>>>>>> CPPC what's being controlled.
>>>>>>> The kHz unit is documented in the ABI.
>>>>>>>
>>>>>>> Thank you,
>>>>>>> Sumit Gupta
>>>>>> On my x86 machine with kernel 6.18.5, the kernel is exposing raw values:
>>>>>>
>>>>>>> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568
>>>>>> del:437439724183386
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
>>>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
>>>>>>
>>>>>> It would be surprising for a nearby sysfs interface with very similar
>>>>>> names to use kHz instead.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Russell Haley
>>>>> I can rename to either of the below:
>>>>> - min/max_freq: might be confused with scaling_min/max_freq.
>>>>> - min/max_perf_freq: keeps the CPPC register association clear.
>>>>>
>>>>> Rafael, Any preferences here?
>>>> On x86 the units in CPPC are not kHz and there is no easy reliable way
>>>> to convert them to kHz.
>>>>
>>>> Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to be
>>>> in CPPC units, not kHz (unless, of course, kHz are CPPC units).
>>
>>
>> In v1 [1], these controls were added under acpi_cppc sysfs.
>> After discussion, they were moved under cpufreq, and [2] was merged first.
>> The decision to use frequency scale instead of raw perf was made
>> for consistency with other cpufreq interfaces as per (v3 [3]).
>>
>> CPPC units in our case are also not in kHz. The kHz conversion uses the
>> existing cppc_perf_to_khz()/cppc_khz_to_perf() helpers which are already
>> used in cppc_cpufreq attributes. So the conversion behavior is consistent
>> with existing cpufreq interfaces.
>>
>> [1]
>> https://lore.kernel.org/lkml/076c199c-a081-4a7f-956c-f395f4d5e156@nvidia.com/
>> [2]
>> https://lore.kernel.org/all/20250507031941.2812701-1-zhenglifeng1@huawei.com/
>> [3]
>> https://lore.kernel.org/lkml/80e16de0-63e4-4ead-9577-4ebba9b1a02d@nvidia.com/
>>
>>> That said, the new attributes will show up elsewhere.
>>>
>>> So why do you need to add these things in the first place?
>>
>> Currently there's no sysfs interface to dynamically control the
>> MIN_PERF/MAX_PERF bounds when using autonomous mode. This helps
>> users tune power and performance at runtime.
> 
> So what about scaling_min_freq and scaling_max_freq?
> 
> intel_pstate uses them for an analogous purpose.

FWIW same thing for amd_pstate.


