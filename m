Return-Path: <linux-acpi+bounces-2354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7806810DE4
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 11:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA481F21195
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2722333;
	Wed, 13 Dec 2023 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJrFESsm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E2A7
	for <linux-acpi@vger.kernel.org>; Wed, 13 Dec 2023 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702462055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdSkfSCIDP93EM+mxv9M+W9x4jK0YGjz6e+tBs7DUUU=;
	b=MJrFESsmgsStJEVeQGRSzw7jSqJQqakgDZoantISfiynw2zw0mbrN+96N/bb5freDVH7vw
	/rgAGd4tnm8dL73Lr9XoqCpKSFExQSRtDYDgJ6x6T/HDFX7p/L5h8tRKvCdd1odmkUxiVO
	t0cc3VsTZmt2bXpBE9MqrULdvlbDfF0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-JcXb8oTXN5GNSaKj5xKTzw-1; Wed, 13 Dec 2023 05:07:33 -0500
X-MC-Unique: JcXb8oTXN5GNSaKj5xKTzw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bf00775ecso6556948e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 13 Dec 2023 02:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462052; x=1703066852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdSkfSCIDP93EM+mxv9M+W9x4jK0YGjz6e+tBs7DUUU=;
        b=db/SDzuqvq24TlUYhokdSPWafOHQVVlIYQBvpnHUxVpaSe3E9xzK+wGaVMVcXuPEGa
         8RhuJhv+Ha6wAdv04A4sGxH/lFP0sEcEH5cljFp5C7afo2w7NSy3cWKHgmSonO/fhDyk
         pXHXC5/H7YDyFW+IaNDPJ9G0EkBOJqi9Ope818dHRKLqsdCZOKqONg4kuuzKCfONCKX/
         wmaX99QExjhgLTYKqnucOyAABuUqSERwnuLJQhQasIENZNJOYAljOk40VXsLDBYzcyI3
         UnJhF5n6uRE1qPz3kgi6dRZOdYx6mPPHvmDuDjRVWlTtmddLl3WNz1oVTc+lleFj3SDP
         bQdA==
X-Gm-Message-State: AOJu0YxY3D7aIauDzdrYLHEmlBQjffJJCPeSJYBDKH4KlNdyEOZgSKaU
	zwCU4kp5GCTwKyitujPOvawglWKi4b+PQoGe6zOfwurupoPG86ANErjkX9dVurn9cY6VTNrAzhJ
	1isnlVdKfc3QJkW/V3MVuUw==
X-Received: by 2002:a05:6512:104d:b0:50b:f380:5fad with SMTP id c13-20020a056512104d00b0050bf3805fadmr4913045lfb.87.1702462052213;
        Wed, 13 Dec 2023 02:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkYdiiq48AtFlXavTGhK5TgEnQUjes08MTe0tzKUxfAO2LnnNyQQT8kV1vdp+a/90HJ+pTfA==
X-Received: by 2002:a05:6512:104d:b0:50b:f380:5fad with SMTP id c13-20020a056512104d00b0050bf3805fadmr4913025lfb.87.1702462051861;
        Wed, 13 Dec 2023 02:07:31 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f45000000b0050bf06c8098sm1590674lfz.116.2023.12.13.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:07:31 -0800 (PST)
Date: Wed, 13 Dec 2023 11:07:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com,
 rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
 joe.jin@oracle.com, stable@vger.kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>
Subject: Re: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been
 enabled already
Message-ID: <20231213110729.3845f530@imammedo.users.ipa.redhat.com>
In-Reply-To: <501c1078-ef45-4469-87f8-32525d6f2608@proxmox.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
	<20231213003614.1648343-2-imammedo@redhat.com>
	<501c1078-ef45-4469-87f8-32525d6f2608@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 10:47:27 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 13.12.23 um 01:36 schrieb Igor Mammedov:
> > When SCSI_SCAN_ASYNC is enabled (either via config or via cmd line),
> > adding device to bus and enabling it will kick in async host scan
> > 
> >  scsi_scan_host+0x21/0x1f0
> >  virtscsi_probe+0x2dd/0x350
> >  ..
> >  driver_probe_device+0x19/0x80
> >  ...
> >  driver_probe_device+0x19/0x80
> >  pci_bus_add_device+0x53/0x80
> >  pci_bus_add_devices+0x2b/0x70
> >  ...
> > 
> > which will schedule a job for async scan. That however breaks
> > if there are more than one SCSI host behind bridge, since
> > acpiphp_check_bridge() will walk over all slots and try to
> > enable each of them regardless of whether they were already
> > enabled.
> > As result the bridge might be reconfigured several times
> > and trigger following sequence:
> > 
> >   [cpu 0] acpiphp_check_bridge()
> >   [cpu 0]   enable_slot(a)
> >   [cpu 0]     configure bridge
> >   [cpu 0]     pci_bus_add_devices() -> scsi_scan_host(a1)
> >   [cpu 0]   enable_slot(b)
> >   ...
> >   [cpu 1] do_scsi_scan_host(a1) <- async jib scheduled for slot a
> >   ...
> >   [cpu 0]     configure bridge <- temporaly disables bridge
> > 
> > and cause do_scsi_scan_host() failure.
> > The same race affects SHPC (but it manages to avoid hitting the race due to
> > 1sec delay when enabling slot).
> > To cover case of single device hotplug (at a time) do not attempt to
> > enable slot that have already been enabled.
> > 
> > Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> > Reported-by: iona Ebner <f.ebner@proxmox.com>  
> 
> Missing an F here ;)

Sorry for copypaste mistake, I'll fix it up on the next submission.

> 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Thank you! Works for me:
> 
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> 


