Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034092F8F71
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jan 2021 22:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbhAPVaR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Jan 2021 16:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhAPVaM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2021 16:30:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C42C061573;
        Sat, 16 Jan 2021 13:29:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 6so5501213wri.3;
        Sat, 16 Jan 2021 13:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2Th5lDGpBI/Rhu3/73k5rMrbZQS4Y/S/x1FlM2kyjVU=;
        b=A0K6e7pgp6V067iGxutfRK0GYQppIu37GjUXW4hN/fNIkicSKz288qebc35p31RaII
         X6zbjFRfQo+4F9Sr1KV/xhWNxY3aoK4bpnEGfgNgVY2c0yDzubI3yngZM5oHWfzX0quM
         2FEioGjTO+UdhYiQYnrPFIHyJkSY5UOMRoq3fXjQXelEvm+V4Mo4OMkCG/tk5/hfqE6I
         8jHtvnlr7O/R3cs+vA//i7ZbBA6XCQ9TMRZp8xJVO7waREOL3oF2swyzsUxYIworNuYP
         2rZKRcaX+ejEK8yNli3MhJxRJFM/l6gZm4zKxrZizB6LZ0PgbRqSRcHM21xJ1Gnj+7mS
         X+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2Th5lDGpBI/Rhu3/73k5rMrbZQS4Y/S/x1FlM2kyjVU=;
        b=XnWApkg+/CLk+CnfQmR4DP8levSh5OBwFoB6rKl+j2yan4SzTFKT/o/DXSQwwztpE1
         y02X8edcEF02ZUoy57nuoGNifga/zYdKIAbJ2vB6PIVquAaZ5cqkzeIgaOS1xQYYplgz
         jU5ZIe1rBmB02f7K2/rj0nVkY+++rK5DqP0TWcm+F3f+4E/Lb7AYfXbX9kTI0GRs5cMj
         Xk5zK+LxVtrGhIsHtvMaJr8ZHG0MULVik/AvAVcFyPronhdT01OhucNcvkKV3arTAzrF
         0K81hWNmK8l0Q4V+tt8+NAXI+6OF+0dWfN4gYl/HmiZuO8f3kFA+sP/KoVUVubqPZ93B
         jVxg==
X-Gm-Message-State: AOAM530yaaycizgJqsGAa1yEX4lD61Qt5XEfqer0suDskcJl0jaVjQ1i
        NZVEKmWS5wTcH2RuqxlKYMC+6tGYOQ0=
X-Google-Smtp-Source: ABdhPJz+i5Ro02n6fk6qh4otSWdV1pNKb/SlP/Oa0qdCaFU9Nxg9lTmkKpR5//+vCGOFFrlcVwjn6w==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr19730858wro.97.1610832570621;
        Sat, 16 Jan 2021 13:29:30 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id y14sm15263314wru.96.2021.01.16.13.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 13:29:30 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Remove one more platform_device_add_properties()
 call
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <greg@kroah.com>, Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210115094914.88401-1-heikki.krogerus@linux.intel.com>
 <CAHp75Vc3xjaOugX3d8bohz12OEP=n4BAonNyQJQ=UgBfVZorOg@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <c644e72c-bb46-56c2-931e-7cb98b024cc3@gmail.com>
Date:   Sat, 16 Jan 2021 21:29:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc3xjaOugX3d8bohz12OEP=n4BAonNyQJQ=UgBfVZorOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16/01/2021 20:23, Andy Shevchenko wrote:
> On Fri, Jan 15, 2021 at 11:52 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
>> Hi,
>>
>> I'm now clearing the dev_fwnode(dev)->secondary pointer in
>> device_remove_software_node() as requested by Daniel and Andy. Thanks
>> guys, it's much better now. I also took the liberty of including one
>> more PCI ID patch where I add PCI ID for the Alder Lake-P variant. I
>> hope that is OK.
>>
>> Andy, I dropped your Tested-by tag because of the change I made to the
>> first patch. If you have time to retest these, I would much appreciate.
> Since Greg already grabbed a v3 I will test it when it appears in linux-next.
>
It seems the grabbed one is the v2 one though actually
