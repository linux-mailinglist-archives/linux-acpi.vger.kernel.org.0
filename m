Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02E570C6C9
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjEVTW2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjEVTW2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 15:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32FCF
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2023 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684783298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19CMbyqGYx+dTe/70Tt+e3xVM/rvt5nddSdllvKHLqA=;
        b=cDxWis4FegcULbzPGoLlSX66aw8fHtosC/YwlGh0O5Gg1G1R6Y/bOH6Q/7Q6w5lmmC1TXh
        D5yR+VACRH6G5tplnwm/XA8tNjYJbA1eZkioB9cguU0CNVc07Gy9SrP0YxCapEqZCsqHQS
        DL7Lc8vNjkEbQ1RYtVEjUPa+Q1/sMlM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-LCqs6jJ_NEmYs1eclTt7_A-1; Mon, 22 May 2023 15:21:36 -0400
X-MC-Unique: LCqs6jJ_NEmYs1eclTt7_A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3094b683f3dso1907374f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2023 12:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783295; x=1687375295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19CMbyqGYx+dTe/70Tt+e3xVM/rvt5nddSdllvKHLqA=;
        b=hgI/EfcuPavfnv6Q+s6nDgVYrwkJ8ZKDhnLgVe7iYzwVoF7q7baiep7SfPVP0JvrL9
         B3BA9LhPJUqhfXMHZp4GxFnQcpY08bc+2jOG7eVdhdyo3nI4XVTbL8RopY4zRdWEXm+G
         2qU6qs7uLNRK2+ypv9jCYmFsHM5oRHmDS2QZYPrw4+0vq340w6HR+pTiMLcgQVvjVH0y
         Aa6McuvoMz7eQ1EMky8Ojy6W1dpKWNUZ9KU9RQtVcK4hMoqS0shSRWHK+Gzml1sE0wD3
         ebj/7FB92sejLuxgMTHhKT2Ey7CJEmwvdiXfOcWSUXTnaKV1D1YjQrtZfzObNpTTYrnv
         6cWw==
X-Gm-Message-State: AC+VfDyqPsidO9GPu65q4LJsSGmu2HkTZA1EZKL1egfEoqcqQ6XlcVzJ
        LW7Wtlh4p/0KsJ1V27kpqUPoZkD2bTidA6kjMDf4kwggrBDAxoeZy8X2LEEiSZ6IiNUNbXHj6pN
        2iOWw6CBHiujfJidFFD1DvA==
X-Received: by 2002:adf:db46:0:b0:2fb:87f7:3812 with SMTP id f6-20020adfdb46000000b002fb87f73812mr8907210wrj.1.1684783295418;
        Mon, 22 May 2023 12:21:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6kIIq5uetcGP+KQsLYXRS4iGfwi1QtzdCKHvoC7OvlwQh1dgXKBPsat1cRNlG/p+vSiuUceA==
X-Received: by 2002:adf:db46:0:b0:2fb:87f7:3812 with SMTP id f6-20020adfdb46000000b002fb87f73812mr8907196wrj.1.1684783295050;
        Mon, 22 May 2023 12:21:35 -0700 (PDT)
Received: from redhat.com ([2.52.20.68])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d660a000000b003063a92bbf5sm8661795wru.70.2023.05.22.12.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:21:34 -0700 (PDT)
Date:   Mon, 22 May 2023 15:21:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230522152054-mutt-send-email-mst@kernel.org>
References: <20230424191557.2464760-1-imammedo@redhat.com>
 <20230522130635.5e3f8771@imammedo.users.ipa.redhat.com>
 <CAJZ5v0jcap1Qe=PeZ98csqN9DxwZLPRontGkbvMuah6XrtbT4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jcap1Qe=PeZ98csqN9DxwZLPRontGkbvMuah6XrtbT4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 22, 2023 at 01:52:33PM +0200, Rafael J. Wysocki wrote:
> On Mon, May 22, 2023 at 1:06 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Mon, 24 Apr 2023 21:15:57 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > > When using ACPI PCI hotplug, hotplugging a device with
> > > large BARs may fail if bridge windows programmed by
> > > firmware are not large enough.
> >
> > Rafael,
> >
> > Since there was no more comments for a while,
> > can you merge this patch through your tree?
> 
> I need an ACK from Bjorn on this, as the PCI maintainer, or it can go
> in via the PCI tree as far as I'm concerned.
> 
> Thanks!

I'd also like an ACK for:
Cc: stable@vger.kernel.org



> > > Reproducer:
> > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> > >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> > >       disk_image
> > >
> > >  wait till linux guest boots, then hotplug device
> > >    (qemu) device_add qxl,bus=rp1
> > >
> > >  hotplug on guest side fails with:
> > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> > >    Unable to create vram_mapping
> > >    qxl: probe of 0000:01:00.0 failed with error -12
> > >
> > > However when using native PCIe hotplug
> > >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> > > it works fine, since kernel attempts to reassign unused resources.
> > > Use the same machinery as native PCIe hotplug to (re)assign resources.
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > tested in QEMU with Q35 machine on PCIE root port and also
> > > with nested conventional bridge attached to root port.
> > >
> > > v2:
> > >   * fixup subject to match expected style
> > >   * drop no longer needed __pci_bus_size_bridges() to avoid
> > >     memory leak (Bjorn Helgaas <helgaas@kernel.org>)
> > > ---
> > >  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > > index 5b1f271c6034..328d1e416014 100644
> > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > @@ -498,7 +498,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> > >                               acpiphp_native_scan_bridge(dev);
> > >               }
> > >       } else {
> > > -             LIST_HEAD(add_list);
> > >               int max, pass;
> > >
> > >               acpiphp_rescan_slot(slot);
> > > @@ -512,12 +511,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> > >                               if (pass && dev->subordinate) {
> > >                                       check_hotplug_bridge(slot, dev);
> > >                                       pcibios_resource_survey_bus(dev->subordinate);
> > > -                                     __pci_bus_size_bridges(dev->subordinate,
> > > -                                                            &add_list);
> > >                               }
> > >                       }
> > >               }
> > > -             __pci_bus_assign_resources(bus, &add_list, NULL);
> > > +             pci_assign_unassigned_bridge_resources(bus->self);
> > >       }
> > >
> > >       acpiphp_sanitize_bus(bus);
> >

