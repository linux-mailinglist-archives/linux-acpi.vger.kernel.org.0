Return-Path: <linux-acpi+bounces-168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC807AF64F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 00:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6F0B5281417
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D823B287
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:31:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E5347AA
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 21:33:26 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418415EBE
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 14:33:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32172f8a5dbso8343622f8f.3
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695764002; x=1696368802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZieSTgMmUxr/NfrkjbwSgNBNg4r3Zk2KAXB7myr0pX4=;
        b=LeF/fgiUcq3PBpwMTeTs20NQ+6zTGiMrhFzQvGfQOczpdv4mB/bqLouRDav9rC7inT
         YR2FQ54CuvN836AaA5aVTi5Rm8GIEuyynMklnF+Kb6RDkxVYmMcAhwGDf6NH/+A7K0WU
         +3Y5w3MB9mkvtFLgVqXt7hzcsemtvDtoFTknkmYrX3uxKfBlolRivauc8GyFI7xiV2LP
         hsT/9evepJAG7TRVf/FEEihpLOHHiuH+q5tqB1iPB4pPumKMNzqxkLUd+oBJ5AtUW/FT
         EAhpsc312xu8C3ArStLw3v4ibgh6J5yKcSyJOTJkfkcZ1cB5/kbqbawvziF/4MeUwgH6
         LPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764002; x=1696368802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZieSTgMmUxr/NfrkjbwSgNBNg4r3Zk2KAXB7myr0pX4=;
        b=r8z5klqEyDjc9nP9KDk/T84h2Ic6306fqVxEQ2ERWmJsEBBz6JNEK0lQDV3UDvl8hi
         lBB8bgv130LXIFqqPTA2yjTniAUhq8qoZn5hv5/yzYLz101aV9odz7x4Mhx5134Xvnjt
         OlIln/3Cf7YG4NVbamMKIMkHQYC5j31go2I/2YpehY95JeBDK00ANRO6XFltCMNKkfuM
         QVVfvgPprXeKGjzdsue1hQpUhvQY0D2ZT+UsL/kJQbvfMkvrpkOUqzS5bZ9wKS+cY3OX
         zBAXScJvv5Xd3ZtptU8rx2gzkeiAUrgem3PKNRgBbzCQriUlOePzybyRtiqD8Z0yZSdZ
         McuQ==
X-Gm-Message-State: AOJu0YxH3xT0k3/idqVrlo0+ve0P4jVazb5EqGS9uR8vWNpeHUROQRfy
	t07x+7VWv/r9H43t0iW/+LFfDA==
X-Google-Smtp-Source: AGHT+IFOOMgkDp4RpIOH4fcxCTjyZKjvfOrC5prP7B4X4f0NsVWVwuRAKhYSlLCC9KDKAJF1jpA7Mw==
X-Received: by 2002:a5d:4fc9:0:b0:31f:f99c:6009 with SMTP id h9-20020a5d4fc9000000b0031ff99c6009mr11016450wrw.22.1695764002559;
        Tue, 26 Sep 2023 14:33:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id m16-20020a056000009000b0031c71693449sm15709182wrx.1.2023.09.26.14.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 14:33:21 -0700 (PDT)
Message-ID: <44f9b368-395e-eaf7-b548-7906b33e039b@linaro.org>
Date: Tue, 26 Sep 2023 23:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update
 functions
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <3534976.iIbC2pHGDl@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3534976.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/09/2023 19:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplication, merge update_passive_devices() and
> update_active_devices() into one function called update_trip_devices()
> that will be used for updating both the passive and active trip points.
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


