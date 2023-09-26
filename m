Return-Path: <linux-acpi+bounces-128-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC17AECEF
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5E4FA28179F
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756C28DA8
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB2525E
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 11:30:58 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A4101
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 04:30:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso52817465e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695727853; x=1696332653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ8NWxX3XZ8O0amBBB9fjrfirMGFwy+I6ljBSmFsWZ8=;
        b=O+p4iHf+mYTPSokCOVLWZBbouNEqzZvpLJUSYs//oCs2QjVgSUYhKIxmOgFCJGfJ1e
         x9QKfVdnXAAKSNSuIuiajKbL6ypvqMstZHiS9aQXMSKeP3FGoP+POmr1Cgv5VCnd9z1P
         JWogQISp57s4HqnMv5/Vlt32qN0yIKsi7OMx6W0EvrHw/VILe0dykwTaal8Wm86e1fy8
         JtBnCZaHdSDD/fETAWftJI1Yz+ayZXP9nCVfCuPNoDdQsUQMVKifLx4YaMCbNGRZB3RE
         n1KFhOZ/P/p3CItvup0JEwFmKAQWzMD7RFGW74LLM7dIpx6zm2YekiF0Jv312MRPYub1
         dDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727853; x=1696332653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ8NWxX3XZ8O0amBBB9fjrfirMGFwy+I6ljBSmFsWZ8=;
        b=mUorx7fRBuwi04b6Rhv+kp2NBfSoqmnKKH2B48CLpcpxP4JyZPkD9GFcIC0qGZi1N7
         h+glFv0MXFQOhJVBLOOx1h6mhZ1NDNZqOT0QTm8fkEYaHOssFrhKHqJHEb3SWWwzTQtx
         RrCqpZRDWnK6MuxAtsn5ZZlFpo9puHhFG0813hayykAyXacbxzNzi7Wg6AezMB/rbLWd
         25XMp3tmRrIUFGQEqXhs02P418jQVN/Ve0XaIcQOJdXu/Jp903J7kP2fSyhDQdZH4cl9
         8PSJAEknnfvCM/IHWQYSX9oK0IcM4PV1nw7uGNJj7DqqzPeHEFhN7aOjvkNdJ1/MQDJ3
         WhRg==
X-Gm-Message-State: AOJu0Yx+m47d5bCKiJxyHvssBbu+a/lXOFtms0PAQSM84q3D+Bkw2XJ2
	6xQleSEtlW6m9zNvhoMB3ttqJQ==
X-Google-Smtp-Source: AGHT+IFI9K3AxHawduGMPqjVMpMA9N0DyVZyAB8v27F5UVumfSRQyiThJ7rvhwgT6V4mmVLgMuR3LA==
X-Received: by 2002:a7b:cc85:0:b0:402:ee9e:ed98 with SMTP id p5-20020a7bcc85000000b00402ee9eed98mr8069517wma.34.1695727852468;
        Tue, 26 Sep 2023 04:30:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id z9-20020a05600c114900b004058e6379d8sm6210637wmz.23.2023.09.26.04.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:30:52 -0700 (PDT)
Message-ID: <e3dd5e8c-7bdd-8ff5-5f47-3e3b09f2d97c@linaro.org>
Date: Tue, 26 Sep 2023 13:30:51 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 6/9] ACPI: thermal: Untangle initialization and updates
 of the passive trip
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <1942063.PYKUYFuaPT@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1942063.PYKUYFuaPT@kreacher>
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
> Separate the code needed to update the passive trip (in a response to a
> notification from the platform firmware) as well as to initialize it
> from the code that is only necessary for its initialization and cleanly
> divide it into functions that each carry out a specific action.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


