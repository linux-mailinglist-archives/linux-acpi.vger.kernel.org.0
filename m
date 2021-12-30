Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D670A481C1C
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Dec 2021 13:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhL3MeR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Dec 2021 07:34:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239289AbhL3MeQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Dec 2021 07:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640867656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ut4wgPb7k5x4/Ao0enPwI8WZ94CXIktnwuIhAN3PoC8=;
        b=GPtO54UiVgbK5S19Qh9s6BnQxsqHZWmO/SAUSWjprxdGpRtQ0lH1UbM+oeNrUQw3PTteSQ
        EB6nwxuL/S1qhFNTqMndK5xx2Mcuk/i0hoet/0Nn+E3EIKOd4f1EwlyTws/KlmHDybk1Be
        WMFKKmgGth7zCjXOR0njIknjvbLPidI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-pVskqwpIP-aoy5hPJYItXQ-1; Thu, 30 Dec 2021 07:34:15 -0500
X-MC-Unique: pVskqwpIP-aoy5hPJYItXQ-1
Received: by mail-ed1-f71.google.com with SMTP id w10-20020a50d78a000000b003f82342a95aso16978837edi.22
        for <linux-acpi@vger.kernel.org>; Thu, 30 Dec 2021 04:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ut4wgPb7k5x4/Ao0enPwI8WZ94CXIktnwuIhAN3PoC8=;
        b=XfDKe6cyLwPfnvXRPfAQ4nW47E7RhrNUNXTadAA+uVekkw+1tUgwktUBZho2oVs4Ng
         N6gQMkbT/p1rtpZJzF8e2RzjYo6/SR6Tn5CZ6xPbm22GIqyH4lz+IKBVid4UDswJCoRE
         Qa/1jKMcVhOwHhXH5YKr8jxJj3nW9VlX+48/elKq41QOcLr51L3L4R1+Kqyqb96JjgvY
         R/613OwYy0jD2q2gH+UFNDRpozCI/wOF51SKkZ7bA3U5r3lWCsMjeRtI8VW8od2BcbT9
         oh/3GuXJK5Qn+oadc0ZAbc4/ofWLlBRSICg1Dl7U3cDgTONVSK7dTyeKtbhghvGBc8WM
         k+dA==
X-Gm-Message-State: AOAM532GcopwDlKfAsSG9Sg4is8zGgA2AxWJ/MVyn5IRqyH/nxa9chYx
        Z9i0nmxRW2BSBoXZFSeHOdcb1kR+9LZaXv+/CQsyDKQmdz3KI0qWIXz9Vw+3ho8rJvxpDS+zWKC
        p4ce7/vAZDsUnOb/zkKGteg==
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr24120217ejo.51.1640867653941;
        Thu, 30 Dec 2021 04:34:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzmnjnx4eSy7lbaE43bW3/7p+qVtytMv1zH5egd5JLWaMS/r/RUe/rAah2zABTS6qH1ctxUQ==
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr24120207ejo.51.1640867653805;
        Thu, 30 Dec 2021 04:34:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id cn8sm9422998edb.13.2021.12.30.04.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 04:34:13 -0800 (PST)
Message-ID: <0a8e5ec6-5739-5391-deb0-df65b7e01e61@redhat.com>
Date:   Thu, 30 Dec 2021 13:34:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 02/12] i2c: acpi: Do not instantiate I2C-clients on boards
 with known bogus DSDT entries
Content-Language: en-US
To:     Wolfram Sang <wsa@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-i2c@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-serial@vger.kernel.org
References: <20211229231431.437982-1-hdegoede@redhat.com>
 <20211229231431.437982-3-hdegoede@redhat.com> <Yc2kPCe3R0EX8+A1@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yc2kPCe3R0EX8+A1@kunai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/30/21 13:21, Wolfram Sang wrote:
> 
> Okay, I have a question, after all :)
> 
>> +static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
>> +	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
>> +	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
>> +	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
>> +	{ "NPCE69A", 0 },  /* Asus Transformer keyboard dock */
>> +	{}
>> +};
> 
> Can't we add this table to patch 1 and check it within a
> acpi_quirk_skip_i2c_client_enumeration(adev)?

Yes that will keep all the quirk-handling / ugliness together in
a single place, so that is good idea.

I will change this for v2 of the series.

Regards,

Hans

