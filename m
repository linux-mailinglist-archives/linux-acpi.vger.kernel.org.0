Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C30F67838B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 18:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjAWRrb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 12:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWRrb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 12:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868582ED73
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674496008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSpU8Fnu44BAO8XQCUCc7Ds/9nau4mzqfKlC4gjcApM=;
        b=NRYplnRo9dNvRep2E6oV1xl072YPro8savhdZbm9hSbr8vvOY4L8Yt0hY2Wy/nOtxRctRr
        OdWGrk9AQAK9sEW6IWTPJtBOJiqsNnepWDUphZCq9jwF5/GJ7vo3z0Y4RzalqcSW/otpZd
        vNqGRKueP7kvqnqVmJOX1/NVfekDt3c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-FaVCkljyOSmwPPO06g8Fqw-1; Mon, 23 Jan 2023 12:46:47 -0500
X-MC-Unique: FaVCkljyOSmwPPO06g8Fqw-1
Received: by mail-ej1-f69.google.com with SMTP id qw29-20020a1709066a1d00b008725a1034caso8337831ejc.22
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 09:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSpU8Fnu44BAO8XQCUCc7Ds/9nau4mzqfKlC4gjcApM=;
        b=OuTlpoW7eZJOKRxblJu87ByYaMPZoLUGRu8KO2nBTyxR82fPnfcgtaTYXBE4Tjra/P
         EjbHyIj6Ac1ah65ZU/VSJCiJyAWIvkMrHiGK2kvoOQ560Qc65ArFWDa1xhg72G6IDMmf
         RX9FTpuKcbbHipLyJEf0TBhlmxsTFHvEoXMujVRt0FHV43Laxc3jEgPEETFCFPo3p2iE
         zxhaanvpbNZPKGSv2BiSSmtludA1aH4ofKva9+0VRf/s0aHv3Pnv2Z3iFNwWpTaT3TON
         1Nf0pIFG6TjSSO7RYz9Zi45ae6jxVU06a1z9dsNeUjSGDusWbqUS9hOOdU5cmD8e9WwF
         N3uQ==
X-Gm-Message-State: AFqh2kq9GMa4o1FwKMScfvTGjlcHJhCnrzQKkSvPVvRwrNRLDqhTtyYZ
        dvKswCAUuuXLLqwu1t5LUs6SvyQ45eD2Pzgo1Xcv/d9OiAoz8w+tM6xVsW1jzP8YrPdlcTki0+i
        Qrcq46povtS65mRykf4A1QQ==
X-Received: by 2002:a17:907:1710:b0:86f:64bb:47eb with SMTP id le16-20020a170907171000b0086f64bb47ebmr26993339ejc.3.1674496006111;
        Mon, 23 Jan 2023 09:46:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsIwMltMSsN1RlXrtbK0LRNbScrIKxzHCR+mdiNjOIZw8eCVzkKtNZ1KY3fs7AU9On1Bf69vA==
X-Received: by 2002:a17:907:1710:b0:86f:64bb:47eb with SMTP id le16-20020a170907171000b0086f64bb47ebmr26993331ejc.3.1674496005968;
        Mon, 23 Jan 2023 09:46:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k22-20020a17090632d600b00780982d77d1sm10669603ejk.154.2023.01.23.09.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:46:45 -0800 (PST)
Message-ID: <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com>
Date:   Mon, 23 Jan 2023 18:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/3] ACPI: video: Fix refcounting in
 apple_gmux_backlight_present()
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On 1/23/23 18:10, Andy Shevchenko wrote:
> acpi_dev_get_first_match_dev() gets ACPI device with the bumped
> refcount. The caller must drop it when it's done.
> 
> Fix ACPI device refcounting in apple_gmux_backlight_present().
> 
> Fixes: 3cf3b7f012f3 ("ACPI: video: Fix Apple GMUX backlight detection")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your work on this, much appreciated and I like
the new acpi_get_first_match_physical_node().

But I don't think this patch is a good idea. There is a
regression related to apple_gmux_backlight_present()
with a patch-set fixing it pending.

And that patch-set actually removes this function. Adding
a fix for this real, but not really important leak now,
will just make backporting the actual fix harder.

So I would prefer for this patch to not go in and to
go for (a to be submitted v2) of the patch-set fixing
the regression right away instead.

Regards,

Hans



> ---
>  drivers/acpi/video_detect.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 65cec7bb6d96..0ccde0d4c527 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -114,12 +114,14 @@ static bool apple_gmux_backlight_present(void)
>  {
>  	struct acpi_device *adev;
>  	struct device *dev;
> +	bool ret;
>  
>  	adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
>  	if (!adev)
>  		return false;
>  
> -	dev = acpi_get_first_physical_node(adev);
> +	dev = get_device(acpi_get_first_physical_node(adev));
> +	acpi_dev_put(adev);
>  	if (!dev)
>  		return false;
>  
> @@ -127,7 +129,9 @@ static bool apple_gmux_backlight_present(void)
>  	 * drivers/platform/x86/apple-gmux.c only supports old style
>  	 * Apple GMUX with an IO-resource.
>  	 */
> -	return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> +	ret = pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> +	put_device(dev);
> +	return ret;
>  }
>  
>  /* Force to use vendor driver when the ACPI device is known to be

