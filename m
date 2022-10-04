Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC85F3F7E
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Oct 2022 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJDJ0k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Oct 2022 05:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJDJ0A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Oct 2022 05:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D285726D
        for <linux-acpi@vger.kernel.org>; Tue,  4 Oct 2022 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664875414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JkoeR+Mq9UuP0i/zAS9R9qOBYeLCfGROCJkxu+6AQ4=;
        b=ZgePNnPZQstEbiLe7PVf/kKVj3qRFDNu36XhCMGnZDdW5iDx67P2w8l9VLxaQvg+gODYVu
        fbsS13/0tcVb+vISd/c90I1eJLmEMn8UjN5idtC83pioZYUlY/O09jJSxtuzzl+ZyvLQoJ
        VJyhWZO510J0ZangCMAXSHWn7rag6NU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-ll6eTFMMOjeU0IOaPHyx3w-1; Tue, 04 Oct 2022 05:23:33 -0400
X-MC-Unique: ll6eTFMMOjeU0IOaPHyx3w-1
Received: by mail-ed1-f71.google.com with SMTP id w2-20020a056402268200b00458ef2a5a4eso4367925edd.9
        for <linux-acpi@vger.kernel.org>; Tue, 04 Oct 2022 02:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+JkoeR+Mq9UuP0i/zAS9R9qOBYeLCfGROCJkxu+6AQ4=;
        b=lsNsyYaf6PxWNZgtQz4pIP6yQHWb4oBt2cFtzD9UCETvkbwvHkhB+gRYoCfYNhd4Ja
         eVCiuS4ICdPLZJOFiWEBujhkoTH5hwE71L/e9mj2rGuKD2UdBOQRNRAV3rKO1tD7YJ+w
         3xvivAkcpSp/yUnAjwmRlO/jn2JdKeeypdctuTReqsR846T1KkoW4OZH+qw98I+Ch1rY
         tSBq06K3pXJXb9QGGaAc42symu63M4xebHcUT4Z+eq0K1ezWt1zAfNPJ/Ew1miWQP8K2
         MtfCp/CuBOzz062izCPrPw9v4rixUVAxrlAtgaerQpZTskeo2ly4RdIvQF8umyuJRwDr
         KPCw==
X-Gm-Message-State: ACrzQf1tHyt2RWNXdJFIKPyqVaOG0OQag8dM8yU6zkn60Gh2jlZbBBcK
        O+/7AuyzrlXTVkuyp89AAtX+/AxU9aR2LGM3gwYMqsyyL2TbhqvZDz//w+SZmON66UPi5OKzVXh
        2ayR3LF6aiCt5jpTwlZijPQ==
X-Received: by 2002:a17:906:dc95:b0:783:4e1:d5c4 with SMTP id cs21-20020a170906dc9500b0078304e1d5c4mr17987221ejc.463.1664875412072;
        Tue, 04 Oct 2022 02:23:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5GLvoDuHFBEo/dP32IJfUH5qhbXdE26CI2t+joFDXpW81qaei/lu7eRC4tqIhV84OHEqXlaQ==
X-Received: by 2002:a17:906:dc95:b0:783:4e1:d5c4 with SMTP id cs21-20020a170906dc9500b0078304e1d5c4mr17987210ejc.463.1664875411882;
        Tue, 04 Oct 2022 02:23:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id hp20-20020a1709073e1400b0072b33e91f96sm1070787ejc.190.2022.10.04.02.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:23:31 -0700 (PDT)
Message-ID: <9c3a138d-24c4-1bd1-0ec9-489302470f2f@redhat.com>
Date:   Tue, 4 Oct 2022 11:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC v3 4/4] ACPI: EC: fix ECDT probe ordering issues
Content-Language: en-US, nl
To:     Andy Shevchenko <andy@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, kai.heng.feng@canonical.com,
        =?UTF-8?Q?Johannes_Pen=c3=9fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
References: <20221003144214.345279-1-hdegoede@redhat.com>
 <20221003144214.345279-5-hdegoede@redhat.com>
 <YzvtwCTShC/yYovH@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YzvtwCTShC/yYovH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/4/22 10:24, Andy Shevchenko wrote:
> On Mon, Oct 03, 2022 at 04:42:14PM +0200, Hans de Goede wrote:
>> ACPI-2.0 says that the EC OpRegion handler must be available immediately
>> (like the standard default OpRegion handlers):
>>
>> Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
> 
> (Side note: As of today the revision 6.5 of the ACPI specification is
>  available)
> 
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
> 
> ...
> 
>> +	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>> +		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
> 
>> +		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
> 
> Just to be sure: do you need atomic operation here? Does it prevent of any
> kind of races? Because if it had been the case, it would have been done via
> test_and_set_bit() rather than testing and setting separated.

AFAIK we do not need atomic operations here (I did not verify this). Also note
that existing code a couple of lines above already uses the same pattern.

Regards,

Hans

