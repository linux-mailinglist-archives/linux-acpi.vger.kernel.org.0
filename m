Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D801C3A3491
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFJUI4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 16:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhFJUI4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 16:08:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD1C061574
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 13:06:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 11so1625314plk.12
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKsgQ7BRGtjEa1Ou+HuJvcTs+5swgCb2B/IPdm9zxRY=;
        b=leeOmSzcNiA7y4GEQg+I9bSEiLFWkXFJwXql1uqUwgm2PQxqFpY8ztdC/6EOmhPgnJ
         aYFt4CTufSw2yO9Mb8C6NwPeYqwirZJz9pth5gAVf1OcZAfF0zK58crJo47GeCQ2Go+u
         KIlTy5dnWycRhaXR0l0ofxm+w/E80QYFrFOx+HM148HiU45Wz6of0C7Xu/q4nXUSlQpx
         1hcEsbGpGgUuMx8pIw6sMoR0akpXNS+as5LqxoqTqjL6FQdBCSqYkoRKtg0pBaYgf3Qv
         8ZRoKprPgA0V28YdVxfWW0myhj1B4JnRS7E2XSuruhGVmVuVl2UIXWiQd7exOx9B9Kkx
         riig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKsgQ7BRGtjEa1Ou+HuJvcTs+5swgCb2B/IPdm9zxRY=;
        b=qeQl/OriFK4gaj2DGtzqDfnwnigUDLS0z6poTsccEDtauYXHgkfFECDQRE1fjdHqF2
         X7jvuW9EszAkO/3ULJ7VaNk+1yNxOjSsluPZPHOhr0kzxeOnh4q8ufjTnN7o/Gt43ibm
         aS+sjhhnGlIi2UxTsF8v9u1pYtwSUKKzshmwRHrSSFZ3x40EOi+rdBwyxe9oSLd4sVox
         SCnAm6+tMwD5btmtfNhRBPwN6rS3/giADL0J6iU5RQ+WxVK6otvrooykthENYeckX636
         zys6IVllFMe1ij1xNrKlU79lXJER+nKtP1rOsV9pWcWFKyVY/vwGhuMsfDTn7Lz/1bWS
         2Q+Q==
X-Gm-Message-State: AOAM533F3fQEKYCCK+C5i7HqG8vd4wBqZG02/NNjqAB7KmyUebUAJVO/
        qrIxYhLTbPv2T6LPp1RzbSraEEwVfhWXvhGSrtrqiQ==
X-Google-Smtp-Source: ABdhPJz6wmUU+rOu0/RDkASZwBX1XFszYUwrpjXk+vt72BjnsIr5mhgjvJScPGDsB78w/srz5aLN2MQlSetr4zuidcI=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr5197874pjb.13.1623355619412;
 Thu, 10 Jun 2021 13:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com> <20210524133938.2815206-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20210524133938.2815206-3-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Jun 2021 13:06:48 -0700
Message-ID: <CAPcyv4gBORHzouArX-Fsnhew+ZYur8pp9ySJQGwrOBrGuv+-ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] PCI/DOE: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Introduced in a PCI ECN [1], DOE provides a config space based mailbox with
> standard protocol discovery.  Each mailbox is accessed through a DOE
> Extended Capability.
>
> A device may have 1 or more DOE mailboxes, each of which is allowed to
> support any number of protocols (some DOE protocol specifications apply
> additional restrictions).  A given protocol may be supported on more than
> one DOE mailbox on a given function.
>
> If a driver wishes to access any number of DOE instances / protocols it
> makes a single call to pci_doe_register_all() which will find available
> DOEs, create the required infrastructure and cache the protocols they
> support.  pci_doe_find() can then retrieve a pointer to an appropriate DOE
> instance.
>
> A synchronous interface is provided in pci_doe_exchange_sync() to perform a
> single query / response exchange.
>
> Testing conducted against QEMU using:
>
> https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/

Nice.

I was hoping that by now QEMU upstream would have given us some
indication that this useful work that has a chance of being merged. I
fear it's only us CXL practitioner's that care. Perhaps the PCI IDE
support will get them to move on at least the DOE patches?

>
> [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
>     Data Object Exchange (DOE) - Approved 12 March 2020
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The core logic of this looks good to me. The interfaces for other code
to make use of this I feel can lean heavier on existing mechanics. A
few points come to mind:

- Does this need to support anything more than queue depth 1? I know
the specification seems to allow for some overlapping and queueing,
but I don't think there are any use cases that are precluded if the
max number of tasks in flight for a given DOE is one.

- Once its queue depth 1 then the list of tasks can be replaced with a
wait_queue_head_t where submitters wait for the previous task to
finish.

- This appears to be the prototypical scenario for deploying the new
auxiliary bus facility. Rather than custom code device-like facilities
(lists and parents etc) in 'struct pci_doe' just make pci_doe a device
directly (auxiliary-device) and separate the infrastructure that
drives that device to a driver (auxiliary-driver). That makes the
lifetime management more idiomatic, allows for user space to have
typical driver-binding controls to manage kernel-user DOE conflicts,
and it allows for typical driver services like devm.
