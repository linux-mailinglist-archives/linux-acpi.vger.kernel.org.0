Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0727A404B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 07:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjIRFEG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Sep 2023 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjIRFDv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 01:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74D11F
        for <linux-acpi@vger.kernel.org>; Sun, 17 Sep 2023 22:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695013387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCDoXZnQJiBgGjXOi0ciKhKqeO4OfqPdXpxnEdvp7mI=;
        b=AV4KHs5YbFYMHe/6ShsgeXmv3+JXfTyjpFXM0/0I4go/70Jluhl5XxxMREiOMmwePL0JrQ
        1Cw4lPTte/eZrRhQXCrhQTFDo0R4DK4GbKxLb30+ZHbdyEAONkXqzBSmY84r84YhP2JthG
        euNlLc0SYjoeTHnIdKXuF1a9wzz39uM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-yBNC50eSN0Gu1esyeUkksw-1; Mon, 18 Sep 2023 01:03:02 -0400
X-MC-Unique: yBNC50eSN0Gu1esyeUkksw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68fb9874533so4095597b3a.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Sep 2023 22:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695013381; x=1695618181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCDoXZnQJiBgGjXOi0ciKhKqeO4OfqPdXpxnEdvp7mI=;
        b=TLvP9sBBzT8qx4Fh8CTL3IqC9pqeEt2I8iB/sUzEZtHK415iCUbu3/jendpeqmqmU+
         7EOPZmlLre2lgKZT8LlvjCeG1xIv/bmNrtYAYeJ6BqimkFpV3P1mEsHm7AdftePPaOWx
         fZHr6eSJoA3/QGxrDA1D/lQSksCLvOuWD5BJ5XLfjt2gxm+1onzOXr02Ni/JY4oEazl3
         DZSwba+q7ADt/wtvtOeQ5lHfN+B1uwUIy8f61kz2latvcaqkEtlfpZXp81moDkAwZOEC
         SU2ycBBuwMpitjH5DtID1V8Qv2yfpSamm4OWVLymfDO6a6f1OFcP4cvixkQB3BJt4rzy
         ysgA==
X-Gm-Message-State: AOJu0YxB0K1/mm0OLL1LIuj90qa1WgU8YB53/1BdvAsZeWsjsPaOB4GA
        Ba49lAj/1CzXSWOcWVCGqnjhWqHzIhEWTzfukCKV5J2VsFC4hNZZPJXA21tPUlvP4nZ7fnX+3wD
        1CR2631zhOQae9zNmJTzKNg==
X-Received: by 2002:a05:6a00:2344:b0:68e:43ed:d30b with SMTP id j4-20020a056a00234400b0068e43edd30bmr6879609pfj.21.1695013381112;
        Sun, 17 Sep 2023 22:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqmnfE9QFPe9E5tdKFUUF/pg2T2yxaduIzlP4FnKDLuVWyov/hE0tCEtGqZQwTLT17gzDFFw==
X-Received: by 2002:a05:6a00:2344:b0:68e:43ed:d30b with SMTP id j4-20020a056a00234400b0068e43edd30bmr6879587pfj.21.1695013380748;
        Sun, 17 Sep 2023 22:03:00 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id j26-20020aa783da000000b00687a4b70d1esm6322062pfn.218.2023.09.17.22.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 22:03:00 -0700 (PDT)
Message-ID: <50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.com>
Date:   Mon, 18 Sep 2023 15:02:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 15/35] ACPI: processor: Add support for processors
 described as container packages
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-16-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-16-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 9/14/23 02:38, James Morse wrote:
> ACPI has two ways of describing processors in the DSDT. Either as a device
> object with HID ACPI0007, or as a type 'C' package inside a Processor
> Container. The ACPI processor driver probes CPUs described as devices, but
> not those described as packages.
> 
> Duplicate descriptions are not allowed, the ACPI processor driver already
> parses the UID from both devices and containers. acpi_processor_get_info()
> returns an error if the UID exists twice in the DSDT.
> 
> The missing probe for CPUs described as packages creates a problem for
> moving the cpu_register() calls into the acpi_processor driver, as CPUs
> described like this don't get registered, leading to errors from other
> subsystems when they try to add new sysfs entries to the CPU node.
> (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> 
> To fix this, parse the processor container and call acpi_processor_add()
> for each processor that is discovered like this. The processor container
> handler is added with acpi_scan_add_handler(), so no detach call will
> arrive.
> 
> Qemu TCG describes CPUs using packages in a processor container.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 

I don't understand the last sentence of the commit log. QEMU
always have "ACPI0007" for the processor devices.

#define ACPI_PROCESSOR_DEVICE_HID      "ACPI0007"
#define ACPI_PROCESSOR_OBJECT_HID      "LNXCPU"

[gshan@gshan q]$ git grep ACPI0007
hw/acpi/cpu.c:                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
hw/arm/virt-acpi-build.c:        aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
hw/riscv/virt-acpi-build.c:            aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
[gshan@gshan q]$ git grep LNXCPU

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c0839bcf78c1..b4bde78121bb 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -625,9 +625,31 @@ static struct acpi_scan_handler processor_handler = {
>   	},
>   };
>   
> +static acpi_status acpi_processor_container_walk(acpi_handle handle,
> +						 u32 lvl,
> +						 void *context,
> +						 void **rv)
> +{
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	adev = acpi_get_acpi_dev(handle);
> +	if (!adev)
> +		return AE_ERROR;
> +
> +	status = acpi_processor_add(adev, &processor_device_ids[0]);
> +	acpi_put_acpi_dev(adev);
> +
> +	return status;
> +}
> +
>   static int acpi_processor_container_attach(struct acpi_device *dev,
>   					   const struct acpi_device_id *id)
>   {
> +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, dev->handle,
> +			    ACPI_UINT32_MAX, acpi_processor_container_walk,
> +			    NULL, NULL, NULL);
> +
>   	return 1;
>   }
>   

Thanks,
Gavin

