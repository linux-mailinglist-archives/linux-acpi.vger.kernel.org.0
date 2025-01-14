Return-Path: <linux-acpi+bounces-10584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C0CA103C8
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 085BA7A2E42
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F7222DC56;
	Tue, 14 Jan 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="iJI2EN/n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DB33998;
	Tue, 14 Jan 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849696; cv=none; b=iwpW3JTQh1ffG0aPBO0aGOoQSCFYhXkJQM3zdp86xX7FGyKeYTpvsT2oqTP9p3TrD7UrnaRa2em6pKKv2u9tgj9T/vAwG8/bdjwd01dsLyLDES0vI/LWL6VmLlAQzHAJxmLGBb5DFCqKq1OYb5hf6YczranQjXrWCT988b2KD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849696; c=relaxed/simple;
	bh=afH6X2tcZWNCSw7y255q2gkZqJqVky0sEtWd5Y7uUi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5sBvi2YS6fD890jU6R/Aw/e+GOh5+WdSB5Tphm5bPX0kaV31FOV3AmGa5eomMScLX2v4GMl5OEb9NxRSuTMTf4tDFpBZ16nSM8vLrzMomLZwYraLJz4qlpgiYkbjTdJiMJDmPw/ouKIBs+NEObCCyqALngw3zVhyn309/rjlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=iJI2EN/n; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D8F8D2FC004A;
	Tue, 14 Jan 2025 11:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736849685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wL2BdaqLmw6nRarkVHjKnTWFINzttDLCoJJit0B1B64=;
	b=iJI2EN/nIbr8QVuSTkI4oyrGkpLoeyTEkvT+Q9GnYwASkrCdAKJWGKZ3/0khPRc0pI0QGi
	pIjEBqKVMCZcmd/Q3ILkET5qcYjdpvRwEg656rH8FFzgpuEGpfHskS7b5eJI6nq/UBDVKG
	sK7Mmp8TBmO5J+OJddrmscYK3NFQxRU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <2de53940-d379-4b50-bacf-6849583acbc8@tuxedocomputers.com>
Date: Tue, 14 Jan 2025 11:14:44 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thermal driver with safeguards
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
 Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
 <2d24e844-242b-4c1e-9e43-f0bec1a98ed5@tuxedocomputers.com>
 <Z4WQ9XasbW6VuU1A@duo.ucw.cz>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <Z4WQ9XasbW6VuU1A@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 13.01.25 um 23:17 schrieb Pavel Machek:
> Hi!
>
>>> given a pair of a temperature sensor and a fan, I want to implement a
>>> driver. that allows userspace to directly control the fan if it wants
>>> to. But have a minimum fan speed when certain high temperatures are
>>> reached to avoid crashes or hardware damage.
>>>
>>> e.g.
>>>
>>> - temperature of target die is 80°C -> fan speed must be at least 30%
>>>
>>> - temperature of target die is 90°C -> fan speed must be at least 40%
>>>
>>> - temperature of target die is 105°C -> fan speed must be 100%
>>>
>>> - temperature of target die is 110°C -> device shuts off to protect the hardware
>>>
>>> Would the thermal subsystem be the right place for this to implement
>>> this protection in driver?
> Best place to implement this would be hardware... It should
> self-protect.
Don't know what you mean by this: The lowest level of logic that could handle 
something like this is the EC firmware.
>
> Next best place is embedded controller.

I agree, but I'm working on upstreaming a driver that is also for devices that 
are multiple years out of production. They will not get a firmware update.

Also for new devices the EC firmware is usually delivered as a binary blob by 
the mainboard ODMs.

So the lowest possible level of logic I as a developer can actually do something 
about this lack of protection is the kernel.

Please don't assume that we, as in TUXEDO Computers, do not try to talk to the 
ODMs about this and other problems we see with the EC firmware. We do. But 
matter of fact is, that all this does not help with devices out now. These need 
to be fixed in driver instead.

Best regards,

Werner Sembach

>
> Yes, kernel can probably do that, too, but then you risk running "hot"
> when kernel panics, when someone boots 2.16 kernel, or DOS or ...
>
> Best regards,
>
> 								Pavel

