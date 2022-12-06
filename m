Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C472E644C7F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 20:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLFT1W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 14:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiLFT1U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 14:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898F18B24
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670354786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dr9eadMAbHe85PAKzK4dCl/lg7DFQYZXZiHsTAGln3s=;
        b=U4al7hxNuL9Aazss66dXNyYk1UbN3mZEi9lsrtgTstHefu9X0EbqagECLduWIPEhxKIRZB
        EU5re5YfWpJmqKF1TC8wjM5fgLicbM9esHqz8Vhmt5m140M38hUaHdL8i5onnsqe3X/PaC
        MSFmnaNyxC4gv1iwxHYPOHKgEMbNXyY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-X4bs_x5pMk-Fq2RWXwMJFA-1; Tue, 06 Dec 2022 14:26:24 -0500
X-MC-Unique: X4bs_x5pMk-Fq2RWXwMJFA-1
Received: by mail-ej1-f70.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso2060113ejb.14
        for <linux-acpi@vger.kernel.org>; Tue, 06 Dec 2022 11:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dr9eadMAbHe85PAKzK4dCl/lg7DFQYZXZiHsTAGln3s=;
        b=6P85bE1KHPxyiG5s12QI39+Lymadms6h4BA9Bb9R4tucpzrtiQOcSnT0evyuMY/EqU
         FEorcJEPk3kQYQKWxlt/66cjCdXEVX5OCBcAfFQqYMPYgqOVdR/rhCIODNwwGC+i+a4j
         RHLaxaKl8CkpZsIm1zGaMlYrbZ7ZpNX64dP0HQ9f+mWsRyDCE7yqyldmzTOTHcvnImgN
         Eul032hN6gZgBNd8Z7FCmpOXdohlboWJXKCMihRpM0z2yCFa8xUbsG8svrw05Xckgv2h
         GqGRdKzUhk0aNQ6LvoCSBtiRqL+6pTfZICbWDSY7+SCV8JO86e5+iWqanfB/GPzqVsyZ
         0qOg==
X-Gm-Message-State: ANoB5plkfgf8HNe82nzUtQzgrv0b6rneP8k85DDc3LfvZrZH+UDZKoN0
        zuT4X/NsA7+CDimirCpEwfZvunuL/N7Mx8VCFriYi0YWwtmQqxA5oLdhDYQ509gWk234pInltqa
        xXVgVl+bXexgknZLmJPYuIg==
X-Received: by 2002:aa7:c2cf:0:b0:46d:1c24:e804 with SMTP id m15-20020aa7c2cf000000b0046d1c24e804mr3304315edp.221.1670354783212;
        Tue, 06 Dec 2022 11:26:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ZnYXnvfbGNrTKHhGwrdtvgNBxij/xgDDLq8t20iByjVwRgYRuPK862mYTmRsalvyG5aoJlw==
X-Received: by 2002:aa7:c2cf:0:b0:46d:1c24:e804 with SMTP id m15-20020aa7c2cf000000b0046d1c24e804mr3304302edp.221.1670354783046;
        Tue, 06 Dec 2022 11:26:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007ba46867e6asm7781934ejc.16.2022.12.06.11.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 11:26:22 -0800 (PST)
Message-ID: <9bc9cd5f-cfbe-f997-bd97-2ec874853d93@redhat.com>
Date:   Tue, 6 Dec 2022 20:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] x86/PCI: Disable E820 reserved region clipping for Clevo
 NL4XLU laptops
Content-Language: en-US, nl
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxkernelml@undead.fr,
        Florent DELAHAYE <kernelorg@undead.fr>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
References: <20221206172604.GA1356368@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221206172604.GA1356368@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bjorn,

On 12/6/22 18:26, Bjorn Helgaas wrote:
> On Sun, Dec 04, 2022 at 10:42:38AM +0100, Hans de Goede wrote:
>> On 12/2/22 22:58, Bjorn Helgaas wrote:
>>> On Wed, Oct 12, 2022 at 10:23:12AM +0200, Hans de Goede wrote:
>>>> On 10/11/22 19:40, Bjorn Helgaas wrote:
>>>>> On Mon, Oct 10, 2022 at 05:02:06PM +0200, Hans de Goede wrote:
>>>>>> Clevo NL4XLU barebones have the same E820 reservation covering
>>>>>> the entire _CRS 32-bit window issue as the Lenovo *IIL* and
>>>>>> Clevo X170KM-G models, relevant dmesg bits (with pci=no_e820):
>>>>>> ...
>>>>>> Add a no_e820 quirk for these models to fix the touchpad not working
>>>>>> (due to Linux being unable to assign a PCI BAR for the i2c-controller).
>> ...
> 
>> As I mentioned in the email-thread about that patch-series (and there
>> now is dmesg E820 output to confirm this) your generic fix will
>> unfortunately only work when people boot in EFI mode. It will still
>> be good to have the generic fix of course.
>>
>> But maybe we should also add this quirk to make sure these
>> Clevo-s also work properly when booted in BIOS CSM mode ?
> 
> Yes, if they can boot in CSM mode, we should probably add the quirk.
> But Florent doesn't see a way to boot his Clevo NL41LU2/NL4XLU in CSM
> mode, so I think we can postpone adding the quirk until we find a
> machine where it makes a difference:

Ack.

>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1948811/comments/8
> 
> I added a note to https://bugzilla.kernel.org/show_bug.cgi?id=216565
> to that effect.

Thank you for also following up on this in bugzilla.

Regards,

Hans
'


> 
>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565
>>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>>> ---
>>>>>>  arch/x86/pci/acpi.c | 13 +++++++++++++
>>>>>>  1 file changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>>>>>> index 2f82480fd430..45ef65d31a40 100644
>>>>>> --- a/arch/x86/pci/acpi.c
>>>>>> +++ b/arch/x86/pci/acpi.c
>>>>>> @@ -189,6 +189,19 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>>>>>>  			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>>>>>>  		},
>>>>>>  	},
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Clevo NL4XLU barebones have the same E820 reservation covering
>>>>>> +	 * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
>>>>>> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216565
>>>>>> +	 */
>>>>>> +	{
>>>>>> +		.callback = set_no_e820,
>>>>>> +		.ident = "Clevo NL4XLU Barebone",
>>>>>> +		.matches = {
>>>>>> +			DMI_MATCH(DMI_BOARD_NAME, "NL4XLU"),
>>>>>> +		},
>>>>>> +	},
>>>>>>  	{}
>>>>>>  };
> 

