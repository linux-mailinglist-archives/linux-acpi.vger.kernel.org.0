Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1764F724977
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbjFFQqR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jun 2023 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjFFQqR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 12:46:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F34E79
        for <linux-acpi@vger.kernel.org>; Tue,  6 Jun 2023 09:46:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso64645245e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jun 2023 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686069974; x=1688661974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+bDzolSmxZz+ENMAgHkS8Ql7yhHkA2P8esxqkurY3o=;
        b=Iqah33xqQlS0IRRSvFClh+WMAtloJtKOfmAEbCzSqDAz1bOVPmTB7AFJMLYAt/FOCt
         tfvk0BVaJHQtYnfzQec8maXVwIAqXA3WoHEyJ4/3zqmKNAbZR5MQwXoZ1Eq0XbF6RRos
         HOcBGsRYlYX6WllZ5GnUFHnBgHN7KSY5itVbJYxgSkuScC57LC/ymYPCHjiTsfgJDH3X
         oEzuGlzNdnNGRHbMupKMdTVzIWJ2hYyd+IKNRsJP/Q/NFYLXQ+NjfhmB8BrTpdrzrPJM
         aX9Q7hye3MfHQ4OYUKnLyM+vl6DW5NR5rnM/bmWNFseaUluN2CUwDW4/e5IQVVmVCWcO
         sTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069974; x=1688661974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+bDzolSmxZz+ENMAgHkS8Ql7yhHkA2P8esxqkurY3o=;
        b=YsD1EDy3UbFyupJgnm3gA4FAsiZJfkhAZ9bIUmPlO1e9kwHvYm4kcWeG2ZgvzUcxjn
         JxHN8L8oBkvZbA7kg0FRi5UAXpE4KlnNrTr0TkL3X14XbdegUMFsCqc534Vbpe0lIeDs
         idHTkZG/17awn8LyBOFYB8ED669X+mD3IoQaVKs+OEfV7N1dT31peYgJskMPr9b4F2bK
         jDP4VdVOUlhLyZiz/qP+dN8DKt+cv9awZ540d3v997SVyh/MTuOEHvpjOLKAAYDnMV9P
         EJZ6GWBVtHkwmf/0/WesPJdjK3nxUR9Iy9ce3nSpQj4+hkfq65KoSnDtsb2F0+IR12fV
         wVgw==
X-Gm-Message-State: AC+VfDyyRsH9dUUGZejbFB7hiZ9v3O2Y6O63r018Efh7nIMM14MIiwwg
        OjfKgBTQVBwmQGOwIr0fjnFldA==
X-Google-Smtp-Source: ACHHUZ50A1wYWKsWzpXlsWaRPO00apg2Ow3LqIZLHfne3DFaLhrjsCy8cvh1ctUbEx8UeXu1ov5kiA==
X-Received: by 2002:a7b:c457:0:b0:3f6:f2b2:15c9 with SMTP id l23-20020a7bc457000000b003f6f2b215c9mr2880678wmi.37.1686069974068;
        Tue, 06 Jun 2023 09:46:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id f4-20020a7bc8c4000000b003f7e717c770sm5031876wml.23.2023.06.06.09.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:46:13 -0700 (PDT)
Message-ID: <4462e01b-1e45-3c85-69c9-576a7f543512@linaro.org>
Date:   Tue, 6 Jun 2023 18:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 7/7] ACPI: thermal: Drop struct acpi_thermal_flags
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <2581616.Lt9SDvczpP@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2581616.Lt9SDvczpP@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04/06/2023 14:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop struct acpi_thermal_flags which is not really used (only one
> flag in it is ever set, but it is never read) and call
> acpi_execute_simple_method() directly to evaluate _SCP instead of
> using acpi_thermal_set_cooling_mode(), which has no callers after
> that change, so drop it.
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

