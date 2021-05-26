Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F73920D0
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhEZT0t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhEZT0s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 15:26:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518AC06175F
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 12:25:15 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b81so2244296iof.2
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=izmyF5lXZ6T+Ih81ROoFBWGYSX359TfngCEeuMk/7tw=;
        b=kMT8SVDJjaBto+io7zebuCCqledUf8nh4myBvhiKUjQphfgDe7/5JIOaMq3TeL2vli
         lGZSIEPGc5X7c2WAvwLO0tfc2FNWGgydkFVNt02Ogh4fov63BJn270+3sWaPdKFGgM0Z
         TeSGT3og1EXgFByRnd3ZSqx1UxiS33o0w7vjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=izmyF5lXZ6T+Ih81ROoFBWGYSX359TfngCEeuMk/7tw=;
        b=P814WBDoaKDhuyg0uejmi5fEh24zZ0jORdi4hx3CChrPgSmGcSdjil6zsgvqHpKjQ+
         8WtgyvsRC/yBgntpXeuxHqzTh802rSyyBjeoz32tyGpT3+bfy0S3MBK1pxzR+kYpnQkU
         a2AEyi7b7Mbt654NxezHyoE1zP3Lzm/D5nOnm32P8HoPwsNkVl/oE3MPWELMPE1dYXGY
         P8ObUNjxLwwpBnG8UBvoXsbVtg08XDLih5kvk7MkH8pBlqwDQuDBIn9ang37kmdWok3R
         HI3gTnbH1sF6kIbHu2oszv8fIMbvr7Bh9KsqFSvN6U/captaCdb/tpmOVO8KM+0EO+zu
         PaSg==
X-Gm-Message-State: AOAM533ghg3tEQpg/+9oL4gGJDftk9CO3IafZ+k08sYjMOnZ8bQrQ8JS
        OJX3QeP0qcLDA5Y+8x8VMqflhzOUDa4SSg==
X-Google-Smtp-Source: ABdhPJxCtegg75Nne7R6DXMK3EvcaNHbzYsgBnTRD663faG7Iz3QuT5u01nw0IQsC+K5QxYFkrdv2A==
X-Received: by 2002:a02:b78c:: with SMTP id f12mr4804493jam.7.1622057114750;
        Wed, 26 May 2021 12:25:14 -0700 (PDT)
Received: from google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id b189sm113428iof.48.2021.05.26.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 12:25:14 -0700 (PDT)
Date:   Wed, 26 May 2021 13:25:12 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        dan.j.williams@intel.com, shyjumon.n@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable
 property
Message-ID: <YK6gmAWqaRmvpJXb@google.com>
References: <20200702225011.10932-1-david.e.box@linux.intel.com>
 <20200709184333.6241-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709184333.6241-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 09, 2020 at 11:43:33AM -0700, David E. Box wrote:
> +#ifdef CONFIG_ACPI
> +static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> +{
> +	const struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	struct pci_dev *root;
> +	acpi_handle handle;
> +	acpi_status status;
> +	u8 val;
> +
> +	/*
> +	 * Look for _DSD property specifying that the storage device on
> +	 * the port must use D3 to support deep platform power savings during
> +	 * suspend-to-idle
> +	 */
> +	root = pcie_find_root_port(dev);
> +	if (!root)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&root->dev);
> +	if (!adev)
> +		return false;
> +
> +	/*
> +	 * The property is defined in the PXSX device for South complex ports
> +	 * and in the PEGP device for North complex ports.
> +	 */
> +	status = acpi_get_handle(adev->handle, "PXSX", &handle);
So I'm curious why we need to directly look at the PXSX and PEGP
devices instead of the ACPI_COMPANION node attached to the pci device?

I've looked around and I can't find any documentation that defines the
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

> +	if (ACPI_FAILURE(status)) {
> +		status = acpi_get_handle(adev->handle, "PEGP", &handle);
> +		if (ACPI_FAILURE(status))
> +			return false;
> +	}
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return false;
> +
> +	fwnode = acpi_fwnode_handle(adev);
> +
> +	return fwnode_property_read_u8(fwnode, "StorageD3Enable", &val) ?
> +		false : val == 1;
> +}

Thanks,
Raul

p.s., Sorry for the second message, I somehow mangled the headers in the
first message and dropped the Message-Id.
