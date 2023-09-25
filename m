Return-Path: <linux-acpi+bounces-108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FA7ADEBB
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1B1AE281619
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356B219E0
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:30:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD3107BD
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 16:33:07 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B4FC
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 09:33:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so58997995e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695659584; x=1696264384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wH2q4NDrTP0nkpBNjIpNRjV2lTawgN/pnwM9yGfrd4c=;
        b=l/uBWKQ4MymajoQwF2vMmr3xfpddhzyesAmLVswoU2/ywPK35T2FByRxE8JEhBeSjt
         peEB5x4NcuQsTc4e638WmUd+/pTcI5FEfsd/EtpyG1pN52Vy4z//p2o+XwaQDHkVp1TQ
         fWN28wlDukLeH30BoYQi3ecTaKGzq1JKUsBx7wFImazLEi5ONkKGK2CobaWELJy2Fdou
         /IuiHJjhDpz87Q0KhnAFP97vKGNYH0dK6T0deXdXNstB/Wdt3Ox0aH7KwISDmwRH2+Jc
         PJY1nTLlEgJtZ3OWa6IUSjcPIKXN8rjBOqxza2ikXsjxD/sy95now7C+NcxDoStF2bnF
         Gzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695659584; x=1696264384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wH2q4NDrTP0nkpBNjIpNRjV2lTawgN/pnwM9yGfrd4c=;
        b=QNlW6YkxtIAW/2Is8mz7Zu+9ZfqrgbSAwOPcVkhqv375xLB7lBykwgy+CkjeEf1dnm
         JCU8NcPBw3VN09SCCqb53WOfPh6VSWFM1fSs7EKQM+8AtEpm06LbdqcIXnBCxzACdxHM
         QjZucUxUqXeW7PMh9CTre/IeifQzMpLxRU+DM7zXcRDEr0iCkC/0dHlX4BaDxmBtRt7I
         NE7rP+sEMSC8KV/F0RzW0oWVfjDAr1tRKW61ZNpYQ7bsMg3umNn7ekbOevoIh+LRzfQD
         6YiYKwmBy9gj4qvelc9J0vzPSr22kHu0plhBs44rL0Q9prqJ3KFXyr7nAS67kcsVoxIq
         dVgQ==
X-Gm-Message-State: AOJu0YzsmBL2Y1SKt87qayIsxoe7vgExZgymQSvdl6bGgOL4UiEBs23d
	8ibzgtZFAgV9fYxdhSTvRyrsIA==
X-Google-Smtp-Source: AGHT+IFpj/H8k5T91oUvMgi2o59IHxklRYgFKjGBIRq5HmF5ufoPZE96JMlpGweodhDYrrMQmOWItQ==
X-Received: by 2002:a05:600c:3658:b0:3f6:9634:c8d6 with SMTP id y24-20020a05600c365800b003f69634c8d6mr6183252wmq.18.1695659584104;
        Mon, 25 Sep 2023 09:33:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c300900b003fe407ca05bsm11465024wmh.37.2023.09.25.09.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:33:03 -0700 (PDT)
Message-ID: <3c3ffe47-4812-1ef6-216c-6d9a7e57e296@linaro.org>
Date: Mon, 25 Sep 2023 18:33:03 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 5/9] ACPI: thermal: Simplify critical and hot trips
 representation
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <3249479.aeNJFYEL58@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3249479.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/09/2023 20:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the only piece of information regarding the critical and hot
> trips that needs to be stored in the driver's local data structures is
> whether or not these trips are valid, so drop all of the redundant
> information from there and adjust the code accordingly.
> 
> Among other things, this requires acpi_thermal_add() to be rearranged
> so as to obtain the critical trip temperature before populating the trip
> points table and for symmetry, the hot trip temperature is obtained
> earlier too.
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


