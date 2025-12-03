Return-Path: <linux-acpi+bounces-19418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B531CA1092
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E553317A9CB
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8A31ED8E;
	Wed,  3 Dec 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="waeN7KXC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406F25EFAE
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783554; cv=none; b=au3JPN30TC75CuigVTTPiNT/pHjybRbU1hSnfm+1kZhazXVQd6/aSVEEZbTgfRPnAWCstr2mztTVskdoyEFgg0CvHdLxyLIIOtL5u1Qg02Ge1pcZHhqQL48TpRplLgvkiOhmQ8MQrskfWDgUlWXLtabM0ukJvHvXAp5TNvaR+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783554; c=relaxed/simple;
	bh=lqB/4mhUE2yTmXKPm3REMAfwEcdLCYeaas36LVXjf1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnwI8BaDTxoZavLvz/YJn9ShFHCnIf98XjdAo//xeMazIvm8Mhk66GhVr2nsOM+N5d7Pysu3QHi4mk340dUuXeB47BGYcQAKJIKZ9r4CAicvy7LLXDzHSIp8gW41Z0N4MxxKYSV1Mo83FAnQBbTkHprFD1pUa+/UqonEjncmBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=waeN7KXC; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3f4f9ea26aaso33243fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1764783545; x=1765388345; darn=vger.kernel.org;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rh+6msNDHnVjjuN/R81jZjgmx9PmAz+Em8qshbGawRY=;
        b=waeN7KXCTF4oCIiC4t0X8lSJDl9DNn23eUfmypZZxA+5jZDyMzu3Lvfg5ii2SgEVpB
         xuNqVfRMHX20Tgwki6GBMc0SIcWSiQqj9VY8xQBjUXVUSrBCYBSVA5SQFyZj7gInfroo
         JKGYOKRu7o+PS8CdrAJ8Zmq8FQ1uoI40xsLJl3lTh0Yt0dLdl0WkRx0v/U7mCDEad91E
         blPZCw1a1MCDB0+aPSRoIP9au/wgJS5Hy5lZq7bEys8ZddLS0scadzpuMaVmpBhI2Uqf
         jQEd1oJkvFA3T9mzFAKSAlmt15Iozcp2a8zMlESHuz7DxwA/xkXWu3UlmVoGh88uvKoq
         kq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764783545; x=1765388345;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh+6msNDHnVjjuN/R81jZjgmx9PmAz+Em8qshbGawRY=;
        b=qIFBR8h+hFgRhWJ0lwsAnYcnbPmabkoT01GAcW+nfL/EE8pBmlNN6sUZYZ11gQE29I
         OPhval2uTZs4zRyj9eshDHs5CqxwXOWmFX+aPKCP/BceDeOlS3GDUkg5JyxNLidHBfIM
         7yIrh45v9kJy5eghm1LW1LEBGrZzXF3t1hrCI5+ihWJf2amTrBcPlT8Ud9jz5h1ed0XD
         a0uRnKasMe+cnLLsaPvAF359Qpx01G8P56orQC300P22/Nzfte1saB/UAsebmh1cq3Yh
         OvjfdzEV/OSzHRTgCk/1v1gWFLnwQiUPuFVEYKFNh+XgZ7DbUmeGtD4gaQjv6gWQJB5f
         +Mjw==
X-Forwarded-Encrypted: i=1; AJvYcCVxJwP2OPruvNi/RC6UX4bJU6WJ3+fWVmfTVqzgom6ETqETGtIpo+WMa2QZ3wTJZS3++7wHUn5qHreH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/MzF9MICPhyNbQilmo99Eu4kSgv6O2Oooh0iSrDmo3BEK033
	SXx6T7cIdlpKTK9Iv4kHGxJ4k5DY1BZXTK0skP96WTE/Mo/kj+XQmtsPd2svEqdbYn0=
X-Gm-Gg: ASbGnctcMKJ5z7KqvWJz05mZN+4KFsOe6D46Wj7+AuDqFWzBJL0yliS928BtbD7Ais4
	qFQdtvDrlbfgld5XaTl5+SWDK9p7+4dU2D5RAOhDqyWd5cCKz6sfv55T44oBaVt70Jms7wanX7m
	HHYiBSOc2SX9CSJ6zXnlnqA+IzRBybT4iGu7Ch91xC8R2cjQ8RKunVYubveb9vU+jTSNvkoSJwY
	r9C5/okyfWLjGDJY0W8zmz7l42v2TJAwANzo/F1G9k0ZrpLv4kNUMfLzPSbw5InCPWv2tHVEDDx
	Thw12WgrY3Sdb2BVAXzhUDe8fQD2hDkogXLKpJRQr4vIieMAJRsjUOdKTTe+6zfzD6m1keGP65n
	42mt2CB6Az4B6COkDb2HBxVvspbznGJUt7R4z7EXzPQL5rSY052nv6RbC0mmvybBpThmyK3Mane
	kmYOqCXQY=
X-Google-Smtp-Source: AGHT+IHHApwLreZgH4ovi5WX/rc0u4hgi3kiCi6fhtVUAAkNtO7jMHi5ltJMyRyZCiGkgFY1pjoyXA==
X-Received: by 2002:a05:6808:308e:b0:44d:c185:f816 with SMTP id 5614622812f47-4536e4f7ccfmr1731021b6e.34.1764783544673;
        Wed, 03 Dec 2025 09:39:04 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf8f:aac:11b2:8ea3:5a93:ee05])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537820ffddsm204623b6e.11.2025.12.03.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 09:39:04 -0800 (PST)
Date: Wed, 3 Dec 2025 11:38:51 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 mmikowski@kfocus.org
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251203113851.52bf872b@kf-m2g5>
In-Reply-To: <20251126170031.145b6a56@kf-m2g5>
References: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
	<20251126170031.145b6a56@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/gSFvir+VM81sdu0qQQTVXTb"

--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 26 Nov 2025 17:00:31 -0600
Aaron Rainbolt <arainbolt@kfocus.org> wrote:

> (Sorry for this rather malformed email, Claws *still* can't find the
> thread for some reason so I'm having to resort to a "mailto" link off
> of lore.kernel.org.)
> 
> > I asked for some dumps before. We can try to inform the OEM of the
> > system as this is a BIOS tables issue. What is the make and model of
> > your system?
> >
> > Thanks,
> > Srinivas  
> 
> We're actively working on getting the dumps you mentioned previously
> for all three affected machines, along with the model info and some
> benchmarking results with our current production kernel and the latest
> mainline kernel. It's taking a bit longer than we expected, but we're
> pretty close. I should have more info by Monday if all goes according
> to plan on our end.

Hi Srinivas,

We ended up finding out that the frequency misreporting issue impacted
more machines than we thought, in different ways than we thought, so we
ended up a bit delayed. We did get many of the dumps you requested, and
also did some tests to see exactly how frequencies were getting
mis-reported. The actual dumps and the results of testing are long, so
I've attached them instead of pasting them in.

Some key things to note are:

* The manufacturer and model codes for each machine we tested are in the
  "2025-11-26_cpu_freq_report.md" file.
* We're seeing the misreporting problems on at least five models of
  machines from three different manufacturers (ASUS, Clevo, and
  TongFang). Every Arrow Lake system we've checked is affected. This
  doesn't rule out BIOS issues I guess, but it seems somewhat unlikely
  that three manufacturers would mess up their BIOS in the same way.
  The reports are for three models of Clevo machines and one ASUS NUC,
  we haven't gotten final test results for the TongFang machine in
  question.
* On all affected systems we've seen, *either* P-core frequency is
  mis-reported, *or* E-core frequency is mis-reported, but never both.
  One core type always has its frequencies reported correctly, the
  other core type's frequencies are reported incorrectly.
* All systems tested were using the latest BIOS from the manufacturer,
  to our awareness.

Thanks again, and let me know if there's any other info we can provide.


--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2025-11-24_6.14.0-34-X560WNR-G-acpi_cppc.dump.txt

/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:270641204082 del:275722878614
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:133912418268 del:139184280166
/sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:115895924324 del:119120299188
/sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:135163412604 del:139673124030
/sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:134216335076 del:136878099645
/sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:127454330124 del:130825399213
/sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:173110410800 del:180407121677
/sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:150555889972 del:157978027842
/sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:157707186600 del:163187443243
/sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:144500108048 del:151193319807
/sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:128414316672 del:133079393109
/sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:235732033557 del:245559669554
/sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu20/acpi_cppc/feedback_ctrs:ref:142529934172 del:147286014327
/sys/devices/system/cpu/cpu20/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu20/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu20/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu21/acpi_cppc/feedback_ctrs:ref:134110261880 del:138912585023
/sys/devices/system/cpu/cpu21/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu21/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu21/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu22/acpi_cppc/feedback_ctrs:ref:118184508996 del:123263423709
/sys/devices/system/cpu/cpu22/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu22/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu22/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu23/acpi_cppc/feedback_ctrs:ref:172933187148 del:164921744944
/sys/devices/system/cpu/cpu23/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu23/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu23/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:280142498645 del:334674936327
/sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:256054357938 del:287527389253
/sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:186745001362 del:194811608030
/sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:230118055201 del:248255491877
/sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:175095729168 del:176795360535
/sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:150105939201 del:145936640289
/sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:142290990884 del:147807338169
/sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:154708348652 del:158632827571
/sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615

--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2025-11-24_6.14.0-34-X580WNT-G-acpi_cppc.dump.txt

/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:374866724597 del:465489532684
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:226946192396 del:271342932276
/sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:175237076520 del:197664430464
/sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:207357763720 del:239563603235
/sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:249535094828 del:298991040346
/sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:221214580324 del:261701879687
/sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:183465357044 del:213189463519
/sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:236845413840 del:276985499939
/sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:258748495336 del:309148087977
/sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:282665725696 del:334695362296
/sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:187457675552 del:217590026137
/sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:402083637737 del:555040601378
/sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu20/acpi_cppc/feedback_ctrs:ref:229259680856 del:274888319458
/sys/devices/system/cpu/cpu20/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu20/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu20/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu21/acpi_cppc/feedback_ctrs:ref:268441358832 del:332569878567
/sys/devices/system/cpu/cpu21/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu21/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu21/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu22/acpi_cppc/feedback_ctrs:ref:249194573096 del:308902686939
/sys/devices/system/cpu/cpu22/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu22/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu22/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu23/acpi_cppc/feedback_ctrs:ref:187445466884 del:222071704319
/sys/devices/system/cpu/cpu23/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu23/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu23/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:322158653189 del:429905792341
/sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:319077406391 del:404513577749
/sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:268043681191 del:343751704951
/sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:230209976184 del:285555852631
/sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:207999236211 del:252907975184
/sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:250771637584 del:296309565135
/sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:179869433180 del:205359472395
/sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:234553386432 del:278617537574
/sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615

--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2025-11-24_6.18.0-061800rc7-X560WNR-G-acpi_cppc.dump.txt

/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:85764085462 del:81092364612
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:30648952280 del:32319093196
/sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:24418501228 del:26064639390
/sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:30772876268 del:31630648127
/sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:32208013456 del:33858924907
/sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:34318996648 del:37357638199
/sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:41344894184 del:40523832261
/sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:36965175248 del:37144286195
/sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:29796395364 del:30507895794
/sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:30008884864 del:31394469575
/sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:33127087692 del:36493571195
/sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:47084742987 del:52088422560
/sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu20/acpi_cppc/feedback_ctrs:ref:35405865204 del:37891455176
/sys/devices/system/cpu/cpu20/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu20/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu20/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu21/acpi_cppc/feedback_ctrs:ref:31453151676 del:32354440344
/sys/devices/system/cpu/cpu21/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu21/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu21/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu22/acpi_cppc/feedback_ctrs:ref:29395705360 del:30249765611
/sys/devices/system/cpu/cpu22/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu22/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu22/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu23/acpi_cppc/feedback_ctrs:ref:34147115164 del:34129428131
/sys/devices/system/cpu/cpu23/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu23/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu23/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:52863482561 del:63458169943
/sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:53310134126 del:60839001140
/sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:37661765305 del:39273578265
/sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:37315012790 del:40229366158
/sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:31209054793 del:33190454758
/sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:27945691272 del:28942342249
/sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:30470288492 del:31360721157
/sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:33008945576 del:35214567794
/sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615

--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2025-11-24_6.18.0-061800rc7-X580WNT-G-acpi_cppc.dump.txt

/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:74783349627 del:74791433151
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:17495243700 del:19070054739
/sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:17384466440 del:19403776545
/sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:21845290924 del:25086237232
/sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:17433839396 del:19247766490
/sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:18058167740 del:18521617185
/sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:15963076884 del:16338653622
/sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:20801035216 del:21984217755
/sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:18574290088 del:18550697798
/sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:16725258508 del:16419667955
/sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:18028089184 del:18997492510
/sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:32768244495 del:38393600658
/sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu20/acpi_cppc/feedback_ctrs:ref:15631584212 del:15908355040
/sys/devices/system/cpu/cpu20/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu20/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu20/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu21/acpi_cppc/feedback_ctrs:ref:23249605556 del:26489009609
/sys/devices/system/cpu/cpu21/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu21/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu21/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu22/acpi_cppc/feedback_ctrs:ref:15766351504 del:16036289967
/sys/devices/system/cpu/cpu22/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu22/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu22/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu23/acpi_cppc/feedback_ctrs:ref:15008859188 del:16012788345
/sys/devices/system/cpu/cpu23/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu23/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu23/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:22957483783 del:28388697340
/sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:38446441149 del:53438056561
/sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:20838805244 del:25651369450
/sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:19550796381 del:23272468368
/sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:17609094176 del:20962277250
/sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:38715367978 del:55778897631
/sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:32
/sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:63
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:19160123376 del:21192607910
/sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:19086913404 del:21235914198
/sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:21
/sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:46
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:15
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615

--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/markdown
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=2025-11-26_cpu_freq_report.md

## Overview
This document details the incorrect CPU frequency limit reporting we have seen
on multiple systems and multiple Linux kernels. We analyzed the following
systems and report on them below.

ODM   | Model      | CPU           | Kernel
----- | ---------- | ------------- | ------
Clevo | X580WNT-G  | Ultra 9 275HX | 6.14.0-34-kfocus
"     | "          | "             | 6.18.0-061800rc7-generic (Mainline)
Clevo | X580WNS-G  | Ultra 9 275HX | 6.14.0-34-kfocus
"     | "          | "             | 6.18.0-061800rc7-generic (Mainline)
Clevo | X560WNR-G  | Ultra 9 275HX | 6.14.0-34-kfocus
"     | "          | "             | 6.18.0-061800rc7-generic (Mainline)
Asus  | NUC15CRKU5 | Ultra 5 225H  | 6.14.0-34-kfocus
"     | "          | "             | 6.18.0-061800rc7-generic (Mainline)
Asus  | NUC15CRKU7 | Ultra 7 255H  | 6.14.0-34-kfocus
"     | "          | "             | 6.18.0-061800rc7-generic (Mainline)

See separate reports for the output of the following:

```bash
 grep . /sys/devices/system/cpu/cpu*/acpi_cppc/*
 ```

The mainline kernels were download and installed from [this Ubuntu
site][_0090].

Generally, the E-cores report frequncies as expected: the claimed frequency
limits provided by the CPU (`cpuinfo_max_freq`, `base_frequency`), the
Spec-Sheet frequencies, and the measured frequencies attained
(`scaling_cur_freq`) all agree.

However, the P-cores are have issues with the claimed frequency limits
provided by the CPU (`cpuinfo_max_freq`, `base_frequency`). These do NOT match
the Spec-Sheet frequencies or the measured frequencies attained
(`scaling_cur_freq`).

These errors are a problem because they are used by multiple tools to help
manage the CPU power usage. Performance can lowered if the claimed frequency
limits are lower than they should be; conversely, power-saving tools that rely
on these values will not work if the reported values are too high.

## Scan Results Key
Each section contains a 'Scan Results' table that shows the specified,
claimed, and reported frequencies. Notice that all cores of a given type are
scanned, since not only are there P and E cores, but within these groups there
may also be "golden" cores that provide higher frequency capabilities. For
example, the Ultra 9 275HX's 2 golden P-cores have a max freq of 5.4 GHz,
whereas other P-cores can only attain 5.2 GHz.

Column  | Values | Purpose
--------|--------|---------
Type    | P|E    | The subset of cores this row applied to.
        |        |   For example, `P` means `all P-cores`.
Turbo   | off|ON | The turbo setting of this core subset.
B-Claim | int Hz | The max `base_frequency` value of this core subset.
     Id | int    | The core id that provided the Base-Claim value.
B-Spec  | int Hz | Intel SPEC'D BASE freq for this CPU's core Type.
M-Claim | int Hz | The max `cpuinfo_max_freq` value of this core subset.
     Id | int    | The core id that provided the Max-Claim value.
M-Spec  | int Hz | Intel SPEC'D MAX freq for this CPU's core Type.
M-Test  | int Hz | The max `scaling_cur_freq` value of this core subset.
        |        |   The entire core subset is sampled 200x.
     Id | int    | The core id that provided the Max-Test value.

## Clevo | X580WNT-G  | Ultra 9 275HX | 6.14.0-34-kfocus
The Intel specified values were copied from [this page][_0100].

### Scan Results
CPU: Intel Core Ultra 9 275HX
Type | Turbo | B-Claim . Id | B-Spec  | M-Claim . Id | M-Spec  | M-Test  . Id
-----| ----- | ------------ | ------- | ------------ |-------- | ------------
P    | off   | 2000000 . 07 | 2700000 | 2000000 . 07 | 2700000 | 2708723 . 00
P    | ON    | 2000000 . 07 | 2700000 | 3900000 . 07 | 5400000 | 5414342 . 03
E    | off   | 2100000 . 17 | 2100000 | 2100000 . 17 | 2100000 | 2175694 . 09
E    | ON    | 2100000 . 17 | 2100000 | 4600000 . 17 | 4600000 | 4723780 . 14

### Assessment
1. The E-cores correctly report `base_frequency` and `cpuinfo_max_freq`.
- pass: With Turbo ON or off, Claimed capabilities (B-Claim, M-Claim) match
  Intel specs (B-Spec, M-Spec).
- pass: With Turbo ON or off, the measured frequencies (M-Test) are in-line with
  Intel pecs (M-Spec), and match claimed capabilities.

2. The P-cores under report `base_frequency` and `cpuinfo_max_freq`.
- FAIL: With Turbo ON or off, the claimed `base_freqency` (B-Claim) of 2000000 does
  NOT match the Intel spec (B-Spec) of 2700000.
- FAIL: With Turbo off, the claimed `cpuinfo_max_freq` (M-Claim) of 2000000 does
  NOT match the Intel spec (M-Spec) of 2700000.
- FAIL: With Turbo ON, the claimed `cpuinfo_max_freq` (M-Claim) of 3900000 does
  NOT match the Intel spec (M-Spec) of 5400000.
- pass: With Turbo ON or off, the measured `scaling_cur_freq` (M-Test) values are
  in-line with Intel specs (M-Spec).

## Clevo | X580WNT-G  | Ultra 9 275HX | 6.18.0-061800rc7-generic (Mainline)
The Intel specified values were copied from [this page][_0100].

### Scan Results
CPU: Intel Core Ultra 9 275HX
Type | Turbo | B-Claim . Id | B-Spec  | M-Claim . Id | M-Spec  | M-Test  . Id
-----| ----- | ------------ | ------- | ------------ |-------- | ------------
P    | off   | 2000000 . 07 | 2700000 | 2000000 . 07 | 2700000 | 2700054 . 01
P    | ON    | 2000000 . 07 | 2700000 | 3900000 . 07 | 5400000 | 5400054 . 07
E    | off   | 2100000 . 17 | 2100000 | 2100000 . 17 | 2100000 | 2140243 . 17
E    | ON    | 2100000 . 17 | 2100000 | 4600000 . 17 | 4600000 | 4653899 . 16

### Assessment
The assessment is the same as found for section `Clevo | X580WNT-G  | Ultra 9
275HX | 6.14.0-34-kfocus`:

1. The E-cores pass all tests.
2. The P-cores under report `base_frequency` and `cpuinfo_max_freq` in the
   exact same way.

## Clevo | X580WNS-G  | Ultra 9 275HX | 6.14.0-34-kfocus
### Scan Results
CPU: Intel Core Ultra 9 275HX
Type | Turbo | B-Claim . Id | B-Spec  | M-Claim . Id | M-Spec  | M-Test  . Id
-----| ----- | ------------ | ------- | ------------ |-------- | ------------
P    | off   | 2700000 . 07 | 2700000 | 2700000 . 07 | 2700000 | 2700054 . 02
P    | ON    | 2700000 . 07 | 2700000 | 5400000 . 03 | 5400000 | 5400054 . 00
E    | off   | 3000000 . 17 | 2100000 | 3000000 . 17 | 2100000 | 2138214 . 22
E    | ON    | 3000000 . 17 | 2100000 | 6500000 . 17 | 4600000 | 4765000 . 21

### Assessment
In contrast to the X580WNT-G, the P-Cores here report correctly, whereas the
E-cores are incorrect.

## Clevo | X560WNR-G  | Ultra 9 275HX | 6.14.0-34-kfocus
The Intel specified values were copied from [this page][_0100].

### Scan Results
CPU: Intel Core Ultra 9 275HX
Type | Turbo | B-Claim . Id | B-Spec  | M-Claim . Id | M-Spec  | M-Test  . Id
-----| ----- | ------------ | ------- | ------------ |-------- | ------------
P    | off   | 2000000 . 07 | 2700000 | 2000000 . 07 | 2700000 | 2703982 . 00
P    | ON    | 2000000 . 07 | 2700000 | 3900000 . 03 | 5400000 | 5400000 . 03
E    | off   | 2100000 . 17 | 2100000 | 2100000 . 17 | 2100000 | 2132738 . 18
E    | ON    | 2100000 . 17 | 2100000 | 4600000 . 17 | 4600000 | 4710638 . 15

### Assessment
The assessment is the same as found for section `Clevo | X580WNT-G  | Ultra 9
275HX | 6.14.0-34-kfocus`:

1. The E-cores pass all tests.
2. The P-cores pass all tests.

## Clevo | X560WNR-G  | Ultra 9 275HX | 6.18.0-061800rc7-generic (Mainline)
The Intel specified values were copied from [this page][_0100].

### Scan Results
CPU: Intel Core Ultra 9 275HX
Type | Turbo | B-Claim . Id | B-Spec  | M-Claim . Id | M-Spec  | M-Test  . Id
-----| ----- | ------------ | ------- | ------------ |-------- | ------------
P    | off   | 2000000 . 07 | 2700000 | 2000000 . 07 | 2700000 | 2700027 . 03
P    | ON    | 2000000 . 07 | 2700000 | 3900000 . 03 | 5400000 | 5400000 . 03
E    | off   | 2100000 . 17 | 2100000 | 2100000 . 17 | 2100000 | 2134000 . 08
E    | ON    | 2100000 . 17 | 2100000 | 4600000 . 17 | 4600000 | 4711250 . 14

### Assessment
The assessment is the same as found for section `Clevo | X580WNT-G  | Ultra 9
275HX | 6.14.0-34-kfocus`:

1. The E-cores pass all tests.
2. The P-cores under report `base_frequency` and `cpuinfo_max_freq` in the
   exact same way.

## Asus  | NUC15CRKU5 | Ultra 5 225H  | 6.14.0-34-kfocus
"     | "          | "             | 6.18.0-061800rc7-generic (Mainline)
The Intel specified values were copied from [this page][_0100].

### Scan Results
CPU: Intel Core Ultra 5 225H
Type | Turbo | B-Claim . Id | B-Spec  | M-Claim . Id | M-Spec  | M-Test  . Id
-----| ----- | ------------ | ------- | ------------ |-------- | ------------
P    | off   | 1700000 . 03 | 1700000 | 1700000 . 03 | 1700000 | 1805625 . 00
P    | ON    | 1700000 . 03 | 1700000 | 4900000 . 03 | 4900000 | 4900049 . 03
E    | off   | 1300000 . 11 | 1300000 | 1300000 . 11 | 1300000 | 1502459 . 09
E    | ON    | 1300000 . 11 | 1300000 | 4400000 . 11 | 4300000 | 4320736 . 10

### Assessment
1. The P-cores look mostly correct.
  1.a. Minor issue: with Turbo off, the claimed and spec freq match, but the
    tested max freq is around 6% greater (1700000 = 1700000 < 1805625).
2. The E-cores look mostly correct.
  1.a. Minor issue: with Turbo off, the spec and claimed max freq match, but
    the max freq is around 16% greater (1300000 = 1300000 < 1502459).
  2.a Minor issue: with Turbo ON, the claimed max freq is greater than the
    spec, but measured freq is closer to spec (4400000 > 4300000 < 4320736).

## Asus  | NUC15CRKU5 | Ultra 5 225H  | 6.18.0-061800rc7-generic (Mainline)
TODO

## Asus  | NUC15CRKU7 | Ultra 7 255H  | 6.14.0-34-kfocus
TODO
## Asus  | NUC15CRKU7 | Ultra 7 255H  | 6.18.0-061800rc7-generic (Mainline)
TODO

[_0090]:https://kernel.ubuntu.com/mainline/v6.18-rc7
[_0100]:https://www.intel.com/content/www/us/en/products/sku/242293/intel-core-ultra-9-processor-275hx-36m-cache-up-to-5-40-ghz/specifications.html

--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2025-11-28_6.14.0-34-X580WNS-G-acpi_cppc.dump.txt

/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:222947587336 del:265250152806
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:87
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:104962667500 del:107644788904
/sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:141643551420 del:158019120345
/sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:131172829600 del:144873032373
/sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:118134829636 del:123696118604
/sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu14/acpi_cppc/feedback_ctrs:ref:108324957012 del:112096131391
/sys/devices/system/cpu/cpu14/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu14/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu14/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu14/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu14/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu14/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu15/acpi_cppc/feedback_ctrs:ref:107683535392 del:109947519143
/sys/devices/system/cpu/cpu15/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu15/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu15/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu15/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu15/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu15/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu16/acpi_cppc/feedback_ctrs:ref:113895174652 del:120992585122
/sys/devices/system/cpu/cpu16/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu16/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu16/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu16/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu16/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu17/acpi_cppc/feedback_ctrs:ref:131296978896 del:145875295539
/sys/devices/system/cpu/cpu17/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu17/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu17/acpi_cppc/nominal_perf:21
/sys/devices/system/cpu/cpu17/acpi_cppc/reference_perf:31
/sys/devices/system/cpu/cpu17/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu18/acpi_cppc/feedback_ctrs:ref:113960474168 del:115437841597
/sys/devices/system/cpu/cpu18/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu18/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu18/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu18/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu18/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu18/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu19/acpi_cppc/feedback_ctrs:ref:147915637084 del:157709569881
/sys/devices/system/cpu/cpu19/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu19/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu19/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu19/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu19/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu19/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:206604282618 del:232997420518
/sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:85
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu20/acpi_cppc/feedback_ctrs:ref:124808200628 del:128042012373
/sys/devices/system/cpu/cpu20/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu20/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu20/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu20/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu20/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu20/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu21/acpi_cppc/feedback_ctrs:ref:123412285880 del:125394922582
/sys/devices/system/cpu/cpu21/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu21/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu21/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu21/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu21/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu21/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu22/acpi_cppc/feedback_ctrs:ref:112905323572 del:112169094451
/sys/devices/system/cpu/cpu22/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu22/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu22/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu22/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu22/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu22/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu23/acpi_cppc/feedback_ctrs:ref:116724560648 del:118456830846
/sys/devices/system/cpu/cpu23/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu23/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu23/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu23/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu23/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu23/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:143283901726 del:159326350243
/sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:85
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:141528700853 del:167670592115
/sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:87
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:126676438413 del:143961097482
/sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:85
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:110235347450 del:123186510315
/sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:85
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:108592201564 del:124204354188
/sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:85
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:103287535070 del:114820052579
/sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:44
/sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:85
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:2700
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:43
/sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:49
/sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:107162778792 del:109392728704
/sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:105909941816 del:108195936064
/sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:30
/sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:65
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:21
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:2100
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:29
/sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:43
/sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615

--MP_/gSFvir+VM81sdu0qQQTVXTb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=2025-11-29_6.14.0-34-NUC15CRKU5-acpi_cppc.dump.txt

/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:424447862820 del:258167215786
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:28
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:79
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:28
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:1700
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:27
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:59
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu10/acpi_cppc/feedback_ctrs:ref:312044313108 del:171000014067
/sys/devices/system/cpu/cpu10/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu10/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_nonlinear_perf:16
/sys/devices/system/cpu/cpu10/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu10/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu10/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu10/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu11/acpi_cppc/feedback_ctrs:ref:309517511032 del:166250307340
/sys/devices/system/cpu/cpu11/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu11/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_nonlinear_perf:19
/sys/devices/system/cpu/cpu11/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu11/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu11/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu11/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu12/acpi_cppc/feedback_ctrs:ref:263086731844 del:101193644381
/sys/devices/system/cpu/cpu12/acpi_cppc/guaranteed_perf:7
/sys/devices/system/cpu/cpu12/acpi_cppc/highest_perf:25
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_nonlinear_perf:11
/sys/devices/system/cpu/cpu12/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_freq:700
/sys/devices/system/cpu/cpu12/acpi_cppc/nominal_perf:7
/sys/devices/system/cpu/cpu12/acpi_cppc/reference_perf:37
/sys/devices/system/cpu/cpu12/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu13/acpi_cppc/feedback_ctrs:ref:246098759488 del:93604084753
/sys/devices/system/cpu/cpu13/acpi_cppc/guaranteed_perf:7
/sys/devices/system/cpu/cpu13/acpi_cppc/highest_perf:25
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_nonlinear_perf:11
/sys/devices/system/cpu/cpu13/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_freq:700
/sys/devices/system/cpu/cpu13/acpi_cppc/nominal_perf:7
/sys/devices/system/cpu/cpu13/acpi_cppc/reference_perf:37
/sys/devices/system/cpu/cpu13/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu1/acpi_cppc/feedback_ctrs:ref:617719533980 del:353005123281
/sys/devices/system/cpu/cpu1/acpi_cppc/guaranteed_perf:28
/sys/devices/system/cpu/cpu1/acpi_cppc/highest_perf:79
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_nonlinear_perf:29
/sys/devices/system/cpu/cpu1/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_freq:1700
/sys/devices/system/cpu/cpu1/acpi_cppc/nominal_perf:27
/sys/devices/system/cpu/cpu1/acpi_cppc/reference_perf:59
/sys/devices/system/cpu/cpu1/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu2/acpi_cppc/feedback_ctrs:ref:372139536100 del:214723142940
/sys/devices/system/cpu/cpu2/acpi_cppc/guaranteed_perf:28
/sys/devices/system/cpu/cpu2/acpi_cppc/highest_perf:79
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_nonlinear_perf:26
/sys/devices/system/cpu/cpu2/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_freq:1700
/sys/devices/system/cpu/cpu2/acpi_cppc/nominal_perf:27
/sys/devices/system/cpu/cpu2/acpi_cppc/reference_perf:59
/sys/devices/system/cpu/cpu2/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu3/acpi_cppc/feedback_ctrs:ref:362744142010 del:218863510762
/sys/devices/system/cpu/cpu3/acpi_cppc/guaranteed_perf:28
/sys/devices/system/cpu/cpu3/acpi_cppc/highest_perf:79
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_nonlinear_perf:24
/sys/devices/system/cpu/cpu3/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_freq:1700
/sys/devices/system/cpu/cpu3/acpi_cppc/nominal_perf:27
/sys/devices/system/cpu/cpu3/acpi_cppc/reference_perf:59
/sys/devices/system/cpu/cpu3/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu4/acpi_cppc/feedback_ctrs:ref:295694693020 del:160190872521
/sys/devices/system/cpu/cpu4/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu4/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_nonlinear_perf:17
/sys/devices/system/cpu/cpu4/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu4/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu4/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu4/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu5/acpi_cppc/feedback_ctrs:ref:292433149088 del:157272489864
/sys/devices/system/cpu/cpu5/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu5/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_nonlinear_perf:17
/sys/devices/system/cpu/cpu5/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu5/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu5/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu5/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu6/acpi_cppc/feedback_ctrs:ref:325717497052 del:177550079935
/sys/devices/system/cpu/cpu6/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu6/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_nonlinear_perf:17
/sys/devices/system/cpu/cpu6/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu6/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu6/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu6/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu7/acpi_cppc/feedback_ctrs:ref:402080679356 del:204300141100
/sys/devices/system/cpu/cpu7/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu7/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_nonlinear_perf:17
/sys/devices/system/cpu/cpu7/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu7/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu7/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu7/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu8/acpi_cppc/feedback_ctrs:ref:367742812040 del:186031914500
/sys/devices/system/cpu/cpu8/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu8/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_nonlinear_perf:17
/sys/devices/system/cpu/cpu8/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu8/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu8/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu8/acpi_cppc/wraparound_time:18446744073709551615
/sys/devices/system/cpu/cpu9/acpi_cppc/feedback_ctrs:ref:318192500840 del:169490000896
/sys/devices/system/cpu/cpu9/acpi_cppc/guaranteed_perf:19
/sys/devices/system/cpu/cpu9/acpi_cppc/highest_perf:61
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_nonlinear_perf:17
/sys/devices/system/cpu/cpu9/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_freq:1300
/sys/devices/system/cpu/cpu9/acpi_cppc/nominal_perf:18
/sys/devices/system/cpu/cpu9/acpi_cppc/reference_perf:51
/sys/devices/system/cpu/cpu9/acpi_cppc/wraparound_time:18446744073709551615

--MP_/gSFvir+VM81sdu0qQQTVXTb--

