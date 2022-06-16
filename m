Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BED54E341
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jun 2022 16:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377667AbiFPOUr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jun 2022 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377665AbiFPOUo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2022 10:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F5C5FF8
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655389242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CP26oKQZpYaHtXMoa2k1lVl6zQxP33lDkoRtUPmB3UQ=;
        b=F40xhRW/CI6JgS/i/rINcvwcn+5cE0utep8cboc1eOsw4cXYw8dAGsscynTr43xWFktB5c
        Q5WNVC9oM0t3l8VmcwD9pdrV9+7QRfbPpdi/s1bA8Ty9Ou4hqynyQLEBgjmOMK6NSbWWC/
        wevZ6qz82UvY4J178VmtPFF10Krqaqc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-k9SIsM-VNRazL8y9weYVxA-1; Thu, 16 Jun 2022 10:20:41 -0400
X-MC-Unique: k9SIsM-VNRazL8y9weYVxA-1
Received: by mail-ed1-f72.google.com with SMTP id x15-20020a05640226cf00b004318eab9feaso1364376edd.12
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 07:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CP26oKQZpYaHtXMoa2k1lVl6zQxP33lDkoRtUPmB3UQ=;
        b=2J718gaNzeeSxeXaZFdhxSHyQrWjHnSfAaAV7rqP/pP/+TgszPnm2AO2R3G4n/bDT+
         UMUTmEdaKrbwLI79Bzv+Uhh7omiu51TLxuIQE51ev3VV1x5UFPuRat7aFuM3zdh258Uo
         bYIYTqecs5HFv2ZOXyT8NRxdTi3cUktZEjQZeEefgytb/pT5YqjCuwo/Mr5M0Prv8IDT
         qijR3vbTtD8zXI7o7ZDWYBOpzchyQH6RUwpaArbER4mdGBjQh85PmAAx7GHxqAdL7KJX
         6eLQK/3mKvk6CO6Qg6SxUXci7Uy49rn/RcjzoLB3M92OK/hv2VQ3Kt/vwnaqolw6L1TK
         6GqA==
X-Gm-Message-State: AJIora/zNNAk4qBwWDZx9bOypuvWXYlxnuTcXRX9jnyM5+7GEo6oN5la
        NTL8Nfl8BzjNzw6v/4sKjbaeMJDQwiZgmE3qkwSEnBil7YBdrFIyUFpBVprJrN4xFawCv3fpLy8
        YjsHow6hJ2CSSCT/oOsxCBQ==
X-Received: by 2002:a17:906:561a:b0:711:cfa2:6a35 with SMTP id f26-20020a170906561a00b00711cfa26a35mr4747293ejq.251.1655389239995;
        Thu, 16 Jun 2022 07:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulrr5Hvj44oHAdjCD6MwWL4JitLdu/yGPpIyCG4NXlCWpXDhdsHOf97jInjNLb3t/5pK8b4w==
X-Received: by 2002:a17:906:561a:b0:711:cfa2:6a35 with SMTP id f26-20020a170906561a00b00711cfa26a35mr4747275ejq.251.1655389239814;
        Thu, 16 Jun 2022 07:20:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ck6-20020a0564021c0600b0042ab02e3485sm1893837edb.44.2022.06.16.07.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 07:20:39 -0700 (PDT)
Message-ID: <7b8f9902-590c-0d2e-774b-173cd6bc97c1@redhat.com>
Date:   Thu, 16 Jun 2022 16:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC 2/4] ACPICA: Add \_SB.PC00, \SB.PCI0 to
 acpi_ns_early_initialize_devices()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Johannes_Pen=c3=9fel?= <johannespenssel@posteo.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20220615195643.12608-1-hdegoede@redhat.com>
 <20220615195643.12608-3-hdegoede@redhat.com>
 <CAHp75VcPEw93_3dZvKCadnAqrJCVvdVcKh+DodgBC68xkmJ7VQ@mail.gmail.com>
 <e1647dae-cde2-868d-458d-ffe969203566@redhat.com>
 <CAHp75VeD5Ej3jvV=MtAB9fNxgyd8V8Wr+MZZnvbgzy2v3+eJmQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VeD5Ej3jvV=MtAB9fNxgyd8V8Wr+MZZnvbgzy2v3+eJmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/16/22 13:27, Andy Shevchenko wrote:
> On Thu, Jun 16, 2022 at 11:13 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 6/15/22 23:31, Andy Shevchenko wrote:
>>> On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>>> -       char path[ACPI_PATH_SEGMENT_LENGTH + 2];
>>>> +       char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];
>>>
>>> Strictly speaking this should be, IIUC,
>>>
>>> 1 + ACPI_PATH_SEGMENT_LENGTH + ACPI_NAMESEG_SIZE + 1
>>>
>>> \\ + path segment length (with a separator) + name + \0
>>>
>>> That said, it seems the original code adds 1 unneeded byte.
>>
>> Right I already knew I needed the " * 2" when writing the
>> original code, so I decided to do things this way for KISS
>> reasons.
> 
> Yeah, but then you don't need + 2, it should be +1.
> I believe the initial use of ACPI_PATH_SEGMENT_LENGTH vs.
> ACPI_NAMESEG_SIZE is a bit misleading.

You are technicaly correct, but the code is IMHO just
easier to read like this:

char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];

Then like this:

char path[1 + ACPI_NAMESEG_SIZE + ACPI_PATH_SEGMENT_LENGT + 1];

And also to be more technically correct it would need to be:

char path[1 + strlen("_SB") + ACPI_PATH_SEGMENT_LENGT + 1];

Since "_SB" only uses 3 of the 4 bytes in ACPI_NAMESEG_SIZE,
so that would save us not 1 but 2 bytes on the stack.

But those 2 stack bytes are really not worth the worse
readability of these options IMHO.

Regards,

Hans






> 
>>> Perhaps a comment in the code?
>>
>> I've added a comment to my local version now.
>>
>> After this thread has had some more time to gather feedback
>> I will turn the ACPICA patches into a acpica github pull-req
>> with the comment added.
>>
>> (or if necessary rework the entire series)
> 
> 

