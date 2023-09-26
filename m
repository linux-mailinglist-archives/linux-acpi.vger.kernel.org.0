Return-Path: <linux-acpi+bounces-143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A97AF0BC
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B8F83281B98
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E734193
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA07479
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 15:17:20 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0CB10A
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 08:17:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so82044255e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695741437; x=1696346237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FWdB7qhp/3C5VtANSk0XKiYCoQcsCA0ol/IvxkxQeo=;
        b=AvshJ6ESUgBnI8Ov2PCIPVkjyY1YNqZecyG9RXB4qwy6Jy52CqPyQam+14vgyz1LdX
         VlG1P+ghPv+ZJ+8hf+b/RwAc5Z9dDnZQCM7C/ZcxMiVFDMibQ9D+WTR03qhyiiOrSIae
         MolEZaaGzeDwrNH1Yw+xxIT5OWb1xuSRbRcS/NtKNTkuMz4WMCHUyJboykklmIm/lvMR
         f3R3TASw6hTMYL25+zhP6Jlc7VybKkuMdfmepSswFzMjNHs4J/RuwuFgBBHMBh0wpFmO
         IG+xP1TG0Ct7ebgSdmKq/NE6948eQXpn7kpYp8lj3WfdY5hB9+FaizFcRWxYhnoBLVNH
         Rh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695741437; x=1696346237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FWdB7qhp/3C5VtANSk0XKiYCoQcsCA0ol/IvxkxQeo=;
        b=BSic/0CH1Dr1mReGlDc6RuXyltErkL8A3o+iP0NWAdcqJ/m1Aju3hqfkJIx7OC2hSL
         6SyKRLDo15k4GkH32aDvgI72HpuGpu6NNOi5QOVT+XWvlS+zHklLZ23RaJ45QzY1Sh8f
         i2lTONGZVYv991F5XPMF1QCcNG0YQHDHDH7T7whdD0jBTLbgKaNmbolzI2ugO+ZWl0/R
         z3wL7AitL8WbizngegezjACB5Kqz6fRVuQ/QKkqxZy3WvaHXCqociOZhbx4h1PHnyt3w
         Zadb4kaZpw5+/F5vCvcqNRLpwPq80jLoXHT4G7KPvEmwnL0XtvHowLWndiIVt6kK61se
         uhmA==
X-Gm-Message-State: AOJu0YzBa5A8qeGsWmSn1uItLJhF0boyZ7i+HQOwMrMnEmvxEgh01g/k
	cK5xvLjoFokPCfclCYtZFglfmw==
X-Google-Smtp-Source: AGHT+IHsvgVlVREkoHRutvomMmLWajv1KGTWZoTcUqi819hwRXvDmOVmKuYCDaeXtgrHC/2PQzXfew==
X-Received: by 2002:a05:600c:2198:b0:404:7462:1f6f with SMTP id e24-20020a05600c219800b0040474621f6fmr9265427wme.8.1695741436758;
        Tue, 26 Sep 2023 08:17:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id x10-20020a05600c21ca00b004051b994014sm18189127wmj.19.2023.09.26.08.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 08:17:16 -0700 (PDT)
Message-ID: <0fb4f640-ad62-206f-7122-c0a3aaad319d@linaro.org>
Date: Tue, 26 Sep 2023 17:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 01/13] ACPI: thermal: Add device list to struct
 acpi_thermal_trip
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <7586104.EvYhyI6sBW@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7586104.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 19:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The device lists present in struct acpi_thermal_passive and struct
> acpi_thermal_active can be located in struct acpi_thermal_trip which
> then will allow the same code to be used for handling both the passive
> and active trip points, so make that change.
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


