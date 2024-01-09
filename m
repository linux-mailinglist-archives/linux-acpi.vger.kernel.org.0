Return-Path: <linux-acpi+bounces-2758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F24782850C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 12:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A345D1C2408E
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jan 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C714364D1;
	Tue,  9 Jan 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EX/hKgNg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AA36B15
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jan 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33748c4f33dso2713004f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 09 Jan 2024 03:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704799698; x=1705404498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnCEbYre5zGye06QU8T4lh4dMbpyA+aXMIBZMhzJpJY=;
        b=EX/hKgNgJaP2qCnypvuZByHyERm9M8jLMH3wl0+pAp6czoD+ZjZP2plHToEQOZY9vo
         QfNZdfVxEIh/KoDeyqnYzrQJ+zGRF8ucxVPOgCMzlwEaH3440eDdyUqIFrJ4WytWMaob
         VbMVtExYlLrrUwG2xXSU8MG924gmxICYl/ig+tLbat8ZnpAixY4Xue/dwujgyr798Zk9
         o+P2XedxBXYYjbbj8h938hWU9CuJBPY1iVGvph1OJpZNY2mehbEA8Ix1NSK9SUMdTLO3
         xvvpRFcORM9BqaFrdbfOY5tTVhesy3oAuEihPY0iUzvZqI9cAp0AFe85lUuHDTUMvFPb
         5r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799698; x=1705404498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnCEbYre5zGye06QU8T4lh4dMbpyA+aXMIBZMhzJpJY=;
        b=OTyd693d2wr9ZoheBhu1x28wI1WaRWIzXtzQyEamN0YGcDkukFba150F1LgWv7j3ve
         ALryeVuAyoLuprltDu27zvx0gGasHIshqcNoIQ4t7gkWRfwQFNvGs9BeqVemyPWOOJLI
         wwpT3JizmokmbAlkk5d7BRqvWKC+ijo1gecKfVdwZ4QJJDXxlUJUp8CrP7ffSMyLm42k
         G3vweLpRFbztvQNxjFf33nUQplar6kOiu4VBUBAgRZZW+t4pRbJDM5t06ltHOPnleCit
         +ZzMtRvqelZGctlDARKlcn+Qw6G/aAFXztdMw8U1ocbKITc429FYMDBunvhiC6keUJgs
         OhHQ==
X-Gm-Message-State: AOJu0Yz2CVm4j6JP9PXd7cSv0lGTrtQdiT+xueMA4qWQ9bW3vvG/bDaz
	fop3YWZxdzp0lE1tH9E2jOW2w6QfObevFw==
X-Google-Smtp-Source: AGHT+IH/1wMAk1aHGTdT12ROSrsiZVhUweuFKxTnb57vuF8GLwso0x6Fm7CR8XF2i/J9O/Vk1hqJOw==
X-Received: by 2002:adf:f608:0:b0:336:c5b3:6bd9 with SMTP id t8-20020adff608000000b00336c5b36bd9mr408215wrp.61.1704799698133;
        Tue, 09 Jan 2024 03:28:18 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c15-20020a5d4ccf000000b00336765e9babsm2151544wrt.83.2024.01.09.03.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 03:28:17 -0800 (PST)
Message-ID: <0c35bb66-cca1-4beb-9042-a72cc3984579@linaro.org>
Date: Tue, 9 Jan 2024 12:28:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] thermal: netlink: Pass pointers to
 thermal_notify_tz_trip_up/down()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4556052.LvFx2qVVIh@kreacher> <3295756.44csPzL39Z@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3295756.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/12/2023 20:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of requiring the callers of thermal_notify_tz_trip_up/down() to
> provide specific values needed to populate struct param in them, make
> them extract those values from objects passed by the callers via const
> pointers.
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


