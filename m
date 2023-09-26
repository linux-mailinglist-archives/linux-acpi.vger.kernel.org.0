Return-Path: <linux-acpi+bounces-136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2217AEE74
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 88BAF28166C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717BB2E628
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:31:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7229420
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 13:46:54 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED49F3
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 06:46:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32336a30d18so1335346f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695736011; x=1696340811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCmjIQ6MlyJSHv6jxI43Wa1sDzubRKwBtVizOpgzVHo=;
        b=dlT7A5IQf8VpOgkdKYSqOJj1DALti/8yFXoLxGPiuU5ZliBFSqDM5foykDW8cuYY7s
         72mhUVIxKPmgGu1OfmDGJvVgBDNg2NoJWJTF4UBL40k4P+5zfLGT6z/sKXCY1Ug+DKfp
         aWyipXoF10TSNXdw2uXltE9Zy9CbeeRhb7yfoVhyDQbmvPctBwue4veKMeOkTlK2ptcs
         hQzSZ6H/hYoKkQdYm4ui91AXutfNWIchfB6gVbUS/+UacSsiaIZtOHMxw9ha7v4BuZd1
         gfEmvfyuem5vJTZxNCRBTnf0KAZeZN+h8xT0A168u+lE/pIhgMn21vdRAFBZiWJR9GjL
         jkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695736011; x=1696340811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCmjIQ6MlyJSHv6jxI43Wa1sDzubRKwBtVizOpgzVHo=;
        b=u9JSMUhULqD5JEsE7Gkj9VgdKvLkkO2PMLdaURGB8IVQBiEb1YU1EG2ID5CR2nb1bp
         Cpvs8ncu/9YGhJr7AmBQjdnyPhydsiDJ4XBpI6XeNJGbofcPssn9FGrbudvm9mVxDxs0
         KT4fnFaxFf3SjHNc4eJvkoGNWFjW5NXvQKgDYARwmRMr95dxFg/SoTkP/XEmbxs8zCwZ
         +1NkAfFTvlf3+z1Yhjh227xPbyrWkqzv37HqqqPZGKHrOLbVPVFAjhFb6RNMi4A/ZeZP
         qxQhOTFcYsc1ESMNR21qgnWNg8VzbkiajTkOzRAgzV6EAEkSC0a1ltkawUysBMFqdtyT
         1EGg==
X-Gm-Message-State: AOJu0Yw4mUSsXSuPD1nfa4W2bGVpYXTY5z3aL9A9TH2bO3c7OiVt1lOK
	x3fcPeFB5LRCAnUGcK08tY2+fQ==
X-Google-Smtp-Source: AGHT+IFCagExkiJZB35HCSGq4eUDCGol8kLk/CV44p2EdduLg0d6sOxBF1sH9r4OjhDw5pfEeZrZdQ==
X-Received: by 2002:a05:6000:180e:b0:321:65f3:4100 with SMTP id m14-20020a056000180e00b0032165f34100mr8230982wrh.7.1695736010661;
        Tue, 26 Sep 2023 06:46:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id m12-20020a056000008c00b0031f3b04e7cdsm14714940wrx.109.2023.09.26.06.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 06:46:50 -0700 (PDT)
Message-ID: <94e5829d-d867-8ce6-7aca-8a831054bd40@linaro.org>
Date: Tue, 26 Sep 2023 15:46:49 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 8/9] ACPI: thermal: Drop redundant trip point flags
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <3760530.kQq0lBPeGt@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3760530.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/09/2023 20:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Trip point flags previously used by the driver need not be used any more
> after the preceding changes, so drop them and adjust the code accordingly.
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


