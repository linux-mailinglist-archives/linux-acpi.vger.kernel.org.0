Return-Path: <linux-acpi+bounces-243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDE67B0D76
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 22:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 3BFD11C209EC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127644CFBE
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 20:31:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14E3C69C
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 20:15:46 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B26A10E
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 13:15:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77063481352so622513685a.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695845744; x=1696450544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIIkMitTrNSDHIAlH1uq6vJrTxiNPJMdVtHBFBBDPlc=;
        b=ILCIx6xmz2azLwb8GDuCgY1udcz441/rPk8b1yRr6y2/jUPq9kaIcTQtiUpi/PoQBr
         Jiy7eutQj1tKuMGWCtBM1fvvFE37pHhiqpOlP0drdbTZefyQA/ZVtLZQFjTpn/Dt6xs+
         SR5TlWGMVMckSK9CGysg7BiS7w5/aH8EM4SRtm1XGhrwkmK6OItfrkwX8ksXlnBIdi+R
         74jaEDygDzGDj3hlIRT2HV53XOnelh1MwDKpvS+h/k5OBpXhIw5uHcateE6Y6Vn/SUbb
         g0TSebPomBnQN5uXSAXsW9ZDHi/GdsEfeLnkcmg/Gm5fGLX2uyhWUPtqZLPnh93g0Ygu
         k7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695845744; x=1696450544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIIkMitTrNSDHIAlH1uq6vJrTxiNPJMdVtHBFBBDPlc=;
        b=tvKBkZYApQ4no580Xb0J+ugbmy8CD5eUs7bJpCNNr2sxc2ysj20e/nFfv5wywKdJy1
         36TpkzwEgnVKCsl3lGejo0VSCX+yNtlfu8J9BJa9paMTo5P3bjrlU6XK2sKiuCqk1Hvg
         7k2rC/hYNKhVZhFiUcBT7kC3ywKxpdpJMYdwJe0Bn/eqUD3C4nW6DmP1TSTdPIzmJvNN
         UB+ycZQQPozp1qSZCR1MZ6BNFgYZqcC27JqWM804yz4hifJKNG0Cf8oWBJFzmycIC6PS
         loMlf6MsuayzaV6sImJVP85UNAX3rH6pbYAdjCdBrzrkqlVq2thXLF54IER7eBIyXFFz
         7aRQ==
X-Gm-Message-State: AOJu0YyXhlo6C+TIPAQfBxD4d1rVmfqB3UP7iNjYAVynFUKawey8WVDO
	zLWJWgSfnVU5zsiHGEPuaHkwjWmJygcJ28tQZMjrt1TX
X-Google-Smtp-Source: AGHT+IGX1XnfSRNAReG5q04YfQKGoh+0IG7R+vPK7j1BQpXrbkx9xTpzlBHu3vjoMSNDJGjhfw3g1g==
X-Received: by 2002:a05:620a:461e:b0:773:ca5c:4556 with SMTP id br30-20020a05620a461e00b00773ca5c4556mr3157567qkb.10.1695845744297;
        Wed, 27 Sep 2023 13:15:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:40d8:421c:60ef:36d5? ([2600:1700:2000:b002:40d8:421c:60ef:36d5])
        by smtp.gmail.com with ESMTPSA id pi32-20020a05620a37a000b0076dacd14484sm5715366qkn.83.2023.09.27.13.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:15:43 -0700 (PDT)
Message-ID: <23935a29-0138-49f8-9efd-ea678a41c9c5@sifive.com>
Date: Wed, 27 Sep 2023 15:15:42 -0500
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
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Jones <ajones@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>,
 Len Brown <lenb@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-27 12:00 PM, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


