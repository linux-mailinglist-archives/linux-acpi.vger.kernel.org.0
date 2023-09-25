Return-Path: <linux-acpi+bounces-98-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F227ADD33
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 60EC5B20BB7
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD2219F6
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D51C283
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 15:31:42 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D52FF
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 08:31:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3231df054c4so2873381f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695655898; x=1696260698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwhduR0PBRru9TfBtXmQap3pf9B8mygp5A+8/TOKmUE=;
        b=awwcrCyQO7bkOawFnDPA6xPJXMnMEw/6sfCd/ioG43ktoQFomEMydjIG2L+wMiz07+
         7ppkFXSVzwuygrPTBep1m+SlAjRZNw39FkFGYPPUY3LbYm4MyPsfVn00blmx16qcErnc
         wkXEpRd3sWIymEcmgI/Z+JE4SB0/C4PCOpqIxvMwhpmijPIscqdcTjC7UqjFek4+FmIs
         Rerl6NlHBmYBqBq4up0dW0f6kj1fuyIqhffCg71poBCqEYPJ3qCiaG0GGYXuYLUBz5yd
         mx3a8oCitdg1Pb7DLkh57bXWvxKwMWN2Ijn08+Pbt7yC5Hj/HDBMd/jIOtes+JZVdtJ2
         WUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655898; x=1696260698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwhduR0PBRru9TfBtXmQap3pf9B8mygp5A+8/TOKmUE=;
        b=IbOzPhf4+uqOrM44b3cvQ/4QfaOw1+Xp8c0Mn/CCKaqyLnl5regxmy+4ftwNoQDqus
         7iDHnIDwObPlxMN7YCbgHY6/ogqveZJXkkD81RTrbo9zcOmDCcE9FjbLPXDcHlPt9K6u
         jWBqOh7KowFHLzN5CUWWKHtZbJBPNx6Rv3rDfyiSBnLE4cnklHdk5qP3Tr+dkfc1dRfW
         pZo1QUptQfoeIXJDXj9WD9aT61oT+N652jFZdk+8uf0asD6XBz12IFZsKcy0w0N8OZ7q
         60mf76/kq50sMLKUa7sSnE2oULPcs7FSp3FK5wB6XkcRfGP0hRf5pynQpzc9X7eSAl+I
         SW8g==
X-Gm-Message-State: AOJu0YwfZprFRrASakXBkaYMm5GKsbLoOmLSwwW2hwgv/4lQlCJ4ExPG
	WzLjcLm0ZihFJfCsPn773KN0+Q==
X-Google-Smtp-Source: AGHT+IElg9Lgcl2vkKFmDLvL1YGhqWu9vGNT9vdBSUuBJMDElnomzw7h19XWAu7SzeScUhISgbwCbA==
X-Received: by 2002:a5d:440a:0:b0:319:83e4:bbbf with SMTP id z10-20020a5d440a000000b0031983e4bbbfmr6739536wrq.20.1695655898528;
        Mon, 25 Sep 2023 08:31:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm12144144wru.41.2023.09.25.08.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:31:37 -0700 (PDT)
Message-ID: <06ca2e6b-13ce-f097-b17c-8287e2130e52@linaro.org>
Date: Mon, 25 Sep 2023 17:31:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/9] ACPI: thermal: Fold acpi_thermal_get_info() into
 its caller
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <2296248.ElGaqSPkdT@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2296248.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/09/2023 20:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is only one caller of acpi_thermal_get_info() and the code from
> it can be folded into its caller just fine, so do that.
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


