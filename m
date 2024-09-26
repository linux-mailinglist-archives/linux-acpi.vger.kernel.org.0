Return-Path: <linux-acpi+bounces-8448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BCE987A11
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 22:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6A7B21D6D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D9183CB6;
	Thu, 26 Sep 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XP+12Kja"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413217C9AA
	for <linux-acpi@vger.kernel.org>; Thu, 26 Sep 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727382500; cv=none; b=qixgZ6Jqum9mQ9vAmDuZHucwwBO12sIWNWT3TH3O+fh70DsASkQFxXIusAeBtSVnKqIaK86eeU1ZD1s4Gx92O/Ij/NdbHd3y3STC6UXhEcE2TXZzJvA8hmn2LSx89i8yHATdJYQC0lGtFJk5Yz/Y+BmWmwpVcg2loQi6jCgHdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727382500; c=relaxed/simple;
	bh=5i9PvWSVQ7pmJdAj0JVCH4wfYvmOKbNzNLK7RmykQCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1HrzmdbVJnQJYVGjvrTFzRRxfkBAUOjhHcCFq7YbB0wor9C8ojAMDizf4ct1Vdnm3elMB/q9TOGO1/RMRlzCDA/tDpsc2DoyANTOTLrqelw3zg/yCaIeI4A5wf2fNbcUp0dg/mq/JGgOaLNOpAnbfXmZ3yVKqORw/wq8h/Rj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XP+12Kja; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5389917ef34so1656703e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Sep 2024 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727382492; x=1727987292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BsSpvuOtgm3mX4L6cqlhiDX/t4WAYJef/7qC9Vsyxvc=;
        b=XP+12KjaJWMCvJwvzaDadYlz3s0S9RWV6SUfG20GHXoL6n+2ZLm6z0dSDh24wVVx/R
         OwqXO9L6Khgx+C0EFnhQv5MJkEomtaZ1MA9RzgPv4ZTrsAGEhg/y0dcb6IEba59A3kdt
         YMXBiCeAB0yf4yoAfy2gnuaF3Q4tfTK9t+1Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727382492; x=1727987292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsSpvuOtgm3mX4L6cqlhiDX/t4WAYJef/7qC9Vsyxvc=;
        b=eEBgykbyzCQVItqjW5/rIJPpGpKDDBG6UpK6Y4GQyE4B9p4Du2GONlxh1Jk7G3Q7ry
         hl9aHCeIbRDQiPWmPftkgZZs6dFQ8snDMqZBeS4TM7Zp6A8clmRIduae2n1nxVfvHxlm
         K78a+emt69i1LgfcdnVL3ULqd/64FLkZv6vtfVJdeVoEVE+3ToZYSUFyIWGqgr5R308P
         y8x24Gg+hPxzQHFsyasB21h05DVRcHI5LnXOl/HcJTpSt/Qr08zWVvYUx4vwkE/DzYh4
         LyRtgM3LFH7ZrZCEsCOB94lU5fc2Ge5hBsGJdIiV2OsFDY0S7tsmVYmadoEeUcJVOPAF
         hwNw==
X-Forwarded-Encrypted: i=1; AJvYcCXg/jH81qzplXqzXkTbrvTfeY3tlrX9RThLAymzlW9mpyn1yJw02fpV9IJZ9+TJJthMMIKAFlZCPPIw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1YkdUNMEEf6b/Q4Yr6PfbBPmgIY7jHTn8LPX49oIAfD52aOcv
	9d7Lo1coNlvxGeycHN47FoGj7fHn5zoM0LF9O8WtFBX9GH3RhGrCnWi4jvyCB7YojG54kZbO08h
	ffzNVOw==
X-Google-Smtp-Source: AGHT+IG0hStdfb3XQmtcx3KdPVnGpRlLQPG8x+NyCn/YDz5flD8sDx6thAfL9AtFQ/khyUMLZppo1w==
X-Received: by 2002:a05:6512:12cc:b0:536:a565:cf2b with SMTP id 2adb3069b0e04-5389fc48322mr591646e87.36.1727382492050;
        Thu, 26 Sep 2024 13:28:12 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd539a5sm64129e87.17.2024.09.26.13.28.10
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 13:28:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so1937697e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Sep 2024 13:28:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZXXeWO+3tTJ/FO544vAUilldX7Dsxv7UkAWRrIdBXwztPVxaI7jEoaLOBsfOz2uFcX5DIxW//Bcqy@vger.kernel.org
X-Received: by 2002:a05:6512:1383:b0:535:68ab:7fdd with SMTP id
 2adb3069b0e04-5389fc362b2mr551171e87.19.1727382490149; Thu, 26 Sep 2024
 13:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
In-Reply-To: <ZvW9e8qBiAT5e0Ke@amd.ucw.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Sep 2024 13:27:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>
Message-ID: <CAHk-=whj9dbJD0mT6VUW7i16Les5waxWBb1o_XsDKrtQ9iBO1g@mail.gmail.com>
Subject: Re: Bricked Thinkpad x220 with 6.12-rc0
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux@leemhuis.info, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 13:01, Pavel Machek <pavel@ucw.cz> wrote:
>
> When I press power button, it starts producing some noise (hdd
> spinning up), but power light goes pulsating, not on, and I stare at
> black screen.

No beep?

> I removed everything, let it sit for a while, but behaviour was the
> same. I'm now letting machine "cool" with everything removed,
> but... It seems EC is very confused.
>
> Should I try removing CMOS battery?

It probably won't help. Last time I had something like that, it was
the EFI variables being messed up and messing up the boot as a result.
That's all in flash.

The CMOS battery these days tends to really just be for maintaining
the real-time clock.

But if it's easy to get at, it won't hurt to try either.

> Is there some magic combination I can hold during boot?

I don't see anything  about keys during power-on in

  https://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/0a60739_04.pdf

but you can try the usual suspects (hold ESC / Fn / etc during power-on).

But that lenovo pdf says
 1. Make sure that every connector is connected tightly and correctly.
 2. DIMM.
 3. System board.

for your symptoms.

That said, my first suspicion would be a dead harddisk, just because
they happen and you hear noise (but it migth just be the disk getting
power on its own, and making noise even with a dead system board).

The BIOS _might_ be trying to resume from sleep from a dead disk, and
not even initializing anything else.

And the disk is easy to get at, so try just removing it first. That
might get a stuck BIOS unstuck, and you'd get a "no harddisk" error
instead of a hung BIOS that tries to access something that doesn't
reply.

At least that way you'd have a suspect.

              Linus

