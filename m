Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEAD472AA4
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Dec 2021 11:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhLMKs5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Dec 2021 05:48:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235844AbhLMKs4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Dec 2021 05:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639392535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSMRWWvDwDZ8+s/iBej33Q+kZmQH43UiURk7nbOWwWQ=;
        b=Guuhnn3Uof8zRW0JiHIxl5zq0LAH4t9BW5Qugw93Q2L7ljX3rBwTNrqTEvzjQphphh+bUA
        QlddvftCDRfqCrfLN0/lImSNrtYLmcT0Ney2bde/+0hkEpilmeZLH/OEV2oFJlUNHW68qx
        FBdq51kMB6Z9Syw5b/3NaoVQOxrTl3s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-hh5-VQViOiqUE9S4JZa48g-1; Mon, 13 Dec 2021 05:48:54 -0500
X-MC-Unique: hh5-VQViOiqUE9S4JZa48g-1
Received: by mail-ed1-f69.google.com with SMTP id 30-20020a508e5e000000b003f02e458b17so13548266edx.17
        for <linux-acpi@vger.kernel.org>; Mon, 13 Dec 2021 02:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hSMRWWvDwDZ8+s/iBej33Q+kZmQH43UiURk7nbOWwWQ=;
        b=U/Ip1uS12xoiTUVzMMMOZOQt2/bIlvARfqfucOyiW9Fr6on15xX3kLt/7ZwL8aN/Ix
         Duoj+PxLOQW+JpLputSc5zaMAMYR56BI0+XeuwGTWclua2eJrb1oxT4QXxofMWHPuinN
         80AFWXn1nU68hvGuxKfdp/Ze89tAJPTJRwTwOjxNz/NT98l7mig2gM8bFNuOGjyP7Qfv
         JZVz15g2pu9XxKaVdyK19Rfvr8kOyhFxfVgu8gWZhrPzbfbcuqfFSO7M/k4Cb+lTgTf/
         lxilhzBhL/0jILKOMgu8czkoX66njKYP991QPIo/6+aKc1OxOws10xRJvoo+d1xx7dOk
         VNjA==
X-Gm-Message-State: AOAM533xL0/XOfr0ymQik/JIzPgUInLE3f9YKZHRQ3urHOtfqoM3px+p
        xBgDYbW0hUwuy9KTo59nOtZ1jLItJJKS5rg+LKCrVcrkCFHtIClKpPd7cji44+kXlFAkSrmWeIM
        bCx2mgAPK0I13a+jg2Frizw==
X-Received: by 2002:a17:906:1697:: with SMTP id s23mr44596877ejd.60.1639392533093;
        Mon, 13 Dec 2021 02:48:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwFggy2dFOgUjYCsFjmoXFnFNZYH9/F2s6stMUwGL3v9+wBbcRAHCKqxo/kLkyq2T9/Q0jYg==
X-Received: by 2002:a17:906:1697:: with SMTP id s23mr44596844ejd.60.1639392532881;
        Mon, 13 Dec 2021 02:48:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hg19sm5541132ejc.1.2021.12.13.02.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 02:48:52 -0800 (PST)
Message-ID: <b11e9554-c3ac-10a8-63ad-46e4f3d1235b@redhat.com>
Date:   Mon, 13 Dec 2021 11:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 06/14] clk: Introduce clk-tps68470 driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
 <20211203102857.44539-7-hdegoede@redhat.com>
 <20211210005710.2BB88C004DD@smtp.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211210005710.2BB88C004DD@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Stephen,

On 12/10/21 01:57, Stephen Boyd wrote:
> Quoting Hans de Goede (2021-12-03 02:28:49)
>> The TPS68470 PMIC provides Clocks, GPIOs and Regulators. At present in
>> the kernel the Regulators and Clocks are controlled by an OpRegion
>> driver designed to work with power control methods defined in ACPI, but
>> some platforms lack those methods, meaning drivers need to be able to
>> consume the resources of these chips through the usual frameworks.
>>
>> This commit adds a driver for the clocks provided by the tps68470,
>> and is designed to bind to the platform_device registered by the
>> intel_skl_int3472 module.
>>
>> This is based on this out of tree driver written by Intel:
>> https://github.com/intel/linux-intel-lts/blob/4.14/base/drivers/clk/clk-tps68470.c
>> with various cleanups added.
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Thank you.

I'm preparing an immutable branch based on 5.16-rc1 + patches 1-4 + 7-11
from this series.

I can send you a pull-req for that once its ready (its building atm) and
then you can merge the branch + this patch on top; or I can simply add this
patch to that branch and take it upstream through the platform-driver-x86
git tree.

Please let me know how you want to proceed with this.

Regards,

Hans


