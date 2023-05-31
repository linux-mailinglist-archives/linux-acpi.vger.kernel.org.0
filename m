Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E871863B
	for <lists+linux-acpi@lfdr.de>; Wed, 31 May 2023 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjEaPY3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 May 2023 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjEaPX5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 May 2023 11:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACFE10D1
        for <linux-acpi@vger.kernel.org>; Wed, 31 May 2023 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685546559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vim2Ps+SLhIjHN6Pns9HoI/IKeD0F9kbBagSaUaU/oo=;
        b=aneP2FQbmG1uu3jDL1PsXxIxxEZkUSlVgKT6HsaC/mzzVojPaGvHHM+chP34cAr032dOva
        vxMoDTNBrsWBJfRw4M4pZfIRltvbDCBB3iJ1d19RnEoxkp7HRDEXoSzYrmEm/Z5i/mIJ0b
        CF+sAGyW5LxySRzI/V6aZhbrQ/IVoRM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-PW3UQShBO32h87TeGE6chA-1; Wed, 31 May 2023 11:22:35 -0400
X-MC-Unique: PW3UQShBO32h87TeGE6chA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34e35f57so494157866b.3
        for <linux-acpi@vger.kernel.org>; Wed, 31 May 2023 08:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546554; x=1688138554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vim2Ps+SLhIjHN6Pns9HoI/IKeD0F9kbBagSaUaU/oo=;
        b=LrrNlBP3KbQhGPHFQ+F51pg+0Mk8lZDPM8hOH5sdZzC0bRpg79rg5XIC8V6y9cG0cF
         nNWrbINpO5dlsgnrEcRBUQVjoWiouKnQw+A4wIO74Sr7TkhKdElFM+/fiDmYfoKa5Bsk
         bU5FGcrid5EZleHNNlkAqKjt5VKfIdCSnWzdxXvQwNt+Ler2DmcoRiX7agFNUBjcyJtV
         /z3zhzdmayy/wLQmJaiXraskJ2ctHySZ+Hp+6nkDG6oGjtE585XnEg9pXNk/EgweBVtz
         8QtZEr2VfaTgyDO8igNcvSnUetFSFi2hzYDqGfh6onzEz1I5d1YzdgK6AqgM+CXCE1NZ
         e6Vg==
X-Gm-Message-State: AC+VfDyV6iqhqABJKmScN5p47fk4GKxNHRgSp3rRTUP4hV0VpT8k7ws1
        sKB8sU4s7/RMLINZRDcjnSZLZ92hU7k8m0YUXaR+fheCXIRiB1kn7yaQ/vUNjXm7u+ot3Pf+nLC
        ZKUqq6HIWpkKb+bOU2z81bQ==
X-Received: by 2002:a17:907:eaa:b0:94f:7edf:8fa1 with SMTP id ho42-20020a1709070eaa00b0094f7edf8fa1mr6008753ejc.32.1685546554646;
        Wed, 31 May 2023 08:22:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TfEMtyNeDIvoDZLtn9WZ6Ma5SEXbIKcUctEw0dFKuBxjkH16CQD3dCFTlwdMhGDeLM5IZ0g==
X-Received: by 2002:a17:907:eaa:b0:94f:7edf:8fa1 with SMTP id ho42-20020a1709070eaa00b0094f7edf8fa1mr6008739ejc.32.1685546554329;
        Wed, 31 May 2023 08:22:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906089500b00966265be7adsm9112590eje.22.2023.05.31.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:22:33 -0700 (PDT)
Date:   Wed, 31 May 2023 17:22:32 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230531172232.28cef6a3@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZHZGkAg34ltZLV9J@bhelgaas>
References: <20230530141321-mutt-send-email-mst@kernel.org>
        <ZHZGkAg34ltZLV9J@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 30 May 2023 13:55:12 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, May 30, 2023 at 02:16:36PM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 30, 2023 at 12:12:44PM -0500, Bjorn Helgaas wrote:  
> > > On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:  
> > > > When using ACPI PCI hotplug, hotplugging a device with
> > > > large BARs may fail if bridge windows programmed by
> > > > firmware are not large enough.
> > > > 
> > > > Reproducer:
> > > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> > > >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> > > >       disk_image
> > > > 
> > > >  wait till linux guest boots, then hotplug device
> > > >    (qemu) device_add qxl,bus=rp1
> > > > 
> > > >  hotplug on guest side fails with:
> > > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> > > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)  
> > > 
> > > Ugh, I just noticed that we turned on PCI_COMMAND_MEMORY even though
> > > BARs 0 and 1 haven't been assigned.  How did that happen?  It looks
> > > like pci_enable_resources() checks for that, but there must be a hole
> > > somewhere.  
> > 
> > Maybe because BAR2 was assigned? I think pci_enable_resources just
> > does
> >                 if (r->flags & IORESOURCE_MEM)
> >                         cmd |= PCI_COMMAND_MEMORY;
> > in a loop so if any memory BARs are assigned then PCI_COMMAND_MEMORY
> > is set.  
> 
> It does, but it also bails out if it finds IORESOURCE_UNSET:
> 
>   pci_enable_resources()
>   {
>     ...
>     pci_dev_for_each_resource(dev, r, i) {
>       ...
>       if (r->flags & IORESOURCE_UNSET) {
>         pci_err(dev, "can't enable device: BAR %d %pR not assigned\n");
>         return -EINVAL;
>       }
>       ...
>       if (r->flags & IORESOURCE_MEM)
>         cmd |= PCI_COMMAND_MEMORY;
>     }
>     ...
>   }
> 
> I expected that IORESOURCE_UNSET would still be there from
> pci_assign_resource(), since we saw the "failed to assign" messages,
> but there must be more going on.

with current acpiphp code pci_assign_resource() isn't called,
instead it goes __pci_bus_assign_resources() route.

However I an reproduce similar issue with SHPC when using
hierarchy deeper than 1 bridge (for which relocation has never worked)

qemu-kvm -monitor stdio -M q35 -cpu host -enable-kvm  -m 4G \
   -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off \
   -device pcie-root-port,id=pr1,bus=pcie.0,chassis=4 \
   -device pcie-pci-bridge,id=br1,bus=pr1

hotplug device
  (qemu) device_add qxl,addr=1,bus=br1

shpchp 0000:01:00.0: Latch close on Slot(1)
shpchp 0000:01:00.0: Button pressed on Slot(1)
shpchp 0000:01:00.0: Card present on Slot(1)
shpchp 0000:01:00.0: PCI slot #1 - powering on due to button press
pci 0000:02:01.0: [1b36:0100] type 00 class 0x038000
pci 0000:02:01.0: reg 0x10: [mem 0x00000000-0x03ffffff]
pci 0000:02:01.0: reg 0x14: [mem 0x00000000-0x03ffffff]
pci 0000:02:01.0: reg 0x18: [mem 0x00000000-0x00001fff]
pci 0000:02:01.0: reg 0x1c: [io  0x0000-0x001f]
pci 0000:02:01.0: BAR 0: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 0: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 2: assigned [mem 0xfe600000-0xfe601fff]
pci 0000:02:01.0: BAR 3: assigned [io  0xc000-0xc01f]
                  ^^^^^^^^^^^
shpchp 0000:01:00.0: PCI bridge to [bus 02]
shpchp 0000:01:00.0:   bridge window [io  0xc000-0xcfff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe600000-0xfe7fffff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
PCI: No. 2 try to assign unassigned res
release child resource [mem 0xfe600000-0xfe601fff]
shpchp 0000:01:00.0: resource 8 [mem 0xfe600000-0xfe7fffff] released
shpchp 0000:01:00.0: PCI bridge to [bus 02]
shpchp 0000:01:00.0: BAR 8: no space for [mem size 0x0a000000]
shpchp 0000:01:00.0: BAR 8: failed to assign [mem size 0x0a000000]
pci 0000:02:01.0: BAR 0: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 0: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: no space for [mem size 0x04000000]
pci 0000:02:01.0: BAR 1: failed to assign [mem size 0x04000000]
pci 0000:02:01.0: BAR 2: no space for [mem size 0x00002000]
pci 0000:02:01.0: BAR 2: failed to assign [mem size 0x00002000]
shpchp 0000:01:00.0: PCI bridge to [bus 02]
shpchp 0000:01:00.0:   bridge window [io  0xc000-0xcfff]
shpchp 0000:01:00.0:   bridge window [mem 0xfe000000-0xfe1fffff 64bit pref]
qxl 0000:02:01.0: enabling device (0000 -> 0001)
                                           ^^^ IO res only
where:
  assign_requested_resources_sorted()
     ...
     if (pci_assign_resource())
        reset_resource(res);
reset wipes everything pci_assign_resource() has done for failing resources
leaving only assigned IO (on the 1st pass).
Then later pci_enable_device_flags() will build mask for available bars

        for (i = 0; i <= PCI_ROM_RESOURCE; i++)                                  
                if (dev->resource[i].flags & flags)                              
                        bars |= (1 << i);                                        
        for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++)           
                if (dev->resource[i].flags & flags)                              
                        bars |= (1 << i);

however since for failed MEM resources reset cleared flags along with everything else, 
above snippet will ignore MEM bars, leaving only assigned IO resource.
Then
   do_pci_enable_device() -> pcibios_enable_device() -> pci_enable_resources(,bars)
will happily succeed since mask tells it only to look into IO.

And well even if mask weren't excluding MEM ones, it won't help since
the resource was cleared out in assign_requested_resources_sorted().

Perhaps instead of playing with flags, we should somehow mark device
with unusable resources as disabled, and fail pci_enable_device() early.
(and also make sure its resources aren't accounted anymore on follow
up hotplug events to the bridge)

