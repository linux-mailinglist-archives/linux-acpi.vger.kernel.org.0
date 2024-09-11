Return-Path: <linux-acpi+bounces-8248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BA9757DB
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E0BB22FAE
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2024 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B219CC24;
	Wed, 11 Sep 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTsO4iRI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826783E479;
	Wed, 11 Sep 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070147; cv=fail; b=JRaczdd1q1iPhd46zuzBdw8sI4zs0lPpcPoCGQi5JELh/ED9oPHZiDKPHTi6nire7nAmL/VxXQbl3O4pTnzuUnK4pgRrIBxwE2IJXsT/RQzfxWn9Ck1vEc1ltcIBQpMe4WLP4hd9DJi+Kz4K3ZEuBilpi+IwIwcNm3O8xELuDn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070147; c=relaxed/simple;
	bh=92tEq0JoWbd2HJKIktZnhMRIvO9azk3lOH6zZHUC08Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L+WOOjPUIdxyS6t2RQg9nIYK6+jIjPdPl6IXdGE6GX5y3MZ9ztrKZlYl4IrWjOhWI/wRgkB9KvRT2D+rOCk/h/IkZRK+0eKe8c6vMODk4nRy1sFAGZc9KBsWUatNL4VG8eiJG0gFyEuD6+UdxJQkEMu1V5aIjmb/0FXFbLa0Ezg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTsO4iRI; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjS3TElegacB7izjh1MwXF9ybvNneHSG3JCY7OVd0WCqX/ZJPyKevFLkSysC8dPZ9anSlyRzqRrBeQ1l+pZAwPMvkbzHolSYLZir+bIZilkiB8HwrrgzsHfeB8d/PjnwWgrCzaZFjbw17fI9LszWebSKNKd7mpmbdhnifLcp8PaJCMLKGCbaISF2tqZcabFS/dDCwmMOKsRHFIqjuq0S7YtEbIDnJWnlZwLW5FWQclymmiyzm/sVO70vh4OBPsayM4zMaDxknx0QrrpemQyJ2jrPvgDLhgw/7/jezmIK6t9P6Q5TCD+pQukWTOBmwZuN8x0Y18YBrwTUgCWp0GARTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9HXpSoz/mXwSfPk2Oa3SypMZPm6cFqdnerBic4dLkM=;
 b=Va6ADIAXZK/CpAtcbpW+ewLOO26YOh802RqEldFNdN7VwPfcqH9nlQE36SyLquRKWS7SmydeAMzup3YrUzZuNo6K4J9HnMAN+/oQjycNbt56X3SwnTKZ6d+xGPGrapgSG8VKiCrhNbavmb8nulHGtiAH7az44gTuK6rUsweHrzAAsAbbvtHWNLnAjv8sBUiIEuUirM43DQWeMu5UYQGnOl+8aVYloByeV1S1sQ53HcXHkLiT05/ibSzFRq2GIOf5hV/kyGfeWk9eah1kJ64UlVQWdBHiqzViE0RLcdPWtAH4TG7QIIJhhKlTR0xs9rmhPg1oI34IziObEbvvT+SJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9HXpSoz/mXwSfPk2Oa3SypMZPm6cFqdnerBic4dLkM=;
 b=WTsO4iRIXBsCZFnbLKAG0104u4/b3kGMZ82ZRHMDjePEhv3OhZZVUaal5aGmqUnQmIHetrh7TFPXwiPqwYHca5C15qiQrbpeZeZqAGjY9aaMNhF5ROifl151tUoqNvlHIeEBuZ3hp5hSuA6KChtMQ0Phmnjt/gPbpxzp7pjzEsrGHSpjLjdBgalbCHjpPx+3LX8dlBXI61TbdiLtien542ySJyAeQbmCRuyW/OR9IGYPeTVFFwXnN5EMRcGX3yyq6fUTrPX0FZlAiytOlc1SSAAlCRh02/skzBYShlqt55tTI84oxlmaTxAq6NoIE9XczgklM4lyqxc5/5cFDLCKhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 15:55:42 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 15:55:40 +0000
From: KobaK <kobak@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V5] acpi/prmt: find block with specific type
Date: Wed, 11 Sep 2024 23:55:36 +0800
Message-ID: <20240911155536.3900579-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: e51d4cc9-aed6-41cc-d64c-08dcd27a2f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYHXtClJvNJ5s81sy380EFSia+DlEmDC7f5mq+TWReYi3dFYJxLLUidQD3ul?=
 =?us-ascii?Q?uZyyKfofmiC3BVJzW5j9lVewo32clOy1Zig61CREbhKMsNGZuXDvEKI9Z6ho?=
 =?us-ascii?Q?jv4ys7RNIRfv6GTQtXBihiQ0OsdIQOORsbzfpX9UsGJ+01bRa12qHmYl0fTd?=
 =?us-ascii?Q?F5FlLa3uLxIrB2zOFzxytCHsBdhLS7MOhoouCazNhkd/rjXKADa7K3HwZfMs?=
 =?us-ascii?Q?vMHD4uPVYlg/8b/4mXa2e/FDtwx9gDCZSO5FGwJeTDr1/YrMz+e2taoowFj9?=
 =?us-ascii?Q?cKaKMIkHcJIXzS9do573gFNQOtMdzY8Xk5CAArSYfEabNtYdyUoypVrdU+Wy?=
 =?us-ascii?Q?KohE9rccvtGn8WwdLo4C2mlqBTweNTmhx/fFf7dmNXRahFJjKyHRLIJ/pI1d?=
 =?us-ascii?Q?0F8Ns7zO6p1SXR8RPhKM7zYT8y4W5ytWvFlcYhClcTEnJFdCeCZ88E4QGqTD?=
 =?us-ascii?Q?Ro1Nx53iQwNygny4syIMnmmX8ZuRZ7qAwSe0ghIQLnHoHq6ZgdSLVrg2B/Cz?=
 =?us-ascii?Q?12c1ciiWrCYk7sp3ilmYyNKgiyxewM9SAAttXkf5I8WDWauScsLw065AbO7d?=
 =?us-ascii?Q?+Oj2CKrdXsM0KGMwKy1b7AC/K9fpz/pXkeLFihohzIFmx6uMMGQRpUFXC6ya?=
 =?us-ascii?Q?Gmhnv7RVFsn4FYI08RqZWZpqXJWiqpcmolWIPIXWgBdFZo/V9PA7YUr5Ibu+?=
 =?us-ascii?Q?7cLWR070XMHJ31n3PQ7mBFMTQv3nEurb2uNVDj2NZF0uMwbZgEC3cbApkk0Q?=
 =?us-ascii?Q?D+rE3FYDfckxGpgpPmiVko1YP56hBpyYJi+dJuz+3nGRPU5AgTR7YbDMNn5Y?=
 =?us-ascii?Q?3luTu2gEGUj98LLCQASD8P1NceUsPDf8+2EWeE5MwwF0SzZUFH+Xe7lKVJ3c?=
 =?us-ascii?Q?GoApK23LheKXEKreAD36wrp7SfhKqAxHS1M1rp1/Mz1wp+VIgnukqEJKLMvd?=
 =?us-ascii?Q?COZhx1cijO+gSEwnlaITAEP8eA0jqQlh9smxew943ZAGtpn49rC1zMNfafCW?=
 =?us-ascii?Q?YRWwRhVRdebKLUTfwa/TxrIZoqPb3E+6fGieR6nXvEXA9a+RsTHiZT1naSFV?=
 =?us-ascii?Q?mOMtbvHphDylRqxomioWBh8XIClp8kDfRg70+tD9qkKjJLLsP3szxjUbLj//?=
 =?us-ascii?Q?T86XBvCaKeM3yQApJwF0lZQNeTJSxuk+sk5ObQelK+Ugho+jGv6wMk+p9e8i?=
 =?us-ascii?Q?prGyZdUGJhukLe83Jv0epZTdRSczu3uUiPf5Q8hZqB7YmmuKqQIaPq7WsIRp?=
 =?us-ascii?Q?Yx0bpzmSoOwBS6MTKOYEasRiszRRZkTML248o/U5IfxqFC3d+SGIbjHqxohd?=
 =?us-ascii?Q?fHMCVucncNdBvxccgzZx1zWptR91bF8gIZaSz/R78TBRFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W4JWsbvPo02PMmaWAJ6GryoHsvJi/msCtrehKqVEAlLaKeW5lOoy+AJC/ody?=
 =?us-ascii?Q?ibJ4NLvxGa6Cn3/rk0vzk7KMYp/iYgfKuGHbEa+Zqx65qFBMq/qSKEuzCf1o?=
 =?us-ascii?Q?511ytuOakZBX6V7eOlMEFkL9U4vLwlwVvWWngwvSegt1oEafvOvj0ucjqQvx?=
 =?us-ascii?Q?jvMah+2tus/d32dXui9QDl+7aDTdEeP64SntqSESna6DZBNbYD1zgLCr/qxN?=
 =?us-ascii?Q?d8XsFbAeIQ+YJY47mQYJLHrYRdPLw4pC7XqIIhApTbwDAgOUlJLPfSD5cfd2?=
 =?us-ascii?Q?unwO4rI7D7xA/xIHXKRGR5WTdjCYfLr3VMEfB7OXy5AJDP0qxJAU9qeaUTzg?=
 =?us-ascii?Q?mrzDfuue6S1c6asrnZqUpdwfDALXuAmtart141A9tSR6WZ8YFa5EyrWn7jGv?=
 =?us-ascii?Q?8tIr0K++Z6DZIENb/bX9tFwodlZMXwm8SBgcGI9WJaOe+eTUvclVSQiqthFv?=
 =?us-ascii?Q?px4vJtt3Si70MibBYpngkZsalAcTp0WLdbvYjCLEZ58qatMBhXUN7yLG4SUk?=
 =?us-ascii?Q?eTgPJ7eCsn/W5RzJtIL33tWdq2rGX5vJhayT1hhutB8X82s7Fp68rk3qCLxg?=
 =?us-ascii?Q?0kDLgag2g6rOBBjRtKzj2Q1YYa2vhJvc4x7YL9NDpjIov7EWItbTNdLanioi?=
 =?us-ascii?Q?RrLlX+WGGYZdUhTol6lAYB4rlCAobfBC0wrh+j03apdoXuPQXcZdkq26aPnF?=
 =?us-ascii?Q?Nk33MWMvV6Qe6pJixlndhJU7B/EvDUl2dXesa1PDSSGruMYVBYfjF2bg9vRZ?=
 =?us-ascii?Q?Re7DpNfMd31w/DSMmZg6V/HPYB2k/E8Dnnh3MPmWvC4Kb7f8bzcJAjRQuxCl?=
 =?us-ascii?Q?IkTPCLwPA5eEqpf4EQ9H3d/SRXN+hEBeybRS9ngDHmT3fdCFnJHQkmwpLkT3?=
 =?us-ascii?Q?5Xa3l1C9IPc1QiDBqQGEjY9LLytj+e2kdZaL/GBRHUYXso54qbn/B6yPflL+?=
 =?us-ascii?Q?kyNhFm84+sGFIu23FEWA/ELjpQXoJ+MBTeJeBbUXE3pc2ijzrm7CUojD4Okt?=
 =?us-ascii?Q?ERtUfBcqJI8kKPhTrQuami+tbaCC18NUEzqH24PXFgIW2yEwe74Gw6CZDMjf?=
 =?us-ascii?Q?tngZrzGMT508dM6l3Ke8DhFPFZ3E5bKGBNBL1NslaiehWH+ybJudY8KnCcs+?=
 =?us-ascii?Q?i/2T0j5UaF3PtiyU7UEnDL4Z1R82t0gMumcR5suriI70G74k1xOKRjk/990k?=
 =?us-ascii?Q?aE/NtPIg3fHxuvPFUJF/yQmbYnfd/5OVD6WkIrDOFEovSDFP6zu+DfK4mSy4?=
 =?us-ascii?Q?ojc0leOIGlgLJIFnS4kir7L1kQ9u9HokRpvMwl2FAgpMvJN3zp/qzDS/iKI9?=
 =?us-ascii?Q?OQ2t1vPprwwuLjLToPWtFBKfLj1yNSGDmEp7enk2Cv3+Ur+VLR3fzoba178e?=
 =?us-ascii?Q?2ulCPWGtRr6LcGjRVd6/z/51k7jO/2ee4e2uM4mWjFh2VprsetPQu1+7eis4?=
 =?us-ascii?Q?Tlx0scJppZsNxlnhct7uvrsljpASWEKAWedWFnlnVz5fb9DYt4DmXlQxnZpU?=
 =?us-ascii?Q?c9X+fzsU4/xA3DVKhGYIzwM5Gw29ElRkt3uvpylI2Bk+Jnw5VNvbRSFpGOCO?=
 =?us-ascii?Q?inQC6u646lr8KX/ufoKq/PdZR/BMjRymHvCQznuh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51d4cc9-aed6-41cc-d64c-08dcd27a2f83
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:55:40.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy6iTgPkVlLytX8viYDMCaI1M4VKt4vtnxBuoRFEHkmbGKi1w8NRedja46eRqXKwhTJLm1D6oyp9QHMwsWH5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

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
V4: Fix the 0day
V5: Fix typo and pr_warn warning
---
 drivers/acpi/prmt.c | 49 +++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index c78453c74ef5..cd4a7f5491d6 100644
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
+				"Idx: %llu, Parts of handler(GUID: %pUL) are missed, handler_addr %p, data_addr %p, param_addr %p",
+				cur_handler, &th->guid, th->handler_addr,
+				(void *)th->static_data_buffer_addr, (void *)th->acpi_param_buffer_addr);
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


