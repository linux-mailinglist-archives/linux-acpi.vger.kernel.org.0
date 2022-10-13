Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC765FDF32
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Oct 2022 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJMRoA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Oct 2022 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJMRoA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Oct 2022 13:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CBAFE75F
        for <linux-acpi@vger.kernel.org>; Thu, 13 Oct 2022 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665683037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBH16COFaMraurW5BQ03iXqdQmZGNr7B8EEvtpNgiJI=;
        b=YSWFrNWKtF4kJBsFZ5mWul3+PzIJfX9O5OIeQtWk1tdsyN0tHaCUmfvM0OxuZfz51VhzuU
        IMAXBpXXBwAe7A+dS0dMDHzdWZ+bTon5HnnY5regVOw+aV21F/5VF1HLGKGMngjRvOBh8X
        IHWmcCJpaAZ/Tdm04jeF6qoMo4PfXJA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-176-8pe7Bvd2M7OrCCjMJksnxg-1; Thu, 13 Oct 2022 13:43:56 -0400
X-MC-Unique: 8pe7Bvd2M7OrCCjMJksnxg-1
Received: by mail-ej1-f69.google.com with SMTP id hp41-20020a1709073e2900b0078e07dbf280so1232446ejc.7
        for <linux-acpi@vger.kernel.org>; Thu, 13 Oct 2022 10:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBH16COFaMraurW5BQ03iXqdQmZGNr7B8EEvtpNgiJI=;
        b=d4OriOJ46gmxSvd2D2A1a1P4Jn66ZLylzi1GSCNNyd3j16jXeZteCwfNJbOiN0cE73
         jd/l6oIlLax1AAt4+gkt9kctBK65G6b7+e65ULa9Bln8QqoECjLA+PhnM3gq4FpSgYlU
         JjYmc4iwODAXywbYE+V4qx9eWs/C7bRnkb759uoFKdqmrtz5zEdt3m49HRFZneSlapaN
         PoUo/M3mU0bROVOT2FLqGeWS2/g969pJvpEeHJ+8L+F8MIYxew6tkXkDEIEkjZfqXgAo
         elll+yABnIwigId+z/c1yqY14ss9xjyyfzi654rJkhGuaahzBY5mUDexnyUGipYx1vpf
         pVIw==
X-Gm-Message-State: ACrzQf0+/A0YjCJ8Rs0p/qAPapv5CZbneoIxyKUscEEeN1fJAhyHIGdV
        SU0X++EMQRmHk3zZ5nSaH0/GNJHw+omwydmlAdiwz2rQNQ4uT9zfCla0v8ceZHEFKDSdcHx+VWg
        ZueZSt6mrmQn4Qa7Jnvbl5w==
X-Received: by 2002:a17:906:730f:b0:783:27c5:f65f with SMTP id di15-20020a170906730f00b0078327c5f65fmr706064ejc.142.1665683035230;
        Thu, 13 Oct 2022 10:43:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4TI1HGxAYeVRvzihjtOwK6kR/Ee30FGpow5fdE6Sphw8K3mxV7xrKyYQrsqwtODQKUdEfEVQ==
X-Received: by 2002:a17:906:730f:b0:783:27c5:f65f with SMTP id di15-20020a170906730f00b0078327c5f65fmr706050ejc.142.1665683035032;
        Thu, 13 Oct 2022 10:43:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id t14-20020a05640203ce00b00459e3a3f3ddsm177610edw.79.2022.10.13.10.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 10:43:54 -0700 (PDT)
Message-ID: <fb54891c-cf60-5772-eeb5-28ad6ec2a3ae@redhat.com>
Date:   Thu, 13 Oct 2022 19:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC v3 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?Q?Johannes_Pen=c3=9fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
References: <20221003144214.345279-1-hdegoede@redhat.com>
 <CAJZ5v0gaCYVTSk2wCBVEj9xXCMjtt=Ce8t88Me1kb_MCAuYfBw@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gaCYVTSk2wCBVEj9xXCMjtt=Ce8t88Me1kb_MCAuYfBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/13/22 18:53, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Mon, Oct 3, 2022 at 4:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> Here is v3 of my series fixing some ECDT EC probe ordering issues which
>> are causing issues om some laptops:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>>
>> This is a RFC because fixing this requires some ACPICA changes which
>> obviously need to go upstream through the ACPICA project:
>> https://github.com/acpica/acpica/pull/786
> 
> I've just approved your pull request.

Thanks.

> Also, as soon as it gets merged, you can resubmit the series with a
> proper ACPICA  commit ID and I will be able to apply the patches right
> away then.

Will do.

Regards,

Hans



>> The problem this fixed is best described by the commit message of patch 4:
>>
>> ACPI-2.0 says that the EC OpRegion handler must be available immediately
>> (like the standard default OpRegion handlers):
>>
>> Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
>> 2. OSPM must make Embedded Controller operation regions, accessed via
>> the Embedded Controllers described in ECDT, available before executing
>> any control method. These operation regions may become inaccessible
>> after OSPM runs _REG(EmbeddedControl, 0)."
>>
>> So acpi_bus_init() calls acpi_ec_ecdt_probe(), which calls
>> acpi_install_address_space_handler() to install the EC's OpRegion
>> handler, early on.
>>
>> This not only installs the OpRegion handler, but also calls the EC's
>> _REG method. The _REG method call is a problem because it may rely on
>> initialization done by the _INI methods of one of the PCI / _SB root devs,
>> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .
>>
>> Generally speaking _REG methods are executed when the ACPI-device they
>> are part of has a driver bound to it. Where as _INI methods must be
>> executed at table load time (according to the spec). The problem here
>> is that the early acpi_install_address_space_handler() call causes
>> the _REG handler to run too early.
>>
>> To allow fixing this the ACPICA code now allows to split the OpRegion
>> handler installation and the executing of _REG into 2 separate steps.
>>
>> This commit uses this ACPICA functionality to fix the EC probe ordering
>> by delaying the executing of _REG for ECDT described ECs till the matching
>> EC device in the DSDT gets parsed and acpi_ec_add() for it gets called.
>> This moves the calling of _REG for the EC on devices with an ECDT to
>> the same point in time where it is called on devices without an ECDT table.
>>
>> Changes in v3:
>> - Add a prep patch to fix an indentation issue in Linux' acpixf.h to fix
>>   the patch from ACPICA's script not applying
>> - Add 2 new functions to ACPICA for this instead of a flags argument
>>   1. acpi_install_address_space_handler_no_reg()
>>   2. acpi_execute_reg_methods()
>> - Add a patch to fix EC handler removal in the ECDT case
>>
>> From my pov this series is ready for merging once the ACPICA changes
>> are accepted.
> 
> I agree, please resubmit as soon as the upstream ACPICA pull request
> gets merged.
> 
> Thanks!
> 

