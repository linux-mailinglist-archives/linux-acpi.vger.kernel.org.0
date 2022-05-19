Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44152D611
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiESO3w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 May 2022 10:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiESO3v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2022 10:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C64F370904
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652970589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=skQV/7bpYYCLikiWPou37BZfffdt7LpNOeVYRjZR2lk=;
        b=efZ0FspOjKjIWqZk+E4Aiy0Hv05qylCBoRDJ/n9O5WinOKQI8qEttc9ukuGuVMJCauI2/h
        UI8eYpGyuWnbztaPx1+DItp481AqH3plJV9K+aWLfJezxjUkXQXCcq6DJPFOre+I1GWWgM
        6GFt58ju6PORnL2N6G/g8BnBXAlVHPQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-Xg-Yr3raMhGBENVmlzr2pg-1; Thu, 19 May 2022 10:29:46 -0400
X-MC-Unique: Xg-Yr3raMhGBENVmlzr2pg-1
Received: by mail-ej1-f71.google.com with SMTP id sd38-20020a1709076e2600b006f3e54b1dbcso2637992ejc.4
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 07:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=skQV/7bpYYCLikiWPou37BZfffdt7LpNOeVYRjZR2lk=;
        b=WReMpMcygb4JTiO9i/FDYQ6w4t7fg6TZT0m1WblMmVJqpP365s7Hm64CjEJeBiecpg
         CTHtxBCY5vTE3s7OvzrzXPJP2PRZZvvR2tAJ0Nn30fZ03Y36/6ybSkqpy/0LCSOtxlE3
         8vEFu36hgoXPHrXF68YgjWJ7NUW9+fUqeigmj5Ph70nR9PQcynmYJiQBNkMwnUyOsS0W
         7LvayKIAYLE3h3VGtyhcFENnLo7gi2z1TX/pNB35U7oHbCvzVirdqtbgukyFeKA8kn4s
         SJpsMM7DyYJFKUHREpH4OEn9p4NiTrCW/i7fdvbxH55KmatE2pOHtJRxLXRUAdOFojbL
         Bndg==
X-Gm-Message-State: AOAM532CgEK4YsE4k4IGO9EwaPfRPVnX4rP8kesYKBnOd+F4/4yytO8T
        o4ja0rA0eZIBSZH6z7kzZUh1NY3qR4YYFTwSncAFdo94wmyDD82nffEPHFtGb+sI/VS5Bu1bu5B
        sd3IyBm6zpiZRgjBz0fWcQA==
X-Received: by 2002:a17:907:6e09:b0:6fe:8b65:357b with SMTP id sd9-20020a1709076e0900b006fe8b65357bmr4556166ejc.492.1652970585077;
        Thu, 19 May 2022 07:29:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR6WHxquEyjTqk32bptNw0qJbDMyBekjUeS7a4RWeKtvRRxz2LEG0cbg0e2bJOBOt7i1Z4UQ==
X-Received: by 2002:a17:907:6e09:b0:6fe:8b65:357b with SMTP id sd9-20020a1709076e0900b006fe8b65357bmr4556142ejc.492.1652970584862;
        Thu, 19 May 2022 07:29:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906729a00b006f3ef214e0esm2184208ejl.116.2022.05.19.07.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:29:44 -0700 (PDT)
Message-ID: <c49dfdf1-c1e8-a9d2-0f31-f190d7b6631f@redhat.com>
Date:   Thu, 19 May 2022 16:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519141450.GA19225@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220519141450.GA19225@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/19/22 16:14, Bjorn Helgaas wrote:
> On Thu, May 19, 2022 at 04:01:48PM +0200, Hans de Goede wrote:
> 
>> Ok, I'll go and prepare a v9 and I will submit that later today.
> 
> Would it be practical to split into three patches?
> 
>   1) Add command-line args
>   2) Add DMI quirks
>   3) Add date check
> 
> It seems easier to assimilate and document in smaller pieces, if
> that's possible.

Ack, will do. Note this will cause quite a bit of copy/paste
in the commit msg to explain why these changes are necessary.

Regards,

Hans

