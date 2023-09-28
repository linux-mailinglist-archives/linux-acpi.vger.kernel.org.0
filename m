Return-Path: <linux-acpi+bounces-264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7937B1FA4
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4C559282AC9
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F83FB02
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:34:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D4328AE
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 13:31:51 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F72B19C
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 06:31:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32167a4adaaso12342940f8f.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695907908; x=1696512708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T08S6IcvTtc7N9BV5LzOKgOD0pjFqX9HyRFqWGAYhhs=;
        b=qGH/yx6ELOmDQYM0Abt2n1QZA96NjkfJMKJyHfyBwpZiwuqVb8bbycg8PXJeItdsoc
         +nt1l8AXdgWdi7IH1o0Ftmo5pgeedRS6uMwb8TYIo5KzIGaJV/ltwrAYcBJd32j8YOvo
         DfeW9ZBsGNYn/jL15Fwa91eF/bGiRwqiJCIoJySN8Ef6A1zOp5/xBwozTrhf8sZzYskC
         942akULqN/7f2q2icjPoiOc01fx8J1wFL//YzdrVm/Pzt7Dq9W1Q5AyDFmYhVGIcnkJI
         UYfBJfqLLwraTNn7lYAhWV7jdbCTdn55hL36ObPEBYktvCBUq7+Jnr7OmPR69CEJKwXJ
         lQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695907908; x=1696512708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T08S6IcvTtc7N9BV5LzOKgOD0pjFqX9HyRFqWGAYhhs=;
        b=N9OnahKCkixtdyWYJlE0bCsTZNQg8DWe86tbOBa3cdVakFg/Aik9Dm/x5NM0jLNbuz
         1+YXjj6SuJ4hSYCvNoGA9+dNCRvGrtiT9OwHcc1EwBZyyzBF3MtIxXd12BAsjDnfaSxG
         n8oJNYyr4G6WASZkEVeB9KMllPEOg+QGmQAESOytUUaLaNrCbDcBfq0v7qBPq4i7mFj4
         9UFnVBVokTypUQOyO19Kzps/iC0RhEk3rT9k5LjUGTgj1I2ThXFxRcnO2Ld56k+tFYa9
         REo8wbPcaNyaaY/qIXc1x7295viOFyeQ231vEQYQVQI5iZ16/vCsSHfz2ILxZFmFI91U
         /jGg==
X-Gm-Message-State: AOJu0Yy0nD58f66c2ERlshWD/kq3YpE/WtRO99vubpbT4/7oC+wKk7DH
	qWErRjR8E6ArVH7lZpwR0eBa/Q==
X-Google-Smtp-Source: AGHT+IEaDyRoeJfIh3W2+KNnYk9x6itUo1Xk6uJTmTcRoir3MfVwImO36qIbE00OsPNbngLtxbPUzg==
X-Received: by 2002:adf:cd0a:0:b0:31f:f982:5395 with SMTP id w10-20020adfcd0a000000b0031ff9825395mr1408904wrm.35.1695907908443;
        Thu, 28 Sep 2023 06:31:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm19426288wru.52.2023.09.28.06.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:31:48 -0700 (PDT)
Message-ID: <11eac712-b9aa-3c46-11bc-70c2f4f9935c@linaro.org>
Date: Thu, 28 Sep 2023 15:31:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 10/13] thermal: core: Allow trip pointers to be used
 for cooling device binding
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
References: <1957441.PYKUYFuaPT@kreacher> <45837158.fMDQidcC6G@kreacher>
 <065636fa-e6ac-4fcb-5d78-b3f281ac4609@linaro.org>
 <CAJZ5v0gjGL_4Fs=_iO086tmBP6E+oQoo+Jix_PH0dspbZ9yn2g@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gjGL_4Fs=_iO086tmBP6E+oQoo+Jix_PH0dspbZ9yn2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/09/2023 12:38, Rafael J. Wysocki wrote:
> On Thu, Sep 28, 2023 at 9:10 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/09/2023 20:01, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Add new helper functions, thermal_bind_cdev_to_trip() and
>>> thermal_unbind_cdev_from_trip(), to allow a trip pointer to be used for
>>> binding a cooling device to a trip point and unbinding it, respectively,
>>> and redefine the existing helpers, thermal_zone_bind_cooling_device()
>>> and thermal_zone_unbind_cooling_device(), as wrappers around the new
>>> ones, respectively.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Thanks so much for all of the reviews!

You are welcome. Thanks for cleaning up the ACPI code

> I'll now apply the patches for which you have given tags and respin
> the rest (governor changes) as a separate series on top of them.

Sounds good, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


