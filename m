Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B8F42FCD8
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbhJOUQn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 16:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234285AbhJOUQm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Oct 2021 16:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634328875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ob0cXS+iTVqhTc0LL+1lwvmPqj++Muh+HEaU63BqtuQ=;
        b=OGWzt5e25yJYQiQD7/uF8o+UKGtYVDv5oE7oDURTcvbPBEYtOKPrlhvQfdWBaxwjDQS0JO
        X9ECFLmDU7/O8GHVKiQtm2jVhUTa6cWeaclrBzB9SRvErD9jVWnhZ2vZT45KU4dmQW2N2Q
        Slx3SPuQYj63wlRBl3g6xijzBjJWYHU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Ugk9BqnNMkOXc87t68v1dw-1; Fri, 15 Oct 2021 16:14:34 -0400
X-MC-Unique: Ugk9BqnNMkOXc87t68v1dw-1
Received: by mail-ed1-f72.google.com with SMTP id p20-20020a50cd94000000b003db23619472so9259217edi.19
        for <linux-acpi@vger.kernel.org>; Fri, 15 Oct 2021 13:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ob0cXS+iTVqhTc0LL+1lwvmPqj++Muh+HEaU63BqtuQ=;
        b=URlOjWac0Fc0/x7pwLFUkUzHoQ1H4P/nDzwl3c6mJf3L2HvBVLy/wvIquIhjBbo+/c
         tgr7ccHGdAskK5wucah7q8GIxf++NMtw3DY7nwq2+LQKNyAZr9hBLtLSqiy46BGUejxz
         fELXjtSNQhEXaIq7F+8DaeFwNJsbkINIEKpoyRIEav6zwPrmCjaqpvQY2eF0JZKr6O3u
         CqgvJURewxW5VWgplKClrLnO8XNfTtvjNf27BbgaJlFUia//kvN7tNKQAsHULiNYlRP2
         Nhi0usZU9RAFBrxP//5ggMrgE8V/AXzTWbDVruVtzpvWAejz8mdVLKRk9tpjd2BUZdGI
         /5vw==
X-Gm-Message-State: AOAM531CESaA7W0Yz5XbnrIL/PEXroocYKOgccQyd8KoI6wR8uQFg7A7
        2NGMqN0q94BvU+msngfl2peZaG1I+G1aiDNm/ua9u4KgrdBBxnlUCThsvqgLzz6/MVY3tMk3VWg
        cQn61TQTnwQff2HxsKQif3Q==
X-Received: by 2002:a17:906:25d7:: with SMTP id n23mr9598473ejb.322.1634328872883;
        Fri, 15 Oct 2021 13:14:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxezyePB9FvDabIoN4SDBtXb0EfYt6tXjhJ1dDf14blwJ1cW4KunpzRXCflX2qy8gweIQsg7g==
X-Received: by 2002:a17:906:25d7:: with SMTP id n23mr9598434ejb.322.1634328872644;
        Fri, 15 Oct 2021 13:14:32 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id z18sm4752728ejl.67.2021.10.15.13.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 13:14:31 -0700 (PDT)
Subject: Re: [PATCH 05/12] regulator: Introduce tps68470-regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-6-hdegoede@redhat.com> <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
 <YWmwZJvDYjPWJdb4@sirena.org.uk>
 <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
 <YWnPaI/ZECdfYre9@sirena.org.uk>
 <843f939a-7e43-bc12-e9fc-582e01129b63@redhat.com>
 <YWnZIZTPiuAIazV+@sirena.org.uk>
 <c595b143-d7ed-e76b-7734-e03d14e0f76e@redhat.com>
 <YWndpGgBtLEAEaNj@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1805d16e-87ab-c291-6a73-adabf41344ca@redhat.com>
Date:   Fri, 15 Oct 2021 22:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWndpGgBtLEAEaNj@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/15/21 9:59 PM, Mark Brown wrote:
> On Fri, Oct 15, 2021 at 09:48:24PM +0200, Hans de Goede wrote:
>> On 10/15/21 9:40 PM, Mark Brown wrote:
> 
>>> I can't see how the quirking gets propagated through into the driver and
>>> I'd really expect that in a situation like this the platform data would
>>> be passed through as platform data from the code doing the quirks,
> 
>> That is exactly what is happening here. The platform_data in this
>> case is just an array of regulator_init_data pointers (one per
>> regulator in the PMIC):
> 
> No, it's not.  What normally happens is that whatever registers the
> device will when registering the device supply platform data that the
> device later picks up from the struct device during probe.  What you're
> saying is that the idea here is that driver unconditionally declares
> platform data and then other code scribbles over that before the driver
> instantiates.  This is cleaner in that it keeps the platform
> configuration together and safer since the device can't exist before
> it's configuration is provided.

Right, this is the standard device-tree model. Unfortunately the
information about which supplies are needed and the constraints
for those supplies is missing from the ACPI description for the
devices which we are dealing with here.

Daniel Scally tried to solve this by allowing specifying this
in software-firmware-nodes. Which you nacked because those need
separate parsing code in the regulator core.

During that discussion you said that instead we should sinmply
directly pass the regulator_init_data, rather then first
encoding this in device-properties in a swnode and then
decoding those again in the regulator core.

And passing the regulator_init_data is exactly what we are doing
now; and now again this is not what we should be doing ?

Also note that the current solution is exactly what I suggested
we should do during the discussion with Daniel and I even provided
example code and you said absolutely nothing about this!

>> So we have the code doing the quirks determining the regulator_init_data
>> and passing this through platform_data, which AFAICT is exactly what
>> you want?
> 
> No.  There should be no sign of the platform data getting allocated or
> initialised in the driver consuming the platform data.  It should purely
> be reading the data it gets passed by the platform initialisation code.
> 
> Please make the use of platform data look like normal platform data use
> rather than going and inventing some new scheme.

I'm sorry but I no longer have any clue what it is what you want us to do /
how you want us to solve this.

AFAIK what the current code is doing is exactly what you requested during
the discussion with Daniel.

If this is not to your looking please provide some pseudo code explaining
how you want us to solve this problem instead of the current solution.

And please keep in mind that we *cannot* change the ACPI firmware interfaces
and that whether we like it or not things simply work different in the ACPI
world.

Frankly I'm quit unhappy, angry even about how you are blocking progress
here. You don't like APCI we get it, can we get over that now please?

So far all you seem to be doing is shooting down solutions, then first
being quiet about suggested alternative solutions and then once the
alternative solutions are implemented shoot them down again...

And all that without adding anything constructive. All you have
told us is how things should not be done (according to you).

So fine everything we come up is wrong, please tell us how we should
solve this instead then!

Regards,

Hans


