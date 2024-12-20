Return-Path: <linux-acpi+bounces-10213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97099F98B5
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA9416602F
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80622F389;
	Fri, 20 Dec 2024 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SC/wT12U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA621D5B0
	for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716036; cv=none; b=pTBJ1FJpBkvC0NqLIKcl7g4WU8rj3ELdV8/56DO1/z6Bk+iZ3oFxltJPWde0CKnF5/8olYengTjiybZtPsFEcN+IHiDNAwqqeucpXR2fQh/rmcEEB0Jldts3Li6iGHJ2tkcbhjH0nUbkVeg4+oWxaJyYQs/eavugWzn4IFVJ39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716036; c=relaxed/simple;
	bh=EOSgJFqbNzZue8PcEmo8AOIhn9yrJuIFDZjAitrdngA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlzSpSu8ohKvMTKbbBdv398L5nWjiyghcTTxHLgpDD4mzgBFQ0H1V5CBbdDQ08JHIexJpW67wJ4ZqBoPEaDSL6DCl8g6usbmeVgHLhwGGcvPrt0Ope+EW1FiqYX3Ceq1+1CZJ/Ttki3nCvaFYbbhOvICD0qZS/Baoqqxhxo0eAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SC/wT12U; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so72174539f.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734716033; x=1735320833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3lDWXYieWaSwhCuCMEtUeqlkkHZALzZ6qVm2AYz5YE=;
        b=SC/wT12Uf2ED7mrE5a/zeZQ2TDmilhHWP09B7xOyT9a1pr/q+ehgg6UeVcfbJIISGn
         s/PCLkoZapjuYJKXUvS/HFTWabKwLbLHO6eX2gg/94WGkNn5RwENM0nG1NisuoWkWQ72
         F5e1hOl+5X/8lJtw7GSRm56Z0YWaxm48PMmeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734716033; x=1735320833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3lDWXYieWaSwhCuCMEtUeqlkkHZALzZ6qVm2AYz5YE=;
        b=nABYSmWaNrGizVKl0PIyAIRA+1qefK7B3LBFNj3ii75rmEa+l2xcHa8+EHRS+zFPtq
         pfkOnUO8WkHt6WDMQ5I26sBI0q5tkjbXkQ3CbIEau+Ko/Ngqi3kvC5xmIdOZZP93x/56
         zwmrMO0X7f5QjXBPHHgFc6NsThnsk9AHXIuc1by3zsyHLBQk4laSwt6qDuJP341LRv7L
         aKd+Q2OnOIqp0/Fuy2UuR9crrMPnzGABuq7i6hCvrcsF0M7dfzWPnNXAjr3iP+7lnmJw
         kpafZWRkcfdRyG6rwxxVetNl7UZb0xA8KkMN0nsFWmvUaXIeB1JmDzoffvYkp+YhJ6nh
         9omA==
X-Forwarded-Encrypted: i=1; AJvYcCWRD0YUgwwVpW0RN1svSdqb/QEHN+0LN+FP6SFZj5BNwBiR5YpbhpnSepKsaTRUd4ggBbkvpCrTLDWE@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiOZDFb9QMzquXypQio5UffsBYDljFTrQKzJiJFxOngRVT3ot
	0yElXesmjaolDvOiiV3vVRHRyuZ5fLqAqYQthp0Za2l3XyGaip9lvHH9+On7cRc=
X-Gm-Gg: ASbGncuW9xMam8JfDa3QKlwvpirW8bjQIV5M7ypzFTRnc3dAit83doUmu4IrdF+UiFm
	mtIi9799xHpVFn0G34/BqcjQF2pA+7hECfTrP88gtX5thOwIj/sagDFwMFA4cMYlhQQqffFpcpK
	YsJhJXyTU0Kt9bt95n/6TJM2j6Dht8QHlZQSCYVn5iiwlPssiCkfhH2H50UvHElJxuZVDRsu5BL
	21tIgXrgmmaxevWK3jjJuV////X0MilZi1GlhaSXYboddAO0gfoV/b+Ia8DAKJ8hPOf
X-Google-Smtp-Source: AGHT+IFxMb2oesh8pBt/S0AGpufvN5zhHv/M30Pf7wTX/edjZ8qrqpLT9QM7STSTrQpfkOUyEB4LOQ==
X-Received: by 2002:a05:6602:2dd5:b0:843:e9c1:930b with SMTP id ca18e2360f4ac-8499e679bddmr394514739f.14.1734716032784;
        Fri, 20 Dec 2024 09:33:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf7ecc6sm877195173.70.2024.12.20.09.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 09:33:52 -0800 (PST)
Message-ID: <c8e232e9-78ff-4051-995b-41454f9c4b51@linuxfoundation.org>
Date: Fri, 20 Dec 2024 10:33:51 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drivers: base: Don't match devices with NULL
 of_node/fwnode/etc
To: David Gow <davidgow@google.com>, Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>, linux-acpi@vger.kernel.org,
 Rae Moar <rmoar@google.com>, Rob Herring <robh@kernel.org>,
 linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241216201148.535115-1-briannorris@chromium.org>
 <20241216201148.535115-2-briannorris@chromium.org>
 <CABVgOSmZUETNa8OfqTvMuGg8Dim3UjLzvKdeJia6aCV7Ydgzdg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmZUETNa8OfqTvMuGg8Dim3UjLzvKdeJia6aCV7Ydgzdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 22:45, David Gow wrote:
> On Tue, 17 Dec 2024 at 04:12, Brian Norris <briannorris@chromium.org> wrote:
>>
>> of_find_device_by_node(), bus_find_device_by_of_node(),
>> bus_find_device_by_fwnode(), ..., all produce arbitrary results when
>> provided with a NULL of_node, fwnode, ACPI handle, etc. This is
>> counterintuitive, and the source of a few bugs, such as the one fixed by
>> commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if
>> one actually exists").
>>
>> It's hard to imagine a good reason that these device_match_*() APIs
>> should return 'true' for a NULL argument. Augment these to return 0
>> (false).
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
> 
> Seems sensible enough to me.
> 
> Acked-by: David Gow <davidgow@google.com>
> 
> I assume this series (including the KUnit test changes) will go in via Greg.
> 

Works for me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


