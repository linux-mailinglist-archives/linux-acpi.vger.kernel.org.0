Return-Path: <linux-acpi+bounces-186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F0A7B01FA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0A9C1282AB0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D181C2B8
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47B290B
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 09:15:10 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE22E139
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:15:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4064014bca5so21707695e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695806107; x=1696410907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQteU9pTpx/ahIZrbklTplbazA8QXQaSLA02EVq9mDk=;
        b=ApvVHJGq6VrYiu1ih883CsWuuc9GbV5pnkK5a4w21mwWEQxdPO6qynjcw1zJRvL/q1
         IRsn3Zn22cgdJGwd3j08u8AoGFoJitzxI+sRqkP2Vm/vJpKHvWpNbOOv6N5mSMbbKgD9
         DHNF3lm1BTRkIWNkCjgp1YjjxC+PzOsovuemi9cqQx64JUBjlwqnPRf3YhtMvPooSLc+
         ACzOt7rjdTBqNh5Uaff4gpSfYocANmcka5ihxp3imjTl1jstken6EWg1ComMdMVLB5vJ
         BogRw/vaDh/tuEbPrFppODp4rhu90PvOv1aDPm6rH3+wNClMZzUdct/ByAXNdp+oBi9O
         aNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806107; x=1696410907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQteU9pTpx/ahIZrbklTplbazA8QXQaSLA02EVq9mDk=;
        b=XVddfqPS+URcpYyRKckEGsZTNu3Qgts+X200tPesk6tnjmr/5XiR73oOKTQE/lcn0/
         MgX/ow0vERe9ym4ZZaHhqdC7HugvYIE0725PBjHEPLjWWo1QK9myYDTuhWcrOkCiwsLm
         7iUxa6iRp0LkklJZXDXp4S+8ndrw2rpcfC5Rw6VX2nSa6jPH+m2TQ/pwBR+CtRD9VPVu
         vVKbf4WHygkgTdGR7mEP9mhGGRTan9XIduJIwegeH8OMd7fv2sBEmYai+RIzGBhU0+s7
         LeCfShQlyQaWgdNmw8lwLfCIOnudd1Ot+MgaHE8Z25E87nrX3y+udROxxuyBYXGA8OUx
         hc9g==
X-Gm-Message-State: AOJu0YzJ/bEETggah29iXvdWCCkyCmxGIlDQs7vRii3Hok6IZMG7opFs
	uLuX9yn8b4A83nxYIUEU4/U2Ww==
X-Google-Smtp-Source: AGHT+IERHdps2mDqYu+cJwU2VeQoE7qdSuzm9UauaAFviG9kxq5YZjOrjV5XMnvlUTwUvHfW1jCUkA==
X-Received: by 2002:a7b:c409:0:b0:405:1c19:476d with SMTP id k9-20020a7bc409000000b004051c19476dmr1337246wmi.39.1695806106621;
        Wed, 27 Sep 2023 02:15:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 4-20020a05600c22c400b00405bbfd5d16sm5076799wmg.7.2023.09.27.02.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:15:06 -0700 (PDT)
Message-ID: <28a739a6-b3c8-6d7d-3eba-3bec41cd4b1e@linaro.org>
Date: Wed, 27 Sep 2023 11:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 03/13] ACPI: thermal: Collapse trip devices update
 function wrappers
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <3198428.5fSG56mABF@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3198428.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 19:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplicationeve further, merge
> acpi_thermal_update_passive/active_devices() into one function
> called acpi_thermal_update_trip_devices() that will be used for
> updating both the passive and active trip points.
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


