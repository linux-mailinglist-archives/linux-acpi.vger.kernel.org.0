Return-Path: <linux-acpi+bounces-8227-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B53974A3C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 08:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD731F267F5
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA5762EB;
	Wed, 11 Sep 2024 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAtyo8l6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EF8BE7;
	Wed, 11 Sep 2024 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035274; cv=fail; b=jjblXiNZeApCsDLvnUhEQO2FeimjQtRgXWlPeBnY6ddEpGXnR7qDMiRugh1VRZ6N8twGEhugGttDkE3oP6/qjMyZzu1aPzmjKkGAY82oWDMObKfjZy3gFbTrNSxp1cqu99GkwevAhcspzgQAFjpQfjv0F/lZVC7mK3AKNATx7To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035274; c=relaxed/simple;
	bh=Ei1jlqpUmeCcOLGmCKBwgqfN0SIlnINpMrryerrfYs8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TJEnhXNlWu+ByXLAlLGOrR3PK58vctGzWJ/PB8jUkcSJpQ4zsdV5OYkhTCD1k2NKPmzGss+ozwLzquCXy7nYZGfNek2y1tZA6Qn6nZKl7eCWm8o5eik0KPUuU7WCf2Ft4W+URt2JaMkNKtRjdvM9qq0qfMfzXbg2xdy/EAGFYa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAtyo8l6; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZviWYGKFH2x6QlikXiswMLTtAx6mH8xPKKtvtOZkMlAM5QzQcvCT0Tnt7brX+tzpe7S3O/QJx/3LVgQhV7Yof8iJj6pE248/KOyevgjXz5OFtSET8O9KkuOrXC6gI9H9Jq7ms2zuSI7Gx7jy9vxT0lLRwMj8goHMqFhNErxuzzXJDYyPtUJkz7FYA7QGJ9jQlISxz155Cev71ybYCBzepacswW6/L4RY2tJbqCcaODfY+GFd/vteiepm2rc+L6RfTITwE2B7HyqnHppwdUrN9ztUf7W1dNVmpIJQ4eb0nlbp7nP7patnl1gh1RF0ZVep44b6lzHL/thv8Rh7ZScLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkuRHtO7V207w7cxFdB+JKt/ptHkV6FLSDNfsMVopCU=;
 b=Ic8o9N5+qVhcUjm7su/P63Hk4uDgTiEzSLwdaLCUL3GcCoW0JpMdJTAxadqFsmlOEe2MdX2Y9iJ/iTTKfhISpYjGJ6NGE/ygRyv8BoDS3pC/dw+5gv4F8aZDq1G6v5GJCdgJoO4PUUPIljAI0PA+5EfOVt2e7It3ZIcpHjN2nzJSLnW4drIudvoBzOKN5JbRjYVnaMN5m1Wk5mGl8NZTB7zRxnuUlMrZDpSmui1FAG1BSS3KHZLevZyDbvdUZ0lPmZ7ee9Y1Dwqb7xU/vSWBaJn63rqkT5/RN2uhHdmj9o8DlKW/wE65GqAiyBFbF/WMWwmWDpXEVjKLMzsw0VDy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkuRHtO7V207w7cxFdB+JKt/ptHkV6FLSDNfsMVopCU=;
 b=cAtyo8l6hFfoXwJ8J8Cl2NEJdp5AfmwnVVMosLB8vNRVr21O070Lrp0EdhjZMwcAc177ytp0KtOFcc0EDZ8wbWtv3dN5o2tdTJA9xWf7ywqeeTBYRJeeoZZEG9HCp2K1b26qLBquut4OwCvEMG7Xyj+NojijIXmhe9Spm/pOTLXeoEw0yxqzJDABA4p/ehJnwDKAMQYtycWyVAoeiDD2sYSAK7xREsi+sISEdPXg6Ds2gRpjcsqYPbUsVvVyL9Kip6I6NZrtgV03RgeSR5jNtdLYT6IpQoE7x/2uCXHS8yuAIzitkmL9DomBdZVViHNxBOA6tYWqSYI3P8OGVfg5tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 06:14:29 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:14:29 +0000
Message-ID: <3d6ed4ad-0108-40dd-92b2-fc249d320667@nvidia.com>
Date: Wed, 11 Sep 2024 14:14:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] acpi/prmt: find block with specific type
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240911045214.930141-1-kobak@nvidia.com>
 <b660f003411fc5f22f58b6a8f16d38f7bfe682f9.camel@intel.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <b660f003411fc5f22f58b6a8f16d38f7bfe682f9.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::36) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: c15d477a-20e8-4b21-a4f4-08dcd228fe86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVpxSjNpTzFnb3Q3eTdCenZkZXFxbjluV3Z6TDBqM1dKQmZzTUFBYTFlYkhI?=
 =?utf-8?B?TVh4UlJxQkRYSHl3STU5RWZIblNhVkVTT3dreGt5cDRmeFU5R1Ivd2pFcmJE?=
 =?utf-8?B?NEJhblFhMG9vQytvc1o2OVNTTWdpaUxic0NBczZqK3VYbUZoWWJmeElubDNM?=
 =?utf-8?B?N1d2Mjk0dFFoY090NXB0QlJ4TFZvc1A4clFOZjN4dWRQWmFkU3RJRS8zL0d4?=
 =?utf-8?B?a09mVmpBWnJ0cWdNc0s5eGJwQ0ppWnBvOHcyL3EzOEFYaXJWbFEyZmtCSXpu?=
 =?utf-8?B?UFptSnRWWTRLWFNwZlY5N1FveDJnQzhqN2xHaXFvT1hnN2hKeFgvcE9DYmVV?=
 =?utf-8?B?U1VYS3lqSVZBUzBuZ2dnZmVtdHpDOHNrK1lIaWpLbU9zS1RkZ3BBMWVtZEpF?=
 =?utf-8?B?Q1ZMZnBoQnNiUWRiWjBhYnJVUW1YQzFuRnRiV0NCbDQrTTRTTE5PUW5sVmZt?=
 =?utf-8?B?NXVZS1B6VkpNQmNHNVVzdVNYYzIySWlBd09mOWFSZ0RSTVVaU2lrVGdDa01Y?=
 =?utf-8?B?TGhYbFJNNWlFN3U1YnUreTd2dldDZzZ3ZmxpL2tlTmhDL0dBaXV5ZmNvMGZU?=
 =?utf-8?B?S2srNzVTRndiRFpoRVNwUnhWOUhlMTBlMUJ2WEFLUHBEVVZCcWlJNzNzekxM?=
 =?utf-8?B?cEtmRU9uTlZ5OHMxd1pQY0Fjc3p5THpqZDM0UTJSMUlpMGlhMlhKbHB4TlRr?=
 =?utf-8?B?VDNzZ0NUWHR4Ly81Sjh5MHpwZVRadk1UVjc1UEFyMWNKSWlUM3dXQnZkNjdF?=
 =?utf-8?B?b1FCN0I5NEs5SlJqT1pmMlMvQnJ2dmdScEJlZGxrbGJwQWdkN2JRQmptbFQ1?=
 =?utf-8?B?MEl1dUIyQ29jK1VvYzYrTGZCQTl6SmhvWXVIODJBSHc4bUxxUUlSSHpRTStx?=
 =?utf-8?B?cWdmRVQ1QVNjTDdzT1JjaUpUMkU2UXJhNi9wcGR1R21KZ0NOa0UrRHNxV3FX?=
 =?utf-8?B?RXhZUkNvTFJGQ3ZmeXJ5eFRBMG92ekJvYzB3SnJDZS81TWNQY2Fzb3M3Vmt2?=
 =?utf-8?B?OWs1L3Njc1p5NldOM2JXV1RRUWJySnM5TGpFSjdaSzRoMmtFcVNaVHhkaUU3?=
 =?utf-8?B?RmdBR1RMRldpTGNmZmdscFRkSTZxeVA1bURhKzdKSWhqWTZxWW04dysxdmdz?=
 =?utf-8?B?b0VRYUZBbzNxYWxGWFVmM2gxd05kV2crVXVGMGswSktodzFpSE5QdUY0bzM2?=
 =?utf-8?B?MmdnRXArYkFGSmJJdGV2MUdUbVVzaHRBYXBONWNEYXdpdXhCUTFpT0FxS1ZF?=
 =?utf-8?B?YU5Ddm9WT3BpM054aGpib1UzVkFySkJjUnd0OUh0SFBsRFd0Wmc5UTlockM4?=
 =?utf-8?B?YnNaSmJJbExuOFhhZmt4QTZoRWNIaFp6a1lQNk9YVm5USzM0Sy9WUmhyOXY4?=
 =?utf-8?B?cmpZVm1oYUlBaU1EU21lNnpIVjd2R3dBaVZVN0x5dEZjVFFTQWVNWUlKZ1Zm?=
 =?utf-8?B?aktZQkhzN2pSUFNHSjdsemdpdkFlZnZCM3F4QW4yczF4QjFXRWpYY0QyREJ6?=
 =?utf-8?B?YXkvcGVVanF0V2ozS0FBS3JLckwwblV5YThWL3J2SXE5a0g3SnN1RnQ4cmdo?=
 =?utf-8?B?TlhYcUZ3MGpZR21FZEJZdHFpb21BQWZld1VOQU1zYVJZN0kyR1IvcW5hM0Jr?=
 =?utf-8?B?UTB3NG1FMUJkVExPZEM0OWFJZUF4dVpmSTlmTWI1Sk8ya3hzOGg4bmVITVpx?=
 =?utf-8?B?R04xZlQrOEVKOC93REJHRVlBMXZOZlRpWXFSbXNPWk5vU1J6WWlLSVhHa0x3?=
 =?utf-8?B?cXJFSEhuSTV3Sk9IeDJIdTZDM0ZqQW0rQS9KY1RVQ05XRXZTbHlMRzMvOURC?=
 =?utf-8?B?RzlaRS9aTUd5M3U1ZC9MUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmN5clpSeW14MWw2WGxXU1dWYzdIUHpoY09rYVVFV3ZOaGJ0N3kzdHROQ2VX?=
 =?utf-8?B?K0FWSndqY3VRWWRPcmozL0xMb3JDamtpR0swQmxIQXF5SVcxdmFQQ0QzN1Yw?=
 =?utf-8?B?bm1weTViUSt6bEI5K3B2QThMTmJEM280SGJlY0dkZGl5L2huS3JkbWF0YWpy?=
 =?utf-8?B?MExYVkZHbWxHUVk3MGNWYlBySmFhVXNZa0xoYURKVXhlUG1OZEhob0dWUzk3?=
 =?utf-8?B?TUtQdmZGakQ5L0luL0txVTNMcjQ2WVRhR3FhZkZpZmhEM29nTHd2dklRY0Fx?=
 =?utf-8?B?Vk1VYlJFRzZMQWlVT3V1MUpDZmdwT0M2VXR0TjQ3MEo0UU8wQWdjaEw1aWZw?=
 =?utf-8?B?VXpUcy8ra2JUekVnMmFMNitxWVhieVFVVDJDUFd5QjBuT3VmUFdPa1BNUU05?=
 =?utf-8?B?d25CUFNVZ1ZGS3JZVUNya0tsa21mUVVXNm9kM09GUVZIYS9NOW44MWVSMEdk?=
 =?utf-8?B?Z2pLbXZuV3FVTERlbldzbjFUQVpER2FLZnFpU2xzQ0owcTd4TGk2eElRT3lx?=
 =?utf-8?B?MjU2QTBwRUw1OEhFS1VBaUNJNWhqRGJNTGJ3dHRjd0RpNW13K3dEcHFPZG5l?=
 =?utf-8?B?R2hLdHY2T1ptUFlJMmh3aWRkQ0tOa25wQUE0YzA3S3N2TXVaUWxOcVVnNjl4?=
 =?utf-8?B?eG9Ta3NDN2xWbk40MGdUaUhSaGovWWJ5RjliNGNnN1grcjZXa2pINmM3OVAz?=
 =?utf-8?B?a2VZb1lkZ3dnUjlFLzdMMmNYVXBmT0dDcHJ2TG91dHBlWUYwbUNlZ2tKM1hU?=
 =?utf-8?B?OUV4NFV5elh5b0E2TCtkUEZZSzhyRWR5ajhHTTJDK1d2bDV2bW9GdGQvbUdv?=
 =?utf-8?B?MHY2L0N6OWc1VjRZU0pwb0hiaFlYTHBpdHg4YldzM2lKdDF1QjNhanpRWGNy?=
 =?utf-8?B?U05UR1RBdmQzem1JQXV4UDgvRVVmeS95aGdtWmU2TGdXNXJkOUt1S2F2SUFM?=
 =?utf-8?B?MGgzUFV1TWNiUnJSN3habU1rWEJLL1JUWUFZd2taNmxia0s1cDVKOExGOGdM?=
 =?utf-8?B?SHBCa1FCN2VMRnJJR2EwZEdaMFVYazJrWUJPZ09GU3FmTTB4OU1iVWxLa29B?=
 =?utf-8?B?cm5yeTBtdGJSdE1FNEZTU0padTlwcmhmUXJDN3NiOVF4WVg1eE5vL3U1Z3Jn?=
 =?utf-8?B?VjVndEdSdS91Q1VTbXpRdU9WcVFxd1MxT1JHZW10a0xBQlRDM0lWY0F2Tno4?=
 =?utf-8?B?dThib0VkZ0ZwV1dLcWluV0lOQ2pLRHBSWGZhYjVaZzJjd3poV1U0cDVtSmNX?=
 =?utf-8?B?d2VVOXN5VFNWSHpDQkhHYVF6dDJxa3lMK1BSdC9rUWRaOVQ2eTh3c05qOVYz?=
 =?utf-8?B?dUUvZ285eTZ6SE1aek9CK1BEcWZtc1RrRVVjUGVuWWFJQWZhZzl6V1puc1lN?=
 =?utf-8?B?dVBndjMrQlFsVVR0bndkUTRncTVjNzN4UkdjT2JMZnVFMW9RYmNmaVZQd3VC?=
 =?utf-8?B?eW9hZHdQcG1BMTgxbW9YT2xwZW5LOE1qRkwvWnVvRDNxRHdjNEl1ZzFrQ05s?=
 =?utf-8?B?eTVSamRhaVhVRm5TWW9ZQmtsNmFsMURBc2lZTUVVNVZtTlBMWHQ0REg1QXgv?=
 =?utf-8?B?RFpxT1UyRWIvOHVCZ1Ftdk1DQVhPOGpsVEM5cUEzVkY0UUpVV3YyYzdxWFhz?=
 =?utf-8?B?QmhTU3F0QkFqTk5ubDNkT0MwSzJFdUcrWnhRckFLcXdMRE1qdGpUQ0N4MUN6?=
 =?utf-8?B?WERReWRxQmVBZ2I0YzVrNGxBVG9BZG5palNmMmlkbVJyWVdQWlQ0RWJIYVQ2?=
 =?utf-8?B?U0t3OElBUGoyeGduODl6VmJkVS9pRWtPQXd3a1kxSWliVzJBZElTeDlhTXpW?=
 =?utf-8?B?aWVCZmtvNFlYMEFNRDA3U0RjU2JHam8xaXRKUUptMEozNjRyOUNVa2VmYURL?=
 =?utf-8?B?cFk5RjBsYlRMR0p0eUxROWRpSE83TU5BZ05Db2NWNytuNEVFSnZDQTRnUkV1?=
 =?utf-8?B?Qkp2VjNseFVSZmRuRDNIYkdCTEk3Wk8vLzBFVXF4RGFwOU03MEx6dUZvMGVY?=
 =?utf-8?B?TTBYa2V5ZVNwaUpNNXJiTVlHWnNLcm5ReERQYnpzbmZON1M0RXBybnFWWXY0?=
 =?utf-8?B?WDRtR0s5Z1JVSEZkc3JEencxVjVSOHoydVUrcnhtTEV5UjZLSUlTcXlKSzAx?=
 =?utf-8?Q?+zIwDos+JlYIiO7r5sug5aeWT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15d477a-20e8-4b21-a4f4-08dcd228fe86
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 06:14:29.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXMtJg0IwmN1VMMsSASYqiPHqG6aOdD3EdOr6mW3qTz3iNlmLRBuReaAmb5VCTqMhMy17jzsRl9YEpVUnzyNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905


On 9/11/24 14:07, Zhang, Rui wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 2024-09-11 at 12:52 +0800, KobaK wrote:
>> PRMT needs to find the correct type of block to
>> translate the PA-VA mapping for EFI runtime services.
>>
>> The issue arises because the PRMT is finding a block of
>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
>> runtime services as described in Section 2.2.2 (Runtime
>> Services) of the UEFI Specification [1]. Since the PRM handler is
>> a type of runtime service, this causes an exception
>> when the PRM handler is called.
>>
>>      [Firmware Bug]: Unable to handle paging request in EFI runtime
>> service
>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-
>> wrappers.c:341
>>          __efi_queue_work+0x11c/0x170
>>      Call trace:
>>        __efi_queue_work+0x11c/0x170
>>        efi_call_acpi_prm_handler+0x68/0xd0
>>        acpi_platformrt_space_handler+0x198/0x258
>>        acpi_ev_address_space_dispatch+0x144/0x388
>>        acpi_ex_access_region+0x9c/0x118
>>        acpi_ex_write_serial_bus+0xc4/0x218
>>        acpi_ex_write_data_to_field+0x168/0x218
>>        acpi_ex_store_object_to_node+0x1a8/0x258
>>        acpi_ex_store+0xec/0x330
>>        acpi_ex_opcode_1A_1T_1R+0x15c/0x618
>>        acpi_ds_exec_end_op+0x274/0x548
>>        acpi_ps_parse_loop+0x10c/0x6b8
>>        acpi_ps_parse_aml+0x140/0x3b0
>>        acpi_ps_execute_method+0x12c/0x2a0
>>        acpi_ns_evaluate+0x210/0x310
>>        acpi_evaluate_object+0x178/0x358
>>        acpi_proc_write+0x1a8/0x8a0 [acpi_call]
>>        proc_reg_write+0xcc/0x150
>>        vfs_write+0xd8/0x380
>>        ksys_write+0x70/0x120
>>        __arm64_sys_write+0x24/0x48
>>        invoke_syscall.constprop.0+0x80/0xf8
>>        do_el0_svc+0x50/0x110
>>        el0_svc+0x48/0x1d0
>>        el0t_64_sync_handler+0x15c/0x178
>>        el0t_64_sync+0x1a8/0x1b0
>>
>> Find a block with specific type to fix this.
>> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
>> find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
>> If no suitable block is found, a warning message will be prompted
>> but the procedue continues to manage the next prm handler.
> s/procedue/procedure ?
>
>> However, if the prm handler is actullay called without proper
>> allocation,
>> it would result in a failure during error handling.
>>
>> By using the correct memory types for runtime services,
>> Ensure that the PRM handler and the context are
>> properly mapped in the virtual address space during runtime,
>> preventing the paging request error.
>>
>> [1]
>> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>>
>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler
>> for the PlatformRtMechanism subtype")
>> Signed-off-by: KobaK <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202409071245.bkGWWtfQ-lkp@intel.com/
> I don't think you need these two lines. This applies when you address
> the bug in a separate patch.
ok, thanks
>> ---
>> V2:
>> 1. format the changelog and add more about error handling.
>> 2. replace goto
>> V3: Warn if parts of handler are missed during va-pa translating.
>> V4: Fix the 0day
>> ---
>>   drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++------------
>> --
>>   1 file changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index c78453c74ef5..029e8f9db53a 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -72,15 +72,17 @@ struct prm_module_info {
>>          struct prm_handler_info handlers[]
>> __counted_by(handler_count);
>>   };
>>
>> -static u64 efi_pa_va_lookup(u64 pa)
>> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
>>   {
>>          efi_memory_desc_t *md;
>>          u64 pa_offset = pa & ~PAGE_MASK;
>>          u64 page = pa & PAGE_MASK;
>>
>>          for_each_efi_memory_desc(md) {
>> -               if (md->phys_addr < pa && pa < md->phys_addr +
>> PAGE_SIZE * md->num_pages)
>> +               if ((md->type == type) &&
>> +                       (md->phys_addr < pa && pa < md->phys_addr +
>> PAGE_SIZE * md->num_pages)) {
>>                          return pa_offset + md->virt_addr + page - md-
>>> phys_addr;
>> +               }
>>          }
>>
>>          return 0;
>> @@ -148,9 +150,18 @@ acpi_parse_prmt(union acpi_subtable_headers
>> *header, const unsigned long end)
>>                  th = &tm->handlers[cur_handler];
>>
>>                  guid_copy(&th->guid, (guid_t *)handler_info-
>>> handler_guid);
>> -               th->handler_addr = (void
>> *)efi_pa_va_lookup(handler_info->handler_address);
>> -               th->static_data_buffer_addr =
>> efi_pa_va_lookup(handler_info->static_data_buffer_address);
>> -               th->acpi_param_buffer_addr =
>> efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>> +               th->handler_addr =
>> +                       (void *)efi_pa_va_lookup(handler_info-
>>> handler_address, EFI_RUNTIME_SERVICES_CODE);
>> +               th->static_data_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info-
>>> static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>> +               th->acpi_param_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info-
>>> acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>> +
>> +               if (!th->handler_addr || !th->static_data_buffer_addr
>> || !th->acpi_param_buffer_addr)
>> +                       pr_warn(
>> +                               "Idx: %llu, Parts of handler(GUID:
>> %pUB) are missed, handler_addr %llx, data_addr %llx, param_addr
>> %llx",
>> +                               cur_handler, th->handler_addr,
>> +                               th->static_data_buffer_addr, th-
>>> acpi_param_buffer_addr);
> have you run build test for this patch?
>
> drivers/acpi/prmt.c: In function ‘acpi_parse_prmt’:
> ./include/linux/kern_levels.h:5:25: warning: format ‘%llx’ expects a
> matching ‘long long unsigned int’ argument [-Wformat=]
>      5 | #define KERN_SOH        "\001"          /* ASCII Start Of
> Header */
>        |                         ^~~~~~
> ./include/linux/printk.h:437:25: note: in definition of macro
> ‘printk_index_wrap’
>    437 |                 _p_func(_fmt, ##__VA_ARGS__);
> \
>        |                         ^~~~
> ./include/linux/printk.h:518:9: note: in expansion of macro ‘printk’
>    518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>        |         ^~~~~~
> ./include/linux/kern_levels.h:12:25: note: in expansion of macro
> ‘KERN_SOH’
>     12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions
> */
>        |                         ^~~~~~~~
> ./include/linux/printk.h:518:16: note: in expansion of macro
> ‘KERN_WARNING’
>    518 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>        |                ^~~~~~~~~~~~
> drivers/acpi/prmt.c:161:25: note: in expansion of macro ‘pr_warn’
>    161 |                         pr_warn(
>        |                         ^~~~~~~
>
>
> -rui
Certainly, i built test for patch.
Sorry, didn't mention the warning.
Will fix.
>
>>          } while (++cur_handler < tm->handler_count && (handler_info =
>> get_next_handler(handler_info)));
>>
>>          return 0;
>> @@ -250,8 +261,16 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>
>>                  handler = find_prm_handler(&buffer->handler_guid);
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!handler || !module)
>> -                       goto invalid_guid;
>> +               if (!handler || !module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>> +
>> +               if (!handler->handler_addr || !handler-
>>> static_data_buffer_addr ||
>> +                       !handler->acpi_param_buffer_addr) {
>> +                       buffer->prm_status = PRM_HANDLER_ERROR;
>> +                       return AE_OK;
>> +               }
>>
>>                  ACPI_COPY_NAMESEG(context.signature, "PRMC");
>>                  context.revision = 0x0;
>> @@ -274,8 +293,10 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_START_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>>
>>                  if (module->updatable)
>>                          module->updatable = false;
>> @@ -286,8 +307,10 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_END_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       return AE_OK;
>> +               }
>>
>>                  if (module->updatable)
>>                          buffer->prm_status =
>> UPDATE_UNLOCK_WITHOUT_LOCK;
>> @@ -302,10 +325,6 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          }
>>
>>          return AE_OK;
>> -
>> -invalid_guid:
>> -       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>> -       return AE_OK;
>>   }
>>
>>   void __init init_prmt(void)

