Return-Path: <linux-acpi+bounces-426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D007B855A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 287A82816EE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95B1C28A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9031C290
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 16:30:18 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC8D8
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:30:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so23289745e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696437015; x=1697041815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIJySTs34JmUmNbMiJ7I6/1TQWbHfds1YxEs2wK2HFc=;
        b=tmFFOdFXRCd8xlM25wllqndrTLanxhzxnYXBl2R6zubMQUB8b7xHSIXyjoVlzQDTrm
         sRVm9xMwEroMaBAeONYmVLuuAEKdavapncUFWM1LyMXXrHlDCBjK2xm4D5KYcLpj6J7P
         BPG6mbLymcueZDmWxAcaE/t/cCtRQ0/C5mEtlx4vBg2CVhHSBuF1z1RprIJ7Wn8fJeiV
         B+v7MEAqwQn8jJnaR5PpuWhbYad1HEylW+ooDVKDYV5yXURA0RWq3WY12Hu9zKm8rEWM
         fi/zf7ZOdV6Mj+nIs9yP/p5n0JAl+pVI1B5tuVYEpFTxZgsHzW2SvUjn2eHuBc7s1q+S
         tbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437015; x=1697041815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIJySTs34JmUmNbMiJ7I6/1TQWbHfds1YxEs2wK2HFc=;
        b=PNHB85JYBz7w1aFQgaVUgsFNMc/jnQT7OfB+rO1KImWP79uLqzkIIonMgnxWVpbHM4
         TUS47OaMkmrylnhI7wvYWXWOfgycvUCug4XY/OhffCO+OZsrg0A9J8GAihS9QG959YRL
         8ooxNS8EA8HfK7DjpvLvLOPjoGLmNcoVN0+S/mTRXyaPxAptdE5tdwVNftZb9bLmhVQW
         25P1gylw5kwP7eUISUep5jWyVXOiw1v244OWcyUjr3iA8L1QGDdkGQmMMF0CFukSRulA
         fNG1ClqY6cD1Y2VORvSaVogrLdSBF9ba2xwtkn+HDwit25IG9KkHQmA01NpeM7p3Aik0
         xENw==
X-Gm-Message-State: AOJu0YxUbslp+4TSnMybd2Gto3B57yHG4G3TztwM6bIs6Jyqct9yOiQ8
	yUaAGlTPs2T090FKjKKA//u0Og==
X-Google-Smtp-Source: AGHT+IH7J/z4cjaLtMMeUDbk3FPajWRTR3LSHA+By88VR2RVrlVEvH0lmzLgNmMQ8qUBLgGR5HT2vA==
X-Received: by 2002:a05:600c:230d:b0:401:dc7c:2494 with SMTP id 13-20020a05600c230d00b00401dc7c2494mr2974381wmo.27.1696437014776;
        Wed, 04 Oct 2023 09:30:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:426:5324:c7e9:5012? ([2a05:6e02:1041:c10:426:5324:c7e9:5012])
        by smtp.googlemail.com with ESMTPSA id 17-20020a05600c021100b003feae747ff2sm1918307wmi.35.2023.10.04.09.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 09:30:14 -0700 (PDT)
Message-ID: <f14894b4-805c-3eb4-755c-4795405d7e7e@linaro.org>
Date: Wed, 4 Oct 2023 18:30:13 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/6] ACPI: thermal: Combine passive and active trip
 update functions
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <8288399.T7Z3S40VBb@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8288399.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/10/2023 15:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Combine acpi_thermal_update_passive_trip() and
> acpi_thermal_update_active_trip() into one common function called
> acpi_thermal_update_trip(), so as to reduce code duplication and
> prepare the code in question for subsequent changes.
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


