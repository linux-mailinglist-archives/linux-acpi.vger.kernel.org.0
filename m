Return-Path: <linux-acpi+bounces-1101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AD07DBFE5
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 19:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8461D1C209B0
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E452119BA8
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nqPfPqk/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3753D27F
	for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2023 17:54:39 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB55B4
	for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2023 10:54:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c10f098a27so967583b3a.2
        for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2023 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698688476; x=1699293276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21YW+6fG17bA3AZxmYV1MGGTJ8p29kWqv098XZo38z4=;
        b=nqPfPqk/strvzYxBWCBmFV0dwI7wZ7N7xR4H8fVXLn93Z3cAblj32QTGu+WodvuPnS
         1EZZnkuTf6h1+mWK5TndqNiZ+syOeWOhRPPL8AsArRRYhZpqaICuACQ8j/56B8VLNptL
         H6mSkjc0mn8MIjTatTlJkXd4khqFWYHtQCAEBGo9dFGvn5A/jVLz8hPQT/wwpN2V2ADN
         LDaSU8T4FTv3HGaP0N915cFZM/U3XapV2BGaczADrfC71SNicHxlvm6DmrcEJ6uxAvCE
         LKVsqssvzBXEKxcw/RUaWQd1AF9aUtsXlMmUnaIRTh8++R0VtHoSCBKc5ZVn+gwA0Wlu
         czJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698688476; x=1699293276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21YW+6fG17bA3AZxmYV1MGGTJ8p29kWqv098XZo38z4=;
        b=R3oWeETFJERI8nAdTWOtx5VogggGQKz03LT+AfibrZD53rhB2RRdYh18PKymLVmnRG
         aUKLAlqqz5Wetfbgby5EXX6Diw2KjWHfi/2qnaXrySuMOxuweXlssPNrSf/24VdZlweT
         qKGvzv8a6frbmlcTHmQj0CGvlnNIQx+Xqm7g303M0bOyLRh7fGnHEdg37kiQ1GlsPKKD
         m8DbPAf9T8lFegtARY/mMth5zR2Edr8DTkm+kBlQ6r9+lpaPRm9s0eVSD9iBXkmDpqzY
         t0V6Z/8pZVVsMPWajhXmnanu/2kDZ9EzUPAnCi1p4m7Pmlpr/DSh96UY1xBbAV7A7IpD
         l5wQ==
X-Gm-Message-State: AOJu0Yyoxt2DWveZYjwqXOMdXQfF5RSiVlC9A257wthx3g3Xexbzfd5v
	nHMybDE25adkYUFvmLiCQ5K/Ow==
X-Google-Smtp-Source: AGHT+IGcO5mSWybe6n+dtGZAk2xcN8I4tCXS/WOTKt6LNejW/oYf1m4IEzTPCduyQ3/xCabvXgof9A==
X-Received: by 2002:a05:6a00:cc6:b0:6be:11ac:98a5 with SMTP id b6-20020a056a000cc600b006be11ac98a5mr10716364pfv.27.1698688475658;
        Mon, 30 Oct 2023 10:54:35 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id f29-20020a056a000b1d00b006be0fb89ac3sm6169630pfu.30.2023.10.30.10.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:54:35 -0700 (PDT)
Date: Mon, 30 Oct 2023 23:24:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 11/21] PCI: MSI: Add helper function to set system
 wide MSI support
Message-ID: <ZT/t0UY5rbudhjfH@sunil-laptop>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-12-sunilvl@ventanamicro.com>
 <87a5s0yyje.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5s0yyje.ffs@tglx>

On Mon, Oct 30, 2023 at 03:28:53PM +0100, Thomas Gleixner wrote:
> On Thu, Oct 26 2023 at 01:53, Sunil V. L. wrote:
> > Like pci_no_msi() used to disable MSI support, add a function to enable
> > system wide MSI support.
> 
> Why?
> 
> int pci_msi_enable = 1;
> 
> So this function makes it more one or what am I missing here?
> 
Hi Thomas,

Just noting related discussion :
https://www.spinics.net/lists/linux-serial/msg57616.html

The MSI controller on RISC-V (IMSIC) is optional for the platform. So,
when by default pci_msi_enable = 1 and the MSI controller is not
discovered, we get stack trace like below.

[    0.608941] [<ffffffff804d0400>] pci_msi_setup_msi_irqs+0x18/0x34
[    0.608991] [<ffffffff804cfe04>] msix_capability_init+0x228/0x406
[    0.609001] [<ffffffff804cfbc6>] __pci_enable_msix_range+0x1b4/0x1ca
[    0.609011] [<ffffffff804ce8c2>]
pci_alloc_irq_vectors_affinity+0x6e/0xee
[    0.609020] [<ffffffff8055015c>] vp_find_vqs_msix+0xfa/0x350
[    0.609031] [<ffffffff8054ff54>] vp_find_vqs+0x36/0x144
[    0.609040] [<ffffffff8054f7b8>] vp_modern_find_vqs+0x14/0x48
[    0.609049] [<ffffffff8064d3fc>] init_vqs+0x362/0x4ee
[    0.609058] [<ffffffff8064c8be>] virtnet_probe+0x672/0xa70
[    0.609067] [<ffffffff80549d38>] virtio_dev_probe+0x194/0x200
[    0.609075] [<ffffffff805afb52>] really_probe+0x106/0x28a
[    0.609083] [<ffffffff805aefda>] __driver_probe_device+0x62/0xdc
[    0.609091] [<ffffffff805af920>] driver_probe_device+0x38/0x164
[    0.609098] [<ffffffff805af146>] __driver_attach+0xd0/0x17c
[    0.609106] [<ffffffff805ac6e2>] bus_for_each_dev+0xd0/0x11c
[    0.609116] [<ffffffff805af06e>] driver_attach+0x1a/0x22
[    0.609123] [<ffffffff805ace06>] bus_add_driver+0x136/0x208
[    0.609132] [<ffffffff805b044e>] driver_register+0x48/0xda
[    0.609140] [<ffffffff80549594>] register_virtio_driver+0x20/0x2a
[    0.609157] [<ffffffff80a3060e>] virtio_net_driver_init+0x76/0xa6
[    0.609168] [<ffffffff800020ec>] do_one_initcall+0xc0/0x21e
[    0.609176] [<ffffffff80a00f68>] do_initcall_level+0x7c/0x8e
[    0.609186] [<ffffffff80a00eb6>] do_initcalls+0x52/0x88
[    0.609195] [<ffffffff80a00e5c>] do_basic_setup+0x1c/0x24
[    0.609204] [<ffffffff80a00e00>] kernel_init_freeable+0xe2/0x122
[    0.609213] [<ffffffff8090beb4>] kernel_init+0x1a/0x18e
[    0.609223] [<ffffffff8000383e>] ret_from_fork+0xa/0x1c

So, what I did was, by default call pci_no_msi() to disable MSI and then
call pci_set_msi() to enable when MSI controller is probed.

But I think Bjorn's suggestion to depend on PCI_BUS_FLAGS_NO_MSI may be
better idea. In that case, we need to set bridge->msi_domain to true in
pci_create_root_bus(). Let me know what do you prefer or if I am
completely missing something here.

Thanks,
Sunil

