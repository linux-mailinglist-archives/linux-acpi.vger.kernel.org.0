Return-Path: <linux-acpi+bounces-191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8469F7B0430
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A20CE1C20A03
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799AF1FDC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:31:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9D6D19
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 11:58:18 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DAE12A
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 04:58:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb94eso110331595e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695815894; x=1696420694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxBT05QSaKYLy2VHz5mpN5js/FV2wLDKiGhrnovBJpM=;
        b=xq/0WbYP9QsWTd/8pk7bMcHl22hgLbTMarCfwcQdshQm+/YYbC9rA22lbvaVhSCEwa
         R6uZ92je3wppp1tmdauk+duYzNSFECL4EtbzlsPk6P1VM23VJm6396+Yc2TL/gxBBz2L
         7R/ZYGhWb6n7E0VXvLasInqSlgfYm/DT7pxB3+HveBD0SCO2e0Q8YWeTJmA9X2m9jMS2
         A44wOstRnEQ7x8Q82+8sJ+nF5UaDwVZ2g148cyLJhyewKBfXj1rndI+rSJCI/mE6wffJ
         qURG9uxMCxeU9w4kiDlaWN3hjn8FzXK/4BRCAXL3mUdOaP2jZ83A8PhXYqaFENuNKLDz
         Lphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695815894; x=1696420694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxBT05QSaKYLy2VHz5mpN5js/FV2wLDKiGhrnovBJpM=;
        b=LAprnjWyhNZcOL8GrjuuwixhGwU0PPRmbH7dp5kG4vPmRw5fZ55lCGRbHwUawiIBo/
         sQpLGz/ExRaegiaV7Bw/knlY2zS0pvLWbWx0mPH6asu/z7HaT3r908ZSNF5Qs6ioLs4a
         Sh2vIce1QMCISNDqCOEfQluE0wU8NldCpkuhZ2FWvH6xVR4Es2P+dNTcHXrDAWTgSZ66
         h8j0+O0SDRrVvTOp9Wgdbqv5Y9l7oJkTPrE499z9B6arS9eySKvZ2VvUHGgCwQ3Uue/7
         8klpbqo9KbhxyjkuY3fKJTyWXIhE/5j3u0LniCruB0bNW8Im32gZDfieEoaDnDBV8h7p
         CDsg==
X-Gm-Message-State: AOJu0YzlZiXf8QLxLtI5WepoAYOOwCGddbkUlG/PoUTna9ywhNsTaALC
	MOiyWYx4vCWtmsYOiOF3EaDBGA==
X-Google-Smtp-Source: AGHT+IFC1nJTi1+9q1YPtODs3+1SqLVX/KlO7kVRVqmPJV7UgGFXZDSWD24bnnFuSRUjHFEAaPNKhA==
X-Received: by 2002:a05:600c:28f:b0:405:39b4:314f with SMTP id 15-20020a05600c028f00b0040539b4314fmr1966413wmk.24.1695815894432;
        Wed, 27 Sep 2023 04:58:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id t21-20020a7bc3d5000000b00405c7591b09sm5389181wmj.35.2023.09.27.04.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:58:14 -0700 (PDT)
Message-ID: <704d7983-16e0-a614-7db8-b1c71859800c@linaro.org>
Date: Wed, 27 Sep 2023 13:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 04/13] ACPI: thermal: Merge trip initialization
 functions
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <1785516.VLH7GnMWUR@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1785516.VLH7GnMWUR@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 19:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplicationeve further, merge
> acpi_thermal_init_passive/active_trip() into one function called
> acpi_thermal_init_trip() that will be used for initializing both
> the passive and active trip points.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


