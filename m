Return-Path: <linux-acpi+bounces-20789-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQRO839fGnLPgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20789-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 19:51:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A708BDFCC
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 19:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FB9300876E
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D037F738;
	Fri, 30 Jan 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiCHx3Aj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527636A002
	for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799088; cv=none; b=FaNt3iHVdzLrSziF3OpkX5hcRa3iKQMEQ1/sIbp2ZgA6XaYCH4ZIzmYvN+1tqhhNam1BjP4M4cw8jLaQaN6KMkmARrftxXQNwqkV3fup48UGhn62c1h01VbH10tpqkLcaROEOSFOf0MWr+CuXK05/VAVNNvVHXMrJpYf2bwgDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799088; c=relaxed/simple;
	bh=/9PASLNkEz1077GAKGR+lXo3rAHLekUpOanEbIBlnbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7jq16VwrWJEJ2f66S9C/KEOAOPJ2ytoTPDMDXjkl0kvZiVRWnZ2h5PiizJ0XWpBoLYXHC18ri6I0bk/j+QgRqMfZAzyow+vb1QTDX1ofQplQ5KLVWQaru6/xQkeGh61ePvp3UqSRNGNbNGGw6dIB/AJMCIw+qtLcJ8pE7vg4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiCHx3Aj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so1344011a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 10:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769799086; x=1770403886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gJAVq6555m7vuU36qd07Iq3B3EwXpc49uehWWjzHmxs=;
        b=KiCHx3AjAtEVp7qJ0jfW7Q+DctosUMINpfanuibBXkEREJe9zBOuqbLObA5suMGR4/
         neInemoHEEtnPoqpGQINOclAK+4uepqxzLo0EVSWVYatGMe4CiBn2IocIz2cNmt1Ix5m
         kfWvHSGRme8TSgmd5WJq4XcEIN5y0tBsaRmWiZGOQeLgo5YplPfBl5wvOD44G2mcecEU
         YBsXy86n0Ow/XVemqh2yqtRj2AHglLWa05OC2AjK5+rbFZdY1bbpnlWr+sy2aA8LkH6p
         g7axGtoVQoxHdKCunqP7a+joIL6it23FW17NCFgtGDi1bj1rh+0d4/0cELWDyBpK5yaQ
         jWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799086; x=1770403886;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJAVq6555m7vuU36qd07Iq3B3EwXpc49uehWWjzHmxs=;
        b=Jcl3g7UKPC9t199Foh79K28GNsw34dKfdTmuIoICD+lbzxgbIIM+/SHEShaFTmDm+S
         zb1NI9hC3BRwRWnIcOe6yYqtVVrA0akq0PeAo7J07so/XUiwsNyBRb/pYlpBBzy34ALF
         TdX2b8nF+xIHZTrZ/WZ1D0nxd2q5vhMtcjR5yIMhlCxI0yHB9OJ2DfBQiSHlVi6zJeUb
         QoWBpmFInDWaeDSbAtOy0/iU9beReF2cpsltQSo3VeRx5ZKqX8ebufZQvsguHHg2lL7+
         ibt8PeWXPp4/iGPpjqye+jWESZm3P/eROGtCcAaj3Q9nuVB0wqL8NT6jvBfeud+zupCy
         q9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW1j/tsxXxEOJFiKb6HQWSzzoesp5e8c/gvhG4pZL1NYPYSwRIyPznWCoG4duB4sMH7ICTu7pxa5PCu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hw8cmPiN0vhPjMXfmwNHQPTeGf3dYEhQ28Cjjh2YUIkJsgMh
	GAFWdHTcf7nVmbTYZn0UGoce253nAs4d+fXzco+hAPKYCKEP8QU7P9lo
X-Gm-Gg: AZuq6aIzNxeTfkKN49V+tdXsjSwFnUmy7doEcu7lKMT9MiueGp5RPAEgS+yWNm22XwR
	F1/s2aUVrSBOJPqModfD88FvWms27jk1oNa8UuVsDlFork9pMpG+0/beN4PLdhzP4cjkRuszXuz
	1JLtH3t1eJWwQZTzG5UiUO2BMqQQWzlAWJNjuWEBpM3nS7Ru4eM/akRCw+RyAlYRb/bPtxaPM5t
	Y1MRTLMa9QsgnMnYIiUc+FHgOc+YbE10QwqbXp6Qc0Fo7b7VfdDEgnoEmg4jGlPGTM94jY0/w5P
	+27ibSyEpivk7kXEj/HYz72f+bbPI2Mj0MRl898NlEw1G8rXXmOWwoqehX77l4CRRCfP32tCcuq
	Ca2RQtJ/ROJ2xi+dZoiQDTIiiIWBqmFYyMTuGMfZiQOPTMLe4PLOOdrFwp8v88VA117eyiq+aWh
	hu2/X8yt4V1X0zHq3Dq3qHayFpt/xzI37osx/0kUsAkqIh3KQnsly4UXgYe0ltf9lG0n+3G8o=
X-Received: by 2002:a17:90a:fc4f:b0:352:b674:2592 with SMTP id 98e67ed59e1d1-3543b30564bmr4594233a91.7.1769799085875;
        Fri, 30 Jan 2026 10:51:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f02aasm8725178a91.7.2026.01.30.10.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 10:51:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <91fd3a9f-8370-4a6c-8beb-bb0e66e59523@roeck-us.net>
Date: Fri, 30 Jan 2026 10:51:23 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to
 acpi_power_meter_notify()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki>
 <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki>
 <e30972fa-62de-401a-8fc2-a48a66ca2c73@roeck-us.net>
 <CAJZ5v0jxEMhQ_i3ReOE9=XSaguGYTQA44staN=hBHhjVR0_zVg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJZ5v0jxEMhQ_i3ReOE9=XSaguGYTQA44staN=hBHhjVR0_zVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20789-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A708BDFCC
X-Rspamd-Action: no action

On 1/30/26 09:51, Rafael J. Wysocki wrote:
[ ... ]

>> Gemini says that this is still racy:
>>
>> Description: Race condition between remove and notify. acpi_power_meter_remove()
>> unregisters the hwmon device and frees the resource structure without acquiring
>> acpi_notify_lock. If acpi_power_meter_notify() is running concurrently (e.g.
>> waiting on the lock), remove() can free the resource while notify() still holds
>> a pointer to it. When notify() acquires the lock, it will access the freed
>> resource (Use-After-Free).
> 
> This cannot happen because remove runs after unregistering the notify
> handler by the ACPI core and that causes all events to drain.  See
> acpi_device_remove() and acpi_device_remove_notify_handler().
> 
> Moreover, acpi_os_wait_events_complete() is effectively a full memory
> barrier because of the two consecutive flush_workqueue() calls in it
> that each acquire and release a mutex.
> 
>> Additionally, both functions may attempt to unregister the same hwmon device
>> concurrently (Double Unregister) because remove() reads resource->hwmon_dev
>> without protection. acpi_power_meter_remove() must acquire acpi_notify_lock
>> and clear device->driver_data, and acpi_power_meter_notify() must re-validate
>> the resource pointer after acquiring the lock.
> 
> Well, this also cannot happen AFAICS as per the above.
> 
>> Maybe I am missing something, but I think it has a point. it is not a new
>> problem, but still ...
> 
> I don't think that there is a problem.
> 

Excellent. I wasn't sure if a notify call could still be executing when
the remove function is called, but that does seem to be a bit far-fetched.

I am inclined to apply the patch as-is to (hopefully) resolve the immediate
problem. Getting rid of the hwmon device re-registration will need more work.

Thanks,
Guenter


