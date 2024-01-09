Return-Path: <linux-acpi+bounces-2760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68176828519
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 12:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA012B22D03
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62136B1B;
	Tue,  9 Jan 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUlSUJPM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CEF33CDF
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jan 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso31209691fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2024 03:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704799874; x=1705404674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AtoqUTwZLfl0KwHmLzuwT//NH99rWdFjZcUUxVIHc0=;
        b=FUlSUJPMvRE/xzNo6JzzHmjaxoWsZFzintADMVojSc9epiUy4v0APfYb+MNLz5pJpR
         8Z2ROqj79SnMX3u5CY+ZGXJQVFuCJw0V1WFf4IlIJf6jasxDgaCVyMaLxdrwNuR+zfo+
         U+sA0NBP6CPsOAGe47vYB+0fjWMdnoEfr7x289TzWGFcGfe8kWEr/S2S3auHQXeMySKT
         3e3hGM9o9JTqUrEnk01puyRWLpCkm8jhZLLNJ3Rn4YO+BBnLBDMTepY2EQxm9fID5VPM
         286XjyP+w1l9IWWNSZym/N+8VYpnkn2m+Qjz4G6lEs1ALLQU/E9Yypp6rkucvVsPShrB
         yQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799874; x=1705404674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AtoqUTwZLfl0KwHmLzuwT//NH99rWdFjZcUUxVIHc0=;
        b=i1d9BBWjiwB7o0h4jkFAJeJiRwGG7VXI+RXAFUkgCVKK1SqtAawysYvWY0woTcuKpL
         2Voue+aZR8FkL+ihLt+2B6jH9AIUucGSrGLeIHY371asGPBAgA22P1/rXLdlTyMs4bnd
         JXFt4+U8fwsog2lbDBR9ekM8HsoU1pXYVoNFaAFbycb7B1eKGRaeq+qzkTeylnVR8wOD
         iooL74yoCTpAl39iyFPfwKZ5c4sUQk4n3ONH0lejKaCDqNJOHBfys8DznflZyMGvutbE
         8pC6z5guGFWMwRy/kIZXd0Wuc5WZJMfsknRP7GGt339WDFe5NcvmXwtVLctnbetu6wdd
         qmzA==
X-Gm-Message-State: AOJu0YyGrfLksIyqhHzmLcMOH+iHD8bhQFU1J59PWkUVr7dio3KVzKPP
	iTDS5+psK0kF33Paz3yps3BxIR+7mtH/zQ==
X-Google-Smtp-Source: AGHT+IFeyakWPVTGSlb2yexBb353agn2iLP9slBWjtFFmXKMTmAlmsgVOfLhN2uL0+mAM8Cpht5rxQ==
X-Received: by 2002:a2e:9785:0:b0:2cd:d5a:7f34 with SMTP id y5-20020a2e9785000000b002cd0d5a7f34mr2160742lji.32.1704799874610;
        Tue, 09 Jan 2024 03:31:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c15-20020a5d4ccf000000b00336765e9babsm2151544wrt.83.2024.01.09.03.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:31:14 -0800 (PST)
Message-ID: <3a92f601-8422-40f0-b15b-76db3fe2901b@linaro.org>
Date: Tue, 9 Jan 2024 12:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] thermal: netlink: Pass thermal zone pointer to
 notify routines
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4556052.LvFx2qVVIh@kreacher> <1975810.PYKUYFuaPT@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1975810.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 21:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are several routines in the thermal netlink API that take a
> thermal zone ID or a thermal zone type as their arguments, but from
> their callers perspective it would be more convenient to pass a thermal
> zone pointer to them and let them extract the necessary data from the
> given thermal zone object by themselves.
> 
> Modify the code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


