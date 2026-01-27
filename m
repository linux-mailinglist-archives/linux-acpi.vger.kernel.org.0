Return-Path: <linux-acpi+bounces-20667-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM4ENTXTeGlHtgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20667-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:01:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323929636E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA0A301BF4B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E172FFDE1;
	Tue, 27 Jan 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyOvuiCM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205782D77EA
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526062; cv=none; b=V/xmQdAMQNzL6O2rGJhMIWW4Wk/aEWEsGIzavpczuZUsCv+4mPD/W9OTNHyVF4ZVAUgUqQAHPULwoho/62cnSdxOeKAJ3e9AO3U+kQ0rhYbnsbAbPABg6QR3dWW/xRIMXDP4CxjeqsBTHd4pZKGnI6QFJwZygkhTZHv0U5pfnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526062; c=relaxed/simple;
	bh=TC2ojBnEzKjSm02vnSKbJc6xd4kHdDdbya/Bgqu9H9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkuCz1wsUwgQzg/sGW+8GPKPTL+NhB+A5aq07wc3+e9HvYI0ypBlib3aLH2yqDO6ECA2ffM1MFIXjLp0EnjL8f4wp+2l6cU6bg2PrYLgWJ55x49ZrgzyW/Cpu7MxHWcI3vgvMrL56U3uX3CGt3Xy8twtNTT5nkDSrDP4VQh4/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyOvuiCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23E5C2BCB3
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526062;
	bh=TC2ojBnEzKjSm02vnSKbJc6xd4kHdDdbya/Bgqu9H9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oyOvuiCM7BWg3JqhVa6NRjkLtKaqXo0hq0J2dkGycf2BBKxG/al07cnawjtcr1Bd8
	 dqPNCBSLUutRmtUeXjgad/p4iBg05ycWoFuInGEZ61H2RPpMlxpNDAjPKIpr91Ec4B
	 LfI2nteelFWxDENVMhKaCJD/igCZSKKr2+QxVsXd1iF9TwkkPA2TqKileEL3hvl8/h
	 XohCVvlE6/vWZa6SiyOz0eGIsdIclt95tKe4LQeTMFpSsQ4On+OnoqZ00G+Y0fAmKD
	 liGaQJZBkW8Th66Dcf38Zr1fdGODZxViCDSKelf83S8YcMO/nhl4vnoSwWSpLWEDdR
	 +1qzXDdVTwKaQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45c9fdf2a06so3656663b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 07:01:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0tUwXSVzB7mmYs8r0h6+5xkVA5cdosNTdozYIHmaA4/XwxR/YcHpWmmZuLbogOi+0dIqdzlLMdsBy@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1qt3KttCjazkjrTYLGkLCFPU2Vxlg74jhLqglm9qD3gHc4j2
	aLX4fvHXs3ggmfULSDqiy4VrfENSJJcNqI66fM5sw4BLuD/Y/WzSX77qG4x7HrKj1cbagR+jFY5
	85w41jxRkC9z2p3x306qhtL3xxC8JMpQ=
X-Received: by 2002:a05:6808:2e4d:b0:450:bc28:c883 with SMTP id
 5614622812f47-45efc6f7349mr1237514b6e.58.1769526060517; Tue, 27 Jan 2026
 07:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203140716.3065-1-huyuye812@163.com> <20260112141630.2869-1-huyuye812@163.com>
In-Reply-To: <20260112141630.2869-1-huyuye812@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 16:00:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ixBFGHwvSEp3Ae_s0tyhK338Gju=1+vb+O3_pH2mHyGA@mail.gmail.com>
X-Gm-Features: AZwV_Qip_BNTk6ncmyWz97jQ9rPE2aPWnHrEh9T9xbERPrdO3mOUpXGjtm_GQ24
Message-ID: <CAJZ5v0ixBFGHwvSEp3Ae_s0tyhK338Gju=1+vb+O3_pH2mHyGA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
To: huyuye <huyuye812@163.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn, 
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn, liu.qingtao2@zte.com.cn, 
	wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn, 
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn, li.kunpeng@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20667-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 323929636E
X-Rspamd-Action: no action

On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM huyuye <huyuye812@163.com> wrote:
>
> Hi Rafael,
> Thank you for your thorough review and valuable comments on v1.
> I've updated the patch as follows:
> 1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled)
> guard as you pointed out. The entire code block indeed already depends
> on CONFIG_ACPI at a higher level, making the inner guard unnecessary.
> 2. Moved acpi_dev_clear_dependencies to RISC-V specific architecture
> code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI dependency
> clearing is handled within the appropriate architectural context.
>
> Best regards
> Signed-off-by: huyuye <huyuye812@163.com>
> ---
>  drivers/acpi/pci_root.c       |  6 ++++++
>  drivers/acpi/riscv/Makefile   |  2 +-
>  drivers/acpi/riscv/acpi_pci.c | 11 +++++++++++
>  include/acpi/acpi_bus.h       |  1 +
>  4 files changed, 19 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/riscv/acpi_pci.c
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 9d7f85dadc48..a16eb9097cdc 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -30,6 +30,11 @@ static int acpi_pci_root_add(struct acpi_device *devic=
e,
>                              const struct acpi_device_id *not_used);
>  static void acpi_pci_root_remove(struct acpi_device *device);
>
> +
> +void __weak arch_acpi_pci_root_add_clear_dep(struct acpi_device *device)
> +{
> +}
> +
>  static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  {
>         acpiphp_check_host_bridge(adev);
> @@ -760,6 +765,7 @@ static int acpi_pci_root_add(struct acpi_device *devi=
ce,
>         pci_lock_rescan_remove();
>         pci_bus_add_devices(root->bus);
>         pci_unlock_rescan_remove();
> +       arch_acpi_pci_root_add_clear_dep(device);

Actually, this could be as simple as

       if (IS_ENABLED(CONFIG_RISCV))
              acpi_dev_clear_dependencies(device);

with a brief comment explaining why it is needed.

Bjorn, any thoughts?

>         return 1;
>
>  remove_dmar:
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index 1284a076fa88..5b1bd0298fb9 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y                                  +=3D rhct.o init.o irq.o
> +obj-y                                  +=3D rhct.o init.o irq.o acpi_pci=
.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)      +=3D cpuidle.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)            +=3D cppc.o
>  obj-$(CONFIG_ACPI_RIMT)                        +=3D rimt.o
> diff --git a/drivers/acpi/riscv/acpi_pci.c b/drivers/acpi/riscv/acpi_pci.=
c
> new file mode 100644
> index 000000000000..368ff113e5c6
> --- /dev/null
> +++ b/drivers/acpi/riscv/acpi_pci.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026, ZTE Corporation
> + *  Author: Yu Ye Hu <hu.yuye@zte.com.cn>
> + */
> +#include <linux/acpi.h>
> +
> +void arch_acpi_pci_root_add_clear_dep(struct acpi_device *device)
> +{
> +       acpi_dev_clear_dependencies(device);
> +}
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..c00b523a6ebd 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -996,6 +996,7 @@ int acpi_wait_for_acpi_ipmi(void);
>
>  int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_d=
evices);
>  u32 arch_acpi_add_auto_dep(acpi_handle handle);
> +void arch_acpi_pci_root_add_clear_dep(struct acpi_device *device);
>  #else  /* CONFIG_ACPI */
>
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
> --
> 2.43.0
>

