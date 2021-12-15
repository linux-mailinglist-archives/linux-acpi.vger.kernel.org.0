Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752C7475646
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Dec 2021 11:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhLOK0H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Dec 2021 05:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241651AbhLOK0F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Dec 2021 05:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639563965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTMyhmlUwtP+UZbN7o4sfE3CL8eyBS2/mVFpUPSzp54=;
        b=NunX4qJwSlk4nXa4Z5Ye5EPLcJy0dm+1AypYb0MC/DSugV7mDbz2/ZHSAgcQbltc4H5MQp
        rgwUG6zGBBzwByDfcvzQ1mAhWKEK2AqVLUr67o6OlJgXPkr0D8GXrwZpy4b8P4/d5CpS9u
        aipYIwGE+5ocr0T7PMnX1RMoKFM3Vg4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-C8yQ0dqDN_atdQGZOdd_Qg-1; Wed, 15 Dec 2021 05:26:04 -0500
X-MC-Unique: C8yQ0dqDN_atdQGZOdd_Qg-1
Received: by mail-ed1-f69.google.com with SMTP id t2-20020a056402524200b003f7ed6cf4f1so728420edd.21
        for <linux-acpi@vger.kernel.org>; Wed, 15 Dec 2021 02:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lTMyhmlUwtP+UZbN7o4sfE3CL8eyBS2/mVFpUPSzp54=;
        b=gJQg28uCPNP456pnJdyU5ulPZq4gCG9ZO88XE8OS30zKAdGq5yYpmGsvhir7uBgNd1
         L/kQ2LtsxTIBjaP5oOkonwTWWjXJT9x3tEneq8C6ydZRuQJPAZc5z37wGNF+s5Y+RjPt
         8ZRuGnD3Z3v8cBAdVSiMiysKMSAlTRqEAn2BYKdIms8xE5FZGRJRwKloY6ihj7iEPG/u
         6ng6fx6K9wzHy758bb7zQWrcFbGv21LNUmdnSxLF2bwcaKlIUWHGUj0qNhKLjO9r3/w7
         D5cRk7rX4O1OFHvOyIu9IR0iLcHy54B51XJ1C2FdNKyKlM0y07rw5PXF4cc3/tCPbg20
         v4IA==
X-Gm-Message-State: AOAM532uZOHRQr2uZ8cCjn1+e73+/hcn1sZ8uTQloCrIvYZVZJYFeWG2
        R1oXIk7rAM3aoqthzx2zgKqwKwLHrZJWIr5D8Z0C2aT4YtfQ/3FCuZJ130kDGhI1YaAcfJPVAgW
        4owhbbhmwyNiS7zKXEz87ew==
X-Received: by 2002:a17:907:7b9f:: with SMTP id ne31mr10323763ejc.592.1639563962913;
        Wed, 15 Dec 2021 02:26:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxn1xV7iE8sI1FQ9psjd60mn1dZq5+6ul60Aou6+YU3I+HarC9Iu3ebjWaLZ27pxPSyzL7C4w==
X-Received: by 2002:a17:907:7b9f:: with SMTP id ne31mr10323749ejc.592.1639563962763;
        Wed, 15 Dec 2021 02:26:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id h18sm658317edw.55.2021.12.15.02.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:26:02 -0800 (PST)
Message-ID: <f7ddad0b-633f-9b86-55f5-dc148c0729a6@redhat.com>
Date:   Wed, 15 Dec 2021 11:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 3/6] platform/x86: i2c-multi-instantiate: Move it to
 drivers/acpi folder
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
 <20211210154050.3713-4-sbinding@opensource.cirrus.com>
 <YbOVf5eGwCqJDgvv@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YbOVf5eGwCqJDgvv@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/10/21 18:59, Mark Brown wrote:
> On Fri, Dec 10, 2021 at 03:40:47PM +0000, Stefan Binding wrote:
>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>
>> Moving I2C multi instantiate driver to drivers/acpi folder for
>> upcoming conversion into a generic bus multi instantiate
>> driver for SPI and I2C
>>
>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>> ---
> 
> You've not provided a Signed-off-by for this so people can't do anything
> with it, please see Documentation/process/submitting-patches.rst for
> details on what this is and why it's important.

To clarify this, what I believe that Mark means here is that if you
submit a patch which was originally authored by someone else, then
you should add your own (the submitters) Signed-off-by after the
author's Signed-off-by.

The idea is that each person directly touching the patch (rather
then merging a branch which has the patch) adds its S-o-b to the
patch. You will also always see sub-system maintainers add their
own S-o-b at the end when they pick up the patch from the list
and then apply it to their own tree (and possibly resolve
conflicts or touch up things a bit).

Regards,

Hans

