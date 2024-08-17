Return-Path: <linux-acpi+bounces-7638-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6E955938
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Aug 2024 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410DF1F21B7A
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Aug 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0231E154BEC;
	Sat, 17 Aug 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b="W1UaxZjz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C54C133;
	Sat, 17 Aug 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723917464; cv=pass; b=mPbcauIDqtrE3pzLft/Qth3LCE5OwWnVya1Rg7/7aXUwOnGeJzn/76vU/b0nITi40pueKJ9xRbRYL0YipKara+njToOmyuOnpqZkoLPkQ9fPr2ftvMCZBNDfn1rvzefGFJ1HYA8mp1Scs6O2MVeIKQWjfJWIpQpmAbv5r4ij6nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723917464; c=relaxed/simple;
	bh=ofA6MwBB9myYSOX62CFyfawqJEj8oehsD1BG4ehoB18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REb3aB9LjpWmqJbtBwZq3aVDX0JD+KljV9jOCJv8ML87MnYKxkr3HjlFpgZ0RI9ec2IEWlSJ2BVNTysxZ+K48M1ZcV+Dx8W+epjTB64VL6FC+11q/obJUpThC74itXw1cc2hjGKwhVAcdFYV9FMDK4blzSrvmK+xszilj6icqTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz; spf=pass smtp.mailfrom=jevklidu.cz; dkim=pass (1024-bit key) header.d=jevklidu.cz header.i=petr@jevklidu.cz header.b=W1UaxZjz; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jevklidu.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jevklidu.cz
ARC-Seal: i=1; a=rsa-sha256; t=1723917451; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fjjt0jYToWMT9OoGJmKva7yfjhbiNkBiriB8tWAH8Un5iuKT4OqgS2UkchG0h6gMzEDeaRV9bwawq/LVEfXUEn6J8rENVf6ZEuojvsXKfPW/FQyTp/OAA6i4nlpl1CzVOcIpJnx5eIEiX0uUukLe2FDkkYKyY2BZzbGvDMVObL0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723917451; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V227+9OZSU+cAq7GWLgJgCLEHnyka3YBMISfs8NB9lU=; 
	b=foyAm2g4DguzyHVxz5SjZBbYX7IXFlqliGwwspri5tMEorhu83F9AVki05OcX+4OceXRq4zmeTynxO2pf66CWec6y1w7lpQ7TzCbwea71Yt5r9hFmHqpz5BzZJDZrzqvy4lKmNa6x3Go9Jc89bKS4OeMNUzOAPiLwe+eEYhNfB4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=jevklidu.cz;
	spf=pass  smtp.mailfrom=petr@jevklidu.cz;
	dmarc=pass header.from=<petr@jevklidu.cz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723917451;
	s=zoho; d=jevklidu.cz; i=petr@jevklidu.cz;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V227+9OZSU+cAq7GWLgJgCLEHnyka3YBMISfs8NB9lU=;
	b=W1UaxZjzAkJ4PNRu58CEyvRjXGPY7tsjoAmCl/nU7iJkZ4GsV/BN4n1SBZtoEgIb
	7KhI/ry6fWeHEIpumeXAfgqM5EBiwHQyl6GOLa8fpZSuVZEWYs3QOIvu7GLAyS65Gtn
	t7hNDh6/1awZUWNFlm3fE0YyWXIu+ZUjvZKRQ3Yw=
Received: by mx.zohomail.com with SMTPS id 172391745003275.63577164506398;
	Sat, 17 Aug 2024 10:57:30 -0700 (PDT)
Message-ID: <6eac5c37-a5a8-4ccf-aef6-62a4a0bfcea0@jevklidu.cz>
Date: Sat, 17 Aug 2024 19:57:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI IRQ storm with 6.10
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org>
 <bd149809-f670-4b5d-a18a-f1f63624265f@kernel.org>
 <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
Content-Language: cs-CZ, en-US
From: Petr Valenta <petr@jevklidu.cz>
In-Reply-To: <CAJZ5v0jrgC+cvjDfw+vQ1jyVz1oj28uTf9k+-Kk2EAPJj3VmdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



Dne 16. 08. 24 v 20:29 Rafael J. Wysocki napsal(a):
> On Wed, Aug 14, 2024 at 8:48 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> On 14. 08. 24, 7:22, Jiri Slaby wrote:
>>> Hi,
>>>
>>> one openSUSE's user reported that with 6.10, he sees one CPU under an
>>> IRQ storm from ACPI (sci_interrupt):
>>>      9:   20220768          ...  IR-IO-APIC    9-fasteoi   acpi
>>>
>>> At:
>>> https://bugzilla.suse.com/show_bug.cgi?id=1229085
>>>
>>> 6.9 was OK.
>>>
>>> With acpi.debug_level=0x08000000 acpi.debug_layer=0xffffffff, there is a
>>> repeated load of:
>>>> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6D:
>>>> Status=20, Enable=00, RunEnable=4A, WakeEnable=00
>>
>> 0x6d seems to count excessively (10 snapshots every 1 second):
>>> /sys/firmware/acpi/interrupts/gpe6D:   82066  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:   86536  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:   90990     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:   95468  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  100282  EN STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  105187     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  110014     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  114852     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  119682     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  124194     STS enabled      unmasked
>>> /sys/firmware/acpi/interrupts/gpe6D:  128641  EN STS enabled      unmasked
>>
>> acpidump:
>> https://bugzilla.suse.com/attachment.cgi?id=876677
>>
>> DSDT:
>> https://bugzilla.suse.com/attachment.cgi?id=876678
>>
>>> Any ideas?
> 
> GPE 6D is listed in _PRW for some devices, so maybe one of them
> continues to trigger wakeup events?
> 

Disabling powertop service (which calls /usr/sbin/powertop --auto-tune) 
solves problem completely. After some search I have found this is the cause:

# causes IRQ storm on 6.10.x
# kernel 6.9.9 is immune
echo 'auto' > /sys/bus/pci/devices/0000:00:1f.6/power/control

lspci | grep 1f.6
00:1f.6 Ethernet controller: Intel Corporation Device 550b (rev 20)

journalctl -b | grep 1f.6
srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: [8086:550b] type 00 class 
0x020000 conventional PCI endpoint
srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: BAR 0 [mem 
0x9c300000-0x9c31ffff]
srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: PME# supported from D0 
D3hot D3cold
srp 17 19:44:17 e14 kernel: pci 0000:00:1f.6: Adding to iommu group 12
srp 17 19:44:19 e14 kernel: e1000e 0000:00:1f.6: Interrupt Throttling 
Rate (ints/sec) set to dynamic conservative mode
srp 17 19:44:19 e14 kernel: e1000e 0000:00:1f.6 0000:00:1f.6 
(uninitialized): registered PHC clock
srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 eth0: (PCI 
Express:2.5GT/s:Width x1) fc:5c:ee:b0:13:74
srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 
Network Connection
srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 eth0: MAC: 16, PHY: 12, 
PBA No: FFFFFF-0FF
srp 17 19:44:20 e14 kernel: e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
srp 17 19:44:24 e14 ModemManager[1434]: <info>  [base-manager] couldn't 
check support for device '/sys/devices/pci0000:00/0000:00:1f.6': not 
supported by any plugin



> You can ask the reporter to mask that GPE via "echo mask >
> /sys/firmware/acpi/interrupts/gpe6D" and see if the storm goes away
> then.
> 
> The only ACPI core issue introduced between 6.9 and 6.10 I'm aware of
> is the one addressed by this series
> 
> https://lore.kernel.org/linux-acpi/22385894.EfDdHjke4D@rjwysocki.net/
> 
> but this is about the EC and the problem here doesn't appear to be
> EC-related.  It may be worth trying anyway, though.
> 

