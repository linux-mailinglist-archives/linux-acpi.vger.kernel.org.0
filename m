Return-Path: <linux-acpi+bounces-2202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A12D4808D6A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Dec 2023 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EF11F211AF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Dec 2023 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88D46B9F
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Dec 2023 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVI0H/Qj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDD128
	for <linux-acpi@vger.kernel.org>; Thu,  7 Dec 2023 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701960946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tz6X+bifKo7AdaGetM0WimZ3DgQEAXtIAzsWo7qdtOo=;
	b=XVI0H/QjyfVRqYDiLCS0RgsVwL/uooZJjU2lJ7DzMkQtDm9TW7AavEM6VM/4mdCcmwFJfF
	pHsBskW+UqiyHqDGX7H8AbF12LrDi9maSU56bwdzgfc6qxA4UMar826+lFgj6likufeRqB
	R5bhWh/yFksFsG7Py9+7MERA1elcIsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-_VdegiGzNrW5VXUrSIYJfA-1; Thu, 07 Dec 2023 09:55:45 -0500
X-MC-Unique: _VdegiGzNrW5VXUrSIYJfA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c0f21a649so9312285e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 Dec 2023 06:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960944; x=1702565744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz6X+bifKo7AdaGetM0WimZ3DgQEAXtIAzsWo7qdtOo=;
        b=MNFoJgRkwEMopGYTYTEtAknOm22rlrmNCMvrvR/tOOHWnwbCEINjEKSnrzz/ox+P99
         +ND+AJo1MJitYf7hVOicTQ0B2vaOrAndLkUw0eWTdbx/fvHKgIUjwNzeFkR7AghA5Vwg
         8OGTaAX6jhAxdmbUvyzeLdjkadIfwmgL0LWKF+xQRE8uXLZryLpwNO0IsH4IYCV4jNTZ
         9rRJqoqaTJmYXloJ87n3jP0ei9EgsgEaTLPFVcdxkidRAiTQVrR7jnph8D2jbJQkyL1w
         dTyZ+CAbCZxSKtAeRr3IZ+qDWac+a+OTAyXNSlRsac42BR8ouEOmxhqGRBFEGBXzsC0z
         VOUg==
X-Gm-Message-State: AOJu0YzeZuPjjKm2Cxm4tVlikXq5nm9jyUZyF047n/F/MK7cbChhSU2o
	T1CV3CCk5mJqHvRrYE3ZkLKTtOXY4SCw9SpJQc+saBXgF/T1njH88xwDFTaGoOWGAbMJ5FH2rWw
	mL/anx2Od48dkVbqZ3sxAlA==
X-Received: by 2002:a05:600c:198b:b0:40b:5e21:dd34 with SMTP id t11-20020a05600c198b00b0040b5e21dd34mr2068542wmq.98.1701960943983;
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqPu0jtkLU9hMN3uH/bMY5VhR71AQ+5SLWqCAxzRD+0Q/xUOdmx8munOvaO4iPnv+olLoNZQ==
X-Received: by 2002:a05:600c:198b:b0:40b:5e21:dd34 with SMTP id t11-20020a05600c198b00b0040b5e21dd34mr2068529wmq.98.1701960943567;
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906208300b00a1e04f24df1sm918499ejq.223.2023.12.07.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
Date: Thu, 7 Dec 2023 15:55:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231207155541.735e0055@imammedo.users.ipa.redhat.com>
In-Reply-To: <4dbc72ba-8edb-4ff5-b95d-b601189e4415@proxmox.com>
References: <20231130231802.GA498017@bhelgaas>
	<4dbc72ba-8edb-4ff5-b95d-b601189e4415@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 10:24:41 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 01.12.23 um 00:18 schrieb Bjorn Helgaas:
> > On Wed, Nov 29, 2023 at 04:22:41PM +0100, Fiona Ebner wrote:  
> >> Hi,
> >> it seems that hot-plugging SCSI disks for QEMU virtual machines booting
> >> with UEFI and with guest kernels >= 6.5 might be broken. It's not
> >> consistently broken, hinting there might be a race somewhere.
> >>
> >> Reverting the following two commits seems to make it work reliably again:
> >>
> >> cc22522fd55e2 ("PCI: acpiphp: Use
> >> pci_assign_unassigned_bridge_resources() only for non-root bus")
> >> 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"
> >>
> >> Of course, they might only expose some pre-existing issue, but this is
> >> my best lead. See below for some logs and details about an affected
> >> virtual machine. Happy to provide more information and to debug/test
> >> further.  
> > 
> > Shoot.  Thanks very much for the report and your debugging.  I'm
> > hoping Igor will chime in with some ideas.
> > 
> > Both of those commits appeard in v6.5 and fixed legit issues, so I
> > hate to revert them, but this does appear to be a regression.
> > 
> > #regzbot introduced: cc22522fd55e2 ^
> > #regzbot introduced: 40613da52b13f ^
> >   
> >> Host kernel: 6.5.11-4-pve which is based on the one from Ubuntu
> >> Guest kernel: 6.7.0-rc3 and 6.7.0-rc3 with above commits reverted
> >> QEMU version: v8.1.0 built from source
> >> EDK2 version: submodule in the QEMU v8.1 repository: edk2-stable202302
> >>  
> 
> I should mention that I haven't run into the issue when booting the VM
> with SeaBIOS yet.
> 
> Log for 6.7.0-rc3 + SeaBIOS (bundled with QEMU 8.1):
> 
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xfd404000-0xfd407fff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xfe801000-0xfe801fff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > Dec 01 10:08:08 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > Dec 01 10:08:08 hotplug kernel: scsi host3: Virtio SCSI HBA
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> > Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Attached scsi generic sg1 type 0
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk  
> 
> Interestingly, the line with "QEMU HARDDISK" does not come after all
> lines with "bridge window" like was the case for the one time it did
> work with UEFI. So maybe that was just a red herring.

I've just seen this,
let me try to reproduce and see what can be done with it.

> 
> Best Regards,
> Fiona
> 


