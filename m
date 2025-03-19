Return-Path: <linux-acpi+bounces-12348-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A96A68BCA
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 12:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3505462D9E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Mar 2025 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15E2561B0;
	Wed, 19 Mar 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMRxkk5G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EF1C9B97;
	Wed, 19 Mar 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383809; cv=none; b=mgN9LVAVY7oifJf0rkTM/0NoN/Sbx+aaGusyYK5JLnJujtim73cXyz0AZ4RjpbWI1inFFrnq0LQmALkMl5IknyGw2z1bA6N39TTPF3boQaeDxfVSPAReKRB0LWS6eAhrz0iiQCBzLD4ly6JLGl3cWZTTBKkJ401kN/wv8dC02Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383809; c=relaxed/simple;
	bh=lAIDwwvMqBHf5q3jJeNvQGXqxBKzYrlvwuNryM8NoPI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SpLdy6SaqABT59jX8lWmtpqyeOXPGwYNm+lLj+XLA5yFLqzEAfppFKkFSAFfuQ6zpl5LY7+3Jva0vd/5bvFQkXHgurCrUVSvrQa2vw37HMh0zQzBOcPsg5KNCCk77EFwmNKlKHJ56SZKWfqfqrX6H6Q2gw4RyBf4k0k6CBs/MYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMRxkk5G; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-549967c72bcso7010125e87.3;
        Wed, 19 Mar 2025 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742383804; x=1742988604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gggRL9RGdCLCbmpGvdZDWu10hCZPvTtTQSbYZx10J2Y=;
        b=mMRxkk5GSsyfWZdopCaSvRgk/a9fz26jPfoxcCHdllWpFb1Uz/xm0COg5h6JeZjNwR
         PETVs5IjxBdP+8NwX6r3vJ4PjD1dA4R/8nGPlz1uSCvAsOMRpf+vS+eDyacLUPAW8hgX
         aSREh+1q5P0YYOiUhv5Ah1/UvRniadY0wNTQX8FYo8ayX2TfV0W/3IHlnmP+q5jfJkkd
         ICZNh9Jabr7U09NG/STfX+SWVsSszz15U8eTY7pYt0iYe/ZT7uHXWSlUg4ysuV8iiIEO
         ZQDnHkS2z1gpDnpPMkZMdvzXbBXOv+fWSRq9kSdjmFI3XhQfq07CJDXus85E9NXZT8pY
         WoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383804; x=1742988604;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gggRL9RGdCLCbmpGvdZDWu10hCZPvTtTQSbYZx10J2Y=;
        b=BdXGQj3xLFjzXfAs5Rtdq0FaXxNp/7wZN6JSovOWfz3CXT6xrgIP2cg+n3Ee3lpTh1
         NfpGX5H+q/QLS2hjHwtqrPTFlG8bZyURZjuRZovfdt+U38UhtsGmLLcNDTNLXuAcGWMv
         qpkaZnOEU27tPP21V2ArLFVb3sNRzFD1gsZ232mFcoY1D+4izJXAKDQHTshZUkdwN4/L
         X6SOA1R7bMN2uIShMXI5sGWXYmEWro+3cuOFxMcJQAtEFrpE7XhGItbbLtJkvQnq/RF8
         EiCWUXepworo1R4rk7RC3dTzTAqC13O3zrzOBdC0CU08EGQPFkxS3whf5/3kr89hJtdB
         LhAQ==
X-Gm-Message-State: AOJu0YxMV+aGoKeGR4ff6u5M79IPS5/lVWnkFDo6XNwrRXyZOjleflmP
	TAbfsnzMgIDttt4quf37v5v5Z+g7zWSKOyjkhG8HBu5pOBp72SdydeMCTXzywJF+wHWmg8k2VpR
	hFn0jolkcmw5h8X9fRAHPyOgicwPYnE3u4Q==
X-Gm-Gg: ASbGnctl8wgvIyLpCdHz97GXUXVydxja5dSUGao+4r5bqC5AyueGiZxT3fua2/FOSDQ
	1Hjbb4bnnUdlIsrVITMpOm/EH9H+GGR9kJZe1QeKdKGOPAlQbSvA05VGbir5uYDrOUSHCBKBjkx
	wG5FDZ0h0xwc81rNOVx0UYesdBwA==
X-Google-Smtp-Source: AGHT+IF2Ma3Ee3timoAC5xHNc/CDFWULERemDRPizTGVKJSYnHWBIEP9BZGDdk3Yf7qGlL5X16u+AgcoR3igGYx7vyA=
X-Received: by 2002:a05:6512:2315:b0:545:f69:1d10 with SMTP id
 2adb3069b0e04-54acb193205mr717541e87.8.1742383804197; Wed, 19 Mar 2025
 04:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Wed, 19 Mar 2025 16:59:52 +0530
X-Gm-Features: AQ5f1JqtJI9Tm-8u3qufV3bCwZpdgyUr5MMd6Lflc7Xupq9AzDqspgD-br0xcKc
Message-ID: <CAMciSVUVjLj44LW+3ALB1fJQsUiw_2BQ5tLgpNJH08Xmj=Wr9w@mail.gmail.com>
Subject: ACPI Error: AE_AML_LOOP_TIMEOUT in \_SB.PCI0.SBUS.RDWD & \_SB.PCI0.SBRG.ADP1._PSR
To: linux-acpi@vger.kernel.org, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am encountering repeated AE_AML_LOOP_TIMEOUT errors in the ACPI RDWD
& \_SB.PCI0.SBRG.ADP1._PSR methods. Below are relevant log entries
from my system running Linux kernel 6.13.0+:

[77998.038653]
               Initialized Local Variables for Method [RDWD]:
[77998.038691]   Local1: 00000000d0fe9fee <Obj>           Integer
0000000000000015
[77998.038862]   Local6: 00000000f41c1645 <Obj>           Integer
0000000000000000
[77998.039031]   Local7: 0000000040665c5c <Obj>           Integer
000000000000AA55

[77998.039237] Initialized Arguments for Method [RDWD]:  (2 arguments
defined for method invocation)
[77998.039273]   Arg0:   00000000397dc53d <Obj>           Integer
0000000000000014
[77998.039442]   Arg1:   000000001099e334 <Obj>           Integer
0000000000000002

[77998.039673] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
[77998.040455] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
[77998.043659] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
state: AE_AML_LOOP_TIMEOUT

[78028.442980]
               Initialized Local Variables for Method [RDWD]:
[78028.443019]   Local1: 00000000898a9a7e <Obj>           Integer
0000000000000017
[78028.443192]   Local6: 000000000cf0c853 <Obj>           Integer
0000000000000000
[78028.443362]   Local7: 00000000bb4aa65f <Obj>           Integer
000000000000AA55

[78028.443569] Initialized Arguments for Method [RDWD]:  (2 arguments
defined for method invocation)
[78028.443606]   Arg0:   00000000ef8d445b <Obj>           Integer
0000000000000016
[78028.443775]   Arg1:   000000006cacc887 <Obj>           Integer
0000000000000003

[78028.444006] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
[78028.446366] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
[78028.451179] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
state: AE_AML_LOOP_TIMEOUT

[78032.877472]
               Initialized Local Variables for Method [RDWD]:
[78032.877509]   Local1: 00000000cf6291ae <Obj>           Integer
0000000000000017
[78032.877682]   Local6: 0000000026aa8a7a <Obj>           Integer
0000000000000003
[78032.877851]   Local7: 00000000acfa20e0 <Obj>           Integer
000000000000AA55

[78032.878058] Initialized Arguments for Method [RDWD]:  (2 arguments
defined for method invocation)
[78032.878094]   Arg0:   00000000a186096f <Obj>           Integer
0000000000000016
[78032.878262]   Arg1:   00000000d0e1eefe <Obj>           Integer
0000000000000003

[78032.878492] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
[78032.881011] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
[78032.883061] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
state: AE_AML_LOOP_TIMEOUT


This issue appears randomly, affecting the RDWD method, which is
likely responsible for reading data from a bus, and consequently
causing the _PSR method (power state read) to fail.


Questions:
1. What typically causes AE_AML_LOOP_TIMEOUT errors?

2. Could these ACPI errors impact PCI device access?
Since the error originates from _SB.PCI0.SBUS.RDWD, could this failure
affect PCI device communication or cause failures when accessing PCI
devices?

3. Could this be a firmware/BIOS issue?If so, what tools or steps
should I use to verify and debug the ACPI tables?

4. Is there a recommended workaround to mitigate this issue?

4. How can I debug this further?I can enable additional ACPI debugging
logs or provide dumps of ACPI tables if necessary.

Any guidance on resolving or further diagnosing this issue would be
highly appreciated.

Best regards,
Naveen

