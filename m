Return-Path: <linux-acpi+bounces-14242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A6FAD1ED7
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824EE7A3CDA
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F19258CD7;
	Mon,  9 Jun 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fJRMWC5q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC9256C87;
	Mon,  9 Jun 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475709; cv=fail; b=LjsHzyG+6UWcTfrVe6N7Nb++mPICuG9UYCmimsrCkp7xQhETZ9i6tbpbTp16r6BBYLmYZjXhUXGBeUtuKoUCr/o2eF0Ndmi1ZW6LTzRVxtLOTmC7I5vCP1GV5w2CL/qkITYwXpuciuJ+ILgJ+QtfEjcnibunty1p2nEaezWV6Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475709; c=relaxed/simple;
	bh=QCrL82sz9qO4DwDqgYz0z2pKIQFUr4Y5GYffZJM86jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tqSPn+3yhIkOFTxZTfQITBBRDSKn50TCahU8JHqGH+Vqy9UeO0zabNs5hJTIrlliQrzJDM3KQzfuQlSJJ6x1WXyEJI3RbJJLx9enCMnW5hDqju929NpfXfy6GnAVaTgU7FCGC1rkg44/IMSLA/HCCAjkKxeaz33pS/MT9SjwsHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fJRMWC5q; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6oKN27oMeLI/lkNYY+mbbf6D4/LsNlTIURzmKWjc4itYS4IR7+Ky00qIAOP2AQzh3FEZ7ADg5DzuVmM2WAxaMR4Ilh8PrUmWfC+PUPklqs06Zd6xIXu8tctC8KrML7mZgs4QjFc7/hW+QFn59D9EiMwQesrN8fjNOtyUcgC+g8jD9ANH0JQ9g6CQDSTFORkOYsjeEsbV2mEoE/3/Oh20tbBmoF/6gMv+1uu1Yc0NcGIRwB0VXWfEvkvvnnvno5mAi3D4nWsG37l8cTwXF3b9jKNZbbToCEoUmlnc/dLFajlMwVpL8d2vKONbbpDqz9KgdoXQ8rcCGdbZxc5eP7bLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2qh4WW2cJgcu0bYIa/8YVbG6JN5+8jirVBNU5esx3A=;
 b=LrSNF4hF92jSFV03Swf8Cs8YO2l8fC9c6sXorNvAuZGFVLeB7ZzADldJbBDTtxfUuz3dtud3hzy1GaFthYz8PvWwBCXl7zRndqC+daYuEcuI4MfoK2sLk+5DXPQeuPXOOUuw8oS27rVnyi29xyPFUCuqFwhP5mPTd5Dx17uteRb7Fo3jbuuiGJtUuBCA5BBJcQ/Kq0Wvu+pR1F3RWIf1OYnkkfntB3bLAPH7RVD9IqMTci6ROfVxdOK7iyfOgYVvXxTGfvZKdv7Hk7XL5zDqfGV+CEHW/F9WTbHXxVfbGpGbgxLBEuL7iUD5QW1f6WkE+eKt7YDzkM80fSQdzSxl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2qh4WW2cJgcu0bYIa/8YVbG6JN5+8jirVBNU5esx3A=;
 b=fJRMWC5qBu3xlzDbP62GQPJzD6lnadwQF/l2Gjqs8LbWqnu75+uVSqu/LANC0+9Xf1S1ZwkQexcse4AkKVL7GxYgoZQE5wk2XqMkG8lux6IUG9q1MoIzLRATjhXZzY2TeYmpeJbjNzOmL6poS86NpDzrCzuEhUBM7GD1yqr+EiQ=
Received: from SJ0PR13CA0138.namprd13.prod.outlook.com (2603:10b6:a03:2c6::23)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.42; Mon, 9 Jun 2025 13:28:25 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::da) by SJ0PR13CA0138.outlook.office365.com
 (2603:10b6:a03:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Mon, 9
 Jun 2025 13:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 13:28:24 +0000
Received: from [10.254.50.197] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 08:28:23 -0500
Message-ID: <51bbdb65-8b42-4003-a229-8581d2212002@amd.com>
Date: Mon, 9 Jun 2025 08:28:16 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ACPI: APEI: EINJ: Do not fail einj_init() on
 faux_device_create() failure
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <gregkh@linuxfoundation.org>,
	<rafael.j.wysocki@intel.com>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
 <20250607033228.1475625-4-dan.j.williams@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250607033228.1475625-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ec4d35-d877-4663-01e3-08dda7598307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0RNSlAzczl4VHkyQzFyVktVRi8zZUEvRVlZSmEreUpGS2NiR1Q0RVFUN0Ix?=
 =?utf-8?B?ZlhJUG5pSEpmUjJyb0Z5VTdqb25DSFlqdlhSK3dhSkFqc2phLzIzQk9LK2lU?=
 =?utf-8?B?VHlWemk1OERGNkdDdjExbVZXWXhRakZnN3djY2JwUDVRSnlvcWhncVdUcG9N?=
 =?utf-8?B?RmluL1lxV3JEcHAwVmE0Mm00WUVTamF4ZGFvd2pGYVMxSUhLZmJkdzhGa0ls?=
 =?utf-8?B?clU1ZnNTZkhJbzBSbUtYZC9XQXNmd3JUWmtSZm95TFU3N0RNcUs0ZUtEeEtT?=
 =?utf-8?B?WWtWaGtnd1ZzNmJaU1JncWc1MjA0R3I4bVdLY2I1OWlRS3czNDZYdTNNQUg4?=
 =?utf-8?B?OFdxWWRmMVd6V2J3S1czUHR5N3pNQWZjOVJCWXFOdGRrN2pKeHJUa0x2NHd5?=
 =?utf-8?B?YmtDRjl5VUU1VnhvRW94bG5CMXM0YjEwdEhmSTA5d1ZRdWJHc1B6Z1hjYmpO?=
 =?utf-8?B?MzZoSElSTStlaytTeTlKRjM5dktOTUxYeEcrU1lJbnF1YzNzdGMzQnlSQjlK?=
 =?utf-8?B?N2pYMXhpNGdvL05Nc3E4TkpBS0VDV0srdVRsVk44WDVQMDNRNklBVTFZa3dR?=
 =?utf-8?B?amdYMm9pQUJ6bUU1MEM3QmQxV3c2cVA5SGZrTHl1aWhDL3loNGZsOUJuUE1y?=
 =?utf-8?B?VU91WUFkc1FPY2w1Y0dDb1Rlb0psUHQzcXJRbmFQRndNeVU1VWRGdVVLR3Zr?=
 =?utf-8?B?OGFDRkgxQUsrc0hTQkM2bUh6NklBcWUwaENXcERHR3RET2J6OXBlZXJCZEF0?=
 =?utf-8?B?K0pVWVFrRjJBVG5mVjBJZ2IyNmNMRXVUMFZ0N0lVQ1RtVThDK1VwVVhQdHJ4?=
 =?utf-8?B?dUtxSnpxbEVITG1wSFdVdkpyMUJ4QlJFOXlGd0tLMUJKVGl3VFBOdkxjMFlz?=
 =?utf-8?B?SFgxaFNYM0dmbVJIV291UnFVYVdNM1ZtelhwMGQzNjhrVFYwWEdRUkFRcGJK?=
 =?utf-8?B?N1g5WG9XYkIwUTcvNE9hY1VWOTgzUjdLVmRIL00vemo0SlZrTUM5WkdjNzE3?=
 =?utf-8?B?QzM4MDdMbzdGVnFoekZZcGkrZGdSQU1aSW9mVFptMHlYc2dtQTlQMXp6UFBx?=
 =?utf-8?B?cEoyTHB4aXNXYm5kbFhqaU5adVlldTNENnhwRHZJZk9seDMyaGk5WkVzUUhO?=
 =?utf-8?B?WG4vQ0R1bGNEU1IzMkNicXU0amNzclBLeWU4UEYwdkJuaDNNRjNJcUZPVGV5?=
 =?utf-8?B?UGZRaUhrQkEySGFPa2FZenBiR2xrT2lRS1NtT2hKM1pjcG9TOTZwY1BKVnNZ?=
 =?utf-8?B?by9MNU1pU243WUtGd0E2azB6a0hNUTMrWVJra2JrVG54TmlnSSs5L25pQm1h?=
 =?utf-8?B?RlQvZFFnRDNxQlVlRlo0K3h0b1B6S0FzMlhqOTBqSDVzbno0NVRuZkpQZzhq?=
 =?utf-8?B?V1hyRzlpWXdWTjhGNVdJNGp6WGFiRk9BN2FVSldXbW9JWmFER1V2QVI1eEFL?=
 =?utf-8?B?UVBqTmxIZ0xFb2hHdUxEMWFXYWs5akU4ZWxpRUNkMW03YjBVcGxlMjM4VkJW?=
 =?utf-8?B?Q3RWUjhnbFFtWWVyZGluYWtpb0x0RkxVUkZ1N0pSVWZ4TmtrRGpPK0JrK01u?=
 =?utf-8?B?K2NuOXZ5WkFTV3I1VE9FQVE0QUhudnBmdzluMlJZSGpxUXZKVFdNbXJNU3dI?=
 =?utf-8?B?RGZrREZCUXpXeTg5VllhNTdXMXBaSkJyOU5uN1dqUVhlTi9LTm5nSy9nQ0Mv?=
 =?utf-8?B?cWVUak5VQ3EwalAvYkJ6SnhlMFdYVDVUcjlEU0o5SVcrOXBFVWhrZkRpbVQx?=
 =?utf-8?B?T00xT0tZajBVNlNiU2JySzJSbVIxdEdIOUJJZ0c5aVhSK2NLaXpOdm0wVVph?=
 =?utf-8?B?WlJ1N0tkUDdyUk9PTzFlMEpuWUZJMlhMWEVLQ0RNcEZycE1KZ2JHc3duZlE0?=
 =?utf-8?B?NTdKempVNjcvVWFHRFM4MXhJSk1DN08yZTVzN1FsY0gyQ3JTSUpHTFFRZGQ3?=
 =?utf-8?B?bXZ4em1UZXZsUkRBMjY3NXYxRThBQXFXZS90bXRUUGMwVkZQZHprcHlxVjlC?=
 =?utf-8?B?eHVEaTROV0dWL3pmMm9kRzhwNkhiK05mcFNUUlRVUnRsM2tEaitTMVFVZUM3?=
 =?utf-8?Q?19nNNG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 13:28:24.7217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec4d35-d877-4663-01e3-08dda7598307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557

On 6/6/2025 10:32 PM, Dan Williams wrote:
> CXL has a symbol dependency on einj_core.ko, so if einj_init() fails then
> cxl_core.ko fails to load. Prior to the faux_device_create() conversion,
> einj_probe() failures were tracked by the einj_initialized flag without
> failing einj_init().
> 
> Revert to that behavior and always succeed einj_init() given there is no
> way, and no pressing need, to discern faux device-create vs device-probe
> failures.
> 
> This situation arose because CXL knows proper kernel named objects to
> trigger errors against, but acpi-einj knows how to perform the error
> injection. The injection mechanism is shared with non-CXL use cases. The
> result is CXL now has a module dependency on einj-core.ko, and init/probe
> failures are handled at runtime.
> 
> Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Thanks for sending this out!

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

