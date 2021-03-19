Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED96341A8C
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 12:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCSK7a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 06:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhCSK7E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 06:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616151543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTtCoj7GiAxnLlyHTKHV8c52HQXk/FzWNNseSEaUuVo=;
        b=F7cHHbAyf4XYABcjbaUd8HtYAMzm6IzW3UFODd3UeAEaZ8i//IcFkXg4ScXTpvoubuT3IC
        ubk2GLMh0nKmb/HoQyh8ioyDBXNINdMxZfPbP3mhcJqHx9vIrfRHcGU6wm0+EomE9XCO6t
        sFbvZR3bZOdK618B2LFMMxgh+Eh9H1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-m6o5VM7IOxGPZsaMPWwlbg-1; Fri, 19 Mar 2021 06:59:00 -0400
X-MC-Unique: m6o5VM7IOxGPZsaMPWwlbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FE245B362;
        Fri, 19 Mar 2021 10:58:58 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 524DB5D72E;
        Fri, 19 Mar 2021 10:58:51 +0000 (UTC)
Subject: Re: [PATCH 0/3] Add support for ACPI VIOT
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <e7291605-88ca-6e55-11ec-574b2f94cefa@redhat.com>
Date:   Fri, 19 Mar 2021 11:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316191652.3401335-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 3/16/21 8:16 PM, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which enables virtio-iommu on
> non-devicetree platforms, including x86. This series depends on the
> ACPICA changes of patch 1, which will be included in next release [1]
> and pulled into Linux.
> 
> The Virtual I/O Translation table (VIOT) describes the topology of
> para-virtual I/O translation devices and the endpoints they manage.
> It was recently approved for inclusion into the ACPI standard [2].
> A provisional version of the specification can be found at [3].
> 
> After discussing non-devicetree support for virtio-iommu at length
> [4][5][6] we concluded that it should use this new ACPI table. And for
> platforms that don't implement either devicetree or ACPI, a structure
> that uses roughly the same format [6] can be built into the device.
> 
> [1] https://github.com/acpica/acpica/pull/666
> [2] https://lore.kernel.org/linux-iommu/20210218233943.GH702808@redhat.com/
> [3] https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> [4] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> [5] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> [6] https://lore.kernel.org/linux-iommu/20200821131540.2801801-1-jean-philippe@linaro.org/

Do you have a qemu branch to share for us to start exercising different
kinds of topology?

Thanks

Eric
> 
> Jean-Philippe Brucker (3):
>   ACPICA: iASL: Add definitions for the VIOT table
>   ACPI: Add driver for the VIOT table
>   iommu/virtio: Enable x86 support
> 
>  drivers/acpi/Kconfig         |   3 +
>  drivers/iommu/Kconfig        |   4 +-
>  drivers/acpi/Makefile        |   2 +
>  include/acpi/actbl3.h        |  67 ++++++
>  include/linux/acpi_viot.h    |  26 +++
>  drivers/acpi/bus.c           |   2 +
>  drivers/acpi/scan.c          |   6 +
>  drivers/acpi/viot.c          | 406 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/virtio-iommu.c |   3 +
>  MAINTAINERS                  |   8 +
>  10 files changed, 526 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/viot.c
> 

