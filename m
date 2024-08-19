Return-Path: <linux-acpi+bounces-7645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E09562B6
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 06:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD07E1F221E5
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 04:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69812C52E;
	Mon, 19 Aug 2024 04:50:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98855464A;
	Mon, 19 Aug 2024 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724043014; cv=none; b=ULqyyMaRuzf27BdqiszPJjk6kTDBRw06ApWdmwKUlSqA7bFhUwEhy4bXEnPexXo6V45EUp98k+MmXZzjG630KzqEp7R5dVhrpNbD44DNOflJ5TUm6TKQdSX/24TH1Fxb5va/+/mUJZ8X/6VyKfZRYwB4CY9NxiurlO32BU4FmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724043014; c=relaxed/simple;
	bh=++occDpV7vCDuFgKgggiO9Vj7GY6Ljf0yBlohpGLT3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKJ3QBEhaEYsLoW5m+VAY4t8BUBrHgsece/vVC/TOymNne/MPqz/6uq+5L3L6AEWUB3XaiwrfIZ2ek0Mi+9C/cjH91z78pA5Ba/enae0CeWHNITTnLFQGYIaG52x6g7L8/IRESDoMvaBddeY6GDi1ytWxRh0nU6JgHnivuucET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42809d6e719so32327355e9.3;
        Sun, 18 Aug 2024 21:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724043011; x=1724647811;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYxzJL/zYTS0RTltuHgT27JKtVxek25BUeqgw0i3KSQ=;
        b=ARpUQD34cxK4BgC7Hs4NikYaiFpcoC7culOuRruPP5pZXM/4x95qu1UGdZKsr3SEoh
         EK5uyAbBwRlBwQvzy73G22QiSr9XDvo9C8EwtCes+kXM0qkSX6m/1HHJW/r4QhDwK+Hy
         8pWFxHphyK4uSqwuHLFB7yzg+quiw0Z5TvVvzmUh604XfigB6hDeRypgxsrVAptZGiNv
         Av9OQaQFx7iR1xXidz/hP69TeAPhjGMeUquDCjqFjanYzxxagicSHKJ+uoCVyyTz52zP
         B2OjP3y8zbVFJEBOPNCCEoPBqY9ReNmVkpukb+W2zcYL0MOvzvYcMHOyjzz3sV/LDnqn
         EVgg==
X-Forwarded-Encrypted: i=1; AJvYcCV2MslANj8lvFEosBHegYb+elHkBXq5Mz6Mv9qdHKBjdjj1h34SmYGxNM2hsDizF+IdaQBsXDlOdEx9XyM2@vger.kernel.org, AJvYcCVQGvY2LIUxFufW0inoQ0ZliEmLNAQdguOz37ZwSn0sVycK4rCXhd/kTuOQjJh+jOx+GuTFHUB5gA72@vger.kernel.org
X-Gm-Message-State: AOJu0YzLHmIzK9ECWkoP3GgnV7/RVy3ENKm/x559IWXZaSEaDIhfkBiR
	sYE1FDkdw34F3o0vFpNvwWqof2m4R3oEwI0Bto2jaavcK+eyIG+9
X-Google-Smtp-Source: AGHT+IHslvwh9znIKAar3W1Y8q9MvL6x5u8S2m9JgW1IO2Uc71quggEmdnRI3eXHNOpeR4ID64WvnA==
X-Received: by 2002:a05:600c:a43:b0:426:6696:9e50 with SMTP id 5b1f17b1804b1-42aa8241587mr42641595e9.14.1724043010534;
        Sun, 18 Aug 2024 21:50:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896d74sm9331502f8f.68.2024.08.18.21.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 21:50:10 -0700 (PDT)
Message-ID: <95ef6fd9-6d86-40e2-9814-d1f671b2262d@kernel.org>
Date: Mon, 19 Aug 2024 06:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
To: Petr Valenta <petr@jevklidu.cz>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com
References: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org>
 <bd149809-f670-4b5d-a18a-f1f63624265f@kernel.org>
 <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
 <6eac5c37-a5a8-4ccf-aef6-62a4a0bfcea0@jevklidu.cz>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <6eac5c37-a5a8-4ccf-aef6-62a4a0bfcea0@jevklidu.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CC e1000e guys + Jesse (due to 75a3f93b5383) + Bjorn (due to b2c289415b2b)

On 17. 08. 24, 19:57, Petr Valenta wrote:
> 
> 
> Dne 16. 08. 24 v 20:29 Rafael J. Wysocki napsal(a):
>> On Wed, Aug 14, 2024 at 8:48 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>>
>>> On 14. 08. 24, 7:22, Jiri Slaby wrote:
>>>> Hi,
>>>>
>>>> one openSUSE's user reported that with 6.10, he sees one CPU under an
>>>> IRQ storm from ACPI (sci_interrupt):
>>>>      9:   20220768          ...  IR-IO-APIC    9-fasteoi   acpi
>>>>
>>>> At:
>>>> https://bugzilla.suse.com/show_bug.cgi?id=1229085
>>>>
>>>> 6.9 was OK.
>>>>
>>>> With acpi.debug_level=0x08000000 acpi.debug_layer=0xffffffff, there 
>>>> is a
>>>> repeated load of:
>>>>> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6D:
>>>>> Status=20, Enable=00, RunEnable=4A, WakeEnable=00
>>>
>>> 0x6d seems to count excessively (10 snapshots every 1 second):
>>>> /sys/firmware/acpi/interrupts/gpe6D:   82066  EN STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:   86536  EN STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:   90990     STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:   95468  EN STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:  100282  EN STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:  105187     STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:  110014     STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:  114852     STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:  119682     STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:  124194     STS enabled      
>>>> unmasked
>>>> /sys/firmware/acpi/interrupts/gpe6D:  128641  EN STS enabled      
>>>> unmasked
>>>
>>> acpidump:
>>> https://bugzilla.suse.com/attachment.cgi?id=876677
>>>
>>> DSDT:
>>> https://bugzilla.suse.com/attachment.cgi?id=876678
>>>
>>>> Any ideas?
>>
>> GPE 6D is listed in _PRW for some devices, so maybe one of them
>> continues to trigger wakeup events?
>>
> 
> Disabling powertop service (which calls /usr/sbin/powertop --auto-tune) 
> solves problem completely. After some search I have found this is the 
> cause:
> 
> # causes IRQ storm on 6.10.x
> # kernel 6.9.9 is immune
> echo 'auto' > /sys/bus/pci/devices/0000:00:1f.6/power/control

$ git log --no-merges  --oneline v6.9..v6.10 
drivers/net/ethernet/intel/e1000e/
76a0a3f9cc2f e1000e: fix force smbus during suspend flow
c93a6f62cb1b e1000e: Fix S0ix residency on corporate systems
bfd546a552e1 e1000e: move force SMBUS near the end of enable_ulp function
6918107e2540 net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates
1eb2cded45b3 net: annotate writes on dev->mtu from ndo_change_mtu()
b2c289415b2b e1000e: Remove redundant runtime resume for ethtool_ops
75a3f93b5383 net: intel: implement modern PM ops declarations

The last two play with PM ^^. I cannot immediately see if the issue can 
be caused by any of those, though.

If there are no ideas, possibly giving revert of both a try?

> lspci | grep 1f.6
> 00:1f.6 Ethernet controller: Intel Corporation Device 550b (rev 20)
> 
> journalctl -b | grep 1f.6
> srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: [8086:550b] type 00 class 
> 0x020000 conventional PCI endpoint
> srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: BAR 0 [mem 
> 0x9c300000-0x9c31ffff]
> srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: PME# supported from D0 
> D3hot D3cold
> srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: Adding to iommu group 12
> srp 17 19:44:19 e14 kernel: e1000e 0000:00:1f.6: Interrupt Throttling 
> Rate (ints/sec) set to dynamic conservative mode
> srp 17 19:44:19 e14 kernel: e1000e 0000:00:1f.6 0000:00:1f.6 
> (uninitialized): registered PHC clock
> srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 eth0: (PCI 
> Express:2.5GT/s:Width x1) fc:5c:ee:b0:13:74
> srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 
> Network Connection
> srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 eth0: MAC: 16, PHY: 12, 
> PBA No: FFFFFF-0FF
> srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 enp0s31f6: renamed from 
> eth0
> srp 17 19:44:24 e14 ModemManager[1434]: <info>  [base-manager] couldn't 
> check support for device '/sys/devices/pci0000:00/0000:00:1f.6': not 
> supported by any plugin
> 
> 
> 
>> You can ask the reporter to mask that GPE via "echo mask >
>> /sys/firmware/acpi/interrupts/gpe6D" and see if the storm goes away
>> then.
>>
>> The only ACPI core issue introduced between 6.9 and 6.10 I'm aware of
>> is the one addressed by this series
>>
>> https://lore.kernel.org/linux-acpi/22385894.EfDdHjke4D@rjwysocki.net/
>>
>> but this is about the EC and the problem here doesn't appear to be
>> EC-related.  It may be worth trying anyway, though.
>>

-- 
js
suse labs


