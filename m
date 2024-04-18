Return-Path: <linux-acpi+bounces-5166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D046A8A9CEC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E98EB27DB4
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053816D4DF;
	Thu, 18 Apr 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GTbpuzB/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1181165FC7
	for <linux-acpi@vger.kernel.org>; Thu, 18 Apr 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450056; cv=none; b=ZTKWqeU+9NVVIvgiOczX9aqxFaHFttf9Zcq4+OUKx10dVupOApMpzqQPF+WP75DNxwnZB/TuAu66LBIQh4t2KZAAe1q/4O4tArK3ttBWaOo6GuSPRX/rOGUdjWvqYxoM6kpGOyYlj+m0wg6AeQX082RvA+kinfjGuYqIAU4r2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450056; c=relaxed/simple;
	bh=gAa7Kq1mYFyz8jqtnXVIe79COqi9Rf6W5LHAFGe3mjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mpnp8HVDxN4UHL/qDv9yBSaRNtkmF8UeuI3Kjubtm1VrR8E76+3S3zHGxTQSelRH1eAoXPtkqRpWn0pzZ+TUTtw91v6PMi3gKLPwRv+imZgsoopcbXgDRP/6E4mdD/+zDhlZYkDy9FakVcIsVj9AVAE9b5ShvMGeeXAPwaZdWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GTbpuzB/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 495204017A
	for <linux-acpi@vger.kernel.org>; Thu, 18 Apr 2024 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713450051;
	bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GTbpuzB/h2uitfvhaUFa4LOPITpsbr+XDSGPySt/gvU4/8IayWsBaTxRIdj7En4Vr
	 P61B8PnuTx6S8mdx0o8yOoLxhZyLbfaf1Cq7yyd1lXQf+r1luvX2vvHaEzB6q3+ZOr
	 OtUYm0YzAob0q9Gy07/lsUn6gzO/SCBVNoepPiDpGxtXsz8ZgI93IM8nd4FRr7yaVm
	 1ZnNWUpiruSdCtMgJOoLFZNMfYs7Yj87GAWhoxGcK9cP29IIJ+Tw/lNIMGr1DC2tI0
	 TgARQbhmgjnAudJ4AjhkOiNSK5z/3Kj+s2tNUs5ChZPy+5XNqQAChkscEl0Bgd5XZp
	 L6pQ3wST3/M+A==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51aaee20733so44762e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 18 Apr 2024 07:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450050; x=1714054850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MdH0R6Fh42BcaDDw8FV00JACUmgNVaSlcHYQMVpZWk=;
        b=gekntfkNf6QmbxZOZ4dt80XReAm+b+01dfeK6CPhEPHOov+N0ckGMqbXSsWQwM9spo
         x1aJeHPbLIh/0qJwuuFKA/I7Wee+yUqVlZLz9Nrrsf43z6v4bBJwSpkpa4GByIqJr7C+
         wgl3okc2aQybcyY4dE8LRkpLxZRiSZZO5WLnX2WmeO3nTmC824bhhNT6Y2J3NV+LZuYV
         FuWykZ3wgj+/oGxttHmUJ9/3DoEbeKE69kvZEJwx2N/tnkpumJZzkDxBENTvwgz57XUc
         T+uMNU5mnh6HCc3UmO1ACwY7bFcFREvc5S7UpWsiR8z1vALhEhzJsCaPgTTinuFqoUNz
         W9yg==
X-Forwarded-Encrypted: i=1; AJvYcCXu/JtQP4BnrPi9gvH9VIG+o6nNMDTkUmy+xrRgMqMpFmpTv2VXOnQKfY5cE8bEfmba7UWAL/vease7epd0dleTNlp9KdG4MJ48ZQ==
X-Gm-Message-State: AOJu0Yxa5wXBtsVgAKcrCByIPdfaQlxQEOLuYD3pVl9IjlQrsH885MKv
	dO66o+GZHknf19hR7S1IH84lBWmt6eMCXN+2PdInEGL1mNSLY57mXo/ZzCs5d4UR+2sDnYNZUnP
	tSOKu1By8NXPrav+Z3Z2o0h6vHnIgThXdVnbHs3389TsJo7bOnRXUaWtgAfgWRPekn6L/9kVmo2
	s=
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340919wmq.40.1713450029761;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT2UI5195uUHY+LxtGsmAza41kuNxu3PsqfU28U6vm2gIhE1ZKzhOvItctvv3fW1IYrvOjmg==
X-Received: by 2002:a05:600c:4e87:b0:418:d077:2cbd with SMTP id f7-20020a05600c4e8700b00418d0772cbdmr2340875wmq.40.1713450029353;
        Thu, 18 Apr 2024 07:20:29 -0700 (PDT)
Received: from [192.168.123.126] (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00416b163e52bsm6658726wmq.14.2024.04.18.07.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:20:28 -0700 (PDT)
Message-ID: <ef065a0e-1996-4ca2-b6f0-3a152edd3540@canonical.com>
Date: Thu, 18 Apr 2024 16:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>,
 Robert Moore <robert.moore@intel.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Andrei Warkentin <andrei.warkentin@intel.com>, Marc Zyngier
 <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>
 <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZiEnHtWbT04bXYmP@sunil-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.04.24 15:58, Sunil V L wrote:
> Hi Björn,
> 
> This is cool!. I was not aware that u-boot also supports ACPI on
> RISC-V. Many thanks!
> 
> Thanks,
> Sunil

For RISC-V and ARM we have

* pass-through for QEMU ACPI tables
* pass-through for QEMU SMBIOS tables
* generation of SMBIOS tables

Generation of ACPI tables in U-Boot has up now only been implemented for 
x86 but would be feasible for RISC-V boards too.

Cf. https://docs.u-boot.org/en/latest/board/emulation/acpi.html

Best regards

Heinrich

