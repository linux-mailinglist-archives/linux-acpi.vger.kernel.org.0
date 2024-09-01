Return-Path: <linux-acpi+bounces-8058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC549677B3
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 18:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794951F217FC
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3D17F394;
	Sun,  1 Sep 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cmrqJPg7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8DA2C1B4;
	Sun,  1 Sep 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207786; cv=fail; b=RQsAft3Umi17KdWGxYnt9iibJRtKMO3FrZr1B6K0v1O2fBIIDucdvEl+/qHCcy2IJ3AMfOx4ZuUcQiVvy+NWbClxIqVfpQdPznLUcqqlKo84tZK/LN55w/mc6qCSMghqTTlkPa4UN3OD19vBT3KYw+LGZoy3I0aysut1wHwyzX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207786; c=relaxed/simple;
	bh=fLAby7DkbAvOMTfINB6XN9lQFAjrtQLDpgsiiccTq4M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AIjxcekIm0CNe/OQWevgVqq5wKAMAXV9xa0iLl3R2ZpPGCtHEbYJk9s9bgDF1o6ofpophKTEKzHCn/JpczyGBCEJtJuAa06aw+JCZiaIfPyuCdZMya49YArK17bvO3zvss8OIOF9xJpfJVXtusZHtGKaW/uB3YF98IgdYc8KOoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cmrqJPg7; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIv2zlSamerf/0ZbSFPxTOPhiip6f22yUPam5kpzTkc8BY8kVWF4C4AydCDlrd7Te+ACRtchVkteO6VWXpFaBvyqI7JrQnJ0iJkLN/sS+twtwrZa3lUcnrY+0TCjjoSk4FvK2RR2Z2povzIL9dhG1OjqZ3LnJUa5Cy/BZ4AovnHuerGcj+8115hjo8e10JITqT6u6nxb1ZNsvCB0NhlmslS5WfLu+jE5M8APUll4279AhhSm9GBC+6Iz+PjHJJVl2DXKMJCp46jCBrAjAbsjRdmuCLkLj/3Csj15CcxsNWKzNrf2XaDJbtk7+DmYL7y/Km9cSkEgW5uQ69wuZwJy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0i5QnWWKKIj63t7iK5Y1kYaqkV4W10i8RoNaVlCc6Q=;
 b=EojdKv05A2ou0V31m9GvdbqHTUoql+cLTNx+U2OQxUpHO3WULXgCVu3dJ8qI3laGXTfWyDH3CxeFuXl66sWKO5PdCzJTK0SFGq47MxO245PosxA2lDXH/5VmHMZOijBInTKguYxhD8Rk+PQSRy+KtnqZLN80+8CjmIII+K6+hAdEfjCCS0Y6goeeFT2ei0neppwCC2SHg023LACJSjwmIvyCGAQfGlCLxonzV9IDRH/O/JndvHrMZ3HUavaMhv2bBBOjKbP/rJSZex4/jdUQZDMTPHRlOe0m8K+Gq+Jt+q/tO4v307OK21jo1Avy6UF0Xhbt+FhTVVY2gEy5vsrmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0i5QnWWKKIj63t7iK5Y1kYaqkV4W10i8RoNaVlCc6Q=;
 b=cmrqJPg76X4cMg4efwzPMMRuwvadMeI28FNA4YSkBG/v8iFGn+uj518mNNCnYrIUt95UbFmpV1bP77K5Dnozd/HZIgeCje2uFYKlYlCKwjxuthTVmerpno7lm6116Cmpk6j3+QMC2b7o2MjojKYgSPi7WkJuX69dja+TLegHRLa1kHO3/nDLqcfhnYuhjIrnK5tGF0svJEf3BsnE7v0pW02vlAP4uI8y/ZVcKQsiRzchVYZ63MAma75r5x5pOjkWo8rITOHGkAkkSwceWFO6TilmKihGcGlxveUvZppE+jhh4XoA3JujToO3PTdbuxz6sPuJyyil0/hiQOZcd1+m5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Sun, 1 Sep
 2024 16:22:59 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.024; Sun, 1 Sep 2024
 16:22:58 +0000
From: KobaK <kobak@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2] acpi/prmt: find block with specific type
Date: Mon,  2 Sep 2024 00:22:55 +0800
Message-ID: <20240901162255.1302358-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: a7725ce5-282d-4cd6-b872-08dccaa257be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yR2HzH5iZagfTSrxUAzdJxkDZhGsSK7OHzqURbHD9szyee3LIN64qubJlIKn?=
 =?us-ascii?Q?pWUWvgCkcjS7B+y+FhvDlW5XnZoudzfXmWnVLtJOIxU8d13BJlHDMz0KL8gw?=
 =?us-ascii?Q?vGvnK080jVgn1ZN+medyDQEF2WlyUscXskT+4khMVHdSlbrTL94GHMM6dSlE?=
 =?us-ascii?Q?Avm6UMZq/dUGcP0FocNhOtGxoIwwbEEioBqsZ3ujuFiCnGkUvPz7OuxEHIbK?=
 =?us-ascii?Q?8sxFqGfZeqCbfVBWNaMXEJehljY0nzfPjoBVy6HaCLEV+UVtdmj6E5LH3jrD?=
 =?us-ascii?Q?l1K7wfW6de2vxHhMYupmyt5heQgiQ94jagRPcubEQH1hAJE6vqvUBmsCsrKN?=
 =?us-ascii?Q?MK1h/p1FIDm5P69OJZPNQytPqMNACzC2G3XfI+FJ7g7mdbLFqXID2n0LEfpR?=
 =?us-ascii?Q?sIcSGec9fbswpgGtM7tklinQfgVL35YZyHhc5ZRX89uIkONZrqkhsZg/sdRz?=
 =?us-ascii?Q?8cd/L9uWlZ6rY+HJjmcS9Dvl/ellmIhZQBBK+QVL+8RSi4ys302acqKq6hPH?=
 =?us-ascii?Q?B0h7b1TCCbi6j/v73YihfWZghepOyQX1xCKwv6vgzau1fnZErJ11bxH6U2l6?=
 =?us-ascii?Q?842C8yRNG5LtGyWnsUbOvEhCUqtV/PpWz6vnmOAFWACQr3WYQ/nN0NE08H22?=
 =?us-ascii?Q?v6evyy6PVr6jo5CTP9yHe9txjvWG7KSIRkmPzh2KHfu6nwGg/VNpAHInyMwF?=
 =?us-ascii?Q?y04zC7el4LeY0EJHXFWaDLBG5aMj6sv/Vtn/azIa+PKI6BmkFgI049uKjKzb?=
 =?us-ascii?Q?dD6c+47lfW/qWXhcLAGtbGtNJ5YRjlnNIhApyPdTe6QlEKNceI09fRtiPJaP?=
 =?us-ascii?Q?Qane4vQQJRvWNmTeHVlVVvrbYB6N9PSE1sOPVD800R3tcmFpjK1f4c37Gkrp?=
 =?us-ascii?Q?txxYxjPxOjtAuqIV6tKog0op4DLXykHECBSSnPH/u51YabYy/kTrNOW28MxW?=
 =?us-ascii?Q?Ow8UnSmuhBRcNRmC0OnZCt1W1xiebBUaeUDtdXw7cX2M+Mt27yjCwSUSG4BQ?=
 =?us-ascii?Q?X3HOzO3uZk6YXHkKATnFxQk6Xl+hiDaQs+W8A4tr8y4qJSsdsUXSu8I1Kc0V?=
 =?us-ascii?Q?o2AhEtZttJm9cwxsijZKdHCvbuKXTbtMx8HgvFHfbtL7sySPT7k6wLn3fGd3?=
 =?us-ascii?Q?DYXV/UH83XZOsi0cC22aDrT+X0b4PTrCkeINkSINcG6zid/oYaMPMhdIoeer?=
 =?us-ascii?Q?DhXL85kpmAah1fzO65qgyf0Z71DoyrD65+Pv8mziy4ERa74GaJu//zbRVoIV?=
 =?us-ascii?Q?WSoS3FzRWO7oEyhjKcv3renUZwC586KPwXfvk0b6gqde30zYG260BW6B9blU?=
 =?us-ascii?Q?5UwoPZ/O7g6O4Gg8ApnJnxsnecrnSi67S90iyLITfn3QmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uca+F57HpzAiN/Y0KmXpoirQ07AqwCHrBg87W3LDWhokClNQm3QBLE7SjpI?=
 =?us-ascii?Q?D3zUBmIgVF3KlEKPBfXVx9Q/gClgCgWdLbHHK296p4ZjXXDvbD3PHAZXlxRc?=
 =?us-ascii?Q?/dIzbhfOLCfB545xQIStoSaeuJlEHJNJz1YTlmYhfErmQZ7gjdC14Keg/RaA?=
 =?us-ascii?Q?jzJdc4MZUNjbd/jcQXZblxiehGxqy9ptX8JxXHk0mVSZQiedS9DFhsaCr6OC?=
 =?us-ascii?Q?2DZsCc86jZaI4Cj3BfPfYoISprEG8xIWfP/ed/hxjdH3R8DwqGT3zuHcxx5d?=
 =?us-ascii?Q?xZ6+VEcgsvex6xeHRlaLBRxcTCCVE6xPWAbG/9Wqjv79WqFwch6DY1uPZ1Zr?=
 =?us-ascii?Q?uwPYhVrQp3DpbKZ1uj3299lY0iUL6LH2S7FMHwzIIJ3Uvzws0KauWtLX/uOe?=
 =?us-ascii?Q?HISKAqoGGv6u64mDs5giME56f5Sc1Vw2ZF/SlsZ27B+r9/QWBEu/L88kVdbg?=
 =?us-ascii?Q?/EDi3hMO8C89BZ15yYBEpa/4d47W+lqHL9GjnTVy66v0rVxRhpUmArjxKk5U?=
 =?us-ascii?Q?+ynp8NnWjfaDpshuECes4u4CmXMyLDg1+DDhhaQqZAAKgwopwKFlynhoie8g?=
 =?us-ascii?Q?C/ehQ+a+qd1wSM1G2EE7yJAW5IzaAL/Pb4Gd9e3O1WsjGhMp4PvTykPUpuUP?=
 =?us-ascii?Q?T5ybsbsoEo2Ncla0m1YdOmTC3x4HRfPhLuck9AqUueLQ20WR0a38Dia2ivJ7?=
 =?us-ascii?Q?ZJ5uDqRpinA3wL18SiU/8058SggGQOCD4FdOeBJ1AJZHVAKDPNzs8z356DII?=
 =?us-ascii?Q?t1+7Tp8AO8LnggA7NcnzS3fKirfziUe3rFz1do9/wZ458Co5CGRHsGoZmpYZ?=
 =?us-ascii?Q?u73UVi8GQs2XxNNw7W/A9gmgzQLhqJwvXPWikUQsxQNKnMXjPcXNeDuoIwCG?=
 =?us-ascii?Q?UI3Wm5nZ9OyZCeJNeIv37qCLRCimZrIZJhstv8Mz172eZ87PXwJsrUkeoPMu?=
 =?us-ascii?Q?LVS5TbvLUv5wzx95MrcnDoFCvV4tEC8FleehWOgxJoMSEhZOGiV8/tWxGBaQ?=
 =?us-ascii?Q?9cZMPxodqRnASjHmM4dQoBz7vWAr5+2Eu+jGoWbqTbSk19bE3l56DWg/jWgb?=
 =?us-ascii?Q?jAOMh0wrbE0fHrcOtQfC9StdenQlL0tJcVNrCtjwUdO42xiVcwOCL1oOvpNr?=
 =?us-ascii?Q?8IaJqafE0TfojhHBZMyG0hWGterNr5Hwn64b9Z7wEgVFMpk0T9s7Ku/hhCZC?=
 =?us-ascii?Q?F/HSC8xaYsLK8VrETtfId75s594Io8ubZZkjAhxO4yr0Arm4KJNGAR4SVWHf?=
 =?us-ascii?Q?ulZp6E1fyET5fYoPU8LSvCfUvNrg4OG/K6lyJDlahwCLghFyrJGL+MUXHNrj?=
 =?us-ascii?Q?qLukLQ6PdTIEz0cyuWHLhuULfHIdSbHicEtREsPunomSu1XgPK+WbU2ZRmhP?=
 =?us-ascii?Q?6VoeTCrMaWbn6rJLbDI20KHUd0FJvBqkXnCJT19plgM0HkyejR2YWEUtkpYS?=
 =?us-ascii?Q?y4nXCQjd7bxvop/NZK9p7whX3MaMxSl9aw0CxgyXIGrN4RDQphCukWzgKTzD?=
 =?us-ascii?Q?9P9bFABJT+15gwkLzMsP7l2M0m5ZNe484FRta577wZ1qm+V2+0iGtFbYuloU?=
 =?us-ascii?Q?bjxIHaDUMU1rbMtukUTFZ3sAgZYin6XCQsdkzNvY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7725ce5-282d-4cd6-b872-08dccaa257be
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 16:22:58.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtSSZiKF0YNPAwzbFiE34U+b/WXGFESmh1KfucwgjaGbWnWGNgwRibE+hywJTFKczvsr14JxYAC64/snkzazPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

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
---
 drivers/acpi/prmt.c | 47 ++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..281cdb53eddb 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -72,17 +72,21 @@ struct prm_module_info {
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
 
+	pr_warn("PRM: Failed to find a VA block for pa: %lx type %u\n", pa, type);
+
 	return 0;
 }
 
@@ -148,9 +152,12 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
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
 	} while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
 
 	return 0;
@@ -250,8 +257,18 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 
 		handler = find_prm_handler(&buffer->handler_guid);
 		module = find_prm_module(&buffer->handler_guid);
-		if (!handler || !module)
-			goto invalid_guid;
+		if (!handler || !module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			pr_err("PRM: PRM Handler GUID is not found\n");
+			return AE_OK;
+		}
+
+		if (!handler->handler_addr || !handler->static_data_buffer_addr ||
+			!handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			pr_err("PRM: PRM Handler not found\n");
+			return AE_OK;
+		}
 
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
@@ -274,8 +291,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
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
@@ -286,8 +305,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
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
@@ -302,10 +323,6 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
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


