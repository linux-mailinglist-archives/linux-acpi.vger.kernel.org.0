Return-Path: <linux-acpi+bounces-14699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7889AEA31D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F68017C857
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458F2ECE80;
	Thu, 26 Jun 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzQQcA9L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169A2ECD1C;
	Thu, 26 Jun 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953598; cv=none; b=oCIiPJLCUmnWy5sYMC2gD7UDYpmx833tymC3G8EvhzHRZFjynR26bqt35qrPRa1BfrYjnb0Rw2YuyaVDSpknlkv2xc8R1DLfodv3WekFocd5zmkByfjGFk23iubum3gy1tch93bcCISUjkLzqdNKapRnzWS4kDvt1mICvouciUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953598; c=relaxed/simple;
	bh=5OCKpyq0EAO0vvvI0lknTAQgHsWoLfl+8GdLvH4xgMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJBuMkLPzRgFljYVIRr68/125PgMT1I1+OdLQjD/7NhBi4Yd4Q3dFesKEMrb0xEgC8iKc8duB3j2D0UjfaTdtlixdidFdvQQU7/KoaPHkNxE4JG4N7CeaP86FEXsBd+PbLK4U17iGoL8ZP5Oz4VewVnYrIgG7xf9g5vMqJ8pcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzQQcA9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD162C4CEED;
	Thu, 26 Jun 2025 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750953598;
	bh=5OCKpyq0EAO0vvvI0lknTAQgHsWoLfl+8GdLvH4xgMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SzQQcA9Lr8xm8+u0v5svVsXtegfdpIsXzKef6ujyM3dO49Vo5FFIRPviIQrRb/yty
	 g6mHCY5bKGGcmNQtc/tdb8S5Io4sRAwjrhp3de1MoL+LhWYsIPnR9SG2MZbW0W/2hR
	 wSnUpXC0e9Klu9KOYcIgUt6ONVD/VrqFxaw4psUFXTwKGNPnOeihPpPh8lZ4ZyTonF
	 nniY8fpbr/R22QUMdVXoEUtIBLvBpiEPN/rUBMBz9tGvjonSIlkhPO23YNZF1OmF79
	 zAXe1MRupTAg2h5nGhduPzON6h1vte+SdiPE3830eNdWIscSCskmAVGMPRm9NwFsNT
	 WVbrnQXNi7Vdg==
Message-ID: <6fe93457-4d41-4610-ac0e-e3341783f891@kernel.org>
Date: Thu, 26 Jun 2025 10:59:55 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Fix soc-button-array debounce
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <aF1anq07UAkHCfPO@smile.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aF1anq07UAkHCfPO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/2025 9:35 AM, Andy Shevchenko wrote:
> On Wed, Jun 25, 2025 at 04:58:09PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> I have some hardware in front of me that uses the soc-button-array
>> driver but the power button doesn't work.
>>
>> Digging into it, it's because the ASL prescribes a debounce of 0 for
>> the power button, but the soc-button-array driver hardcodes 50ms.
>>
>> Hardcoding it to what the ASL expects the power button works.
>>
>> I looked at the callpath into the GPIO core and I believe it's
>> because the debounce value from _CRS is never programmed to the
>> hardware the way that the GPIO gets setup.
>>
>> This series add that programming path and then sets the hardcoded
>> value on on some quirked systems.  Hopefully Hans can confirm this
>> continues to work on the hardware that he originally developed the
>> hardcoding for.
> 
> There is no a note about routing the patch in upstream. My proposal to take
> GPIO ACPI library patch and provide and immutable tag for others.
> 

Sure.  I don't feel strongly on how this needs to go, fine by me.  I'll 
add a note in cover letter for this for v4.

