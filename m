Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6880F775645
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjHIJWB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjHIJVz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 05:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6921FDC
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 02:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691572871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9xAGqf9aiDwwi/u0vKlka2Lj7rHzO4Um01b3PUOfJQ=;
        b=ddV/RTya703L8AyprRhsba44Rf/9WYQ8WG6HdvtEtm7/vX4DGFwwRLRyxd1hJlxeLAD02k
        8hHUJ+SKzlO0qR+XAVvdD0sY3LrxajSi8s2mU+kyl7ejoUdq+DcOYqP7ZonmidlFykK69j
        +QxwMNBhLROLc32imWv1uIVdy5OtyLA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-V665jOPROFmSIAkr83QEew-1; Wed, 09 Aug 2023 05:21:10 -0400
X-MC-Unique: V665jOPROFmSIAkr83QEew-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99c20561244so428589866b.0
        for <linux-acpi@vger.kernel.org>; Wed, 09 Aug 2023 02:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691572869; x=1692177669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9xAGqf9aiDwwi/u0vKlka2Lj7rHzO4Um01b3PUOfJQ=;
        b=NJuQPUWD9D3pT4p1AJI5Nevz75B0JXdtywy7OCZY9ApRWeDZQ0Kmake+sLyTxXmgDi
         LYfI1oVeqH7H9M4+9sgSiDduY8Cx87d7KJAifgQcMYenMc32y4Fu38WM8++QvkQsDmbX
         1Gf51PibZdL8OE2d+g8OFwRRnwwhoGDbhbEEQHHdiJsQQ9FX/dBOWQLJu8bWCwe+tDPm
         d9m/ULkeiHnIJtKq1HLDNjtrFffqbe0qE2fvIrsTKI4qyJ/j+6nkQ+I+/MwmWwCQaFi7
         ErJpqUjpQ0HeQBZAqGWL+d7rZYqpjLEwdC9v3sbMORkzcfzYItHtO7JPbzKYSkXv0W/i
         25gg==
X-Gm-Message-State: AOJu0YwwSn5hSlSBAIjp34/2tP6QSTMsVTCfocW+Oj3vUWeMzcBhW8Pr
        whr6JgG1VI1LWIPqNNOEgStZ93g2YhCGnAkfAiuaWLpqtB0Tab9TO72LrOkre2DGwZ//jvLYI9b
        6jUKgeDNYfujCAuW8y4AAfQ==
X-Received: by 2002:a17:907:75c5:b0:994:54fd:31aa with SMTP id jl5-20020a17090775c500b0099454fd31aamr1571694ejc.15.1691572869250;
        Wed, 09 Aug 2023 02:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjMru6Ex1xwpeLF0h6uvHaiAkp+bnWoayPqR275tiN7vTEidyY8087BcbPeOuSOFcLnbduKw==
X-Received: by 2002:a17:907:75c5:b0:994:54fd:31aa with SMTP id jl5-20020a17090775c500b0099454fd31aamr1571683ejc.15.1691572868957;
        Wed, 09 Aug 2023 02:21:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906155800b00993004239a4sm7696669ejd.215.2023.08.09.02.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 02:21:08 -0700 (PDT)
Date:   Wed, 9 Aug 2023 11:21:07 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Woody Suwalski <terraluna977@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: acpiphp: Log more slot and notification details
Message-ID: <20230809112107.2b692b67@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230808192713.329414-1-helgaas@kernel.org>
References: <20230808192713.329414-1-helgaas@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue,  8 Aug 2023 14:27:13 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When registering an acpiphp slot, log the slot name in the same style as
> pciehp and include the PCI bus/device and whether a device is present or
> the slot is empty.
> 
> When handling an ACPI notification, log the PCI bus/device and notification
> type.
> 
> Sample dmesg log diff:
> 
>     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>   - acpiphp: Slot [3] registered
>   - acpiphp: Slot [4] registered
>     PCI host bridge to bus 0000:00
>     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
>     <ACPI Device Check notification>

Having ACPI node name/path here that received notification would be helpfull  

>     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
> 
>     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>   + acpiphp: pci 0000:00:03 Slot(3) registered (enabled)
>   + acpiphp: pci 0000:00:04 Slot(4) registered (empty)
>     PCI host bridge to bus 0000:00
>     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
>     <ACPI Device Check notification>
>   + acpiphp: pci 0000:00:04 Slot(4) Device Check
>     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/acpiphp_core.c |  4 ----
>  drivers/pci/hotplug/acpiphp_glue.c | 23 +++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
> index c02257f4b61c..19d47607d009 100644
> --- a/drivers/pci/hotplug/acpiphp_core.c
> +++ b/drivers/pci/hotplug/acpiphp_core.c
> @@ -282,8 +282,6 @@ int acpiphp_register_hotplug_slot(struct acpiphp_slot *acpiphp_slot,
>  		goto error_slot;
>  	}
>  
> -	pr_info("Slot [%s] registered\n", slot_name(slot));
> -
>  	return 0;
>  error_slot:
>  	kfree(slot);
> @@ -296,8 +294,6 @@ void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *acpiphp_slot)
>  {
>  	struct slot *slot = acpiphp_slot->slot;
>  
> -	pr_info("Slot [%s] unregistered\n", slot_name(slot));
> -
>  	pci_hp_deregister(&slot->hotplug_slot);
>  	kfree(slot);
>  }
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 328d1e416014..eeca2753a5c7 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -25,7 +25,7 @@
>   *    bus. It loses the refcount when the driver unloads.
>   */
>  
> -#define pr_fmt(fmt) "acpiphp_glue: " fmt
> +#define pr_fmt(fmt) "acpiphp: " fmt
>  
>  #include <linux/module.h>
>  
> @@ -333,6 +333,12 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
>  				       &val, 60*1000))
>  		slot->flags |= SLOT_ENABLED;
>  
> +	if (slot->slot)
> +		pr_info("pci %04x:%02x:%02x Slot(%s) registered (%s)\n",
> +			pci_domain_nr(slot->bus), slot->bus->number,
> +			slot->device, slot_name(slot->slot),
> +			slot->flags & SLOT_ENABLED ? "enabled" : "empty");
> +
>  	return AE_OK;
>  }
>  
> @@ -351,8 +357,13 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
>  			acpi_unlock_hp_context();
>  		}
>  		slot->flags |= SLOT_IS_GOING_AWAY;
> -		if (slot->slot)
> +		if (slot->slot) {
> +			pr_info("pci %04x:%02x:%02x Slot(%s) unregistered\n",
> +				pci_domain_nr(slot->bus), slot->bus->number,
> +				slot->device, slot_name(slot->slot));
> +
>  			acpiphp_unregister_hotplug_slot(slot);
> +		}
>  	}
>  
>  	mutex_lock(&bridge_mutex);
> @@ -793,6 +804,14 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
>  
>  	pci_lock_rescan_remove();
>  
> +	pr_info("pci %04x:%02x:%02x Slot(%s) %s\n",
> +		pci_domain_nr(slot->bus), slot->bus->number,
> +		slot->device, slot_name(slot->slot),
I had similar issue with logging patches that I've asked Woody to run.

it crashes here with buscheck on non existing device

Call Trace:
 <TASK>
 ? __die_body+0x19/0x60
 ? page_fault_oops+0x158/0x430
 ? fixup_exception+0x21/0x330
 ? exc_page_fault+0x6b/0x150
 ? asm_exc_page_fault+0x26/0x30
 ? acpiphp_hotplug_notify+0x13d/0x2f0
 ? __pfx_acpiphp_hotplug_notify+0x10/0x10
 acpi_device_hotplug+0xc2/0x4f0
 acpi_hotplug_work_fn+0x19/0x30
 process_one_work+0x1f8/0x3e0
 worker_thread+0x29/0x3b0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf2/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0

(gdb) p *slot
$2 = {node = {next = 0xffff8881003287c0, prev = 0xffff888100887730}, bus = 0xffff8881003de800,
 funcs = {next = 0xffff8881008877b0, prev = 0xffff888100887a50}, slot = 0x0 <fixed_percpu_data>,
                                                                 ^^^ likely culprit
 device = 0x0, flags = 0x1}


reproducer hack: https://gitlab.com/imammedo/qemu/-/tree/acpiphp_buscheck_on_missing_device?ref_type=heads

 ./qemu-system-x86_64 -M q35 -cpu host -smp 4 -enable-kvm  -m 6G  -kernel ~/builds/linux-2.6/arch/x86/boot/bzImage -append 'nokaslr root=/dev/sda1 console=ttyS0' -snapshot rhel9.img  -device pcie-root-port,id=rp1,bus=pcie.0,chassis=0,addr=8 -monitor stdio -serial file:/tmp/s -s

then once booted to trigger buscheck issue at monitor prompt:
(qemu) device_add e1000e,bus=rp1

> +		type == ACPI_NOTIFY_BUS_CHECK ? "Bus Check" :
> +		type == ACPI_NOTIFY_DEVICE_CHECK ? "Device Check" :
> +		type == ACPI_NOTIFY_EJECT_REQUEST ? "Eject Request" :
> +		"Notification");
> +
>  	switch (type) {
>  	case ACPI_NOTIFY_BUS_CHECK:
>  		/* bus re-enumerate */

