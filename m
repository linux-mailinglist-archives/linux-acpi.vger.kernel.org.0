Return-Path: <linux-acpi+bounces-282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4BE7B2C51
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 08:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7FDF81C20959
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A87C128
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 06:31:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E768F72
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 06:30:11 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA71A2
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 23:30:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5033918c09eso21697389e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695969008; x=1696573808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8B9U0J03v9W4gmh9II0yrpUaLY38JPff5+I8zBDe+g=;
        b=RUrK9O19upc+H6Fr4LpZ/zd/ZrOeKbwwwPH8KqXTCXGzTkhfNvFd7WnvTSp1iqmw8B
         bRl8nI1+R9mhkOsIdL2WjVS6auuIrTtE+cX94Qf9mikKchJaBfx+u+l+yvhrWjWQxq4y
         ivuaEzseYqWrTZNxlD3YKAUo1+8IEdFQlogLHCFIE5VX8q6hIIHvGSoElsLUt4aHKeip
         hER5jlffgMQOq0DfTjRDP/TqGd9d5tZgleX0ckuWYHtI071BVN2O44aRZLvXkPu6Yz29
         Fiaj3GpHOmLrCONT2wCxGw0ec5iwGJUV+KnrQLT3gQadE+fZ4ibAla9IlcZUYsgb4N0W
         IXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695969008; x=1696573808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8B9U0J03v9W4gmh9II0yrpUaLY38JPff5+I8zBDe+g=;
        b=rn8f15AjOlZtqex1LdoQXHYstxlXLBC+qKcpm7Rb1BklwQPXRlCJVO3Kf/uVFIwb+6
         ESkZYFEsTsvteNOslM5FLKlwaba/gq/qZtnzdRQRVUdHbdIQxwAydbPJZyqPwsWXiIMf
         KHvAWW1iD3c8cqjLZrj3uHiJmP0vzSolzTa2VvcrS9yCLycLmFdDEioxSt3t4MRqfS/8
         ZKhBRn2u9RKLaqYjuzjWRaIebTj2y1kAtUefpfMeADsHTKzccagYUHjQpJVl0OOGKOUN
         dKTWZgGWeZegZYsNBozWYXrqGDtFF/oePACGvQqwvmfeiZC3UUg+CqqQFdLRFKRr/ys0
         6qTw==
X-Gm-Message-State: AOJu0YynKUBFbkSsLTxxM1eEAvQot/sBHiqJlOd1eH2tG9BAcWEGbpUX
	G4f3PEuPBm4i804EYErcZJwW2H8prH3VyQiwXwI=
X-Google-Smtp-Source: AGHT+IHLZnh0NqyTg1Kdur6wnM9TSTcEAapIYnlDf2JcJPIh701wlBLegZxwHVbibElyKi4ZGrPDNA==
X-Received: by 2002:ac2:4bd6:0:b0:505:713a:4bb8 with SMTP id o22-20020ac24bd6000000b00505713a4bb8mr397240lfq.27.1695969007058;
        Thu, 28 Sep 2023 23:30:07 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id k15-20020a7bc40f000000b004013797efb6sm745516wmi.9.2023.09.28.23.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 23:30:06 -0700 (PDT)
Message-ID: <d1abb7e6-c71f-faef-3488-4d723d3d9e17@linaro.org>
Date: Fri, 29 Sep 2023 08:30:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] ACPI: thermal: Drop list of device ACPI handles from
 struct acpi_thermal
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2725347.mvXUDI8C0e@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2725347.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/09/2023 20:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the list of device ACPI handles in struct acpi_thermal is not
> used and drop it.
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


