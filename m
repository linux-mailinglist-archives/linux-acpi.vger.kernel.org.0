Return-Path: <linux-acpi+bounces-4599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B758A895BCF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Apr 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80BC1C20B54
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Apr 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CBD15AD89;
	Tue,  2 Apr 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qpgi2Okg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308015AD86
	for <linux-acpi@vger.kernel.org>; Tue,  2 Apr 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082810; cv=none; b=R07RcNysM3DiSjg/IYOCG99pr8ZkIyTgyop9LxqEg1Pw7rjZHNhnDlbEYo6shg/UTrlE6qNDqn0Ny/mevhlhCi//NXQtdfTogL/FlJS60vJtqHr3TTNQBg1wJTDfTWFiW3hM0p+b59Zp+rAGx1atZxONj1n85ztnvfGewr+Z4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082810; c=relaxed/simple;
	bh=qyQkVgCunXaotgK67r8cO6HSgdhDl8n3o9zyob62ZMU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=Y3+9Rssw+hbGmQvi83Bo9ipHXuun+wdWpCFlK0SpkTLGRxIGHH9sK4X5BBlLQw9K9x6D5gwvP/pUJUhu/ib2VEfksQ7fuMFLHyoGQSTT2+zOcIShgC3C2cDWzG8Mp+TIcJV0qZscSmMFpksJ3QHhTo25+4JLzReK+Zz/8kZ9wb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qpgi2Okg; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:3621:0:640:20a5:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 9E34461363;
	Tue,  2 Apr 2024 21:26:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7QX1OSD7NmI0-AlLn6Q4V;
	Tue, 02 Apr 2024 21:26:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712082368; bh=+79NysKhHHp+5wSLjsonqIpEQ4oIXL6A29mM7gnhE/c=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=qpgi2OkgUwkyp2T+zpY/UiOouc3JIwvRnlw75s/QTff1NA/VM5bYYkLrN0WCo8W6I
	 E2+e1W4v7mQBQtYHSaon3+McsE5Uquv9/VcnIXD0S5nmXOekV1+jLRLwu8b7VgLd+7
	 D2U6uXxWHoqyxYbZ+g9NW7O0UMYGtC8IoP0smg5g=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <56f94776-484f-48c0-8855-dba8e6a7793b@yandex.ru>
Date: Tue, 2 Apr 2024 21:26:07 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <9d0a3bd8-62d6-43cc-8109-311448ad0867@yandex.ru>
 <cb9c17e4-53f0-4579-879a-0a8fa1352fb9@gmx.de>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
Subject: Re: ACPI BIOS bug and memory leak?
In-Reply-To: <cb9c17e4-53f0-4579-879a-0a8fa1352fb9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/24 05:46, Armin Wolf wrote:

> i thing the memory leak happens in acpi_ps_get_next_arg(). After allocating an acpi_parse_object in line 820 of psargs.c,
> calling of acpi_ps_get_next_namepath() fails due to to the missing symbol. The code now returns the error without freeing
> the acpi_parse_object, causing a memory leak.
> 
> IMHO the solution would be to call acpi_ps_free_op() in case of an error before returning said error code. I attached an
> experimental patch which might fix this, but it is still untested. If you want you can test if it solves the problem.

This seems fixes the leak indeed (running upstream as of 026e680b0a08a62b1d948e5a8ca78700bfac0e6e).
Feel free to resubmit with Tested-by: <me>, including the following if needed:

Tested on HP ProBook 450 G8 Notebook PC (2X7X3EA#ABB), with 'dmidecode -t bios' as shown below:

Vendor: HP
Version: T87 Ver. 01.12.00
Release Date: 01/03/2023
Address: 0xF0000
Runtime Size: 64 kB
ROM Size: 32 MB
Characteristics:
         PCI is supported
         PC Card (PCMCIA) is supported
         BIOS is upgradeable
         BIOS shadowing is allowed
         Boot from CD is supported
         Selectable boot is supported
         EDD is supported
         Print screen service is supported (int 5h)
         8042 keyboard services are supported (int 9h)
         Serial services are supported (int 14h)
         Printer services are supported (int 17h)
         ACPI is supported
         USB legacy is supported
         Smart battery is supported
         BIOS boot specification is supported
         Function key-initiated network boot is supported
         Targeted content distribution is supported
         UEFI is supported
BIOS Revision: 12.0
Firmware Revision: 84.22

Dmitry

