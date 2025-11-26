Return-Path: <linux-acpi+bounces-19278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9CAC89DFD
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 13:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64300351637
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18383328B40;
	Wed, 26 Nov 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv2V+2JO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81A3203A1;
	Wed, 26 Nov 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161737; cv=none; b=i6eAb0kF1ZRiOrLkzLtrFVsR3FQ3zy4Z2/1fdOzs0/4ggIwMt2ujG+0VLtXHFQ8NLVfntMu8qkrhVsvZdT4y7lQO/fKyI6pgvIxjwmxk77A2YxdoJxB5kWNxR7D2ZJnkxQWv/Q+1uN99MCxKG4CPBM/73QoqmXU6p+ISPi3/Oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161737; c=relaxed/simple;
	bh=UQj9CJJfFE0vgN4ANycjBBZEHoUeZXry4mman+OU4zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uxnrmcyqprn2CXzlCZ0A1cORWTOEUuwfI4wlUyTrRJCcpPGtkEogFHPMOdvmQzVHFrUNLagitu+fEdeyEYs9xCfgwjIgDdEYWoIYZPBL9nf8oFavG2STgWVuHMJlEBGU6LDnIdazsViD1xX/Xd6YHYs2BR2KgEkIRWuvSxXw1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv2V+2JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B15C113D0;
	Wed, 26 Nov 2025 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764161736;
	bh=UQj9CJJfFE0vgN4ANycjBBZEHoUeZXry4mman+OU4zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bv2V+2JO3jULXQyZ3B5j8/DMhUnZE2IVdN9f7x/fRYx8UkOT45mCIzFWLv2nQ6t+f
	 eh09vl15/NNhW6Kl06lMV5RepC7k7+T3cU/bibNsc7BHbVwdms+fcLi66k3jbUAa+E
	 w5kSioBH/em6LuODzXTrjoFSte2N3P/vn2JkHLYiUDgL+FdFKB4awZT/Pyr5AtFiN9
	 CrBBCySQ2yDBfXnbJ/sco4eSGNFcFEdElQ94iob+n2hiTVI/DcZT799OMUWV5a1gYi
	 sxLugmBuAh5pQuCdxCzJXbeaY6urxTq2whwA7hcPT1MaowDhWQVubC2ezUjL+g7nEh
	 nkJe8NsI1h7UA==
Message-ID: <92de74fb-fc75-4260-bb1d-2d6dd522183f@kernel.org>
Date: Wed, 26 Nov 2025 06:55:32 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ACPI: button: Cancel hibernation if button is pressed
 during hibernation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, kernel@collabora.com,
 Askar Safin <safinaskar@gmail.com>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-3-usama.anjum@collabora.com>
 <2025112433-emphasize-helpful-b748@gregkh>
 <e1e97842-0ad3-4270-b0d1-3cc7150988cd@collabora.com>
 <2025112506-acting-tipoff-3a49@gregkh>
 <cef1d96b-b642-4e69-8c1b-2e0bf7528edf@collabora.com>
 <2025112612-backup-driving-e6e6@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2025112612-backup-driving-e6e6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> First I need a board/machine with serial console access to view all logs in real
>> time. :)
> 
> usb debug cables might be your solution.
> 
Just a word of warning before you go too far down this path to get a 
console working from XHCI debug.

This is probably a Hal changing a light bulb problem [1]. Last time I 
tried XHCI debug cables on some modern AMD systems I ran into a problem 
that the BAR is too big for early_ioremap().  Looking through LKML it's 
come up a few times in the past too [2] [3].

Link: https://youtu.be/5W4NFcamRhM?si=qOFrCTzvK6-H-4AX [1]
Link: https://lore.kernel.org/linux-usb/ZCOq3PUBCtHkwdnw@mail-itl/ [2]
Link: 
https://lore.kernel.org/linux-usb/CAAcb1K_bezseTM8DrOrzVUi_W+nZoE2N0CO4k3AQWPw7=7pyjw@mail.gmail.com/ 
[3]

The other obvious idea is to use netconsole, but you need a PCIe 
Ethernet controller, but I think you'll have more success in development 
using KVM as these are generic architectural problems.

To help you get started with this I may point out something that was 
shared to me for another hibernate bug [4].

Link: 
https://lore.kernel.org/linux-pm/20251105180506.137448-1-safinaskar@gmail.com/ 
[4]

Askar Safin (CC'ed) produced a script that does a very minimal kernel 
build, sets up a VM with the right sizes of disks/swap/etc.  It's 
trivial to make kernel changes and re-run the script, and you can  also 
attach a debugger to the KVM instance.  Maybe you can adapt something 
like that.  You can wrap it with 'time' calls to actually measure 
performance for any ideas and prove them out too.

