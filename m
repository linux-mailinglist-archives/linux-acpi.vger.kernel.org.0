Return-Path: <linux-acpi+bounces-3987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15086A0B0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 21:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA551C23781
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5F14A4C1;
	Tue, 27 Feb 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fTezXRVF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32824D5A2;
	Tue, 27 Feb 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064883; cv=fail; b=jw6WIIjGyGXHA/Ur7/wfJzVPRv2Pm50Qf9WnK3oej9ocd+uEUOS7AV537WNERbYPmprpb3QkxTHzO52KPHvgPABITnGoCqGyyxxQM+qgeb4Ydo2eSnPsmvBh7ErlRnZOAK0nm+mWukU9yPUmMjNfq7QEkD5mA+5cVZSjuXvkzw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064883; c=relaxed/simple;
	bh=NHFFZDhNLextz8FPuGVUkn1XBlW4b7OeI5ncX9NX8tQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+OuShEAOiWT6oUGeM7YF6fH7Tfs1cVXQkrUNzQCMb7Sqh6P9DDg3+Nb/+0XW7difLn/PgbWZhY03iLtzHTgCXzB0xXrFOJ5gDcv0aMc8HzfIs3KwHmLXoztn3ykSUkskj7My/OLFy6kc6Q3B8QvAFaGeSrLw3jKQXyQJy6gj14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fTezXRVF; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2dWMly+x4BmeWvpRTu42Hdn58tMT1e8CBeTToYTtju7OA15lZXEgVMIi9A4ALlGo+lHj2ocwUnFU4H1CxdOHkjZPda8XhvBxzm9mWKEUAQX040ZPEYPBRd8Y1iemLavIW9YA0BrlMADYUzdXYqmZe0vh6Df0RHtRIJl4YqonydquFDZSA0ikK2Mz9n9tu61Vviu/sZucD+E70s8vBkkPTd2XPwwn7lITpAsyH+oJd+s+BDiXhnQFq2GoNNeYQyf8Z21mpSAYY0MwcebbZO2XiI3apExpBefA+wO8bDpZAxoBfco4b+Y/OVlmO5J7/weuzvOF7SaNDMl9dcjxLDCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhHJISLYg5reNFVNXUSFRtV8FtJoRObs+N+hzYPd1/8=;
 b=O2IPRTlKugkwHsvL9ZMgCttjXRxvJKWxo9HW0IpT5OrBkA6zb4u+JC/PwW15zMQA0C0ewXXtMcGaNIs01bScoOJPlWuROZBEDzunQtBTB2wjA6PmTUS3c3/oMGDDwWsoRCh13pLagJQlRRRMcN58o8Eq71cMhWJFz8Ce/Q+oeighS0Dxk6EpiYoR3sE0fmKS2JAd9kbzHy6SWrr2P5sn3Ebtb1u7F/5kS8ZamqBGZ4W3+HYHjier2uPItD8+KxG8EWZ9lAaS+DeXgv7VBMRQn1Py5VhkXegpeuu4wfSyhC3lAIHHyu+aGvDsXzW6soX1ZyUjrfEzEvNaM6pDwrV1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhHJISLYg5reNFVNXUSFRtV8FtJoRObs+N+hzYPd1/8=;
 b=fTezXRVFGzzkUvB8kXQ5IypyWp3eFNQqbH3aQfuaSocjJc8zBb1pV2MrXY8IfqHqLmjewRK13kMMKWFjfRKpbt70wCj0HUnk3xOsCO/PzZopkZ6K3GKh7yQ9525gVWwEatZHZwZI7ZbhzFzq+SEhjokdCMjW9qjkZ3c06ZknTjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Tue, 27 Feb
 2024 20:14:39 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 20:14:39 +0000
Message-ID: <fcc39ab2-d616-4be2-a816-b0037a9653a2@amd.com>
Date: Tue, 27 Feb 2024 14:14:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/4] cxl/core: Add CXL EINJ debugfs files
Content-Language: en-US
To: dan.j.williams@intel.com, jonathan.cameron@huawei.com, rafael@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-4-Benjamin.Cheatham@amd.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240226222704.1079449-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc5a3ce-7321-48f1-2687-08dc37d0b9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZRjSyyylXSl02lM54HQfpWLO8MyT5Jcjx6lWjNtvUzexshJFZ7YOCHffrTnSx0OLe6LMYSIdO/JFSuE9Xv/3QNJhNt8pq73Nb/2AgSsGlV1oynBnhVMqWKh6PxoLDK74jwx3vBvTxK/EZXS/NiFd3jKsN/riVn/L0F3gUjURx5jXMEaICTFHqsHSLAjWpiELI7X4ePi2KEds4dT80YFULPVY0O8m0QVzNoQ+QV72Lb5xAO9TpWTok+2mUCwbf1X6kcEF9iWgQAoogj8DFxk4cEriAl7GkGTw54+uYfETGAYv72zRu8UuZW4jdzqStuDmGfATK/xV/LlBCfANgPCBqnuX4/4smtDTOs0a48O2VwLNCl/+DWIH2bmZ1u3ELBFdtKDzr5vJvDlsmd0TWdaDiyCQz7AzysfmAWB8AUryU2FjuJqX+W3xsQsjY+WHdfvh2khS4VHkVeI2qCRy7+aEFtXDM87tdKSUlbeJvayN9uSreTKYRTc8DF6fGoIsGQVWbIP29j1Tz+54S9g1EDDV1t3Jz3f6zp3OE/4uzEgWb8RWALxw6cIf9CWsTfkSIoJuqIEERaRBG8pp/1TNsQsMavaXEOjGtaGzmGZQav1ehy7sgmAUZeJIwacKjX9hB+lkHAx4j6o2trj7aw1CtfKXkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek1lMWtWWURYSEdzcDhpL0tqSkpLZWlqMHYrTnVHZVBmVFBFaExhVC9qdkp5?=
 =?utf-8?B?WmZuY0EvdjBVOFB3aUVhVHZjOTZFNjhNZVJGaXNTc3h5VEtWOWk4U3dGSjBF?=
 =?utf-8?B?Yk9PYVlWYWk0ZHFEaGc0WXpvaXA5WXJxKzRBYVloTmUvbFJzMGlhd2ViQ1dZ?=
 =?utf-8?B?MFlDTHU2RWoyNkhOb2NhUDBwTjVKVjZpbWlsUW1wemcxbEhvVDV3eGRyMkdE?=
 =?utf-8?B?OWFQMGUyOThNT0w0S1hLa2Q3U3c0WHFKUnNjNm1hWnVLVEcza2o4akhKcDg3?=
 =?utf-8?B?T094UkVGY2RwU0NZUmorU3pabGxwZnFSYXJjQWpjaVVuV0FSR1ZjQ1luOTg0?=
 =?utf-8?B?ZDkxRVRnSHh4VHI0aWZxK1RpbmQ0c0NpNlMwZlU2Ti9HeE9oNkU3U2xnZGhI?=
 =?utf-8?B?am4wUzV3ZkFxbUc1dDdTbjJaYXpOSmdRU2hrUGVidnhmUHY0cnI2d1gyS3Zt?=
 =?utf-8?B?RU1RQlkrRjNOY2dBeVJzVWtObnlMdC9tR0paUkFrMUhDbTZpaE9takxLK1FV?=
 =?utf-8?B?N2RMditKOEYweStnNmRJNTdaWTdveE4yV003WnBMSitJNXpqVlEvUmgxUlZ6?=
 =?utf-8?B?Yzd3b2hDc2RpUzNKUmlPMUlkMGJvT0RvQko3d0dNZGQrSHE1czVMSG1BSzV2?=
 =?utf-8?B?OTduYWU5RFhZWWNLSVcxSmRleWtySkkvK1RUWXM3MXRIYmN2RmFyaC90RzA2?=
 =?utf-8?B?Z2FmYWpiS3ViRENiSkF5TDVRYWJNa3ZOVTlVQjN3b3FNcVA0aHNVK04reWdK?=
 =?utf-8?B?VTNWRlJFblhhbmZzcXA3eDZEaUFCMmJka1gwTGtxQUhYc0h5cEZsbmFzaWYv?=
 =?utf-8?B?OW9KeUdLaFBUQTgrUVhtNERwdnBXeCtybzFhNURUQ3ZBMVNzQTBVRFVtUGJV?=
 =?utf-8?B?N0l2M1RmaDFLSkN6UmE0OXE3QkpYTFZPZUhvcW9mS0JEWm5pcWxDTm9JOGha?=
 =?utf-8?B?RUN1VjUxcmtVQ0RySVJwOVJxRGIvK3FBQ3ZheFk2Zm9TNHlzaHF4N0ZiUTA2?=
 =?utf-8?B?SldJdVlMZWpQT1ZtbGtFQXluZTJxUlFsTTluRzVmaGs0SGxOMkVFV1hCenEy?=
 =?utf-8?B?R0RLNlh2ZkJDci8vcXRpdjRWbk5MeW9neGNWM0NHZ1BrY3llOCt4V1YrT2My?=
 =?utf-8?B?RzA3S1M1aGRwYXdIemZPcWJ2eUZCdm9CSjdNd3Q4b2ZYakd3TTYzWjhBRmNt?=
 =?utf-8?B?ekZTVENFNmxUUkZrZ1J4bGtyb0VoNDJScDBGMlZnZzFRQUdSdnZoeTBmRGFU?=
 =?utf-8?B?b2ZuS2dyM0l6R1dmTnRPYUtiOFZSQ0I1c2RldFQrMTRkS2tBTmx5Tjk2UnVl?=
 =?utf-8?B?aVNTeEl1NW9BQlNVbjM3cnVwUG5IK21HSVNHMzVNWGdYUDNkVUtCeDE2OWxP?=
 =?utf-8?B?c3dGaHNZWkJZYStMdk5QVlhXa1BpTzdlZzVGb2YyRjlWTXVBa25HczlScXN4?=
 =?utf-8?B?L3gwUzBmaENMZzFuMUpSZjdZbUdRMExUdHZFTE9xWUZpQy9hMnVoK3RYR0Ew?=
 =?utf-8?B?dmNSWVpFdnB3SW81Rk81QVdnK0JnSzJ2dElYMHdSUUIrVHVxdCs2OGwrR3Mz?=
 =?utf-8?B?dFVHNk1KYkdDZ3BGQ3U3djNHZ1gyN2RtYlJDRC9wYlg5SnFKcHBpYWgwS0lY?=
 =?utf-8?B?Si9HOVVpQ1Q1dXNZendWWU1RWEF4N0RnOXB4TGNsSGllSzVrZjdLS3ZQSjZ5?=
 =?utf-8?B?MmlNYmRieWJmRTRDTzJvMkVZemZZUkNNdVhsYzJtRkVzNU90dldUb2lkZXVB?=
 =?utf-8?B?SWJkVy8wSGZ1bVVlbGFpUVBUNmJEaE0xakREam1mNEZzaFF6MXRrcnM4cW9L?=
 =?utf-8?B?cVU0Qnc3ZktiL00raW9TU1ZaZFQyTUt3WGRubGRQZjU1V0crb0NsYkpTNmlC?=
 =?utf-8?B?bkhmQ1cxSnZORTU1STRtaWllWmpobzFZM0tyT3cyZUVIa0NtSXBBVnIvem0z?=
 =?utf-8?B?SXloMWhGOVhvbVNrWmpZaFk1VU5mRjJmd3lkMXdYc1BMV1loZ0Z6SGdoNUw5?=
 =?utf-8?B?NDlZUWlDYnhTV25XNlBSVy9FVFdMQ1hTYW9Zd1o5c1Fic0FwejZ6NGowWUl5?=
 =?utf-8?B?NW9zNXlkOGhTMmx6Rm8zalNUdXBNWnFjc2ZjSmt5eENCT0c2a1Y4cEVJajBu?=
 =?utf-8?Q?nFUDu0GwvQIA8TcAANz7GfIFt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc5a3ce-7321-48f1-2687-08dc37d0b9e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:14:39.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW2f1qPqdQk0AaxJCKLQ+RMcinZYBt7rHvIIJYR9a3lOXjeCc9cWXFX6CmArKAut0BcK1kf2hnD660XNHB6WqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

This patch also had an outdated commit message (still referenced the einj-cxl module).
The patch with the updated commit message is below. I also made a tiny change to
the format specifier of the einj_inject file to "0x%llx\n" from "%llx\n".

Thanks,
Ben

From 321129893da9129473c447772a461c1a4e9e0e9d Mon Sep 17 00:00:00 2001
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
Date: Fri, 16 Feb 2024 11:17:01 -0600
Subject: [PATCH v14 3/4] cxl/core: Add CXL EINJ debugfs files

Export CXL helper functions in einj-cxl.c for getting/injecting
available CXL protocol error types to sysfs under kernel/debug/cxl.

The kernel/debug/cxl/einj_types file will print the available CXL
protocol errors in the same format as the available_error_types
file provided by the einj module. The
kernel/debug/cxl/$dport_dev/einj_inject file is functionally the same
as the error_type and error_inject files provided by the EINJ module,
i.e.: writing an error type into $dport_dev/einj_inject will inject
said error type into the CXL dport represented by $dport_dev.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl | 30 +++++++++++++++++++
 drivers/cxl/core/port.c               | 42 +++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..4c0f62f881ca 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,33 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+What:		/sys/kernel/debug/cxl/einj_types
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Prints the CXL protocol error types made available by
+		the platform in the format "0x<error number>	<error type>".
+		The possible error types are (as of ACPI v6.5):
+			0x1000	CXL.cache Protocol Correctable
+			0x2000	CXL.cache Protocol Uncorrectable non-fatal
+			0x4000	CXL.cache Protocol Uncorrectable fatal
+			0x8000	CXL.mem Protocol Correctable
+			0x10000	CXL.mem Protocol Uncorrectable non-fatal
+			0x20000	CXL.mem Protocol Uncorrectable fatal
+
+		The <error number> can be written to einj_inject to inject
+		<error type> into a chosen dport.
+
+What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Writing an integer to this file injects the corresponding
+		CXL protocol error into $dport_dev ($dport_dev will be a device
+		name from /sys/bus/pci/devices). The integer to type mapping for
+		injection can be found by reading from einj_types. If the dport
+		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
+		a CXL 2.0 error is injected.
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..eeeb6e53fdc4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -3,6 +3,7 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
+#include <linux/einj-cxl.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -793,6 +794,40 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
+
+static int cxl_einj_inject(void *data, u64 type)
+{
+	struct cxl_dport *dport = data;
+
+	if (dport->rch)
+		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
+
+	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
+			 "0x%llx\n");
+
+static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
+{
+	struct dentry *dir;
+
+	if (!einj_cxl_is_initialized())
+		return;
+
+	/*
+	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
+	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
+	 */
+	if (!dport->rch && !dev_is_pci(dport->dport_dev))
+		return;
+
+	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
+
+	debugfs_create_file("einj_inject", 0200, dir, dport,
+			    &cxl_einj_inject_fops);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -1149,6 +1184,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (dev_is_pci(dport_dev))
 		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
+	cxl_debugfs_create_dport_dir(dport);
+
 	return dport;
 }
 
@@ -2221,6 +2258,11 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
+	if (einj_cxl_is_initialized()) {
+		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
+				    &einj_cxl_available_error_type_fops);
+	}
+
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
-- 
2.34.1

