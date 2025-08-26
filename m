Return-Path: <linux-acpi+bounces-16065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D39B35962
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B80D188D49D
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84B3176FF;
	Tue, 26 Aug 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="siy50CBg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68764B661
	for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201896; cv=none; b=lbyoo5Ygsvlcpdi4pbG9zT6gBOFcYWs9+IpgRz041Dq61pt3f45wx1pjg0g6i2NygZopo6TG1XPS5L7b6ekRYP6WVGWJcZ3+glac/IqMc9KGYKhfR+sNpCMT7ZgB6CvjGiu7wcBSQNH9P4aYwV5zUTJrjWtSUluEd567Ib975XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201896; c=relaxed/simple;
	bh=/KkcJAmnrfybttPx6jNoWxuS0SHkGFIyFNoIbHwnasA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DSlfHacfGEeLLZLphTe2ZcC7oYS1awgS5fqC1M3d4GdKsIan7cBU+kUeOPzKLhuE1pTaPo5De/FHmZWSKdXb78QuSWEJhxRDHb4mVXevYC+zEtTVWYEd7RFLc3BdHiQn1wVSZjhYxrmhXYeBiM1VCWHwUcXSG+EYbNeOF1J2ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hifiphile.com; spf=none smtp.mailfrom=hifiphile.com; dkim=pass (2048-bit key) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b=siy50CBg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hifiphile.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f92a69d4so39058711fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2025 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1756201892; x=1756806692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h9c1CDCOvyBq/aRhIMWpbkELmYhN1vUsfg/iJ5AHkIk=;
        b=siy50CBgSbkGWGadSehIZyUg4sqpZBS1CqliXcuw4Rdaw36tSY2gCLOMmEnzMAmBP6
         8IDjOpUwuGd8k+0aKmuWx3ev0VevsOdXiZAN8r5Vg45A6srewip6FaoHj6z59TOcWXSe
         pfXNV7SpHayTZS+zlYklZCMeYlFbOQ9cpblW/knlFxwueAqoHY/fEF15Tjqz+Nxv7eWn
         t86MjFdVDdnpn+EVkXVlRgqI7hcGUBAVyOeTmyM4bKRbWKIJyFznFqfyToRTKSprHI+l
         SklRXieEmxH8IfOFRtLhzHe/l3tcP7kIkoyd6Qjp1Ko+4TOUjkPYI1IrHkhT8g1QZ2Hs
         tXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201892; x=1756806692;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9c1CDCOvyBq/aRhIMWpbkELmYhN1vUsfg/iJ5AHkIk=;
        b=qFJdQv41nXH7/+o2SW+Er6LroHDLcerARScIBnteRNI9MsT51ejLN+wK1QZLr9nGFX
         wApCFawWF4VSr/efoQZUCXYpq03XIVaKZcdssBxCM0hZ59iIQTI7hQr0ARmxQYqQ276M
         gBxoTkUcAKg3Avr6BHT43oU52xLnfnXtxqGcDsRgwrkQBaGFMmTZYLEgbLexS5oMyBBR
         QRO2A18TWlga2cbDKIHx/58ZPSNRB8388s5MSYG/ymQCSGYrkV323BGO9AaUBMUkk2xn
         mfxa+83Solg1YhiGYucHks44P/RHG4wN3npm1LQNfJsjLytio66h/7cxDJJa8LcUA3iz
         dmAg==
X-Gm-Message-State: AOJu0Yyu+4ixdSsc/EG6qGJ0kTgGDv7SfJZRyIxTT6yt67UnSO5MpEFo
	yEWYQLCSRZ4CbPdO0DcJhceC+qhL9DOGbJlB4U/nk27K28ZEQdz4LsCmh5cPY3nEnxkQ9XysiJl
	0krVhSZ+roXxbK5Iw9qUZwylZn0E5pGuZ8j2KU5sYCDBqHxqAM1kU1m1Sjg==
X-Gm-Gg: ASbGncv8e09buJKicCUe6naEJiloUQM31dSud+qM01REKeOgvBj6iJW6aOlifRFH9Bp
	nP9DRAwTiT/UNEe9bbn0MQ3Kcy+J6xQsG2btpio74EWbAJSLjJuVkO+N9rHZmLEnEAB8SLHFvcO
	tV1zUXiWVNNDNb58NiHTFc/1fGHN8cG2Hl3ScWYQh+vN5nU8sC2h/kkazgbBzBJP7UaVDtkxGok
	GwmDUgBI3YfB7PsluoNZG9nekevqC+cfpEvQA==
X-Google-Smtp-Source: AGHT+IEtEIVZaWLRcBovdduVXYsS+KT2Ob5GOJ1otgp63Q+ekMD9ZvXzd0jWGYz/R4sX+d1TjrP8tbhXcYwdoQewITQ=
X-Received: by 2002:a05:651c:31ca:20b0:30b:edfc:5d8a with SMTP id
 38308e7fff4ca-33650b8a25fmr26018321fa.0.1756201891750; Tue, 26 Aug 2025
 02:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 26 Aug 2025 17:51:19 +0800
X-Gm-Features: Ac12FXzUndEm7sgSR6NAOag7RreTASiIm_1K6StK6diSO2cDMs1zfa93DUv2B5o
Message-ID: <CA+GyqeaFsLj7ocLGEuw9mB2f5qChC-dMb-jvLN9BVe=rRU=J4g@mail.gmail.com>
Subject: Long boot time on ASUS TUF A14 FA401KM
To: linux-acpi@vger.kernel.org
Cc: "Luke D . Jones" <luke@ljones.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

Kernel boot time is very long on ASUS TUF A14 FA401KM with kernel 6.16.

From dmesg the kernel is hanging for 36s:

[    2.164931] usb 3-5: New USB device found, idVendor=13d3,
idProduct=3612, bcdDevice= 0.00
[    2.165573] usb 3-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.166127] usb 3-5: Product: Bluetooth Radio
[    2.166671] usb 3-5: Manufacturer: Realtek
[    2.167208] usb 3-5: SerialNumber: 00e04c000001
[   38.188085] clk: Disabling unused clocks
[   38.188644] PM: genpd: Disabling unused power domains
[   38.191606] Freeing unused decrypted memory: 2028K

Result of initcall tracing:

[    1.750332] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0x40 @ 1
...
[   38.126886] initcall
acpi_gpio_handle_deferred_request_irqs+0x0/0x40 returned 0 after
36376321 usecs

With ftrace=function_graph the delay is located in acpi_ex_system_do_sleep,
which came from DSDT Sleep instruction.

In DSDT the issue is located in this function combined by looping and long
sleep:

Method (NOD2, 1, Serialized)
{
    If ((IVGA == Zero))
    {
        If ((Arg0 != RDNT))
        {
            Local0 = Zero
            Local1 = DNOT /* \_SB_.PCI0.SBRG.DNOT */
            DNOT = Arg0
            RDNT = Zero
            While ((Arg0 != RDNT))
            {
                If ((Local0 >= 0x0f))
                {
                    DNOT = Local1
                    Break
                }

                Notify (^^GPP9.PEGP, Arg0)
                Local0++
                Local2 = (Local0 * 0x64)
                Sleep (Local2)
            }
        }
    }
}

For testing purposes I've made a DSDT override with the loop removed, for the
moment nothing is broken and the issue is mitigated.

The full tracing and DSDT dump (dsdt_org.dat) are updated to
https://gist.github.com/HiFiPhile/324c330b204ef038ef8b3ff2aff7bb6c

Thanks,
Zixun

