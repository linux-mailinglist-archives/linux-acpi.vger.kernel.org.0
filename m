Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C077B5BB7CF
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Sep 2022 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIQKjn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 17 Sep 2022 06:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQKjb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Sep 2022 06:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BCB2DC
        for <linux-acpi@vger.kernel.org>; Sat, 17 Sep 2022 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663411168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Js+pDsDZVgZBmTabvM6o9xVyy1VsRkAd5kz24EsL8CI=;
        b=NqVEPPfhEphsn898RhWjPzWYJ/I6lH/rQT94PkqeweWCiYWnikLEG03f3+XMQK10DDoKne
        kVhgIS+RbA6z/7qNuZpldVlSkpL/eOeSGjdj3IkahUxO0KWVXtA64GVBFlJwAdhKSxEyAQ
        JpJg/CYNhQOZhZBhFVumQ0KYb7Q9Iqo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-SM7qlNnfMfWHoy0723E3aw-1; Sat, 17 Sep 2022 06:39:24 -0400
X-MC-Unique: SM7qlNnfMfWHoy0723E3aw-1
Received: by mail-ed1-f70.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so9212888edb.2
        for <linux-acpi@vger.kernel.org>; Sat, 17 Sep 2022 03:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Js+pDsDZVgZBmTabvM6o9xVyy1VsRkAd5kz24EsL8CI=;
        b=ht2IN5RNT9Pm1D051aGhUqWIu1mCwWbrboa45IWpOxeeYk/YA5lBZRckPjI1koP1kW
         t76cEU+H1hSq40N/qffweljcYMXOw34c4INgc6IXsIKL0/8u77P1UJiONGpvLBhVW8nG
         cNoG9BDeWh80bTcWMrtgjLhSlzexa8rpj6zehdkUfWLfIQZ82RXEGOZqsNH3gTyVtuSC
         Ko7Cfz2uEa8r8jWbDFE+y6T1YGD/KE2vO0ydV0kb22PZ9ckUuwIx6sajUXncPpro3QEW
         SFhxmXqjOZ+ftK+Myziu6+t0JVrtxykohU8H4/xMlRLkfXk9c0FsA32y15qmvxSz7qfe
         gVYg==
X-Gm-Message-State: ACrzQf33xoGLMECrEV4yowbFnMxfLPFxWTA64rBw0cA73fEqPGmI2kE0
        Pn1MM6y8Fr1F9frxtfMX6B1zIWfdT60/Y4EJNwyQIxJ1ACaePXwo8TgW7F8mSB+ZUKkBMSmViN7
        ZSZtdOubk+tP9ohIGkrBwwA==
X-Received: by 2002:a17:906:4fce:b0:780:e1d8:eacc with SMTP id i14-20020a1709064fce00b00780e1d8eaccmr1479895ejw.366.1663411163399;
        Sat, 17 Sep 2022 03:39:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5TqQPPEh5xLUYL6dFxx+u0rLERe2nCIyTVyV3eMraf0YrShDD/joxP33xpx9uWiydaFx/zmw==
X-Received: by 2002:a17:906:4fce:b0:780:e1d8:eacc with SMTP id i14-20020a1709064fce00b00780e1d8eaccmr1479887ejw.366.1663411163188;
        Sat, 17 Sep 2022 03:39:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b0072f4f4dc038sm11826690ejo.42.2022.09.17.03.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 03:39:22 -0700 (PDT)
Message-ID: <7b421d09-eacb-de83-4218-3c3757b004ff@redhat.com>
Date:   Sat, 17 Sep 2022 12:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ACPI: AC: Remove the leftover struct acpi_ac_bl
Content-Language: en-US
To:     Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1663407909-17686-1-git-send-email-guohanjun@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1663407909-17686-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/17/22 11:45, Hanjun Guo wrote:
> In commit 57a183222271 ("ACPI / x86: Introduce an
> acpi_quirk_skip_acpi_ac_and_battery() helper"), the usage of struct
> acpi_ac_bl was removed, but left the definition of the struct in
> the file, so remove the useless code.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Good catch, thanks. Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/ac.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index c29e41b..bb9fe79 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -36,11 +36,6 @@
>  static int acpi_ac_remove(struct acpi_device *device);
>  static void acpi_ac_notify(struct acpi_device *device, u32 event);
>  
> -struct acpi_ac_bl {
> -	const char *hid;
> -	int hrv;
> -};
> -
>  static const struct acpi_device_id ac_device_ids[] = {
>  	{"ACPI0003", 0},
>  	{"", 0},

