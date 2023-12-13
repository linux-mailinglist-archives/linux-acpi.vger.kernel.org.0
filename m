Return-Path: <linux-acpi+bounces-2353-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA0810DDC
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 11:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8431C20984
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE172233B;
	Wed, 13 Dec 2023 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGesFVT2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214CDD0
	for <linux-acpi@vger.kernel.org>; Wed, 13 Dec 2023 02:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702461963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xn1jEdk27xv+fw6ihije0awyyp3dKSt8aX+E0LMVgl4=;
	b=OGesFVT2fkGvwRBvfbWwHpeaVVtPl66oWdkykV+b9Q2EnoIuPMqTfmMsW2ori4I3lBqUwo
	Lu/FyyJZlX1SD3AyWFxEyPAHb93FlJ1+V21w8PWMezwCGl2OgDCQJabJSag77BLQABZk0d
	QqmLwGIR8zrAZ+jdsRJys6JaydDmc/U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-d4-rFdC5Mi6vxGb76rIxKQ-1; Wed, 13 Dec 2023 05:06:01 -0500
X-MC-Unique: d4-rFdC5Mi6vxGb76rIxKQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1d7df84935so392558766b.3
        for <linux-acpi@vger.kernel.org>; Wed, 13 Dec 2023 02:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461959; x=1703066759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xn1jEdk27xv+fw6ihije0awyyp3dKSt8aX+E0LMVgl4=;
        b=pZzg7jf3ipPzoulfM3lBrwYCKzV9PhjclzQMbXmCtjw435bMKXiqnMG+LE9s4lphHL
         hdjfhHkSMz2szJ9uiQ1wqSZoWzcfO8cROa1ik8U6Sklftio6B0I9cQntD4Kl4baWmPQz
         VOgIQqx5AJLwVKKmUZqc0Eo/4LbX5r3ZpR4TPogtolJesswmgnwn8HBsTlK9Am5O0tws
         Y70gXWpVBdjziUJEeh9Z3+Z0xvJodSWyKRa+Lg3XlV8jh9Fna1jxZao6fXZJEDGU00wz
         iyTFk0FKxekWe3hFZFJEH4Ia5vLTGaeBDQ4s3sBhP7JuTA9LOxhJCQEtINfGU8M9tjfj
         JlyQ==
X-Gm-Message-State: AOJu0Yx5tBhwP4G6/P+bELvgrmfPDS4r5huRWfcTwgTVazllh5GRtylO
	52fbnzWC5j8ztGOPb+ZJEbyYU9/vw+OvUo9aMk54kmepikt1UnJmzW7RD8F3OGEf2jKBkpfAxNG
	kbhEfaf2nBkhQeRYKlq3q9gkWi/jL7g==
X-Received: by 2002:a17:906:c019:b0:a1b:86e2:a1ab with SMTP id e25-20020a170906c01900b00a1b86e2a1abmr2567531ejz.223.1702461959005;
        Wed, 13 Dec 2023 02:05:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZYT5Bvuxw2XfH2SIkWB1x7mzcXJCq+ITRe/p2JW4K3jZB3t+Oz+dOz0ZfsQ43uci8yyjdFw==
X-Received: by 2002:a17:906:c019:b0:a1b:86e2:a1ab with SMTP id e25-20020a170906c01900b00a1b86e2a1abmr2567517ejz.223.1702461958642;
        Wed, 13 Dec 2023 02:05:58 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id fb4-20020a1709073a0400b00a1c76114fcesm7513801ejc.218.2023.12.13.02.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:05:58 -0800 (PST)
Date: Wed, 13 Dec 2023 11:05:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com,
 rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
 joe.jin@oracle.com, stable@vger.kernel.org, Fiona Ebner
 <f.ebner@proxmox.com>, Thomas Lamprecht <t.lamprecht@proxmox.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging
 multiple devices at a time
Message-ID: <20231213110556.5f1d83bf@imammedo.users.ipa.redhat.com>
In-Reply-To: <d93c4614-1bbc-3a30-305e-28ff75d7fde2@oracle.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
	<20231213003614.1648343-3-imammedo@redhat.com>
	<d93c4614-1bbc-3a30-305e-28ff75d7fde2@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 00:13:37 -0800
Dongli Zhang <dongli.zhang@oracle.com> wrote:

> Hi Igor,
> 
> 
> On 12/12/23 16:36, Igor Mammedov wrote:
> > previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> > introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> > bridge reconfiguration in case of single HBA hotplug.
> > However in virt environment it's possible to pause machine hotplug several
> > HBAs and let machine run. That can hit the same race when 2nd hotplugged  
> 
> Would you mind helping explain what does "pause machine hotplug several HBAs and
> let machine run" indicate?

qemu example would be:
{qemu) stop
(qemu) device_add device_add vhost-scsi-pci,wwpn=naa.5001405324af0985,id=vhost01,bus=bridge1,addr=8
(qemu) device_add vhost-scsi-pci,wwpn=naa.5001405324af0986,id=vhost02,bus=bridge1,addr=0
(qemu) cont

this way when machine continues to run acpiphp code will see 2 HBAs at once
and try to process one right after another. So [1/2] patch is not enough
to cover above case, and hence the same hack SHPC employs by adding delay.
However 2 separate hotplug events as in your reproducer should be covered
by the 1st patch.

> Thank you very much!
> 
> Dongli Zhang
> 
> > HBA will start re-configuring bridge.
> > Do the same thing as SHPC and throttle down hotplug of 2nd and up
> > devices within single hotplug event.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 6b11609927d6..30bca2086b24 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> > +#include <linux/delay.h>
> >  
> >  #include "../pci.h"
> >  #include "acpiphp.h"
> > @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
> >  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> >  {
> >  	struct acpiphp_slot *slot;
> > +        int nr_hp_slots = 0;
> >  
> >  	/* Bail out if the bridge is going away. */
> >  	if (bridge->is_going_away)
> > @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> >  
> >  			/* configure all functions */
> >  			if (slot->flags != SLOT_ENABLED) {
> > +				if (nr_hp_slots)
> > +					msleep(1000);
> > +
> > +                                ++nr_hp_slots;
> >  				enable_slot(slot, true);
> >  			}
> >  		} else {  
> 


