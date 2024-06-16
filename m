Return-Path: <linux-acpi+bounces-6443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BB909FE4
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 23:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2151C20CEB
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 21:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7144CB28;
	Sun, 16 Jun 2024 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="jyocfVUl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227803A8F0
	for <linux-acpi@vger.kernel.org>; Sun, 16 Jun 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718572558; cv=none; b=u+NHZxoKHhOrwJsmsCdeJThqmObHfhgVN2yDvCrlbNeV9MEHMLjYPVs5U3aRGEnBnAsS2MCc1FDanNdhUSksVxk0gte4qdUC1ZKgfmwPT2th59K5sPBqtKxMiuPN7YVnseC1WOoPSck5q7x8yFHcwKyr6lmmipFj16T0zkStgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718572558; c=relaxed/simple;
	bh=oIdeXeyjXZDHkm7gQVO2gHhWkxVVPPi0Zz7iv4rcPos=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PEqrYA2ic4j4jWMuLZkI1d7iBWvH0FzQ3mNsWrXvlASSFFfAwWfOW8UTcSC2qygjzB4J2p1Sy5g34ECgifzwYoKD7NmOD5zahXIvUyBEhpATGaZoBRlFyXYZP13ugPmT2FPavkXKglmFGKY757FzDraXA/Q60xaxd/fK66o3ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=jyocfVUl; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-7eb9e7f3da2so163404339f.1
        for <linux-acpi@vger.kernel.org>; Sun, 16 Jun 2024 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718572556; x=1719177356; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPezpQBaJx00fRUafxAhmwOXexVKiTuVTEiNrD1iCrQ=;
        b=jyocfVUl8M/FJhl5bLMuVnF4FzOp8y8c7nXCyhPcyqPlAMcFSzmyw5ecdYtJZ4NffT
         btMZxrUWOc/1v2J5s9E59hLMYMOwd5/Yj2J6dPRWggaABha5YtQbsUa7Efm4YC3mKnR/
         Z/FsGNIgHUgn1PR30WWFcXnIt43yplaq4GDfoeYMRzbwIf+dG3adu4vv2VXB/bf5atJ1
         HDzDi7HaRejBRP+xE6jsz/XjVhHEWyX16f1Jfc9sWNRaJGxUogs03Th5Hah+rVrD14nm
         LxS+BLT+kZlc4NkCjnBZbwD17MzAl3ogUFzy/CBEIoyFq9I0Byg5rVMoeIeIzuZV2ZRu
         EBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718572556; x=1719177356;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UPezpQBaJx00fRUafxAhmwOXexVKiTuVTEiNrD1iCrQ=;
        b=Bjm9Bw5zwd6lCMi3WB+78KFb4qBRBJ8TA+N05jZ2ksKFk1SfnmDZsTihcx0SxpQ8Fu
         c+zJmldRZNUlKVm4ZBMUEIp7BFy5b2eNTC+mQuqW8CVWq1WAdTeAJht3S4N+QnVDIohQ
         C2bZKmv2mxAwDJ3W5Z9Ln2ZzFymLgEiRMkxg+0EqLm06kHdhrUFWKslbItEUpa1xoGU+
         Eg0x5nSpMOiLR+Dn14WxZYerftlJv3rfi5etqaWVvNdJG6T2x7ebyl9k9tccAM7OWn/4
         p05FlQxCgg5YYaUxkVOrpE+62IlMstwEwLn+3UGEmhEa8StDDpZkrw7UOdlQy3lRlufU
         DjTA==
X-Gm-Message-State: AOJu0Yxa52IxoMkUTWofUf7T86wpzlPZF40e5ARF1pe/9nuQz4SfM/s0
	6VGxRz223rmMvai8TT9yHnxSwfFLd3bqlMM499aDDwGFjj+tb8fMDvLN3aStqfB6UYVg8qbniYH
	Spy/YU6tC4LE=
X-Google-Smtp-Source: AGHT+IF1mlGHa2H7J2jHRkNaK6Vg2wtcHoxnGd5/PrFvkxPyaXEhbGTuFyBVwCGoadqV+Es0XtC4Eg==
X-Received: by 2002:a05:6602:2b84:b0:7eb:81d6:c92f with SMTP id ca18e2360f4ac-7ebeb4dc7famr1098506039f.9.1718572555970;
        Sun, 16 Jun 2024 14:15:55 -0700 (PDT)
Received: from ?IPV6:2607:fb91:111c:4643:f99:28ab:c3f4:9503? ([2607:fb91:111c:4643:f99:28ab:c3f4:9503])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956917e8dsm2231170173.48.2024.06.16.14.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 14:15:55 -0700 (PDT)
Message-ID: <d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org>
Date: Sun, 16 Jun 2024 16:15:54 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-acpi@vger.kernel.org, rafael@kernel.org
Cc: mario.limonciello@amd.com, lenb@kernel.org
From: Aaron Rainbolt <arainbolt@kfocus.org>
Subject: Relying on_OSC to be accurate about CPPC v2 support breaks scheduling
 on heterogenous-core Intel systems with buggy firmware
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

My name is Aaron Rainbolt, and I am working as a developer with Kubuntu 
Focus.

In commit 7feec7430eddd, the `acpi_cppc_processor_probe()` function was 
modified to check the CPPC v2 bit in _OSC to determine is CPPC v2 
support was present on the system. If this bit is not set, a particular 
set of CPUs are checked using `cpc_supported_by_cpu()` (defined in 
arch/x86/kernel/acpi/cppc.c) to see if the processor supports CPPC v2 
even though the BIOS does not report it. If this function returns false, 
CPPC v2 is considered absent.

While this works well on systems where the firmware accurately reports 
CPPC v2 support in _OSC, this causes a severe performance regression 
when using the new EEVDF scheduler on some machines. So far we've noted 
this issue on certain machines with i5-13500H processors, and have seen 
some reports of the same issue elsewhere on other hardware. All machines 
encountering this issue had two things in common:

* They use heterogenous-core Intel processors
* They have buggy or misconfigured firmware. In the clearest cases, this 
firmware fails to report CPPC v2 support in _OSC even though CPPC v2 works.

When these two things are true, the EEVDF scheduler will oftentimes 
schedule processes on efficiency cores rather than performance cores, 
resulting in badly impaired single-core performance (my workplace was 
seeing 50% slower Geekbench 5 scores on some systems because of this 
bug). Some examples of the bug online can be seen here:

* Kernel.org Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218195
* Same issue, same author, Star Labs Firmware bug tracker: 
https://github.com/StarLabsLtd/firmware/issues/143
* Similar but less-clear issue on the Manjaro forums: 
https://forum.manjaro.org/t/linux-kernel-6-6-lts-cpu-regression-on-i7-alderlake/157474
* Similar but less-clear issue on the Gentoo forums: 
https://forums.gentoo.org/viewtopic-p-8819389.html?sid=5997f89fd5a202b6db8396fba0b45821 
(resolved by enabling Intel SpeedStep - I suspect the poster meant Intel 
SpeedShift here, though I can't be certain)

To test whether the _OSC mis-reporting CPPC v2 support was the issue, I 
recompiled the latest kernel for Ubuntu 24.04 with the following test patch:

--- cppc_acpi_old.c     2024-06-16 15:27:44.214202299 -0500
+++ cppc_acpi.c 2024-06-16 00:29:51.684020493 -0500
@@ -679,8 +679,13 @@

        if (!osc_sb_cppc2_support_acked) {
                pr_debug("CPPC v2 _OSC not acked\n");
+               /* KFOCUS TEST PATCH
+                * Some machines have a BIOS bug that causes
+                * this code path to be mistakenly hit. Ignore
+                * it and continue regardless.
                if (!cpc_supported_by_cpu())
                        return -ENODEV;
+               */
        }

        /* Parse the ACPI _CPC table for this CPU. */

This essentially ignores the results of the _OSC bit check and continues 
on to parsing the ACPI table regardless. This immediately resolves the 
problem in our testing - CPPC v2 appears enabled looking under /sys and 
/proc, and single-core performance improves dramatically.

Looking through the mailing list archives, it does not appear simply 
ignoring this bit is safe in the long run - apparently is can mess 
something up with USB4? (See 
https://marc.info/?l=linux-acpi&m=165704566017713&w=2 - I've CC'd Mario 
Limonciello on this.)

Some ideas I have for potential long-term fixes:

* Perhaps add a kernel parameter such as "force_cppc_v2" that will allow 
the user to choose whether to ignore this check or not? This isn't 
ideal, but it would work, I think.
* The `cpc_supported_by_cpu()` function appears to be used to work 
around this very bug for select AMD and Hygon CPUs. Would it be possible 
to add heterogenous-core Intel CPUs to this function so that the _OSC 
CPPC v2 bit is overridden for all such processors?
* (Long shot) Make the new scheduler not need CPPC v2?

While not ideal, I think the kernel parameter solution is the safest, 
and it is also sufficient for Kubuntu Focus's purposes. I'll work on a 
patch that uses that strategy if no one objects or has better suggestions.

Thanks for your help!


