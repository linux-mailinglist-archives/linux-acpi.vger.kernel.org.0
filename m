Return-Path: <linux-acpi+bounces-2103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F245C802D27
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 09:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD5E1F20F1F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 08:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25687FBE9
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9Sil9zK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zBwXBxP/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762CBB;
	Mon,  4 Dec 2023 00:13:56 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701677635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMNsPU3Juib2yJf6SWQqDXaxEhWmoFOPHWoGv9RWmGg=;
	b=c9Sil9zKcRmAM17YdNijnJ738PZPkK/vFPXvfZqAahgs6pPDG3sDKWQXOdww6YNmkHldsI
	vjwOnAXB+bYEjHmN1RamCkmOVTAX2fGQdmvw2pNYjUI0MxdPmd4T1YHOg6v27La0V6EFgU
	shnYxpZ7VtqifbKRJUw+fltnGt8KchZV9aqpZBYYCcSMPwCNLOTLDHzMzJ3OMeRCm6gji/
	ZBI7XVm6Xe+uzjQsA5VNiKpVTduqxYnPjwbaeWpGWrT98UaiypT/oFki+dXe3gGk7j402j
	xblTjyWiv/lL2Vg+dWyUHVVUVgRYDX3x98dOizKDaWFwW3nuPFqS5GwLQ0e/Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701677635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMNsPU3Juib2yJf6SWQqDXaxEhWmoFOPHWoGv9RWmGg=;
	b=zBwXBxP/CtRum3O7TXJpoQS0cbxSZPFzNqDfrXvR7wNiGLNFMWJgE3xAEKIaSQKeV6xH6I
	vHV1cGfsxAipPcAw==
To: Jiqian Chen <Jiqian.Chen@amd.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Roger
 Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Stefano Stabellini <stefano.stabellini@amd.com>, Alex Deucher
 <Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou
 <xenia.ragiadakou@amd.com>, Honglei Huang <Honglei1.Huang@amd.com>, Julia
 Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
In-Reply-To: <20231124103123.3263471-3-Jiqian.Chen@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
Date: Mon, 04 Dec 2023 09:13:54 +0100
Message-ID: <87bkb6xu4d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 24 2023 at 18:31, Jiqian Chen wrote:
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index 5a96b6c66c07..b83d02bcc76c 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -357,6 +357,7 @@ static int pcistub_match(struct pci_dev *dev)
>  static int pcistub_init_device(struct pci_dev *dev)
>  {
>  	struct xen_pcibk_dev_data *dev_data;
> +	struct irq_desc *desc = NULL;
>  	int err = 0;
>  
>  	dev_dbg(&dev->dev, "initializing...\n");
> @@ -399,6 +400,12 @@ static int pcistub_init_device(struct pci_dev *dev)
>  	if (err)
>  		goto config_release;
>  
> +	if (xen_initial_domain() && xen_pvh_domain()) {
> +		if (dev->irq <= 0 || !(desc = irq_to_desc(dev->irq)))

Driver code has absolutely no business to access irq_desc.

> +			goto config_release;
> +		unmask_irq(desc);

Or to invoke any internal function.

> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -439,6 +439,7 @@ void unmask_irq(struct irq_desc *desc)
>  		irq_state_clr_masked(desc);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(unmask_irq);

Not going to happen.

> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -380,7 +380,7 @@ struct irq_desc *irq_to_desc(unsigned int irq)
>  {
>  	return mtree_load(&sparse_irqs, irq);
>  }
> -#ifdef CONFIG_KVM_BOOK3S_64_HV_MODULE
> +#if defined CONFIG_KVM_BOOK3S_64_HV_MODULE || defined CONFIG_XEN_PVH

Neither that.

This all smells badly like a XEN internal issue and we are not going to
hack around it by exposing interrupt internals.

Thanks,

        tglx

