Return-Path: <linux-acpi+bounces-7486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74794D9B0
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 03:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6C8B21FC7
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Aug 2024 01:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F182347C7;
	Sat, 10 Aug 2024 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDXFdJk4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD81E4A9;
	Sat, 10 Aug 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252526; cv=none; b=TeWN360jWfLZRvzYklVYjS10Iixyx8yODDC/qns0SDUGImnLcOO6xGOjOWWMlC670ds+4g1xSnnjLWhh8jFFbWP9Ncp9Sp80YMTYyqVGHC3/Zxt6GXXa5f3ULr/pTgV0MlCH4YfpfuXrXmJnLCEULCqM1zRJu55w1eIIagU3Jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252526; c=relaxed/simple;
	bh=eVrnEkymkgWiw4KUnaEUL7rO4ydgXHlWRyNSdxlmzIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+3fWGIvnlwzjFYkBJGU9TOnrbbFQ1flDk8TqRgW93jGHKdkKhgCpmn7Zl6BWJRmlzYLT1dL/kK0Shaqjp94ywJS6ZQBtwWrhD02qLdIcwDw1w38UUQQC+oqBqRA1ao0S+OuMJQdY/HTIzuBlyp4OB1w2ZMDcGnSo9H/Ec+evTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDXFdJk4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso1679724f8f.1;
        Fri, 09 Aug 2024 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723252523; x=1723857323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9zfo4WEzF3z/bIMKMHgf7itqTEdxPVPMEvEU0eIHiQ=;
        b=RDXFdJk4E21r2nHYpzwajofnDFQDcScLJLsDDkfC4GGYpq+vyzRcxPGdRPyHVVib+b
         rIsXdebNacPFmrgJJwG/KO4p1Uki20sZn+n/58+hn1xDfMOPdJC0eMWsiQe3JGF15/PP
         UYPCffcMGNWGWV0i2U+th//w7nw3XVI8CFZY4V83K/SKishfVO2CHJ1/ii40/B6fo/Mn
         YCFuvuFqLnWzSZM1sfl04QUE4exBsAeN1VH2GGtxbMJi4t2mvFBl5nEnzWZ1ZQdh+CyQ
         SqNLW9yB+GWhM1BHY4n7WQYrymClEOgpzHfHBCc7DyXi49mgozAwIoj6SEQeHcLM2pMy
         tMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252523; x=1723857323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9zfo4WEzF3z/bIMKMHgf7itqTEdxPVPMEvEU0eIHiQ=;
        b=SbP5ygb3XFEOt5deV51GFw9WBVIMN6bG1ZH9Ln7x6/oCQ0Yk/UUN2JTEejO5uHCVGn
         QIslSvrb04JEQuSTihHGpq4xuLpZo7/TOsCkMkKsCsK46Ph6CdoZ7jZzSwFA8MMasaGk
         ppBfx9T1RgtEZ8hzhkkWVuLng5CEnSnKL8ROkLBtlKlfCSzJQZX/2FXjFLYSVFhPG16u
         ThGW3HxvkESsbx1RI5ro5aVNNRUpRLCcxVfydzgeWbGzUD6geXHMUtRIsNg9cSL1fHDP
         XdQ7rJXN6idDp4gcwk/PAHYkPp2OwsIQKpxGCxZEXTv94BFRXaYfwQatkHbTlceJ9Hul
         nC+A==
X-Forwarded-Encrypted: i=1; AJvYcCUVlcn9FoVgqu94nr1cvUCJuzczO6ZeU+MI/mE92SAvwZX8L5SrZVRANsVVOn2okhzQyNLwdmxyb4JF2osMcAxwmKRG7saIWkcTxJuQVjWpa7FIIcZO634JvAghtQSMOBpv4RsSQ51MIo0fo0rdPbd1OC/8sL4B8vKZjb7502Ui1cJZfleqwd1OKHrli77MZNs66m6VqfDeVCYOX+p0q6iLWFWrP2R/Ap+6S4vYsoLyPcvamhPXwc7OfwTOR/13R+lNn1H4+g+M
X-Gm-Message-State: AOJu0Yxlp/601sGM1Wubm2UqtNrb6Qoozp01UMqzVNg0h0mppQvOC8Xx
	+sU2rovlLE2JgnNP/kt/+m/KikgdZYcRMFNvwPn6xR01e9WZLNwX
X-Google-Smtp-Source: AGHT+IHXVUdEv2O5ohO9bAXTgJVklt0jhTkgNxeU/ElF7JfiC68zZmaHSF+BCSkgHtUC/zTurdLJHg==
X-Received: by 2002:a05:6000:bce:b0:366:f041:935d with SMTP id ffacd0b85a97d-36d61cd285cmr2223176f8f.60.1723252522595;
        Fri, 09 Aug 2024 18:15:22 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4f0a6d76sm796094f8f.115.2024.08.09.18.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 18:15:22 -0700 (PDT)
Message-ID: <f9c9601b-737b-42d1-9449-2072afdec580@gmail.com>
Date: Sat, 10 Aug 2024 03:15:20 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/surface: Add OF support
To: Konrad Dybcio <konradybcio@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
 <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
 <9ee8eb9d-1e1c-439f-a382-c003fbd7259c@gmail.com>
 <ea348f62-49e9-4b5e-9041-b0a696aaa736@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ea348f62-49e9-4b5e-9041-b0a696aaa736@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/24 12:44 AM, Konrad Dybcio wrote:
> On 9.08.2024 8:09 PM, Maximilian Luz wrote:
>>>    +static int ssam_serdev_setup(struct acpi_device *ssh, struct serdev_device *serdev)
>>> +{
>>> +    if (ssh)
>>> +        return ssam_serdev_setup_via_acpi(serdev, ssh->handle);
>>> +
>>> +    /* TODO: these values may differ per board/implementation */
>>> +    serdev_device_set_baudrate(serdev, 4 * HZ_PER_MHZ);
>>
>> Isn't this defined in the DT spec that you're adding as "current-speed"
>> in patch 2? Why not load it from there?
> 
> Yeah and it's not under `required:`.. i added it for future proofing

Okay.

[...]

>>> +static const struct software_node *ssam_node_group_sl7[] = {
>>> +    &ssam_node_root,
>>> +    &ssam_node_bat_ac,
>>> +    &ssam_node_bat_main,
>>> +    &ssam_node_tmp_perf_profile_with_fan,
>>> +    &ssam_node_fan_speed,
>>> +    &ssam_node_hid_sam_keyboard,
>>
>> Did you check if there are any other HID devices connected? In the past,
>> keyboard and touchpad have been split into two separate devices, so is
>> it a combo keyboard + touchpad device this time? Some models also had
>> HID-based sensor and other devices.
> 
> No, touchpad is wired directly to the SoC via QSPI, same for the touch
> panel

Ah I see. So somewhat similar to the SLS2 I believe. Does it work with
multiple fingers out-of-the-box? Or does it send raw heatmaps like on
the SLS2 that require post-processing?

Maybe some background: Since quite some time, the touchscreens on
Surface devices operate in two modes: Basic single-touch no-post-
processing-required mode or multi-touch mode where it sends raw touch
heatmaps to be processed by some driver or user-space application. So
basically, the whole touch processing stack is shifted to the software
side. And with the SLS2, they now even applied that same thing to the
touchpad... We're trying to replicate that (user-space) processing
with the IPTSd daemon, but there's still a bit of work to be done to
make this reliable.

> 
>>
>> Would just be good to know if this can be assumed to be complete or if
>> we're maybe missing something here.
>>
>>> +    /* TODO: evaluate thermal sensors devices when we get a driver for that */
>>
>> FYI I've posted the driver at [1]. It needs a small Kbuild dependency
>> fix but apart from that I think it should be final, if you want to give
>> that a try.
>>
>> [1]: https://lore.kernel.org/lkml/20240804230832.247852-1-luzmaximilian@gmail.com/T/
> 
> I'll give it a shot, thanks
> 
>>
>> The rest looks fine. I'll try to find some time to update my SPX branch
>> this weekend and give it a spin.
> 
> About time that thing lands upstream ;)

Agreed :) Thanks for taking this up!

Best regards,
Max

