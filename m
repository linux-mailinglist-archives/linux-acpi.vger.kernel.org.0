Return-Path: <linux-acpi+bounces-14743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D990AEA66B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2C64E15FD
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B72EFD96;
	Thu, 26 Jun 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMadZVOW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D8194AD5;
	Thu, 26 Jun 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966112; cv=none; b=jxn9ChULJurSkVPqxyTTXXswRAGqmas7pKgnlK4Pl3F7ZCtrRKjPcjbC+tlKLUW6Z5uXJW87Oza99H0tEq6VDo0twNYHprdHB4K+HAvf4vhKtUz5G844QKE0StTVxiSkAMeevUuCPPcC+YDxmGR3Yo/uAGr1xpogLt6LvOJpyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966112; c=relaxed/simple;
	bh=Q2wS+pyzzf5tK6D5i4KqNnpqLK3Yy5WfdmsA064hS2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geSWcSVEzaNNDKL4uqWDuYOZole75iSaZ1SIJx+Wp9dtTyyxWvczbhaFCjRdvILMsYY0eREDvQYpRaOBodaQfrHYozrY4NdIyyzEO2GSZhDI26X2w+CUZjQ36xRZYrfdzky2LEslgLzBSmhBT6lsgs32Dt9VA88LfEadwKCVFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMadZVOW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23636167afeso15951825ad.3;
        Thu, 26 Jun 2025 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750966110; x=1751570910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n+KI9xuy7BCM400uV+MvV1zpA9Alzbfuo6WtynbJu1s=;
        b=JMadZVOWomps4CcBggh+PlStncaxa6uDu/8QzsAloeVN7ooclLMIWC55bH+CE30h2F
         aPsCayTzFO074Tgd3R2PRbznEUdifrZgK6VtRMt5guyADvOmOcF0qcMjdu3Jfo67bK3V
         kZ8otunw/o9y9zDHHDgIzplxYDahf5LdzKAEV3FZW2u+0e1LXVoUsyPmJM+FtpHHfXb2
         shUJkWk5jabUc5UWQ3K8QOyTYV/QrR+fgM7YqHRGrpNNH6rI7mxtpxT5o9mboKDjcfcJ
         UAeeTQeG7VL/RXUuABLgqqPRT4YnDtPdUVLMOLrpalw/hWvyxLPbRKjPfMS/ValV9pha
         sCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750966110; x=1751570910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+KI9xuy7BCM400uV+MvV1zpA9Alzbfuo6WtynbJu1s=;
        b=oEsFhUProcWCQDX1GIMYTYIkV7BctgOlDiN6QwsdUyzGgoftZWn5x6xWWg4IPhK/DO
         cs7m9Gsyny/1TW2fH/NkiKaYLJEGcWLgnLmYl7kKJr4I3w20mpuEbJpUfwwUj/iXl7p7
         IjU5pQHqSWCHMU3ccC2E2wvW3DM+iQi0m+AtUN/mTYCLB2JRXRFKvKBqy+LPELfOdhwM
         d150ZDaohgtW1krImbu6q3l5LYsIdDwKdpJWC0cXooweH8ZrKmQTBHc+V1zdYFoiXw6H
         vl5GM4Ghdiqh9CBL/pB0OXLn6XckigKrhjfHAMQ6AEaGmco1g6wlY0cVRDDSIYFgkzFC
         Xg2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJHasRtNg3SycfPYKKUD6ngSwAKvfUJzLoRIMeEDkKaYuo1XnW5dO3xeQ57dn5/bCsLFEqtw9Qz8pee4t8@vger.kernel.org, AJvYcCUy+g0zNaB5QaxtgmmzBwgKuUq0xPa38rJuCH0nXRDKUOhwNFXvN23A14fOCpdwvnVRTiBkE+HR+SmUOYE=@vger.kernel.org, AJvYcCVAROKcARMappmdsC43lP3W8fbqs2ccFSnHJBl+zYNAv226jQfL6WB911FPzMv/v4HEEo5+3xIXtuSBVA==@vger.kernel.org, AJvYcCXu+gXk1h5nTX27P6B4d4GyQR06+zfVTkjE9v3b4A/QSSZvDNIo6HdglSu4LGxPt2/GJo46N9Th633A@vger.kernel.org
X-Gm-Message-State: AOJu0YzULMHEwx3yOxBkjdbEGAET0bUBVAu7pWED2VG2AuVQQEhk68IE
	+eSthIuNw8BMtFWJTjxU7Pi4kVgnfyVTtHtlhy/lXBIY6COrfFDXYgJM
X-Gm-Gg: ASbGncveLJVb79c8CbFIcHL+ucUWn2n1jFYAogpsTRGX/sF/zgE1iqNZ12K1eB2Fffm
	fi1QRACQz/sm91xxEYCUvC8FhPkTtTuF7K2HzurKhYQe4SzmM5HP35eTovjgj2x2PvgvUpZEq4e
	YtKfw6Z8FkcXH6Vy1sY2Zayb1umEcn1P4QAP4vw4vFm1bzvRC2dkNRJjGsXSJeD8SHmvyoUxWQx
	UZw+F7Er38UCM2vizcuQ+iWK5N0Sd4jAWl0wuhLVlj5TSY5VkLmDYtOdOkq5Ki/F6b31ubUanwi
	ruhc8RVYb289xj1s8ltmmbV2GPldS4AoYSs5fD51YiA3ohsGs7imlw3s2NwDK2A=
X-Google-Smtp-Source: AGHT+IGpoY7/fquEMZwaVCEOwMvBYCe+srIwXynJUatqOx7vcebaPxrZE/1T5lKcEHVx9k3XRV8sfQ==
X-Received: by 2002:a17:903:2c5:b0:234:bca7:2920 with SMTP id d9443c01a7336-23ac45e262dmr8776225ad.24.1750966110350;
        Thu, 26 Jun 2025 12:28:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c429b436sm2317446a12.7.2025.06.26.12.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:28:29 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:28:27 -0700
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
Message-ID: <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
References: <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>
 <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
 <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>

On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
> >
> > Hi,
> >
> > On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> > > On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> > >> Hi,
> > >>
> > >> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> > >>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
[...]
> > >>>> I want to note this driver works quite differently than how ACPI power
> > >>>> button does.
> > >>>>
> > >>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
> > >>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
> > >>>> patch was modeling).
> > >>>>
> > >>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> > >>>> [1]
> > >>>
> > >>> If you check acpi_button_resume() you will see that the events are sent
> > >>> from there. Except that for some reason they chose to use KEY_WAKEUP and
> > >>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> > >>> multiple other platforms.
> > >>
> > >> Interesting, but the ACPI button code presumably only does this on resume
> > >> for a normal press while the system is awake it does use KEY_POWER, right ?
> > >
> > > Yes. It is unclear to me why they chose to mangle the event on wakeup,
> > > it does not seem to be captured in the email discussions or in the patch
> > > description.
> >
> > I assume they did this to avoid the immediate re-suspend on wakeup by
> > power-button issue. GNOME has a workaround for this, but I assume that
> > some userspace desktop environments are still going to have a problem
> > with this.
> 
> It was done for this reason IIRC, but it should have been documented
> more thoroughly.

I assert that it should not have been done and instead dealt with in
userspace. There are numerous drivers in the kernel emitting
KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
what keys to process and when.

Thanks.

-- 
Dmitry

