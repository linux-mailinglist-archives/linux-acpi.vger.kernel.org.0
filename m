Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33964CC46F
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 18:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiCCR5R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 12:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCR5Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 12:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FA171405C6
        for <linux-acpi@vger.kernel.org>; Thu,  3 Mar 2022 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646330190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pt2NEyN77WvQVDGkaIF/Nqcc+6j6rTEVnHq5++rUv8c=;
        b=hePrSxXIsaJ11sjw3iCcI5MxoDZeadaGs2l09Bfkc6NpBPDbXVG7o0XSXaoZJZ4BXLNoot
        wQxtcKAmQdzdDy4FMuxSG9NYrNtn6hlQFr98UxyupoeR0QMHaVnXx1f5KOzVmRVngm7k6z
        Fkyy0RAKJqwQLM066jMlIg7sr/LN/WA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-0pMO7BNsOlu245HRAEP9Xg-1; Thu, 03 Mar 2022 12:56:29 -0500
X-MC-Unique: 0pMO7BNsOlu245HRAEP9Xg-1
Received: by mail-ej1-f72.google.com with SMTP id y5-20020a1709060a8500b006da9258a34cso1371365ejf.21
        for <linux-acpi@vger.kernel.org>; Thu, 03 Mar 2022 09:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pt2NEyN77WvQVDGkaIF/Nqcc+6j6rTEVnHq5++rUv8c=;
        b=mp0y7p5QDxjWV+SCl16ZM2mGGxYk7D2ftoeLg0vOKLgYnrtbMEYlVrRyQ6Jjgqmea9
         DobKmea4yn8r7DxUBP4CT3Qr6/oJ7mwCNE4mXSQ+GsacO4UejDVkb/bpHv9Aoi1Iugm3
         eA4kyM5WU7IsQjO5XHeDAJTXs1pWos7yqtmUrISRneyA8jMFC0nL72iwMyZJDl9bf+rc
         PmwV7iIxIWarUo5pplk4HxtJ+8umk4/nv3ZTk1ptdCKVydgYUG8kFhZ+codmWrihDY9p
         12u1dzt83Q/doFEzbUdzvFPdV9ovnsvmuBxcMNxnMLpiFQhwmeFbKaY8GBvSfrqVWt8Y
         gX4A==
X-Gm-Message-State: AOAM532h/QiVWG6jBD2idopalr1nslxs+xI7nnafGp4anGG+YTeTWo4A
        +xK4YX3w0H8KTUASor4A27968Op/DBEIJ+7IUvSUrX8h+H+UpqonO6Vgvczav5VKSrQcdczD9bC
        ZnawwLg6G9HcjNu1RvV66vQ==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr35543554eda.203.1646330187926;
        Thu, 03 Mar 2022 09:56:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPRtKLOiKu9tA7Gy98mghBFK0zV7El+3s6ksl1od7pWlMdP3fg7CriUUTbr2yPPhb7rsU+gg==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr35543539eda.203.1646330187754;
        Thu, 03 Mar 2022 09:56:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id lk10-20020a170906cb0a00b006da92317793sm825104ejb.131.2022.03.03.09.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 09:56:27 -0800 (PST)
Message-ID: <535336dc-8c54-7c3a-ecf6-b2920ea99297@redhat.com>
Date:   Thu, 3 Mar 2022 18:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
References: <20220302040800.10355-1-mark@yotsuba.nl>
 <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
 <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
 <43b0c275-e728-492b-c6a7-d054fae72117@redhat.com>
 <4BBB58DC-653C-4373-A5F5-9239C86C8AE8@yotsuba.nl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4BBB58DC-653C-4373-A5F5-9239C86C8AE8@yotsuba.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/3/22 14:42, Mark Cilissen wrote:
> 
>> On 3 Mar 4 Reiwa, at 14:38, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Mark,
> 
> Hi Hans,
> 
>> On 3/2/22 21:20, Mark Cilissen wrote:
>>>>
>>
>> I think that there are a lot more boards that will have
>> DMI_BIOS_VENDOR == "Phoenix Technologies LTD"
>> then that there are boards that will have
>> DMI_PRODUCT_NAME == "Bearlake CRB Board"
>>
>> So if you want to make the DMI match as specific as possible then
>> IMHO dropping the bios-vendor match is best.
> 
> Of course, but just to clarify -- my proposal above is to drop
> 
>> DMI_MATCH(DMI_SYS_VENDOR, "NEC”),
> 
> not
> 
>> DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board”),
> 
> . :-)

Ah I see, I did indeed misunderstand that. Still NEC is not that
often seen as sys-vendor, so I still believe dropping the bios-vendor
match is best.

Regards,

Hans

