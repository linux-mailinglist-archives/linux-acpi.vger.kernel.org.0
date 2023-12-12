Return-Path: <linux-acpi+bounces-2338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD5880F8D6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 22:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802741C20AF6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 21:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543465A81;
	Tue, 12 Dec 2023 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0zWqfWH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF24A95
	for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 13:02:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-334b2ffaa3eso5359917f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Dec 2023 13:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702414955; x=1703019755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fP3PBbkg+dGDRbq07rpkl3oLoeUyahhiYf75aZTkbF0=;
        b=J0zWqfWHzdG+QeTl4U+QZKt5y8Efwcr4V31Lrl3e2GJf9dHb9GaTPdMyz9JWAq6VFf
         qwjugv9cp6cXnOKMsJX4dkdYNwVtyK3ihlzxWykY+6lv6lX0XKlUcaoc4LQhxOk03BSE
         Z2lq3HU73JzInRDo6yWRUEOzljFsx8PuopvbtC5DJL9L/BZNYSCx9zeMcOeWeHcIyCIJ
         RUHOSlo9YUfIiee931XMpbikEp5vt0vESB+XgtxVNRJDmWW4G5rrBkErAcjZO2btQqE0
         tm2DiZrPWCTb17j9l1YEpMknlNafOFe5rbY3r5fpnwEfqpC2oXfgwlyOUHI5NnQcZHSM
         CliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414955; x=1703019755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fP3PBbkg+dGDRbq07rpkl3oLoeUyahhiYf75aZTkbF0=;
        b=SWXZuVJv+DW5KSKJz2WndrG4EBV0wpKBWDzYPDoGDeows1nRdpgxnbdoLb341TiTlP
         HFkUB8eztpPaEtBnK0YVl4muzjXXB1nRLFx7lUtN2xpFiIMFhFsdxZZVcPo9U4NkxTDK
         ms/35fcyUaNZaZXqcet4tWm9Xh/1m3C3BKsAyq+dWvH5dcLdlDvTqy2Hc/Q6NrCQNxKR
         5wDIzmVOhUXSfBqy3gOGX3GbcI1Rz5G5qeMTGbatFyvpEsDKywwRSaqREL5yOuIkfp27
         6sG1DGXkpM3q6Mb8X0MCt8gMKn6TLJXDDQV/2VrkArxbiztwYe9h4lHTCTE0AltM8O4I
         YQxQ==
X-Gm-Message-State: AOJu0Yy1PkRVmT83Dj4NJJYdMh0lNjoc38/CFTyiVMxzyTTeFTF3lKYT
	f8nCBZVMntFdewKHlA0fm+9dcA==
X-Google-Smtp-Source: AGHT+IGzx824ZUtMwg2ZMXI/wufgirctkBfjm6aqgGXizgPzjydfwsIPAaND7CNMU2RbzjzhH/Jlzw==
X-Received: by 2002:adf:e34a:0:b0:332:de0f:d7be with SMTP id n10-20020adfe34a000000b00332de0fd7bemr3284238wrj.18.1702414955022;
        Tue, 12 Dec 2023 13:02:35 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d6b84000000b0033634aef014sm1746153wrx.104.2023.12.12.13.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 13:02:34 -0800 (PST)
Message-ID: <1e2b5100-f40d-47f2-880b-121704c0c8e2@linaro.org>
Date: Tue, 12 Dec 2023 22:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Send trip change notifications on all
 trip updates
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5737811.DvuYhMxLoT@kreacher>
 <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
 <CAJZ5v0ic_=2wvge1T7YmGe5icR5dPxrvKy2N4gXP+KMievobmA@mail.gmail.com>
 <CAJZ5v0gkBZh42obB-g95T2DBFntYrnidjAeUoFN+e-CqGrSQCw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gkBZh42obB-g95T2DBFntYrnidjAeUoFN+e-CqGrSQCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2023 20:04, Rafael J. Wysocki wrote:
> On Wed, Dec 6, 2023 at 5:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi Daniel,
>>
>> On Wed, Dec 6, 2023 at 3:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>>
>>> Hi Rafael,
>>>
>>> On 05/12/2023 20:18, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> The _store callbacks of the trip point temperature and hysteresis sysfs
>>>> attributes invoke thermal_notify_tz_trip_change() to send a notification
>>>> regarding the trip point change, but when trip points are updated by the
>>>> platform firmware, trip point change notifications are not sent.
>>>>
>>>> To make the behavior after a trip point change more consistent,
>>>> modify all of the 3 places where trip point temperature is updated
>>>> to use a new function called thermal_zone_set_trip_temp() for this
>>>> purpose and make that function call thermal_notify_tz_trip_change().
>>>>
>>>> Note that trip point hysteresis can only be updated via sysfs and
>>>> trip_point_hyst_store() calls thermal_notify_tz_trip_change() already,
>>>> so this code path need not be changed.
>>>
>>> Why the ACPI driver is not calling thermal_zone_device_update() after
>>> changing the trip point like the other drivers?
>>
>> It calls that function, but because it may update multiple trips in
>> one go, it does that after all of the updates are done, via
>> acpi_thermal_check_fn().
>>
>>> It would make sense to have the thermal framework to be notified about
>>> this change and check if there is a trip violation, no ?
>>
>> It is notified as noted above, but not synchronously.
> 
> I believe that the question above has been answered, so are there any
> other comments or concerns regarding this patch?

No, it is fine. Thanks for the clarification

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


