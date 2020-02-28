Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC331735FD
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 12:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1LWv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 06:22:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54446 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgB1LWv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Feb 2020 06:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582888970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BnoaA17pJMFu998jYGiIMsNzgI1x+bmJkwrgednNKw=;
        b=Ao7tkMjk4EuBJEPzyf1AddE/onNSh6fmkaMEnqgtKcQsYQGFxqgnRWgqdEnyZ4pDdAb6UA
        MiDfECHRgTd3sZB5IRt9PQ+s24IkavNIed+o6aSO5skCz+sf4FtUirc70sOw3dqJkR1tgx
        AgoiiOCj7PCXj4w00PzIlkh6VBvEA1Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-j52aickpN2WioaokLhA0PA-1; Fri, 28 Feb 2020 06:22:49 -0500
X-MC-Unique: j52aickpN2WioaokLhA0PA-1
Received: by mail-wr1-f72.google.com with SMTP id r1so1190777wrc.15
        for <linux-acpi@vger.kernel.org>; Fri, 28 Feb 2020 03:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BnoaA17pJMFu998jYGiIMsNzgI1x+bmJkwrgednNKw=;
        b=TZLs8i+HVd6jUqy/Tfn8XKuNZ/p59g6T3ooKK1rIO5rpCHn8HBFgXjsJ4hNLNuDZ7R
         H1RqS84zhcUrOoRlZLXsG6BuIjJlg+lt/rMzLk80nqcMirK+WUmf2X8JvQzReGOfkq/0
         bUgNb2o+d6qo09FXBc+AZ+aNoTdF6W987m/93Vaw1NUxOLp62EaHciF+MolHU6rnbhUe
         p0DzE+gHvkkBqFQy9SmxTl2zB/4CpxdIUN9og3SIuWxCuux/BgGngI4rbGb9I0iFBbui
         Ojm6Rjajh/A2cZFO8iMgVueONYZsK48jBX0OLRx9z+Y9DtQ1d0l66EsodMlIJ3bXb5BD
         xsIg==
X-Gm-Message-State: APjAAAUrsmhFuR8s3wur93ZaHhOEG+3bBpY8A8cRGzgk/UA6E7RJZ4cm
        U582g1FTIsb4/L6VDjX99gblLt+i8/i2JrNqUc1NOgDegU7OiETkenvV8QMXS/EoXMsw07IXJCD
        ruj5L83ugfKfisffOwD8ZDw==
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr4721416wro.204.1582888967639;
        Fri, 28 Feb 2020 03:22:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUfcO5YrOruRLOgiKuOdm1ewT6kk5ie3QhpLjqx3kLXtS0X76Pmw47xD73u0WNOD3WguS+sw==
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr4721394wro.204.1582888967400;
        Fri, 28 Feb 2020 03:22:47 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id a62sm1786454wmh.33.2020.02.28.03.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:22:46 -0800 (PST)
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
 <20200225123425.GK10400@smile.fi.intel.com>
 <20200225125700.GL10400@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
Date:   Fri, 28 Feb 2020 12:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225125700.GL10400@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/25/20 1:57 PM, Andy Shevchenko wrote:
> On Tue, Feb 25, 2020 at 02:34:25PM +0200, Andy Shevchenko wrote:
>> On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:
> 
>> Let's do it as a list of pairs, but in slightly different format (I see some
>> potential to derive a generic parser, based on users described in
>> Documentation/admin-guide/kernel-parameters.txt), i.e.
>>
>> 	ignore_wake=pin:controller[,pin:controller[,...]]
> 
> Another possible format
> 
> 	ignore_wake=controller@pin[;controller@pin[;...]]

I like this one, the other one with the pin first feels wrong, the pin is
part of the controller, not the other way around.

I will rework the patch series to use the ignore_wake=controller@pin format.

> The second one, while having less users, can be extended to have list of pins
> of the same controller, like
> 
> 	ignore_wake=controller@pin[:pin2:pin3][;controller@pin[:...][;...]]

I don't really see a need for this, the controller name can be repeated
in the unlikely case where more then one pin needs to be blacklisted
from wakeup and I would like to keep the parsing as KISS as possible.

I guess we can always add this later if people feel like adding it.

Regards,

Hans

