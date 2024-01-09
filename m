Return-Path: <linux-acpi+bounces-2757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A174F828496
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFD92862B2
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274CB36AF1;
	Tue,  9 Jan 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4UDKeY/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AD364B9
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jan 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336c5b5c163so1719264f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2024 03:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704798747; x=1705403547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giU7yoblhm9T3wJQH8RwrG1QRyYb1G8RdgWlJJdhkJI=;
        b=y4UDKeY/LJ2ptcC0Eyh12PjSI06ULqPd/peR78Z9RYH+wTuwhAvZIomoS/fIsJO6QB
         Oz2dI/rlf7VqgWlmil004nL3hEFZwcU0Hg2alJ2ZI1jDiM68E17V7VSXn0VqTsr9AZfz
         6Qkw2p2uIG1aeFaEyJKNEnPNRHoyK78tNqBQ451dQsuTc4LTYAn10JUPgDYtfSg3Cl++
         bLeGgN+EKLANj/R/Su16zMxESAB9MHgBnBXxy3f01f8p9IMYx69Le+TV9N6mTsCGzS00
         l+2aRiKnXOFwdZ0ZmENdomgM1NkBj2gppFNIVBYdTNYsSD2656BbUwmV5xv3/PQy1ks1
         0l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704798747; x=1705403547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giU7yoblhm9T3wJQH8RwrG1QRyYb1G8RdgWlJJdhkJI=;
        b=tC4qeM53fbau2bwUeQbV0xx/8obTl621v1IkSj7paIOnE331WXRYyid13NwNmcjlvK
         qC2fGyawK7htV1hdcFl8CfOHAkMcbBjWP3SG1Vi5Zg20B8+JjPVzG41W5tTJ8sB9qC1H
         tzA92oABgFLrAKt9hVQJA+p2iCKAZR0hF1OWFqIhSKcYATSUkuX8Io1kPI8fwkX0Vu4r
         dEOw69c7PIiDJvVuHD+5TDZOHSUj446xRzIYkn6vmZHJKfc+imiuhmOdK864JGxRSr/1
         PdXl+QkFHhtCsrRmVOOSCMj/ZlDr53U826knIF9Hk9Q3ApDQqsPA2e6ngGoG3FA6K5ad
         Af9w==
X-Gm-Message-State: AOJu0YygBRCZrPKK62m6xlZ6XVqXiQwQQunNWW2XjqpcXpK7wGIajCQB
	sHkMZLFzkJ03jnT+Fg2r7N6A2B5AG2xA6w==
X-Google-Smtp-Source: AGHT+IFCM0JvaGmINta6JpEUWrb2rei4iCmFRI4ZX2Yey+JouQgZdDT94oE+JWjrzTmJWhVOgQiWuQ==
X-Received: by 2002:a5d:694b:0:b0:336:d24d:3c76 with SMTP id r11-20020a5d694b000000b00336d24d3c76mr221897wrw.28.1704798746821;
        Tue, 09 Jan 2024 03:12:26 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g4-20020adfa484000000b00336344c3c3fsm2119554wrb.90.2024.01.09.03.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:12:26 -0800 (PST)
Message-ID: <1980095c-2d3d-42a1-8f72-97962a679b4f@linaro.org>
Date: Tue, 9 Jan 2024 12:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] thermal: trip: Constify thermal zone argument of
 thermal_zone_trip_id()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4556052.LvFx2qVVIh@kreacher> <1896687.tdWV9SEqCh@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1896687.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 20:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal_zone_trip_id() does not update the thermal zone object
> passed to it, its pointer argument representing the thermal zone can be
> const, so adjust its definition accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


