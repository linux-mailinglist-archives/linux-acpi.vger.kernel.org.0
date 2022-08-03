Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1559588A17
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Aug 2022 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiHCKDR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Aug 2022 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiHCKDQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Aug 2022 06:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BD201836B
        for <linux-acpi@vger.kernel.org>; Wed,  3 Aug 2022 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659520994;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHAatqq7WLX8aAM5p4x5ULy+iYVYaT/OkqKn6lCeb3U=;
        b=d94ZPjRUde9GSHRt3EQhGfiGWnxSZf5+pVp/2Nezj5+oJsLQldFQTfCcKq/o/mOwxGQFMj
        WGWX3UyZhAZxE7FrcRcXhztVzYxVkMYJrTv0+/e78O0ylFin2h2HCQb8jj+hiwuaQYXetl
        ZFwkPreQeYiH7Zf+Pn8SF0PG91U9usw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-jbiqJP_6P0Gp3RZOMtHtIA-1; Wed, 03 Aug 2022 06:03:13 -0400
X-MC-Unique: jbiqJP_6P0Gp3RZOMtHtIA-1
Received: by mail-qk1-f200.google.com with SMTP id ay35-20020a05620a17a300b006b5d9646d31so13145307qkb.6
        for <linux-acpi@vger.kernel.org>; Wed, 03 Aug 2022 03:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=SHAatqq7WLX8aAM5p4x5ULy+iYVYaT/OkqKn6lCeb3U=;
        b=JnvqXeWom8wfHz5ieuA4wu/iVSC62MqGHvNpnkhHOQVdeYNIUEKXKxur6gBhPGx5/p
         O8VIXkdETyBdfsiqyzrugGI7cMMTWJA2+mRxNJLc74v7py023DdJaXYY0OUATZPVvhbX
         zC8TTPCbucO81F+/WwwVhlaDsWPA0sVTqqGQDDW3fyK+ovf9kTAuS4VaZ9DdDT7cuO45
         7rV7Mcsb1MkO8tHhPcjZNGKCXGQSjfyEW4LNxHwPehrW48Wkns0qwRjksF94HmTMVy7E
         bH3td6kMcf5yQASIpy6zMnkElNSDXArX6cTSAhUj3M+/hQIWbxAu58bbBz9B0HGkoAZC
         OAGA==
X-Gm-Message-State: AJIora8/EWawxp5rK/wZgdDekAUOVsXJTFzNeMqvzH0M6R1gXSz/n686
        5AFRJ3kqM2O57fMrk5kwXb/DFmy04+eZ3b0N/YJTNULUoDnBijE+VFl4suQEWOFt5VnhaW4Tww+
        ywvOVsWMqV46sdiIgBGyg9Q==
X-Received: by 2002:ac8:5803:0:b0:31e:f49b:ed3a with SMTP id g3-20020ac85803000000b0031ef49bed3amr21430003qtg.46.1659520993057;
        Wed, 03 Aug 2022 03:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPTcMMZKqqwMRVSbno7QUDjIZ2Pu+sY7zLYFAUCeY3W3tdw5redRG5JkrQAtRAnIpbQqJwbg==
X-Received: by 2002:ac8:5803:0:b0:31e:f49b:ed3a with SMTP id g3-20020ac85803000000b0031ef49bed3amr21429989qtg.46.1659520992829;
        Wed, 03 Aug 2022 03:03:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a440200b006b5e50057basm12487432qkp.95.2022.08.03.03.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 03:03:11 -0700 (PDT)
Message-ID: <f2685007-0331-aaea-bfbe-074a3680fc29@redhat.com>
Date:   Wed, 3 Aug 2022 12:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Do not dereference fwnode in struct
 device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On 8/2/22 21:35, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific dev_fwnode() and device_match_fwnode()
> APIs for that.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/acpi/viot.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index 647f11cf165d..6132092dab2a 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -88,7 +88,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
>  		return -ENODEV;
>  	}
>  
> -	fwnode = pdev->dev.fwnode;
> +	fwnode = dev_fwnode(&pdev->dev);
>  	if (!fwnode) {
>  		/*
>  		 * PCI devices aren't necessarily described by ACPI. Create a
> @@ -101,7 +101,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
>  		}
>  		set_primary_fwnode(&pdev->dev, fwnode);
>  	}
> -	viommu->fwnode = pdev->dev.fwnode;
> +	viommu->fwnode = dev_fwnode(&pdev->dev);
>  	pci_dev_put(pdev);
>  	return 0;
>  }
> @@ -314,7 +314,7 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
>  		return -ENODEV;
>  
>  	/* We're not translating ourself */
> -	if (viommu->fwnode == dev->fwnode)
> +	if (device_match_fwnode(dev, viommu->fwnode))
>  		return -EINVAL;
>  
>  	ops = iommu_ops_from_fwnode(viommu->fwnode);

