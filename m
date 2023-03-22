Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1546C4732
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Mar 2023 11:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCVKFh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Mar 2023 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCVKFg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 06:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477D193F0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679479493;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlzXqLaiFJqutr/ifAilPZ+K+vBBAuY2KbY33ds/cHU=;
        b=MajMBT9zF9h81mj37OGtTieTEP4yzTU9IXut1dPXc8XVT+LaYkjn8ZuD+on2gF7MHUZxE7
        ZjQiWym6mZ0o+0kWywV+yASFNuwLII7cLwes7MkmW1527dfqcTZIOeDVqK9p1Zf65H4ycM
        vL48AEVpZYFKSToT/8o2Ak8Rq2rJ+pY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-MxjLgk6tNoSlrv3u6Iw5Ow-1; Wed, 22 Mar 2023 06:04:52 -0400
X-MC-Unique: MxjLgk6tNoSlrv3u6Iw5Ow-1
Received: by mail-qv1-f71.google.com with SMTP id f3-20020a0cc303000000b005c9966620daso4455703qvi.4
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 03:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679479492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlzXqLaiFJqutr/ifAilPZ+K+vBBAuY2KbY33ds/cHU=;
        b=UaRP+nFaeIOYeLiZF7iWOh+oaCqD8nr/razayjMQBj/YRthvdNJywAH798xOGxpP9D
         vv9ogdIVmAIDQ+el2UuaU6peJUxgHGThncQ5EUpvYGh2Nci4FSlXN8LM5px6d1GLLs2C
         MZRI6evIQYLhTRJylc0TzcC+yInTFLEm1idbK0KO5+6KX8La0hX1BzAU70urxWfl6V+R
         4v6e+vOeSM3mge0agWlQUGy8R279xW4he2UHRH3OwBWioF99UVz2uEMAJZjds+SKC0CJ
         Jh6DmVDGbs6pLt3665mG6gphOClcnCl1G1+WacVH2Ob8pXswSZWkOZJqrfSDM57CLG3h
         CHRA==
X-Gm-Message-State: AO0yUKVBi9KJJvowhnywMpllgO9RtMKROEcr/x672noWuhP/iGnd5lu+
        /DT3txcbiKmOMQOUG+cHuWnbfcvTYKHlGUReDXechE7/4/ffe39YkTMjj6N04ArI9y9krhjraXc
        3z05uZdpweteM4h6SG1lBVQ==
X-Received: by 2002:ac8:4e83:0:b0:3bb:88e2:7625 with SMTP id 3-20020ac84e83000000b003bb88e27625mr4875206qtp.24.1679479492328;
        Wed, 22 Mar 2023 03:04:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set+MdvA2FH9NCy5hSRE5kdbgRKa8XU3K3oS6KEMykktU5okAu5JCYZ0efXr+GMZF3/gdAkmxJg==
X-Received: by 2002:ac8:4e83:0:b0:3bb:88e2:7625 with SMTP id 3-20020ac84e83000000b003bb88e27625mr4875177qtp.24.1679479492048;
        Wed, 22 Mar 2023 03:04:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a148800b0073bb0ef3a8esm11009302qkj.21.2023.03.22.03.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:04:51 -0700 (PDT)
Message-ID: <1a227cc4-217b-01aa-ecee-9819160d9a44@redhat.com>
Date:   Wed, 22 Mar 2023 11:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [RESEND PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, helgaas@kernel.org
References: <20230320180528.281755-1-jean-philippe@linaro.org>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230320180528.281755-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 3/20/23 19:05, Jean-Philippe Brucker wrote:
> When setting up DMA for a PCI device, we need to initialize its
> iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
> this we use pci_for_each_dma_alias() which calls
> viot_pci_dev_iommu_init(). This function incorrectly initializes the
> fwspec of the bridge instead of the device being configured. Fix it by
> passing the original device as context to pci_for_each_dma_alias().
>
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Tested-by: Eric Auger <eric.auger@redhat.com>

With this patch the pcie-to-pci bridge is assigned an iommu group.
The iommu group topology is not yet correct (ie. end points downstream
to the pcie-to-pci bridge are put in a separate iommu group) however
this is not related to that patch and not supposed to be fixed here
(https://lore.kernel.org/all/4fead092-1058-198a-b430-3dee0fffcd51@arm.com/)

Thanks

Eric

> ---
> This fixes issue (1) reported here:
> https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica/
>
> resend: Added linux-pci list
> ---
>  drivers/acpi/viot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index ed752cbbe636..c8025921c129 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  {
>  	u32 epid;
>  	struct viot_endpoint *ep;
> +	struct device *aliased_dev = data;
>  	u32 domain_nr = pci_domain_nr(pdev->bus);
>  
>  	list_for_each_entry(ep, &viot_pci_ranges, list) {
> @@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  			epid = ((domain_nr - ep->segment_start) << 16) +
>  				dev_id - ep->bdf_start + ep->endpoint_id;
>  
> -			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
> +			return viot_dev_iommu_init(aliased_dev, ep->viommu,
>  						   epid);
>  		}
>  	}
> @@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
>  {
>  	if (dev_is_pci(dev))
>  		return pci_for_each_dma_alias(to_pci_dev(dev),
> -					      viot_pci_dev_iommu_init, NULL);
> +					      viot_pci_dev_iommu_init, dev);
>  	else if (dev_is_platform(dev))
>  		return viot_mmio_dev_iommu_init(to_platform_device(dev));
>  	return -ENODEV;

