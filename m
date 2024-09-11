Return-Path: <linux-acpi+bounces-8225-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B46974960
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 06:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F941C219A6
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 04:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13474C627;
	Wed, 11 Sep 2024 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MD9Sy72F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43F38DE5;
	Wed, 11 Sep 2024 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726030342; cv=fail; b=s7x6Q/wpEAnIag4Mpwz6PpVV0joqd5j9BC3c5G9pi4FiptUVIxVO5ipTbpLbtpDqu4Ry0yLF2JEPfZNwa/5Qx8njv+rzQBje5e3lr5xE6gjEwn5/ZECEQEYfcezutzl+LOSTpM24RcSRlNEbTuW2j8WnrzpdAkJfEMDbZyKCINY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726030342; c=relaxed/simple;
	bh=wxYBk+KZC0hxjbl/4LHK5bifyebODTEzbAzVlSrghog=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MYEicfZqUlGhphS42wi1sCKBloSk40+AQq7+KKiXXPTKPxJLnCI8S4VVnLwkVDfmKImkhPxlOZWMdQD22QqeuX9bI/IR+lL/Te6GQRl9Jdh7jLv3karYvtwyaG2PIUdGAQbBCrmyQxxI0966mC8ihP3uiUQBwTsd8TRjxYdPIFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MD9Sy72F; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5h9MZKdCwzoKk8EgWQ0AOq4kjtaBnp6mFmob49VCJDjJKGd7O8Y2To8RR7SvBZKmITjvLBfNfTQNjIipNQAEe1liYZkYF18HPSh9rX9n406JWQVgevdZf+0EE+Hh626MeVwFeJFSxUsYOsJGpVbfwoOUe6L5Qd09COpW3c7HF1VeuNMaUZboIvaGXHQmR0DfCIjc8q8KzL27KJQypBrLUIwPSk84mNquQ6DNgLZ1PHyR39ojmdTbIcmKpvXE1gXSiJ9ghKEmuT18k49Xmidle+23fLz6fZdWoeuvok/EK6nKYkWaS6Vlc5OVMyUOYOcNUCRYYQHH46KXcZAvRNgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R1528KKnRF9Mbs9/Pg2qQCCLuypnVnTFXx13w8Y5Vk=;
 b=WDjv+MimXxexHyNc5thwy7TZ1k3b6sVgVqT7KQuPB047dsJUUx46qK4McuOxXN3bOzL5o2UGi5ReyiLjdVRzaazfTKKqQwMRaNBfniB9bPvdqJgLKpGRNveZ3U6tzXL18FH4l5fE+7eR1rDdZbpStgbDYGKZ/0CXPm1Vs1tfwxLQv12Bl1D0ZNpaLdzsKUIPm4DOAKiGOIIOIDBskJ2S2EG2rFApPmMeYM07UPPKP1JWIh4MeXLnXuDrNEFHH8wBOoE3HR3XrwuiqK8xNnY2BKTWVYcRJVx1upWXkT90K14KZ1d/snXtPY4v3SApmap26RJ3q9TWhuzmwknDQMwYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R1528KKnRF9Mbs9/Pg2qQCCLuypnVnTFXx13w8Y5Vk=;
 b=MD9Sy72FE5BWKKz0Fa7yrlYOWTQEUYMyMTqV/dWdMS1/lKyhLSXMnbtQ4VMJDfOiolxR0ARqJ8VBB84UJzKQ4dtaemqwItrA3NW2cBcGPXjJRcq38xhdDZXsMkBqyBjvxL1Dgo8TIOklACGzPes2PR6D9XNBXcYt0aiA8ifXYlI0E64vMfscLlXte2UessU6XvZaWbtxc6/t6frETVKOPZWIkStNfGfRWtcBCYxLHL+dVgzm75+VsIQYRIAxEOyOAMLHCnwRBHvyVwrGZjbk0sIvAwI90bKzrrG9SafV0UOqyoIOUYhbrIxghYwedWNYsg6IRAa0tsIh0t5VL7Rz4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 04:52:17 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 04:52:17 +0000
From: KobaK <kobak@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V4] acpi/prmt: find block with specific type
Date: Wed, 11 Sep 2024 12:52:14 +0800
Message-ID: <20240911045214.930141-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f7079f-954e-4119-8a61-08dcd21d82e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cNXZVB3fwzgdn8QJPgb/N2M/ohSYb8rMjLm9Q7dPWWXYtnFYoC5PCi1ts76V?=
 =?us-ascii?Q?bxFzqzXyDpCO4xbin1Xr1kSc1SNqLUNslD2uP1/I+8kUW0sll66TRr4ywh9g?=
 =?us-ascii?Q?ljsjDUsSTsoF5zjbosiGdmd7Hr9Qwp63FIyyHpzK/s7gZOvtWgsQOHuLYJGH?=
 =?us-ascii?Q?hqUtwPCLp27yXCAOjV45RWV0tyEcTfHl1H1gLri71zY3SRKmq7EzKmraKJpR?=
 =?us-ascii?Q?HD0w00wxp7J3+SFMfwFFxzHN9fnj26/uyT5i0k268q6mDRuLAoWB+wkXSvYG?=
 =?us-ascii?Q?uToquzDGPZFkC+ZjHhVFjHgWDHT8mj2tcoTmkf8lNs3b6z2pNsK5aavx/wiS?=
 =?us-ascii?Q?88SQhJR+0k8jt75fTV6CqNmnUGgh7rhlAGX/baNA2NbVrn+l1dI0ovBftYIo?=
 =?us-ascii?Q?+t3uYgxp1lTp+O0NtzQNK0zudDmro731YY8Zx32SVJ74IMcRUXe65xGiGHiw?=
 =?us-ascii?Q?JRYISTrRQUisPHS5VUTb1Cj+cFgILmSat/te7W5uPzEq2cQl3DNkWaBotY36?=
 =?us-ascii?Q?DDBEVAlYrZT1ITNRDhTq6e5JtTpfRaw+3IHX1GXJT5dYFT9zUZqVg1UPxEAO?=
 =?us-ascii?Q?VRAK9A2ALu12zthGllME4Wqy2WP+H0JsC7HeWgz+m4DfRQdndBCzW9k8k9d/?=
 =?us-ascii?Q?h8dsT4B2vHpQzn6hmu28P2l4hgZYf9PLc3CaFdlS62OQMbQUC20KCStTLiu6?=
 =?us-ascii?Q?yxzTsTOrAQz41+D8ePFvN+4NFojKTHo1yAaBAiV05Gjb5qNAf96uqia70V9v?=
 =?us-ascii?Q?0sLxf4ydpYmgjNrAj5vBAsYHnp/D8pXcbyq1b17BRhl0zwt7m/qALmqbdSox?=
 =?us-ascii?Q?ZTlVXSUHDxlszvCwnAKhGfHLaN7ioYtJ5PYdH0F2+jBp/Oipp9LYHSXnyDiG?=
 =?us-ascii?Q?vUhdRf6E6baCGLOULChZ2CwQgsH/o5Pi6Az3C82ro/aM+DhJUxUNeKmdggQL?=
 =?us-ascii?Q?8NO52c3B30nJgXZ3ESfuZWt2pk6w59qxn/WBN+IeOONYXOiCgSWKVMqKP0rt?=
 =?us-ascii?Q?UX4aWDEsVldY70LVCMqO68kz1YssurATWoT7sxLyM4b6cRE4zWj32cuzE8em?=
 =?us-ascii?Q?Tj5X5ZY9o7/d2Y2++b4U6Jvk62cVXSYpZLJQzpy6rgnfjjk3iJ5vzJwY58ns?=
 =?us-ascii?Q?LUZh/lYFpDf9DAn+SQTXI0/LXMlERArvP0WsOg73VcXLDiKRF574jdpD8JAo?=
 =?us-ascii?Q?uRCMKLspfi72DABASfBkq/31Ec5k6Ow5xI28MUsACMnD1TTgn7C3yqhlbkRj?=
 =?us-ascii?Q?Z/0nhfXEUyEqSPlByvI0IJOOmu36MJhyVRy2HNJoFLV98XjMRTThQjHiwHW3?=
 =?us-ascii?Q?6xqQBHYbyRzd1cuQVH3jSFhlqmHi1Dj76LL0fPwfZRjaAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ylJoLJEaO0WNrQJ0SWWlt9sy/gyEe/HiyInHdQjcQvQTQgMBbSbxaEddk1o0?=
 =?us-ascii?Q?fToMmzAN7RqNNq6kymJ1VqxkfaCHCoK394UDupmBRThhpHR/XwS2XpLw7klS?=
 =?us-ascii?Q?PwN0ZOQFhGA9w5kM+/noVVIkb3LXHW5z1w0knjWGkAj8biH0qmOKoXUxLRqy?=
 =?us-ascii?Q?8WKiE9USZXzFd7elSH6mYxPVKYQTlAdDE4TImk7GxGqZ6j3+2rPD6QSX8457?=
 =?us-ascii?Q?axbR0YU1HqkQwDLZZzy9Cm7x9H6UYd5AFHVEkPjEWx4CcSCEO5/aX6PFFhfZ?=
 =?us-ascii?Q?ifl4hUVxRzhT12umuFm+KTSL8w73oUon38VHfWkrdZOaTuf83EqE3dkmKROL?=
 =?us-ascii?Q?4c85m4JBKoMrVPfVo4adzM/ILG/o3KD7A/DkhGPaRaWJXVUjqu8JgDkkPb/a?=
 =?us-ascii?Q?NZLcrWhMUJOeO457uN0+u7CBXfSnaJgizLVFUxbCbcOXZmslGNMohXRLWTsF?=
 =?us-ascii?Q?Pk4Lyjzxp+ETRFLkDV8UBbDjy91sSU2Kyk8aAml+Z/zVGEf/Hd/leM4qGVGG?=
 =?us-ascii?Q?rEFmWUHq2e1ig0p9TzSyCX96x1aSQDxJge2lMrKD1JE1EmMlpb6c9vP7nfh+?=
 =?us-ascii?Q?kSSHDmlmVdQU92krMJU4Dd3Im8RttiCzmWbeEp/8wvBA72GF9SX6X39RPQVQ?=
 =?us-ascii?Q?+K8YSH3K8M9QbRp36iY8hijFkW+N0Qzh+8GcyBHfsubCMnbyvXe3leLFpq/7?=
 =?us-ascii?Q?V0PWM5ipE0msdSTYZGevbU1KvuBC32EAONARD3KNJnybLK+m0lVwOAQCCnIO?=
 =?us-ascii?Q?i2GBUBhfZurbZ+uK3dY/P7VpreieBKMIjAHY1LX8tgwBMOZhoy0LATzdOh1e?=
 =?us-ascii?Q?lVRZL381mpx/yczRKLZH0shiu2wivPWpLatGnZdhv7Q6NTBxsw8RSh1nJTui?=
 =?us-ascii?Q?VxjzNPgpwBJrAznMtWihzVDMUxQntfTnhGH4GEIi84fTb5es4QEvT9ghQJ1X?=
 =?us-ascii?Q?JKufB+leTdVpPNLCisLdTc9cJB+//R3Ib5NnMCYBVho1VFVLm5VkG5oXFthJ?=
 =?us-ascii?Q?MLU6Hu8LHJrItrLgFTJdUeJohdZ3f3XOB7e7hYruQ2uTUB1MTXnIfRU/rU85?=
 =?us-ascii?Q?JlICyBTK2tZpmjcM0Lh84+9uBDFq7HjlHwdtJ+AG6vj+YtgzjaUJHPkR/aFK?=
 =?us-ascii?Q?7rxPM0ZFNgdvdSnTEkdUQewiGy7JWYRweBFcEiJjMyNAN+MNUSsCeP7Fx8kl?=
 =?us-ascii?Q?Xqcd7L4fC0x76bBRcrPSs+NNBAmUgejDetrKQJQTBN2ds9QmcLCHl6SpkLG5?=
 =?us-ascii?Q?qN5YsJ4VP5yDZBwqxYaRSspV+vubopyHN3f2MixPQC06jw2615a1AQ6LK2tU?=
 =?us-ascii?Q?DV/rUUY/Tae8zsQKwzFO3CqFgVaQUxBLKppdAMYsMvoor5CVjeGUMEzY+jC6?=
 =?us-ascii?Q?cujZSLk435hJAI+JUdi/qPIhx+Cy1NI5KRELo4vkUTqchkUROGewqWRUaO9K?=
 =?us-ascii?Q?srpgis4NRoXhcUXru3p5Sp3t5QskYo9kTN874rSJMVgTbDdlsrT47T6aA4MC?=
 =?us-ascii?Q?Yv3tvK7LqKHRQu7i24tF1HIWn3nhsklVorFQCUS6SsIljOeBoNZ0hU7xwrd4?=
 =?us-ascii?Q?i5CvpKxSdpm6kpU6nHLlMQoJROJQQyBc1vxdYQb5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f7079f-954e-4119-8a61-08dcd21d82e2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 04:52:17.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNOSVZqdQMRbtp6VWFQACVfexZDeh4i9S1tA+cHXkL4u1m9M8wuji9/FxUVq3cJX/AKwswnQd9qMR/9iKQlHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409071245.bkGWWtfQ-lkp@intel.com/
---
V2:
1. format the changelog and add more about error handling.
2. replace goto
V3: Warn if parts of handler are missed during va-pa translating.
V4: Fix the 0day 
---
 drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..029e8f9db53a 100644
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
+				"Idx: %llu, Parts of handler(GUID: %pUB) are missed, handler_addr %llx, data_addr %llx, param_addr %llx",
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


