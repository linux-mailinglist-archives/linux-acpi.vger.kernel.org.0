Return-Path: <linux-acpi+bounces-103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C437ADD38
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 28B64281E63
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D41D6A2
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271891F95E
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 15:59:15 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5511F
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 08:59:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3231df68584so2920905f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 08:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695657552; x=1696262352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GneicmgZfpXE6hx2WHE29gWRFXhiOHILZTpcrUZlhUs=;
        b=ez8zszzp8MZEAOmQKi9v6U+nPORDhg+7ctvod5JTCbj+DMiq9qWbvI2+HfaCb1Si5S
         94NCV/fWHMKQfR4uTU22lCQyM0N5ZfSCUEZmE3aUUN09Y0v6TncwISGW3rwCpa7M0EIr
         R1DP/ZzlVcMZJRkcZ38RG0fOW1ZIQLv0T8t/WQNeuzOK5UCRRJtV+CUw6qQCQghiX5Jm
         6sWqKBhn5Kc7887kRujif8WjxJNa/WItZJTp9FCQNxkh7Z3w10tApbqdJhORa8PeAx9j
         bICj8D7xgNeqbeSCtkJcYTqMVvdoi0wi5tCnO5ZUaqfMG8zyF2efvGEyNiYl9ZRRiNQL
         dJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657552; x=1696262352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GneicmgZfpXE6hx2WHE29gWRFXhiOHILZTpcrUZlhUs=;
        b=Fxk7/0/Da0E3R3XSovMaxIY1/1lpbm3hJjSBOefCGXpZl9cIrLM48CA7IlhRzZeGCU
         vRwW5bXDkDLFcI2I/r73uZM3kOmtcycBWP8ALMMmjRe9LKzV5mjKLHKkSqgbLXFDO1FG
         8ROYW4pfiXOxAr0dKZmG3/j6PW7SL/auCLzwmyiNGxatsfhjN+F3Nv2aVXC6l8a5O3As
         oL+K2ggrD9rbuepCjH8BQa6jnjbeTQJDy4lQFE/tRDanjO7WOWgm9M51JyR45idws4lJ
         d16LjnjOZ1EhyAtgYmRGRmb6nayAhX8GVyRz61+WWGdrdShV8XXSWcORmIJXH0aQzlIx
         DLYw==
X-Gm-Message-State: AOJu0Yy7gq/hqNtzIqTaHYDj/04/twbgT4n2VezCWhQkiY1pp5qaCUUY
	+vtiBqrqi0vzVVMHDTCZVs1nvQ==
X-Google-Smtp-Source: AGHT+IHaL2nHE+gPfmVIVjPbQh46rGimWfCVGxsyc2a2vOkwGLunOTR0JtGlIvoOswcgNExhEDbq/g==
X-Received: by 2002:a5d:6084:0:b0:320:7fa:c71e with SMTP id w4-20020a5d6084000000b0032007fac71emr6996682wrt.15.1695657552615;
        Mon, 25 Sep 2023 08:59:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id o13-20020adfeacd000000b00317f3fd21b7sm12307395wrn.80.2023.09.25.08.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:59:12 -0700 (PDT)
Message-ID: <9fcd9003-c210-be46-6a25-460ad6c0e53a@linaro.org>
Date: Mon, 25 Sep 2023 17:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/9] ACPI: thermal: Determine the number of trip points
 earlier
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <1863318.tdWV9SEqCh@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1863318.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/09/2023 20:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Compute the number of trip points in acpi_thermal_add() so as to allow the
> driver's data structures to be simplified going forward.
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


