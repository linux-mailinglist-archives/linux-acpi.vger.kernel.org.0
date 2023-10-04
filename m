Return-Path: <linux-acpi+bounces-412-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1157B7D38
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 96B501C20832
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCF111A2
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:33:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BA10A28
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:41:59 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36517AF
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 02:41:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406402933edso18017525e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696412514; x=1697017314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xtvpjCwqzQ0mhQ9TCxc82QEvIPANtYiI2zXvvtKXYM=;
        b=rJxoMJ1RtB9ElSWPu1lrtx28REFXrQiNqYuGUFBlbWwzATJn/WanQIXLE8UArPbs2u
         2gOYK5CNUr/0ByfULIoQpL0Am141sKpS+OXyz2v3UQf4XJYMWoVF7z5M4b+DeqQj744d
         ktoP4aIUx14Pe74D2BIqy6XZfTfnLcN1ml+RrZvpBR7OqeY5nkqzqOT9iAnHv4JQWBpA
         WebT5i1moBsa51J1950tPGcKyBArLsPLxrgAmA9P/iHF1ccxaSvI+UrKv2BeIHS1Ds2Z
         IUtjtKsqaW0oFgoFn4S8dHIfd/68fkOfuJNTMp6csb68ubJLY7c8iQf/0kZJaQ6tWzOZ
         O1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412514; x=1697017314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xtvpjCwqzQ0mhQ9TCxc82QEvIPANtYiI2zXvvtKXYM=;
        b=tb0kOLwsiCYqpHKvNM/6sDTIi/AeE4LlNWV6ynzHoM1bKiJWPKa8xfyiDoVleVY0+9
         SpnBhWnkrF85ISuzT1X+lD+oKdYhfk4Vn35Vmx2uCr2z7cVMby5vFCxiZ3R/JNx+gbGB
         R6ZrXDodXTqi4sGQ9wzgzKLNzwV6sNdO+jcrTbvQGFlCU7OBDTTL+R/Rkf9AFuFVMXRH
         q9MKHBBa4iFElHpB4L+ExO+DiP6CrFc299bQ8nCbFAtZ5fTS6RUa26B65hTSyRcjWTlE
         W1fCMV/hkfzqPmjRK42P2zhQSAl/mtD/FzI/GUbWMRMxN8TXPE+aNIVDZdLbFT//lt9G
         cCWQ==
X-Gm-Message-State: AOJu0YxZ1h9PpUiqWREicKNLXAcUnO5n9rVjYfDzrr2C187PY7ryOlc4
	Z1Cz8cWCZS5X676rn6M5POuYXg==
X-Google-Smtp-Source: AGHT+IHYxD5P/qk5Dm3MNVUTPpqCq5PdSTeOkWPu5LFjS4FauJW+b3DDoYldNbq4SSygCnqFsG8eNg==
X-Received: by 2002:a05:600c:28c:b0:405:e492:8aef with SMTP id 12-20020a05600c028c00b00405e4928aefmr1749551wmk.40.1696412514571;
        Wed, 04 Oct 2023 02:41:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a496:68ab:9165:6f16? ([2a05:6e02:1041:c10:a496:68ab:9165:6f16])
        by smtp.googlemail.com with ESMTPSA id r2-20020a05600c320200b0040641ce36a8sm1349744wmp.1.2023.10.04.02.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:41:54 -0700 (PDT)
Message-ID: <5ea12cc8-dca8-ed6a-8fa2-9b011131bf00@linaro.org>
Date: Wed, 4 Oct 2023 11:41:53 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/6] ACPI: thermal: Move get_active_temp()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <2913298.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2913298.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/10/2023 15:18, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Put the get_active_temp() function next to the analogous
> get_passive_temp() one to allow subsequent changes to be easier to
> follow.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


