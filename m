Return-Path: <linux-acpi+bounces-17365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C385FBA4E88
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 20:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE3217CA5E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5227780E;
	Fri, 26 Sep 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECbygrl/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30C1FE44B
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912024; cv=none; b=dAEos04fRuraDcg1FTHrkV3+P/MuJX5E1TjmxIio6x6VEldAZZRqDmlE2E8mUvnjLhvgnbnY2jON2GUBKLMMpmFkLrylqY38j6ZTxVcz93UwxSmfcb3usqT6PTfc4n/FJaegr7pqlvVhz4aopybwSUIVMEvfxJUS3zttF7gdCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912024; c=relaxed/simple;
	bh=I+Evkj4ZyraDDAOliE43941p9OKriJEKfrJedbsijZw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=t74yqfcVGhbkGX9dmKcSGzHAOfzQMQ+uANBgX8w2yjZMEplr7wVWLdIYw7CErEvYdEJ1yNh7TWYDdbGf53fDuIHuToruPMJl6x95XP1Kykg/ayIcnJlY0VJrkwDln8cMxq1wSe6Z2G9+/98VeKDbXu7UKKbNazNR0Co7K3vZF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECbygrl/; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-244580523a0so27486185ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758912022; x=1759516822; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stJ84izxeEItUB66Vm/qDYA515D2UztYSOWsa2H0chY=;
        b=ECbygrl/jIGZgKQFAftCibKjSE3hvA+HC2h1pvE7XTbBu8cyFYEaRkOIYLdW+xurGx
         pDYxwizzPVRaZDu4b+xPJ01jFrG2A5YsnuggMCIZ8xN6DTzlsd+Ubd9bIPa1g084G6EK
         HXUw+uRteFHNzO27Ngg5zUr+KbU65ztHjI+IA+lyecbajZKXRRsTYakTAASuiM4GAV4b
         KSboTR8D5QgBiqdg4bQlaOh0Znjbjb5eIu6WkaTnjgi6JBlSsjwqPlxicr6vgOyw+9lO
         Q/brJ5M7Xfz95pxBFmPWnNukIpvTKlwuAtesB6TfuqgZW73AjnaNDZDs9oMU6HEzxLQ6
         f3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758912022; x=1759516822;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=stJ84izxeEItUB66Vm/qDYA515D2UztYSOWsa2H0chY=;
        b=MDIC4Vn6oMML3ahQAJfPtKX6dr3DICQaLOWzYRqIml+e2RXuAO3Lo3XFxSWL0cCilc
         guJLhonbONKLnlMYt50kG0menSwJG4it//ciiZVXKQIsKJYa++/UVEe9yah7F4F83j0/
         nTFi6ZGjy0pzIomEC++ZUE+bAJZs8gQmTo9euAVJnhJIwTHIHpNvo3vWhlmApkOQibU+
         J9FxRxUYfA80/Ot0ksCSHJeRohVKq85uhcWyXOJ1iXyqehCrSRYn19tZnA6As7qZqYAh
         ikR52ZfvteWvaqKAEkEOi9iHFs53muF62vw9aMo5xQCTjLoCGbm4HDiqRlDM2fwYg9Sr
         Dvuw==
X-Forwarded-Encrypted: i=1; AJvYcCX++/5+SAwssPyr376W6/SeWFph+wGXLXeD8q4Y0NTBK+e4tZOFds2k8ETuQGeCit9FFn4xohFss6bj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8PH1WDOl2DyetMWM1mq4MjrQIkWwkPuOkOhtrzPfOXhaUZJEJ
	PbxPDHarDOQ3R7geD2i52dLjwCJjXXjyVsnH2cn/aPdNidOsv9IT1uG9ML2x6jNqWeA=
X-Gm-Gg: ASbGncsTqkKLteiD/1xk3WS6+v9G2NlrU9d/rkPXBc8GWPvx+aO/TXMDmufCG4wt5QA
	NsnxIfSVeJeAxsANAuhFD6joPZBct8npAduEuPU4YwMg6rnKnXpTclbgvo6mkje7afAhB38efX7
	kiDH/3iWo/K71kKGNwbnmYNASPCOI/QsezWKiED0i5vczh7HgvYZZ0BtvR/tcec/Jk4Y0BAv8r+
	Ir4lf1o5mfKGMAOxQ8iKGrjfEeDGy+mjVMnnPF/69cl9VGPi1Wh9CqNkBo20FO4nr2MiOpmMmnk
	BaCxq/NssVefIHpwmXE3GA72WlRWHNXI0JL4svPPxqLRfO6YXfu/msdeUYlL9Uj8AOvppNak1VA
	Pyq568CKURxq5r9RlpF5ucLUFH8JPL7VIBwA3R5sMFzrpaQ==
X-Google-Smtp-Source: AGHT+IFXGK8iMqpu/q1zv7TPk0SPuVzNPBS6MvhQ56CHLCHoWBCkzmIr0jwTnM+QK+B7YQEUTx2v/A==
X-Received: by 2002:a17:903:3d06:b0:275:7ee4:83bc with SMTP id d9443c01a7336-27ed49b8694mr107333915ad.2.1758912022346;
        Fri, 26 Sep 2025 11:40:22 -0700 (PDT)
Received: from [192.168.0.218] ([115.187.48.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d310csm60991305ad.10.2025.09.26.11.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 11:40:21 -0700 (PDT)
Message-ID: <b285bfa2-2601-4977-b565-642830eea956@gmail.com>
Date: Sat, 27 Sep 2025 00:10:17 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, rafael@kernel.org,
 lenb@kernel.org, tursulin@ursulin.net, joonas.lahtinen@linux.intel.com
Content-Language: en-US
Subject: [BUG] ACPI/i915: Dell Inspiron 5567 fails to resume from S3 (black
 screen), DSDT patch included
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone,

I am reporting a long-standing bug on the Dell Inspiron 5567 that causes 
it to fail when resuming from S3 sleep, resulting in a black screen. 
This issue has been present for years, including on Windows.

After a deep investigation, I've traced the root cause to a logical flaw 
in the vendor's ACPI DSDT and have tried to develop a patch addressing 
that. However, a final experiment has left me with a question about the 
interaction between the ACPI code and the i915 driver, and I am seeking 
expert insight.

Firstly, the original DSDT in the _PTS method calls the sleep trigger 
(SLPE = One) before setting a critical flag (AES3 = One), meaning the 
flag is never set for S3 sleep.

The faulty code:

Method (SPTS, 1, NotSerialized)
{
     SLPX = One
     SLPE = One
     If ((Arg0 == 0x03))
     {
         AES3 = One
     }
}

My fix was to reorder the operations to ensure AES3 is set before 
sleeping. With this patch, loaded via a GRUB override, S3 suspend and 
resume are perfectly stable.

Working patch:

diff --git a/dsdt.dsl b/dsdt.dsl
index f30aef6..b6fb883 100644
--- a/dsdt.dsl
+++ b/dsdt.dsl
@@ -4359,11 +4359,11 @@ DefinitionBlock ("", "DSDT", 2, "DELL  ", 
"CBX3   ", 0x01072009)
                  Method (SPTS, 1, NotSerialized)
                  {
                      SLPX = One
-                    SLPE = One
                      If ((Arg0 == 0x03))
                      {
                          AES3 = One
                      }
+                    SLPE = One
                  }

                  Method (SWAK, 1, NotSerialized)

(Note: I also confirmed that the _WAK sequence explicitly clears this 
flag (AES3 = Zero), more specifically in the SWAK method of DSDT, which 
supports the theory that it is part of an intended state machine.)

Now, here comes the main part.

The _WAK sequence on this machine calls a graphics-specific method, 
_SB.PCI0.GFX0.IUEH, which is defined in a secondary ACPI table (SSDT). 
This method appears to be responsible for display re-initialization 
after waking.

To confirm its role, I created an experimental patch where I commented 
out the calls to IUEH inside the RWAK method. I expected this to 
reliably cause a black screen on resume.

Surprisingly, it did not. The system still resumed and the display 
turned on, even though my patched ACPI table with the disabled IUEH 
calls was successfully loaded (confirmed via dmesg: "ACPI: DSDT ACPI 
table found in initrd...").

Here are the questions:

1) Is the i915 driver "saving the day?" Does the kernel's native i915 
driver handle the entire display resume sequence on its own, making the 
ACPI IUEH call redundant on a modern Linux system?

2) What is the failure mechanism? If the i915 driver is doing the work, 
why does the black screen bug happen in the first place? Does the 
driver's resume sequence depend on a specific hardware state that is 
only correctly configured when my AES3 = One patch is applied before sleep?

3) How can I debug this further? Are there specific tracepoints or debug 
flags in the i915 driver I can enable to see where the resume sequence 
fails when AES3 is not set?

Here is the full acpidump for review: 
https://gist.githubusercontent.com/BandhanPramanik/3e5350019b513c0d32afed1f22dbaf42/raw/1f44ddcfb17277ce282cf03f9aab2f91bec1bd30/acpidump

Thank you for your time and for maintaining these critical subsystems.

Bandhan Pramanik
বন্ধন প্রামাণিক


