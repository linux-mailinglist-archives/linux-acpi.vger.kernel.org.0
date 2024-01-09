Return-Path: <linux-acpi+bounces-2756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D22828495
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 12:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77561B24A86
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFD37142;
	Tue,  9 Jan 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdagC62X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A068036AE7
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jan 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33674f60184so2885640f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2024 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704798679; x=1705403479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPuw2f0lok/do/yRJgAKbKvhvOM5AdGi80autS0Z2tA=;
        b=kdagC62XBFTA0vPpBnauvPWuZJD4VKeDsfA4StCwIb6bezjmzDr5e6/ViF7ov76aXC
         julcXhroZL0eNLw56lArnGPBmISJDJISByV3v39VgtgggAGysTewbPtR1FarBcsxLIax
         q/euYamcM4anwjLkuiT1q06/bm766BpRiEEbCe6RLKq8RwRiKCX+ueXBXIUmWyVjXbCY
         zhH8fL1pJX98aFmuRU4JUqZ1f5X+mn4QdTwi2PNsk+mUPL9yXxDjks1BwB68Ax7Vsm8h
         PkAKoKYMJ++rDoT5w6A0/rhaMzA6ykSzvmn9mc3o5M3t8Xv1fP3j6W0R4RVUAJxGQjfL
         XVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704798679; x=1705403479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPuw2f0lok/do/yRJgAKbKvhvOM5AdGi80autS0Z2tA=;
        b=cMrmvZT6ED7Ylov1jIIaWwWdP985UIny4v7Sl8LMZpNmGLEPIfsRpmWo509i2fD6yQ
         qjxHxqH1g4Z5XG/KLbGAK6AbOiiIMOzfqblp628XgDDfIFed8dnnQlzqqx1j6YD812iK
         ND+8coQ2tK7TYlwrG8SBbbRHH0MpV7zxexprQ/EsxqLmKQs2GEv26FDMd56tiYsppNJ7
         UoGXHDTPT8uIZjTfFxyMoYuvXODIR//PMlOUpoBTerIEUjMwgTu/DB0+VdveOJpsgr1z
         sXEEF7sTDVaUOZ8/RvLrcrrNY7opIuB3Cy8wgTE/gO7+iDvbMfmXzXUuUzOC52ctDRh/
         g/cw==
X-Gm-Message-State: AOJu0YwuMEiQM0A+95aomkOplzgfjxBcby5nhKQhJd86koBxkbMaFM+z
	wlutdSy2Z+e8xVAaXRyjiNZgt3NYPvEk2Q==
X-Google-Smtp-Source: AGHT+IGW7Nw3UNMKqnspKJNA/b+OgjNwSMdO+rvq58lLOjMwdj3me+m0eUrVYRh7/74aLRoWO0Z0hA==
X-Received: by 2002:a5d:4a05:0:b0:336:787b:5a85 with SMTP id m5-20020a5d4a05000000b00336787b5a85mr474366wrq.1.1704798678818;
        Tue, 09 Jan 2024 03:11:18 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g4-20020adfa484000000b00336344c3c3fsm2119554wrb.90.2024.01.09.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:11:18 -0800 (PST)
Message-ID: <1b6c832c-3516-4116-8c44-f85990fb8346@linaro.org>
Date: Tue, 9 Jan 2024 12:11:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] thermal: netlink: Pass pointers to
 thermal_notify_tz_trip_change()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4556052.LvFx2qVVIh@kreacher> <2938222.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2938222.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 20:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of requiring the caller of thermal_notify_tz_trip_change() to
> provide specific values needed to populate struct param in it, make it
> extract those values from objects passed to it by the caller via const
> pointers.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


