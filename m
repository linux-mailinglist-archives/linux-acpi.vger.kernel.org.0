Return-Path: <linux-acpi+bounces-14749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E571AEA72B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF87D16DF63
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867812F9484;
	Thu, 26 Jun 2025 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baYQrrZe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFAA2F5468;
	Thu, 26 Jun 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966853; cv=none; b=CswbFLQ5i0w/s92wZ/Z2FhuQJ4jvSOSUDFxe+MF9x4Q8xnlT63rB7IP/7roFhw5jWWl+daLTHWH3TVbTGHdjkG2ivAXt1o+7sSL7vBnrRbuh7+jN5f/NLnX5M/AgUlsP/r6EACLfAFIIVaLYFR0J5Emrg6pjeA1RnQW9oklXf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966853; c=relaxed/simple;
	bh=AAO7C5Y/RZlpj+t132su3nOcGXkNASwzvoFQP/R11KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjblQZdVFEkfQlZYLfjo5gyQXZtwU1T4d3wGxcNirJlCk5i3HVPTqy+w6rwAgdjcnBu8B8+388CyfMcL/hy1cpg3ptHOYjDXD/R0dsDFefr252Lpay2YfFtYeI6hID9XSoXowLb3VQ81myrB84qGBDzt4fvAqpZzrVgovLky6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baYQrrZe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1030971b3a.1;
        Thu, 26 Jun 2025 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750966851; x=1751571651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FR1Bx76/hEFg2MC1mzG6wAYU6iwdbG0AxK6s00hXRXg=;
        b=baYQrrZe0+pyLNlHniV0RHEXSv1ku9eqyeunfGorL/Qw25i3qqVBODOdh8WhTEHBx6
         FvYw1PykF66Zh/qTzttqC+FUKrVJGZXqp/eR+t7ZVPNxFMf2N+29rMsTqTz1u31t4Dlr
         BXdix8RWh9H0GfVhYxFcaDvm3UmiP5n65lGY1o9WwYB98Q+w5UcBdn3v5iEPLX22KxYk
         Y7i5U0B98gL/b01WdR261UZvGb9g1tKJKX72Obtk66pgJ2ZYjxjV5I6hfeFOEQppHPuf
         TXd9oIGak3Nw0qNzHe+yYunb+eqmJRSs7iXpY9YHEqO/m/gxI3oBwau2+v8ZcOI/IOxP
         L5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750966851; x=1751571651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FR1Bx76/hEFg2MC1mzG6wAYU6iwdbG0AxK6s00hXRXg=;
        b=CjIGJhPbQMObMqfEyugZYfqY8gIwfLTNmR3ESGiqRp366bIuGoLD2PuHBSCr/8yYaY
         +UcGKeowvYENLENPbDSWtPCs1/y/Am02JY3hxqsRyCzHZPqxpAHLZIoW2XWkTyMRmUha
         +n2+UnkBflo0g1gw8IKitQnnaOkZl885yJ2EC0REsbsxRdgxTIM/YMof8WDS/8g6R2+/
         OGXgoX/CA9LVeJeswG1PLXxpLxqczCpR0fZPGBajVCDiB3sMpj5uo96AHUSpWZzXbDXY
         xmF8p/0KtzO67LGPUQGctH2oHKCVWGhrBx+0yYcg/5wL7OhvL521I66riloCR51fqZ7W
         2bqA==
X-Forwarded-Encrypted: i=1; AJvYcCUiHL5Xi9QACgI+WUjX122otK6oowPDvmujxZZdHDE5AiINPcSJ3X4Brkk6yebIe0Jq4jYG+kTyVqSzeQ==@vger.kernel.org, AJvYcCVGWXI4XRH5jDO1XRNbsRPBkshndB+uNTfkIt26ejbTar59U9oYkVc5oRsWKU07OxYkjxGDr6wpwkA29GaF@vger.kernel.org, AJvYcCWEG6Ur6zi9ooPQz6nu9tfUT4c8i355BnpV2mDnmccfHSgjSN6jrQa6BFycTG+ZT+n9cU0EOEphqPTP@vger.kernel.org, AJvYcCXkFPKW1auRd50lNdAflS7gwK+spEPlQFPX2/x4ADAgrEH4PXNXk3AwUAlvV/X/6hewGwXZDJP/Kk64ozc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tXQcGJzeomkwVK5y4rLZQwza7IqrMA9Ulm5F+Ci01rBYDseP
	rnYtX6PuErU7iM8dzgkK9+8vC5oD+R1SORsAYsZBsPFYyu2USJDRI/J/9V0M9A==
X-Gm-Gg: ASbGncsDV64SH9K/M34Cj2OZj6zcj2LtR3aLtWNQdreCMcLEU1+Dl46579PnsRVpcOI
	n+6aLL3/vpR5hvlymF+P06t7qQPOKAJh1gnTxK+dTlxTrsLHyeG5JNhhEUGquhke+dt1yJup/Jo
	u6XdvkBGKLUplGLZibRwHswhxoW6hkAwBpsNgGvVfOcA8LKQUGOu7sVbXPgM4QG2WEOYp8TAOfC
	D2OhNWmp+p0WlNy5hNU4KV1aFkqR1X4CLYWHT6ORw+e7MXjyEsspUGgF0oLZodsDQB/sHEe/Rft
	rWRiaEQoIPyvnnqr9P0Wk5WaQ3NzMWtLlw7a3kYPmO8/o9nPSg8mAwJCoKTm11g=
X-Google-Smtp-Source: AGHT+IEIdbExDbqrZv7dWtG2wqYrlM+AXl0MN/UpcvMIKhL6kDmzQB8lqg5Zjgu9mpYRbfJ6tiAQVA==
X-Received: by 2002:a05:6a00:928d:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-74af6e51e92mr555438b3a.3.1750966850954;
        Thu, 26 Jun 2025 12:40:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56cffe4sm394644b3a.138.2025.06.26.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:40:50 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:40:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
References: <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>
 <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
 <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>

On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> > > > > On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> > > > >> Hi,
> > > > >>
> > > > >> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> > > > >>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> > [...]
> > > > >>>> I want to note this driver works quite differently than how ACPI power
> > > > >>>> button does.
> > > > >>>>
> > > > >>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
> > > > >>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
> > > > >>>> patch was modeling).
> > > > >>>>
> > > > >>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> > > > >>>> [1]
> > > > >>>
> > > > >>> If you check acpi_button_resume() you will see that the events are sent
> > > > >>> from there. Except that for some reason they chose to use KEY_WAKEUP and
> > > > >>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> > > > >>> multiple other platforms.
> > > > >>
> > > > >> Interesting, but the ACPI button code presumably only does this on resume
> > > > >> for a normal press while the system is awake it does use KEY_POWER, right ?
> > > > >
> > > > > Yes. It is unclear to me why they chose to mangle the event on wakeup,
> > > > > it does not seem to be captured in the email discussions or in the patch
> > > > > description.
> > > >
> > > > I assume they did this to avoid the immediate re-suspend on wakeup by
> > > > power-button issue. GNOME has a workaround for this, but I assume that
> > > > some userspace desktop environments are still going to have a problem
> > > > with this.
> > >
> > > It was done for this reason IIRC, but it should have been documented
> > > more thoroughly.
> >
> > I assert that it should not have been done and instead dealt with in
> > userspace. There are numerous drivers in the kernel emitting
> > KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
> > what keys to process and when.
> 
> Please see my last message in this thread (just sent) and see the
> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
> events").
> 
> This appears to be about cases when no event would be signaled to user
> space at all (power button wakeup from ACPI S3).

Ahh, in S3 we do not know if we've been woken up with Sleep or Power
button, right? So we can not send the "right" event code and use
"neutral" KEY_WAKEUP for both. Is this right?

Thanks.

-- 
Dmitry

