Return-Path: <linux-acpi+bounces-16658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D5B52EB8
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 12:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73C516795A
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FCB30DD15;
	Thu, 11 Sep 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI4IStw+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032102E7BAD;
	Thu, 11 Sep 2025 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587136; cv=none; b=lnXv6d803k0ljaHMi7af4km2127wCqgvfZPu1sfg3jQ1BOZ7F2mQLWglvY0/VmX5ZrM1bqULmA9KGLkTJ3DyEAvR0R/N8TQQj/MeAnYLBmntUaAPmAuxduD1QoKUmdJGsl9hqw11ibJjXB8j0goGjDLc8zZp5Bk/zyydL5nGyqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587136; c=relaxed/simple;
	bh=CxQe3bX/MQqLYiit7yd0xARE4Y3X2J6l2HzXxwQDNqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sss2Hg+uWCY5GYZKtRtCocsgWa16mHL9NQLnuT/EBCpbau8qFstIs58ADzt3NyNMXTcGZr+SPHjlxUwFZ2iPMLplNwQ+U/n5N+VTv4zTcz8JhD90PKmUnoopfn3JS14Qst0EB5HUxN0ZQ1cg4g8cUnIv2i/IebC9jW1IkeUQWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI4IStw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4D7C4CEF1;
	Thu, 11 Sep 2025 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757587135;
	bh=CxQe3bX/MQqLYiit7yd0xARE4Y3X2J6l2HzXxwQDNqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FI4IStw+oqeL2m9Z2FcATjKpiFh6btP6e6+DFXG7rkp4aXj/+yFIjc8RlM95tljKf
	 bqei/Q+AWWcqg/UPAT4fHc8zVQLXOsMcc/YZpL3/nQRd5ug287ZjJvPC/HjADCyVVW
	 opEN6U3VKv4AwI/qJWMcg4N8CMJxhrYS/u9UaKk4zN9wN8kDKj9f3aE56Mw24IDpZf
	 E87e+pH5uw/DkD3qJdqKeNXkUWvFqqBS4NHLAc5B6gHz9ltCLHj4yIb8cxvp3SlZWA
	 +O5NrKwI6zmnwPYdOFLkhHHqHrWVpUkXMQt6Q8oroyg0EtDcuIyUA5ibbT9YkoxpRo
	 jbXctAdHrFuGA==
Message-ID: <ae7b139f-dc25-413d-bfc3-3be187ab3a73@kernel.org>
Date: Thu, 11 Sep 2025 12:38:52 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, rafael@kernel.org,
 stable@vger.kernel.org
References: <de4b5ec6-1e42-44b8-b5d3-5a452d7401ef@kernel.org>
 <20250911074543.106620-1-zhangzihuan@kylinos.cn>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20250911074543.106620-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zihuan,

On 11-Sep-25 9:45 AM,  Zhang wrote:

...

>>  So as you say the issue is that you have no native GPU driver calling
>>  acpi_video_register_backlight().
> 
> I'm very happy that you got it.
> 
>> First of all I assume that there is some sort of builtin GPU on these
>> Lenovo and Inspur machines with Zhaoxin CPUs. Even if the GPU driver
>> is not in the mainline kernel then I assume there is some out of tree
>> driver. Can that driver not call acpi_video_register_backlight() ?
> 
> We are currently working with Zhaoxin on this matter, and we expect to have some results in a few days.
> I will keep you updated once we have progress.

Ok.

...

> Thanks a lot for your patch and for looking into this issue.

You're welcome.

> At the moment, we are still confirming with Zhaoxin whether this behavior is consistent across all their platforms,
> so we are not sure if the special handling should always apply.
> 
> Also, on kernel 5.4 these machines seem to work fine without requiring a native GPU driver, while on 6.6+ the backlight node is missing. 
> Could you please clarify what design change or intention caused this behavioral difference between 5.4 and newer kernels?

The main problem is that on x86 laptops there are too much different
ways to control the backlight:

enum acpi_backlight_type {
        acpi_backlight_undef = -1,
        acpi_backlight_none = 0,
        acpi_backlight_video,
        acpi_backlight_vendor,
        acpi_backlight_native,
        acpi_backlight_nvidia_wmi_ec,
        acpi_backlight_apple_gmux,
        acpi_backlight_dell_uart,
};

With video, vendor and native all 3 being quite normal to have
around on a single laptop.

A long time ago the kernel just used to register all
backlight handlers for which there seemed to be support,
so "ls /sys/class/backlight" would e.g. output:

acpi_video0
intel_backlight
dell_laptop

And then userspace would pick one to use, typically
checking for different backlight types (raw/platform/firmware)
in descending order of preference and picking the first
backlight interface matching the highest preference type.

But even though multiple types may be advertised by
the firmware, they do not necessarily actually work.

So the simple userspace pick based on preferred type
solution did not work on all laptop models and
drivers/acpi/video_detect.c starting growing heuristics
+ quirks to let the kernel pick one and hide the others.

At first for acpi_video# backlights they would get
registered and then later if a native backlight
(e.g. intel_backlight) showed up and the heuristics /
quirks set that should be preferred then the
acpi_video# backlight would be unregistered again.

But this is racy (and ugly) and caused issues for userspace
trying to open the already unregistered backlight.

So the code was changed to delay registering the
acpi_video backlights till after the GPU driver has
loaded so that it is known if native backlight
control is supported or not.

Long story short: The design goal is to only
register 1 backlight handler, so that userspace
does not has to guess and to only register this
once and not do a register + unregister dance
of a potentially unwanted acpi_video backlight.

Regards,

Hans




