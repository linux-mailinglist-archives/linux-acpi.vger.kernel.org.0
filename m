Return-Path: <linux-acpi+bounces-6545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC6910582
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1293C1C21C1E
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEF8175E;
	Thu, 20 Jun 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km/3CQ5N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1615B107
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889067; cv=none; b=kJ/oHlhT1yDR5m9saGHoPGMrCYHJfWHdeTzxeYpwusVTK//oQT91x/UA3Oj+ohKWMB+yS6jmLr6OjvOMGx8T4QthU8BFfRj8ArXJXi+IO7LW7mCpyDj/xS6/pZfNmwP9ezrVE3kxCq1UoZr3sn4vG5GYyDbjl1jxkFrSwQPL0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889067; c=relaxed/simple;
	bh=v2YumtMuddti/f2PBWk5ybowX4Anda14MOI5rqyGFsw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ap6h7ZcZv6j4WVK5FXpTyHB6XzgqrOY5aPl87MHCTTDTU8Z/WjkG6xrAbvMGFwyV7Ihwl6eZ3h3mgYLuGFONwXSfposhQ9sLYdK9mwqV/lJL/Sft2oRtWxJERR0xDS/xKQnRPjf3an+RnzfhHcKa/SmC5Qm4AFRmIYgTqs56BNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km/3CQ5N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9c2847618so7299445ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718889065; x=1719493865; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgQ8qlIj45bCdzvAvD45aa0/LLr3r+CWnkJc0JZAefQ=;
        b=Km/3CQ5NZlh0BVpq88nsPJr74SlMDNp/Kc/1vEAUAciOI4Hu+ojB55xEncf/2/NhHv
         zSZDk+S4URd/8YjFZuA/zK+NmIfAci38yrfeCU8Un5hF3qSoBiojIUk9UmgM5WS7GF/C
         h/JxDrQZswzpCUgZrFQXSse5okjY9bP10LXhSkgY1KXVNNJxe8dOh3yB6nz9fRtDJkzi
         HEnKrZ1MUGCVsWlu0FDGHLfmuKg0gdIIc0RBF+hDP7d+YkYPmLHXa5TJkWuTWvaAvEUk
         vC+3HsnSI3pjfyCcyL2qhYahYKEnh4gfSuwo9+GJh40j6Y1OybTMGc4pxMfjtC3xhL/s
         e64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718889065; x=1719493865;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgQ8qlIj45bCdzvAvD45aa0/LLr3r+CWnkJc0JZAefQ=;
        b=KzOe6ZedunesEF3EtDKxsP4ijRLYViFZeO/cxH5aj00lLnwo8iVLzsFfu35WlHLm6d
         qb91Hp+pufM771RQUZqUKZt00wA+tN3sdjPW3IK4GfN5hRgpqGwoO1KUCwPzWcdfh7l5
         rWt7mD46XBTk/DfaYND1qhz7zUDl+AjpPvTdb7tmj86P42Q190QbB97IPTNeIGBLDGOo
         TRDWLyHBocvfZDiCP3XgcaIMCXUuT9UN0a6BB4UhmGyJdgOUwGlYx29Z2gKiKpN/ychJ
         SUORVVNZMcDH/d56G/YbzpBpspvnoMYNuH18uOlG0R+CqWrWhpA2cc4ssxR1NmQcsjZq
         1RgA==
X-Gm-Message-State: AOJu0YyJ4HHBDr9qSbdMbxN8w7Os7H1KotLM5F4jRbWYoQ8GI6K3wmEn
	+RYINSBi9ZAknDSnezV97To3PBVCi9Gh1cxQyhRSr33jrQZLR/F4
X-Google-Smtp-Source: AGHT+IGdlpM+GbAU/aN73ta431s5wwA92kCQHDwSc/VcHj5NbtPEB2h0dN5qk7ZP0HhSQ5ZHvKz07A==
X-Received: by 2002:a17:902:e80b:b0:1f9:b518:a11 with SMTP id d9443c01a7336-1f9b5180e4amr48296705ad.53.1718889065291;
        Thu, 20 Jun 2024 06:11:05 -0700 (PDT)
Received: from localhost ([2001:f70:860:4100:e712:ac1a:da07:2e53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9d9308636sm7568485ad.102.2024.06.20.06.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 06:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Jun 2024 22:10:57 +0900
Message-Id: <D24VBFQ86ZIA.3KHVV0P1I3MNX@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: EC: Use ec_no_wakeup on ThinkPad T14 Gen 5
From: "Yutaro Ohno" <yutaro.ono.418@gmail.com>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
X-Mailer: aerc 0.17.0
References: <ZnFYpWHJ5Ml724Nv@ohnotp>
 <40ec6e11-c279-44ba-993f-2f2475c15073@app.fastmail.com>
In-Reply-To: <40ec6e11-c279-44ba-993f-2f2475c15073@app.fastmail.com>

Hi, Mark.

On Wed Jun 19, 2024 at 8:28 AM JST, Mark Pearson wrote:
> We're doing Linux enablement on the T14 G5 right now - and if this is an =
issue in the Lenovo FW I would rather fix it there instead of introducing a=
 quirk into the kernel that might later need to be removed. This platform i=
s getting full Linux support.

That sounds wonderful! I agree that my change is more of a workaround solut=
ion.

> I'd like to collect some debug details from you (if preferred you can pin=
g me off thread using this email address):

Sure. But first, please note that my machine is AMD, not Intel.

>  - Can I get your BIOS, EC and ME versions (easiest is to get these from =
the BIOS setup screen - F1 during early boot)

- BIOS: R2LET23W (1.04)
- EC:   R2LHT18W (1.01)
- ME:   Not applicable, as my machine is AMD, not Intel.

>  - Get a report from running the Intel S0ix test tool - https://github.co=
m/intel/S0ixSelftestTool. Run it with the -S option

It may not work as my machine is not Intel, but here's the output:

```
$ sudo ./s0ix-selftest-tool.sh -s

---Check S2idle path S0ix Residency---:

The system OS Kernel version is:
Linux ohnotp 6.9.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Sun, 16 Jun 2024 19:06:37=
 +0000 x86_64 GNU/Linux

---Check whether your system supports S0ix or not---:

Low Power S0 Idle is:1
Your system supports low power S0 idle capability.



---Check whether intel_pmc_core sysfs files exit---:
ls: cannot access '/sys/kernel/debug/pmc_core': No such file or directory

The pmc_core debug sysfs file is empty on your system.
Isolation suggestions:
Please check whether intel_pmc_core driver is loaded.


The intel_pmc_core sysfs missing will impact S0ix failure analyze.


---Judge PC10, S0ix residency available status---:
cat: /sys/kernel/debug/pmc_core/substate_residencies: No such file or direc=
tory
grep: /sys/kernel/debug/pmc_core/substate_residencies: No such file or dire=
ctory
Test system does not support S0ix.y substate

The system failed to place S2idle entry command by turbostat,
please check if the suspend is failed or turbostat tool version is old
e.g. did you make turbostat tool executable or separately run S2idle comman=
d:
rtcwake -m freeze -s 15
```

Note that `turbostat` command is available and its version is `2024.04.08`.

>  - There is a known issue if the ethernet is plugged in on this system th=
at Intel are working on - can you confirm if you're using wired networking =
please?

I haven't used the ethernet on my machine. It's not plugged in.

>  - Do you have WWAN enabled? If you have it can you try with WWAN disable=
d.

No, I don't. My machine doesn't have a WWAN module.

> I'll also highlight that Linux enablement is not complete on this platfor=
m yet, so some patience might be needed.

Sure!

Please let me know if there's anything else I can do.

Thanks,
Yutaro

