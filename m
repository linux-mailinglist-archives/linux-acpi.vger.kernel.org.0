Return-Path: <linux-acpi+bounces-10214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D69F98D4
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1237A7A31
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6AB21E0A2;
	Fri, 20 Dec 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QgP/edTA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4B21E096
	for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716092; cv=none; b=BQN+fme9WcXBXxPiSsbmlSiRlBlrkHy6PSNJRPlBvZ5rqjqSKnkdS+UwTczoutFsUEzasZaEvKnY5bXN4mDyHu+xoabN6xTeOvOQwYORF9qH1eNfZa2cnWCQokIRPSHbodQHuvS2PYk81LlRDMElq9v8f35tI44BrdT/GawPFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716092; c=relaxed/simple;
	bh=sB4Qa9trk67pIn3qtj324FrHhU4l0JkYAxP9D1po14A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iy3ZS7ZK3x8Ydwm2TcQ0QocTXAXWMazdmVc3bLubjz5UnCou7J35VADby+DdAhQ3A49DINw40ZMv9nsu9U53SJtgT2krfOX7Kco868MHRaOfeCnboDaUiH1Ulj0Ni7Az3067yBlrpTrhF1lsG2jAJ10s701+zPhJUyyaMiyku2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QgP/edTA; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e12f702dso76067239f.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 09:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734716089; x=1735320889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bfcorNm0/Wj5y3Z7wXjeJrt/2j0lA2cfaU6IiYz2hU=;
        b=QgP/edTAI2iPUeMWgdjmt566rpXfMMDIAMFJh+8uz6MQHwtSoax9n8W6Im3a88pLtR
         iPRjn+ADmlt2wbUUozVgOHlCIF/6kvmqKnDqFwn3Zxb+rqRZbUvigHrCzaBAyY9QPxGT
         ecDDZ6rsLKJkXT3FqBjPaydKnwfvyKCtfwVW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734716089; x=1735320889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bfcorNm0/Wj5y3Z7wXjeJrt/2j0lA2cfaU6IiYz2hU=;
        b=hxx7ZbeXHoFbd8dGtF4PF8bSy6pcOhJx0AZoQ4l+Uam8bYMPmN+sK9U0KpRjv6mL5R
         tLeVGBPlnOb2kkrs6OwHwViojg3rhDVwPh2yVq6lvekbn9uZ/qNxE888J8XRbzuEjIGU
         MrPDU7EHxn9ft9lk5RDmbRPDkGbk4X0roAMYOC6etUkRbxIi+3kwnZHTPfcnC47Cj+zr
         96B746yDda3+zWneRe0g/zohnNTcJqC++2rjqLV1wVGjXJTCVSp3dBvHLIIvbxFcxxCR
         9N6qFG9ZeM8a0Jy8mE8gjUXefz4S7Jk4YjI9rNvga1z0OF26KCg8ddJZlP9TQYWycwgZ
         Aj3w==
X-Forwarded-Encrypted: i=1; AJvYcCVOW265GDRbKOYXmK3RVtfLWTi2TWs7CoTDgUKYkUnNxiHmLU/rmNmNZaQOrETSzOblc2xNLDFfNM7X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90UtJULtETT64Qh90CnnKWlm9WElgo1LlXUKxJGE4SLK6tUwz
	+x1tstHOH7hAPUxUUzchJfMnuA1ud+gqkUDYS8GR+C3eqLqan+WKO8neUkrArEg=
X-Gm-Gg: ASbGnctaDcTXojvdxWl5RiKuPvsLvNt/UUWTWQSf0phjOqrRvbLlDT12Xk/C9U3Fgjq
	xEHl/mqYkW7ADWvudQX60gHr3gLNikpYJp9snRyzD0AhsQPUZtOiHTbUzR7ZwOVhupR6s/rF+yP
	agrRu4qclLuTVP7tpRZgv6HRcHx9RZe4Ebz4vXlteIhqE8X0h3txmO0S8n2KN5KQCqzjcUVvWgE
	qPiJMSzXFWMfznZFHSlopGV5Zy2DbwgLkQ8WjWs92WsBP1fpZ5mbjf8ugpSsnRkdoJv
X-Google-Smtp-Source: AGHT+IERS0XEXKu0zBuSlavwD3/LW9dk/OiT/DTiE5qVaR8PsSVflTcP0RFBZdkYhG6Y0jZ2zzcTYA==
X-Received: by 2002:a05:6602:3c7:b0:841:9d3d:ea14 with SMTP id ca18e2360f4ac-8499e61e2f1mr450577139f.6.1734716089630;
        Fri, 20 Dec 2024 09:34:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c1df18bsm874192173.137.2024.12.20.09.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 09:34:49 -0800 (PST)
Message-ID: <df114243-822a-44a0-9991-d5d51a0dd91b@linuxfoundation.org>
Date: Fri, 20 Dec 2024 10:34:48 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
To: David Gow <davidgow@google.com>, Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>, linux-acpi@vger.kernel.org,
 Rae Moar <rmoar@google.com>, Rob Herring <robh@kernel.org>,
 linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241216201148.535115-1-briannorris@chromium.org>
 <20241216201148.535115-4-briannorris@chromium.org>
 <CABVgOSkL3iCA9j553GM8pX_SZ80Xx+BWGZ_qaL0jHAY69-WMmg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSkL3iCA9j553GM8pX_SZ80Xx+BWGZ_qaL0jHAY69-WMmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 22:45, David Gow wrote:
> On Tue, 17 Dec 2024 at 04:12, Brian Norris <briannorris@chromium.org> wrote:
>>
>> We recently updated these device_match*() (and therefore, various
>> *find_device_by*()) functions to return a consistent 'false' value when
>> trying to match a NULL handle. Add tests for this.
>>
>> This provides regression-testing coverage for the sorts of bugs that
>> underly commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device
>> only if one actually exists").
>>
>> Reviewed-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
>>
> 
> Thanks. This looks good to me.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> 
>

This one also can go through Greg's drivers tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

