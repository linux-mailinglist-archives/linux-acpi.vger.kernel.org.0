Return-Path: <linux-acpi+bounces-7174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D149440D5
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354351C23C29
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B934514D2BE;
	Thu,  1 Aug 2024 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQb8a+/I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8F647;
	Thu,  1 Aug 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476943; cv=fail; b=G0WFY8jyqrPSf45/mX5qyv1OrRvodD0jiqsxAtad0+HyZbO74nOkXzIu4oNhp9dDHI8N9n4m7+m9Fc2IAWGRNYV9JVwjsOoYrg6WnR6HPEPLHRPR+g+1fnqU6B/ef5tEMIWXHILoC3D0R1wqNKKVRlPUUSserimHoOanf+S/0Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476943; c=relaxed/simple;
	bh=VhkFT1EJt6QfyZZcQWVwhG4vc7I45kyuSLCFgkPBU7k=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gBsJKFyuLdhYjVAGBsqefCnH/CYuf2uPz5yaLseuI3Y3fqo3C/sAUtxHZ2Ruy3374osjcBZ6TxBK08md4xsGZCY6JZdQ46pkay9J9OFEAvfqqv048XT/NMlUFtYTfUUmqfKYljiwpSOwt5MMt3gBC3akKciKEBeySRqB+XNENbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cQb8a+/I; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5kkwZ4OiVRchRQ0wWuGsnnZK0QLohzOf6KT8ZXKAVXGLcFzwiCDCObg/TEzrVEx1SYcE6XjiisiYmx6lwnauSjQCpa6EpArfM5yMlhKfTkYOCy9niLfi40wzrjPRTwibdysxMNHRMa88is4hM09ZJcXKi2zPgAZewiarFSm/e4qpO1QYqC/NzRma5OOYbsvcp/ZXP7jpWwUqwhYr8u8NmLMy8uZj29S321XBht3gEp3iDHSVbSMI6k5wrEUK9fretP4MBpLUznM2T0K3hK3IIWjFyIPEK18RB7MXPhVRvxkEE8wbK4KsKPcCRXg5x51p1u935FG0jQXUxq+AoYUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MntY58tP9baUgYtSyJbxaf1NNbeY933BdXMVRd7Msdw=;
 b=Ha0UkYk7nAkVTLADdaijm95/N/p1RKMFwr8LCf/wKGfTtRAzHwT3K2g179OzsyEpNvu9KCltEzgN+zuASd7kPCUZrvEldB9j5pMYTgTPe7ZuAW4HdnFnaOZrlL4K+OK5Gt0TegoucbUgM4h1pOagkP4zZSwA62ELG2KkkFdDjLjb6STresTH+An5dmduqXJrFy9ng/DoLRFqvnFyhUW27H0EGLPZCJfyZppiktV3aEJJLJXuUHH3DfhD/ZlKScywHvOi0hKu3RDuijr96dJJAgTNi/8CdCE6Y0E2Sw+fGUgYcINLbxvMt5gZ/YUaCSBgvEYVwm43REzw/5ik86J9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MntY58tP9baUgYtSyJbxaf1NNbeY933BdXMVRd7Msdw=;
 b=cQb8a+/IKxjOWoCaSMJLrUM1oBebQCfbwyTrfkGg6MQEwTWtD7KcbaPDBsAJbcmLmS7uGJ5cVXOzG5Sq62Q/23e+uOD6TOAxCQ/c2kjvOkxY271OpyONtk5kXUoYC/VDVHfSguWmjTkd6VsIGjwhPmDJs5CctGFH2/oBR2jEAfnT9rhF+7BKh2HoXEa6XeOMS6D0Y4ze9hsaybPVmNkih42vip5iQ6z73O3IJz5wlftBpG/C9Wf7rKxYQ8peXBwdZp7GxOY54jZ9DK3ykXQQdxz1fYLSlGZ7UyXMspjW2Dlf2aKVp7CQwmn08XJLpuHoHbJp3K0pJG4xSxdytVs0IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 01:48:57 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::4c1b:f50a:3b29:bf72]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::4c1b:f50a:3b29:bf72%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 01:48:57 +0000
From: KobaK <kobak@nvidia.com>
To: Erik Kaneda <erik.kaneda@intel.com>,
	Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/prmt: find block with specific type
Date: Thu,  1 Aug 2024 09:48:53 +0800
Message-ID: <20240801014853.1594699-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bbd5b5-a5bc-4a35-67c8-08dcb1cc1b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gPCwdnMhhUaHOS9Ws3Md1IJi2xLHfKdI9aTeawKPksWcLPoewUlY5AvwtPJ4?=
 =?us-ascii?Q?7Is+DwQv4AS8wY0Z35/EHgAeQygnISOoyENMqlfodMxko1Gx00SY7kubZnOO?=
 =?us-ascii?Q?7K+Kbt/RJ5/7d6KdJfed8yz3fpoUHrjxfpimz39FDV4IClvnykA1FIgdLT3/?=
 =?us-ascii?Q?/Mgz3GM5TTLws5x+rhjv9u3X5MEPdCbaai7M7czUUXxx69D+Xo+6JIxHAEXL?=
 =?us-ascii?Q?xi6n0C3pJFKpye1F9pQM/a6DjfAFC2xGEnlQ+IvoVSJVgDHnRaaD87MwK5sg?=
 =?us-ascii?Q?oOTn16oKmZgrpdggnEQEddskS0XROFgDsUdsw5V/JQtVJYROk5g04qJ9HstM?=
 =?us-ascii?Q?5rttYb/LBhGmuIdVBQh/vEbbuD1jADVS6B6REsqkhEDeM+uokYAXu4IYTyzN?=
 =?us-ascii?Q?sXRVWyoHHbDMDd/NG++q4e7B6i9/4fBeJCIZ/gXQSXyQtnBJPWp8jDGHA9O7?=
 =?us-ascii?Q?j+bm77ydPAxsXk/gFjUt8Elpl2/DjIlu387EGfTxq3rpOaYRTKjaBgX2h1wX?=
 =?us-ascii?Q?7lXKmbnAwkPZXHD1NgBVC43rIS/PH67wh7tZjRzlHeHzhDYafXe7ajFTeYmD?=
 =?us-ascii?Q?A0x8/JvFrEQ9utphf94Loot5HFE7mKTMu7GCmHDmKBAp9B/qHW25umuRkrCZ?=
 =?us-ascii?Q?bvJV0Xxu20Ub7Nml3s1Dte3HygGcMRavlowk0Zhy6/5EDZdvz053kjf3k6bs?=
 =?us-ascii?Q?Ocw24L9FHxodAB/TvUJ+tOsOXRG6SfmmLYiY/uhdXstpM+LhxqXq+8ldNbvA?=
 =?us-ascii?Q?E6HBLpFHsNSeZVnCsoEKjDlJQqZUBEa07M2BaQgE6tUHx+26ziA/RuoGL79h?=
 =?us-ascii?Q?n9rN2d7hwTM7K+Jkenlk93HEL2lXJtNXl9EDdVxHcpwMBkkWp1cctIvS/6kz?=
 =?us-ascii?Q?AnRzG2NQAsulfYci8wY35x0zYFuiZaIfPezwOBzWANCQfENKT4crEuLVL3ws?=
 =?us-ascii?Q?A82gs7RkJDYXSOmTl9eDYKzlnJEVQLEeQrrI9ZOxt8unNaD9XP7YWaR6Pvki?=
 =?us-ascii?Q?T/uAwHQWlq8HaJXbjKK/Olv/flT0mcvJoJVGvwXMCM29nNn2ID3uuTSFR55C?=
 =?us-ascii?Q?hpDAj/ogDctSPZPywaiV0BwzdqHKdsxItDP9pXmC4kTAjWY1VnimlqBsEQU3?=
 =?us-ascii?Q?Ubbv6yWqxk2eOXEcPFa+/evIXjdvi5HjgjT2xwyls5E0R3ArC0pX22OUBsfk?=
 =?us-ascii?Q?mFWaQfnzIPcDc2Tc3jQ4DhD9mlq3quGXVwTeHE5vBrICVkrzbCYVS266Biju?=
 =?us-ascii?Q?/EQIQ4o27aPLC7wqaYQKRGjGfKO++bTsBXp5GNpHj8GZqgw4TaujyujMg/f6?=
 =?us-ascii?Q?O7r6463EuK+O47UkXSmOQl47IEg0w0cjXwDP3My6prHZvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMz+IRfQjwJQL8QzGrfXKwcKNDo9LqM9UdCAPH43CjNwioCRwDLUNB+gSfO2?=
 =?us-ascii?Q?jsCQOj6qoQ79E9STg2gwc9YdP0c40civ+hBzbW3r0EO0k8Sf3ppB+GC0TS/R?=
 =?us-ascii?Q?4Et/f8oSsCrofWi1IrdWlzUFmd6c3wiJGHfTSkTSnQUV0igYNQrLv7Io8jYy?=
 =?us-ascii?Q?3EBWhHHjxIEsu4CbZG3Qn5XDd1Jrwc8QnMSAsxJV1MpPQ5o5xxNU0e7MkNcx?=
 =?us-ascii?Q?IVuW2a2ylf5B1bhREbmcXZuz7XWooTognSsyi9JNIn9GaNi7YOlrLdTMhVIz?=
 =?us-ascii?Q?FhWalvNis37OIhVJ8xKk3oKWMosf7qTRlXnhyX+bMjaZcpPotCgSUF0iOp6O?=
 =?us-ascii?Q?suqCa354JyKZN4UWet7iS0ERJR191QERFUp/W+U91DjS54dzKQ0tT3VGpOEV?=
 =?us-ascii?Q?whefAwMPHcLzVY57npEmUxGj25J6ygI21/OfNx9RtcQYkSovN9DnmYaOxw/e?=
 =?us-ascii?Q?qooD5kOV02KxLWoZVeufGr0Xynup6frVUN8+IZGHBXAMjJQ2qX9I9I9zBcPR?=
 =?us-ascii?Q?/RVThs8rA7lOqmT/BvfZHB8uqivnc7sqNdgatG4Pg/WiDXKFp+rHKCpWEHXx?=
 =?us-ascii?Q?j7mFC//vqrYmuD37E8xQ98J9ImrU6MXKbhMLNEeuzUpPTH/GwEGUiUz7UHJc?=
 =?us-ascii?Q?XRwF7GD3ckH8cUUh6+KnJwcDK4rIcPMTyVW3hTpL8+b/CGSEC3kcwzJnYdV6?=
 =?us-ascii?Q?4n3I+83J2QG6ts4cqmHg87r1WQFt3w2HwmLwb7OESpEYzmJr/mA2MGv99Yaz?=
 =?us-ascii?Q?C83YA7QyBA4geoXzU/OSAO8dOPpOt0uCWgerT+oouc3SNjRQD3yhv1PkaCsQ?=
 =?us-ascii?Q?228BOElSGIQG5NNShMBANF0XrvUy2XFzv8tkuOVNOD8DqTK2IH+2RiUV10ke?=
 =?us-ascii?Q?GnhkVcjTZZXx7rmO+noraZD5rEwfEt+NLIWZpXAP13dgnvIAu8IAQ4mWccOd?=
 =?us-ascii?Q?zN3H5Utre0q7uouqYB7vTQ5kKUX3gQw1B/hPLEurW1E5x+5lCYjgln4C4rvW?=
 =?us-ascii?Q?4VPMfjPviZzpx+A8i98T4aBml4aeHZOyVA4Hbfe+bV3KfEo5irGcbEXiNWnM?=
 =?us-ascii?Q?npPuCHwW+wnmibJwMuE+kS/bJcylmSj11ET7jEIA4ECATuGSkO56gNT0Hh+b?=
 =?us-ascii?Q?J/WoJTZW94sxBYMDwREY+2px6BepyqVuhoFEucDfQoqA0JqCoOdZFmYPls0E?=
 =?us-ascii?Q?zMvXUEOoNQRhI7TdXo81JTNdevKAglFl069LSHgR/n+4b7/dSOvZCGGjQ7ZN?=
 =?us-ascii?Q?PmWTXj/5d/74H3mRWsXve52Fh8o3KxMfztR3iajJ01zsrqTAmdnnqCcA6sSY?=
 =?us-ascii?Q?HrvzynlDMpER65eJh/OJHKXDVrjpLd2hP5Et67a6BhUiRN0yK+tvNhVLKjcK?=
 =?us-ascii?Q?aGSeEfWUO83JFWYXvDvB5ZoXwYPS12RG4cBHBpG5+iY/bUAgG5GkSDLBJ1aA?=
 =?us-ascii?Q?fVSop3ptObyCs6zqzlNo8fLmOGiOer940qkh005GcZ8WZ8J/XxAI4mDMni91?=
 =?us-ascii?Q?RJghcfR3dK/v/ehGZef5V3dw6YEfkiAa2s8vZQlCam73RpLfxymgOTGxjxTp?=
 =?us-ascii?Q?s4MAIwJaglBPj2xZLhwJU0lecDrDad2GVZNTB5Dq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bbd5b5-a5bc-4a35-67c8-08dcb1cc1b8e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 01:48:57.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfbmNuCsroz3WO8AbC4IYBde+xk7ab1fVhzb86FmHxj3mXLcoXUEdRI3BEu01ep8JJchb1pDvS2Nahnp+vU1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

PRMT needs to find the correct type of block to
translate the PA-VA mapping for EFI runtime services.

The issue arises because the PRMT is finding a block of type EFI_CONVENTIONAL_MEMORY,
which is not appropriate for runtime services as described in Section 2.2.2 (Runtime
Services) of the UEFI Specification [1]. Since the PRM handler is a type of runtime
service, this causes an exception when the PRM handler is called.

    [Firmware Bug]: Unable to handle paging request in EFI runtime service
    WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341 __efi_queue_work+0x11c/0x170
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
prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler.
prmt find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
By using the correct memory types for runtime services,
we can ensure that the PRM handler and
its context are properly mapped in the virtual address space during runtime,
preventing the paging request error.

[1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf

Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
Signed-off-by: KobaK <kobak@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
---
 drivers/acpi/prmt.c | 46 ++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..e2f0bdd81013 100644
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
 
+	pr_err("PRM: Failed to find a block for pa: %lx type %u\n", pa, type);
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
@@ -250,8 +257,16 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 
 		handler = find_prm_handler(&buffer->handler_guid);
 		module = find_prm_module(&buffer->handler_guid);
-		if (!handler || !module)
-			goto invalid_guid;
+		if (!handler || !module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			goto error;
+		}
+
+		if (!handler->handler_addr || !handler->static_data_buffer_addr ||
+			!handler->acpi_param_buffer_addr) {
+			buffer->prm_status = PRM_HANDLER_ERROR;
+			goto error;
+		}
 
 		ACPI_COPY_NAMESEG(context.signature, "PRMC");
 		context.revision = 0x0;
@@ -274,8 +289,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	case PRM_CMD_START_TRANSACTION:
 
 		module = find_prm_module(&buffer->handler_guid);
-		if (!module)
-			goto invalid_guid;
+		if (!module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			goto error;
+		}
 
 		if (module->updatable)
 			module->updatable = false;
@@ -286,8 +303,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	case PRM_CMD_END_TRANSACTION:
 
 		module = find_prm_module(&buffer->handler_guid);
-		if (!module)
-			goto invalid_guid;
+		if (!module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			goto error;
+		}
 
 		if (module->updatable)
 			buffer->prm_status = UPDATE_UNLOCK_WITHOUT_LOCK;
@@ -301,10 +320,7 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 		break;
 	}
 
-	return AE_OK;
-
-invalid_guid:
-	buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+error:
 	return AE_OK;
 }
 
-- 
2.43.0


