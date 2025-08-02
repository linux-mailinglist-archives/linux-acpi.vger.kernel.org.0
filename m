Return-Path: <linux-acpi+bounces-15469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28796B18AA4
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Aug 2025 06:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D96564BB6
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Aug 2025 04:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1DA194A45;
	Sat,  2 Aug 2025 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L+QSlnhy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E0158535
	for <linux-acpi@vger.kernel.org>; Sat,  2 Aug 2025 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754107953; cv=none; b=WyXMMwKFySPG0OzzjjHY9UKGjpD9pdyMAYUaGBM3j9RJxk3LZ70zCpZ3lv3+J9CAb1wIFW4FmMtjtXPhj10SZNTELqY8LNiGxX9KSjlYfz9QG6mSmNtqT57xwTk4VZolgu3Sh7tQ93jziqCrN5CRXyjYWt26HlE7qYFoGijWsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754107953; c=relaxed/simple;
	bh=jiSy6EgaRG9Ud8aFoKJwA0IhJhNFA8CwUL0Sj/LVdWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyBlFvGrC4BIanj9gF1vGJ6c+boMHeQuuOev4H9iV2V4JOUey6iHcRuJ0WhAvIMqeglp9fjrhnWXAZhT6w6tIIlElmAHxJRR+P2qjpuQuHb5MTtSzU30sr1Wp/qSpZUYpWa/G0LAZKnnlOUwvd1mSzRERmsjo97mAJ4alcfUswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L+QSlnhy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e406ca2d22so7930175ab.1
        for <linux-acpi@vger.kernel.org>; Fri, 01 Aug 2025 21:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1754107951; x=1754712751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ip2rHPlCiGFGcr5YGyF7kmeRLuJtKeayor/PNig1fgE=;
        b=L+QSlnhy6ypqQOWBUSQhU9qaWdi+P2lVkRTeDvbiXhEVh1j8gr3vZ4bo/wovMmrpkm
         edSpm3fhBnetYfo+t4SKySHWSScwW6IFkj6AeE5KiuJ657Ibw9X37WWeuzJEiquet8Zx
         osRZ8esPNb5PSu6npexUrUO7PzkNP8f5KsKNqNdp9Sd8a8lHmI1bgw5/aMddsSIy1q8i
         gl2NuOHISk4Y4OSGu6GL1iIIYvJGNx3cDUTW9y8l6N1AHOBtJPOTg0/QDgDQ/88Ny/Vr
         ARUvI1dtpBKGxiXUmBbtVOtGrauDCFUpTnG/jP1UE6fAIEmqwmQyy3YaWIX91H5aBaZA
         tJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754107951; x=1754712751;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ip2rHPlCiGFGcr5YGyF7kmeRLuJtKeayor/PNig1fgE=;
        b=ZS84+UFF0iwSckW3cIMI/2IV08/0YtmKqnGN3ER4j+Ox7v3d8axqB8TMcn5PRgAKtN
         b5DP6HV2dnm/WjUIPCKCd5ywCUJa5cFDO3xTwmCdzYZS3gQmd1FGSl71rJsIBwaM3kNQ
         1GvS289Vz7pfTBWlaqwSY9qKaCkTlftigw26W0ncYaRxFayGiayhaQbDv0j+ry6+wRIk
         rmeQ4mScpMH3N2mlRGIw/YDq1DE68P5pw0XMwYyNTybolZGmiz265K1PApdNWtfAipcU
         dvi6lLH2QQLtvxQk+cFHyHB1N+LRCAQDZqml+/iojZxO1IsN028m1+ktZaHf4HaFgzyW
         ugWA==
X-Forwarded-Encrypted: i=1; AJvYcCVVMmGnz2DxZpFhoihTaWRyTdFL6Lpy/nUpqFTGTjWek00B+YKfeC6vK6Msr8CrlD9iR0lh2RLmL1Sk@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHxrCCoPF/0v7zfehcumqGMMxU6d6Ln2NDZceB1srqPBLiG1H
	PgTodqRlM9dArh7xjXPhEAV7EImR5Zzdbk/bytVpudTUQfUZEpJwA8NAjsdiJ3mtJQ0=
X-Gm-Gg: ASbGncserakYezpSyzEnVakGsuuUuiqnpN4/pL2ksXFQUkKEvzIvTWgDbkH64ohhl+P
	U6bKHl2Kh6ambhjHoHST8AoIU1iWi7D+Nxq/Pykyu+izYSO0SuHWJJiEKa/v7ssKDLGC5utyMby
	sjCRDk+DNrVYCS/L0IQjdAbOK/hd0rTDHwQiLv8vwYUouPqaa7ouXS5jk0osL4N+cyF1g4/gZlb
	Oo4nr5l/HenQaZrsKd35pLio1q7yhjhdAcHyexXC3cfpNMNgaBCCvrCu4Q/D+C8dug21tQxTO0a
	68MCmzLPTREePagL2KJUzl0rajy6EpSwtTphdmrjtupF6ig5hEMol61s/0ULYxaRR/OJntPPgGW
	66DiXfjNFtD7zVTFmM6eVamqwpOOtM93fw0SQFWmsX4L5jBLo
X-Google-Smtp-Source: AGHT+IFWXv/meUt6qnzrJTilZJBXyZAntv/HisFVx8CQALlAxTer9z3pL9Su5iQx9S/dGPdOHi5YGA==
X-Received: by 2002:a05:6e02:2487:b0:3e3:b6ab:f869 with SMTP id e9e14a558f8ab-3e416191ba5mr36293525ab.13.1754107950776;
        Fri, 01 Aug 2025 21:12:30 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.11.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55d5da1csm1652544173.65.2025.08.01.21.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 21:12:30 -0700 (PDT)
Message-ID: <612a13d3-d3a6-460b-90fd-c26e47b80711@sifive.com>
Date: Fri, 1 Aug 2025 23:12:28 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/24] dt-bindings: mailbox: Add bindings for RISC-V
 SBI MPXY extension
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
 Rahul Pathak <rpathak@ventanamicro.com>,
 Leyfoon Tan <leyfoon.tan@starfivetech.com>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
 <20250728094032.63545-3-apatel@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20250728094032.63545-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anup,

On 2025-07-28 4:40 AM, Anup Patel wrote:
> Add device tree bindings for the RISC-V SBI Message Proxy (MPXY)
> extension as a mailbox controller.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
> new file mode 100644
> index 000000000000..061437a0b45a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V SBI Message Proxy (MPXY) extension based mailbox
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description: |
> +  The RISC-V SBI Message Proxy (MPXY) extension [1] allows supervisor
> +  software to send messages through the SBI implementation (M-mode
> +  firmware or HS-mode hypervisor). The underlying message protocol
> +  and message format used by the supervisor software could be some
> +  other standard protocol compatible with the SBI MPXY extension
> +  (such as RISC-V Platform Management Interface (RPMI) [2]).
> +
> +  ===========================================
> +  References
> +  ===========================================
> +
> +  [1] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> +
> +  [2] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> +
> +properties:
> +  compatible:
> +    const: riscv,sbi-mpxy-mbox
> +
> +  "#mbox-cells":
> +    const: 2
> +    description:
> +      The first cell specifies channel_id of the SBI MPXY channel,
> +      the second cell specifies MSG_PROT_ID of the SBI MPXY channel

What is the purpose of the second mailbox cell?

The client can probe the message protocol using a SBI call, if it doesn't just
assume a protocol based on the kind of node that references this mailbox. The
SBI implementation knows the message protocol from the kind of node that
instantiates the channel (for example riscv,rpmi-mpxy-clock has
riscv,sbi-mpxy-channel-id). So this cell looks redundant.

Regards,
Samuel

> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mailbox {
> +          compatible = "riscv,sbi-mpxy-mbox";
> +          #mbox-cells = <2>;
> +    };


