Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AA272DFED
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jun 2023 12:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbjFMKmo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Jun 2023 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbjFMKmm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jun 2023 06:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329071AD
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jun 2023 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686652918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irXa5/MVUXutU2yje0SPChb0/2Blm8SZbdJ2XPx6hj8=;
        b=JHv9tUaceiuqMGU73jj9SIK+B2+VwKQbAS/yktTD0zHo22Gy/13L40ns2j967ZPLpKI9Tx
        nrmc9F8KlgG9xVjOu7NeEZCPrJg6vDYuDbz1+zgt+C6Y5v1bJoX0HvKWa44SnoQP2+9Uj6
        lXDY68VmJ62+3LmYqhz/kxOmoLeqjrE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-s6VU4u2NOkq3wD1nR65rlg-1; Tue, 13 Jun 2023 06:41:56 -0400
X-MC-Unique: s6VU4u2NOkq3wD1nR65rlg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9745c72d99cso611401666b.1
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jun 2023 03:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652915; x=1689244915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irXa5/MVUXutU2yje0SPChb0/2Blm8SZbdJ2XPx6hj8=;
        b=h4rQI6bRgDN0zaDB6cnww/eYGspQgjxbNulUH6Md1AS/mlhJljloefmmkUlFbajXzd
         RtawpcD0kRvlk8oaFSOTzoCVk5AehPkjFbp68ozYz9FdNvXqpzrxerYHYqGwM+FSVGOy
         frDqCpp3DrZq/cIfXckTZdOroJi9W24KZeA3MTUF5pM1/0APpEznQOMPvyve7pAFIGUw
         mMHVCyuXSISFQWgpZQzIEtevGuvGi8DwbE65fr0fv/Xwdn+GEmakY6YNY+WYNVWAJGRv
         j0kDT+04/ydq8OHayyQSJe8ZUvXjg87GxH4hM+HS08tCei7kQZ2hg89U1i61oLMsAL/v
         JjRg==
X-Gm-Message-State: AC+VfDyo61QtcijbgQZ5r5lu6xVs2knio7BUm84823OT8/aWL+At8qJD
        Y+dRz48FKTBfVLzLwmB2Mz693nvyQNfISARZKXjcApvNNWqKONEFoo74AG8bngAAPH4m6wwFLn0
        HnNir1sEBlnS55TCiJrISFg==
X-Received: by 2002:a17:907:25cc:b0:94f:6218:191d with SMTP id ae12-20020a17090725cc00b0094f6218191dmr11871318ejc.32.1686652915836;
        Tue, 13 Jun 2023 03:41:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ649gXkCgdxRxAB5x48am3xL6yj+0ReYQgIhb6mbtLS6zRHULE7BFRMjEl/xK8VH+IPs/zLgg==
X-Received: by 2002:a17:907:25cc:b0:94f:6218:191d with SMTP id ae12-20020a17090725cc00b0094f6218191dmr11871305ejc.32.1686652915511;
        Tue, 13 Jun 2023 03:41:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm6490324ejb.98.2023.06.13.03.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:41:54 -0700 (PDT)
Message-ID: <066c16a1-265f-e3f9-a8c9-25115aad9451@redhat.com>
Date:   Tue, 13 Jun 2023 12:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Content-Language: en-US, nl
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com, pali@kernel.org,
        markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230613084310.2775896-1-michal.wilczynski@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230613084310.2775896-1-michal.wilczynski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/13/23 10:43, Michal Wilczynski wrote:
> Currently rbtn_add() in case of failure is leaking resources. Fix this
> by adding a proper rollback. Move devm_kzalloc() before rbtn_acquire(),
> so it doesn't require rollback in case of failure. While at it, remove
> unnecessary assignment of NULL to device->driver_data and unnecessary
> whitespace, plus add a break for the default case in a switch.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
> v2:
>  - move devm_kzalloc before rbtn_acquire as suggested


Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




>  drivers/platform/x86/dell/dell-rbtn.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> index aa0e6c907494..c8fcb537fd65 100644
> --- a/drivers/platform/x86/dell/dell-rbtn.c
> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> @@ -395,16 +395,16 @@ static int rbtn_add(struct acpi_device *device)
>  		return -EINVAL;
>  	}
>  
> +	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
> +	if (!rbtn_data)
> +		return -ENOMEM;
> +
>  	ret = rbtn_acquire(device, true);
>  	if (ret < 0) {
>  		dev_err(&device->dev, "Cannot enable device\n");
>  		return ret;
>  	}
>  
> -	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
> -	if (!rbtn_data)
> -		return -ENOMEM;
> -
>  	rbtn_data->type = type;
>  	device->driver_data = rbtn_data;
>  
> @@ -420,10 +420,12 @@ static int rbtn_add(struct acpi_device *device)
>  		break;
>  	default:
>  		ret = -EINVAL;
> +		break;
>  	}
> +	if (ret)
> +		rbtn_acquire(device, false);
>  
>  	return ret;
> -
>  }
>  
>  static void rbtn_remove(struct acpi_device *device)
> @@ -442,7 +444,6 @@ static void rbtn_remove(struct acpi_device *device)
>  	}
>  
>  	rbtn_acquire(device, false);
> -	device->driver_data = NULL;
>  }
>  
>  static void rbtn_notify(struct acpi_device *device, u32 event)

