Return-Path: <linux-acpi+bounces-7559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD49513CE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 07:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC02284E6E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 05:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B1770FE;
	Wed, 14 Aug 2024 05:22:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2756F2F4;
	Wed, 14 Aug 2024 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612971; cv=none; b=Ta0a1TUWYl22HppFijWy54t7cygPC0asHMoJ700Sx37BTCLAJ2d+4RVLZFXOo8lAoVLav3mnDlu6nl04JdKkiF0HoJRKZ0tmdhKBEiFH4dameYbOlgL91QYsqU4S6kJMUWLo0UtgvAZ/c4UJotfmaCGFpTjHJU5g/gHwT1z2+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612971; c=relaxed/simple;
	bh=QOxvKD6mdRI5zUGMXtUaVqcQjFYBQSeZRXbWDE2fotk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dZMd00Ah7hO5P1i6v7cS1ODXLnkbz8dHWiVhI6TVxtmCijej84GcpABlH9Dta/W0l0ZYae30yT1kY3ayt2aHMbjhHKPZ509WJWb7KrvVveKxOHZ5FdULrYjAbD5ndXq7Ky4FpLbqawiVd4KGLfdP/IG3VOoYG3cpqtwaYD516Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a94aa5080so720742266b.3;
        Tue, 13 Aug 2024 22:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723612967; x=1724217767;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBxz/yI6iP/vJJDGJ4pN7KwEbLJNNeReRtmR06yY6Hc=;
        b=h680e8gdxY+1vVc6nB+jbC3jikZGopUbQjjmaKuPWdjjMAp6xyL8GrhwbMX+Pa4iMZ
         buohhJfoaURaRqfBaOxfWjq5/SgjFXQcjCDr3ypz8n8DJB16Fc4x/tP+W7xVMAYehVMt
         CbuvdyWb9OMSinLJQC+ZYezoFN2+jSDeD53+coB59iTf0TARcFYe0d8EyhyPxvlRX6W3
         UPGikf5wrttqJiDDDhNBaDdXJVzYSov1c43LBZ/9a27nlSt6K4MAnq95JRMfazSQWhwA
         VtGLigia7X/bOKGGYhBwAUhIdnlxh1sH5Ff5gD7XvTaDFkA6m/u3BPk7o4oD95+XCqS3
         yDQA==
X-Forwarded-Encrypted: i=1; AJvYcCWAQzJmLbL348JBsmXICQfDswNMNWw8PrHMFOUXmvPQsEm26Wp3ENIr4Wz9GNFxzIgqNVFb2xVky8nkgPBNrdb4i6I6kEVYlKiDZA==
X-Gm-Message-State: AOJu0Yye01FAhgtAqpeYBD2ewoV4my06bUmpRjgNLFBDEqEqbGsqAkQf
	To+jqzDoSzV3oYnXf2YOmKxZZucYV8H0tokfblJNU/GV8UEJuvJccFYJ8A==
X-Google-Smtp-Source: AGHT+IFkp4ZMyR031eOsGBkK52Ysok/eJv1pHfGN8G3HknAgdHQaZ1y5Ea19k9HSF1AN6A/NGlE0dQ==
X-Received: by 2002:a17:907:d862:b0:a6f:4804:d41a with SMTP id a640c23a62f3a-a8367026b4dmr110999266b.55.1723612966965;
        Tue, 13 Aug 2024 22:22:46 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e041sm127289266b.168.2024.08.13.22.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 22:22:46 -0700 (PDT)
Message-ID: <60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org>
Date: Wed, 14 Aug 2024 07:22:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
From: Jiri Slaby <jirislaby@kernel.org>
Subject: ACPI IRQ storm with 6.10
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

one openSUSE's user reported that with 6.10, he sees one CPU under an 
IRQ storm from ACPI (sci_interrupt):
    9:   20220768          ...  IR-IO-APIC    9-fasteoi   acpi

At:
https://bugzilla.suse.com/show_bug.cgi?id=1229085

6.9 was OK.

With acpi.debug_level=0x08000000 acpi.debug_layer=0xffffffff, there is a 
repeated load of:
> event-0188 ev_fixed_event_detect : Fixed Event Block: Enable 00000020 Status 00000000
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 00: Status=00, Enable=00, RunEnable=02, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 01: Status=00, Enable=02, RunEnable=02, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 02: Status=00, Enable=00, RunEnable=02, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 03: Status=00, Enable=00, RunEnable=02, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 04: Status=00, Enable=00, RunEnable=02, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 05: Status=00, Enable=00, RunEnable=02, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 06: Status=00, Enable=00, RunEnable=02, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 07: Status=00, Enable=00, RunEnable=02, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 08-0F: RunEnable=00, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 10: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 11: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 12: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 13: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 14: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 15: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 16: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 17: Status=00, Enable=80, RunEnable=80, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 18-1F: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 20-27: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 28-2F: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 30-37: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 38-3F: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 40-47: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 48-4F: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 50-57: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 58-5F: RunEnable=00, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 60: Status=00, Enable=00, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 61: Status=00, Enable=02, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 62: Status=00, Enable=04, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 63: Status=00, Enable=00, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 64: Status=00, Enable=00, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 65: Status=00, Enable=00, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 66: Status=00, Enable=00, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 67: Status=00, Enable=00, RunEnable=06, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 68: Status=00, Enable=00, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 69: Status=00, Enable=02, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6A: Status=00, Enable=00, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6B: Status=00, Enable=08, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6C: Status=00, Enable=00, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6D: Status=20, Enable=00, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6E: Status=40, Enable=40, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 6F: Status=00, Enable=00, RunEnable=4A, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 70: Status=00, Enable=00, RunEnable=0E, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 71: Status=00, Enable=02, RunEnable=0E, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 72: Status=00, Enable=04, RunEnable=0E, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 73: Status=00, Enable=08, RunEnable=0E, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 74: Status=00, Enable=00, RunEnable=0E, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 75: Status=00, Enable=00, RunEnable=0E, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 76: Status=00, Enable=00, RunEnable=0E, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 77: Status=00, Enable=00, RunEnable=0E, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 78-7F: RunEnable=00, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 80: Status=00, Enable=01, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 81: Status=00, Enable=00, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 82: Status=00, Enable=00, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 83: Status=00, Enable=00, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 84: Status=00, Enable=00, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 85: Status=00, Enable=00, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 86: Status=40, Enable=00, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 87: Status=00, Enable=00, RunEnable=01, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 88: Status=00, Enable=00, RunEnable=04, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 89: Status=00, Enable=00, RunEnable=04, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 8A: Status=00, Enable=04, RunEnable=04, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 8B: Status=00, Enable=00, RunEnable=04, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 8C: Status=00, Enable=00, RunEnable=04, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 8D: Status=00, Enable=00, RunEnable=04, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 8E: Status=00, Enable=00, RunEnable=04, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE 8F: Status=00, Enable=00, RunEnable=04, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 90-97: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE 98-9F: RunEnable=00, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A0: Status=00, Enable=01, RunEnable=87, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A1: Status=00, Enable=02, RunEnable=87, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A2: Status=00, Enable=04, RunEnable=87, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A3: Status=00, Enable=00, RunEnable=87, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A4: Status=00, Enable=00, RunEnable=87, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A5: Status=00, Enable=00, RunEnable=87, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A6: Status=00, Enable=00, RunEnable=87, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE A7: Status=00, Enable=80, RunEnable=87, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE A8-AF: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE B0-B7: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE B8-BF: RunEnable=00, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C0: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C1: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C2: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C3: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C4: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C5: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C6: Status=00, Enable=00, RunEnable=80, WakeEnable=00
> evgpe-0673 ev_detect_gpe         : Read registers for GPE C7: Status=00, Enable=80, RunEnable=80, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE C8-CF: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE D0-D7: RunEnable=00, WakeEnable=00
> evgpe-0396 ev_gpe_detect         : Ignore disabled registers for GPE D8-DF: RunEnable=00, WakeEnable=00

Longer (yet still trimmed due to pace of the messages) log:
https://bugzilla.suse.com/attachment.cgi?id=876664

Any ideas?

thanks,
-- 
js
suse labs

