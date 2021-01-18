Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5A2FA561
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393356AbhARPsI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 10:48:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405995AbhARPe0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 10:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610983979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTZcVq1Ep1CR1WH46c5PqheI+6A00IvbUKXMhBi/vHM=;
        b=TB6OYNVAI+W9AlWt/1Q81fKLBiah2xxnWem93LTbIez+ZPxySdqW+pyYMhHVILaJTF//ZD
        A7J+NM8UMNPt9VGxGWotltJNTvGw8RbdsoZSjSoefYyAjnKQW87qGKtg1HBL04FgUwH1+u
        WjhEyOd0sK7Yu9jQaIGgHD/R2HkL4Pg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-aC6YMeTzOT67JSzcBDIHKw-1; Mon, 18 Jan 2021 10:32:57 -0500
X-MC-Unique: aC6YMeTzOT67JSzcBDIHKw-1
Received: by mail-ed1-f70.google.com with SMTP id w4so4266655edu.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 07:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JTZcVq1Ep1CR1WH46c5PqheI+6A00IvbUKXMhBi/vHM=;
        b=pqpk4KMN2yhniicbmiOAE5sL7PH1SJe7Qy4ZVYKhOh0Uty7B3mpsSurgMRsEu+AaT2
         OP3e+RQ8hPbbp8D89xx2lBoheoxFZqzbxzyyrEEGYQc2x+CDLqA6sx1p06SWzbSme38/
         AFXEDO4ToNpScXQPdnQJKeJ5mZzKCiB7TwPOKdR/84OpkHVpSoYmblRY3ZXS8DMsy37n
         X2PdTRGYIy/eYSWvPh/ZRsJx1DqDUweECNzPriWMpXYvkVKrSJPqVhLfvgzSKemoUp5Y
         f9nHvqjHNKYPWrbvNj8UlVYc/yF8/W+xBRVrr8aEjSpmpNbw8cSUtkPBOf+OWnZh5kSf
         /51Q==
X-Gm-Message-State: AOAM532XUdUQp0POB68sm2rq66e0xX0I9x17HrkNC28ed47vSLr68OZA
        9MIJCqnFOXg3dJDL59z1eMLLBUBvqxpSZHoY9xHxFgiE6lS446SUS4uyXWCoqxxi5NKCznttNrP
        MdaNcocfguy3nVeevf6eT1Q==
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr159913ejc.227.1610983976404;
        Mon, 18 Jan 2021 07:32:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycAq+hqWDtUQe7NVghv7pF04QqTqMhEAqZ/RU/z2hM4W99B0SgV7qJ5jp+uqhNGO9HnpVacg==
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr159882ejc.227.1610983976211;
        Mon, 18 Jan 2021 07:32:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id v15sm330168ejj.4.2021.01.18.07.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:32:55 -0800 (PST)
Subject: Re: [PATCH v2 6/7] platform: x86: Add intel_skl_int3472 driver
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>
References: <20210118003428.568892-1-djrscally@gmail.com>
 <20210118003428.568892-7-djrscally@gmail.com>
 <-GKrxu8GJvGe-PlKkLpblw9N-DtVtS7i87BOCLgJR72yf4hUFpUgiOlGcFero_gqgUxJrX2gxtLOnz_31hJugfam0SXXmXxIzGIhS162mhI=@protonmail.com>
 <20210118135121.GM4077@smile.fi.intel.com>
 <w3qrFtorGLZ_wMnr_Mi7cltli9g8jsMtiQ7Z1Usnj2IKfJ1MJz6-wxlIAEQ-ErgU1x6IBxdAIHBHtQ3OOT_FJOuUYheILlUc20ysNL_zroo=@protonmail.com>
 <20210118152323.GV4077@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e1032328-c5e8-0bfa-4b87-64207d283d17@redhat.com>
Date:   Mon, 18 Jan 2021 16:32:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210118152323.GV4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/18/21 4:23 PM, andriy.shevchenko@linux.intel.com wrote:
> On Mon, Jan 18, 2021 at 02:51:30PM +0000, Barnabás Pőcze wrote:
>> 2021. január 18., hétfő 14:51 keltezéssel, Andy Shevchenko írta:
>>
>>> On Mon, Jan 18, 2021 at 11:12:34AM +0000, Barnabás Pőcze wrote:
>>>> 2021. január 18., hétfő 1:34 keltezéssel, Daniel Scally írta:
>>>
>>>> Have you considered putting the source (and header) files into a dedicated
>>>> folder? I think it'd help manageability in the long run, and it'd be immediately
>>>> obvious that these source files form a single "unit".
>>>
>>> What would be the folder name? Because, for example, intel_cht_int33fe* have no
>>> folder (yet?) and here it's kinda similar case when HID describes something
>>> else than just one IP.
>>
>> I think "intel_skl_int3472" would not be a bad name for the folder. And I believe
>> "intel_cht_int33fe" could be given its own folder as well.
> 
> I;m not objecting (at some point in the past I had proposed moving Intel stuff
> to a separate folder, but at that time PDx86 has no folders at all and Darren
> was kinda not in favour of creating ones, but things changed), just let's hear
> Hans on this.

I'm in favor of using a folder for this and "intel_skl_int3472" is fine with me.

With that said I'm not entirely sure if I'm in favor of the _skl_ part of
the folder and driver name or not.

The INT3472 ACPI device is used with other CPUs, e.g. Apollo Lake too and
I think the driver should work fine with those.

The intel_cht_int33fe case is special because the driver only applies
to some models with an INT33FE ACPI device (the whole INT33FE ACPI device
is a horrible thing which seems to stem from Intel rushing Bay Trail to
market to try and compete on the tablet market).

With that all said SKL probably is the first SoC to feature this and I
guess future IPUs may still use INT3472 given Intel's BAD habit of
re-using ACPI HIDs for multiple incompatible generations. So I guess
that keeping it is fine; and if we then need an incompatible INT3472
driver for newer IPUs we can use a different prefix for those.

TL;DR:

1. Using a folder is fine, desirable even
2. I've some concerns about the name, but I'm not really objecting,
just giving my 2 cents.

Regards,

Hans


