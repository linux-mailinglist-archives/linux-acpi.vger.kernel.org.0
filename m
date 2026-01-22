Return-Path: <linux-acpi+bounces-20539-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KByjJ1kScmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20539-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:04:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF166601
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556048E3714
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DEA3ACEE2;
	Thu, 22 Jan 2026 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o35bw4W6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o35bw4W6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF5352955;
	Thu, 22 Jan 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081891; cv=fail; b=FE2v+ceuHrNu2DrJEnc/LuGPxJxuA1VKUJtKSjTrp0v23QOCRP6MuMB5h4cMNfxP6LkR1wHQi613qnoFpWLIE1SxF/QHizj9IxK8nBHKso1pi3kg+uCgJxrDGlHoQFNMSm2iVqSHk771aJMvlToY+bZqnCEMHaQ0BC/osHIaOjI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081891; c=relaxed/simple;
	bh=o6gTsAQvizdIZ7aMX2pXMe5Ohl7UMhYQDjZLrP4HZj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/lfwzyprFjCppnUv81bshqP38GdQ0grv0DK1i6iSzq97gUvdCvMTDn70Q2ZuLGblBo4Uvpgv8MWskM4m6vtIlv/gEHe/A/8rws9Kj1LT75K4KAQ/R0DrONxl3+aZXHjGTjt6/gUvbrbIy+k2r02XM4tGjcNvXvnbd1SQjASOPM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o35bw4W6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o35bw4W6; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lhgCtLNPidwS5USnKXCwFPdZqdHMus8TrDJ11I/rek5OPOieLELD19syI587BUYwSPz+GZuFKSdzb+FNv0lW4zvpYoEPmhB+7/YHTgNJ2XKkLnwJm/wAEGilOjVQA2tpcZx6RJFH+18b+mLqI4EkWhYhobONg+Y+JbXyc1u5Au6CN8Gecl4fZhi3N4QVQc0YnjMO3//9OLn8OsQwmGhTDmqiIT2TwKO/iKKJl7Oq1PyzZrvcn94zrEhWs2lukYLRFuu6S/41Aw8wkUyP/YlTTwhoZXbhi93P78OOuLzmHLnusMpxA33GveqPzgiOtqOLSe5sD+JkARbTa5CX5R/u0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u/fN3QV8o565cePKNTVgMoW96GsoEv654q2/vlunNw=;
 b=phr+b6cW08Ye8+GnNAcEa83kPWSMMuAfjc/3kUJknV3pL3KAaS6VWeTK1scUe9WUZ0cZJ5LJgyXizTvnse4FFKjrUdZn3FwDxuSKuxILn1+bjR7JJanii6YXAOfLjWJ7MRwYgXXNvw8xJ6fmF/DQKlw1cPRmATfqZ3gDP8Y3cAXQMKetEdDzAi7gv+FjN2ojEgYhA/QFSd6/ueXuDgUggi5GtSLoyIA4zGXGJzCwZuA3GtD0mgIIofZ/xxH1EiA2bz77Js6wFNXbnHmwWvDmhzvU2ARabhRxDwBq/D21uWTrx4gtEepNGTortoifGDqrbDpUxK/AW3fuL8sgd/1O6A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u/fN3QV8o565cePKNTVgMoW96GsoEv654q2/vlunNw=;
 b=o35bw4W6gcw18FYEr/vF4MZP9bxcE8mqlHkxufcd7ER3Dk9IuBcPmlAJwGh0+Omsm6WyWcGRH82yn5AOe2PHSByTAPvNcEW/qNx4sL14M2myC6w604ayNKTbamzk8ZPQwzdCajS5qKV4GsCZejr1awFnJGwem5Shon92GYA9gYI=
Received: from DU7P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::15)
 by GV1PR08MB11091.eurprd08.prod.outlook.com (2603:10a6:150:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:38:01 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::c) by DU7P195CA0001.outlook.office365.com
 (2603:10a6:10:54d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 11:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Thu, 22 Jan 2026 11:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD15ow8kC/B+9FE5w5uIfeALySnoiWl9Yv6SQgQRAhb1imaiX6AHmPrSBc3KzNtD6eUhmGHjx8ZyPEoAS94l2mFrBYhvAofb8pFbWmt0V9C5f4+gBPnL41gJ9O3BvAm2zNuOaQ1iup/m6uDICihDxtJpMxcLJZkIRgAx7ZHi37frYA5Rv6nJ7MAe/8pbUYJqY3plyyCUmoi30nWvdAXF1B1b/xsK8uMjkXzC6Mb5STHjRoQAptRAR9F/XDuNPhu9L1pZ7cElUpcO3zs30F6ieeEtRv64xGovclqlaL6hkWA9yrdaau9LeaoyAB7kdYvSKSd5icte2TDGTHHnANic4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u/fN3QV8o565cePKNTVgMoW96GsoEv654q2/vlunNw=;
 b=GzpAvxEMVyOvp4/eqPvYG0CHhGz5d/9fDDxkOhMrQtOOin1eGJ4kygytZjxC5DGplsbDAYlrEPWlSf7WPUd9gXSKWuOR3izd+7cQnBK2OLMnAeA1fyvronc5FnMIen7HFv03JJCLuUv4kM9IS90POR8pkxAjBHPJwwe7Ivd5XFeJLbbBLJdaeWJ2SomPkuwcmAOqrNG4wwrORN2wl9sK+wAmvgJieOV+vnBlph95VQJ+w7yxDtnDiGgozwPlxUj53Tnqgt5tVKkjuwtt+d0epOUm4YnUhE9t0NilTlWoPSHgLrsVTIl05PMPVmb5YzajTbYG66MBydmLs0hWbVn67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u/fN3QV8o565cePKNTVgMoW96GsoEv654q2/vlunNw=;
 b=o35bw4W6gcw18FYEr/vF4MZP9bxcE8mqlHkxufcd7ER3Dk9IuBcPmlAJwGh0+Omsm6WyWcGRH82yn5AOe2PHSByTAPvNcEW/qNx4sL14M2myC6w604ayNKTbamzk8ZPQwzdCajS5qKV4GsCZejr1awFnJGwem5Shon92GYA9gYI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VI0PR08MB11842.eurprd08.prod.outlook.com (2603:10a6:800:316::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:36:57 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:36:57 +0000
Message-ID: <b68a4273-ad39-4d3e-a556-1b409b50944d@arm.com>
Date: Thu, 22 Jan 2026 12:36:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
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
 <20260120145623.2959636-7-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260120145623.2959636-7-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0484.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::24) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VI0PR08MB11842:EE_|DB1PEPF00039233:EE_|GV1PR08MB11091:EE_
X-MS-Office365-Filtering-Correlation-Id: 17584761-bffd-4157-cedc-08de59aab292
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eCtDZ0VLb2N1Vi93dE15ZWhSaGUzSFJvMjN1R3BpaGRweXlPaUlCL2IvbE9j?=
 =?utf-8?B?ZjJpYjYvTml6K0I4VnVLV253cmIzZVJkZFVvbGd2RkZlS0l0ZE15aFBuMnJx?=
 =?utf-8?B?U2tvTW84SUM5dkFXdUpRNnFJVHBicFhOV25aU082YURNYzk2ZFhzbDBJYWpU?=
 =?utf-8?B?eFI5aW9MeGVzMzl4bmJQMStwK24xcEQxNC84bkNGTXJoZXlGR05jZlkrbkFj?=
 =?utf-8?B?TzlJcG91ZENhRVpDcXYyUGJuV0tXS2YrY1ZjSW5VN243UFhWZzBjTEp0NVBY?=
 =?utf-8?B?ZXJLdWNRR3l5ZklJUVdTdnQ4TXd2aFJXaGc0UE1HYzBnYVNvQ1B4eTBrT2JD?=
 =?utf-8?B?Vm10WW5OeUdJRjVzVzU4b3l5OUt2a0crU093QTg1RHdwdlpWeVFVa3p0SWVa?=
 =?utf-8?B?QnNxZUNTUHlqLzFxNHZnSFBsSVgrTTVTZ0hVbm1LNHBIL1RucXQrOWlLRyta?=
 =?utf-8?B?VUtsSmFRSmsrT3g4Y2dTZEZLb0RKUmViVFlkMG13UE80eXNtRFE2eXh5cmx5?=
 =?utf-8?B?cVNMSThqQTNOaWQybXhRRjRTQjlIVEpDSmViZHRqOHJxUkZuUHdBbW9mKzZW?=
 =?utf-8?B?OUdSV056MEh1dkdMVDJDQW1ZM3ZTNEIvZXNOTjhIeGhpSVJEanU0QVRSQTBj?=
 =?utf-8?B?TlkvMHJvWVdWdndDOGdkYlhIYkdBQjF4TU4rZ1BmVVpzdVpFVXBkanlxbGZr?=
 =?utf-8?B?RHJkRDZJWlloeWZQL2RhY2dyTjlNQzcwdVNQVUVXSlhMMVpTVTdLODUrSEVB?=
 =?utf-8?B?TjZ2WGdLRXFGOEpQeEExREpZa2x5TndUTzFNUUplREljblJkMjhVT0NYK0ZT?=
 =?utf-8?B?RmsrNWROZjQ0cC92TGJCKy9LemNPZ1VkQkFBMzlyYkZRT3YvUEpUdFl4MzJz?=
 =?utf-8?B?U3c4UmVoMzhzZ1ZvQXZ6MzYreXk1Z2lhbTlTcW9qQ0FRZkFSYnlUeU04ZWgx?=
 =?utf-8?B?YXR6TWRVdGprRFdmb0dFZnpYZE5OZWlUc1p4T1dvb2o3cDczTGh4MTdCbytt?=
 =?utf-8?B?bWJhV3FjZXo1RmY4NWZQaGxESmFJY2lrVWJHMSsyTHJVTE9JaU9ITGM1NFVa?=
 =?utf-8?B?eGhnbklYc2FZUDJaSFFJb2JQR21TN2VpbEFDbnpGNm1GVVJsWU1ZTTFLOVRN?=
 =?utf-8?B?bml5cTBhSDZYelBMWnREeVN1Tmk5NGloZy9id01yY2t5QVlkSmcxek9FT21p?=
 =?utf-8?B?OFdBQThrL05vcHpwOGJuOFFXSlBZWmFvQ1lLYWpwdWJEREZkc0Uvek0rQTBL?=
 =?utf-8?B?Q2E1eUVUM3Bmd21qOFgvSmJ6L09oTUZQNEpIRHJvZ0pxcTJsN3AvbG9OWHNO?=
 =?utf-8?B?NlBGTmlsSkxTN2szQTZDNFA3cDFvZUlPZU5BeklIanVXT0FheUtzMWVFNGkv?=
 =?utf-8?B?a1ZKd3JXazluYjRvdDY2YzR0d1NQT0NNdzB5SVVJNnd6bklvdDMyZ3pPMXV5?=
 =?utf-8?B?ODhOYnpjZ2tFWnRWeURnTHc0K2kxZTFveUZPaGxDamFaTy9ZVis3dmFZNXJ6?=
 =?utf-8?B?b2NLS05RcVpXUGk5czhDTmdmc1hDS283VU1MaXFRNW9oOW9UT1VMVVpZWW16?=
 =?utf-8?B?RFpNYkpURkl6T2FwNkhyamlIejFPRkIrM015OUFPclB1bWZSVEl0Zmp3bDhS?=
 =?utf-8?B?TVdBT3RUTnVxdzBZS09sSk4vNVJSMFpHNXY1c3BEeFAxSlJqeDUwY2o3bmpQ?=
 =?utf-8?B?MkJFa1R5R0dxQlRvM2tzL3VSRVFBb0dmT2N2ZU9qSjJydW1OYjVMQ1RwSVhB?=
 =?utf-8?B?ZjB6cnUvaHhsRG1PWlo0Z3BXYVNsU2dYK3VjbW5SWSt3ejFJNGFaRUk2WXo5?=
 =?utf-8?B?WlU4SkY5NjZwQ05sTDhFdUNLN1FaYjlOd1ZQWTVQTkdxNUMvTmtlT2F2d1ZK?=
 =?utf-8?B?RHhnT2xaNW5TT1ZPTk5nOEZMVnFJUFRjUnZXZ2tlVXpybm1vMU1iamFZVUVi?=
 =?utf-8?B?azF6N2czOHkwVExaZm9hTGtLdVF2RW5RWjdwenI4NGluejN0R3E4K2dUKzFY?=
 =?utf-8?B?aGd4QzV6aGFpa1JvcUhpcXhPYUx1dDhJUjVhSDRZZ2ZFazdzNFN2Sk9QOFZD?=
 =?utf-8?B?OTZza2MxUCt2MUF4VmVQTWlBcjhuRDZJYVNac3lHRWpHNjFIVlV5REZZS3FZ?=
 =?utf-8?B?MThTcXQybFJEcC9BNXdScmdVZVdDQ05oRVlFcWc1czhUQzYveXhkVFU4bUIz?=
 =?utf-8?B?c2c9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11842
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9544a434-137e-423d-c6a0-08de59aa8c83
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|14060799003|35042699022|376014|1800799024|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnRwdDdPUUxtWFlFVkVSZkNQZ0RMWGdFK0lGbVNkTGpDV3ZRc0VGWGRvb3lv?=
 =?utf-8?B?YjZDMWVxODBDYzB3clAvMXFidHFPbDgvL0UrTGZXOGJVNEc1aGR1KzUzaGtL?=
 =?utf-8?B?N1BCQWdsREt0T1d3am5VdkcyTlpSSDc1UEpJVWdCV3BSMm9WYmZwdEs0NWxk?=
 =?utf-8?B?RDZZaTFZdzRxdFlIQzdLVnAwQzV1MDNiQXBxS2N1WEpMajdMMTU4eGZ3ZFcw?=
 =?utf-8?B?UFlwRTNYZDY3WFpEZDVBVjlGaURmUGt3aU1jSUhrdE1TMVJHSnJnbE9zTXRm?=
 =?utf-8?B?elN2TnNrbm02YktLci9Ja1gzNFdjclhydVZpeVF0ellCTzBXQ1lBdEF2c0F2?=
 =?utf-8?B?U3hMUk9LdTk0YWZNL21ZS3puSWxHbWVnWDNXNUcwUUhqbnJpcTZZdXgyZyti?=
 =?utf-8?B?ek1Mc29iVm9jZUFuTEJFdTlzMTYySjVtK2tQNEcyd0hDZ0NJVFFOVUVreWxp?=
 =?utf-8?B?UnJsU05uSFRDMjB2cWQzcjlCZlVVbHp3cmRtZ2IvZ21tTkJMOCtiWTlNNXU1?=
 =?utf-8?B?cGFxaHdwNWVKYWU5S0tUNytDVW55TXg4eGgvV2s2U3UwV2Rib2FuVkNabndQ?=
 =?utf-8?B?QkFMWEt5ME9FRWczZzU3MnVZYzlZbE9LR296WXpPM3lmN29aTU4yb092Z0Q2?=
 =?utf-8?B?MElwK041QTlnOEwwU1FNVHBqb09GYlh6SXVaOXU1cTRNRGEwMG13a1ZweGFK?=
 =?utf-8?B?a1kwd3NBQ0E3eWViMSttRWZRcWczbGtrK29sRExVUHR6cTY2aW1xMWF4RGtK?=
 =?utf-8?B?amU5OXlkUFprMlc3Mi8xWU1IejVYSUh3R0pGTFE3REF6SnpUMjNsc2g4UDE0?=
 =?utf-8?B?cEJIK2xlK01qM0phNmp4UzVRTWZqbVBpUlBBODNjdGVla0ZHN3h1QW13dkxH?=
 =?utf-8?B?NmtzdHcvSnNGN3hJaUpWb25kbGUxUWM3NWIxelZTQlB0RjJ4VG1hK1RVK1hy?=
 =?utf-8?B?RzV0MGN4b0NVeFRQdmdzVnhHMm80aHdpT1Y0WmRiVVBzSnJqQmZ4SzRUMnZz?=
 =?utf-8?B?QzkvN3RWTUs1L1pLd09FYlhlbFJBMFJoazUvalZGYVJjdWFkbHZ4YlQ1NWov?=
 =?utf-8?B?WXhQQkFpOEFyeENIc2pDVlFMUVJBczNQajlGUkxOUlZQelAxeHhjZU55VC9I?=
 =?utf-8?B?aDI5VDNBWWtPSFlQd1pTYUZrcStNd0NhU3Q0MEo5QzBRZU82OEg1Z0w3dWxU?=
 =?utf-8?B?bHBnM3hsSWw5Q0F4OUVVOHQ3UUZNeTBDdmRxTUpHWm5VRUVucUszZnZjWVV6?=
 =?utf-8?B?WGcvV2UxOExjTmx4d0RuRDV4MXJPMHV3emU2alFYdjhjQmxtSlZ1aXZYWWp1?=
 =?utf-8?B?YnZkVmdqTEpZSVErVmJVWnJVVThBUXJKcTdkcThIa0EzREdrTHg4WFFKWEVu?=
 =?utf-8?B?VUV0ZlF2Z1o1eGlSS0FaZ1FSU3JJd0hkSVBrM3hPTXFxOHVmMnRNd005K2Vx?=
 =?utf-8?B?NDl0aW00OGRXaUNsKzVIRm5XRW0vaW5ISXVwRHNQMnVvcndLYlZIeGdqNENN?=
 =?utf-8?B?QWFIS1dIRmNMd1BzdWE1dnV3V3FkQW8vd2duNDNQTVFsYkg2MnRSL2hxalFX?=
 =?utf-8?B?cG9qc3p1UWRnRVIwcUVBMXRyek5laHNISFhkbHZ1b1BzOGVyc0xtZ1lNMW9q?=
 =?utf-8?B?Sk5rd3RmcGlZUEJISHI3eTROcU9YcWJMM3h5QitBNm1ySW5IMzBzYkRQUUlp?=
 =?utf-8?B?Unhrb1FGQ1I1a3YvSXhXNi94bURWdEZWU0plZlRkRnZMSTJGd1I2QndvZmxw?=
 =?utf-8?B?VFNlZzZ1bnVjTXhVYmtzVnkzK0VqaWdiN1FoUTloRGFMYVlBdlNQNFBwa1Nm?=
 =?utf-8?B?cjJVZWRNUUxIWGRQOFB4bEdyK2ErdU9kejBVeXZhVGpOdHo2YjVZa3lhMzRG?=
 =?utf-8?B?ajB5NWJMeWhLdlRXUlp6WUNmSGh3WGo2cHBFRlZGdnVZWm1wK3VJNDRVdFZZ?=
 =?utf-8?B?c0I2NzR6SU5tYVEySFJBVVlWdTZFV1ByeHF2QUNBMEd6V2tDZlV3ampKQlhF?=
 =?utf-8?B?bmhwUTJCKzFtV09oZFRzb1BUU2FUMFVBU2R6bkJhanBXUlQ0UnM0b3lLenVI?=
 =?utf-8?B?SHd6STJvejFGSVQ1OWxsQlZEK0c0d05veGJrQ0ZKZkRKY0QvRlRvVFB6L0NW?=
 =?utf-8?B?WDJtcjdzalowQ0ZtdzJSR2NmMjd4M2JDUzZzVjN4R2ZqNG9abUVjS2QydkVJ?=
 =?utf-8?B?ejJZTFYrQ0VLWUc3VWVvR3Z3MEIzbzZpdDkzYWI0K1YycklXZjBxK2R3cVJT?=
 =?utf-8?Q?epMQ4SUG2OrOlLp0VVfAK3+9AfclPoGvAVGofVC2c0=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(14060799003)(35042699022)(376014)(1800799024)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:38:00.7322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17584761-bffd-4157-cedc-08de59aab292
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20539-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[arm.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,arm.com:mid,arm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 35EF166601
X-Rspamd-Action: no action


On 1/20/26 15:56, Sumit Gupta wrote:
> Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
> write the MIN_PERF and MAX_PERF registers.
>
> Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
> to expose these controls to userspace. The sysfs values are in frequency
> (kHz) for consistency with other cpufreq sysfs files.
>
> A mutex is used to serialize sysfs store operations to ensure hardware
> register writes and perf_ctrls updates are atomic.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c       |  44 +++++++++
>   drivers/cpufreq/cppc_cpufreq.c | 157 +++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h       |  20 +++++
>   3 files changed, 221 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 45c6bd6ec24b..46bf45f8b0f3 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1743,6 +1743,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>   
> +/**
> + * cppc_get_min_perf - Read minimum performance register.
> + * @cpu: CPU from which to read register.
> + * @min_perf: Return address.
> + */
> +int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_min_perf);
> +
> +/**
> + * cppc_set_min_perf - Write minimum performance register.
> + * @cpu: CPU to which to write register.
> + * @min_perf: the desired minimum performance value to be updated.
> + */
> +int cppc_set_min_perf(int cpu, u32 min_perf)
> +{
> +	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_min_perf);
> +
> +/**
> + * cppc_get_max_perf - Read maximum performance register.
> + * @cpu: CPU from which to read register.
> + * @max_perf: Return address.
> + */
> +int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_max_perf);
> +
> +/**
> + * cppc_set_max_perf - Write maximum performance register.
> + * @cpu: CPU to which to write register.
> + * @max_perf: the desired maximum performance value to be updated.
> + */
> +int cppc_set_max_perf(int cpu, u32 max_perf)
> +{
> +	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_max_perf);
> +
>   /**
>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>    * Continuous Performance Control package EnableRegister field.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 229880c4eedb..66e183b45fb0 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,8 @@
>   
>   static struct cpufreq_driver cppc_cpufreq_driver;
>   
> +static DEFINE_MUTEX(cppc_cpufreq_autonomous_lock);
> +

Shouldn't concurrent access be handled by the policy->rwsem ?

I think this can be checked using either:
- lockdep_assert_held_write(&policy->rwsem)
- lockdep_assert_held_read(&policy->rwsem)

in store/show_max_perf() for instance.


>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>   static enum {
>   	FIE_UNSET = -1,
> @@ -570,6 +572,35 @@ static void populate_efficiency_class(void)
>   }
>   #endif
>   
> +/* Set min/max performance HW register and cache the value */
> +static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
> +				      u64 val, bool is_min)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	unsigned int cpu = policy->cpu;
> +	u32 perf;
> +	int ret;
> +
> +	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
> +
> +	ret = is_min ? cppc_set_min_perf(cpu, perf) :
> +		       cppc_set_max_perf(cpu, perf);
> +	if (ret) {
> +		if (ret != -EOPNOTSUPP)
> +			pr_warn("CPU%d: set %s_perf=%u failed (%d)\n",
> +				cpu, is_min ? "min" : "max", perf, ret);
> +		return ret;
> +	}
> +
> +	if (is_min)
> +		cpu_data->perf_ctrls.min_perf = perf;
> +	else
> +		cpu_data->perf_ctrls.max_perf = perf;
> +
> +	return 0;
> +}
> +
>   static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>   {
>   	struct cppc_cpudata *cpu_data;
> @@ -918,16 +949,142 @@ CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
>   CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
>   			 cppc_get_epp_perf, cppc_set_epp)
>   
> +/**
> + * show_min_perf - Show minimum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + *
> + * Reads the MIN_PERF register and converts the performance value to
> + * frequency (kHz).
> + */
> +static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_min_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Use lowest_perf if register is uninitialized (0) */
> +	if (perf == 0)
> +		perf = caps->lowest_perf;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
> +}
> +
> +/**
> + * store_min_perf - Set minimum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer containing the frequency value
> + * @count: size of @buf
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MIN_PERF register.
> + */
> +static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
> +			      size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +	u64 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert frequency (kHz) to performance value */
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +	guard(mutex)(&cppc_cpufreq_autonomous_lock);
> +	ret = cppc_cpufreq_set_mperf_reg(policy, perf, true);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +/**
> + * show_max_perf - Show maximum performance as frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer to write the frequency value to
> + *
> + * Reads the MAX_PERF register and converts the performance value to
> + * frequency (kHz).
> + */
> +static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_max_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	/* Use highest_perf if register is uninitialized or out of range */
> +	if (perf == 0 || perf > caps->highest_perf)
> +		perf = caps->highest_perf;
> +
> +	/* Convert performance to frequency (kHz) for user */
> +	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
> +}
> +
> +/**
> + * store_max_perf - Set maximum performance from frequency (kHz)
> + * @policy: cpufreq policy
> + * @buf: buffer containing the frequency value
> + * @count: size of @buf
> + *
> + * Converts the user-provided frequency (kHz) to a performance value
> + * and writes it to the MAX_PERF register.
> + */
> +static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
> +			      size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +	u64 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert frequency (kHz) to performance value */
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +
> +	guard(mutex)(&cppc_cpufreq_autonomous_lock);
> +	ret = cppc_cpufreq_set_mperf_reg(policy, perf, false);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
>   cpufreq_freq_attr_rw(auto_act_window);
>   cpufreq_freq_attr_rw(energy_performance_preference_val);
> +cpufreq_freq_attr_rw(min_perf);
> +cpufreq_freq_attr_rw(max_perf);
>   
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&freqdomain_cpus,
>   	&auto_select,
>   	&auto_act_window,
>   	&energy_performance_preference_val,
> +	&min_perf,
> +	&max_perf,
>   	NULL,
>   };
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 3fc796c0d902..b358440cd0e2 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -174,6 +174,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>   extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int cppc_get_min_perf(int cpu, u64 *min_perf);
> +extern int cppc_set_min_perf(int cpu, u32 min_perf);
> +extern int cppc_get_max_perf(int cpu, u64 *max_perf);
> +extern int cppc_set_max_perf(int cpu, u32 max_perf);
>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>   extern int amd_detect_prefcore(bool *detected);
> @@ -270,6 +274,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_min_perf(int cpu, u32 min_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_max_perf(int cpu, u32 max_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>   {
>   	return -ENODEV;

