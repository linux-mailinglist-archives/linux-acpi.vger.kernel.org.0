Return-Path: <linux-acpi+bounces-9716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609C9D52A2
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 19:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279F028108D
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2621A0BF2;
	Thu, 21 Nov 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+jmQgkQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04C6F06B
	for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214380; cv=none; b=R6mSamocEPTtn/Au6jWbX+2DuBToBgcg4qUaBP6DWNkLF8o+tO7EK8e4Vl7Vz3h2MJJbFcmMb+6OVQ3mjkuTzweQaarkGHn9NAeXSQMsWVAGV5DAvwxl79psb8zMiOpNaQa3jRvJBYp1Q/FeOhvivwHWum3LNk8Y5z78OM1q/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214380; c=relaxed/simple;
	bh=G8XOSFc7W5LX9nk1d6dB9lDKaf8fszfFMsNH4VlGnZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAI6sycASedCoSeNi55sThT2yIescG1zEI+HqzOrp2WpvnF1LADgBbEKw5G5rO8Spi2+3K8s1m4xGd7/nk6CGQZGTKi222GxCrFoy2SIevTA5W/np2kDPi6ClA4HZ9PVxG9xTqu2tQfwBXHGpHYaHsGSn8q7FCYwI5mmseeIkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+jmQgkQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732214377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8LxgwuAPowXuHoG85RopJJmji4cVIb+ptva+m06qdM=;
	b=f+jmQgkQFFHHngHhuoXF4ZE521rj2rNJoiOUNOPJC2z8UGhZdTc82itSUBEFgCHjJlE3Sr
	+xD/aoMQA5kpp14eA3W8HHkfHjAH0K4IfFMH2Yygeh5+puQdrh/46x7C9FubR2qyI80kz6
	seG52ma6tYsLe9DpA2Z0bd28C936tNo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-V_9o-jmMMTK6Y0QrEX-q0g-1; Thu, 21 Nov 2024 13:39:36 -0500
X-MC-Unique: V_9o-jmMMTK6Y0QrEX-q0g-1
X-Mimecast-MFC-AGG-ID: V_9o-jmMMTK6Y0QrEX-q0g
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539fb5677c9so1150315e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2024 10:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214374; x=1732819174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8LxgwuAPowXuHoG85RopJJmji4cVIb+ptva+m06qdM=;
        b=Jn2mUEvHHBwR4mPOVechzAailZ0QRbiyl51WIYPa1mhXwQhiDNhcbqSJSE/QRWojVs
         zfG+tnzpDYQf2K5iY+37SsvQwaw+tUK0knCSL8nwIxrxIZmX6Y/fkIW2d+zzGLiff4aU
         PAifBJNGhtovvq4KbG0u13k1d4vRJHEcNN8I8zrwTF4lIMP6IMKHxCsjqx9qfpoaQtDY
         3frDFeFfMLhbGIjGy6cnZBAGSIG/9aYtCzVzTtLPUnTdekSB0AZ8oBcb0XlWWjMQKS1O
         OzbXz4f2Mm0Whv3pyUdT69QEI4VlVi71zZ/wOO/AatlFNiG/yLza9CWG64Mfi9BMLHqA
         faYw==
X-Forwarded-Encrypted: i=1; AJvYcCU9fVSG+Rq1paEr2/qaUw08/Nnpr98pdnVVVXFLPl67vcet4YEjiUwnk2svSoCtAOhGtk2GHbRM8Ywp@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHN9tWnjc+x7E+99Y63l+KE/9PuV6vq4PR1bO07UnjkQNB/kY
	tEAakmNg48fLVc1pS8a0VubdXH6qW9f3DZhW5gPsbqq8W7jUXaeVGwbbDczXUd7P6g+pNxx3TGm
	cOo2DZYT5iWepekN7WAjYM4dF0Rle6NMRiZsaNgEZ2Lpem3dKIPAu3VLXgwc=
X-Gm-Gg: ASbGncvLZhjk9Ve7NmGnoXWCp95YtlwdSa9EKsmSeZwOhHm51NB6WHWu9IyaQJRA108
	oOWSZBCEdgJm38ELxMwNbx5I7rpFJaxlm2l1rVVSIqVLjC5Yvdy1WA1DcCcoMz1YcAmtCK3qPCJ
	OVrvs05VhnN8CxWRiJyAoRcRKSOjuvtfLNk/uc/ZEJDKAB2LyFN6Byqv1lnJoSWL51gf/RsIAJi
	MkaBBDlzZ9jkqqbo3igExS5KzF6JW+P4aD8BvkE9R9L+2RNWUCheFU4zqvVSaOUkwrvnJ0QRKfg
	3snEhXDqsQE48/gka6vpR4Zy2D2+FE+0usqugEDyQvCtdkyVBlVwn7Nfakr3BV9m/yrXfBZL/p/
	BETAxjNijvuRSFKWY+HqIjwfj
X-Received: by 2002:a05:6512:1288:b0:53d:a025:14bc with SMTP id 2adb3069b0e04-53dc13670d0mr4202647e87.41.1732214374429;
        Thu, 21 Nov 2024 10:39:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsMRcWipCf+gqmLcfQGX437D2za5bWeNpvmmk4uIvuIwkT8PhxWA8oZeXW/HHOKWEX1LNOFQ==
X-Received: by 2002:a05:6512:1288:b0:53d:a025:14bc with SMTP id 2adb3069b0e04-53dc13670d0mr4202627e87.41.1732214374020;
        Thu, 21 Nov 2024 10:39:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fa36sm1718866b.122.2024.11.21.10.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 10:39:33 -0800 (PST)
Message-ID: <c6315bb7-2943-4693-899b-da65cfecc7a6@redhat.com>
Date: Thu, 21 Nov 2024 19:39:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in
 acpi_os_sleep()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <5839859.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5839859.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Nov-24 2:15 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> As stated by Len in [1], the extra delay added by msleep() to the
> sleep time value passed to it can be significant, roughly between
> 1.5 ns on systems with HZ = 1000 and as much as 15 ms on systems with
> HZ = 100, which is hardly acceptable, at least for small sleep time
> values.
> 
> Address this by using usleep_range() in acpi_os_sleep() instead of
> msleep().  For short sleep times this is a no-brainer, but even for
> long sleeps usleep_range() should be preferred because timer wheel
> timers are optimized for cancellation before they expire and this
> particular timer is not going to be canceled.
> 
> Add at least 50 us on top of the requested sleep time in case the
> timer can be subject to coalescing, which is consistent with what's
> done in user space in this context [2], but for sleeps longer than 5 ms
> use 1% of the requested sleep time for this purpose.
> 
> The rationale here is that longer sleeps don't need that much of a timer
> precision as a rule and making the timer a more likely candidate for
> coalescing in these cases is generally desirable.  It starts at 5 ms so
> that the delta between the requested sleep time and the effective
> deadline is a contiuous function of the former.
> 
> Link: https://lore.kernel.org/linux-pm/c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com/ [1]
> Link: https://lore.kernel.org/linux-pm/CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com/ [2]
> Reported-by: Len Brown <lenb@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a follow-up to the discussion started by [1] above and since
> the beginning of it I have changed my mind a bit, as you can see.
> 
> Given Arjan's feedback, I've concluded that using usleep_range() for
> all sleep values is the right choice and that some slack should be
> used there.  I've taken 50 us as the minimum value of it because that's
> what is used in user space FWICT and I'm not convinced that shorter
> values would be suitable here.
> 
> The other part, using 1% of the sleep time as the slack for longer
> sleeps, is likely more controversial.  It is roughly based on the
> observation that if one timer interrupt is sufficient for something,
> then using two of them will be wasteful even if this is just somewhat.
> 
> Anyway, please let me know what you think.  I'd rather do whatever
> the majority of you are comfortable with.

I know it is a bit early for this, but the patch looks good to me, so:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/acpi/osl.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/osl.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/osl.c
> +++ linux-pm/drivers/acpi/osl.c
> @@ -607,7 +607,27 @@ acpi_status acpi_os_remove_interrupt_han
>  
>  void acpi_os_sleep(u64 ms)
>  {
> -	msleep(ms);
> +	u64 usec = ms * USEC_PER_MSEC, delta_us = 50;
> +
> +	/*
> +	 * Use a hrtimer because the timer wheel timers are optimized for
> +	 * cancellation before they expire and this timer is not going to be
> +	 * canceled.
> +	 *
> +	 * Set the delta between the requested sleep time and the effective
> +	 * deadline to at least 50 us in case there is an opportunity for timer
> +	 * coalescing.
> +	 *
> +	 * Moreover, longer sleeps can be assumed to need somewhat less timer
> +	 * precision, so sacrifice some of it for making the timer a more likely
> +	 * candidate for coalescing by setting the delta to 1% of the sleep time
> +	 * if it is above 5 ms (this value is chosen so that the delta is a
> +	 * continuous function of the sleep time).
> +	 */
> +	if (ms > 5)
> +		delta_us = (USEC_PER_MSEC / 100) * ms;
> +
> +	usleep_range(usec, usec + delta_us);
>  }
>  
>  void acpi_os_stall(u32 us)
> 
> 
> 


