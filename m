Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A124752D6E5
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbiESPGq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 May 2022 11:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiESPGm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 May 2022 11:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0B9830F65
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652972801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cukqKLlYVO6UiHSZMrtRJgoast0/luZetDqiqEdUko=;
        b=JuRsPyE/6yd87aXDGGXsCXMbaSPJxtbOuowTigP+hV2HGuoLuoS14E7lUPXeWhdTVsobjV
        IE4yHbZyctXnh7YasNo+HbNNsQxhOD5A4KshRNMNc3+YX0PIzVPnKjKgp99a1SjCB/ICt/
        RaEW76AZtSBDUn+V6wi1Jyx6icaamC4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-rKZlsbVKNgO261EbRWTgEQ-1; Thu, 19 May 2022 11:06:39 -0400
X-MC-Unique: rKZlsbVKNgO261EbRWTgEQ-1
Received: by mail-ej1-f72.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso2706828ejs.12
        for <linux-acpi@vger.kernel.org>; Thu, 19 May 2022 08:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6cukqKLlYVO6UiHSZMrtRJgoast0/luZetDqiqEdUko=;
        b=4B+XeEEu8hrA/YnI+8GtItVscuGlpWXZqirpmUJKYcc+38bQbOWaUh7B/wh3mP0MVz
         uEWnNWbQ6QY/OID/qpk4lthhLSM/yc0jE7Jn2Gi+tCfnjlQNT78j6aNEwISaTGa5+ANu
         XemRdTJNjMwPl5xv1YY8MiHEg0ZweCmTiKFXtR+GKQ8HraFze3UXp1Sx8cATVF/W9J/x
         XjVoy+FvEBGvMMeFeBhI73dmrYrq0lerR/4/Zl5pYu3JH4TtTFtKxxa7OycOcUPNM6CN
         Kx7HMgemZTkXLcbOEt+hMYp8Jt8WfovwV/x2uWKUMJ26wN9oc6J2zT6+BdkQAVWPpNeq
         Z6LQ==
X-Gm-Message-State: AOAM532sR20fxrVwFpQKr58M5yQYwTvI+tUauMD3UmG2Zwti8UdkUEEx
        uq+V3tVLFlACd1+E8yuY5k4hNTqj0WiZEVfEvFxG4B8HhT1bjGIRWek6NHLLqc4ZDkvj/GFUQlE
        9KMGFRXwwycBYg4+AMnBBTg==
X-Received: by 2002:a17:906:ece3:b0:6f3:da10:138a with SMTP id qt3-20020a170906ece300b006f3da10138amr4833728ejb.438.1652972798594;
        Thu, 19 May 2022 08:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNOoQNKVItf73DSDM0VafoQHW0cH49Hzz2nXR7wvug3z2zrL8Tzk3+pUB5ClBDB3sbRS2J6Q==
X-Received: by 2002:a17:906:ece3:b0:6f3:da10:138a with SMTP id qt3-20020a170906ece300b006f3da10138amr4833709ejb.438.1652972798316;
        Thu, 19 May 2022 08:06:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402120600b0042aa6a43ccdsm2953894edw.28.2022.05.19.08.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 08:06:37 -0700 (PDT)
Message-ID: <4f10c3aa-5eca-ee00-6b9e-f152ffdcca7f@redhat.com>
Date:   Thu, 19 May 2022 17:06:37 +0200
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
References: <20220519144923.GA22233@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220519144923.GA22233@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bjorn,

On 5/19/22 16:49, Bjorn Helgaas wrote:
> On Thu, May 19, 2022 at 04:29:43PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 5/19/22 16:14, Bjorn Helgaas wrote:
>>> On Thu, May 19, 2022 at 04:01:48PM +0200, Hans de Goede wrote:
>>>
>>>> Ok, I'll go and prepare a v9 and I will submit that later today.
>>>
>>> Would it be practical to split into three patches?
>>>
>>>   1) Add command-line args
>>>   2) Add DMI quirks
>>>   3) Add date check
>>>
>>> It seems easier to assimilate and document in smaller pieces, if
>>> that's possible.
>>
>> Ack, will do. Note this will cause quite a bit of copy/paste
>> in the commit msg to explain why these changes are necessary.
> 
> OK, if the repetition gets excessive I can squash them back
> together.  Hopefully the main explanation can go in the first patch,
> the second can just mention the fact that these machines need the
> exception, and the third can focus on the plan for the future.

I'm almost done with prepping v9 and atm there is a 17 line
introduction of the problem which is shared between all 3
patches in the commit msg.

I personally don't think this is too bad, but feel free to
shorten it a bit in patch 2 + 3 before merging these.

I think the split makes sense, so I would prefer you amending
the commit msg over squashing them back together again.

Regards,

Hans

