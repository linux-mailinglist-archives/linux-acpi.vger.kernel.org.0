Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6347641C20
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Dec 2022 10:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLDJno (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 4 Dec 2022 04:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiLDJnn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Dec 2022 04:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE66DEC3
        for <linux-acpi@vger.kernel.org>; Sun,  4 Dec 2022 01:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670146963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piQkUfzaHmSmHoe4DeU+9nHzn0CraXgaqwIYK3vO91c=;
        b=dwf5aFqVBET20Zmh2E+zG+wtC0xxz2WSLwh4xwbQoqm1/WM0Eneherk/4mcRA7fmJDUUVJ
        xjVWIPcy9bN9xO9H7M1wUz/ypa+WJEltQitH4509ZfUqJuDGhRjGrZRRwQImqEoh4btxuQ
        OFz5HkiZkGEMfBTWZ5dNUUiNMZhbICU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-FqGz6lZ8N6q2wC1gAF83-Q-1; Sun, 04 Dec 2022 04:42:42 -0500
X-MC-Unique: FqGz6lZ8N6q2wC1gAF83-Q-1
Received: by mail-ej1-f70.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso6135673ejc.4
        for <linux-acpi@vger.kernel.org>; Sun, 04 Dec 2022 01:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piQkUfzaHmSmHoe4DeU+9nHzn0CraXgaqwIYK3vO91c=;
        b=ey3KgROGDOUS0EjLv1D64TlaOjDkVtNs7z3Upd4Hmo/uTDh8kKkYvlEcOCpyVKxRIe
         kBPGBNl5B/A/ZVaEcGjrvin0Ed3b2SQ+HxH5tRlsu64Oyc8oplP5wHKsJW4RhhheHfP5
         a5PfxviLbpst0c9n4m83eiHCMZ6ft3RXFaFaOAAmAb9r4HktU7SAyHnvwIO12LTiGDaF
         +S7jyL/fnLeEIxevJ8OTO9KLEBo/rxF140FfArs5kzGRGjx+N8UGnp2PrZwHIvGo3IgA
         iLxlGpfR2dXJ1ayoSLxfZzKRjcYFkalfZDZS0tJS5bafe4xKahO2u/yH8GNmoO6SKUCm
         txmA==
X-Gm-Message-State: ANoB5plpT8C48VcGVY1s0SUELaPHKFz1YtIqEgsbKbwvGTVFjAN5Lj6D
        KJ+17ZjQVbPbo7O4dMbVXJ/8lpFihf8XxBlvmpKwWbrC1dd5QFNkgTWd5WHub9Y+vdAmF6+g0Lx
        nHNSJ0FpYqbfC1qtDatPepg==
X-Received: by 2002:aa7:c557:0:b0:46b:1704:324a with SMTP id s23-20020aa7c557000000b0046b1704324amr28447468edr.184.1670146960341;
        Sun, 04 Dec 2022 01:42:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lFnx9TCVwhqNL+bL+IUuJW92DAnLgN/YEsumyBubr9bGz5eWgQjL2FAjTyh9soep/vKpzig==
X-Received: by 2002:aa7:c557:0:b0:46b:1704:324a with SMTP id s23-20020aa7c557000000b0046b1704324amr28447455edr.184.1670146960090;
        Sun, 04 Dec 2022 01:42:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b007c0985aa6b0sm5003495ejg.191.2022.12.04.01.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 01:42:39 -0800 (PST)
Message-ID: <9faa7393-a985-52f6-4ceb-f853c0210a71@redhat.com>
Date:   Sun, 4 Dec 2022 10:42:38 +0100
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
References: <20221202215811.GA1063109@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221202215811.GA1063109@bhelgaas>
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

On 12/2/22 22:58, Bjorn Helgaas wrote:
> On Wed, Oct 12, 2022 at 10:23:12AM +0200, Hans de Goede wrote:
>> On 10/11/22 19:40, Bjorn Helgaas wrote:
>>> On Mon, Oct 10, 2022 at 05:02:06PM +0200, Hans de Goede wrote:
>>>> Clevo NL4XLU barebones have the same E820 reservation covering
>>>> the entire _CRS 32-bit window issue as the Lenovo *IIL* and
>>>> Clevo X170KM-G models, relevant dmesg bits (with pci=no_e820):
>>>> ...
>>>> Add a no_e820 quirk for these models to fix the touchpad not working
>>>> (due to Linux being unable to assign a PCI BAR for the i2c-controller).
>>>
>>> I do plan to apply this, but a little food for thought below.
>>>
>>> I explored this issue a little bit with the ACPI/UEFI folks (see
>>> https://members.uefi.org/wg/aswg/mail/thread/9265 if you have access).  
>>>
>>> One aspect I had glossed over earlier is that on most recent machines,
>>> the "E820 map" Linux uses is actually constructed internally by Linux
>>> based on the UEFI memory map, and that construction conflates several
>>> EFI types into E820_TYPE_RESERVED; see
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/libstub/x86-stub.c?id=v5.19#n576
> 
> Critical error on my part here: the E820 map is passed to Linux by the
> bootloader or the EFI stub, NOT constructed by Linux.
> 
>>> From a response in the ACPI/UEFI discussion:
>>>
>>>   The reason EfiMemoryMappedIO[1] exist in the UEFI memory map is to
>>>   request a virtual mapping for UEFI Runtime Services.
>>>   ...
>>>   Thus the EfiMemoryMappedIO entries just exist to pass up the
>>>   EFI_MEMORY_RUNTIME attribute in the UEFI Memory Map. This is the part
>>>   of the contract for UEFI Runtime Service to use virtual mappings
>>>   provided by the OS. So from an OS point of view EfiMemoryMappedIO has
>>>   no other purpose.
>>>   
>>>   [1] UEFI: Table 7-5 Memory Type Usage before ExitBootServices() "Used
>>>   by system firmware to request that a memory-mapped IO region be
>>>   mapped by the OS to a virtual address so it can be accessed by EFI
>>>   runtime services."
> 
>>> I'm a little leery of changing that UEFI->E820 conversion because of
>>> other possible implications, but it may be that omitting
>>> EfiMemoryMappedIO entries from the E820 map and keeping the original
>>> "avoid E820 regions" (4dc2287c1805) would also solve this problem.
>>
>> Actually during my many attempts to fix this I did write a patch
>> adding a new E820_TYPE_MMIO to the generated e820-memmap which
>> would only show up in the EFI -> E820 entry generation case
>> and then used that to not exclude that E820 region, see
>> this RFC series:
>>
>> https://lore.kernel.org/linux-pci/20220214151759.98267-1-hdegoede@redhat.com/
> 
> Yes :)  I tried something similar and of course it didn't work because
> it didn't change the E820 map coming from the bootloader.

Ah that is a good point, which I did not realize when I was working
on this back then.

Note it depends on the bootloader actually, systemd-boot uses
the in-kernel-EFI-stub and Fedora's grub is patched to also use
the in-kernel-EFI-stub.

But your solution should work regardless of the boot path (1), which
is good.

1) As long as some form of EFI booting is used.

> 
>> I also did another series which used the EfiMemoryMappedIO type as
>> an input to heuristics to automatically set pci=no_e820, see:
>>
>> https://lore.kernel.org/linux-pci/20220228105259.230903-1-hdegoede@redhat.com/
>>
>> IIRC that patch eventually got replaced by a similar but simpler
>> heuristic from you. Which IIRC eventually got dropped again because
>> it was causing regressions on some models again.
>>
>> So we ended up with the current set pci=no_e820 using DMI based quirks +
>> try to enable it for all BIOS-es with date >= 2023 approach,
>> with the plan to do DMI quirks setting pci=use_e820 if any (buggy)
>> 2023 BIOS-es show up which need this.
> 
> I gave up on figuring out what went wrong in this path.
> 
> Anyway, I've had the patch below in -next for a couple weeks, but I
> plan to drop it and replace it with the series here:
> https://lore.kernel.org/linux-pci/20221202211838.1061278-1-helgaas@kernel.org/

As I mentioned in the email-thread about that patch-series (and there
now is dmesg E820 output to confirm this) your generic fix will
unfortunately only work when people boot in EFI mode. It will still
be good to have the generic fix of course.

But maybe we should also add this quirk to make sure these
Clevo-s also work properly when booted in BIOS CSM mode ?

Regards,

Hans





> 
> Bjorn
> 
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  arch/x86/pci/acpi.c | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>>>> index 2f82480fd430..45ef65d31a40 100644
>>>> --- a/arch/x86/pci/acpi.c
>>>> +++ b/arch/x86/pci/acpi.c
>>>> @@ -189,6 +189,19 @@ static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>>>>  			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>>>>  		},
>>>>  	},
>>>> +
>>>> +	/*
>>>> +	 * Clevo NL4XLU barebones have the same E820 reservation covering
>>>> +	 * the entire _CRS 32-bit window issue as the Lenovo *IIL* models.
>>>> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=216565
>>>> +	 */
>>>> +	{
>>>> +		.callback = set_no_e820,
>>>> +		.ident = "Clevo NL4XLU Barebone",
>>>> +		.matches = {
>>>> +			DMI_MATCH(DMI_BOARD_NAME, "NL4XLU"),
>>>> +		},
>>>> +	},
>>>>  	{}
>>>>  };
>>>>  
>>>> -- 
>>>> 2.37.3
>>>>
>>>
>>
> 

