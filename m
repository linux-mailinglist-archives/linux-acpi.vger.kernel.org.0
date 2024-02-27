Return-Path: <linux-acpi+bounces-3986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E586A0AF
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 21:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6761C238D8
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3306B14A0A2;
	Tue, 27 Feb 2024 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZslqUW9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640C4D5A2;
	Tue, 27 Feb 2024 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064877; cv=fail; b=rXsfQVecONM8rAQ0L0moUCMmBgKOwOIzY0VuwdmJ+5Rn65fiVJUO12TARflQ3x0PNVQy2WL/OYmTvg3zrxu69aGpVcMaWXGGqk4ya7F5oojd97firNQNKzeEY94AFO8ztM1elk0cqkzLOmlchaqjJlC7r8TwX2kixW9Y1elDvMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064877; c=relaxed/simple;
	bh=Bn7Vubg6O13L5sTue4GbQyD2ABxiRndEUslbpeXIius=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XL8iys9YG08ZpW21lJlQfvEH7Mr6pAwqofx0/c7w/jNFCpfzHZ/Tvr0Mt8HIry/sDk9ISuHu2bLqfBhaj6acq8iqe/nPI8VQfUh2m5MJDU5WAGcgJYlNlqPTPiMLuHsYcu+tRdtdRBTaEnA2BAZ6IVi1yRg5L0yIXxuiaED3ozA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HZslqUW9; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRnX2qCFJA8FmVx2ka/tg4UbX6eDwHNL7QZZRNciT3JDheZbVnbz5dvJJvDZySVwsvLWu+tUeY3uG6FUSJx8mGvKjpRTLDbaxWVM3rbs98muucjt59RnpsjI/r7L2yrjuog7SBVoX2QVVr8oJO74pWaFpeuk+TkYPj6v+/HM5Jq8MfTf+mCRZbV5HP9a3+drnHAOX5U6xNuPQLzYeOkt685+SL1beKZvg8crMvKYxpUuZy0S1cciJKks3zOOCSv/BsLdUNnsPbmYp8dZqTwDCv/b2prEaTnSq7FJwbu8pW3uip8uzIRtlyiWACP0nFZGRE1RN+Q5CfsEe8ZEIZKs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsN3kSBvAIL4I+FwxFWZF7RvH3bk6sg6aMNTDjr0qeM=;
 b=kPUj9hmqe0lST8dX0WrVMJgtCzlEbF2814obGBWpZ+JPaPOxDwC3xDKIvQoxeKrO8IoiWzubuF+YvioRLMrg9oWHMZMgIorEAHL3mrRdKnniBNLl7bgJr/rewII2oHUkXAcvPL3g63fKHg1Y41K3zrvVi9KUd20bltTeTuUg9tb+CIv8ITZiwcTeo4DSUSRSXhWRVm3Zl37OYBci3M6BGainbtuYvWTOW+C9/sB1L/kdyHzrhoQs8pbjOPVF2Vf95QU/9/OF3ItBSRB7X2y83/LYJE7G10RAo/B04K0IuYUu74QhUN/IZJBk/vx29w40b8Bla2q8zAO77m/ZEUeRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsN3kSBvAIL4I+FwxFWZF7RvH3bk6sg6aMNTDjr0qeM=;
 b=HZslqUW9Cjd6l2MRQYAIxbNXM1V1cAjhgkU4XhDUZPIupL/YolTOJdellJGvywNyWl7vbsd1Dgh72jB3EseUImJxwDQIAhuD2KZeGhZpLJgfpQFfolJFpgKWaJdwHOL42fUlO+a5WO+Q+F8OEp4pIsmVQoAbxhWmjhOdF66ciOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Tue, 27 Feb
 2024 20:14:32 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 20:14:32 +0000
Message-ID: <1e7673e9-8e30-4d66-a86c-bb768cb69f9d@amd.com>
Date: Tue, 27 Feb 2024 14:14:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Content-Language: en-US
To: dan.j.williams@intel.com, jonathan.cameron@huawei.com, rafael@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03123d42-086c-4149-1843-08dc37d0b5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	op/9uA0GUHyBNLc3hnPzbkA9zs8nAuwAWq0Xi8QjUrp0GrRzvFAwbKMGSlaqlYobWX1RzklCTJU9AyzwciAtmwF+45/KwKg1lAET9plBZQH6e68IG8FYBRnZaaLZsqKfOXujWJkQ029x6ncF/avPDQtu74yOCK1xs3qyIIxUY26XvZAp9kCQq9Zld6hrWGdY3qe+vAm0+ooD2CCqwWYoMSeV+oHFzp6AuN5PEeFJ+wfLehvJKD7LzzTHNukXcETxw48SsJr5q1GoR5mDGuy2nUiyIlkfDMy0jaNJpNcc+RQDQX16ti3ALak3GGd7DRaP8PI1vY4k66t4UPe6nDWITF5ZdiRI/wA4QUDwuPdpTJEvUhqj1V7oAKD3fEeyp1HyR9/cOs/DNilM7wvpQB7R/2yV3MrFDD9LNR/KlyKeGD7ymh3nYNUr9xIU9kLatj2b06Zme68ZKJu+aON8XmQpgdFC8XbRY3/3+nL16sFdiut80z3hJ6/b2WbCyExUPDYJ11BTZVZapFJA1W1S73+a6fgI7jZkcf1tuIZak/IQoQtiuLRoKdJtese2bkPIoAg1XV6neQIWQWcLBWoMhxGBCpM8M1lu4wMdHefWKObgPmlL6Vmd3ddUxVrRgV8UShZ8M8ASNekjeE7r66aGlN5WNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk1JeHZmMTNGZ0U0Mmw2a0tLWE1pQWVOclhoWmMyY1FIZXEwU01yeGx2YWc1?=
 =?utf-8?B?R0c5QUd2cWtFa0VaUDQ5WUdFVCt1MnZjQkhvT28zejBwak9MU1lpbGxFK3JV?=
 =?utf-8?B?U3d0aWQ0a1NiWmpDa0tuVlJHMmFpSU83Y3c1S2g5Ujh3NEJ2a2UrMVlNR1dD?=
 =?utf-8?B?ckE5OEhyZ0lvbWNtR2RqUHplSzhGSnhTQXZVQUt0cUFXOS9HT1BRSVpZRlUw?=
 =?utf-8?B?V0FZWWNNWkp5RE82OWdvZ1lpdWhtNVJUSmhLK0dXTXRIYlZsWDB0ZWkvVXJX?=
 =?utf-8?B?OUQ3V0tFSnl5WGJ0c0s0cnZxNmtTakozWHhjSTBDNyticFFPT2tha1pKTHdW?=
 =?utf-8?B?SDlQSlE4bnVwOUJzZTlZNkw5eFNqbFlCWWhES2Z5U3c3dDNuS1RkbnM0dXpY?=
 =?utf-8?B?RVlyWFdMRFFVQ1FnYkhhNFZvZFRjRVB6bmxxTUZZaitHVzlnRXpuS3BQejlI?=
 =?utf-8?B?WXdWQzNhNXpNK3VMUjVkNjh1R2hWQk00akJmR1dXQkY1RVhRd09KREFZaGJX?=
 =?utf-8?B?SGI1a2VUL1dMOGE3SHRMR3p3UENYMnRRZVV2ZHppUmZjYzlKTThneU1KR0dn?=
 =?utf-8?B?RWhLMXh4SVcrYTNmbFcrdmFNbEt0aVRoRitjZ1lDaWE5YmtxaWRxUEIzY29B?=
 =?utf-8?B?S2ZWMEl5MzFXT3kzUGRPYmp1WTRpanMxRzczTjRacXhJandXbkQ4OG9qM2Ux?=
 =?utf-8?B?cXZYOE5oUEphYWJGTXNVQW9LTWhkd0o4UFpGdmZEQURRY2VkUGNkaGNLRUVt?=
 =?utf-8?B?YzZmM3dPcDVmcm1OM0NLQlVlMzd3Y2NBWVNGbFdWSWRIUHJzdC9NNW42WHg4?=
 =?utf-8?B?OXloR1VId3RaZVVoUGhuQndOZ0JkVEFUYzd0L3p0TDc4YXFGYUUvMWRIbWV0?=
 =?utf-8?B?NUM3RS9zNlFqNGlZa1BZQ3R4REtTTU16dmZ6M3c3ODlsSXlnalhJN2syWHhi?=
 =?utf-8?B?OEtFbGlGdm5WdExlck5XaUQrYnd6VGx5VVlkRWFLeVV0NUdIT1dka0VBYlNL?=
 =?utf-8?B?b2VCZ2NaRkR0OTltTlRpVGhySzlEcmRvZ2R3K05EVUhmUWlMSVl4MEZPYnVG?=
 =?utf-8?B?N3JWNjU0Sm5yYmdOWHJDcko4V0NVKy9mb0FHMFhrZUxhY29vWTlUOEszSmxk?=
 =?utf-8?B?cVk0c21KaFEvRlBuR1RYQkNpWUk4N042MXFXa1g2NDBBMHlXMDZEc2p5WXgy?=
 =?utf-8?B?aVE3aU1NY0ZTcnhkdEduRTAxaTFubFJ1TVdEQks1ZFIzaFMrWUovV0hJQStG?=
 =?utf-8?B?cFMyR3JkOHJrQytKbWcrSTgyKzdRZHIzNGc1REVwbUhqYnk1RXlyd2ExTFFC?=
 =?utf-8?B?U0ZSdzd4VzVBblAwenFjdEZtdXVqcVN6ZTFZYk5temo2bHZWMW9RengwTWpl?=
 =?utf-8?B?cncxeFBTeDMwcU56Qmw3aHpmU2tKK3JyRlF5Ukd4Yng3M2xLRE1McHFrNGYw?=
 =?utf-8?B?NktoOHJSM056UVlrSElFOUV0ME9UVWNvK2xMWHJNY2hXeU5xNGhxaituaEsy?=
 =?utf-8?B?eFlHUHJvQVNLcnNReVl6UkN4VFZLaHNCTFkwV1d5UGZBczRpT1ltTTVPQjJJ?=
 =?utf-8?B?YVBTM2ZEYW05L0ZVYWJaYmdEcVdyeGloTjY4KzdDc1JmTTRtM1g3TGxybTBp?=
 =?utf-8?B?ZHd1cG1nNWI5NUtGZU5sMFJaNXZUU096MXUxY1hGMjg3SDFrSXgyUXpMWnBZ?=
 =?utf-8?B?OFhjK0pkNEtLZ3lDdlRBTFJTNlU1VDJCcmlZREYwV1JaMFdUbGRnWCtsMk5B?=
 =?utf-8?B?WWV1a0QvWU9oa3lJNzg3aWxhdFRWVEFXYWZnTGNrRkZNa3hDRmZFbUtRNjVj?=
 =?utf-8?B?cVdzTDB5Y2EvdDhKVXNvZkg0VkZva2ZzOFFoUUNLY2JRL2F3S0FxRDVXZUhW?=
 =?utf-8?B?SXZINy9wT2l0N2o2TjF4OGhrREh1WG5UVC96d0ZaYXJKMW5DVUp1TjV2VTJs?=
 =?utf-8?B?WG1EYUNDYzdtWEloajl4c3FRKzlueU14MWtJNmU1MjkvWXlIZFluSUNxdHFi?=
 =?utf-8?B?dlhSczk0cWJ4R1QzaGJMaWFCZVZIbVBMQ0VtUkdiajVSZWpCZHg0RG40Mit1?=
 =?utf-8?B?alJOQTVuenBnSldkZkJWejVJM002b0pFOFJSbUk4RnpiMUxlbldqQTNjU3dJ?=
 =?utf-8?Q?wt+wLQzTSjMLUUeiamwq5dZed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03123d42-086c-4149-1843-08dc37d0b5c2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:14:32.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT9LlmQBaPmBktcimHd1OOq8CY/Lk0TVE85aDlFftqWbd0zhfc7l26U6QVsMVdbWr2zYr1Nvt8qVRouiwOD7Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

This patch had an outdated commit message, so here's the patch with an updated description.

I also realized that I was wrong about letting CXL 2.0+ error types (discussed a revision
or two ago) and I wasn't actually letting them through. I've went ahead and added
the ability to inject CXL 2.0+ error through the legacy interface. This pretty
much amounts to returning an error for CXL 1.0/1.1 injection types in einj_error_inject()
and instead routing them through a new einj_cxl_rch_error_inject() function called
in einj-cxl.c

If this change is too big I can send in another revision, I just wanted to avoid
spamming the list(s).

From eea1cf991dc2a551f6db2e3bb9510ed43c86762d Mon Sep 17 00:00:00 2001
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
Date: Fri, 16 Feb 2024 11:12:51 -0600
Subject: [PATCH v14 2/4] EINJ: Add CXL error type support

Move CXL protocol error types from einj.c (now einj-core.c) to einj-cxl.c.
einj-cxl.c implements the necessary handling for CXL protocol error
injection and exposes an API for the CXL core to use said functionality,
while also allowing the EINJ module to be built without CXL support.
Because CXL error types targeting CXL 1.0/1.1 ports require special
handling, only allow them to be injected through the new cxl debugfs
interface (next commit) and return an error when attempting to inject
through the legacy interface.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 MAINTAINERS                               |   1 +
 drivers/acpi/apei/Kconfig                 |  12 +++
 drivers/acpi/apei/Makefile                |   2 +
 drivers/acpi/apei/apei-internal.h         |  18 ++++
 drivers/acpi/apei/{einj.c => einj-core.c} |  85 +++++++++++----
 drivers/acpi/apei/einj-cxl.c              | 121 ++++++++++++++++++++++
 include/linux/einj-cxl.h                  |  40 +++++++
 7 files changed, 257 insertions(+), 22 deletions(-)
 rename drivers/acpi/apei/{einj.c => einj-core.c} (94%)
 create mode 100644 drivers/acpi/apei/einj-cxl.c
 create mode 100644 include/linux/einj-cxl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..90cf8403dd17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/
+F:	include/linux/cxl-einj.h
 F:	include/linux/cxl-event.h
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..f01afa2805be 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
 	  mainly used for debugging and testing the other parts of
 	  APEI and some other RAS features.
 
+config ACPI_APEI_EINJ_CXL
+	bool "CXL Error INJection Support"
+	default ACPI_APEI_EINJ
+	depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
+	help
+	  Support for CXL protocol Error INJection through debugfs/cxl.
+	  Availability and which errors are supported is dependent on
+	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
+	  EINJ documentation for more information.
+
+	  If unsure say 'n'
+
 config ACPI_APEI_ERST_DEBUG
 	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
 	depends on ACPI_APEI
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 4dfac2128737..2c474e6477e1 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -2,6 +2,8 @@
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
+einj-y				:= einj-core.o
+einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 67c2c3b959e1..cd2766c69d78 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -130,4 +130,22 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 }
 
 int apei_osc_setup(void);
+
+int einj_get_available_error_type(u32 *type);
+int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
+		      u64 param4);
+int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
+			      u64 param3, u64 param4);
+bool einj_is_cxl_error_type(u64 type);
+int einj_validate_error_type(u64 type);
+
+#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
+#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
+#endif
+
 #endif
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
similarity index 94%
rename from drivers/acpi/apei/einj.c
rename to drivers/acpi/apei/einj-core.c
index 937c69844dac..437c13949be7 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -37,6 +37,12 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_FATAL | \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -141,7 +147,7 @@ static DEFINE_MUTEX(einj_mutex);
 /*
  * Exported APIs use this flag to exit early if einj_probe() failed.
  */
-static bool einj_initialized __ro_after_init;
+bool einj_initialized __ro_after_init;
 
 static void *einj_param;
 
@@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-static int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type)
 {
 	int rc;
 
@@ -536,8 +542,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 }
 
 /* Inject the specified hardware error */
-static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
-			     u64 param3, u64 param4)
+int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
+		      u64 param4)
 {
 	int rc;
 	u64 base_addr, size;
@@ -560,8 +566,18 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	}
+
+	/*
+	 * Injections targeting a CXL 1.0/1.1 port have to be injected
+	 * from the CXL debugfs interface so that we can guarantee a
+	 * correct MMIO address.
+	 */
+	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
+		return -EINVAL;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -593,6 +609,21 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	return rc;
 }
 
+int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
+			      u64 param3, u64 param4)
+{
+	int rc;
+
+	if (!(einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)))
+		return -EINVAL;
+
+	mutex_lock(&einj_mutex);
+	rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
+	mutex_unlock(&einj_mutex);
+
+	return rc;
+}
+
 static u32 error_type;
 static u32 error_flags;
 static u64 error_param1;
@@ -613,12 +644,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(9), "Platform Correctable" },
 	{ BIT(10), "Platform Uncorrectable non-fatal" },
 	{ BIT(11), "Platform Uncorrectable fatal"},
-	{ BIT(12), "CXL.cache Protocol Correctable" },
-	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
-	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
-	{ BIT(15), "CXL.mem Protocol Correctable" },
-	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
-	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
 	{ BIT(31), "Vendor Defined Error Types" },
 };
 
@@ -640,29 +665,26 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
+bool einj_is_cxl_error_type(u64 type)
 {
-	*val = error_type;
-
-	return 0;
+	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
 }
 
-static int error_type_set(void *data, u64 val)
+int einj_validate_error_type(u64 type)
 {
+	u32 tval, vendor, available_error_type = 0;
 	int rc;
-	u32 available_error_type = 0;
-	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
-	if (val & GENMASK_ULL(63, 32))
+	if (type & GENMASK_ULL(63, 32))
 		return -EINVAL;
 
 	/*
 	 * Vendor defined types have 0x80000000 bit set, and
 	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
 	 */
-	vendor = val & ACPI5_VENDOR_BIT;
-	tval = val & 0x7fffffff;
+	vendor = type & ACPI5_VENDOR_BIT;
+	tval = type & GENMASK(30, 0);
 
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
@@ -671,9 +693,28 @@ static int error_type_set(void *data, u64 val)
 		rc = einj_get_available_error_type(&available_error_type);
 		if (rc)
 			return rc;
-		if (!(val & available_error_type))
+		if (!(type & available_error_type))
 			return -EINVAL;
 	}
+
+	return 0;
+}
+
+static int error_type_get(void *data, u64 *val)
+{
+	*val = error_type;
+
+	return 0;
+}
+
+static int error_type_set(void *data, u64 val)
+{
+	int rc;
+
+	rc = einj_validate_error_type(val);
+	if (rc)
+		return rc;
+
 	error_type = val;
 
 	return 0;
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
new file mode 100644
index 000000000000..9d79c48b2dce
--- /dev/null
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CXL Error INJection support. Used by CXL core to inject
+ * protocol errors into CXL ports.
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Ben Cheatham <benjamin.cheatham@amd.com>
+ */
+#include <linux/einj-cxl.h>
+#include <linux/debugfs.h>
+
+#include "apei-internal.h"
+
+/* Defined in einj-core.c */
+extern bool einj_initialized;
+
+static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
+	{ BIT(12), "CXL.cache Protocol Correctable" },
+	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
+	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
+	{ BIT(15), "CXL.mem Protocol Correctable" },
+	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
+	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
+};
+
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
+{
+	int cxl_err, rc;
+	u32 available_error_type = 0;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
+	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
+		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
+
+		if (available_error_type & cxl_err)
+			seq_printf(m, "0x%08x\t%s\n",
+				   einj_cxl_error_type_string[pos].mask,
+				   einj_cxl_error_type_string[pos].str);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
+
+static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
+{
+	struct pci_bus *pbus;
+	struct pci_host_bridge *bridge;
+	u64 seg = 0, bus;
+
+	pbus = dport_dev->bus;
+	bridge = pci_find_host_bridge(pbus);
+
+	if (!bridge)
+		return -ENODEV;
+
+	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
+		seg = bridge->domain_nr;
+
+	bus = pbus->number;
+	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
+
+	return 0;
+}
+
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	int rc;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (!einj_is_cxl_error_type(type))
+		return -EINVAL;
+
+	rc = einj_validate_error_type(type);
+	if (rc)
+		return rc;
+
+	return einj_cxl_rch_error_inject(type, 0x2, rcrb, GENMASK_ULL(63, 0),
+					 0, 0);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
+
+int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
+{
+	u64 param4 = 0;
+	int rc;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (!einj_is_cxl_error_type(type))
+		return -EINVAL;
+
+	rc = einj_validate_error_type(type);
+	if (rc)
+		return rc;
+
+	rc = cxl_dport_get_sbdf(dport, &param4);
+	if (rc)
+		return rc;
+
+	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
+
+bool einj_cxl_is_initialized(void)
+{
+	return einj_initialized;
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, CXL);
diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
new file mode 100644
index 000000000000..4a1f4600539a
--- /dev/null
+++ b/include/linux/einj-cxl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CXL protocol Error INJection support.
+ *
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Ben Cheatham <benjamin.cheatham@amd.com>
+ */
+#ifndef EINJ_CXL_H
+#define EINJ_CXL_H
+
+#include <linux/pci.h>
+
+#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL)
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
+int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
+bool einj_cxl_is_initialized(void);
+#else /* !IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL) */
+static inline int einj_cxl_available_error_type_show(struct seq_file *m,
+						     void *v)
+{
+	return -ENXIO;
+}
+
+static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
+{
+	return -ENXIO;
+}
+
+static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	return -ENXIO;
+}
+
+static inline bool einj_cxl_is_initialized(void) { return false; }
+#endif /* CONFIG_ACPI_APEI_EINJ_CXL */
+
+#endif /* EINJ_CXL_H */
-- 
2.34.1


