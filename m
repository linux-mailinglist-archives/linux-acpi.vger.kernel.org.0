Return-Path: <linux-acpi+bounces-1977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FA7FE84D
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 05:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B98281D4B
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 04:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF77200B9
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvMRCkn1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D01134B0
	for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2023 03:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F28FC433C7;
	Thu, 30 Nov 2023 03:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701316444;
	bh=eqrzzX60ARPCRs9X4WWPjycQ35QvNwJsAd1XNvK8saw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GvMRCkn1WFSi9WF+av2EeV08oEHGzraC7gBBdTXSLBjyvYt2SQtWcQzoDvBRXOkRX
	 EcSCe1XuhGeKNw4mFK+3a+PtBYv2DE/lAtRxKP1TkpIaR0X0N7QTUrE2PULcyzM50I
	 30COdUKB7E6Xn4rfhvlNEQAoW4iHWUIDf+cbbBI/k2//K5ezvdu9FT7hoNCizoS+zt
	 CGTQ1luYqgCdMC9ZgWNcrPSsi90Gj1pDFP57PXEEqEsp519moh1LCh1hvZhQK1bZqI
	 0RMWGKVE9Grgoadx/opXr8GHVBkj0wm2gqYZe8hlWC943iDrXBZ5gOLff9EyMhLU9m
	 D/KgNLvvSxAYw==
Date: Wed, 29 Nov 2023 19:53:59 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jiqian Chen <Jiqian.Chen@amd.com>, roger.pau@citrix.com
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
    xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    linux-acpi@vger.kernel.org, 
    Stefano Stabellini <stefano.stabellini@amd.com>, 
    Alex Deucher <Alexander.Deucher@amd.com>, 
    Christian Koenig <Christian.Koenig@amd.com>, 
    Stewart Hildebrand <Stewart.Hildebrand@amd.com>, 
    Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
    Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>, 
    Huang Rui <Ray.Huang@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
In-Reply-To: <20231124103123.3263471-3-Jiqian.Chen@amd.com>
Message-ID: <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com> <20231124103123.3263471-3-Jiqian.Chen@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Nov 2023, Jiqian Chen wrote:
> This patch is to solve two problems we encountered when we try to
> passthrough a device to hvm domU base on Xen PVH dom0.
> 
> First, hvm guest will alloc a pirq and irq for a passthrough device
> by using gsi, before that, the gsi must first has a mapping in dom0,
> see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
> into Xen and check whether dom0 has the mapping. See
> XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
> dom0 and it return irq is 0, and then return -EPERM.
> This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
> when thay are enabled.
> 
> Second, in PVH dom0, the gsi of a passthrough device doesn't get
> registered, but gsi must be configured for it to be able to be
> mapped into a domU.
> 
> After searching codes, we can find map_pirq and register_gsi will be
> done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
> the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
> can be conclude to that the gsi of a passthrough device doesn't be
> unmasked.
> 
> To solve the unmaske problem, this patch call the unmask_irq when we
> assign a device to be passthrough. So that the gsi can get registered
> and mapped in PVH dom0.


Roger, this seems to be more of a Xen issue than a Linux issue. Why do
we need the unmask check in Xen? Couldn't we just do:


diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
index 4e40d3609a..df262a4a18 100644
--- a/xen/arch/x86/hvm/vioapic.c
+++ b/xen/arch/x86/hvm/vioapic.c
@@ -287,7 +287,7 @@ static void vioapic_write_redirent(
             hvm_dpci_eoi(d, gsi);
     }
 
-    if ( is_hardware_domain(d) && unmasked )
+    if ( is_hardware_domain(d) )
     {
         /*
          * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock

