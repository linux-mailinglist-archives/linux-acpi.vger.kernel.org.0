Return-Path: <linux-acpi+bounces-8165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC596D94C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22D728AD34
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4519A28F;
	Thu,  5 Sep 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t7t7KZI8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22919992C;
	Thu,  5 Sep 2024 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540599; cv=fail; b=eCWuXGUp7UNF5kULKSTKX4HGh2O4PHR7hbnZJ5LIOaxIeow8uPFQevahU3iJdQLtDh5yiFoRqSVCQCKEk512oEgndkEN6c/fDH3II58kLlW0IsfWWfIxalv08qvNCjeaSXwYwwiBnLYqRk4iEja/NAvhWzJPMh7eqYKW9btFUnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540599; c=relaxed/simple;
	bh=980f0V8Aktgb0NdLAuPuS/wvffxXBqOp8ZmIB7oGqOo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KXghCbm3u5GG0+M8H0jTcG+BYtjDMETI0fFRtn0PwjSQw/Wmz21hf7AvfkXJ5Dg0JgaJbjjtuApCckojsV/i6BL9RUXbwKgfMyFY4MW4lPcQ8j3ZQPqDISQODscyHRIYO0RXSckXgyFLtFYpt1jGaJ4XRtLSi24Mnb9BjK90Vvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t7t7KZI8; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js4XvZgt2uK8808Uugi6Q/JZ4/nOfm0ARYEtmrA4rrkSzYblWH9IuPnGmRSNA9VQJPB1lAHutMG8diw4AuRfjbmfj65xFCkZGsA//bMTsbXn2bLmIPrLBu5shmGosg+Q2WDeMJXvjcLw3Mp4ilq2fWMlLuWMUAaE1L7MyPxzup9MhU1u6QKS9GkT8+Vs/CymLprpqQ8tAp8ErXpDT+vZbRjkNTBXndoDLLMUnc6liDbEZumipqOPh2bgDSQ5TApe6lQTR9LZFJvuq9ad8j9T0HBkr8JrnkG1xEVU4wQJ9vtUkQ8+9QbBHJvh+OaiH2Lt8i+xZtl9Ea/T/ZwcJz7RTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aKSuqilzus2tQhiYl3LdwyBXeBToQDrfvfVqNw6UZo=;
 b=RXjMwNSZL8gCjiDew5NeBgDowbiwOUOH6G6s2oCWTpTiTtExU9jTM7Vkl4fDUeqQGnD+hXbesz6nU+yT/J8aJ9NkYeBBVwwT69udl9OVsejVn6Faw5oWbLBvM6tJ6seWJxzPiBKxxntF40rtPGXt/tYMMIa96tpzMv8QtEkmn3GTqGG2NuEUNKPLJiGM3oLPZyax9b9K8JUKebTvQESnVQYKb5Kf1L4w1MkeO3D0fE7oNyNBiWZWaI1GREFzR9ugtxH2T+jztsHOmwwoJwbQnahp5Xt4gYZX+Y3MEwavswVZjkpIM2pjCVAFfYCH/xNR/HXJEmZNIk7fIlL51C95Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aKSuqilzus2tQhiYl3LdwyBXeBToQDrfvfVqNw6UZo=;
 b=t7t7KZI80lNCDcVEhHpgaMW6OtnbNzoE2WsXrc/fh9ZXbxTjC/TUvClUjnN59O6EB7nOz6TqzTMSv8rIROho6pZr9buOwkAKbjImVfLrV64ZfRCcJP4jBm6hxmltBTXtTDhaUJmE/EguY8d1DGQuYFtOOdv6sQ/qsgyf7S6Ael60bD5lgf6PzP9TvJk24gcjf/evhVBbnFVv9OHQXJJiMjqkATVIoydJ+yp87cvyAsSRhEkzaRIbnjuiRZsPu9OJ9NB8rgr7+YNRUURLQPIKkWZJNaQFgkbdxse6DDKG6pR8T6JBuuthkSvzWaktDZ22VnLaCiugtJeJCuKUZBkdxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 12:49:54 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:49:53 +0000
From: KobaK <kobak@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3] acpi/prmt: find block with specific type
Date: Thu,  5 Sep 2024 20:49:50 +0800
Message-ID: <20240905124950.512973-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::8) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d831a65-f5d3-4683-f518-08dccda93cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2a/AapkrJpRtndAfG2WW7J5XG1wQuDMs3MAbFMhrcfXgIUZL/SVuQ01Wf5oN?=
 =?us-ascii?Q?4HdXoSj0dmLIoPPB5obLwy7s/LjjTJx9rfeHDbx+w5iut1c3Y9zORaG33Osr?=
 =?us-ascii?Q?+8HJfeVMASVazJxgRh1fNoinrO3xLAgRFS05e1vezhDoXmnnbEz33B5vxBsy?=
 =?us-ascii?Q?j4Hgr2YItf57GAWmikA4lPtNY7UUhDqWwYsnx0CGNq3pPUYZ2ZyV1OW1Fnif?=
 =?us-ascii?Q?NllEhSzSHd2nTwxi4GnxeoKcvwOdHDhl1cEuSgFXEo9pUv/KUDjyLQ8YwDT9?=
 =?us-ascii?Q?KdWbVyQvoGoWvzAFm/MTzyUXc1H5ZRLb/HVA8T1LLjhDeuhnget4zUeXyFSY?=
 =?us-ascii?Q?JK8PyVWYT+m1IbpzHdjS4sgPCSTBTfimZDjWsHcUuhMVyN6Ly2r01shUj8Ht?=
 =?us-ascii?Q?0/0j0HB150hNtp+VoqKEVX2vmDmvYtL8uFzd6VUOaA8aM/tDE5ubnLGSQxTs?=
 =?us-ascii?Q?SEh3Ahx7HGWDrYZOZGHVrDyvjvN8AbDS3H/tiujIivbCk/dYZDl4aIUeoosJ?=
 =?us-ascii?Q?ChidsICJuuB3kzjypPLtkvhEbRS2oyCfXpmKilf64n3mVMAlhzweoJ/hsfEK?=
 =?us-ascii?Q?Pr71TnZqGq778NHTAt/+KlIoy6thk+y3pSnk3DUCtj0vBr+eJ9PIQqq0WbGN?=
 =?us-ascii?Q?ZQJlR257Zky+i+860BJXR+LRpQaT48NlmMZasW0w8xvh36RoyFv4tLYx55P/?=
 =?us-ascii?Q?D1Ny7CF2zYjH7k92j7a3jy2w3yVacThzwiTXnSy3UW5gFWyQz+Bvi3aW+88a?=
 =?us-ascii?Q?b9Ord5F90mBheg+eBq/0TKEj1DKf5v/GBlXm0yItW+kn75prgYtdvn1gaBUH?=
 =?us-ascii?Q?qxaNqDAy7whpgNTK69Fh6uhltKPPY+K34lmj3IVWYCUdYBD+8WonNcHCtljC?=
 =?us-ascii?Q?uSTam9uhJxnDUccefpj1qnodhPxznLxr/VCc8UudVBhDxc7NrnoqY1DIGZsk?=
 =?us-ascii?Q?rh7PJ2ZDFL3DSRLtRK8A9YqX7A18yRO0a78rDpWaXndab3r7igLQtAG24DqE?=
 =?us-ascii?Q?wOj707LEDKh2kuyPRb66YAFy+3XH6WvflsHRVS7aTmXUbksZ0i7jl5LF81Ox?=
 =?us-ascii?Q?EuU30VO77L5W67Wut9kFXffMeL6sat/hrSh01nSQrA4RZemAWIDwD505dYUd?=
 =?us-ascii?Q?nev80ShYyOfmvE/4GZeHdGuU9WApI0fqDpr1Fl1loG7z+gBrg0YW+blgzFvp?=
 =?us-ascii?Q?+ncM/hL85lQSgTFVyIzqttoahKTvDVPyDySEy/GxkyGr/Vtq3CQE3TSpAE6g?=
 =?us-ascii?Q?w2MSEwZrOH07UKl83Q+CclfR16hWsZ7YTMLJi3lsSKY63Zc53HKPp4J8hZC7?=
 =?us-ascii?Q?NmDJjBnsL9z9ShI/NEcd/Tw7XjknvqTl/A+qW71JTkNbcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5t9L+BMnk9mTMEs8RWAFvpRuCdrM+zLVzb7vUCW/+vuncP199yzv1hclUgKy?=
 =?us-ascii?Q?NvB70LN8WvBCFOeXRiEhy5pvYDQcUbIxufHXnZTAQHqwTEGdUg8FrzTzvUEA?=
 =?us-ascii?Q?scTAtq6Ot+VAG1zIsu45AI6hl3Bgs071OtmhkT+wow9MaaEhoSAAVwnEI3eG?=
 =?us-ascii?Q?vYlldQG2vqAonW/ATHcTwHf6oeDqENfSu4JCjOthbT/Wtz9+0E7mp2z1i2p/?=
 =?us-ascii?Q?bUOEr8qtqvTBPPUyrNm3TloGRflZ8kba8Go4fjpBd0mLD9Kl7z/coqZbcN8g?=
 =?us-ascii?Q?ujN/GHKRkynFDfmyk3V9UEKqrF3Rc6G4MjTZ2zTrKaXZAVFpMk5SsCcE1XDj?=
 =?us-ascii?Q?rpBXJ4kbmcPJ+JDREKl00r/3aVl1vuxj3vWeSOMP1zr6WNZpd85YAWpJwWgl?=
 =?us-ascii?Q?eLnbA2BdtKnYawiC7djiJqh+OHaodHdTrtb2Qds46/Nv7bh2SlpwO+6pbqmR?=
 =?us-ascii?Q?HW8SsvAGUAXh9xoniQbbbxezd1XQGJ5v6n1HgcpfwCHLNUhHw4qHJti12Jvq?=
 =?us-ascii?Q?qaL8ZuXbHSL3JcVZXWrLQWu7TmtNXhS00zUEQZi2uikfpdWiJEXHExz7B1QC?=
 =?us-ascii?Q?mQNluWJSjjtJyyXrTUOGVV349VgdwRktJqd+WTD780mFCEK3RT5ZyxkdnDUO?=
 =?us-ascii?Q?q/KxeBlsQJaUKIdfOesWiRnkA2eZzvGrvCV49X1zYXsaSn+kjplcvIpn3w2i?=
 =?us-ascii?Q?NXx236BhL13Ej0ZABvMfcZpAbTdBRr2qS672zip2AKn7lCflSxUoClhrJbXD?=
 =?us-ascii?Q?axAXUOaYwr12CrdGpsiK0PX0+90sCBAFAyGWZDHhrxNLQaBGkuyZx8diILQU?=
 =?us-ascii?Q?iuHokumo84FRf8+iWD9OQQojnC/kJMPJUgZtgpNNdtKZ4ix0wpdbn+ZWreML?=
 =?us-ascii?Q?Tgav386dXK7JFY1yuVLcEp565LFiCT/ub3u47IzMqbPy6yS+UNdxzoUuXY4a?=
 =?us-ascii?Q?THaY0/UVAZwoEcrNsPYvceVJ9P4X40VGSQXhBgtV1RMzCk2JjbWCx+0NuUdX?=
 =?us-ascii?Q?gYUc9PPTtNw7wmPkLQYsvKzE+f3nKrAWyuOZf+EG5OPBOJYxV6WVccniqBZk?=
 =?us-ascii?Q?7hS0IVVK5SgVhaptTc1XAZ9vlGpB1f9zfJTqZfBvn+mlGjx+Gn/NIqv8KPWB?=
 =?us-ascii?Q?TwvPsehS8Tk/vj4ZUSXU7BC0IGjTJtUSG8BK4ldjScdoS99BYdW6QCyjJ4+I?=
 =?us-ascii?Q?IuRF00on10mrnGHVt4AhO7VzMigudRnRTzpH4ooT2C/qV9afIUNbxyVm3Hnw?=
 =?us-ascii?Q?r+LQpsfgVtVhsZo00F03N1pD/cMXURVUBdRKl4psDfVQ/RioQPU+9KfFqrZu?=
 =?us-ascii?Q?Gok1j3Ig9MUKbRCmIS9nFEbNgEjR37EOlONmPwpBYMRaTfwxe7wC3u6mjYud?=
 =?us-ascii?Q?/HUnjtKihDxl85Uwx6rcenodx4ffUTuTqf1kE9Zp9r+cESMZpvB7imKZg2qx?=
 =?us-ascii?Q?kajReelvzpHs3zuAW8wwGdpA59I2tz/A1DAiIJZsUQFHP85b4Cq02AJREEhS?=
 =?us-ascii?Q?XRdaFuKhkhl0Cfbt7sRTWIORuTmhgZONxAB+mL7Bit3HwfPKeC5rLiFc3Nh4?=
 =?us-ascii?Q?W8Uh5qL2A8l/ZO7xpjdE4rxAzt74HUGNnXA9AMxl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d831a65-f5d3-4683-f518-08dccda93cfb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:49:53.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zU9ryePPpAUaIDkj73OaheWa501/cBiL/BUAlPc4wB6IAPxgyS5fLXFI423EzQUWX8YinfR60PFm6HOyjQV/GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989

PRMT needs to find the correct type of block to
translate the PA-VA mapping for EFI runtime services.

The issue arises because the PRMT is finding a block of
type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
runtime services as described in Section 2.2.2 (Runtime
Services) of the UEFI Specification [1]. Since the PRM handler is
a type of runtime service, this causes an exception
when the PRM handler is called.

    [Firmware Bug]: Unable to handle paging request in EFI runtime service
    WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
        __efi_queue_work+0x11c/0x170
    Call trace:
      __efi_queue_work+0x11c/0x170
      efi_call_acpi_prm_handler+0x68/0xd0
      acpi_platformrt_space_handler+0x198/0x258
      acpi_ev_address_space_dispatch+0x144/0x388
      acpi_ex_access_region+0x9c/0x118
      acpi_ex_write_serial_bus+0xc4/0x218
      acpi_ex_write_data_to_field+0x168/0x218
      acpi_ex_store_object_to_node+0x1a8/0x258
      acpi_ex_store+0xec/0x330
      acpi_ex_opcode_1A_1T_1R+0x15c/0x618
      acpi_ds_exec_end_op+0x274/0x548
      acpi_ps_parse_loop+0x10c/0x6b8
      acpi_ps_parse_aml+0x140/0x3b0
      acpi_ps_execute_method+0x12c/0x2a0
      acpi_ns_evaluate+0x210/0x310
      acpi_evaluate_object+0x178/0x358
      acpi_proc_write+0x1a8/0x8a0 [acpi_call]
      proc_reg_write+0xcc/0x150
      vfs_write+0xd8/0x380
      ksys_write+0x70/0x120
      __arm64_sys_write+0x24/0x48
      invoke_syscall.constprop.0+0x80/0xf8
      do_el0_svc+0x50/0x110
      el0_svc+0x48/0x1d0
      el0t_64_sync_handler+0x15c/0x178
      el0t_64_sync+0x1a8/0x1b0

Find a block with specific type to fix this.
prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler and
find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
If no suitable block is found, a warning message will be prompted
but the procedue continues to manage the next prm handler.
However, if the prm handler is actullay called without proper allocation,
it would result in a failure during error handling.

By using the correct memory types for runtime services,
Ensure that the PRM handler and the context are
properly mapped in the virtual address space during runtime,
preventing the paging request error.

[1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf

Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
Signed-off-by: KobaK <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
---
V2:
1. format the changelog and add more about error handling.
2. replace goto
V3: Warn if parts of handler are missed during va-pa translating.
---
 drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..a274636dfe8b 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -72,15 +72,17 @@ struct prm_module_info {
 	struct prm_handler_info handlers[] __counted_by(handler_count);
 };
 
-static u64 efi_pa_va_lookup(u64 pa)
+static u64 efi_pa_va_lookup(u64 pa, u32 type)
 {
 	efi_memory_desc_t *md;
 	u64 pa_offset = pa & ~PAGE_MASK;
 	u64 page = pa & PAGE_MASK;
 
 	for_each_efi_memory_desc(md) {
-		if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
+		if ((md->type == type) &&
+			(md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
 			return pa_offset + md->virt_addr + page - md->phys_addr;
+		}
 	}
 
 	return 0;
@@ -148,9 +150,18 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
-		th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
-		th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
-		th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
+		th->handler_addr =
+			(void *)efi_pa_va_lookup(handler_info->handler_address, EFI_RUNTIME_SERVICES_CODE);
+		th->static_data_buffer_addr =
+			efi_pa_va_lookup(handler_info->static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
+		th->acpi_param_buffer_addr =
+			efi_pa_va_lookup(handler_info->acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
+
+		if (!th->handler_addr || !th->static_data_buffer_addr || !th->acpi_param_buffer_addr)
+			pr_warn(
+				"Idx: %d, Parts of handler(GUID: %pUB) are missed, handler_addr %llx, data_addr %llx, param_addr %llx",
+				cur_handler, th->handler_addr,
+				th->static_data_buffer_addr, th->acpi_param_buffer_addr);
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
@@ -250,8 +261,16 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 
 		handler = find_prm_handler(&buffer->handler_guid);
 		module = find_prm_module(&buffer->handler_guid);
-		if (!handler || !module)
-			goto invalid_guid;
+		if (!handler || !module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			return AE_OK;
+		}
+
+		if (!handler->handler_addr || !handler->static_data_buffer_addr ||
+			!handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			return AE_OK;
+		}
 
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
@@ -274,8 +293,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	case PRM_CMD_START_TRANSACTION:
 
 		module = find_prm_module(&buffer->handler_guid);
-		if (!module)
-			goto invalid_guid;
+		if (!module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			return AE_OK;
+		}
 
 		if (module->updatable)
 			module->updatable = false;
@@ -286,8 +307,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	case PRM_CMD_END_TRANSACTION:
 
 		module = find_prm_module(&buffer->handler_guid);
-		if (!module)
-			goto invalid_guid;
+		if (!module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			return AE_OK;
+		}
 
 		if (module->updatable)
 			buffer->prm_status = UPDATE_UNLOCK_WITHOUT_LOCK;
@@ -302,10 +325,6 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	}
 
 	return AE_OK;
-
-invalid_guid:
-	buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
-	return AE_OK;
 }
 
 void __init init_prmt(void)
-- 
2.43.0


