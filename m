Return-Path: <linux-acpi+bounces-1261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB97E26E8
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43125281471
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFC28DAA
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbmUsbAW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0482374A
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 13:32:21 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E827A9;
	Mon,  6 Nov 2023 05:32:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc30bf9e22so35329045ad.1;
        Mon, 06 Nov 2023 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699277539; x=1699882339; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jT3DhaF8Ow4N6+nNljPzGs8H83Pa4BYmAvFBXlx8Fg=;
        b=TbmUsbAWRlNfkC1x9pOsblUmGVoPpR4PKbaG9ty64PYZWJ2+x5JTQprk0vBP3K4Ibm
         DhPNbZaqFCgzsqGl+uafBtFt7LIgyQXpQmjkCsUqc5yDPw+54k6ROg19xRHtxwME8QEc
         6IhMPZthWLi9+pfNoVvMVp0iAAer4+DAaOk7+xCce3VTVZkg1SlKPvR4Io86iSQNLoWS
         qm7l7DdauJtYBjmwmh2KZ1d3hlYjc37NHU3OhaiUxgn177Yx3b//QAoD+Fin9tS1+8KR
         mEiUlKe0LGSKUBYuI2Pfc1RvcaCK7YIKnruuBTurAxgd1JIXsQjsy+3KW7OMzxCNGaP/
         nsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277539; x=1699882339;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jT3DhaF8Ow4N6+nNljPzGs8H83Pa4BYmAvFBXlx8Fg=;
        b=aPdpyGOIWCL738BCjoh3TCndl+96WZNV6zRDJ/XxTRSjfk3P/A5LouamqAZ5sTia34
         OIrVgzPz22RaMk+6TaYmmjXPfITXBaXwb0oE2KshRfIilBU2f0st1u0qDB96d/pVnA4n
         Fcnlm6zy11j5H+dPcREGoVDn9websvLrl6aaRowvkFygVFyvs6sMmO2NR7QxkMheJP7H
         19EcGAya1t1Fc/iA/Ulh9feHzmGikz9X/842uvtXwe0vYLKWqC3qFJ7L05ER/jukX5KZ
         dkkeS4uYCbAgUOWRksqOsS8PFl5jv7ye1F1E40AE1f6TKeCuHGv1EugnaTQjrGUF2i4y
         zTMg==
X-Gm-Message-State: AOJu0YxvK2CapWe6bwWwTanyEn9+ND09g1oMTLGl8CwRvA4POmrW39W9
	DY09tx6l06yPdpVolwBpel++YIWDt50=
X-Google-Smtp-Source: AGHT+IGYQPQZCO7Y0BbQi2FCxldaowhoIpLH2JFRRCS/iqdrKuQPfEORKmwOCvdGc5luKXoHWxbkWQ==
X-Received: by 2002:a17:902:f548:b0:1cb:fcfb:61af with SMTP id h8-20020a170902f54800b001cbfcfb61afmr14275911plf.30.1699277539333;
        Mon, 06 Nov 2023 05:32:19 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001c625d6ffccsm5891886plq.129.2023.11.06.05.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 05:32:17 -0800 (PST)
Message-ID: <bcf9def4-67e9-4939-a065-2eed2884b97d@gmail.com>
Date: Mon, 6 Nov 2023 20:32:05 +0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, yofail2@gmail.com
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: System will crash when trying to wake up from second suspend
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Total carbon copy of the following bug in terms of symptoms described, warning displayed after needing to hard restart after failed second suspend, and solution, but with a different laptop vendor and an A10-5745m APU instead of the A6-6310: https://bugzilla.kernel.org/show_bug.cgi?id=189431
> 
> The problem occurred on the latest stable patch of Debian 12 at the time of writing, as well as Arch Linux using the latest lts kernel at the time of writing, mainline Arch kernel 6.5.9 as well as the testing Arch 6.6 kernel.
>  
> changing linux/drivers/acpi/sleep.c
> 
> by removing
> 
> if (dmi_get_bios_year() >= 2012)
>    acpi_nvs_nosave_s3();
> 
> from the acpi_sleep_dmi_check() method
> as a kludge to enable nvs memory during s3 for my laptop and building + installing completely fixed the issue after several days of failed attempts at fixes. Evidentially, the HP envy m6 sleekbook needs nvs memory despite being manufactured after 2012. Bios is at the latest available version provided by HP.
> 
> I'll include part of my dmidecode to help better identify my exact laptop model.

See Bugzilla for the full thread and proposed fix patch.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218106

-- 
An old man doll... just what I always wanted! - Clara

