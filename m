Return-Path: <linux-acpi+bounces-8826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A09A1587
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F69285208
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 22:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005BD1D278B;
	Wed, 16 Oct 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="Qka3ZapU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3711D1F63
	for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116240; cv=none; b=sKv6BujthWEHfX+bGuDoZp69ESB2D+iWMGgIvDN6e6is/L+64OQiNSblVJ+jyZHAdBEBf3Ip9/YL7aFFPPt1M6mnusoCtNhVS1VszpAmREL1V6gTkpZdPCzLKRwBqndQhTGeSZjDCHLyU6PrMzeTmJWeabHkAgOw50YdX6KfBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116240; c=relaxed/simple;
	bh=pKk/6zrwsgyQPs6L8uSnW+XK2yvBcVM4b1sd3gOK/+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=C/D3r8KXX6LOSu0XiH4ka+WcXYP+KgPRjurAPU4KajH2aPFdmTcg733eYz8CNdZGAssFG0smus+nIw/WpMeUQzO1gLAyUSSCgL5LmJ4Egrurr2Z9cLId9RjlC5SBai0svBVUhflXoPoToskUEZn1yQA0ksNY/2QWZ0mXDkCTP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=Qka3ZapU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so2748445e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2024 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1729116237; x=1729721037; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAy+YI8aJBgzKDlu+bhq0/HfkrFTLmcq01oXRQXTyec=;
        b=Qka3ZapUP6QP4k6h3rcegoIrOL/bawoS9j35GuDFtdQ7QCXFQr45/17yBxz3xnAoYu
         mkkFtPBjZUsMgyozF2gPiP1YRH2cIgh1bhonRujGYpAaQZNDp+mLgfFiPZrPWd56T2EP
         EnGYWL8CcUlqf8+SZsairTJCjE5phaFXMQDwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116237; x=1729721037;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zAy+YI8aJBgzKDlu+bhq0/HfkrFTLmcq01oXRQXTyec=;
        b=BsEnYf+DZWft0DJNKsMlQyPYVPO9C3HdcJT2BuuViiSjgcJ6xt3pHCTwDNqm2Xgjqz
         PWSwXBC3ckJEIaCTJ0Q/NKiRUslrjMZJBJK43sUuVEemGlFClxL8AVIi0TWuvjjKCDq0
         5KOc+Wva6wcP9eGguwLvsIcwupvpL5FZ93y6WXo6cx3OUl2wU0X9N008EeY9xYJ8CIWJ
         /K55gNAjSrnKPCw0K0Q+KhoUr7Utvb38H6kqZ4hNxy2yTXuuZQLHw0YauqdIYyRuw9z4
         YTW/QlJmNi65Gu4wkUhJ1Oo5gPWVPPjZ6HxKANfsRbd7rjBjG7d4T5D7RYADlGnCjMn4
         Zmsg==
X-Forwarded-Encrypted: i=1; AJvYcCVK34oCDWNyg5MoSN4pI63eM+w4ftfwLl0jvchnUEDkNWHN4jWPiqdnx1AAkzvAe6urDiy8iK+loN/i@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeIq2eIYrIJv+1IYU8XjdX9xUI7ZAeE9EP9BpiLx99kSMjIj0
	KpvqW78hrDEjZbhZwXFLYuJ8+Qg+HaBPnY9dZ3aICYJdc5PVRy0uxnEk7Uyj82A=
X-Google-Smtp-Source: AGHT+IGFt/uf+S0HV+Ry8LS1AtX6ZH7OZiyFlbevTM8J88NluXe8RmwYFQhQPmKCyxw6eLPaERmVsQ==
X-Received: by 2002:a05:600c:1f12:b0:431:5871:6c5d with SMTP id 5b1f17b1804b1-43158716f6bmr7664875e9.3.1729116237192;
        Wed, 16 Oct 2024 15:03:57 -0700 (PDT)
Received: from [172.20.10.2] ([91.151.136.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a13bsm5370910f8f.13.2024.10.16.15.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:03:56 -0700 (PDT)
Message-ID: <3b2195074d7c8fa20f93f1dc6fc25afe5dbb2909.camel@intelfx.name>
Subject: Re: [PATCH v3 00/11] Adjustments for preferred core detection
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Mario Limonciello <superm1@kernel.org>
Cc: bp@alien8.de, gautham.shenoy@amd.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 x86@kernel.org
Date: Thu, 17 Oct 2024 02:03:52 +0400
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On my desktop Zen 3 (Vermeer) system applying this series yields a new
warning message on each boot:

> Oct 16 06:20:41 kernel: Could not retrieve highest performance (-19)

As I see it, this is one of the pr_debug()s newly promoted to warnings.
Is there anything I can provide to help fix this?

Just for completeness:

```
$ cat-files /sys/devices/system/cpu/cpufreq/policy0/*
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus                      =
       0
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf            =
       231
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore             =
       enabled
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq                =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking        =
       231
/sys/devices/system/cpu/cpufreq/policy0/boost                              =
       1
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq                   =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq                   =
       550000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency         =
       0
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_prefer=
ences  default performance balance_performance balance_power power
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference      =
       balance_performance
/sys/devices/system/cpu/cpufreq/policy0/related_cpus                       =
       0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors        =
       performance powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq                   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver                     =
       amd-pstate-epp
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor                   =
       powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq                   =
       5274000
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq                   =
       1746000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed                   =
       <unsupported>

$ grep -w cppc /proc/cpuinfo
<empty>
```

Thanks,
--=20
Ivan Shapovalov / intelfx /

