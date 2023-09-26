Return-Path: <linux-acpi+bounces-134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67807AEE72
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 787232816FA
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3E28F3
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:31:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694652770B
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 13:05:06 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F1101
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 06:05:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40594697600so36343155e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695733501; x=1696338301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUDqzgKzbv3Gg1WyHYLHJCasPYrE5OE5lNvp2LrCBsI=;
        b=Z6iQd7/7LL17In5CREozElEuYlrtbgW3E6GV8cU/d2xo3Aq7zNPKQwbwbVCSJRcn9q
         JZCBMChsW2iOMMsh6zhC8n5oBSdo7WWoSY6k9JjK5c7Dm7MZ598TEC6mi2DICLD1jdmH
         tSIobbXID7ARx2oVYk29fTA6a/08lt/mCmsw8uz8sEyC62EGbjmo09YLdKhZpNDXQyTR
         SL5FvZlCfaRZfxbpSjuVJvf39fc5O4T/A81PXMWnz9F3UrYU1unPCkxQIpIajoaznpKv
         BjuNwDxWzZbaT6Rj9gAQqmpzYllDMvxoMKS4YdZYa1ECHBtvaYmXz+aqk4NXyoJZwFHj
         bCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733501; x=1696338301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUDqzgKzbv3Gg1WyHYLHJCasPYrE5OE5lNvp2LrCBsI=;
        b=IFx9e8qiFBxsbruoP+7pBcBpFwEH8dQh4Vq4uosKjDR8Wk3bmpFYLppzeQ5G6bLFPF
         Jh6kkawzzQzPbx+YYWyjmBIaeHu+UqyQGwBLQgcZs12zHdR2tDhaehhCAvhHtUMETq1F
         wchROmOw7KTY79HxR6WYYS41DeFKYwgkSQ8KCeLkvzm5zlArQ9Csu4Q9ak8cBioPBqgA
         zfNKz4xLe9WJtwQAUhwXLYmq8nUXULsuRSZNWdsH3oOiMp07/ily/g8Da0nhPDEheQaO
         abkmTGeHRKiUg9Jx59kAN3+kWNRz1Iqsz5aWyygYYm3ZCY7PvCZQxN/vs2tcQzwOf3nT
         7Ksw==
X-Gm-Message-State: AOJu0YyXTOYNEzPXwZBR/g90Y2amPF8Yk0CkkTg+u/2JE0vmmbAopJkb
	bUtmaO5kcC1qwRuPJlDIRi32CA==
X-Google-Smtp-Source: AGHT+IEFUIftfFnlxqxC3wkhyOmlpvv9lNkeHx563zR0o5R8xM6Pg3jSugWsd4ebp22q79f/MEZ5hQ==
X-Received: by 2002:a7b:ce92:0:b0:405:39b4:314f with SMTP id q18-20020a7bce92000000b0040539b4314fmr9421511wmj.24.1695733501384;
        Tue, 26 Sep 2023 06:05:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id g10-20020a05600c308a00b003fee8793911sm11724064wmn.44.2023.09.26.06.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 06:05:00 -0700 (PDT)
Message-ID: <3137cbd7-8c6e-486b-6572-33990b930bac@linaro.org>
Date: Tue, 26 Sep 2023 15:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 7/9] ACPI: thermal: Untangle initialization and updates
 of active trips
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <22010294.EfDdHjke4D@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <22010294.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/09/2023 20:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Separate the code needed to update active trips (in a response to a
> notification from the platform firmware) as well as to initialize them
> from the code that is only necessary for their initialization and
> cleanly divide it into functions that each carry out a specific action.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


