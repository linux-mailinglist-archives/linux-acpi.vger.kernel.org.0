Return-Path: <linux-acpi+bounces-19427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AADCA42BF
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 16:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34AA33160D1A
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B02D3A69;
	Thu,  4 Dec 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="aBHsBm9J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D542D29D6;
	Thu,  4 Dec 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860682; cv=pass; b=GsNfm4kGmJ1nCIR5OtB9LagwCdO2m5A4A1bIHS9RH5pli+4zWOYTHlLtnmF+brOTqO3bVwJU2s4HbRYJk3GlSex/F1K0rzz0W3XawnSjl5zWc1FEis8lJByafJzFq0MRBxJf6dD1xK1jE3ZlTrRgN+/pA/F6OjMTZHc/RIJXADQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860682; c=relaxed/simple;
	bh=Z1zDOIZZt8ODFF5YMJW3Baghig0RzGQQANrYx67jkic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ir1ITxw2WD9wC8wZsIw4hiIkB452gmOYYMbys9WeUF3oYVwWVPmapLn8i5ETbNd6k/BdvYV5LEijbDUY/WuVKF7xAtEMEdIPWlIReqY8NJCV0fFCpMt9XcDlpDiUhSM16QDYiglAzYhi8nBMFKEH8CQRF6C2V72eK5vimHcknh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=aBHsBm9J; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764860632; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UyCAFsfn6LHZLkTjszFgwl3yfwM1RHks+/KQADfu+Y7r2Upw0jDDvUjckVpamswWNauSFcktVZcq0YSHh+1TLnGH1duBgdVQTY7bu5nB9sQapkT4E0dttpuArjCrmOsouYeJh/GkcEB+ft80Ijieg/Yw80+rGzIpU5sPL9pJOow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764860632; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FPf25EqHzEi/72P8f6zXr0/UiOkqeWlzJVT7ZkJdT/0=; 
	b=P9yQY65LFkW6eTKSmGusEJi6krtl38/H4AlxWgDE85hAlkxoNcFFHEswPAhX9Vu7UvjCOj1xQobfpa8Syqo2LLjk4qTUpxSWAELXCMLAPL3y00DV+Dx/9jXfObce2gl/HI/Hak46BdXFqrbylf/+M+FmVywT501u6hicgHZ1/ZA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764860632;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FPf25EqHzEi/72P8f6zXr0/UiOkqeWlzJVT7ZkJdT/0=;
	b=aBHsBm9JISpTWm1MVPI0BlSnyqSU53pE/PgKRYX40h9frArf5qtrMQpxzSQBMtNB
	+O/hSyUtyVcB9Tj5LSamATHmPE65K54PvYW7euojvXfkPS3zmq18895eZ6YymsKkjeK
	xQURl71DoUkB0gqeG9Pua8H/+I3RWoh2R/xoLs04=
Received: by mx.zohomail.com with SMTPS id 1764860630126560.3360139527972;
	Thu, 4 Dec 2025 07:03:50 -0800 (PST)
Message-ID: <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
Date: Thu, 4 Dec 2025 18:03:44 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>,
 Antheas Kapenekakis <lkml@antheas.dev>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/3/25 17:58, Rafael J. Wysocki wrote:
>> Add `/sys/power/lps0_screen_off` interface to allow userspace to control
>> Display OFF/ON DSM notifications at runtime.
> Why?
> 
>> Writing "1" to this file triggers the OFF notification, and "0" triggers the ON notification.
>>
>> Userspace should write "1" after turning off all physical and remote
>> displays. It should write "0" before turning on any of displays.
> This sets a limitation on the correct/expected usage of this
> interface.  How can the kernel ensure that the limitation is taken
> into account?  In principle, it should not allow OFF to be triggered
> if any displays are "on", for example.
> 
> And what exactly do you mean by "turning off a display".  Cutting
> power from it or something else?

The common lowest level denominator for the "turned off display" should
be that all display CRTCs are disabled and there are no active remote
desktop sessions.

For example, firmware of Intel laptops tracks state of a built-in
display internally and treats display being tuned off when either
display's CRTC is disabled or when backlight level is set to 0. This may
be not the same for AMD firmware.

Display On/Off notification is a hint to firmware that it's allowed to
put machine into a lower power state where UI presented to a user may
become non-interactive.

In practice, entering this lower power state makes device to pretend
that it has been suspended. On a laptop, keyboard backlight will be
turned off and power button LED will start blinking. This allows us to
implement the "resume to a dark mode", mentioned in the cover letter.

It's up to userspace to make decision when and what DSM notification
should be issued, thus the new sysfs control.

There is no strict requirement on having displays to be turned off when
Display OFF notification is issued. Machine won't blow up when display
is enabled and OFF notification is set. Hence, it should be unnecessary
for kernel to be extra cautious RE trusting userspace.

-- 
Best regards,
Dmitry

