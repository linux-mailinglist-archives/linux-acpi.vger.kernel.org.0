Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD26E5F5B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDRLJA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Apr 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDRLI6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2023 07:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58AE43
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681816096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKEfYGa3UvFKKaowY9sL3AcD6BO4UURgowBGbsTt0fI=;
        b=BSL/Dc64y7xMbRw3/jfrGBAiZR7v6Idi+5rOXzc1BE82p3ofEG7kW8SAoDDsaapryAQHuK
        bJ2R64wC1snwtPlXSWFJp94DrBUbUNkDp64W8uYF0DCbD9F08Ago8ceHaNUsn1xWerPZRJ
        f9HeNzaN7MAh/+KFwegxw+HpyoE57x0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-uno_NUXmPs-fAKVcWEs06w-1; Tue, 18 Apr 2023 07:08:15 -0400
X-MC-Unique: uno_NUXmPs-fAKVcWEs06w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1121240f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 04:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681816094; x=1684408094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKEfYGa3UvFKKaowY9sL3AcD6BO4UURgowBGbsTt0fI=;
        b=YpTFXmf8v0ZeqMIa8KqE5mgkKfl59OkvqAUZiDt5tqEGU6s5cacChgfjlXK5O0j0kt
         zktiM2rJSTkg7BbgBznO+u99RapkSth8YVL8BPhaRoYBDvx95E3HSz9x9zshc5kuOyrH
         +Gf6dWPcD/LXjp8Jj7BZmc6TBeRNwmYVX04TxWb7nxngvc8ZFuQK8afXKkrWv/deuLuV
         0RaF1yPxOF/ezjfkI+6LxrzxZDtPayvIgH2VYJ292ZvsmI8rM4OgX6p1xMmILFzoHAcJ
         AilWL6+B6Dy/rvDXCKfwMatJM4vemmtBCBODuGNcRT2eT4GGEgIwaMLu6AIH0UosgbFN
         AANA==
X-Gm-Message-State: AAQBX9fMad7aL2uBVqdVwpnhHTD0d176dS0wblUAMGvNODIEmZCjaFdG
        qlIZquXB5U5CWcR9VSRtl1wRMjZRHP4qlIUQlED3/S6g1DRKl7HPlopzIfzNrEmXFuNHiJGfR+d
        X1f5W50sHX4m/CWfmL1Jpeg==
X-Received: by 2002:a5d:6708:0:b0:2f7:8f62:1a45 with SMTP id o8-20020a5d6708000000b002f78f621a45mr1532073wru.66.1681816093916;
        Tue, 18 Apr 2023 04:08:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZ1NCpYtRz9weic8B+ifu5Tys9OSKO4MurPWYbZhcWZaN/lJ4Sqz3OgA6Sep5i/d/fLMif9g==
X-Received: by 2002:a5d:6708:0:b0:2f7:8f62:1a45 with SMTP id o8-20020a5d6708000000b002f78f621a45mr1532057wru.66.1681816093622;
        Tue, 18 Apr 2023 04:08:13 -0700 (PDT)
Received: from redhat.com ([2.52.136.129])
        by smtp.gmail.com with ESMTPSA id z18-20020adfd0d2000000b002da75c5e143sm12849658wrh.29.2023.04.18.04.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:08:13 -0700 (PDT)
Date:   Tue, 18 Apr 2023 07:08:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if
 necessary
Message-ID: <20230418070640-mutt-send-email-mst@kernel.org>
References: <20230418085030.2154918-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418085030.2154918-1-imammedo@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 18, 2023 at 10:50:30AM +0200, Igor Mammedov wrote:
> When using ACPI PCI hotplug, hotplugging a device with
> large BARs may fail if bridge windows programmed by
> firmware are not large enough.
> 
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

And I think:

Fixes: d66ecb7220a7 ("PCI / ACPI: Use boot-time resource allocation rules during hotplug")


> ---
> tested in QEMU with Q35 machine on PCIE root port and also
> with nested conventional bridge attached to root port.
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..9aebde28a92f 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				}
>  			}
>  		}
> -		__pci_bus_assign_resources(bus, &add_list, NULL);
> +		pci_assign_unassigned_bridge_resources(bus->self);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);
> -- 
> 2.39.1

