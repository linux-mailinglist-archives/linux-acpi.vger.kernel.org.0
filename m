Return-Path: <linux-acpi+bounces-15835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D609B2C5FF
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB2E7B8443
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C8340DB9;
	Tue, 19 Aug 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I16hEff+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DF340DAB;
	Tue, 19 Aug 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611126; cv=none; b=mC1ynUmwvalFdGE19nUdRLLWxnvHEFb8RcCKIWWOt46Z98AkV7rIXd6QrSjcx1DuT6WFcIiGDWSgblpiwLsve/fyr3SO/3wzvzZPV40Ey8DJjS/as0PqKaW4tFkGn947Db2uQhloRt7bFTeS1VskEdE4kMHbZJ7GZHSLZ2pzlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611126; c=relaxed/simple;
	bh=SarDp3gPgO/YdgGtf3xtssRMRvDNPW1kKle/w7h6F4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiwpX66vSFhg3kH2QZNzW6/oG8LDAlcJ1KQnB+WMrJ4QC2JvtJu80nmnNJVxIbpOewqc/+1psHEyhf/Mfgm/aLztpb/HzZyMDv/ppdwyTm23gLbiicAShUMHT2V8RHos6LXgw1t6U/x7+8E3x+jFhm2x8MCYHN1o98VfEvWhrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I16hEff+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso6525545a12.2;
        Tue, 19 Aug 2025 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755611123; x=1756215923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SarDp3gPgO/YdgGtf3xtssRMRvDNPW1kKle/w7h6F4U=;
        b=I16hEff+1pGk0v9ywuvnZOZ73ghWWE8VTs380Igyuvbx/ShJCMrQFFx6ipYN/huhx4
         bBbGx3xXV7AG9bXe4mXugbTN0k5rz1FHJbYpBoNNijmz9pAaXY3CBk1z8bziVAB5T/Fy
         NzZjgr9DjBemth2C6+/SqnrfQYA6WAmqnKHJfbq2mXa01j5/TZh+Fa1EC/FyuadafIpO
         /ltAaWshGR+re6ZTZc/zzozd5AwgUuhGFwJPW4dXvVBWKg4PNCq/JwNVmbV6jnAdULAv
         EOwLT+TAizwnTf1GZLsSpKDQamiP3SDoigYsv39jnS+3d++ZRXIRu1VmCeN66iOurymL
         pKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611123; x=1756215923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SarDp3gPgO/YdgGtf3xtssRMRvDNPW1kKle/w7h6F4U=;
        b=ttAt74vn+iA9KdsnIlrOSV7P5IZ0qStkasjv5gsQGZeNkslvqII1sDplSX+mzic3G6
         6NppCLs6A8hTMe51i45eoTNNImMNdFlblJ4UAZSR8pXzkpVV/QC78DCeoP0k0OuyABja
         lls6NwEU6+9aY4545Ko2tPYCYut4/n/C+DR81xy3mW7L0/PBI5fHlkmkIU9exCcA3rRP
         72LWl7xf7gFKEU9cjQSc9AY3ynEY2W9PP6/S+i3Txp901f7VzPmtn96DKRHFiRGjJMlR
         7mvQcS4kTWBKkodSSYqVxAJUsq+8m0FBn23SgFA1VcsfUZ6xnDTsfyTFhORyzUmdTZ5M
         dJAA==
X-Forwarded-Encrypted: i=1; AJvYcCWQasmHWqqdtlFMDYGuKP741LNyEvryp+9WAAYTLst5T8ABXoOrO8mUPs1uAudQfYwRKiaGnqT6PrM=@vger.kernel.org, AJvYcCXyeKYAc2Zvew4pkb/OYkg5tXG9pWW0fGKm61H9XztcVijj1AHG3K3uLKTbezVgij9kVhT3PbKhz0tt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7O0msk61w+xhj6bpYFtjfTf07tbVbAONONwrRWDghDGBuVUOe
	yfnE0DV9Wh3saSDKMBMgxW7qh9rylHaThktZWWqeJ5B5nRhyoNz4j+9btrZq7zvXyQ0h3Pdv+I+
	9wFSbZ73k6BygANCTJV8Rea2JRCS2f9w=
X-Gm-Gg: ASbGncupoyb0bGLHaawXDlZLUwU6CeBQShdBOk06NqGrdhAGRPSjXYok8aBe+XfhGeK
	Telai2NyI4Bzu1MCRRwsULnPhG81XEv+xXDZP7sI5AwUrVHk/rvA94kmOFBzV0YEY4X4E++qviQ
	y5bkJ13SsTreQ9gYnomIOyo0yQW3WgFmx3fUJZNMrDvZd3VkBp8J3Kv5+5NRHAZt2bSk0+JuhhY
	V3+yhA=
X-Google-Smtp-Source: AGHT+IGuEnssLntoKTg06N8UVz0+UwKwOhj3+VWR97223SWuRF4IgMIPW9I5hYz5V+54tTv67rXumI/lXzSaP19IpJs=
X-Received: by 2002:a17:906:dc8b:b0:af9:1d21:65a1 with SMTP id
 a640c23a62f3a-afddc95a1dbmr279438766b.11.1755611122852; Tue, 19 Aug 2025
 06:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com> <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
 <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
 <CACTEcX7oa+Shj=uYiRMoWpng+RZXDeQrOa-VTRmzVVtXJMCgLQ@mail.gmail.com> <CACTEcX7hsRkzYEBg4pQd5s36p_ZXJM=dtxSGmBjfkt5sWrXP8g@mail.gmail.com>
In-Reply-To: <CACTEcX7hsRkzYEBg4pQd5s36p_ZXJM=dtxSGmBjfkt5sWrXP8g@mail.gmail.com>
From: Andy Mindful <andy.mindful@gmail.com>
Date: Tue, 19 Aug 2025 16:45:11 +0300
X-Gm-Features: Ac12FXzUXiaf2APgZGDQHtK929W1yQQZJ8xoGGhTI90NnJ6i0iL0VZZKQ0T6JiQ
Message-ID: <CACTEcX4CBv9BTgvSrhJsFvPYLm_e5ms1PWzxsjv-hnudxiRTTw@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, rafael@kernel.org, ville.syrjala@linux.intel.com, 
	tglx@linutronix.de, Christian Brauner <brauner@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

Hello,

I've tried to bisect this again on a branch 'linux-6.8.y' @ linux-stable.

I made a commit log via: git log --oneline > commits-linux-6.8.y.txt
And started manually searching bad and good commits, this is the log:
3a2bd2b150f4 - bad
35a4474b5c3d - bad
dc97f6344f20 - bad
b85ea95d0864 - bad
ffc253263a13 - good

Once I have good, I switched back to: git checkout linux-6.8.y and
started bisecting,
which lead to below log:

git bisect start
# status: waiting for both good and bad commits
# bad: [3a2bd2b150f45844d99267696256716e4f23bf53] printk: Use
prb_first_seq() as base for 32bit seq macros
git bisect bad 3a2bd2b150f45844d99267696256716e4f23bf53
# status: waiting for good commit(s), bad commit known
# bad: [35a4474b5c3dd4315f72bd53e87b97f128d9bb3d] Merge tag
'bcachefs-2024-01-21' of https://evilpiepirate.org/git/bcachefs
git bisect bad 35a4474b5c3dd4315f72bd53e87b97f128d9bb3d
# status: waiting for good commit(s), bad commit known
# bad: [dc97f6344f205b0dfa144e1b3e16d6dc05383d57] cxl/pci: Register
for and process CPER events
git bisect bad dc97f6344f205b0dfa144e1b3e16d6dc05383d57
# status: waiting for good commit(s), bad commit known
# bad: [b85ea95d086471afb4ad062012a4d73cd328fa86] Linux 6.7-rc1
git bisect bad b85ea95d086471afb4ad062012a4d73cd328fa86
# status: waiting for good commit(s), bad commit known
# good: [ffc253263a1375a65fa6c9f62a893e9767fbebfa] Linux 6.6
git bisect good ffc253263a1375a65fa6c9f62a893e9767fbebfa
# good: [7d461b291e65938f15f56fe58da2303b07578a76] Merge tag
'drm-next-2023-10-31-1' of git://anongit.freedesktop.org/drm/drm
git bisect good 7d461b291e65938f15f56fe58da2303b07578a76
# good: [2a80532c0745e140852e6b579bbe8371332bb45d] Merge tag
'printk-for-6.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
git bisect good 2a80532c0745e140852e6b579bbe8371332bb45d
# good: [2a80532c0745e140852e6b579bbe8371332bb45d] Merge tag
'printk-for-6.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
git bisect good 2a80532c0745e140852e6b579bbe8371332bb45d
# bad: [e70703890b2586bc3567365d391c260d23fb7a94] Merge tag
'topic/nvidia-gsp-2023-11-03' of git://anongit.freedesktop.org/drm/drm
git bisect bad e70703890b2586bc3567365d391c260d23fb7a94
# good: [b06f58ad8e8c4154bc88d83b4fd70f74ede50193] Merge tag
'driver-core-6.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect good b06f58ad8e8c4154bc88d83b4fd70f74ede50193
# good: [1f24458a1071f006e3f7449c08ae0f12af493923] Merge tag
'tty-6.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good 1f24458a1071f006e3f7449c08ae0f12af493923
# bad: [bfafa2c19d706ab1db0b581f9d3886469fab8627] Merge tag
'phy-for-6.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
git bisect bad bfafa2c19d706ab1db0b581f9d3886469fab8627
# bad: [9b6db9a3a675fc2f33b587a9909dcef20c4b3794] Merge tag
'thunderbolt-for-v6.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into
usb-next
git bisect bad 9b6db9a3a675fc2f33b587a9909dcef20c4b3794
# good: [efa33cd89c8acc510ed0e4dbf98fc1cf3220b9dc] USB: typec:
tps6598x: Add status trace for tps25750
git bisect good efa33cd89c8acc510ed0e4dbf98fc1cf3220b9dc
# bad: [ff8e4630fa3c1f8775f162ceaf52ba8b656927de] usb: gadget:
lpc32xx-udc: Convert to use module_platform_driver()
git bisect bad ff8e4630fa3c1f8775f162ceaf52ba8b656927de
# bad: [c087fada0a6180ab5b88b11c1776eef02f8d556f] xhci: Clean up stale
comment on ERST_SIZE macro
git bisect bad c087fada0a6180ab5b88b11c1776eef02f8d556f
# bad: [5220d8b04a840fa09434072c866d032b163419e3] dt-bindings: usb:
gpio-sbu-mux: Make 'mode-switch' not required
git bisect bad 5220d8b04a840fa09434072c866d032b163419e3
# bad: [1034cc423f1b4a7a9a56d310ca980fcd2753e11d] gpio: update Intel
LJCA USB GPIO driver
git bisect bad 1034cc423f1b4a7a9a56d310ca980fcd2753e11d
# bad: [bfd3824c88081f9b2101d68376f14779ce26691f] i2c: Add support for
Intel LJCA USB I2C driver
git bisect bad bfd3824c88081f9b2101d68376f14779ce26691f
# good: [acd6199f195d6de814ac4090ce0864a613b1580e] usb: Add support
for Intel LJCA device
git bisect good acd6199f195d6de814ac4090ce0864a613b1580e
# first bad commit: [bfd3824c88081f9b2101d68376f14779ce26691f] i2c:
Add support for Intel LJCA USB I2C driver

Can you please advise, if it makes sense and results are accurate?

Best regards!
Andriy

