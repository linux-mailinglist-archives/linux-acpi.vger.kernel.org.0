Return-Path: <linux-acpi+bounces-12653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA1A791C3
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100011711E2
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22AE23BCF0;
	Wed,  2 Apr 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRVJTw3B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5277081C;
	Wed,  2 Apr 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606087; cv=none; b=flpObtyjLTQaVq/K8N0V0/1gPtUD6hhGIsFnpbFDekpcJirGwILtZ0ZdHIRHTIIwxmOrfnnGq1lpT/tJF85dfMbAEIAUvE6GpwD4b54YZutiqWuMlbJPzov3XZxXLM63pJM4VjBjiXGmcc46Aksn2vYGNkicM6cyRG4mvz8xw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606087; c=relaxed/simple;
	bh=Pay5SvCgNwdBymfzqKMZrYyLmxZ7nRMRW2EgfFyo61s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MIwTcLv92UH2TM5mSry+SxuNgUQYM9PHnxF/IN/BuYk1Hcd/B9HzqoP1FV8SoxMlmkGv2APin5BDfIVkRTFNKI9OxauU1+ESk1mQkfIlZJn3GhTh2jsMmYW8hyqD4JbhvDJj9uxy9zzxRQilQAFonIZOZKcjYRJkNnv6+kMeugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRVJTw3B; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c7f876b321so1981811fac.1;
        Wed, 02 Apr 2025 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743606085; x=1744210885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BkJd7ujSnv4CgArdpWVGlVRCnEQfxLIx1UY5sjCYk9Y=;
        b=FRVJTw3BhzMyZ0pA8Ek2En0Wg2DA9h2BqCwL46l0qCHAc038fSFuOSc4f838dtirjE
         2Ocx5S1cGZ3hOqh0yoQXtirje2C8k5E8AWjJ3V1ba5YPGUTNzYcmxbyKcLnjcXIy+bjH
         LxhtWGH5V7YSRZ/a1C1q5AgPDyi6+mSIOJBDK54MG6nFSLpT2KPXwAo1ZepbBC47NAFj
         uHO2aQ2U6vHLXfdU28UVhwyioyLtaT4oVPVOXkRP2c08IC5P0IfyMGAsBrzGz2lSa5SA
         IBeaTsHt0AgcIIKSjAw6NoO0A9ovrjYDH4lgyjhEiHfI7v7hkSkz3nIFrVnCs+JDO8zn
         6XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606085; x=1744210885;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkJd7ujSnv4CgArdpWVGlVRCnEQfxLIx1UY5sjCYk9Y=;
        b=nHQmEoVmL3+y0P0eY2s6WLXwfUHTeFZr3E/KBQUpTlN8IK+QWvDFOJvpjJES3uZe2r
         pn5tdt0hGMfEU07LAKxx7N28EUdiTihwiYxTIyJYegNA7GotL48qrr6W4vv5kNGzDaRi
         bLpM6urQQY+rK73fNgv39woje34nGrIhD55C8hFHAnLhxDtF8cbzwkOLVR9Hpr3Q5piU
         E35vxP5TdaCwXrP/Llz31NondClpJ+2mIPiDNUSWWq67te34HzwYJRtJ6JL/rqB4S0kH
         SojzaXxTjfyLRX8BleDMZ/ZvwL1zBa3K9DsD/SvktU8cM4WhdUmKympVdcE66yE0yg3J
         8G/A==
X-Forwarded-Encrypted: i=1; AJvYcCW1sY9MA01OGETjJLZoyaWrHT+f0LIa1lM2TUmbBUVdI7fh4uI/FGCK4LTogqaNEfYiv4KgMYE93jak@vger.kernel.org, AJvYcCWPSG+oHI5ZpTtDSUh/SdL+wlsi49rTUNwUf2azoOnJvrwAzsdT/lMY+/niDs4SkcCCRGYnpbQaMcbcOZO9@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKL0lGqhiVJVknN02qnLQu2KtG8RXWjy9Xjop6uZJ5Wvl+COG
	ZvilU2nP3VlKuPfjCtnNo6neyRq9PfJQ8Ml3sTFYBh/CExG3TkqXwAYwHV+nKNIN4/MCnGxCUvO
	RA5axU3G61C0YUsjs0BZjCKhDP3+JCXLl
X-Gm-Gg: ASbGncuw8FPVmsAbze2S/wQ5knNYj6UQyw0oRtHcMbCgSbRtZ0iSwGn1Hq5YVCDqSrd
	4ZkIRNl433U+MVhidQ7Z59riQOVnLoQIzlm8AnL4xHYUxUqQt+6jfItMhX2CYpwt9GsADngCUOh
	ej6y5uR6pDcpmNWdGuBaroGwZ0zA==
X-Google-Smtp-Source: AGHT+IHkGPensKtSx0Kqhjq8p/pZzlVb+CzAEvvywG9S0Ch8RxC+IU6YVIn0JYYRbxp8HgoYDYLzHs6VVSvT5sWqR+Y=
X-Received: by 2002:a05:6871:530e:b0:2c8:3411:df19 with SMTP id
 586e51a60fabf-2cbcf7afa78mr9983218fac.37.1743606084913; Wed, 02 Apr 2025
 08:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date: Wed, 2 Apr 2025 17:01:14 +0200
X-Gm-Features: AQ5f1JrX9cFvgUplNqLWVYYVGPY3K08rmNKx-VLmzjhOGeX9vQ6lj-rEvKLJtUM
Message-ID: <CAJZ5v0gEidr++vOdw9rAe3z=TCU5jfAY6_6WJrm3_VD1nq=8Kw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.15-rc1-2

with top-most commit 9e4e249018d208678888bdf22f6b652728106528

 cpufreq: Reference count policy in cpufreq_update_limits()

on top of commit 7d20aa5c32ac8bd272b5470ddbd7ac6e0cb35714

 Merge tag 'pm-6.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive a power management fix for 6.15-rc1.

This prevents cpufreq_update_limits() from crashing the kernel due
to a NULL pointer dereference when it is called before registering
a cpufreq driver, for instance as a result of a notification
triggered by the platform firmware (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: Reference count policy in cpufreq_update_limits()

---------------

 drivers/cpufreq/cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

