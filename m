Return-Path: <linux-acpi+bounces-628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BAE7C8B8B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58494B20855
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93891B26A
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVcjHByJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1811B286
	for <linux-acpi@vger.kernel.org>; Fri, 13 Oct 2023 15:25:41 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2994BB
	for <linux-acpi@vger.kernel.org>; Fri, 13 Oct 2023 08:25:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32003aae100so2252643f8f.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Oct 2023 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697210738; x=1697815538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqiyO5h666WNcMBFY0zx+uO/TZpSzYvmxb3OC1OULWs=;
        b=NVcjHByJCWtE737XCAW5NyLyfdqhnldEsZQOu9/YQl/p6qrg/NGvoviIzidw2yrAhZ
         G87giDn0LNzm4Vi9wzkyG/KwiUU/l/mamKP+k8XF0Lp5X2jew+sySe72twBDeeQS296+
         OvhUpWlLwALfDNZph8sgTGykDtQ1XbyFS4A5eI/7HhpJhoOQdvICXU3XKDNSrrAPmD3f
         UokZPY5m0iS//GraRTR8FpNsnEWZkhbE9do092dMpUL5aYPkfGOCydu8DM/NAgUws2BS
         CpylEqzgCC4DCLpbdBh8jiF+e1s8kpBkYKMjzoRHUQZ90X+YBKLkFFXOH+t6+k+EHnsM
         Us/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210738; x=1697815538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqiyO5h666WNcMBFY0zx+uO/TZpSzYvmxb3OC1OULWs=;
        b=ODw+8p/1tMgouRvePWJgKsORMOED+18mz8r80OKlk14GaJ51PsLBT9LGCb+JserXIX
         swNgIKm/U1eEG9mLgABgNa84JL1oPbBr9ndHk5zLc0RwSgeI5CKX+Lvs2eUDsfbkgs3l
         cU2+Wmrtu4ZnB8fY7WrRZ6aEomNRpHF7oyoS1nYA7VuN+XKlfzYuKhQixfbYPYJdy3sN
         ijOcR8CURIe09ch1OVnfe7+eTAAwSFA4RrCvMOJiK2p2kRkE/7N1tStJ86WeBw1mD9wY
         3b3FLyGh+l2TBL5hqKV4BS9ywnZcCDuMCF6QJ48K0K5D5uOUNUq+nWk9Y8V6ct495q3g
         Xj0w==
X-Gm-Message-State: AOJu0Ywyl6PYm19+Qkf5/NmEEKYgGUosvZ6lA9edAkg7soE+YBSbExv7
	vJaiG0PAf16KKxRpnkAdKQOdLQ==
X-Google-Smtp-Source: AGHT+IG3Q2dwNrMf0dpK3UfqA9ZkhmleZbTUt/8zaNtFpNTgsYvyfK+j2Ev8RbzmQ/zhSYaCKQzf6A==
X-Received: by 2002:adf:8b98:0:b0:31f:f95c:dd7f with SMTP id o24-20020adf8b98000000b0031ff95cdd7fmr353980wra.12.1697210738255;
        Fri, 13 Oct 2023 08:25:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id bh6-20020a05600c3d0600b00406408dc788sm391301wmb.44.2023.10.13.08.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:25:37 -0700 (PDT)
Message-ID: <1ef28d5e-ae16-4668-8fe0-13b5521ae572@linaro.org>
Date: Fri, 13 Oct 2023 17:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: ACPI: Include the right header file
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
References: <2721589.mvXUDI8C0e@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2721589.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/10/2023 17:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is not necessary to include thermal_core.h into thermal_acpi.c,
> because none of the code in there depends on anything in the former,
> except for the linux/thermal.h, but it is better to include that one
> directly instead of including the entire thermal_core.h, so make that
> change.
> 
> No functional impact.
> 
> Fixes: 7a0e39748861 ("thermal: ACPI: Add ACPI trip point routines")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


