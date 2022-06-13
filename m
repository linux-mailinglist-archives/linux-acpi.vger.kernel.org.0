Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427254A0FD
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jun 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352003AbiFMVMu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jun 2022 17:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352017AbiFMVMe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jun 2022 17:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 690963E5ED
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jun 2022 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655153449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHh1Mc7ZpYll3jkRg/4I2vZLEod4WMai9S1oJy78FZg=;
        b=HaFtrNhqDdyXicP9yPhPOcblhPU24z6gvNzZX+e2ITvmr6JvvVlJWGx1EXngtCyzMzcQRy
        EfSGqOa9sJcm2aCmFOJ8mXRrW75jAHsV7wornbSadQEGQksLodg+6vstswjSaSHi8cYu2f
        aoeq0ymFDJ9SYhXd071uhpEEBr/dF4U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-ZYL1BV4dMgmKns4wgtoU6g-1; Mon, 13 Jun 2022 16:50:48 -0400
X-MC-Unique: ZYL1BV4dMgmKns4wgtoU6g-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a056402354900b0042ded146259so4677708edd.20
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jun 2022 13:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uHh1Mc7ZpYll3jkRg/4I2vZLEod4WMai9S1oJy78FZg=;
        b=Q9P27SM4NRoc15ZxKzjRFvp8+aOHy0DFO6LIASsGGgkvsSOO7fXIbeEmQ8XKm9uNot
         CZWIecrvfQcRbsUlT6qMZh6a+5LclUl3N13xyvP+uuBeB58UQyxvnjVyRO7S223VbDxq
         fe+OIBh8OWFxtV9Ru7L8B9RPMXCA9POqjeDrLuTsWzvIOYXbB5tz1cEwlz08vUMQWVvC
         s5LHtVgT3KkAWp0pAmgMGuDfKRibivPLy8vFTAXbNiot7ilHjjDypToyDe5Os9MRP40X
         pDNhjnaAteXaFsVCICIdqjFrL1ptXaCAlhUKgp9E/6oAnvUO43qzmuFD2Ts2AUbi796Q
         YG8g==
X-Gm-Message-State: AJIora9PbfPC6fkZlHfHs0SE8XPo3H4V239ESfZgWZS2MwyDcPYIccoY
        ijva+SC/dLrAL1pSzEFkP3oFhY3U7jhI9d681+b2Bo+nmjOU7kaZPB2G9Y/y943LSCrIWMQBgYZ
        A5jXxPH/i6OcoOg2+n21fnQ==
X-Received: by 2002:a17:907:160c:b0:711:3b56:dc7 with SMTP id hb12-20020a170907160c00b007113b560dc7mr1377165ejc.587.1655153446903;
        Mon, 13 Jun 2022 13:50:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLiEiFvejpV3bRXy2k4g93sSKykLlmNzgB4sMsx4IWkixW2j3DGJCzho0mbCSzEtPT4MlbBg==
X-Received: by 2002:a17:907:160c:b0:711:3b56:dc7 with SMTP id hb12-20020a170907160c00b007113b560dc7mr1377157ejc.587.1655153446669;
        Mon, 13 Jun 2022 13:50:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id za14-20020a170906878e00b00706c1327f4bsm4243279ejb.23.2022.06.13.13.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:50:46 -0700 (PDT)
Message-ID: <81a7cbe7-068a-d9ab-74b1-b6891f5a6f10@redhat.com>
Date:   Mon, 13 Jun 2022 22:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 12/16] platform/x86/thinkpad_acpi: Use
 acpi_dev_for_each_child()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <2091400.OBFZWjSADL@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2091400.OBFZWjSADL@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/13/22 20:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.
> 
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, feel free to take this upstream through the apci tree.

Regards,

Hans




> ---
> 
> v1 -> v2:
>    * Eliminate unnecessary branch (Andy).
> 
> ---
>  drivers/platform/x86/thinkpad_acpi.c |   53 +++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> Index: linux-pm/drivers/platform/x86/thinkpad_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/thinkpad_acpi.c
> +++ linux-pm/drivers/platform/x86/thinkpad_acpi.c
> @@ -6841,6 +6841,31 @@ static const struct backlight_ops ibm_ba
>  
>  /* --------------------------------------------------------------------- */
>  
> +static int __init tpacpi_evaluate_bcl(struct acpi_device *adev, void *not_used)
> +{
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int rc;
> +
> +	status = acpi_evaluate_object(adev->handle, "_BCL", NULL, &buffer);
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	obj = buffer.pointer;
> +	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
> +		acpi_handle_info(adev->handle,
> +				 "Unknown _BCL data, please report this to %s\n",
> +				 TPACPI_MAIL);
> +		rc = 0;
> +	} else {
> +		rc = obj->package.count;
> +	}
> +	kfree(obj);
> +
> +	return rc;
> +}
> +
>  /*
>   * Call _BCL method of video device.  On some ThinkPads this will
>   * switch the firmware to the ACPI brightness control mode.
> @@ -6848,37 +6873,13 @@ static const struct backlight_ops ibm_ba
>  
>  static int __init tpacpi_query_bcl_levels(acpi_handle handle)
>  {
> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *obj;
> -	struct acpi_device *device, *child;
> -	int rc;
> +	struct acpi_device *device;
>  
>  	device = acpi_fetch_acpi_dev(handle);
>  	if (!device)
>  		return 0;
>  
> -	rc = 0;
> -	list_for_each_entry(child, &device->children, node) {
> -		acpi_status status = acpi_evaluate_object(child->handle, "_BCL",
> -							  NULL, &buffer);
> -		if (ACPI_FAILURE(status)) {
> -			buffer.length = ACPI_ALLOCATE_BUFFER;
> -			continue;
> -		}
> -
> -		obj = (union acpi_object *)buffer.pointer;
> -		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
> -			pr_err("Unknown _BCL data, please report this to %s\n",
> -				TPACPI_MAIL);
> -			rc = 0;
> -		} else {
> -			rc = obj->package.count;
> -		}
> -		break;
> -	}
> -
> -	kfree(buffer.pointer);
> -	return rc;
> +	return acpi_dev_for_each_child(device, tpacpi_evaluate_bcl, NULL);
>  }
>  
>  
> 
> 
> 

