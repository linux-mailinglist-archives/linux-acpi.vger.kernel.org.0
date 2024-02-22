Return-Path: <linux-acpi+bounces-3850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8585F64D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F780B27943
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D244C6B;
	Thu, 22 Feb 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqLWrpMc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDE3FE4C
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599523; cv=none; b=qb6w1e57WS+jlGp4KlOWhvWME619koRPKJbIstpXehTTa01syYm7fRqOFkhasjelr3yfqN8GTyGcBnnO+49q30eHp/W/oCDTaHFAL4GBSqXmERsc8rN/X+e4oN+ujQ0Qz5ImFSHfa9Z7PD4i9Kdp7jxSdSP3xASIwGpUfWCc3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599523; c=relaxed/simple;
	bh=MbaHf0aFoYZ+N6o8Nx8FO/BRhrHStIeFx08AcHel/Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDQHjQ1r+Anhb9uG37PjpntVkWLpvVLt67oXh1ack3CtgkXMM8krGlk2ib4mvGHVX0cDH9hXtXAG+Zgu7h+1/PycsaokfoUbhDAY+NeIzD5UsEa20/lG5pkZNsD4fz/h+aIammSkyolz/zfhTfqJRsuH9arLAfXrGTZdkLyQijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zqLWrpMc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2505352e6so31892711fa.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 02:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708599509; x=1709204309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jnb5VAlV+t+Y6J33nYp+vDGASZ6SUQSeVwjB1F0eU9Y=;
        b=zqLWrpMc31DPV52P7E2MWBZx2wG4KfI3J015mydlxCdL43yn7hfpkKKWxV5Ff549cO
         Iap0yoUPQMELFnbK225/8FxVzrKWst0rsKUrvNFgQ3XsFIRI0fKGZflY7IOqerY5VUpX
         LWtkg0LOQzI7YsF0N7eRDSQjKpw8FxG8KT9fT64GbYyjtmTQkuOK+rkrvJ3MCY9GpCN2
         /sTgVtcYzer2EVvNOxw0RDmlM+W5sovIs6IddtOZzt+sElQM45PBVpCeUtCQfrGfXj3P
         OCUoRsg+MZcQvvOu7WhUWiUIZlDkPBWX/40XvmDszGiFnQ7UaT49ww+0phweOunvx2t9
         D2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599509; x=1709204309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jnb5VAlV+t+Y6J33nYp+vDGASZ6SUQSeVwjB1F0eU9Y=;
        b=Ui0UlWvyqqb4VJhX5tVaOcdghIJFcMMzZj/iS1mJ6fIByvTGQbPdivNiMCteJPMlqj
         CH1izuRy7GZ7C01vD/p4+HDiv8oQzqgoZnG2kS0B/Whca9KE1n2IizAmC2cOrSHoeOBv
         Giqe3b/fpRByhoqlwn42avefz1696DPoHcJNTLdWd2HBuxVbXAaIHZZjz4d+CCUY/5Q7
         tBGx3jFeREZGH86PQTBz5I5TAzIzOwKVRlaFaFdwbRumHDDVA5fwl57JNPttCGf45WaU
         ly93fX6+mKh3w7r+IasBDjsZpMd6FII9aRWoeF/SUhxbfrPh8jBQwHo/PL4WKDTlspMJ
         /cew==
X-Forwarded-Encrypted: i=1; AJvYcCV+vK6AeaRHL7hrmbPEMZOAzlnzoJ1TQUMmCJ+nK1Y0uv7u89VOK1yWgJENNugIK7dp0Ibi2sGoRNgs0qSUtAwE/8yWDFVMrxlH3w==
X-Gm-Message-State: AOJu0YxMaANdkb0Zd+r0yn3zKOi7LMLLizHf0lDpG4mCqk+mH7uAlmCj
	+MUUwP1PpW3bSYhCSJFbWtwpox9DbuaE+75oc2X1Ny9bPMLa8TdRy/r+C7hTOw4=
X-Google-Smtp-Source: AGHT+IGr8NDaBQu8UKrwVQ47LhttNlg1oJ/gu5tCjMflzuA048UVvteS2JzYGOYXFhZEhVqvA7rygw==
X-Received: by 2002:a2e:a98e:0:b0:2d2:6182:6ca7 with SMTP id x14-20020a2ea98e000000b002d261826ca7mr1203484ljq.39.1708599508674;
        Thu, 22 Feb 2024 02:58:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm14836608wrb.19.2024.02.22.02.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:58:28 -0800 (PST)
Message-ID: <ccf63280-bad1-4450-bf36-44cd1dcb69b2@linaro.org>
Date: Thu, 22 Feb 2024 11:58:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] thermal: core: Store zone ops in struct
 thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <2262393.iZASKD2KPV@kreacher>
 <ffa37950-d850-44e2-a33e-837466238d6d@linaro.org>
 <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hqCbxChYmvADZJAFiuS1yPnRmj6ZZJfD032tnLB7ZZAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 11:52, Rafael J. Wysocki wrote:
> On Thu, Feb 22, 2024 at 11:47 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 14/02/2024 13:45, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The current code requires thermal zone creators to pass pointers to
>>> writable ops structures to thermal_zone_device_register_with_trips()
>>> which needs to modify the target struct thermal_zone_device_ops object
>>> if the "critical" operation in it is NULL.
>>>
>>> Moreover, the callers of thermal_zone_device_register_with_trips() are
>>> required to hold on to the struct thermal_zone_device_ops object passed
>>> to it until the given thermal zone is unregistered.
>>>
>>> Both of these requirements are quite inconvenient, so modify struct
>>> thermal_zone_device to contain struct thermal_zone_device_ops as field and
>>> make thermal_zone_device_register_with_trips() copy the contents of the
>>> struct thermal_zone_device_ops passed to it via a pointer (which can be
>>> const now) to that field.
>>>
>>> Also adjust the code using thermal zone ops accordingly and modify
>>> thermal_of_zone_register() to use a local ops variable during
>>> thermal zone registration so ops do not need to be freed in
>>> thermal_of_zone_unregister() any more.
>>
>> [ ... ]
>>
>>>    static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>>>    {
>>>        struct thermal_trip *trips = tz->trips;
>>> -     struct thermal_zone_device_ops *ops = tz->ops;
>>>
>>>        thermal_zone_device_disable(tz);
>>>        thermal_zone_device_unregister(tz);
>>>        kfree(trips);
>>
>> Not related to the current patch but with patch 1/6. Freeing the trip
>> points here will lead to a double free given it is already freed from
>> thermal_zone_device_unregister() after the changes introduces in patch
>> 1, right ?
> 
> No, patch [1/6] doesn't free the caller-supplied ops, just copies them
> into the local instance.  Attempting to free a static ops would not be
> a good idea, for example.

I'm referring to the trip points not the ops.

The patch 1 does:

tz = kzalloc(struct_size(tz, trips, num_trips), GFP_KERNEL);

Then the last line of thermal_zone_device_unregister() does:

kfree(tz);

That includes the trip points in the flexible array.

Now in thermal_of_zone_unregister(), we do:

trips = tz->trips;
thermal_zone_device_unregister(tz);
kfree(trips);

Hence double kfree, right?



> BTW, thanks for all of the reviews, but this series is not applicable
> without the one at
> 
> https://lore.kernel.org/linux-pm/6017196.lOV4Wx5bFT@kreacher/



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


