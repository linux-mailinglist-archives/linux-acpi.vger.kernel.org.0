Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4AD30A2AD
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 08:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBAH3v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 02:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230174AbhBAH3u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 02:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612164503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M16LXgfjhsKGuOXkKg0aEAVFa0oEYsjjqhuBQeuiHVY=;
        b=BD8aa01R73/6eDaFVKXM1pNCA7CIJG9KW+VbOfGH1dCEOLD7E4TuphoelOP9hJg1+IxCk3
        Y/0lKF5nA2bbzF1bwvF+XRS6TE0EX9+D/0F3hXycQ7E2SFoeSxSyOwj33yxIx3Dv4Gg521
        7IipFcvYAe2raEMZBFWu+8Rb4FCLNl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-_I4TR1CRN0C5u37sUiyijw-1; Mon, 01 Feb 2021 02:28:19 -0500
X-MC-Unique: _I4TR1CRN0C5u37sUiyijw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67551801817;
        Mon,  1 Feb 2021 07:28:16 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA69B70485;
        Mon,  1 Feb 2021 07:28:09 +0000 (UTC)
Subject: Re: [PATCH v12 08/10] dt-bindings: document stall property for IOMMU
 masters
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Rob Herring <robh@kernel.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-9-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <fa61a670-e11d-0493-a38f-132482b54e35@redhat.com>
Date:   Mon, 1 Feb 2021 08:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210127154322.3959196-9-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean-Philippe,

On 1/27/21 4:43 PM, Jean-Philippe Brucker wrote:
> On ARM systems, some platform devices behind an IOMMU may support stall,
> which is the ability to recover from page faults. Let the firmware tell us
> when a device supports stall.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  .../devicetree/bindings/iommu/iommu.txt        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> index 3c36334e4f94..26ba9e530f13 100644
> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -92,6 +92,24 @@ Optional properties:
>    tagging DMA transactions with an address space identifier. By default,
>    this is 0, which means that the device only has one address space.
>  
> +- dma-can-stall: When present, the master can wait for a transaction to
> +  complete for an indefinite amount of time. Upon translation fault some
> +  IOMMUs, instead of aborting the translation immediately, may first
> +  notify the driver and keep the transaction in flight. This allows the OS
> +  to inspect the fault and, for example, make physical pages resident
> +  before updating the mappings and completing the transaction. Such IOMMU
> +  accepts a limited number of simultaneous stalled transactions before
> +  having to either put back-pressure on the master, or abort new faulting
> +  transactions.
> +
> +  Firmware has to opt-in stalling, because most buses and masters don't
> +  support it. In particular it isn't compatible with PCI, where
> +  transactions have to complete before a time limit. More generally it
> +  won't work in systems and masters that haven't been designed for
> +  stalling. For example the OS, in order to handle a stalled transaction,
> +  may attempt to retrieve pages from secondary storage in a stalled
> +  domain, leading to a deadlock.
> +
>  
>  Notes:
>  ======
> 

