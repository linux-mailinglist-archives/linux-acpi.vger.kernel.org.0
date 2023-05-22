Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5732970BB46
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjEVLMs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 07:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEVLMZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 07:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E735B8
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2023 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684753599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pm6pIysjMAsg0WDE6icfe6G1Q5qdHkb+W04G2UqRo/k=;
        b=FAJ/9dZ1MY1/2UHFlZ6QvArij7FX+3jwjid/ADSN2HvzAEPLI9bv3E7vDqdytTZbWFYoAc
        9jZdhGi8WW5IBccWnm8TTlgCkdNtH4W4EpfsKSpk0Ro4oqs86YUa45PNATbQQz9R8njIeF
        WWHdMtUvQiGXLQIJa2yB2iYBKm6EcIw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-OMMOSD76PmGyj8DHO2yHMg-1; Mon, 22 May 2023 07:06:37 -0400
X-MC-Unique: OMMOSD76PmGyj8DHO2yHMg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3079d15b51dso1655919f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2023 04:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753597; x=1687345597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm6pIysjMAsg0WDE6icfe6G1Q5qdHkb+W04G2UqRo/k=;
        b=JCw5J5tnlDFuvBfUWw+MEusYchfWyaz3ZRjvr4ZheeU5yy5orrLtQCuFbt6dKworQM
         +gBQlhAYy6MA/mgTAxhPDbin7FQ7A/seg6OSPdyeiRBB38ue+xsUiQERnKmo7JD1eh+S
         L0VkYC8gNDEWfNZt3zFioOqtnM9zLJp4LFGSDYhtA4/vifdPssweAaf+3Zbu10Grpbx+
         WateOrFDMHmuqWrLOa/yedteYI572tKm/FaMpIcP5vSCMrxMpxs1iuUWDE4u5qLhN05H
         vSFsMLsyJdii9pZtEDZKp3eT264hrWD7JWC6kcGk8bV3pAO0+igneVZrDQeTuH2I4icU
         A8HQ==
X-Gm-Message-State: AC+VfDzTKP37U7QiHDJ/XlyuDrME4SgcJ1rivo/LWFjrumNB5/btIs3f
        I8VvqAFH4CNaZttAqkL0IU700pk4rMwQHJhDAvLonFPbQE74FVRh544tqiRiVnNLsIfHQUHR95l
        YQGsIhL2R4V9qYbOgDjbK+g==
X-Received: by 2002:a05:6000:1202:b0:307:bb47:75de with SMTP id e2-20020a056000120200b00307bb4775demr9149930wrx.26.1684753596848;
        Mon, 22 May 2023 04:06:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mXtTblA8QpHnMhA95J7Zxci8FCUxH08T/nJQqebnSYn2n0i0RgD4OqKt+UIDp2dvz11ao5A==
X-Received: by 2002:a05:6000:1202:b0:307:bb47:75de with SMTP id e2-20020a056000120200b00307bb4775demr9149917wrx.26.1684753596586;
        Mon, 22 May 2023 04:06:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b003f1978bbcd6sm24870383wms.3.2023.05.22.04.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:06:35 -0700 (PDT)
Date:   Mon, 22 May 2023 13:06:35 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     mst@redhat.com, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        helgaas@kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230522130635.5e3f8771@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230424191557.2464760-1-imammedo@redhat.com>
References: <20230424191557.2464760-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 24 Apr 2023 21:15:57 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> When using ACPI PCI hotplug, hotplugging a device with
> large BARs may fail if bridge windows programmed by
> firmware are not large enough.

Rafael,

Since there was no more comments for a while,
can you merge this patch through your tree?

> Reproducer:
>   $ qemu-kvm -monitor stdio -M q35  -m 4G \
>       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
>       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
>       disk_image
> 
>  wait till linux guest boots, then hotplug device
>    (qemu) device_add qxl,bus=rp1
> 
>  hotplug on guest side fails with:
>    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
>    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
>    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
>    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
>    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
>    qxl 0000:01:00.0: enabling device (0000 -> 0003)
>    Unable to create vram_mapping
>    qxl: probe of 0000:01:00.0 failed with error -12
> 
> However when using native PCIe hotplug
>   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> it works fine, since kernel attempts to reassign unused resources.
> Use the same machinery as native PCIe hotplug to (re)assign resources.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> tested in QEMU with Q35 machine on PCIE root port and also
> with nested conventional bridge attached to root port.
> 
> v2:
>   * fixup subject to match expected style
>   * drop no longer needed __pci_bus_size_bridges() to avoid
>     memory leak (Bjorn Helgaas <helgaas@kernel.org>)
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..328d1e416014 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -498,7 +498,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				acpiphp_native_scan_bridge(dev);
>  		}
>  	} else {
> -		LIST_HEAD(add_list);
>  		int max, pass;
>  
>  		acpiphp_rescan_slot(slot);
> @@ -512,12 +511,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> -					__pci_bus_size_bridges(dev->subordinate,
> -							       &add_list);
>  				}
>  			}
>  		}
> -		__pci_bus_assign_resources(bus, &add_list, NULL);
> +		pci_assign_unassigned_bridge_resources(bus->self);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);

