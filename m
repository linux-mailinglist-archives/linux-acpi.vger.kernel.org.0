Return-Path: <linux-acpi+bounces-17657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E1DBC4219
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 11:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AFF401033
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Oct 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2572F361C;
	Wed,  8 Oct 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDxSCC6U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF92ECE84
	for <linux-acpi@vger.kernel.org>; Wed,  8 Oct 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914881; cv=none; b=RseEX55s+fAvL0RBuCrhmkFx+zm+5hxotUkhCU2WbVCu0U2bmVxqEU9dt9pXVTfkHIi/4AaDAw3CeKToctYn2YgXMz7tyj8iFRUtQHi8VY0IPdPItBnjN6UErjPKymfDc1U4Yyl2XW2h0uaAuBAZALMyGwZudG3XBG0j25ZJhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914881; c=relaxed/simple;
	bh=/cuF/Y4zQEjEE0Fm8le0kz3dTJweejAKiuR6VI0WayU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OEFd8T+ZaALqDBA1qadfzY8UiptM9PheT6lmp+COA0tLz0AkJawyO69nEelYzRN1mqbafHGNGHcZ88oImAKqlYcQOkUUi1FtqYKdXRrS8hIShplOPS2j2qSiMjX2V5CwPBmWEcQGzSNLL+sXOP8FUZFXTUQxWDFUn9QO9aYfkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDxSCC6U; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so1300267966b.1
        for <linux-acpi@vger.kernel.org>; Wed, 08 Oct 2025 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759914878; x=1760519678; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxM4CT53xcQl5IJ+VxHPkq3OZDFIhoxFNhkLPOnaRWs=;
        b=hDxSCC6UIwmWAz4a4d2JzPVjRgtnp/Y/26Q47cpyeL4rWWzfV85geojBXMbRrTnxWe
         hqf36mxkD/QwNjG1+axSgJEm9+INTj7YcX2zUZz9v10BdgjFXEUq/KyQkhiCRb0Oe2iV
         4ewhHSzxjHjs1+dluPiry0iz6WmYa/PElGEqqMcerCGOSAZRJsvkC87xXf4zUu26mrYG
         wtOKPZwGa157vYwCUVrLiS8lQo+BEQ3zat7FBRS54sFVHIVUAQBdNHfTw/MRj+3Z1Aik
         +nQKWVIb2RBXdHT4bEy3/OVceX8X4ST7ShCE9TAzui5FWuH5Zn2Oyr0ZjEikYXh81/bO
         thxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914878; x=1760519678;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gxM4CT53xcQl5IJ+VxHPkq3OZDFIhoxFNhkLPOnaRWs=;
        b=q2yyluye0zBhNDwmqnL21Z3ZKL++UvKu7oeiTBmKWF1v0eA4trTeMty/b0lqZIStUA
         Fp63h+XJkVNGHrgEMvyi8CLBjTrWDpcaCwbHCobBHTSNyOfuB3BfLwEPsOB3eoPYPE0o
         ep284YqQ7hc7Z4hd5P/0n+ov1Mj+edoGUVUrzxB/0qINdl+NlndAXO8Zm0oYvYeUDZBf
         R8QlT5ZAgKxAhuR6pAs4ZnUXR6/ryydFM3iTHDE2O65t0yW89GGSjNacv+xozOydUJ+t
         j/7Y0/hYuV59UJYa44bc0h/lrfCROYalUWHcmMR6g5kgc9tVGjqbHGVoA+nBlEfC9L3o
         wD0Q==
X-Gm-Message-State: AOJu0YwLASD2Khk6iIeHY2qgq137lTbR0/DEnwYNFwqRAapYeURe4qrP
	OzQsgcLNdS4ihol9QlLYzBnzljHJmodmqDOltT1XqNJNBJ5T0obylz4dQ6HKimHz
X-Gm-Gg: ASbGncsSD9+6Pz85KUax75fnotjd5a+/vBprmfSgkg+xVTKWQgNXlQErgjZWiAc4Rug
	Ad5G3AbIruLfZdKiMe3VzjTRJEasBlPPl6r768wvdWd6jLnMudKxtuB1QYzvSEXuCgE+cAwSXAk
	2B/LWx9SimFNyrYbQC4NSAa7EHakXPONJF7wOmArY0nV5L0scfdlyV4h+hQx5dybY0AKMw7dTJj
	vQQ1Jc1CCJiC/Z88b5QcQdiUiIsnGV+TAnxsNODtvAmgg5jj3IPkdjecx6wCLDZt8MNCgT3hVap
	zbrMbZAdxpJY/lRv3CnP6Cua32FYBwm4kUDMjEk4VG50HmDdjBGBeEf5HmFXOeU9tQDGLwgrZ4x
	78mVZZ/G0Q28V3ADjmPPk5Hn/Kh+9YQlkZw/X+g6OU+9uncubWKi6Hx/Xt2BvdWjGrJ75c/KpiH
	sQwDRJVWOlQPu9b3GSrDapFVMXjeDh9VUf
X-Google-Smtp-Source: AGHT+IF+TjJcFLmXdlbP1eVAPvzkVYD9k+f7UIHWq84HafHnbvRJ8EYtFg+Ns0I87W51uJ8u2zia6w==
X-Received: by 2002:a17:907:970f:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b50acd2d8b3mr236178166b.64.1759914878208;
        Wed, 08 Oct 2025 02:14:38 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ebbsm1607940866b.7.2025.10.08.02.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:14:37 -0700 (PDT)
Message-ID: <48d0fb45-096c-4caa-b51c-753c2f17f018@gmail.com>
Date: Wed, 8 Oct 2025 11:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: i2c-mux ACPI parent device references in example
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm currently trying to wrap my head around describing devices via SSDT.

While reading Documentation/firmware-guide/acpi/i2c-muxes.rst, the
references used for the devices behind the mux confuse me a bit.

The tree from the example is:

    Device (SMB1)
    {
        Device (MUX0)
        {
            Device (CH00)
            {
                Device (CLIA)
                {
                    Name (_CRS, ResourceTemplate () {
                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
                                    AddressingMode7Bit, "\\_SB.SMB1.CH00", 0x00,
                                    ResourceConsumer,,)
                    }
                }
            }

            Device (CH01)
            {
                Device (CLIB)
                {
                    Name (_CRS, ResourceTemplate () {
                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
                                    AddressingMode7Bit, "\\_SB.SMB1.CH01", 0x00,
                                    ResourceConsumer,,)
                    }
                }
            }
        }
    }


Is there a ".MUX0" missing in the references, or is it correct that it is not
present?

E.g. should it be "\\_SB.SMB1.MUX0.CH00" instead of "\\_SB.SMB1.CH00"?

FWIW, the references were changed from relative to absolute in e65cb011349e
("Documentation: ACPI: Fix parent device references").

Best regards,
Jonas

