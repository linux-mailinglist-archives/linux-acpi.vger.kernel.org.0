Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3DB391E71
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhEZRzU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhEZRzU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 13:55:20 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4CC061756
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 10:53:47 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so1848493oto.0
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vZCKY3BFEV3ZiEy80bW2ajC3tM0xA2I0IFhvVAC9rXE=;
        b=M8XucArjDI1a9EHFNJOOwkDqhNOXef5ebP5HPxsZCUDX7GN10nM6YKmc8EM03fZXnK
         tIfkFYuBb6r1AHSvW4AhDtV7SiDT4HMfyYCKz6CCtfUyioXuss4WrVHCFy8elvaoHG9i
         30WOPeVtjBJkJwyq5KaSV9qFGV7ga3KUPdQSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vZCKY3BFEV3ZiEy80bW2ajC3tM0xA2I0IFhvVAC9rXE=;
        b=WfzQoqoEo7hSVOWoWi71HsyXdsW9zL6pkvJx1SFdk4IPfMykDRJ9uV/O30ngMcECiv
         KPYjKv9zPWDe0CqHmzS+v56MuxY/vBzAy0y6lYPxSgopg3tnXuJZgyYuTZEt6IqbVKPD
         xtwd36sPZc6gYVWm9SNwoZCgt7yVujCKioR+FiQ7IBBtfUdP06KUbNyyEUtms2aHFHpN
         JHoO7vqebUsE6SUzUHsyR3bJE8qFDqLT2A3cngtCUsBOXqCjKao1H26pOIcQzCi/N4Sf
         lAQlJRTgRKwXdwRGN/Gvg6nag+PD2yyQVoMeCRHNKjevi01cgx2Q5cmG8WUn/YvOEVXD
         wUvw==
X-Gm-Message-State: AOAM533aNeYQDaFFLOdEUqFGM4M5BmRiOZOa8o1WlnNZn3JKQfjF7bK9
        vTIOUrnY4UC+1t5lp6GDxYVv+dR740A3zpeSWTocKA==
X-Google-Smtp-Source: ABdhPJzTzc5s/SSFQBKrdePe/tXsVR6ieBWsBMsswSN1CZ8llyzecXfqneZiX6WAD9lFGgJyEkHG+lFUcUSNcG8eQr4=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr3337585otl.311.1622051626791;
 Wed, 26 May 2021 10:53:46 -0700 (PDT)
MIME-Version: 1.0
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 26 May 2021 11:53:36 -0600
Message-ID: <CALRirFRy9ijyc2Du+z3589WtPD3xaOXeMHVdgUWSTDij-gq0=g@mail.gmail.com>
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable property
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, dan.j.williams@intel.com,
        shyjumon.n@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 09, 2020 at 11:43:33AM -0700, David E. Box wrote:
> +#ifdef CONFIG_ACPI
> +static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> +{
> +     const struct fwnode_handle *fwnode;
> +     struct acpi_device *adev;
> +     struct pci_dev *root;
> +     acpi_handle handle;
> +     acpi_status status;
> +     u8 val;
> +
> +     /*
> +      * Look for _DSD property specifying that the storage device on
> +      * the port must use D3 to support deep platform power savings during
> +      * suspend-to-idle
> +      */
> +     root = pcie_find_root_port(dev);
> +     if (!root)
> +             return false;
> +
> +     adev = ACPI_COMPANION(&root->dev);
> +     if (!adev)
> +             return false;
> +
> +     /*
> +      * The property is defined in the PXSX device for South complex ports
> +      * and in the PEGP device for North complex ports.
> +      */
> +     status = acpi_get_handle(adev->handle, "PXSX", &handle);
So I'm curious why we need to directly look at the PXSX and PEGP
devices instead of the ACPI_COMPANION node attached to the pci device?

I've looked around and I can't find any documentation that defines
the PXSX and PEGP device names.

I've dumped some ACPI from a system that uses the PXSX name and
StorageD3Cold attribute:

    Scope (\_SB.PCI0.GP14)
    {
        Device (PXSX)
        {
            Name (_ADR, 0x0000000000000000)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("5025030f-842f-4ab4-a561-99a5189762d0"),
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "StorageD3Enable",
                        One
                    }
                }
            })
        }
    }

It looks to me like it's just the firmware node for the NVMe device
attached to the root port. Is that the correct assumption?

I'm wondering if we can simplify the look up logic to look at the
ACPI_COMPANION of the pci device?

The reason I ask is that I'm working on enabling S0i3 on an AMD device.
This device also defines the StorageD3Enable property, but it don't use
the PXSX name:

    Scope (GPP6) {
        Device (NVME)
        {
            Name (_ADR, Zero)  // _ADR: Address

            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("5025030f-842f-4ab4-a561-99a5189762d0"),
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "StorageD3Enable",
                        One
                    }
                }
            })
        }
    }

The Windows
[documentation](https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro#d3-support)
makes it sound like the _DSD should be defined on the PCI device.

I can send one of the following patches depending on the feedback:
1) Additionally check the pci device's ACPI_COMPANION for the _DSD.
2) Delete the PXSX and PEGP lookups and only look at the pci device's
   ACPI_COMPANION.

> +     if (ACPI_FAILURE(status)) {
> +             status = acpi_get_handle(adev->handle, "PEGP", &handle);
> +             if (ACPI_FAILURE(status))
> +                     return false;
> +     }
> +
> +     if (acpi_bus_get_device(handle, &adev))
> +             return false;
> +
> +     fwnode = acpi_fwnode_handle(adev);
> +
> +     return fwnode_property_read_u8(fwnode, "StorageD3Enable", &val) ?
> +             false : val == 1;
> +}

Thanks,
Raul
