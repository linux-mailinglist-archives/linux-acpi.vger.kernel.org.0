Return-Path: <linux-acpi+bounces-589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C017C5059
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 12:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0EA1C20E33
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609515481
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgUdK2hG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852091A717
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 09:14:59 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716698
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 02:14:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso61065615e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697015696; x=1697620496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dcsbzf8E/7eeyM/pc2wr1VcgxpBh3MPzSnBM0me6VQ=;
        b=wgUdK2hGmpNfeGpf4cOHi88ZedLhd1HBmJ1wjnV0kPJOCZsyDJ6QIHvtb3Tw0VNswy
         6JZ4tD2/vXfsDD2JIAhH4/F9TQtWaj7TF24vq8ZCPjC6ivi72XohpvYyTEt4G7HAEXCT
         GNJ6UpkTlk6lq8Bc1gWn9sZh4p3Wl0Q4/+Jw0SGYhFFKysLMyQTvYAKBrRtt8nD1BgaE
         bQw5Q1S7NMK8+BpuvUMzsrz9dQW0NCizhEAbYpNEnMu3aD10LUGbXMARzSmJwaocdts3
         o8ow2hsLIXAJgB5ycvIBjMfpHWD7+XvtYTdzxg06UH18jNwdGgC8jUMfFT+fo7s+MVgK
         Je7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015696; x=1697620496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dcsbzf8E/7eeyM/pc2wr1VcgxpBh3MPzSnBM0me6VQ=;
        b=ea5+3fnr89DDKFko8Fa5i+YruKIQwQsuh3+B6ZnqPSK6Wt1Zh4O7RKds95TsMJQU4i
         /xWB22cFdg57/he61Y4Dt6T/WT8dJbcbIXrc0RyfoMRlxsoQcYs2Za9Wi5eVB9lOlpcQ
         rbq54YxLKeZuIIN2p8rsYQal3XWzIXdKelg9l+vgjvIvu3iayq9vIfpsQzOMCixz3jmJ
         FmzXLuH13wSJVtJnnfh9oqDyVtxXez1sd6rkXjj0Jzwokedhk5EGkiEcXgmsHknf3Utp
         9Fdrinle2EtVJ5efdnJT/7mEhgFUzQF5JJxUl+B/3Kr58P5X83qEijmBG6DJc2mnE0jX
         Vqrw==
X-Gm-Message-State: AOJu0YxAx57ffFYHWqLzwEJ6NBrlyYyKiemQ2ETV/BFzcM7fuLs1o+hG
	Es4r0qwtwO7310pS1uOFpx3V1Q==
X-Google-Smtp-Source: AGHT+IFiH+YSs/NYge2HLcC7hKWSTqv0Z71LvtzWkhS94lL06dO+Ooh7J+MIlnk7hzzqpwtUN5jE7Q==
X-Received: by 2002:a7b:cbd4:0:b0:401:b76d:3b8b with SMTP id n20-20020a7bcbd4000000b00401b76d3b8bmr18890887wmi.16.1697015696048;
        Wed, 11 Oct 2023 02:14:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de95:eca9:6b1e:b330? ([2a05:6e02:1041:c10:de95:eca9:6b1e:b330])
        by smtp.googlemail.com with ESMTPSA id bg24-20020a05600c3c9800b004063c9f68f2sm13391034wmb.26.2023.10.11.02.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:14:55 -0700 (PDT)
Message-ID: <367c01e7-1096-47f2-a0da-920b0ea4b915@linaro.org>
Date: Wed, 11 Oct 2023 11:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add
 timer_cannot_wakeup_cpu
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrew Jones
 <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>,
 Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Atish Kumar Patra <atishp@rivosinc.com>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/09/2023 19:00, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


